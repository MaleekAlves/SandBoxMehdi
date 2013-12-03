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
private class ConfirmTicketControllerExtension_Test 
{

    static testMethod void testConfirmTicketSubmit() 
    {
    	// Set the current page
        Pagereference pageRef= Page.TicketConfirmSubmit;
        Test.setCurrentPage(pageRef);
        //Apexpages.Standardcontroller scon= new Apexpages.Standardcontroller();
        // Create extension controller
        //ConfirmTicketControllerExtension cont= new ConfirmTicketControllerExtension();
        
        Map<String, String> params= pageRef.getParameters();
        
        // create test data
        Case c= new Case(
        	Subject= 'Test Subject',
        	Status= 'Open',
        	Popular_Goals__c= 'Highways'
        	);
        insert c;
        
        Ticket__c t= new Ticket__c(
        	GLOBAL_Goal__c= c.Id,
        	GLOBAL_Service_Group__c= 'Chief Executive',
        	GLOBAL_Service__c= 'Human Resources'
        	);
        insert t;
        	
        // add parameters to the VF page	
        params.put('Id', t.Id);
        
        // set the current page to execute the extension class
        Test.setCurrentPage(pageRef);
        
        
        
    }
}