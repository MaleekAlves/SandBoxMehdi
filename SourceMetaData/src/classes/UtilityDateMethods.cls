/*------------------------------------------------------------
Author:        Douglas Guthrie
Company:       Arcus Global Ltd
Date:          24/09/2013
Description:   Utility Class with date methods used in particular for SLAs
Test Class:    SLATestClass
------------------------------------------------------------*/
public class UtilityDateMethods {


    public static Integer GetNoDaysTillBreach(SLA__c mySLA, Integer workingDaysElapsed, Integer calendarDaysElapsed) {
        //SLA in working Days
        if(mySLA.Working_Days__c)
        {
            // Working_Days_Elapsed__c shouldnt be null, but test just in case. if it is null treat as if it were zero
            if (workingDaysElapsed == null) return (Integer)(mySLA.SLA_Length_Days__c ) ;
            else return (Integer)(mySLA.SLA_Length_Days__c - workingDaysElapsed) ;
        }
        // SLA in calendar days
        else 
        {
            // Working_Days_Elapsed__c shouldnt be null, but test just in case. if it is null treat as if it were zero
            if (calendarDaysElapsed == null) return (Integer)(mySLA.SLA_Length_Days__c) ;
            else return (Integer)(mySLA.SLA_Length_Days__c - calendarDaysElapsed) ;
        }
    }
    
    public static Integer GetNoDaysTillEsc(SLA__c mySLA, Integer workingDaysElapsed, Integer calendarDaysElapsed) {
        //SLA in working Days
        if(mySLA.Working_Days__c)
        {
            // Working_Days_Elapsed__c shouldnt be null, but test just in case. if it is null treat as if it were zero
            if (workingDaysElapsed == null) return (Integer)(mySLA.SLA_Length_Days__c - mySLA.Escalation_Prior_to_SLA_Breach_Days__c);
            else return (Integer)(mySLA.SLA_Length_Days__c - workingDaysElapsed - mySLA.Escalation_Prior_to_SLA_Breach_Days__c);
        }
        // SLA in calendar days
        else 
        {
            // Working_Days_Elapsed__c shouldnt be null, but test just in case. if it is null treat as if it were zero
            if (calendarDaysElapsed == null) return (Integer)(mySLA.SLA_Length_Days__c - mySLA.Escalation_Prior_to_SLA_Breach_Days__c);
            else return (Integer)(mySLA.SLA_Length_Days__c - calendarDaysElapsed - mySLA.Escalation_Prior_to_SLA_Breach_Days__c);
        }
    }
    
    public static Set<Date> GetUpcomingHolidayDates() {
         // Get list of upcoming Holidays, then add all holiday dates to a set of dates
        List<Holiday> upcomingHolidays = [SELECT ActivityDate FROM Holiday];
        Set<Date> upcomingHolidayDates = new Set<Date>();
        for (Holiday h: upcomingHolidays) {
            upcomingHolidayDates.add(h.ActivityDate);
        }
        return upcomingHolidayDates;
    }
    
    public static Boolean IsWorkingDay(Date dateIn, Set<Date> upcomingHolidayDates) {
        // Helper method for CalcEscOrBreachDate, takes as argumnts the date to test for and a set
        // of upcoming holiday dates. 
        String DayOfWeek = ((datetime)dateIn).format('EEE');
        System.debug('Day of week for Date: ' + DayOfWeek);
         
        // If date was not a holiday
         
       if (!upcomingHolidayDates.contains(dateIn) ) {
           // If Date was not the weekend
           if (DayOfWeek != 'Sat' && DayOfWeek != 'Sun') {
               System.debug('Date was normal working day');
               Return true;
           } else {
               System.debug('Date was the weekend');
               Return false;
           }
       }else {
           System.debug('Date was a holiday');
           Return false;
       }
    }
    
    public static Date forecastFutureEventDate(Date startDate, Integer daysToCountForward, Boolean isWorking, Set<Date> holDates)
    {
    	system.debug('***************** startDate= ' + startDate);
    	system.debug('***************** daysToCountForward= ' + daysToCountForward);
    	system.debug('***************** isWorking= ' + isWorking);
    	system.debug('***************** holDates= ' + holDates);
    	
        // This method will use a set with all holiday dates in the system then iterate forward over the coming days to determine when the an SLA is breached or should be escalated
        // Takes params for the SLA start date, the days left, whether working cays or calandar days are to be used and a Set containg dates of upcoming holidays. 
        // Uses IsWorkingDay helper method
        
        //Initialise counters
        Integer daysLeftCounter = daysToCountForward ;
        Date currentDate = startDate;

        // If the SLA is in working days the returned date must be a working day. acceptableEndDate controls the loop to this effect
        Boolean acceptableEndDate = false;
        
        if (currentDate == null)
        	return null;
        	
        // Keep iterating with there are days left to burn OR the end date is not acceptable
        while (daysLeftCounter>0 ||  !acceptableEndDate ){ 
        	// increment the date
            currentDate += 1;
            
        	//Does the currnt day burn one of the days left?
        	if (  !isWorking || (isWorking && IsWorkingDay(currentDate, holDates) ) )   {
        		// Yes - burn a day and mark date as an acceptable end data
                daysLeftCounter--;
                acceptableEndDate = true;
                System.debug('Day does count');
            }
            else
            {
            	//No - dont burn a day and mark date as not an acceptable end date
                acceptableEndDate = false;
            }
            
            //System.debug('Next day *************');
            //System.debug('Date = ' + currentDate );
            //System.debug('days left counter = '+ daysLeftCounter);
            //System.debug( 'day ok = '+ dayOk);
            //System.debug('daysLeftCounter>0 =' + (daysLeftCounter>0));
            //System.debug('go again = ' + (daysLeftCounter>0 ||  !dayOk ));
            //System.debug(' *************');
        }
        //At end current date will be the date when the SLA will breach/escalate.
        return currentDate;
    }


}