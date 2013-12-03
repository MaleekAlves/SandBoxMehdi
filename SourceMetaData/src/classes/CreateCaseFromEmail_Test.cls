/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class CreateCaseFromEmail_Test {

    static testMethod void handleInboundEmailCreateCaseTest()
    {
    	User uRA= [Select Id From User Where Name= 'Root Administrator'];
    	System.assertNotEquals(uRa, null);
    	System.runAs(uRa)
    	{
			Test.startTest();       
	        // create email and envelop objects, with subject NOT containing a valid Ticket Name, this will
	        // - create a case
		    Messaging.Inboundemail em= new Messaging.Inboundemail();
		   	em.plainTextBody= 'Test body.';
		   	em.subject= 'test email without ticket name';
		   	em.fromAddress= 'test@hounslow.gov.uk';
		   	em.toAddresses= new List<String> {'arcusTestDev@lbh.arcusglobal.com'};
		   	
		   	Messaging.Inboundemail.Binaryattachment bAtt= new Messaging.Inboundemail.Binaryattachment();
		   	bAtt.fileName= 'test';
		   	bAtt.body= Blob.toPdf('test');
		   	em.binaryAttachments= new List<Messaging.Inboundemail.Binaryattachment> {bAtt};
		   	User u= TestDataCreator.createUser();
		   	Contact c= TestDataCreator.createContact(u.Id);
		   			   	
		   	List<RecordType> rts= [Select Id, Name From RecordType Where SobjectType= 'Case' Limit 1];
		   	System.assertNotEquals(rts.size(), 0);
		   	
		   	CreateCaseFromEmail caseFromEmail= new CreateCaseFromEmail(em, rts[0].Id, u.Id, c.Id);
		   	if (caseFromEmail.isApplicable())
		   		caseFromEmail.execute();
       		test.stopTest();
    	}
    }
}