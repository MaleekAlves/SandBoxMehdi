/*------------------------------------------------------------
Author:        Matt Urbanowski
Company:       Arcus Global Ltd
Date:          26/07/2013
Description:   Main ticket trigger to handle all sub-classes
               Triggers are handled in sub-classes so processing can be done in specific orders.
Test Class:    SLATestClass,TestClass

Refactored by: Ana Lomibao, September 2013. 
               Added a context variable to execute this trigger just once, custom WFs were causing this trigger to be called more than once within the same
               context.
               Created a framework to implement functionalities after update and insert tickets - implement TicketWorkFlow interface in and outer class
               and create and instance of it in the trigger
Test Class:    InboundTicketEmailHandler_Test.cls			                                  
------------------------------------------------------------*/
trigger trigger_Ticket on Ticket__c (before insert, before update, after insert, after update) 
{
	system.debug('******************** ContextHelper.TICKET_TRIGGER_FIRST_CALL= ' + ContextHelper.TICKET_TRIGGER_FIRST_CALL);
	if (ContextHelper.TICKET_TRIGGER_FIRST_CALL)
	{
		
	    // Handle before triggers
	    if (Trigger.isBefore) 
	    {
	        // Handle insert & update triggers
	        if(Trigger.isInsert || Trigger.isUpdate)
	        {
	        	SetOpenedDate setOpened= new SetOpenedDate(); 
	        	setOpened.setOpenedDatToTickets(Trigger.old, Trigger.new);
	            trigger_Ticket_SLA process = new trigger_Ticket_SLA(Trigger.new);
	            trigger_Ticket_EscEmail process2 = new trigger_Ticket_EscEmail(Trigger.new);
	            trigger_Ticket_Confirm process3 = new trigger_Ticket_Confirm(Trigger.new);
	            trigger_Ticket_Customer_Lookup process4 = new trigger_Ticket_Customer_Lookup(Trigger.new);
	        }
	    }else if (Trigger.isAfter && (Trigger.isUpdate || Trigger.isInsert)) 
	    {
	    	List<TicketWorkFlow> wfs= new List<TicketWorkFlow>
	    		{ 
	    			new EmailUserOnClosedTicket(), 
	    			new EmailUserOnOpenedTicket()
	    		};
	    	
			// Get tickets that are applicable to the workflows
			for (TicketWorkFlow wf: wfs)
			{
				if (Trigger.isInsert)				
					wf.setApplicableTickets(null, Trigger.newMap, Trigger.isUpdate, Trigger.isInsert);
				else if (Trigger.isUpdate)
					wf.setApplicableTickets(Trigger.oldMap, Trigger.newMap, Trigger.isUpdate, Trigger.isInsert);
			}
							
	    	// Apply all workflows to the tickets
	    	for (TicketWorkFlow wf: wfs)
	    	{
	    		wf.applyWFToTickets();
	    	}
	    	
			ContextHelper.TICKET_TRIGGER_FIRST_CALL= false;
	    }		
	}

}