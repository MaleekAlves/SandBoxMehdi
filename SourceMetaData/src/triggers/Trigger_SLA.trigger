trigger Trigger_SLA on SLA__c (after insert, after update) {
 List<ID> CaseIds = new List<ID>();
    for (SLA__c SLA1 : Trigger.new) {
        if(SLA1.Active__c = true && SLA1.Name != null) {
            CaseIds.add(SLA1.Name);
        }
    }
    
    List<Case> SLAList = [Select id, Active_SLA__c, SLA__c from Case where id in :CaseIds];
    Map<id,SLA__c> m1 =New Map<id,SLA__c>();
    for(SLA__c s1 : trigger.new)
        m1.put(s1.Name,s1);
    for(integer i=0;i< SLAList.size(); i++) {
        SLAList[i].Active_SLA__c= m1.get(SLAList[i].ID).Name;
    }
    update SLAList;
}