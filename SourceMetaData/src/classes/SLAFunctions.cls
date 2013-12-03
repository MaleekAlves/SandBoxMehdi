/*------------------------------------------------------------
Author:        Matt Urbanowski
Company:       Arcus Global Ltd
Date:          04/07/2013
Description:   Global Static Functions used by SLA Counter batch scheduled classes
               Contains functions such as calculating whether yesterday was a working day or not.
Test Class:    SLATestClass
------------------------------------------------------------*/
global class SLAFunctions {

 public static Boolean YesterdayWorkingDay(Date Yesterday) {
       // What day was yesterday?
       String DayOfWeek = ((datetime)Yesterday).format('EEE');
       System.debug('Day of week for yesterday: ' + DayOfWeek);
       
       // If yesterday was not a holiday
       if ([Select Id From Holiday Where ActivityDate =: Yesterday ].size() == 0) {
           // If yesterday was not the weekend
           if (DayOfWeek != 'Sat' && DayOfWeek != 'Sun') {
               System.debug('Yesterday was normal working day');
               Return true;
           } else {
               System.debug('Yesterday was the weekend');
               Return false;
           }
       } else {
           System.debug('Yesterday was a holiday');
           Return false;
       }
   }
   
   public static Boolean YesterdayWorkingDay() {
       // Overridden method to pass in yesterday date automatically
       Return YesterdayWorkingDay(Date.Today()-1);
   }

   public static Boolean YesterdayCalendarDay() {
       Return true;
   }
   
   // Add 1 to value, or return 1 if null value
   public static Decimal Add1Day(Decimal Value) {
       if (Value==null)
           Return 1;
       else
           Return Value + 1;
   }

}