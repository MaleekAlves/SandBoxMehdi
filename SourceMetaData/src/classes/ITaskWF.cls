/*------------------------------------------------------------
Author:        Ana Lomibao
Company:       Arcus Global Ltd
Date:          October 2013
Description:   Interface used for workflow classes   
------------------------------------------------------------*/
public Interface ITaskWF 
{
	Boolean isApplicable();
	
	void execute();

}