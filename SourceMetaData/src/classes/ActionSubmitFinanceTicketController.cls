public class ActionSubmitFinanceTicketController {
/*
    
    public Ticket__c myTicket { get; set; }
    public Case myCase { get; set; }
    public List<RecordType> ticketRecordTypes { get; set; }
    public List<SelectOption> RecordTypeList { get; set; }
    public List<Schema.FieldSetMember> finaceTicketFields { get; set; }
    public Boolean showForm { get; set; }
    public Boolean showResults { get; set; }
    public Id selectedTicketRecordType { get; set; }
    public Attachment attachment {
        get {
            if (attachment == null)
                attachment = new Attachment();
            return attachment;
        }
        set;
    }

    
    public ActionSubmitFinanceTicketController () {
        // Constructor 
        // Create a case adn ticket object. Set case to some standard values.
        
        // Get the finance ticket record types and add them to a list for selection
        showForm = true;
        showResults = false;
        ticketRecordTypes =  [SELECT Id,SobjectType,Name FROM RecordType WHERE SobjectType ='Ticket__c' AND Name LIKE '%Finan%'  ];
        RecordTypeList = new List<SelectOption>();
        System.debug(ticketRecordTypes );
        for (RecordType rt: ticketRecordTypes )
        {
            RecordTypeList.add(new SelectOption(rt.Id, rt.Name) );
        }
        
        // Create Ticket and Case object, set intial values
        myCase = new Case(Goal_Free_Text__c = 'Test'  );
        // For the case fields that should be set
        //DONE
        // Owner - Finance Queue
        // Origin - Chatter
        // Record Type - CSC
        // Customer - Assume that the current user has a linked contact record. Use SOQL to get this record.
        // TO DO
        // Service Area
        myCase.RecordTypeId = [SELECT Id,SobjectType,Name FROM RecordType WHERE Name ='CSC' AND SobjectType ='Case'  LIMIT 1].Id;
        myCase.OwnerId = [SELECT Id,Type,Name FROM Group WHERE Name = 'CSC - Finance Operations' AND Type ='Queue'  LIMIT 1].Id;
        myCase.ContactId = [SELECT Id,Name,User__c FROM Contact WHERE User__c =: UserInfo.getUserId()  LIMIT 1].Id;
        myCase.Origin = 'Chatter';
        
        // Create the ticket, inherit owner from case
        myTicket = new Ticket__c( OwnerId = myCase.OwnerId  );
        
        // Get the ticket fields that we need to set for a finace ticket (as in the finace field set)
        finaceTicketFields = new List<Schema.FieldSetMember>();
        finaceTicketFields =  SObjectType.Ticket__c.FieldSets.Finance_Request_Field_Set.getFields();
        
        System.debug('myTicket = ' + myTicket  );
        System.debug('myCase = ' + myCase );
        System.debug('finaceTicketFields = ' + finaceTicketFields );
    }
    
    public PageReference Submit(){
        System.debug('submit '  );
        System.debug('submit ' + RecordTypeList  );
        
        //1 - Insert Cast, Ticket and Attachment into the DML
        
        System.debug('myCase = ' + myCase );
        
        insert(myCase);
        
        myTicket.GLOBAL_Goal__c=myCase.Id;
        //myTicket.RecordTypeId = 
        System.debug('myTicket = ' + myTicket  );
        insert(myTicket );
        System.debug('AFTER INSERT myTicket = ' + myTicket  );
        
        // Now upload the attachment
        attachment.OwnerId = UserInfo.getUserId();
        attachment.ParentId = myTicket.Id; 
        attachment.IsPrivate = false;
        
        try {
            insert attachment;
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
            return null;
        } finally {
            attachment = new Attachment(); 
        }
        
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Attachment uploaded successfully'));

        
        //myTicket = new Ticket__c( [SELECT Id, IsDeleted, Name, CreatedDate, RecordTypeId, LastModifiedById, GLOBAL_Active_SLA__c, GLOBAL_Received_Date__c, 
        //GLOBAL_Customer_Id__c, GLOBAL_Goal_Summary__c, GLOBAL_Customer_Name__c, GLOBAL_IsReopenTicket__c, FOI_Type__c, GLOBAL_Goal__c FROM Ticket__c
        //WHERE Id =:myTicket.Id LIMIT 1 ]  );
        
        showForm = false;
        showResults = true;
        
        // here after insert we also want to create chatter posts logging the creation and adding into users feed.
        
        //Chatter Actions
        	//1 - Report to follow ticket that has been created
        	//2 - post into the users feed
        
        //1
        EntitySubscription follow = new EntitySubscription (parentId = myTicket.Id, subscriberid = UserInfo.getUserId()); //your User Id
		insert follow;

        //2 - insert a post in users chatter feed
        FeedItem post = new FeedItem();
        post.ParentId = UserInfo.getUserId(); //eg. Opportunity id, custom object id..
        post.Body = 'Finance Request Submitted';
        insert post;   
        return null ;
    }
*/
}