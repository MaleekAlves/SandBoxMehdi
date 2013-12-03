/*------------------------------------------------------------
Author:        Tony Evans
Company:       Arcus Global Ltd
Date:          01/08/2013
Description:   Class containing all test classes for Confirm integration
Test Class:    ConfirmTestClass
------------------------------------------------------------*/
@isTest
public class ConfirmTestClass{
    
    static TestMethod void testConfirmTicketControllerExtension() {
        Test.startTest();
        
        // Set up test objects variables.
        //Case testCase = TestClass.CreateTestCase(TestClass.CreateTestContact(TestClass.CreateTestAccount()));
        Id caseId= TestDataCreator.createCase();
        Case testCase= [Select subject, id from Case Where Id= :caseId];
        Ticket__c testTicket = TestClass.CreateTestHighwaysTicket(testCase);
        
        // Confirm ticket page with std params supplied (at CRM go-live this will be ony config)
        PageReference pageRef = Page.TicketConfirmSubmit;
        pageRef.getParameters().put('action', 'sendToConfirm');
        pageRef.getParameters().put('TicketID', testTicket.id);
        pageRef.getParameters().put('id', testTicket.id);
        Test.setCurrentPage(pageRef);
        
         //Construct the controller
        ApexPages.StandardController TestStdController = new ApexPages.StandardController(testTicket);
        ConfirmTicketControllerExtension controllerExt = new ConfirmTicketControllerExtension(TestStdController);
        
        // TEST 1 - verify constructor loads ok given valid params
        System.debug('TEST 1 - verify constructor loads ok given valid params');
        System.assertEquals(controllerExt.ticket.id, testTicket.id);
        
        // TEST 2 - Test Sending to Confirm
        System.debug('TEST 2 - Sending to Confirm');
        controllerExt.testStatus = true;
        Pagereference pref= controllerExt.sendToConfirm();        
        System.assertEquals(pref, null);
        
        
        /**
        if (controllerExt.ConfirmID.contains('Error Submitting Ticket')){
        	System.assertEquals(controllerExt.errorStatus, TRUE);    
        } else {
            System.assertEquals(controllerExt.sendStatus, TRUE);
        }
        */
        Test.stopTest();
    }
    
}