/*------------------------------------------------------------
Author:        Matt Urbanowski
Company:       Arcus Global Ltd
Date:          24/06/2013
Description:   Class containing all test classes for extensions / classes / triggers etc.
               Also contains private functions for creating test records
Test Class:    TestClass
------------------------------------------------------------*/
@isTest
public class TestClass {

    public static Account CreateTestPerson() {
        RecordType PersonrecordType = [select Id, Name, DeveloperName from RecordType where SObjectType = 'Account' and IsPersonType = true limit 1 ];
        Account testPerson = New Account(FirstName='Bob', LastName='Test', RecordTypeId=PersonrecordType.Id, Phone='000000');
        insert testPerson;
        return testPerson;       
    }
    
    public static Account CreateTestAccount() {
        Account a = new Account(Name='Test Account');
        insert a;
        return a;
    }
    
    public static Contact CreateTestContact(Account testAccount) {
        Contact c = new Contact(FirstName='Susan', LastName='Cook', Phone='000', Email='t@t.t', AccountId=testAccount.id, MobilePhone= '0987083702');
        insert c;
        return c;
    }
    
    public static User CreateTestUser() {
        Profile adminProfile = [Select Id From Profile Where Name = 'System Administrator'];
        return [Select Id, Name from User Where UserType = 'Standard' and isActive = true and ProfileId = :adminProfile.Id Limit 1][0];
    }
    
    public static Case CreateTestCase(Contact testContact) {
        Case testCase = new Case(Subject='Test', ContactId = testContact.Id,Goal_Free_Text__c = 'Test',  OwnerId = CreateTestUser().Id);
        insert testCase;
        return testCase;
    }
    
    public static Ticket__c CreateTestTicket(Case testCase) {
        Ticket__c testTicket = new Ticket__c(GLOBAL_Service__c='Test', GLOBAL_Goal__c=testCase.Id, OwnerId = CreateTestUser().Id);
        insert testTicket;
        return testTicket;        
    }
    
    public static Ticket__c CreateTestHighwaysTicket(Case testCase) {
        Ticket__c testTicket = new Ticket__c(GLOBAL_Service__c='Test', GLOBAL_Goal__c=testCase.Id, OwnerId = CreateTestUser().Id);
               //configure ticket with Highways Data             
        testTicket.HHW_Hounslow_Borough__c = TRUE;
        testTicket.HHW_Service__c = 'Drainage';
        testTicket.HHW_Subcategory__c = 'Bad Smell';
        testTicket.HHW_Location_Details__c = '';
        testTicket.HHW_Location__c = '';
        testTicket.HHW_Enquiry_Description__c = ''; 
        insert testTicket;
        return testTicket;        
    }
    
    public static Attachment CreateTestAttachment(id parentId, String attachmentName, String bodyName) {
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        Attachment testAttachment = new Attachment(ParentId = parentId, Name = 'test attachment', Body = bodyBlob );
        insert testAttachment;
        return testAttachment;        
    }
    
    public static Attachment CreateTestAttachment(id parentId) {
        return CreateTestAttachment(parentId, 'test attachment', 'Unit Test Attachment Body' );
    }
    
    public static Task CreateTestTask(id parentId) {
        Task testTask = new Task(WhatId = parentId, Subject = 'test attachment' , status = 'Completed');
        insert testTask;
        return testTask;        
    }
    
    // Test method for Creating Related Tickets
    static TestMethod void testRelated_Ticket() 
    {
        Test.startTest();
        Case testCase1 = CreateTestCase(CreateTestContact(CreateTestAccount()));
        Case testCase2 = CreateTestCase(CreateTestContact(CreateTestAccount()));
        Related_Ticket__c RT = new Related_Ticket__c(Ticket_From__c=CreateTestTicket(testCase1).Id,
                                                     Ticket_To__c=CreateTestTicket(testCase2).Id);
        insert RT; 
        Test.stopTest();    
    }


    // Test method for CreateTicket extension class
    static TestMethod void testExtCreateTicket()
    {
        Test.startTest();
        Case testCase = CreateTestCase(CreateTestContact(CreateTestAccount()));
        PageReference pg = new PageReference(Page.CreateTicket+ '?id=' + testCase.Id);
        Test.setCurrentPage(pg);
        ExtCreateTicket myExt = new ExtCreateTicket(new ApexPages.StandardController(testCase));
        myExt.TicketPlaceholder.GLOBAL_Service__c = 'CCC - Payroll';
        myExt.CreateTicket();
        // Test payment flow
        myExt.TicketPlaceholder.GLOBAL_Service__c = 'Payment';
        myExt.CreateTicket();
        myExt.Cancel();
        Test.stopTest();  
    }

}