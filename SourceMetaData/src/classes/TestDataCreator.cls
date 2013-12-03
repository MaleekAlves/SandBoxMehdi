/*------------------------------------------------------------
Author:        Ana Lomibao
Company:       Arcus Global Ltd
Date:          October 2013
Description:   Class to create test data for unit tests
Test class:    InboundTicketEmailHandler_Test.cls
------------------------------------------------------------*/
public with sharing class TestDataCreator 
{
	public static Contact createContact(Id userId)
	{
		Contact c= new Contact(
			FirstName= 'Test',
			LastName= 'Test',
			Email= 'test.test@email.com', 
			MobilePhone= '0987083702',
			Title= 'Test', 
			User__c= userId);
		insert c;
		return c;	
	}
	
	public static User createUser()
	{
		UserRole ur= [Select Id From UserRole Where Name= 'System Administrator'];
		Profile up= [Select Id From Profile Where Name= 'System Administrator'];
		User u= new User(
			LastName= 'Test', 
			Alias= 'test',
			Email= 'test.test@email.com',
			UserRoleId= ur.Id,
			ProfileId= up.Id,
			Username= 'test.test@email.com',
			CommunityNickname= 'test',
			TimeZoneSidKey= 'Europe/London',
			LocaleSidKey= 'en_GB',
			EmailEncodingKey= 'ISO-8859-1',
			LanguageLocaleKey= 'en_US'
			);
				
		insert u;
		return u;
	}
	
	public static Id createCase()
	{
		RecordType rt= [Select Id From RecordType Where SobjectType= 'Case' And Name= 'CCC'];
		Case c= new Case(
			Status= 'Open', 
			Subject= 'Test Subject',
			Popular_Goals__c= 'test'
			);
		insert c;
		return c.Id; 
	}
	
	public static Id createTicket(String recTypeName, Id caseId)
	{
		RecordType rt= [Select Id From RecordType Where SobjectType= 'Ticket__c' And Name= :recTypeName];
		
		Ticket__c t= new Ticket__c(
			RecordTypeId= rt.Id,
			GLOBAL_Goal__c= caseId, 
			GLOBAL_Ticket_Status__c= 'Draft'
			);
		insert t;
		return t.Id;
	}
	
	public static SLA__c createSLA()
	{
		SLA__c sla= new SLA__c(
			Active__c= true, 
			Escalation_Prior_to_SLA_Breach_Days__c= 3, 
			Customer_Acknowledgement_Days__c= 2, 
			Working_Days__c= true, 
			SLA_Length_Days__c= 7, 
			Name= '7 Working Days'
			);
		insert sla;
		return sla;
	}
	
	public static ICT_Article__c createIctArticle(String artName)
	{
		ICT_Article__c art= new ICT_Article__c
			(
			Article_Name__c= artName,
			Article_Type__c= 'Fix'
			);
		insert art;
		return art;
	}
	
}