/*------------------------------------------------------------
Author:        Ana Lomibao
Company:       Arcus Global Ltd
Date:          October 2013
Description:   Class that generates pdf document from an ICT article attachment.
			   If the attachment is a pdf generated from an ICT article, rename the existing document called *_Current.pdf by removing '_Current.pdf' 
			   and new create the new document with name appending *_Current.pdf  
------------------------------------------------------------*/
public class trigger_Attachment_Copy_to_Docs {
	
	/**
	 * This method will create a document record from an attachment record
	 * newAtts: Trigger.new
	 */
    /*
	public static void trigger_Attachment_Copy2(List<Attachment> newAtts)
	{
		// Get information about the attachment's parent
		List<Attachment> newAttsWithParents= [Select Id, CreatedDate, Name, Body, ContentType, Description, ParentId, Parent.Name, Parent.RecordTypeId, Parent.RecordType.Name From Attachment 
			Where Id In :newAtts];  
		
		// this map will contain pair values of <Name: attachment's name, List<Attachment>: all the attachments with the same Name>
		Map<String, List<Attachment>> m= new Map<String, List<Attachment>>();
		Map<String, Attachment> ictAttachments= new Map<String, Attachment>(); // keep a list of the attachments related to ICT Articles
		for (Attachment a: newAttsWithParents)
		{
			List<Attachment> ats= m.get(a.Name.substringBefore('.') + '_' + a.Parent.Name + '.' + a.Name.substringAfter('.'));
			if (ats != null)
			{
				ats.add(a);
				m.remove(a.Name.substringBefore('.') + '_' + a.Parent.Name + '.' + a.Name.substringAfter('.'));
				m.put(a.Name.substringBefore('.') + '_' + a.Parent.Name + '.' + a.Name.substringAfter('.'), ats);
			}else
			{
				m.put(a.Name.substringBefore('.') + '_' + a.Parent.Name + '.' + a.Name.substringAfter('.'), new List<Attachment> {a});
			}
			String parentIdStr= Id.valueOf(a.ParentId);			
			if (parentIdStr.startsWith('a0J') && a.Name.contains('_Current.pdf')) // this is an ICT attachment
				ictAttachments.put(a.Name.substringBefore('.') + '_' + a.Parent.Name + '.' + a.Name.substringAfter('.'), a);
		}
		
		List<Attachment> res= new List<Attachment>();
		for (List<Attachment> l: m.values())
		{
		    l[0].Name= l[0].Name.substringBefore('.') + '_' + l[0].Parent.Name + '.' + l[0].Name.substringAfter('.'); // append parent's Name to the doc's Name
		    if (l.size() > 1) // l contians all the attachments with the same name under the same parent
		    {
		    	// rename the rest of the attachments
		        for (Integer i= 1; i < l.size(); i++)
		        {
		            l[i].Name= l[i].Name.substringBefore('.') + '_' + l[i].Parent.Name + '__' + ( i + 1) + '.' + l[0].Name.substringAfter('.');
		        }
		    }
		    res.addAll(l);
		}

		// Make sure there are no documents already in the database with the same name as the Attachments in res		
		List<String> attsNames= new List<String>();
		for (Attachment a: res)
		{
			attsNames.add(a.Name);
		}
		List<Document> docs= [Select Id, Name From Document Where Name In :attsNames Limit 1000];
		List<Document> docsIctToDelete= new List<Document>();
		Set<String> docsNames= new Set<String>(); // for ICT documents, delete the previous copy of the document
		for (Document doc: docs)
		{
			if (ictAttachments.get(doc.Name) != null)
				docsIctToDelete.add(doc);
			else	
				docsNames.add(doc.Name);
		}
		// Rename Attachment's Name if necessary before inserting them
		for (Attachment a: res)
		{
			if (docsNames.contains(a.Name))
			{
				a.Name= a.Name.substringBefore('.') + '_' + a.CreatedDate + '.' + a.Name.substringAfter('.');
			}
		}
		
		// Create the Documents based on the Names of the Attachments:
		List<Document> docsToCreate= convertAttsToDocs(res);
		if (docsToCreate.size() > 0)
		{
			try
			{
				if (docsIctToDelete.size() > 0)
					delete docsIctToDelete;
				insert docsToCreate;
			}catch(Exception e)
			{
				throw e;
			}
		}
	}*/
	
	/**
	 * This method receives a list of attachments that will be converted to documents
	 **/
    /*
	public static List<Document> convertAttsToDocs(List<Attachment> atts)
	{
		List<Document> docs= new List<Document>();
		for (Attachment a: atts)
		{
			Id fId= UtilityFolderMapping.mapDocFolderId(String.valueOf(a.ParentId.getSObjectType()), a.Parent.RecordType.Name);
			if (fId != null)
			{
				Document doc= new Document(
					Name= a.Name,
					Body= a.Body,
					ContentType= a.ContentType,
					Description= a.Description,
					FolderId= fId
					);
				docs.add(doc);
			}			
		}
		return docs;		
	}
*/
	
}