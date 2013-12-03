/*------------------------------------------------------------
Author:        Douglas Guthrie
Company:       Arcus Global Ltd
Date:          20/06/2013
Description:    Trigger to create the a record within the Related_Ticket__c 
                object that is a clone of the record that the user has just 
                created but the with the ids in the the two lookup files transposed.
                Hence if Tickat a -> Relates To -> Ticket b
                Then this trigger says: Tickat b -> Relates To -> Ticket a
                
Test Class:    NOT YET CREATED
------------------------------------------------------------*/

trigger MaintainReverseTicketLink on Related_Ticket__c (after insert, after delete) {
    // ? SHOULD editing be allowed of the links, currently this trigger assumes that 
    // they are only created or deleted. TODO

    /*
    Function (most simple)
    1> Get ther record targetted by the trigger, shallow clone it -> revLinkObj
    2> Shape the relationship fields of revLinkObj
    3> Insert revLinkObj
    */
    
    System.debug('START CreateReverseTicketLink Trigger');
    if (Trigger.isInsert)
    {
        try{
            System.debug('INSERT BRANCH');
            // Get the new record - SHOULD confirm only one entry in list! TODO
            System.debug('Trigger.new');
            System.debug(Trigger.new);
            System.debug(Trigger.new[0]);
            Related_Ticket__c newLinkObj = Trigger.new[0];
            Related_Ticket__c revLinkObj = newLinkObj.clone();
            // New set the relationship filed of the revLinkObj to be opposite of newObj TODO
            revLinkObj.Ticket_From__c = newLinkObj.Ticket_To__c;
            revLinkObj.Ticket_To__c = newLinkObj.Ticket_From__c;
            // Now SHOULD check that an object like RevLinkObject doesnt exist already! TODO
            System.debug(newLinkObj);
            System.debug(revLinkObj);
            System.debug(newLinkObj.Ticket_From__c);
            System.debug(newLinkObj.Ticket_To__c);

            // insert revLinkObj;
        }
        catch(Exception e){
            System.debug('In CreateReverseTicketLink Trigger, Trigger.isInser. Error =' + e.getMessage());
        }
    }
    
    // TODO SHOULD have delete method here!
    
    
}