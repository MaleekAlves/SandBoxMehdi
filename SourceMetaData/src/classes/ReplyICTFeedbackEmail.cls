/*------------------------------------------------------------
Author:        Ana Lomibao
Company:       Arcus Global Ltd
Date:          October 2013
Description:   
Test class:    InboundTicketEmailHandler_Test.cls
------------------------------------------------------------*/
public class ReplyICTFeedbackEmail implements ITaskWF
{
	private Ticket__c ticket;
	private Task task;
	private static String EMAIL_TEMPLATE= '';
	public Messaging.InboundEmail email;
	
	public ReplyICTFeedbackEmail(Ticket__c t, Messaging.Inboundemail e)
	{
		ticket= t;
		email= e;
	}
	
	public Boolean isApplicable()
	{
		Boolean result= false;
		if (ticket.RecordType.Name.compareTo('CSC - ICT Ticket') == 0)
		{
			result= true;
		}
		return result;
	}
	
	public void execute()
	{
		
		// reply to user's feedback email		
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {email.fromAddress} );
        mail.setSubject('Thank you for your response to ICT ticket ' + InboundTicketEmailHandler.getTicketNumberFromString(email.subject.abbreviate(255)));
		Date emailReceivedDate= Date.today();
		if (ticket.GLOBAL_Feedback_Cutoff_Date__c == null || emailReceivedDate <= ticket.GLOBAL_Feedback_Cutoff_Date__c)
		{
	        mail.setPlainTextBody('Your feedback has been logged.'); 
		}else
		{
			mail.setPlainTextBody('Your feedback has been logged to a closed ticket.');
		}
		// send email        			
        try
        {
            if (!Test.isRunningTest())
                Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});   
        }catch(Exception e) 
        {
            throw e;
        }
	}
	
}