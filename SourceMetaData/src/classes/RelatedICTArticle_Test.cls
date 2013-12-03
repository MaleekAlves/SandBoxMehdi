/*------------------------------------------------------------
Author:        Ana Lomibao
Company:       Arcus Global Ltd
Date:          October 2013
------------------------------------------------------------*/
/*
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
private class RelatedICTArticle_Test {

    static testMethod void relatedICTArticleTest() 
    {
        // Create test data
        ICT_Article__c art0= TestDataCreator.createIctArticle('art0');
        
        // Create all related articles to art0
        ICT_Article__c art1= TestDataCreator.createIctArticle('art1');
        art1.related_To__c= art0.Id;
        update art1;
        
        ICT_Article__c art2= TestDataCreator.createIctArticle('art2');
        art2.related_To__c= art1.Id;
        update art2;
        
        ICT_Article__c art3= TestDataCreator.createIctArticle('art3');
        art3.related_To__c= art2.Id;
        update art3;
        
        ICT_Article__c art4= TestDataCreator.createIctArticle('art4');
        art4.related_To__c= art2.Id;
        update art4;
        
        ICT_Article__c art5= TestDataCreator.createIctArticle('art5');
        art5.related_To__c= art4.Id;
        update art5;
        
        ICT_Article__c art6= TestDataCreator.createIctArticle('art6');
        art6.related_To__c= art5.Id;
        update art6;
        
        ICT_Article__c art7= TestDataCreator.createIctArticle('art7');
        art7.related_To__c= art5.Id;
        update art7;
        
        // Vefiry that all of the articles are related to art0
        RelatedICTArticle controller= new RelatedICTArticle(new Apexpages.Standardcontroller(art0)); 
        System.assertEquals(controller.ictArticles.size(), 8);
    }
}