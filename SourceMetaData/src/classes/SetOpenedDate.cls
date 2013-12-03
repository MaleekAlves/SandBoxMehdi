public with sharing class SetOpenedDate 
{
	public SetOpenedDate()
	{
	}
	
	// This method sets Opened Date to Today when a ticket status' is set to Open
	public void setOpenedDatToTickets(List<Ticket__c> oldTickets, List<Ticket__c> newTickets)
	{
		if (oldTickets == null)
		{
			// inserting new tickets
			for (Ticket__c t: newTickets)
			{
				if (t.GLOBAL_Ticket_Status__c.compareTo('Open') == 0)
					t.GLOBAL_Opened_Date__c= Date.today();
			}
		}else
		{
			// updating tickets
			Map<Id, Ticket__c> oldTicketsMap= new Map<Id, Ticket__c>();
			oldTicketsMap.putAll(oldTickets); 
			for (Ticket__c t: newTickets)
			{
				if (t.GLOBAL_Ticket_Status__c.compareTo('Open') == 0 
					&& oldTicketsMap.get(t.Id) != null && oldTicketsMap.get(t.Id).GLOBAL_Ticket_Status__c.compareTo('Open') != 0)
					t.GLOBAL_Opened_Date__c= Date.today();
			}
		}
	}
	
}