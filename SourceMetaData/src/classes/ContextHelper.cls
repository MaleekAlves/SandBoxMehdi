/*------------------------------------------------------------
Author:        Ana Lomibao
Company:       Arcus Global Ltd
Date:          October 2013
Description:   Static class that holds context variables for triggers
Test class:    InboundTicketEmailHandler_Test.cls
------------------------------------------------------------*/
public with sharing class ContextHelper 
{
	public static Boolean TICKET_TRIGGER_FIRST_CALL= true;
	public static Boolean CASE_TRIGGER_FIRST_CALL= true;
}