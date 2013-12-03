/*------------------------------------------------------------
Author:        Matt Urbanowski
Company:       Arcus Global Ltd
Date:          26/07/2013
Description:   Takes the ticket owner, and if it is a queue, attempt to find a queue which has
               "ESCALATION - " as the prefix and set the escalation email to that address.
Test Class:    TestClass
------------------------------------------------------------*/
public class trigger_Ticket_EscEmail {

    public trigger_Ticket_EscEmail(Ticket__c[] newTickets) {
    
        String Prefix = 'ESC - ';
    
        // Get a list of all queues and create maps
        List<Group> allQueues = [Select Id, Name, Email From Group Where Type = 'Queue'];
        Map<String, String> QueueEmails = new Map<String, String>();
        Map<Id, String> QueueNames = new Map<Id, String>();
        for (Group myQueue : allQueues) {
            QueueEmails.put(myQueue.Name, myQueue.Email);
            QueueNames.put(myQueue.Id, myQueue.Name);
        }

        // For each ticket, find the escalation queue & assign
        for (Ticket__c myTicket : newTickets) {
            myTicket.GLOBAL_Escalation_Email__c = null;
            String OwnerName = QueueNames.get(myTicket.OwnerId);
            System.Debug ('***** Owner Name: ' + OwnerName);
            if (QueueEmails.containsKey(Prefix + OwnerName)) 
                myTicket.GLOBAL_Escalation_Email__c = QueueEmails.get(Prefix + OwnerName);
        }
    
    }

}