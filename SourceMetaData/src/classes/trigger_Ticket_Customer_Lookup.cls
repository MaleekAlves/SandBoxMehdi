/*------------------------------------------------------------
Author:        Douglas Guthrie
Company:       Arcus Global Ltd
Date:          31/07/2013
Description:   When a ticket is saved set the Customer and Representative
               Lookup fields equal to the goal lookups.     
Test Class:    TestClass
------------------------------------------------------------*/
public class trigger_Ticket_Customer_Lookup{

    
    
    public trigger_Ticket_Customer_Lookup(Ticket__c[] newTickets) 
    {
        // Get a list of the parent case customers and representatives for all tickets passed in
        System.debug('*****trigger_Ticket_Customer_Lookup');  
        
        List<Id> caseIds = new List<id>();
        for (Ticket__c myTicket : newTickets) 
        {
            caseIds.add(myTicket.GLOBAL_Goal__c);
        }
        Map<ID, Case> parentCases = new Map<ID, Case>([SELECT Id, ContactId, REP_Customer_Representative__c From Case Where Id IN : (caseIds)]);
        System.debug(parentCases);  
        
        // For each ticket in trigger set its lookup fields for customer and representatvie to mathc those of its parent case
        for (Ticket__c myTicket : newTickets) 
        {
        	if (parentCases.get(myTicket.GLOBAL_Goal__c) != null)
        	{    
	            myTicket.GLOBAL_Representative__c = parentCases.get(myTicket.GLOBAL_Goal__c).REP_Customer_Representative__c;
	            myTicket.GLOBAL_Customer__c = parentCases.get(myTicket.GLOBAL_Goal__c).ContactId ;
            
	            System.Debug ('***** Representative /  Customer: ');
	            System.Debug (parentCases.get(myTicket.GLOBAL_Goal__c));
	            System.Debug (myTicket.GLOBAL_Representative__c);
	            System.Debug (myTicket.GLOBAL_Customer__c);
        	}
        }

    }
}