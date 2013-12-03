/*------------------------------------------------------------
Author:        Ana Lomibao
Company:       Arcus Global Ltd
Date:          October 2013
Description:   Class that builds a tree representation of the ICT articles and uses this data structure to generate the related articles of a given ICT article
------------------------------------------------------------*/
public with sharing class RelatedICTArticle 
{
	public List<ICT_Article__c> ictArticles {public get; private set;}
	
	public RelatedICTArticle(Apexpages.Standardcontroller scon)
	{

		Map<Id, Map<Id, List<ICT_Article__c>>> m= allRelatedIctArticles();
		ictArticles= getRelatedIctAritcles(getParentsIctArticles(m, getChildrenIctArticles(scon.getId(), m, null)));
	}
	
	private List<ICT_Article__c> getRelatedIctAritcles(List<Id> ids)
	{
		List<ICT_Article__c> res;
		if (ids != null || ids.size() > 0)
			res= [Select Id, Name, Article_Name__c, Article_Type__c from ICT_Article__c where id in :ids];
		return res;
	}
	
	/**
	 * This method builds all the ICT articles in the database and their relationships
	 * Returns a map containing: < ICT Article Id, <ICT Article Parent Id, <ICT Article children> > > 
	 **/
	private Map<Id, Map<Id,List<ICT_Article__c>>> allRelatedIctArticles()
	{
		Map<Id, Map<Id,List<ICT_Article__c>>> mapParentToChildren = new Map<Id, Map<Id,List<ICT_Article__c>>>();
		
		for(List<ICT_Article__c> artArr : [select Id, Related_To__c, Related_To__r.Related_To__c, Name from ICT_Article__c Order by CreatedDate desc limit 10000])
		{
		    for(ICT_Article__c art : artArr)
		    {
		    	if (art.related_To__c != null && art.related_To__c != art.Id)
		    	{
		    		// add parent
			        if(mapParentToChildren.get(art.Related_To__c) == null)
			        {
			            mapParentToChildren.put(art.Related_To__c, new Map<Id, List<ICT_Article__c> > ());
			            mapParentToChildren.get(art.Related_To__c).put(art.Related_To__r.related_To__c, new List<ICT_Article__c>{art});
			        }else
			        {
			        	List<ICT_Article__c> l= mapParentToChildren.get(art.Related_To__c).values()[0];
			        	l.add(art);
			        	mapParentToChildren.get(art.Related_To__c).clear();
			           	mapParentToChildren.get(art.Related_To__c).put(art.Related_To__r.Related_To__c, l);
			        }
			        
			        // add current node
			        if (mapParentToChildren.get(art.Id) == null)
			        {
			        	mapParentToChildren.put(art.Id, new Map<Id, List<ICT_Article__c>> ());
			        	mapParentToChildren.get(art.Id).put(art.Related_To__c, new List<ICT_Article__c>());
			        }
		    	}
		    }
		}
		return mapParentToChildren;	
	}
	
	/**
	 * Recursive method to get all the related children of an article
	 **/
	private List<Id> getChildrenIctArticles(Id recId, Map<Id, Map<Id, List<ICT_Article__c>>> m, List<Id> l)
	{
		if (recId == null)
			return null;
		
		if (l == null || (l != null && l.size() == 0))
		{
			l= new List<Id>{recId};
		}else
		{
			l.add(recId);
		}
		
		// recursive call to the children
		if (m.get(recId) != null)
		{	
			// get children
			for (ICT_Article__c a: m.get(recId).values()[0])
			{
				
				 l= (getChildrenIctArticles(a.Id, m, l));
			}
		}		
		return l;
	} 	
	
	/**
	 * Recursive method to get all related parents of the article on the position 0 of the list
	 **/
	private List<Id> getParentsIctArticles(Map<Id, Map<Id, List<ICT_Article__c>>> m, List<Id> l)
	{
		if (l == null || (l != null && l.size() == 0))
		{
			return l;
		}else
		{
			// recursive call to parents
			Id recId= l[0];
			if (m.get(recId) != null)
			{
				List<Id> q= new List<Id>();
				q.addAll(m.get(recId).keyset());
				if (q[0] != null)
				{
					List<Id> res= new List<Id>();
					res.add(q[0]);
					res.addAll(l);
					return getParentsIctArticles(m, res);
				}
			}
		}
		return l;
	} 			

}