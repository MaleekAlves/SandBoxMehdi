public with sharing class Salesforce_Limits_Update_Controller {

	public Integer DMLStatements {get; private set;}
	public Integer limitDMLStatements {get; private set;}
	public Integer emailInvocations {get; private set;}
	public Integer limitEmailInvocations {get; private set;}
	public Integer fieldsDescribes {get; private set;}
	public Integer limitFieldsDescribes {get; private set;}
	
	public Salesforce_Limits_Update_Controller()
	{
		DMLStatements = Limits.getDMLStatements();
		limitDMLStatements = Limits.getLimitDMLStatements();
		emailInvocations = Limits.getEmailInvocations();
		limitEmailInvocations = Limits.getLimitEmailInvocations();
		fieldsDescribes = Limits.getFieldsDescribes();
		limitFieldsDescribes = Limits.getLimitFieldsDescribes();
	}


}