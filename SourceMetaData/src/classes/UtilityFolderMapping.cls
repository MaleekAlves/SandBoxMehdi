/*------------------------------------------------------------
Author:        Ana Lomibao
Company:       Arcus Global Ltd
Date:          October 2013
Description:   Utility class used to map a record to folder, uses Attahment_To_Document_Mapping__c custom settings  
Test class:    UtilityFolderMapping_Test
------------------------------------------------------------*/
public class UtilityFolderMapping 
{
	public static String NO_CUSTOM_SETTINGS_ERROR_MSG= 'List has no rows for assignment to SObject';
	public static Map<String, Folder> FOLDERS_MAP;
	public static Map<String, String> ATT_TO_DOC_MAP_SETTING;
	
	/*
	 * This method uses 'sobject + recordtype' of a record and maps it with the custom setting called 'Attachment to Document Mapping' to obtain
	 * the folderId that the document will be stored in. If there is no custom setting for the 'sobject + recordtype', will return null
	 * @param sobjName: Name of the sObject 
	 * @param recTypeName: Name of the recordtype of the record 
	 * @return the folderId
	 */
	public static ID mapDocFolderId(String sobjName, String recTypeName)
	{
		ID folderId;
		String object_Name= sobjName.toUpperCase();
		String rec_Type;
		if (String.isNotBlank(recTypeName)) 
			rec_Type= recTypeName.toUpperCase();
		else 
			rec_Type= 'DEFAULT';
		
		// Initialise folders map only once to avoid governor limits
		if (FOLDERS_MAP == null)
		{
			List<Folder> l= [Select Id, Name From Folder Where Name != null And Type= 'Document' Limit 1000];
			FOLDERS_MAP= new Map<String, Folder>();
			for (Folder f: l)
			{
				FOLDERS_MAP.put(f.Name, f);
			}
		}
		
		// Initialise attachment to doc custom setting mapping only once to avoid governor limits
		if (ATT_TO_DOC_MAP_SETTING == null)
		{
			List<Attachment_To_Document_Mapping__c> l= Attachment_To_Document_Mapping__c.getAll().values();
			ATT_TO_DOC_MAP_SETTING= new Map<String, String>();
			for (Attachment_To_Document_Mapping__c am: l)
			{
				ATT_TO_DOC_MAP_SETTING.put(am.Object_Name__c.toUpperCase() + '_' + am.Record_Type_Name__c.toUpperCase(), am.Document_Folder_Name__c);
			}			
		}
		
		String folderName= ATT_TO_DOC_MAP_SETTING.get(object_Name + '_' + rec_Type);
		if (folderName == null) // get default folder
			folderName= ATT_TO_DOC_MAP_SETTING.get(object_Name + '_DEFAULT');

		if (folderName == null) // cannot find for the record type of for the default settings for this object and recordtype 
			return null;
			
		// Get Folder Id
		Folder f= FOLDERS_MAP.get(folderName);
		if (f != null)
			folderId= f.Id;
		
		return folderId;
	}
				
}