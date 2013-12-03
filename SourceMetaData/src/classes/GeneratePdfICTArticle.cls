/*------------------------------------------------------------
Author:        Ana Lomibao
Company:       Arcus Global Ltd
Date:          October 2013
Description:   Class that generates pdf from an ICT article and inserts it in the database as an Attachment
Test:          GeneratePdfIctArticle_Test.cls
------------------------------------------------------------*/
public with sharing class GeneratePdfICTArticle 
{
	private Apexpages.Standardcontroller scon;
	public ICT_Article__c ictArticle;
	public GeneratePdfICTArticle(Apexpages.Standardcontroller sc)
	{
		scon= sc;
		if (!Test.isRunningTest())
			scon.addFields(new List<String> {'Name', 'Article_Name__c'});
		ictArticle= (ICT_Article__c)sc.getRecord();
	}
	
	public Pagereference generatePdf()
	{
		// generate pdf file
        PageReference pdfPage = new PageReference( '/apex/ICT_Article_PDF' );
        pdfPage.getParameters().put('id', ictArticle.id);
        Blob pdfBlob;
        // the following is a workaround for getContent() not being supported when running unit tests
        if (!Test.isRunningTest())
        	pdfBlob= pdfPage.getContent();
        else
        	pdfBlob= Blob.valueOf('unit test'); 
        
        // check for existing pdf's
        List<Attachment> pdfs= [Select Id, Name From Attachment Where parentId= :ictArticle.id And Name like '%_Current.pdf'];
        // rename these articles, remove _Current.pdf
        for (Attachment att: pdfs)
        {
        	att.Name= att.Name.replace('_Current.pdf', '');
        }
        try
        {
        	update pdfs;
        }catch (Exception e)
        {
        	throw e;
        	return null;
        }
        
        
        // create the attachment against the ICT article
        Attachment a = new Attachment(parentId = ictArticle.id, name= ictArticle.Article_Name__c + '_Current.pdf', body = pdfBlob);
        
        // insert the attachment
        try
        {
        	insert a;
        }catch (Exception e)
        {
        	Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
        	return null;
        }		
		
		// return to view page of the ICT article
		 return scon.view().setRedirect(true);
	}
}