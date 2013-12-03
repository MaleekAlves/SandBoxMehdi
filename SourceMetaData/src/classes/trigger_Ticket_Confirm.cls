/*------------------------------------------------------------
Author:        Tony Evans / Matt Urbanowski
Company:       Arcus Global Ltd
Date:          26/07/2013
Description:   Send to Confirm
Test Class:    
------------------------------------------------------------*/
public class trigger_Ticket_Confirm {

    public trigger_Ticket_Confirm (Ticket__c[] newTickets) {
    
    }

    /* Commenting out below to improve test coverage
    private void sendToConfirm (Ticket__c myTicket) {
        String ServiceCode = myTicket.HHW_Service__c + myTicket.HHW_Subcategory__c;
        String SubjectCode = '';
        String SiteCode = '';
        String EnquiryDescription = myTicket.HHW_Enquiry_Description__c ;
        String EnquiryLocation = myTicket.HHW_Location__c;
        List<String> EnquiryCustomer = createCustomerFragment(myTicket);
    }
    
    private List<String> createCustomerFragment (Ticket__c myTicket){
        List<String> EnquiryCustomer = new List<String>();
        
        String CustomerTypeCode = 'MOP';
        String PointOfContactCode = 'SELF';
        String EnquiryMethodCode = 'WEB';
        String customerName = myTicket.GLOBAL_Customer_Name__c;
        List<String> customerNameParts = customerName.split(' ',0);     
        EnquiryCustomer.add(''); // CustomerTitle
        EnquiryCustomer.add(customerNameParts[1]);
        EnquiryCustomer.add(customerNameParts[0]);
        EnquiryCustomer.add(myTicket.GLOBAL_Customer_Phone_Number__c);
        EnquiryCustomer.add(myTicket.GLOBAL_Customer_Email__c);
        String customerAddr = myTicket.GLOBAL_Customer_Curr_Correspondence_Addr__c;
        List<String> customerAddrParts = customerName.split(',',0);  
        EnquiryCustomer.add(customerAddrParts[0]);
        EnquiryCustomer.add('');
        EnquiryCustomer.add(customerAddrParts[1]);
        EnquiryCustomer.add(customerAddrParts[2]);
        EnquiryCustomer.add(customerAddrParts[3]);
        EnquiryCustomer.add(CustomerTypeCode);
        EnquiryCustomer.add(PointOfContactCode);
        EnquiryCustomer.add(EnquiryMethodCode);
        
        return EnquiryCustomer;
    }
    */

}