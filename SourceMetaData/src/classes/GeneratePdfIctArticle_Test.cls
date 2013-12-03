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
@isTest(seeAllData=false)
private class GeneratePdfIctArticle_Test 
{

    static testMethod void GeneratePdfIctArticle() 
    {
    	Test.startTest();
        /*
	    	ICT_Article__c art= TestDataCreator.createIctArticle('art');
	    	art.Article_Content__c= 'Test content .... ';
	    	update art;
	    	
	    	Apexpages.Standardcontroller scon= new Apexpages.Standardcontroller(art);
	    	GeneratePdfICTArticle genPdf= new GeneratePdfICTArticle(scon);
	    	
	    	// generate the pdf
	    	Pagereference pref= genPdf.generatePdf();
		    System.assertNotEquals(pref, null);
	    	
	    	// verify the attachment has been created    	    
	    	List<Attachment> atts= [Select Id, Name From Attachment Where ParentId= :art.Id];
	    	System.assertNotEquals(atts.size(), 0);
	    	System.assertEquals(atts[0].Name, art.Article_Name__c + '_Current.pdf');
*/
	    Test.stopTest();
    }
    
    static testMethod void TestCreationOfNextVersionICTArticle() 
    {
    	Test.startTest();
        
        	
	    	ICT_Article__c art= TestDataCreator.createIctArticle('art');
	    	art.Article_Content__c= 'Test content .... ';
	    	update art;
	    	
        	//Attachment att1 = TestClass.CreateTestAttachment(art.Id);
        	
        	
        	//Attachment att2 = TestClass.CreateTestAttachment(art.Id);
        	
        /*
        
	    	Apexpages.Standardcontroller scon= new Apexpages.Standardcontroller(art);
	    	GeneratePdfICTArticle genPdf= new GeneratePdfICTArticle(scon);
	    	
	    	// generate the pdf
	    	Pagereference pref= genPdf.generatePdf();
		    System.assertNotEquals(pref, null);
	    	
	    	// verify the attachment has been created    	    
	    	List<Attachment> atts= [Select Id, Name From Attachment Where ParentId= :art.Id];
	    	System.assertNotEquals(atts.size(), 0);
	    	System.assertEquals(atts[0].Name, art.Article_Name__c + '_Current.pdf');
*/
	    Test.stopTest();
    }
    
}