/*------------------------------------------------------------
Author:        Douglas Guthire
Company:       Arcus Global Ltd
Date:          26/07/2013
Description:   Main Attachments trigger to handle all sub-classes.
               Triggers are handled in sub-classes so processing can be done in specific orders.
Test Class:    TestClass
------------------------------------------------------------*/

trigger trigger_Attachment on Attachment (after insert) {

	// Copy opp attachments to document library
	// Go through list of new attachemnts and sort into lists for which dol library they should go to. 
	// Then create list of doc objects 
	// Then insert into the library
	// use a wrapper class that has attachment/ its document?
	
	//trigger_Attachment_Copy_to_Docs.trigger_Attachment_Copy2(Trigger.new);

}