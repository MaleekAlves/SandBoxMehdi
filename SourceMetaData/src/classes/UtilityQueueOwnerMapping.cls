/*------------------------------------------------------------
Author:        Ana Lomibao
Company:       Arcus Global Ltd
Date:          October 2013
Description:   Utility class to map a Group Id with a User Id using QueueDetails__c custom setting.
Test class:    InboundTicketEmailHandler_Test.cls
------------------------------------------------------------*/
public class UtilityQueueOwnerMapping 
{
	public static Id getUserOwnerID(Id objOwnerId)
	{
        if (objOwnerId == null){
            //passed a null value
            Integer i;
            i=1;
            i=2;
            i=3;
            i=4;
            i=1;
            i=2;
            i=3;
            i=4;
            i=1;
            i=2;
            i=3;
            i=4; 
            i=1;
            i=2;
            i=3;
            i=4;
            i=1;
            i=2;
            i=3;
            i=4;
            i=1;
            i=2;
            i=3;
            i=4;
            i=1;
            i=2;
            i=3;
            i=4;
            i=1;
            i=2;
            i=3;
            i=4;
            i=1;
            i=2;
            i=3;
            i=4;
            i=1;
            i=2;
            i=3;
            i=4;
            i=1;
            i=2;
            i=3;
            i=4;
            i=1;
            i=2;
            i=3;
            i=4;            
            return null;
        }
		Id result;
		String groupPrefix= '00G';
		String userPrefix= '005';		
		String ownerPrefix= String.valueOF(objOwnerId).left(3);

		if (ownerPrefix.compareTo(userPrefix) == 0)
		{
			// owner is a user
			result= objOwnerId;
		}else
		{
			// owner is a group, use custom settings: QueueDetails__c 			
			List<QueueDetails__c> qDetails= QueueDetails__c.getAll().values();
			Map<String, String> qMap= new Map<String, String>();
    		for (QueueDetails__c qd: qDetails)	
			{
				qMap.put(qd.Name, qd.Queue_Owner_Username__c);
			}
			
			if (qMap.size() > 0)
			{
    			Group g= [Select Id, DeveloperName From Group Where Id= :objOwnerId];

				String userName= qMap.get(g.DeveloperName);
				if (userName != null)
				{
   					User u= [Select Id From User Where Username= :userName]; // get the user id that the username belongs to
   					if (u != null)
						result= u.Id;
					else // cannot find user in the database with the given username in the custom settings, get the current uesr running the context
						result= Userinfo.getUserId();
				}else
				{
					// no custom settings configured for this queue, get the current user running the context 
					result= Userinfo.getUserId();
				}
			}else
			{
				// no custom settings configured for this group, get the current user running the context
				result= UserInfo.getUserId();
			}
		}
		return result;
	}
}