/*------------------------------------------------------------
Author:        Matt Urbanowski
Company:       Arcus Global Ltd
Date:          09/07/2013
Description:   Class containing all test classes for SLA-related apex and triggers
Test Class:    SLATestClass
------------------------------------------------------------*/
@isTest
public class SLATestClass {

    public static SLA__c CreateTestSLA() {
        SLA__c SLA = new SLA__c(Name = '40 working days TEST', Customer_Acknowledgement_Days__c = 3, Escalation_Prior_to_SLA_Breach_Days__c = 2, SLA_Length_Days__c = 40);
        insert SLA;
        return SLA;
    }

    private static void testCaseUpdateFails(Case myCase) {
        Boolean HasError = false;
        try {
            update myCase;
        } catch (DmlException e) {
            HasError=true;
            system.debug('**************** e.getMessage()= ' + e.getMessage());
        }
        //System.Assert(HasError);
        System.assertEquals(HasError, true);
    }
    
    private static void testTicketUpdateFails(Ticket__c myTicket) {
        Boolean HasError = false;
        try {
            update myTicket;
        } catch (DmlException e) {
            HasError=true;
        }
        System.Assert(HasError);
    }
	
	/**
    static TestMethod void testSLAGoalTicketPicklist() {
        Test.startTest();
        Case testCase = TestClass.CreateTestCase(TestClass.CreateTestContact(TestClass.CreateTestAccount()));
        Ticket__c testTicket = TestClass.CreateTestTicket(testCase);
        SLA__c SLA1 = CreateTestSLA();
        
        // TEST 1 - Test assigning unique valid SLA to case & ticket
        testCase.Active_SLA__c = '40 working days TEST';
        update testCase;
        testTicket.GLOBAL_Active_SLA__c = '40 working days TEST';
        update testTicket;
        
        // TEST 2 - Test assigning non-unique SLA to case
        SLA__c SLA2 = CreateTestSLA();
        testCaseUpdateFails(testCase);
        
        // TEST 3 - Test assigning non-unique SLA to ticket
        testTicketUpdateFails(testTicket);
        
        // TEST 4 - Assigning non-existent SLA to case
        testCase.Active_SLA__c = '80 working days TEST';
        testCaseUpdateFails(testCase);
        
        // TEST 5 - Assigning non-existent SLA to ticket
        testTicket.GLOBAL_Active_SLA__c = '80 working days TEST';
        testTicketUpdateFails(testTicket);
        
        Test.stopTest();
    }
    */

    static TestMethod void testSLATicketCounter() {
        Test.startTest();
        Ticket__c testTicket = TestClass.CreateTestTicket(TestClass.CreateTestCase(TestClass.CreateTestContact(TestClass.CreateTestAccount())));
        testTicket.GLOBAL_Working_Days_Elapsed__c = 1;
        testTicket.GLOBAL_Calendar_Days_Elapsed__c = 1;
        testTicket.GLOBAL_Ticket_Status__c = 'Open';
        update testTicket;
        SLATicketCounter batch = new SLATicketCounter();
        Database.executeBatch(batch);
        Test.stopTest();
    }
    
    static TestMethod void testSLAGoalCounter() {
        Test.startTest();
        Case testCase = TestClass.CreateTestCase(TestClass.CreateTestContact(TestClass.CreateTestAccount()));
        testCase.Working_Days_Elapsed__c = 1;
        testCase.Calendar_Days_Elapsed__c = 1;
        testCase.Status = 'Open';
        update testCase;
        SLAGoalCounter batch = new SLAGoalCounter();
        Database.executeBatch(batch);
        Test.stopTest();
    }

    // Test method for global SLA Functions class
    static TestMethod void testSLAFunctions()
    {
        Test.startTest();
        // Test add days
        Decimal i = 5;
        Decimal RetVal = SLAFunctions.Add1Day(i);
        System.Assert(RetVal == 6);
        
        // Test null day value
        i = null;
        RetVal = SLAFunctions.Add1Day(i);
        System.Assert(RetVal == 1);

        // Test yesterday is working day

        // Insert test holiday
        Holiday h = new Holiday(Name = 'Bank Holiday Monday', ActivityDate = Date.Today()-1);
        insert h;
        
        // Test yesterday is always a calendar day
        System.Assert(SLAFunctions.yesterdayCalendarDay()==true);
        
        // Test working day if yesterday was a holiday
        System.Assert(SLAFunctions.yesterdayWorkingDay()==false);
                
        Test.stopTest(); 
        
         
    }
   

}