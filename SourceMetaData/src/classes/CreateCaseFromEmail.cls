public class CreateCaseFromEmail implements ITaskWF{

    public Messaging.InboundEmail email {get; set;}
    public ID caseRecordTypeID {get; set;}
    public ID caseOwnerID {get; set;}
    public ID customerID {get; set;}
    
    public CreateCaseFromEmail( Messaging.Inboundemail e, Id rtId, Id ownerId, Id custId)
    {
    	email = e;
        caseRecordTypeID = rtId;
        caseOwnerID = ownerId;
    }
	
	public Boolean isApplicable()
	{
        // dont run if reord type id, owner id or email are null. 
        if ( caseRecordTypeID==null || caseOwnerID==null || email==null ) {
            return false;
        }
        else {
            return true;	
        }
	}	
	
	public void execute()
	{
        // Email has been sent that does not contain a valid ticket name in the subject. Log as a new case. 
        System.debug('In CreateCaseFromEmail - execute');
        
        try{
            // Create a new case object
            Case newCase = new Case();
            newCase.RecordTypeId = caseRecordTypeID;
            newCase.OwnerId = caseOwnerID;
            newCase.Status = 'Draft';
            newCase.Origin = 'Email';
            newCase.Goal_Free_Text__c = 'New Email Case: '+ email.subject;
            newCase.Email_Subject__c =  email.subject;
            //TODO Doug - deal with the email being sent to more than one person. for now just get the first to address.
            newCase.Email_To__c =  email.toAddresses[0];
            newCase.Email_From__c =  email.fromAddress;
            System.debug(email.htmlBody);
            System.debug(email.plainTextBody);
            newCase.Email_Body__c =  email.htmlBody;
            newCase.Email_Reply_To__c = email.replyTo;
            
            newCase.SuppliedEmail = email.fromAddress;
            if (customerID != null){
                newCase.ContactId = customerID;
            }
            // Insert the case object into the database
            insert newCase;
            
            newCase= [Select Id, CaseNumber From Case Where Id= :newCase.Id];
            
            // Save any attachments on the email.
            insertAttachmentsToCase(newCase);
            
	        /**
	         * send reply email to customer - Use hardcoded plain test email for now. Could improve using a static resource
	         **/
	        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();            
	        mail.setToAddresses(new String[] {email.fromAddress} );
	        mail.setSubject('Thank you for your enquiry, it has been logged and assigned the ref no: ' + newCase.CaseNumber);        
	        mail.setPlainTextBody('It will be now reviewd by the appropriate service area');
	        
	        //2.4 Sends the email
            if (!Test.isRunningTest())
                Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});   
        }
        catch (Exception e)
        {
            throw e;
        }
        
    }
    
    /**
     * Method to store any attachments to the task
     **/    	
    private void insertAttachmentsToCase(Case c)
    {
        if (email.binaryAttachments != null && email.binaryAttachments.size() > 0) 
        {
        	List<Attachment> atts= new List<Attachment>();
            for (integer i = 0 ; i < email.binaryAttachments.size() ; i++) 
            {
                Attachment att = new Attachment();
                att.ParentId = c.Id;
                // The case is most likely owned by a queue. Attachments cant be owned by a queue so set the attachment to be owned by the current context user for the class (prob root admin)
                att.OwnerId = UserInfo.getUserId();
                att.Name = email.binaryAttachments[i].filename;
                att.Body = email.binaryAttachments[i].body;
                att.ContentType = email.binaryAttachments[i].mimeTypeSubType;
                att.IsPrivate = false;
                atts.add(att);
            }
            insert atts;
        }
    }
    
}