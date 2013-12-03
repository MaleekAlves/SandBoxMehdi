/*------------------------------------------------------------
Author:        Matt Urbanowski
Company:       Arcus Global Ltd
Date:          21/07/2013
Description:   Extension class for Create Ticket VF Page. Creates a new ticket with 
               record type based on selected service group / service
               Also does a smart search on match for the closest service type.
Test Class:    TestClass
------------------------------------------------------------*/

public with sharing class ExtCreateTicket {

    public Id selRTItem {get; set;}
    public Id selDeptItem {get; set;}
    public Ticket__c TicketPlaceholder {get; set;}
    public String txtError {get; set;}
    public Case myCase {get; set;} 
    public Id PaymentRTId {get; set;}
    public PageReference ReturnToGoalPR {get; set;}
    public Boolean showTicketType {get; set;}
    public Boolean showPayment {get; set;}
    public Boolean ticketsInheritGoalSLA  {get; set;}
    //public Flow.Interview.PAY_Payment_Ticket myInterview {get; set;}

    private String txtInstance;
    private String TicketObjId = 'a06';
    
    // Field ID Values
    private String Param1Id = '00Nb0000002zVyf'; // Status
    private String Param2Id = '00Nb0000003dfYj'; // Service Group
    private String Param3Id = '00Nb0000003dfYk'; // Service
    private String Param4Id = 'CF00Nb0000002zMJP'; // Parent Goal
    private String Param5Id = 'CF00Nb0000003ejYf'; // SLA
    private String Param6Id = '00Nb0000003f9VO'; // SLA picklist
    
    private String DefaultStatusValue = 'Draft';
      
    public ExtCreateTicket(ApexPages.StandardController controller) {
        // Startup function. Defaults
        this.myCase = (Case)Controller.getRecord();
        myCase = [Select CaseNumber, SLA__r.Name, Subject, Active_SLA__c from Case Where Id=:ApexPages.currentPage().getParameters().get('id')][0];
        TicketPlaceholder = New Ticket__c(GLOBAL_Goal__c = ApexPages.currentPage().getParameters().get('id'));
        ReturnToGoalPR = New ApexPages.StandardController(myCase).view();
        showTicketType = true;
        // DG - disabled tickets inheriting golas SLA as per customer request
        ticketsInheritGoalSLA = false;
        txtInstance = URL.getSalesforceBaseUrl().toExternalForm();
        
        // Default Service 
        String DefaultService = findDefaultService(myCase.Subject);
        if (DefaultService != null)
            TicketPlaceholder.GLOBAL_Service__c = DefaultService;
        
        // Default Service Group
        String DefaultServiceGroup = findDefaultServiceGroup(myCase.Subject);
        if (DefaultServiceGroup != null)
            TicketPlaceholder.GLOBAL_Service_Group__c = DefaultServiceGroup;
        
        
        
    }  
      
    private List<selectOption> getListTicketRecordTypes() {
        // Get list of all record type options
        List<selectOption> options = new List<selectOption>();
        List<RecordType> RecordTypes = [select Id, Name from RecordType where SobjectType = 'Ticket__c' Order By Name];
        for (RecordType rt : RecordTypes) {
            options.add(new selectOption(rt.Id, rt.Name));
            if (rt.Name.contains('Payment')) // Store record type Id of payment RT for later use
                PaymentRTId = rt.Id;
        }
        return options ;
    }
    
    public void CreatePayment() {
        // Show the correct panels
        showPayment = true;
        showTicketType = false;
    }
    
    public PageReference CreateTicket() {
        // Create a new ticket, then open it for editing
        String ParamRT = '';
        PageReference myPage;
        List<selectOption> TicketRecordTypes = getListTicketRecordTypes();
        
        if (TicketPlaceholder.GLOBAL_Service__c==null) { // Must specify a service
            txtError = 'You must select a service in order to create a ticket.';
            Return null;
        }
        else if (TicketPlaceholder.GLOBAL_Service__c.contains('Payment')) // If service selected has the word payment in it, load visual workflow
        {
            txtError = '';
            CreatePayment();
            Return null;
        } else {
            txtError = '';
            // Get the record type - based on service label
            for (selectOption eachOption : TicketRecordTypes)
                if (eachOption.getLabel() == TicketPlaceholder.GLOBAL_Service__c) {
                    ParamRT = '&RecordType=' + eachOption.getValue();        
                    break;
                }   
            String Param1 = '?' + Param1Id + '=' + DefaultStatusValue; // Status
            String Param2 = '&' + Param2Id + '=' + TicketPlaceholder.GLOBAL_Service_Group__c; // Service Group
            String Param3 = '&' + Param3Id + '=' + TicketPlaceholder.GLOBAL_Service__c; // Service
            String Param4 = '&' + Param4Id + '=' + myCase.CaseNumber; // Parent Goal
            
            
            // Set the SLA params (but only if tickets are inheriting case SLAs
            String Param5 = '';
            String Param6 = '';
            if (myCase.SLA__r.Name != null && ticketsInheritGoalSLA)
            {
                Param5 = '&' + Param5Id + '=' + myCase.SLA__r.Name; // SLA
            	Param6 = '&' + Param6Id + '=' + myCase.Active_SLA__c; // SLA Picklist
            }
            myPage = new PageReference(txtInstance + '/' + TicketObjId + '/e' + Param1 + Param2 + Param3 + Param4 + Param5 + Param6 + ParamRT);
            Return myPage;
        }
    }
    
    // Takes a subject and finds the most relevant service which matches it to default it.
    private String findDefaultService(String Subject) {
        try {
            Schema.DescribeFieldResult fieldResult = Ticket__c.GLOBAL_Service__c.getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            // Smart search for ticket type
            String[] SubjectSplit = Subject.split(' ',-2);
            Map<String,Integer> resultCount = new Map<String,Integer>();
            
            for (String eachWord : SubjectSplit) {
                for (Schema.PicklistEntry f : ple)
                {
                    String eachWordStripped = eachWord.replace('-','').replace(' ','').replace('.','');
                    if (f.getLabel().containsIgnoreCase(eachWordStripped) && eachWordStripped != '') {
                        if (!resultCount.containsKey(f.getLabel())) {
                            resultCount.put(f.getLabel(),eachWordStripped.length());
                        } else {
                            resultCount.put(f.getLabel(),resultCount.get(f.getLabel())+eachWordStripped.length());
                        }
                    }
                }
            }
            // Loop through map and return result with most matches
            Integer maxResults = 0;
            String Result = null;
            
            for(String myValue: resultCount.keyset()) {
                System.debug('%%% ' + myValue + ' = ' + resultCount.get(myValue));
                if (resultCount.get(myValue) > maxResults) {
                    maxResults = resultCount.get(myValue);
                    Result = myValue;
                }
            }
            Return Result;
        } catch (Exception e) {
            System.debug(e);
            Return '';
        }
    }
    
    
    // Takes a subject and finds the most relevant service group which matches it to default it.
    private String findDefaultServiceGroup(String Subject) {
        try {
            if (Subject.toLowerCase().contains( 'complaint') )
                return 'Complaint';
            else if (Subject.toLowerCase().contains( 'complement'))
                return 'Complement';
            else if (Subject.toLowerCase().contains( 'concern'))
                return 'Concern';
            else
                return null;
        }
        catch (Exception e){
            System.debug(e);
            return null;
        }
    }
                
                
            	

    public PageReference Cancel() {
        Return new ApexPages.StandardController(myCase).view();
    }    

}