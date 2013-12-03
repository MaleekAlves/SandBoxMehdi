/*------------------------------------------------------------
Author:        Matt Urbanowski
Company:       Arcus Global Ltd
Date:          26/07/2013
Description:   Takes the value in SLA picklist and assigns it the relevant lookup value from the SLA object.
Test Class:    SLATestClass
------------------------------------------------------------*/
public class trigger_Case_SLA {

    public trigger_Case_SLA(Case[] newCases) {
        // SOQL ------
        // Get list of all SLA lookups
        List<SLA__c> SLAs = [Select Id, Name, Description__c, Working_Days__c, Escalation_Prior_to_SLA_Breach_Days__c, SLA_Length_Days__c  from SLA__c];
        // Get list of upcoming Holidays, then add all holiday dates to a set of dates
        Set<Date> upcomingHolidayDates = UtilityDateMethods.GetUpcomingHolidayDates();
        // ---- End of SOQL
        
        Integer noOfDaysToBreach;
        Integer noOfDaysToEsc;

        for (Case myCase : newCases) {
            Integer MatchingSLAs = 0;
            if (myCase.Active_SLA__c == null) {  // Blank SLA
                myCase.Case_Expected_Breach_Date__c = null;
                myCase.Case_Expected_Escalation_Date__c = null;
                myCase.SLA__c = null;
                MatchingSLAs++;
            } else {
                for (SLA__c mySLA : SLAs) // Find relevant SLA from lookup table and apply
                    if (myCase.Active_SLA__c == mySLA.Name) {
                        MatchingSLAs++;
                        myCase.SLA__c = mySLA.Id;
                                                            
                        // Now that an SLA has been matched need to update the expected escalation data nad expected breach date fields on the object.
                        // Note that when calculating this it is NOT SAFE to use the myCase.SLA_Days_Remaining__c field as it is a formula field and will not have updated yet as a result of SLA change (before trigger preeceds it)
                        // Fields to use
                            //Case: Status,Opened_Date__c, Calendar_Days_Elapsed__c, Working_Days_Elapsed__c
                            //SLA: Working_Days__c, Escalation_Prior_to_SLA_Breach_Days__c,SLA_Length_Days__c
                        // Use these to calcualte the days of SLA that are left (and days left before escalation is required) and pass these to CalcEscOrBreachDate helper method. 
                        
                        noOfDaysToBreach = UtilityDateMethods.GetNoDaysTillBreach( mySLA, (Integer)myCase.Working_Days_Elapsed__c, (Integer)myCase.Calendar_Days_Elapsed__c);
                        noOfDaysToEsc = UtilityDateMethods.GetNoDaysTillEsc(mySLA, (Integer)myCase.Working_Days_Elapsed__c, (Integer)myCase.Calendar_Days_Elapsed__c);
                                                
                        // Pass params to the funtion to set expected esc and breach dates
                        myCase.Case_Expected_Breach_Date__c = UtilityDateMethods.forecastFutureEventDate(myCase.Opened_Date__c, noOfDaysToBreach , mySLA.Working_Days__c, upcomingHolidayDates);
                        myCase.Case_Expected_Escalation_Date__c = UtilityDateMethods.forecastFutureEventDate(myCase.Opened_Date__c, noOfDaysToEsc , mySLA.Working_Days__c, upcomingHolidayDates);
                    }
                         
                 	// If Status is On-hold need to set these fields blank
                    if(myCase.Status == 'On Hold')
                    {
                        myCase.Case_Expected_Breach_Date__c = null;
                        myCase.Case_Expected_Escalation_Date__c = null;
                    }
                }
            // Display error message if invalid match on SLA
            if (MatchingSLAs == 0)
                myCase.addError(' SLA \'' + myCase.Active_SLA__c + '\' not found. Please either select another SLA, no SLA, or contact the system administrator.');
            if (MatchingSLAs > 1)
                myCase.addError(' Multiple SLAs matched on \'' + myCase.Active_SLA__c + '\'. Please either select another SLA, no SLA, or contact the system administrator.');
        }
    }  
}