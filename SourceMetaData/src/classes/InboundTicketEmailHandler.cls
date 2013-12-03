/*------------------------------------------------------------
Author:        Ana Lomibao
Company:       Arcus Global Ltd
Date:          October 2013
Description:   Class that handles emails received from the InboundTicketEmailService email service. Parses the email for the the ticket number and sends it to the appropiate workflow class
Test class:    InboundTicketEmailHandler_Test.cls
------------------------------------------------------------*/
global class InboundTicketEmailHandler implements Messaging.InboundEmailHandler 
{
    public Ticket__c ticket { get; set; }
    private String ticketName;
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) 
    {
        ticketName= getTicketNumberFromString(email.subject);
        if (String.isNotBlank(ticketName))
        {
        	ticket = [SELECT id, OwnerId, Name, GLOBAL_Feedback_Cutoff_Date__c, RecordTypeId, RecordType.Name, GLOBAL_Ticket_Status__c, GLOBAL_Goal__r.OwnerId FROM Ticket__c WHERE (Name=:ticketName)];
        	if (ticket != null)
        	{
				// Execute workflows classes
				List<ITaskWF> taskWFs= new List<ITaskWF>
					{
						new ReplyEmail(ticket, email), 				// reply back to non ICT tickets
						new ReplyICTFeedbackEmail(ticket, email),	// reply back to ICT tickets
						new CreateTaskFeedbackEmail(ticket, email),	// create task to log non ICT tickets
						new CreateTaskICTFeedback(ticket, email)	// create task to log ICT tickets
					};
						
				for (ITaskWF tWF: taskWFs)
				{   
					if(tWF.isApplicable())
					{
						twF.execute();
					}
				}
        	}else
        	{
        		// TODO: Cannot find the ticket name in the database
                
        	}
        }else
        {
            // Email has been sent that does not contain a valid ticket name in the subject. Log as a new case. 
            // Consult the custom setting myEmailMapping to determine what the new case ownership and record type id should be. 
            try{                                                                    
                List<InboundEmailAddressMapping__c> myEmailMappings = [ SELECT Id, Name, To_Addr__c, Case_Record_Type_Id__c, Assigned_to_Queue_ID__c 
                                                                FROM InboundEmailAddressMapping__c 
                                                                WHERE To_Addr__c IN :email.toAddresses 
                                                                LIMIT 1 ];
                // Based on the inbound email address see if we can match this to either a hounslow employee (if email ends @hounslow.gov.uk) or to a person account if it does not. 
                ID caseCustomerId;
                if (email.fromAddress.endsWith('hounslow.gov.uk'))
                {
                	List<Contact> contacts= [SELECT id, email FROM Contact WHERE email=: email.fromAddress LIMIT 1];
                	if (contacts.size() > 0)
                    	caseCustomerId = contacts[0].id;
                }
                else
                {
                    //TODO Search account objects, more complex owing to business accounts/ person account split
                    caseCustomerId = null; 
                }
                
                // TODO Doug - assuming that the fields in the email mapping contain valid IDs. Could test this before casting them to ID type.
                CreateCaseFromEmail createCaseWF;
                if (myEmailMappings.size() > 0)
                	createCaseWF = new CreateCaseFromEmail(email, (Id)myEmailMappings[0].Case_Record_Type_Id__c, (Id)myEmailMappings[0].Assigned_to_Queue_ID__c, caseCustomerId );
                else
                	return null; // TODO Doug
                
                if(createCaseWF.isApplicable())
                {
                    createCaseWF.execute();
                }
            }
            catch (Exception e)
            {
                throw e;
            }
        }
        return null;
    }
    
    /**
     * Method to parse Ticket__c.Name, autonumber with format T{000000000} from a string using regex
     **/
    public static String getTicketNumberFromString(String str)
    {
    	String result;
    	if (String.isNotBlank(str))
    	{
	    	String searchPattern= '.*([tT]\\d{8}).*';
	    	Matcher m= Pattern.compile(searchPattern).matcher(str);
	    	if (m.matches())
	    	{
	    		result= m.group(1);
	    	} 
    	}
    	return result;
    }
    
    public static Set<String> getNotificationValues() 
    {
        List<Schema.PicklistEntry> ple = Task.Notification_Type__c.getDescribe().getPickListValues();
        Set<String> plv = new Set<String>();
        for (Schema.PicklistEntry e : ple)
            plv.add(e.getLabel());
        return plv;
    }    
    
    
}