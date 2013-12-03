/*------------------------------------------------------------
Author:        Matt Urbanowski
Company:       Arcus Global Ltd
Date:          26/07/2013
Description:   Main case trigger to handle all sub-classes.
               Triggers are handled in sub-classes so processing can be done in specific orders.
Test Class:    SLATestClass,TestClass
Added by: 	   Ana Lomibao, October 2013
			   Added Context variable for the trigger.
			   Removed sub-classes and added classes that implements the TicketWorkFlow interface
				
------------------------------------------------------------*/
trigger trigger_Case on Case (before insert, before update, after update) 
{
	if (ContextHelper.CASE_TRIGGER_FIRST_CALL)
	{
	    // Handle before triggers
	    if (Trigger.isBefore) 
	    {
	        // Handle insert & update triggers
	        if(Trigger.isInsert || Trigger.isUpdate)
	        {
	            trigger_Case_SLA process = new trigger_Case_SLA (Trigger.new);
	        }
	    }else if (Trigger.isAfter) 
	    {
	        // Handle update triggers
			if (Trigger.isUpdate && Trigger.isUpdate)
			{
		    	List<TicketWorkFlow> wfs= new List<TicketWorkFlow>
		    		{ 
		    			new UpdateTicketContacts()
		    		};
				
				// get cases that have relevant changes for the workflow
				List<Id> caseIds= new List<Id>();
				for (Case c: Trigger.newMap.values())
				{
					if (c.ContactId != Trigger.oldMap.get(c.Id).ContactId || c.REP_Customer_Representative__c != Trigger.oldMap.get(c.Id).REP_Customer_Representative__c)
					{
						caseIds.add(c.Id);
					}
				}
				
				// get list of tickets related to the case
				Map<Id, Ticket__c> tickets= new Map<Id, Ticket__c>(); 
				tickets.putAll([Select Id, GLOBAL_Representative__c, GLOBAL_Customer__c, GLOBAL_Goal__c, GLOBAL_Goal__r.REP_Customer_Representative__c, GLOBAL_Goal__r.ContactId 
					From Ticket__c Where GLOBAL_Goal__c In :caseIds]);
				
				// set applicable tickets	
				for (TicketWorkFlow wf: wfs)
				{
					wf.setApplicableTickets(null, tickets, null, null);
				}
				
				// apply workflows
				for (TicketWorkFlow wf: wfs)
				{
					wf.applyWFToTickets();
				}				
			}
        	ContextHelper.CASE_TRIGGER_FIRST_CALL= false;
	    }
	}
}