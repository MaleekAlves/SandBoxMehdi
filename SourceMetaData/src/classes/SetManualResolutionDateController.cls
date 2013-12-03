public class SetManualResolutionDateController {

    public Ticket__c myTicket {get; set;}
    private Apexpages.StandardController scon;
    public boolean disableSave {get; set;}

    public SetManualResolutionDateController(ApexPages.StandardController controller) {
        scon = controller;
        scon.addFields(new List<String> {'GLOBAL_SLA__c', 'GLOBAL_Active_SLA__c','CMP_Manual_Resolution_Date_Agreed__c','GLOBAL_Ticket_Status__c' });
        myTicket = (Ticket__c)controller.getRecord();
        // if a manual resolution date has already been agreed it is not allowed to define another. Disable the save button.
        disableSave = false;
        if (myTicket.CMP_Manual_Resolution_Date_Agreed__c){
            disableSave = true;
        }
    }
    
    public PageReference save() {
        //Save Button clicked. Save the record and return to it. 
        myTicket.CMP_Manual_Resolution_Date_Agreed__c = true;
        myTicket.GLOBAL_SLA__c = null;
        myTicket.GLOBAL_Active_SLA__c = null;
        myTicket.GLOBAL_Ticket_Status__c = 'Open';
        
        // try to save the record, if it saves ok return to ticket otherwise display error
        PageReference pr;
        try{
            pr = scon.save();
        }
        catch(Exception e) {
            throw e;
        }
        
        if (pr != null){
            pr.setRedirect(true);
        }
        return pr;
    }

}