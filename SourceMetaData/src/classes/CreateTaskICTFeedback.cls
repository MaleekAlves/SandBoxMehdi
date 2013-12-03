/*------------------------------------------------------------
Author:        Ana Lomibao
Company:       Arcus Global Ltd
Date:          October 2013
Description:   
Test class:    InboundTicketEmailHandler_Test.cls
------------------------------------------------------------*/
public class CreateTaskICTFeedback implements ITaskWF
{
	public static String TASK_RECORD_TYPE;
	public static String RECORD_TYPE_NAME= 'External Notifications';
	public static String EMAIL_ON_TIME_SUBJECT= 'Customer feedback on time';
	public static String EMAIL_NOT_ON_TIME_SUBJECT= 'Customer feedback late';
	
	private Ticket__c ticket;
	public Task task;
	public Messaging.InboundEmail email;
	
	public CreateTaskICTFeedback(Ticket__c t, Messaging.Inboundemail e)
	{
		ticket= t;
		email= e;
		RecordType rt= [Select Id From RecordType Where Name= :RECORD_TYPE_NAME And SobjectType= 'Task'];
		if (rt != null)
			TASK_RECORD_TYPE= rt.Id;
	}
	
	public Boolean isApplicable()
	{
		Boolean result= false;
		// Applicable when the task's relatedTo is an ICT Ticket
		if (ticket.RecordType.Name.compareTo('CSC - ICT Ticket') == 0)
		{
			result= true;
		}
		return result;
	}
	
	public void execute()
	{
		// if current date <= ticket's GLOBAL_Feedback_Cutoff_Date__c, reply with email and create task with status CLOSED		
		// else if current date > ticket's GLOBAL_Feedback_Cutoff_Date__c, reply with email and create task with status OPEN
		Task taskLog; 
		Date emailReceivedDate= Date.today();
		if (ticket.GLOBAL_Feedback_Cutoff_Date__c == null || emailReceivedDate <= ticket.GLOBAL_Feedback_Cutoff_Date__c)
		{
			taskLog= new Task(
						Subject= EMAIL_ON_TIME_SUBJECT,
						Status= 'Open',
						WhatId= ticket.Id,
						Description= email.subject + '\n' + email.plainTextBody,
						RecordTypeId= TASK_RECORD_TYPE,
						OwnerId= UtilityQueueOwnerMapping.getUserOwnerID(ticket.OwnerId) 
						);			
						
		}else
		{
			taskLog= new Task(
						Subject= EMAIL_NOT_ON_TIME_SUBJECT,
						Status= 'Completed',
						WhatId= ticket.Id,
						Description= email.subject + '\n' + email.plainTextBody,
						RecordTypeId= TASK_RECORD_TYPE,
						OwnerId= UtilityQueueOwnerMapping.getUserOwnerID(ticket.OwnerId)
						);			
		}
		try
		{
			if (taskLog != null)
			{
				insert taskLog;
				insertAttachmentsToTask(taskLog);
			}
		}catch (Exception e)
		{
			throw e;
		}
	}
	
    /**
     * Method to store any attachments to the task
     **/    	
    private void insertAttachmentsToTask(Task t)
    {
        List<Attachment> atts= new List<Attachment>();
        if (email.binaryAttachments != null && email.binaryAttachments.size() > 0) 
        {
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
        }
        
        if (email.textAttachments != null && email.textAttachments.size() > 0)
        {
        	for (Integer i= 0; i < email.textAttachments.size(); i++)
        	{
                Attachment att = new Attachment();
                att.ParentId = t.Id;
                // Must set the attachment owner ID to the same as the task owner Id otherwise get an error on insert
                att.OwnerId = t.OwnerId;
                att.Name = email.textAttachments[i].filename;
                att.Body = Blob.valueOf(email.textAttachments[i].body);
                att.ContentType = email.textAttachments[i].mimeTypeSubType;
                atts.add(att);        		
        	}	
        }
        if (atts.size() > 0)
        	insert atts;
    }	
}