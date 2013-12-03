/**
 * Interface to implement when creating a new ticket workflow
 **/
public interface TicketWorkFlow 
{
	/**
	 * implement this method to check whether the tickets are applicable to the interface
	 **/
	void setApplicableTickets(Map<Id, Ticket__c> oldTickets, Map<Id, Ticket__c> newTickets, Boolean isUpdate, Boolean isInsert);
		
	/**
	 * implement this method to execute the WF 
	 **/	
	void applyWFToTickets();
}