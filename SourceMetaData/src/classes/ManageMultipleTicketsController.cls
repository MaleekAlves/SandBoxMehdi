public class ManageMultipleTicketsController {

    public List<TicketWrapper > ticketList{ get; set; }
    public final Ticket__c myTicket { get; set; }
    private ApexPages.StandardController stdController;
    
    //Mini wrapper class to hold ticket objects and make them selectable
    public class TicketWrapper {
        public Boolean addLink {get;set;}
        public Boolean removeLink {get;set;}
        public Boolean isLinked {get;set;}
        public Ticket__c tkt {get;set;}
        public TicketWrapper (Ticket__c t, Boolean isLinked ){
            this.addLink = false;
            this.removeLink = false;
            this.tkt = t;
            this.isLinked = isLinked;
        }
    }

    public ManageMultipleTicketsController(ApexPages.StandardController controller) {
        this.stdController = controller;
        // can add extra fields with line below if required
        //controller.addFields();
        myTicket = (Ticket__c)controller.getRecord();
        // instantiate the ticket list. 
        ticketList = new List<TicketWrapper >();
        updateTicketList();
    }
    
    private void updateTicketList()
    {
        // Uses 2 SOQL queries to update the ticket list. 
        ticketList.clear();
        // Add all all linked tickets of the same record type
        for(Ticket__c t : [SELECT id,Name,RecordTypeId, GLOBAL_Ticket_Summary__c FROM Ticket__c WHERE (RecordTypeId =: myTicket.RecordTypeId ) AND
                          Id IN (SELECT Ticket_To__c FROM Related_Ticket__c WHERE Ticket_From__c =: myTicket.Id )] ) {
            ticketList.add(new TicketWrapper(t,true) );
        }
        // Add all all unlinked tickets of the same record type
        for(Ticket__c t : [SELECT id,Name,RecordTypeId, GLOBAL_Ticket_Summary__c FROM Ticket__c WHERE (RecordTypeId =: myTicket.RecordTypeId ) AND
                          id NOT IN (SELECT Ticket_To__c FROM Related_Ticket__c WHERE Ticket_From__c =: myTicket.Id )] ) {
            ticketList.add(new TicketWrapper(t,false) );
        }
    }
    public PageReference link(){
        // Link the seleted tickets to the starting ticket. 
        // for each selected ticket in the table
        	// 1. Create a Related_Ticket__c record to link (and create inverse link record)
        // insert list of link records
        List<Related_Ticket__c> linksToCreate = new  List<Related_Ticket__c>();
        for (TicketWrapper tw:ticketList)
        {
            if(tw.addLink){
                Related_Ticket__c rt1 = new Related_Ticket__c();
                rt1.Ticket_From__c = myTicket.id;
                rt1.Ticket_To__c = tw.tkt.id;
                linksToCreate.add(rt1);
                
                Related_Ticket__c rt2 = new Related_Ticket__c();
                rt2.Ticket_To__c = myTicket.id;
                rt2.Ticket_From__c = tw.tkt.id;
                linksToCreate.add(rt2);
            }
        }
        try{
        	insert linksToCreate;
        	updateTicketList();
        }
        catch (DMLException e){
            throw e;
        }  
        return null;
    }
    public PageReference unlink(){
        // unlink the seleted tickets to the starting ticket. 
        // for each selected ticket in the table to be unlinked
        	// 1. get the id of the link to delete.
        // insert list of link records
        List<Id> ticketIdsToDeLink = new  List<Id>();
        for (TicketWrapper tw:ticketList)
        {
            if(tw.removeLink)
            {
                ticketIdsToDeLink.add(tw.tkt.id);
            }
        }
        //Get a list of all the related ticket objects between the ticket records that are to be delinked (in both directions)
        List<Related_Ticket__c> relatedTicketsToDelete = [SELECT Id, Name, Ticket_From__c FROM Related_Ticket__c WHERE 
                                                      (Ticket_To__c =: myTicket.Id  AND Ticket_From__c IN :ticketIdsToDeLink) OR
                                                      (Ticket_From__c =: myTicket.Id  AND Ticket_To__c IN :ticketIdsToDeLink) ]; 
        try {
            delete relatedTicketsToDelete;
            updateTicketList();
        } catch (DmlException e) {
            throw e;
        }
    	return null;
    }
}