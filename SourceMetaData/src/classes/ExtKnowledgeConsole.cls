/*------------------------------------------------------------
Author:        Matt Urbanowski
Company:       Arcus Global Ltd
Date:          24/07/2013
Description:   Extension class for Knowledge console VF Page. Gets suggested search text from selected case
               and opens specific articles.
Test Class:    KnowledgeTestClass
------------------------------------------------------------*/

public with sharing class ExtKnowledgeConsole {

    public String searchString { get; set; }
    public String urlContent {get; set;} 
    public String myContent {get; set;}
    public Boolean modeView {get; set;}  
    public String txtInstance {get; set;} 
    public Integer pageNumber {get; set;}  
    public Integer ArticleCount {get; set;}
    public Integer maxSize {get; set;}
    public Set<Id> AttachedArticles {get; set;}
    private Id GoalId;    
    
    public ExtKnowledgeConsole() { 
        if (ApexPages.currentPage().getParameters().get('id') != null)   
            GoalId = ApexPages.currentPage().getParameters().get('id');
        modeView = false; 
        maxSize = 10;
        pageNumber = 1;
        txtInstance = URL.getSalesforceBaseUrl().toExternalForm();
        SuggestedSearch();     
        GetArticleCount();
        System.Debug('%%% Loaded All. Goal ID = ' + GoalId); 
    }
    
    public void Search() {
        pageNumber = 1; 
        GetArticleCount();   
    }
    
    public void ShowAll() {
        searchString = '';
        pageNumber = 1; 
        GetArticleCount();   
    }
    
    public void SuggestedSearch() {
        // Fetch goal details for default search
        try {
            List<Case> myGoals = New List<Case>();            
            If (GoalId != null)
                myGoals = [Select Id, CaseNumber, Subject, Case_Summary__c From Case Where Id =: GoalId];                         
            searchString = '';
            If (myGoals.size() > 0)
                searchString = myGoals[0].Case_Summary__c;
            System.Debug('%%% Suggested Search: ' + searchString);                  
        } catch (System.CalloutException e){
            System.debug('Could not identify Id: ' + GoalId);
        }
        pageNumber = 1;
        GetArticleCount();  
    }
    
    public void AssociateArticleCase() {
        String ArticleId = ApexPages.currentPage().getParameters().get('ArticleId');
        // If you have a Case Id and an article Id, associate them.            
        If (GoalId != null && ArticleId != null) {
            System.Debug('%%% Attaching goal ' + GoalId + ' to Article ' + ArticleId);
            CaseArticle ca = new CaseArticle(CaseId=GoalId, KnowledgeArticleId=ArticleId);
            insert ca;
        }
    }
    
    // Returns whether we need to see previous button or not
    public boolean getPrevRequired() {
        return pageNumber > 1;
    }
    
    // Returns whether we need to see next button or not
    public boolean getNextRequired() {
        return pageNumber * maxSize  < ArticleCount;
    }
    
    // Show Next page
    public void Next() {
        if(ArticleCount > this.pageNumber * maxSize)
            pageNumber++;
    }

    // Show Previous page
    public void Previous() {
        if(this.pageNumber > 1)
            pageNumber--;
    }
    
    public void OpenContent() {
        String ArticleUrl = ApexPages.currentPage().getParameters().get('ArticleUrl');
        KnowledgeArticleVersion tmpKAV = [SELECT Id, title, UrlName, ArticleType, LastPublishedDate, LastModifiedById FROM KnowledgeArticleVersion WHERE (PublishStatus = 'online' and Language = 'en_US' and UrlName = :ArticleUrl ) ORDER BY LastPublishedDate DESC][0];
        System.Debug(tmpKAV);
        String SOQL = 'SELECT Content__c FROM ' + tmpKAV.ArticleType + ' WHERE Id = \''+ tmpKAV.Id + '\'';
        sObject tmp = Database.Query(SOQL)[0];
        myContent = (String)tmp.get('Content__c');
        modeView = true;
    }

    public void OpenGoalSummary() {
        ApexPages.currentPage().getParameters().put('ArticleUrl', 'Goal-Summary');
        OpenContent();
    }
    
    public void btnReturn() {
        modeView = false;
    }
    
    private void GetArticleCount() {
        if (searchString.length() > 1) {
            String searchquery = 'FIND \'' + ((searchString.length() > 100) ? String.escapeSingleQuotes(searchString).substring(0,100) : String.escapeSingleQuotes(searchString)) + '*\' IN ALL FIELDS RETURNING KnowledgeArticleVersion(Id, title, UrlName, LastPublishedDate,LastModifiedById where' + 
                   ' PublishStatus =\'online\' and Language = \'en_US\')';
            List<List<SObject>>searchList = search.query(searchquery);
            List<KnowledgeArticleVersion> articleList = (List<KnowledgeArticleVersion>)searchList[0];
            ArticleCount = articleList.size() ; 
        } else {
            String qryString = 'SELECT Id, title, UrlName, LastPublishedDate,LastModifiedById FROM KnowledgeArticleVersion WHERE (PublishStatus = \'online\' and Language = \'en_US\')';
            List<KnowledgeArticleVersion> articleList= Database.query(qryString);
            ArticleCount = articleList.size() ;
        } 
        System.Debug('%%% Article Count: ' + ArticleCount);
    }
    
}