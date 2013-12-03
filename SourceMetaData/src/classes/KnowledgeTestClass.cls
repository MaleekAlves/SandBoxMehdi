/*------------------------------------------------------------
Author:        Matt Urbanowski
Company:       Arcus Global Ltd
Date:          22/07/2013
Description:   Class containing all test classes related to the knowledge sidebar
Test Class:    KnowledgeTestClass
------------------------------------------------------------*/
@isTest
public class KnowledgeTestClass {

    // Test method for KnowledgeConsole extension class
    static TestMethod void testExtKnowledgeConsole() 
    {
        Test.startTest();
        Case testCase = TestClass.CreateTestCase(TestClass.CreateTestContact(TestClass.CreateTestAccount()));  
        PageReference pg = new PageReference(Page.KnowledgeConsole + '?id=' + testCase.Id);
        Test.setCurrentPage(pg);
        ExtKnowledgeConsole myExt = new ExtKnowledgeConsole();
        // Test suggested search is returned if of type case
        System.Assert(myExt.searchString!='');           
        // Test suggested search is returned if of type ticket
        pg = new PageReference(Page.KnowledgeConsole + '?id=' + TestClass.CreateTestTicket(testCase).Id);
        Test.setCurrentPage(pg);        
        System.Assert(myExt.searchString!='');   
        
        // Test buttons 
        myExt.Search();
        myExt.Previous();
        myExt.getPrevRequired();
        myExt.Next();
        myExt.getNextRequired();
        myExt.btnReturn();  
        myExt.AssociateArticleCase();
        myExt.ShowAll();
        
        Test.stopTest();
    }

}