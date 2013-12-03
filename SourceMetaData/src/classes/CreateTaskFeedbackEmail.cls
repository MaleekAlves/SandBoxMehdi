public class CreateTaskFeedbackEmail implements ITaskWF
{
	public Task task {get; set;}
	public Ticket__c ticket {get; set;}
	public Messaging.InboundEmail email {get; set;}
	private static String RECORD_TYPE_NAME= 'External Notifications';
	public String RESPONSE_SUBJECT = 'Review Service Response';
    private String responseStatus;
    private String responseComment;
    
    public CreateTaskFeedbackEmail(Ticket__c t, Messaging.Inboundemail e)
    {
    	ticket= t;
    	email= e;
    }
	
	
	public Boolean isApplicable()
	{
		Boolean result= false;
		if (ticket.RecordType.Name.compareTo('CSC - ICT Ticket') != 0)
		{
			result= true;
		}
		return result;
		
	}	
	
	public void execute()
	{
		ParseBodyForStatusAndComment(email.plainTextBody);
        Task responseLog = new Task();
            
        // Set the task record type to External Notification
        responseLog.RecordTypeId = [SELECT Id, SobjectType, Name FROM RecordType WHERE Name= :RECORD_TYPE_NAME AND SobjectType ='Task' LIMIT 1].Id;
            
        // Set Common fields for the log task (ie the fields that dont depend on the body of the email response)
        responseLog.WhatId = ticket.id;
        
        // New Tasks are owned by whoever owns the goal record. Activities cannot be owned by queues so must test if owner is a queue and act acordingly
    	//Is owner User or Queue
    		//If user, set activity to be owned by user
    		//If Queue: does the Queue have an entry in Queue details custom setting and does that entry contatin a queue owner email which is valid. Then assign case to that person
    		//Else assign to root admin 
        List<User> myUsers = [SELECT Id, Email FROM User WHERE id= :ticket.GLOBAL_Goal__r.OwnerId];
        List<Group> myGroups = [SELECT Id, DeveloperName , Type, Email FROM Group WHERE Type =:'Queue' AND Id =:ticket.GLOBAL_Goal__r.OwnerId];
        if (myUsers.size() > 0)
        {
            //It is owned by a user, set activity ownership accordingly
            responseLog.OwnerId = ticket.GLOBAL_Goal__r.OwnerId;
        }
        else if (myGroups.size() >0)
        {
            // Not owned by user must be owned by a queue. 
            // Look for queue in custom settings to get email of user.
            List<QueueDetails__c> myQueueDetails = [SELECT Id, Name, Queue_Owner_Username__c FROM QueueDetails__c WHERE Name =:myGroups[0].DeveloperName];
            //attempt to match the owner email addr to a user within Salesforce
            if (myQueueDetails.size() >0)
            {
                List<User> myQueueOwners = [SELECT Id, Username FROM User WHERE Username  =:myQueueDetails[0].Queue_Owner_Username__c];
                if (myQueueOwners.size() >0)
                {
                    //Found a valid user who can be set to won this queue
                    System.debug('******** CASE ONWED BY QUEUE, MATCHED OWNER');
                    responseLog.OwnerId = myQueueOwners[0].Id; 
                }
                else
                { 
                    //Could not match username in custom setting, set case to be owned by whomever is running class (assumed to be root admin, specified by email service)
                    System.debug('******** CASE ONWED BY QUEUE, NOT MATCHED OWNER');
                    responseLog.OwnerId = UserInfo.getUserId();
                }
            }
            else
            {
                //Case owned by a queue that does not have an entry in custom setting, set case to be owned by whomever is running class (assumed to be root admin, specified by email service)
                System.debug('******** CASE ONWED BY QUEUE, NO ENTRY IN CUST SETTING');
                responseLog.OwnerId = UserInfo.getUserId();
            }
        }
        
        responseLog.Subject = RESPONSE_SUBJECT;
            
        // Store full email body in description field
        responseLog.Description = email.plainTextBody.abbreviate(32000);
        responseLog.Email_Subject__c = email.subject.abbreviate(255);
        responseLog.Notification_From_Address__c = email.fromAddress;
        responseLog.Notification_From_Name__c = email.fromName;
            
        // Set fields based on the parsed response from the service team
        responseLog.Status = 'Not Started';
        
        responseLog.Email_Comment__c = responseComment.abbreviate(255);
        responseLog.Email_Status_Reported_String__c = responseStatus.abbreviate(50);
        // Set the response drop down to match responseStatus        
        If (InboundTicketEmailHandler.getNotificationValues().contains(responseStatus) && responseStatus != 'Error')   
            responseLog.Notification_Type__c = responseStatus;
        else 
            responseLog.Notification_Type__c = 'Error'; // set the response drop down to error.
        // Then set the status to completed in the case of certain picklist values (TODO)        
		try
		{
        	insert responseLog;
		}catch(Exception err)
		{
			throw err;
		}
		insertAttachmentsToTask(responseLog);
	
	}

    private void ParseBodyForStatusAndComment(String body) 
    {
        // Should use Regex for a more robust search. 
        // for now assume that status sollows 'status =' (ends at end of line) and comment follows 'comment =' ends at end of line)
		System.debug('ParseBodyForStatusAndComment');
        // Set the parsed stings, after parsing want to get rid of all whitespace, make all lowercase and capitalize the first letter.
        responseStatus = DoStringSearch(body,'Status =').trim().toLowerCase().capitalize();
        responseComment = DoStringSearch(body,'Comment =').trim().toLowerCase().capitalize();
        System.debug('responseStatus - responseComment = ');
        System.debug(responseStatus);
        System.debug(responseComment);
        
    }	

    private String DoStringSearch(String searchStr, String firstPart) {
        Integer start = searchStr.indexOf(firstPart) + firstPart.length() ;
        String result = searchStr.substring(start).substringBefore('\n').trim();
        System.debug('DoStringSearch firstPart =' +firstPart+ ',  result = '+result  );
        //System.debug(searchStr.indexOf(firstPart));
        return result;
    }    
	
    /**
     * Method to store any attachments to the task
     **/    	
    private void insertAttachmentsToTask(Task t)
    {
        if (email.binaryAttachments != null && email.binaryAttachments.size() > 0) 
        {
        	List<Attachment> atts= new List<Attachment>();
            for (integer i = 0 ; i < email.binaryAttachments.size() ; i++) 
            {
                Attachment att = new Attachment();
                att.ParentId = t.Id;
                // Must set the attachment owner ID to the same as the task owner Id otherwise get an error on insert
                att.OwnerId = t.OwnerId;
                att.Name = email.binaryAttachments[i].filename;
                att.Body = email.binaryAttachments[i].body;
                att.ContentType = email.binaryAttachments[i].mimeTypeSubType;
                atts.add(att);
            }
            insert atts;
        }
    }
	
}