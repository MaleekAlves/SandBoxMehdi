/*------------------------------------------------------------
Author:        Matt Urbanowski
Company:       Arcus Global Ltd
Date:          26/07/2013
Description:   Takes the value in SLA picklist and assigns it the relevant lookup value from the SLA object.
Test Class:    SLATestClass
------------------------------------------------------------*/
public class trigger_Ticket_SLA {
    
    public trigger_Ticket_SLA(Ticket__c[] newTickets) {
        
        // SOQL ------
        // Get list of all SLA lookups
        List<SLA__c> SLAs = [Select Id, Name, Description__c, Working_Days__c, Escalation_Prior_to_SLA_Breach_Days__c, SLA_Length_Days__c from SLA__c where Active__c=true];
        // Get list of upcoming Holidays, then add all holiday dates to a set of dates
        Set<Date> upcomingHolidayDates = UtilityDateMethods.GetUpcomingHolidayDates();
        // ---- End of SOQL
        
        Integer noOfDaysToBreach;
        Integer noOfDaysToEsc;
        
        for (Ticket__c myTicket : newTickets) 
        {
    		system.debug('******************* trigger_Ticket_SLA, myTicket.GLOBAL_Ticket_Status__c= ' + myTicket.GLOBAL_Ticket_Status__c);
            Integer MatchingSLAs = 0;
            
            if (myTicket.GLOBAL_Active_SLA__c == null) 
            {  
            	// Blank SLA
                myTicket.GLOBAL_Ticket_Expected_Breach_Date__c = null;
                myTicket.GLOBAL_Ticket_Expected_Escalation_Date__c = null;
                myTicket.GLOBAL_SLA__c = null;
                MatchingSLAs++;
            } else 
            {
                for (SLA__c mySLA : SLAs) // Find relevant SLA from lookup table and apply
                    if (myTicket.GLOBAL_Active_SLA__c == mySLA.Name) 
                    {
                        MatchingSLAs++;
                        myTicket.GLOBAL_SLA__c = mySLA.Id;
                        
                        // Now that an SLA has been matched need to update the expected escalation data and expected breach date fields on the object.
                        // Note that when calculating this it is NOT SAFE to use the myCase.SLA_Days_Remaining__c field as it is a formula field and will not have updated yet as a result of SLA change (before trigger preeceds it)
                        // Fields to use:
                        //Ticket: GLOBAL_Ticket_Status__c, GLOBAL_Opened_Date__c, GLOBAL_Calendar_Days_Elapsed__c, GLOBAL_Working_Days_Elapsed__c
                        //SLA: Working_Days__c, Escalation_Prior_to_SLA_Breach_Days__c,SLA_Length_Days__c
                        // Use these to calcualte the days of SLA that are left (and days left before escalation is required) and pass these to CalcEscOrBreachDate helper method. 
                        
                        noOfDaysToBreach = UtilityDateMethods.GetNoDaysTillBreach( mySLA, (Integer)myTicket.Global_Working_Days_Elapsed__c, (Integer)myTicket.GLOBAL_Calendar_Days_Elapsed__c);
                        noOfDaysToEsc = UtilityDateMethods.GetNoDaysTillEsc(mySLA, (Integer)myTicket.Global_Working_Days_Elapsed__c, (Integer)myTicket.GLOBAL_Calendar_Days_Elapsed__c);
                        
                        // Pass params to the funtion to set expected esc and breach dates
                        myTicket.Global_Ticket_Expected_Breach_Date__c = UtilityDateMethods.forecastFutureEventDate(myTicket.GLOBAL_Opened_Date__c, noOfDaysToBreach , mySLA.Working_Days__c, upcomingHolidayDates);
                        myTicket.Global_Ticket_Expected_Escalation_Date__c = UtilityDateMethods.forecastFutureEventDate(myTicket.GLOBAL_Opened_Date__c, noOfDaysToEsc , mySLA.Working_Days__c, upcomingHolidayDates);
                        system.debug('************************** myTicket.Global_Ticket_Expected_Breach_Date__c= ' + myTicket.Global_Ticket_Expected_Breach_Date__c);
                    }
                // If Status is On-hold need to set these fields blank
                if(myTicket.GLOBAL_Ticket_Status__c == 'On Hold')
                {
                    myTicket.GLOBAL_Ticket_Expected_Breach_Date__c = null;
                    myTicket.GLOBAL_Ticket_Expected_Escalation_Date__c = null;
                }
                // else if the ticket is closed set the feedback cutoff date to 3 working days after the closed date
                // TODO do this just for ICT related tickets? 
                // TODO Not hardcode in the 3 working days element here. 
                else if (myTicket.GLOBAL_Ticket_Status__c == 'Closed' )
                {
	                system.debug('******* setting myTicket.GLOBAL_Ticket_Status__c');
                    myTicket.GLOBAL_Feedback_Cutoff_Date__c  = UtilityDateMethods.forecastFutureEventDate(myTicket.GLOBAL_Closed_Date__c, 3 , true, upcomingHolidayDates);
                    system.debug('********** check this ' + myTicket.GLOBAL_Feedback_Cutoff_Date__c);
                }
            }
            
            // Display error message if invalid match on SLA
            if (MatchingSLAs == 0)
                myTicket.addError(' SLA \'' + myTicket.GLOBAL_Active_SLA__c + '\' not found. Please either select another SLA, no SLA, or contact the system administrator.');
            if (MatchingSLAs > 1)
                myTicket.addError(' Multiple SLAs matched on \'' + myTicket.GLOBAL_Active_SLA__c + '\'. Please either select another SLA, no SLA, or contact the system administrator.');
        }
    }
}