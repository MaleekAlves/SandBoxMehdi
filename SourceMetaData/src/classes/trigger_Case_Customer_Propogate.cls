/**
 * TODO (ANA): THIS CLASS IS TO BE DELETED, NO LONGER IN USE, HAS BEEN REFACTORED TO ANOTHER CLASS
 **/
/*------------------------------------------------------------
Author:        Douglas Guthrie
Company:       Arcus Global Ltd
Date:          31/07/2013
Description:   When a ticket is saved set the Customer and Representative
               Lookup fields equal to the goal lookups.     
Test Class:    TestClass
------------------------------------------------------------*/

public class trigger_Case_Customer_Propogate {
	
	/**    
    public trigger_Case_Customer_Propogate(Case myCase){
        System.debug('***** trigger_Case_Customer_Propogate'); 
        // get all the tickets that have that case as a parent
        System.debug(myCase);
        System.debug(myCase.id);
        
        List<Ticket__c> tickets = [SELECT Id, Name, GLOBAL_Customer__c, GLOBAL_Representative__c, GLOBAL_Goal__c FROM Ticket__c WHERE GLOBAL_Goal__c  =: myCase.id ];
        System.debug(tickets);
        
        //loop over the list of tickets and update each ticket record
        for (Integer i = 0; i < tickets.size(); i++) {
            tickets[i].GLOBAL_Representative__c = myCase.REP_Customer_Representative__c   ;
            tickets[i].GLOBAL_Customer__c = myCase.ContactId ;
        }
        
        System.debug(tickets);
        // update the database
        update tickets;
    } 
    */
}