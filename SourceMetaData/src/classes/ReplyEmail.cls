/*------------------------------------------------------------
Author:        Ana Lomibao
Company:       Arcus Global Ltd
Date:          October 2013
Description:   This class handles emails containing tickets that are not ICT related tickets
				
------------------------------------------------------------*/
public class ReplyEmail implements ITaskWF
{
	public Task task {get; set;}
	public Ticket__c ticket {get; set;}
	public Messaging.InboundEmail email {get; set;}
	
	public ReplyEmail(Ticket__c t, Messaging.Inboundemail e)
	{
		ticket= t;
		email= e;
	}
	
	public Boolean isApplicable()
	{
		Boolean result= false;
		if (ticket.RecordType.Name.startsWith('CCC') || 
			ticket.RecordType.Name.compareTo('Highways') == 0
			)
		{
			result= true;
		}
		return result;
		
	}
	
	public void execute()
	{
        /**
         * send reply email to service - Use hardcoded plain test email for now. Could improve using a static resource
         **/
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();            
        mail.setToAddresses(new String[] {email.fromAddress} );
        mail.setSubject('Thank you for your response for ticket ' + InboundTicketEmailHandler.getTicketNumberFromString(email.subject.abbreviate(255)));        
        mail.setPlainTextBody('Details of your response have been logged. ');
        
        //2.4 Sends the email
        try
        {
            if (!Test.isRunningTest())
                Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});   
        }catch(Exception e) 
        {
                System.debug('******** EXCEPTION - INSERT TASK: ' + e.getMessage());
                //post error to page messages/ otherwise warn user?
        }
		//mail.setTargetObjectId(responseLog.Id);
        //mail.setTemplateId()
        
        // Would be nice to set this email as in reply to the originating one, need to get messaging id from inbound email		
	}
	
}