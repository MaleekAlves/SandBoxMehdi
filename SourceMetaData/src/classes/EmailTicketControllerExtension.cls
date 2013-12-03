/*------------------------------------------------------------
Author:        Douglas Guthrie
Company:       Arcus Global Ltd
Date:          05/07/2013
Description:   Extension class used to manage the sending of emails from tickets. 
This is uesd both to send acknowledgements to customers and dispatches
to service teams. 
Test Class:    TestClass
------------------------------------------------------------*/

public with sharing class EmailTicketControllerExtension {
    
    //Mini wrapper class to hold attachment objects and make them selectable
    public class AttachmentWrapper {
        public Boolean isSelected {get;set;}
        public String source {get;set;}
        public Attachment cAttachment {get;set;}
        
        public AttachmentWrapper(Attachment cAttachment, String src){
            this.isSelected = false;
            this.cAttachment = cAttachment;
            this.source = src;
        }
    }
    // Email fields, used on VF page
    public String cc { get; set; }
    public String bcc { get; set; }
    public String to { get; set; }
    public String body { get; set; }
    public String subject { get; set; }
    public String filename { get; set; }
    public OrgWideEmailAddress replyEmail { get; set; } 
    
    // Booleans to control class behavior and rendering of componenets on VF page
    public boolean previewAcknowledge { get; set; }
    public boolean previewDispatch { get; set; }
    public boolean sendDisabled { get; set; }
    
    public boolean useHtmlTemplate { get; set; }
    public boolean showExtraAttachmentsPanel { get; set; }
    public boolean markTicketAsOpen { get; set; }
    public boolean ccDispatcher { get; set; }
    public Integer totalFileSize { get; private set; }
    public Integer attachmentsListSize { get; private set; }
    
    // The ticket that is being dispatched
    public final Ticket__c ticket { get; set; }
    public List<AttachmentWrapper> attachmentsList { get; set; }
    private String attachmentSummaries;
    private Integer i;
    //Not using quesue list drop-down public List<Group> queuesList { get; set; }
    transient Messaging.SingleEmailMessage email { get; set; }
    
    // action is passed in as a parameter to the EmailTicket page, it describes what tye of email send
    // operation is required - it is currently either dispatch or acknowledge
    private String action;
    private PageReference pdf;
    
    public EmailTicketControllerExtension(ApexPages.StandardController stdController) {
        //----------------------------------------------------------------------------
        //Constructor - EmailTicketControllerExtension
        //1 - Configure type of email to be sent and what object we are sending from.
        //1.1 - Set action (acknowledge or dispatch) based on URL parameter
        //1.2 - set whether or not to use a html template based on parameter (for now set to false) 
        
        //2. Do SOQL query suitable for action and if using a template
        //2.1 - fetch a ticket and all fields required to select and build emails. 
        
        //3 Select all attachements on the ticket and on the goal, will need to list these on the page so they can also be attached to the dispatch
        //3.1 Create the selectable list of attachments
        //3.2 add to the list all ticket attachments
        //3.3 add to the list all goal attachments
        
        //4. - Populate fields on the sendEmail page based on action and if using template
        //----------------------------------------------------------------------------
        System.debug('******** EmailTicketControllerExtension ********');
        //1 - Configure type of email to be sent and what object we are sending from.
        //1.1 - Set action (acknowledge or dispatch) based on URL parameter
        //1.2 - set whether or not to use a html template based on parameter (for now set to false)
        try {
            action = ApexPages.currentPage().getParameters().get('action');
            useHtmlTemplate = Boolean.valueOf(ApexPages.currentPage().getParameters().get('useTemplate'));
            System.debug('******** PARAMS: use template = ' +useHtmlTemplate+' action = '+ action);
        }catch(Exception e) {
            System.debug('******** EXCEPTION (PARSING URL PARAMS): ' + e.getMessage());
            useHtmlTemplate = false;
        }
        // Default behavior is that when a dispatch is sent the ticket status should be marked as open.
        markTicketAsOpen = true;
        ccDispatcher = true;
        sendDisabled = false;
        
        System.debug('******** PARAMS: use template = ' +useHtmlTemplate+' action = '+ action);
        //2. Do SOQL query suitable for action and if using a template
        //2.1 - fetch a ticket and all fields required to select and build emails. 
        ticket = [SELECT id,Name,GLOBAL_Goal__c, GLOBAL_Customer_Email__c,GLOBAL_Customer_Name__c,GLOBAL_Ticket_Status__c,
                  GLOBAL_Ticket_Summary__c, GLOBAL_Representative_Used__c,GLOBAL_Customer_Representative__c, 
                  GLOBAL_Representative_Email__c,RecordType.Name,  GLOBAL_Opened_Date__c, 
                  GLOBAL_Additional_Info__c , Owner.type,ownerid, GLOBAL_Goal__r.CaseNumber
                  FROM Ticket__c 
                  WHERE (id=:ApexPages.currentPage().getParameters().get('id')) ][0];
        //2.2 - find the org wide email that mathches the reply email addr supplied. 
        //(will crash if an email addr that has not been created as aon org wide email is supplied)
        //System.debug('%%%% replyAddr = ' + ApexPages.currentPage().getParameters().get('replyAddr'));
        
        User currentUser= [Select Id, Name, Profile.Name From User Where Id= :Userinfo.getUserId()];
        // Set the reply address based upon the profile of the current user. If they are CR then reply addr is CR addr if not reply addr is cust services. 
        String replyAddr= currentUser.Profile.Name == 'LBH Cust Relations'? 'customerrelations@hounslow.gov.uk' : 'customerservices@hounslow.gov.uk';
        
        replyEmail = [SELECT ID, DisplayName,Address  FROM OrgWideEmailAddress WHERE (Address =:replyAddr)]; //:ApexPages.currentPage().getParameters().get('replyAddr')) ];
        
        //3 Select all attachements on the ticket and on the goal, will need to list these on the page so they can also be attached to the dispatch
        //3.1 Create the selectable list of attachments
        attachmentsList = new List<AttachmentWrapper>();
        //3.2 add to the list all attachments
        for(Attachment a : [SELECT id,Name, Description, ContentType, parentId, BodyLength   FROM Attachment WHERE (parentId=:ticket.id OR parentId=:ticket.GLOBAL_Goal__c )]){
            if (a.parentId == ticket.id) attachmentsList.add(new AttachmentWrapper(a,'Ticket') );
            else if (a.parentId==ticket.GLOBAL_Goal__c ) attachmentsList.add(new AttachmentWrapper(a,'Case') );    
        }
        attachmentsListSize = attachmentsList.size();
        //4. - Populate fields on the sendEmail page based on action and if using template
        if(useHtmlTemplate)
        {
            // Show the template window - For now just use a generic template TODO
            //EmailTemplate et = [Select Id from EmailTemplate where Name = 'Generic Template'];
        }
        else{
            if (action == 'dispatch'){
                setFieldsForDispatch();
            }else if (action == 'acknowledge'){
                setFieldsForAcknowledge();
            }
            bcc = '';
        }
        ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO, 'Page loaded ok - the fields below have been set to suitable defaults based on the ticket but you can override them if you need to'));
    }
    
    private string getEmailAddress(ID OwnerId) {
        List<User> myUsers = [SELECT Id, Email FROM User WHERE id =:ticket.ownerid];
        List<Group> myGroups = [SELECT Id, Name, Type, Email FROM Group WHERE ( Type =:'Queue' AND Id =:ticket.ownerid)];
        if (myUsers.size() > 0)
            return myUsers[0].email;
        else if (myGroups.size() > 0)
            return myGroups[0].email;
        else
            return '';
    }
    
    private void setFieldsForDispatch(){
        // Here set up the fielname, subject, body, to and cc properties of the emial. With the exception of filename then can be then updated by the user in the visualforce page
        subject = 'Dispatch of Ticket '+ticket.name+ ' Case ID ' + ticket.GLOBAL_Goal__r.CaseNumber;
        filename = 'Dispatch of Ticket '+ticket.name+'.pdf';
        // Body is formed of 2 parts, a dispatch string stored on the ticket record and a static resource which provides a simple text response fomr for the service. 
        StaticResource sr = [select id, name, body from StaticResource where name = 'ServiceEmailResponseTemplate'][0]; 
        body = (ticket.GLOBAL_Additional_Info__c==null) ? sr.body.toString(): ticket.GLOBAL_Additional_Info__c + '\n\n' +sr.body.toString();
        to = getEmailAddress(ticket.ownerid);
        cc = '';
        // Select the appropriate visualforce page for the attached notification
        pdf =  Page.TicketPdfDispatch;
        previewDispatch = true;
        previewAcknowledge = false;
    }
    
    private void setFieldsForAcknowledge(){
        // This is not currently in use as customer acknowledgements are sent using standard salesforce send email funtionality
        String ackSubject;
        ackSubject = 'Acnkowledgement of Ticket = ';
        ackSubject = ackSubject + ticket.name;
        subject =  ackSubject;
        filename = 'Acnkowledgement of Ticket '+ticket.name+'.pdf';
        StaticResource sr = [select id, name, body from StaticResource where name = 'ServiceEmailResponseTemplate'][0]; 
        body = (ticket.GLOBAL_Additional_Info__c==null) ? sr.body.toString(): ticket.GLOBAL_Additional_Info__c + '\n\n' +sr.body.toString();
        to = (ticket.GLOBAL_Customer_Email__c==null) ? '' : ticket.GLOBAL_Customer_Email__c;
        cc = (ticket.GLOBAL_Representative_Email__c == null) ? '' : ticket.GLOBAL_Representative_Email__c;
        pdf =  Page.TicketPdfDispatch;
        previewDispatch = false;
        previewAcknowledge = true;
    }
    
    public PageReference preview() {
        return Page.TicketPdfDispatch;
    }
    
    public PageReference onAttachmentSelect(){
    	System.debug('******** onAttachmentSelect'); 
    	totalFileSize = 0;
    	for (AttachmentWrapper aw : attachmentsList)
    	{
    		if (aw.isSelected) totalFileSize += aw.cAttachment.BodyLength;
    		System.debug('******** totalFileSize = ' + totalFileSize); 
    	}
    	// if attaching over 10 Mb
    	if (totalFileSize > 10000000) sendDisabled=true;
    	System.debug('******** totalFileSize ' + totalFileSize); 
    	return null;
    }
    
    public PageReference preview2() {
        return Page.TicketPdfDispatch;
    }
    
    public Task createEmailLogTask(List<Messaging.EmailFileAttachment> emailAttachments, Blob b)
    {
        //3 Create the task to log sending of email (if email was sent ok!)
        try{
            System.debug('******** CREATE LOG TASK AND ATTACHMENT - ticket.id = ' + ticket.id);
            Task emailLog = new Task();
            emailLog.RecordTypeId = [SELECT Id,SobjectType,Name FROM RecordType WHERE Name ='Dispatch Log' AND SobjectType ='Task'  LIMIT 1].Id;
            emailLog.WhatId = ticket.id;
            emailLog.Subject = 'Ticket Dispatched';
            emailLog.status = 'Completed';
            emailLog.Description  = ' Details of email dispatch \n';
            emailLog.Description += 'To: ' + to + '\n';
            emailLog.Description += 'Cc: ' + cc + '\n';
            emailLog.Description += 'Bcc: ' + bcc + '\n';
            emailLog.Description += 'Subject:' + subject + '\n';
            emailLog.Description += body + '\n';
            
            if (emailAttachments != null)
                emailLog.Description += attachmentSummaries + '\n';
            
            emailLog.Email_To_Addresses__c = to.abbreviate(255);
            emailLog.Email_CC_Addresses__c = cc.abbreviate(255);
            emailLog.Email_BCC_Addresses__c = bcc.abbreviate(255);
            emailLog.Email_Body__c = body.abbreviate(255);
            emailLog.Email_Subject__c = subject.abbreviate(255);
            insert emailLog;
            // create an attachemnt to hold the pdf that has been sent and then link it to the email log.
            Attachment attachment = new Attachment();
            try {
                attachment.Body = b;
                attachment.Name = filename;
                attachment.Description = 'Dispatch sent via the automated dispatch screen';
                attachment.ParentId = emailLog.id; 
                attachment.ContentType = '.pdf'; 
                insert attachment;
            } catch(Exception e) {
                //attachment = TestClass.CreateTestAttachment(ticket.id);
            }
            return emailLog;
            
        }catch(Exception e) {
            System.debug('******** EXCEPTION - INSERT TASK: ' + e.getMessage());
            return null;
        }
        
        
    }
    
    public PageReference send() {
        //----------------------------------------------------------------------------
        // Action when Send button clicked - send()
        //1 Validation Checks - total attachment size, fields completed        
        //TO DO
        
        //2 Define the email object
        //2.1 Convert the ticket details into a pdf dispatch notification and attach it
        //2.2 Attach all the goal and ticket attachments that have been checked to the email
        //2.3 Set the body and to, cc and bcc addrs of email
        //2.4 Send email
        
        //3 Create the task to log sending of email
        //3.1 Create tasks, set its fields, insert it.
        //3.2 create attachemnt object with the pdf dispatch, link to the task, insert it.
        
        //4 Finally if the user has selected to mark the ticket as open then mark it as open (assuming it isnt already open)
        
        //5 Close dialog. 
        //----------------------------------------------------------------------------
        
        // 2 Define the email object and a list object to hold all its attachments
        email = new Messaging.SingleEmailMessage();
        List<Messaging.EmailFileAttachment> emailAttachments = new List<Messaging.EmailFileAttachment>();
        // 2.1        
        // Reference the attachment page and pass in the account ID
        pdf.getParameters().put('id',(String)ticket.id); 
        pdf.setRedirect(false);
        // Take the PDF content
        Blob b;
        try {
            b = pdf.getContent();
        } catch (Exception e){}
        
        
        
        // Create the email attachment and add it to attachment list
        try{
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setFileName(filename);
            efa.setBody(b);
            System.debug('******** ATTACHING : efa'+efa); 
            emailAttachments.add(efa);
            
            //2.2
            
            Set<Id> AttachmentIDs = new Set<Id>();
            
            for(AttachmentWrapper aw : attachmentsList)
                if (aw.isSelected)
                AttachmentIDs.add(aw.cAttachment.id);           
            
            // Do a SOQL query to fetch the body of the attachments (ie the actual file to attach). 
            List<Attachment> myAttachments = [SELECT id, Name, Description, ContentType, ParentId, BodyLength, Body FROM Attachment WHERE id IN :AttachmentIDs ];
            attachmentSummaries = '\n ********** Summary of Additional Files Attached to Dispatch **********\n';
            i = 1;
            for (Attachment a : myAttachments) {
                // Attach to email object
                Messaging.EmailFileAttachment newAttachment = new Messaging.EmailFileAttachment();
                newAttachment.setFileName(a.Name);
                newAttachment.setBody(a.Body);
                emailAttachments.add(newAttachment);
                attachmentSummaries = attachmentSummaries + 'Attachment #'+i+': Filename = '+ a.Name + ', Type = '+ a.ContentType + ', Id = '+a.id+'\n';
                i++;
                // Add its name to the log string to add to task log.  (TODO)
            }
            attachmentSummaries = attachmentSummaries + '********** End Summary of Attachments **********\n';
            
            //2.3
            email.setSubject(subject);
            
            //email.setBccSender(ccDispatcher);
            
            // if to is blank, throw an error
            if (to!=''){
                //ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, 'Email must have a to address'));
                if (ccDispatcher) email.setTargetObjectId(UserInfo.getUserId());
                email.setToAddresses(to.split(';', 0));
            }
            
            if (cc!='') email.setCcAddresses(cc.split(';', 0));
            if (bcc!='') email.setBccAddresses(bcc.split(';', 0));
            // address email is sent from 
            email.setOrgWideEmailAddressId(replyEmail.Id);
            email.setPlainTextBody(body);
            email.setFileAttachments(emailAttachments);
            email.setSaveAsActivity(false);
            //2.4 Sends the email
            System.debug('******** TRY TO SEND EMAIL ***************');
            //if (!Test.isRunningTest())
            List<Messaging.SendEmailResult> results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
            System.debug(results);
            System.debug(results.get(0).isSuccess());
            System.debug(!results.get(0).isSuccess());
            if (results.get(0).isSuccess()) {
                System.debug('******** Worked ***************');
                createEmailLogTask(emailAttachments, b);
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO, 'Email sent ok, it has been logged on the ticket - You can use this screen to send further dispatches or close it to return to the ticket'));
                
            }
        }
        
        catch(Exception e) {
            System.debug('******** EXCEPTION - INSERT TASK: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.FATAL, 'Email failed to send: ' +  e.getMessage() ));
            return null;
            //post error to page messages/ otherwise warn user?
        }
        
        //4 Finally if the user has selected to mark the ticket as open then mark it as open (assuming it isnt already open)
        if ( markTicketAsOpen && ticket.GLOBAL_Ticket_Status__c == 'Draft')
        {
            ticket.GLOBAL_Ticket_Status__c = 'Open';
            update ticket;
        }
        
        System.debug('******** END ********');
        return null;
        
    }
        
    
    
}