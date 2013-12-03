/*------------------------------------------------------------
Author:        Matt Urbanowski
Company:       Arcus Global Ltd
Date:          09/07/2013
Description:   Takes the value in SLA picklist and assigns it the relevant lookup value from the SLA object.
Test Class:    SLATestClass
------------------------------------------------------------*/

trigger updateTicket on Ticket__c (before insert, before update) {
    // Get list of all SLA lookups
    List<SLA__c> SLAs = [Select Id, Name, Description__c from SLA__c];

    for (Ticket__c myTicket : Trigger.new) {
        Integer MatchingSLAs = 0;
        
        if (myTicket.GLOBAL_Active_SLA__c == null) {  // Blank SLA
            myTicket.GLOBAL_SLA__c = null;
            MatchingSLAs++;
        } else {
            for (SLA__c mySLA : SLAs) // Find relevant SLA from lookup table and apply
                if (myTicket.GLOBAL_Active_SLA__c == mySLA.Name) {
                    MatchingSLAs++;
                    myTicket.GLOBAL_SLA__c = mySLA.Id;
                }
        }
        // Display error message if invalid match on SLA
        if (MatchingSLAs == 0)
            myTicket.addError(' SLA \'' + myTicket.GLOBAL_Active_SLA__c + '\' not found. Please either select another SLA, no SLA, or contact the system administrator.');
        if (MatchingSLAs > 1)
            myTicket.addError(' Multiple SLAs matched on \'' + myTicket.GLOBAL_Active_SLA__c + '\'. Please either select another SLA, no SLA, or contact the system administrator.');

    }


}