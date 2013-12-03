/*------------------------------------------------------------
Author:        Matt Urbanowski
Company:       Arcus Global Ltd
Date:          04/07/2013
Description:   Scheduled batch apex to perform a count for SLA days on tickets
Test Class:    SLATestClass

Added by: 	   Ana Lomibao, October 2013
               Error handling: send email if there are any failure on the batch job
               Error handling: send email if there are any errors on the record updates
------------------------------------------------------------*/

global class SLATicketCounter implements Database.Batchable<sObject>, Schedulable{

   private Boolean yesterdayWorkingDay;
   private Boolean yesterdayCalendarDay;
   private String SOQLGetTickets = 'Select Id, Name, GLOBAL_Ticket_Status__c, GLOBAL_Calendar_Days_Elapsed__c, ' + 
                                   'GLOBAL_Working_Days_Elapsed__c, GLOBAL_Continuous_Working_Days_On_Hold__c from Ticket__c ' +
                                   'Where GLOBAL_Ticket_Status__c != \'Closed\' And ' +
                                         'GLOBAL_Ticket_Status__c != \'Draft\' ';

   global void execute(SchedulableContext sc){
      Database.executebatch(this); 
   }

   global Database.QueryLocator start(Database.BatchableContext BC){
      Return Database.getQueryLocator(SOQLGetTickets); 
   }

   global void execute(Database.BatchableContext BC, List<Ticket__c> scope){
       yesterdayWorkingDay = SLAFunctions.YesterdayWorkingDay();
       yesterdayCalendarDay = SLAFunctions.YesterdayCalendarDay();
       // Update tickets in batches
       for (Ticket__c myTicket : scope) {
          // Calendar Days
          if (yesterdayCalendarDay) {
              System.Debug('Add SLA calendar day to ticket: ' + myTicket.Name);
              myTicket.GLOBAL_Calendar_Days_Elapsed__c = SLAFunctions.Add1Day(myTicket.GLOBAL_Calendar_Days_Elapsed__c);
          }
          // Working Days
          if (yesterdayWorkingDay) {
              if (myTicket.GLOBAL_Ticket_Status__c != 'On Hold') {    
                  System.Debug('Add SLA working day to ticket: ' + myTicket.Name);
                  myTicket.GLOBAL_Working_Days_Elapsed__c = SLAFunctions.Add1Day(myTicket.GLOBAL_Working_Days_Elapsed__c); 
              } else {
                  System.Debug('Add SLA on hold day to ticket: ' + myTicket.Name);
                  myTicket.GLOBAL_Continuous_Working_Days_On_Hold__c  = SLAFunctions.Add1Day(myTicket.GLOBAL_Continuous_Working_Days_On_Hold__c);
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
			mail.setSubject('SLATicketCounter batch with Id= ' + BC.getJobId() + ' has errors updating tickets');			
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
			mail.setSubject('SLATicketCounter batch job ' + a.Status);
			mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems + ' batches with '+ a.NumberOfErrors + ' failures.');
			Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
		}   	
   }
}