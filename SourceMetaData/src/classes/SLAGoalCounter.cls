/*------------------------------------------------------------
Author:        Matt Urbanowski
Company:       Arcus Global Ltd
Date:          04/07/2013
Description:   Scheduled batch apex to perform a count for SLA days on goals
Test Class:    SLATestClass

Added by: 	   Ana Lomibao, October 2013
               Error handling: send email if there are any failure on the batch job
               Error handling: send email if there are any errors on the record updates
------------------------------------------------------------*/

global class SLAGoalCounter implements Database.Batchable<sObject>, Schedulable{

   private Boolean yesterdayWorkingDay;
   private Boolean yesterdayCalendarDay;
   private String SOQLGetGoals = 'Select Id, CaseNumber, Status, Calendar_Days_Elapsed__c, ' + 
                                 'Working_Days_Elapsed__c, Continuous_Working_Days_on_Hold__c from Case ' +
                                 'Where Status != \'Closed\' And ' +
                                       'Status != \'Draft\' ';
   
   // method implemented from Schedulable interface
   global void execute(SchedulableContext sc){
      Database.executebatch(this); 
   }

   global Database.QueryLocator start(Database.BatchableContext BC){
      Return Database.getQueryLocator(SOQLGetGoals); 
   }

   global void execute(Database.BatchableContext BC, List<Case> scope)
   {
       yesterdayWorkingDay = SLAFunctions.YesterdayWorkingDay(); 
       yesterdayCalendarDay = SLAFunctions.YesterdayCalendarDay(); 
       // Update tickets in batches
       for (Case myGoal : scope) {
          // Calendar Days
          if (yesterdayCalendarDay) {
              System.Debug('Add SLA calendar day to goal: ' + myGoal.CaseNumber);
              myGoal.Calendar_Days_Elapsed__c = SLAFunctions.Add1Day(myGoal.Calendar_Days_Elapsed__c);
          }
          // Working Days
          if (yesterdayWorkingDay) {
              if (myGoal.Status != 'On Hold') {    
                  System.Debug('Add SLA working day to goal: ' + myGoal.CaseNumber);
                  myGoal.Working_Days_Elapsed__c = SLAFunctions.Add1Day(myGoal.Working_Days_Elapsed__c); 
              } else {
                  System.Debug('Add SLA on hold day to goal: ' + myGoal.CaseNumber);
                  myGoal.Continuous_Working_Days_on_Hold__c = SLAFunctions.Add1Day(myGoal.Continuous_Working_Days_on_Hold__c);
              }
          }
       }
       
       List<Database.Saveresult> saveResults= Database.Update(scope, false);
       sendEmailWithUpdateErrors(BC, saveResults);
   }
   
   private void sendEmailWithUpdateErrors(Database.BatchableContext BC, List<Database.Saveresult> saveResults)
   {
   		// check for any errors in the list of updates
		String recIds= '';
		for (Database.Saveresult sr: saveResults)
		{
			if (!sr.isSuccess())
				recIds+= '; '+ sr.getId() + ' - ' + sr.getErrors();
		}
		if (recIds.length() > 0)
		{
			// error in some of the record updates
	   		AsyncApexJob a= [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,	TotalJobItems, JobType, CreatedBy.Email
							  FROM AsyncApexJob WHERE Id = :BC.getJobId()];
			Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
			String[] toAddresses = new String[] {a.CreatedBy.Email};
			mail.setToAddresses(toAddresses);
			mail.setSubject('SLAGoalCounter batch with Id= ' + BC.getJobId() + ' has errors updating tickets');			
			mail.setPlainTextBody(recIds);
			Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 		
		}
   }

   global void finish(Database.BatchableContext BC)
   {
		AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,	TotalJobItems, CreatedBy.Email
						  FROM AsyncApexJob WHERE Id = :BC.getJobId()];
		
		// Send an email to the Apex job's submitter if the batch job has failed
		if (a.Status.compareTo('Failed') == 0)
		{
			Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
			String[] toAddresses = new String[] {a.CreatedBy.Email};
			mail.setToAddresses(toAddresses);
			mail.setSubject('SLAGoalCounter batch job ' + a.Status);
			mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems + ' batches with '+ a.NumberOfErrors + ' failures.');
			Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
		}  	
	}
	
}