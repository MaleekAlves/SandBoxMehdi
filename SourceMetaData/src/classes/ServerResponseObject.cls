/*------------------------------------------------------------
Author:        Ana Lomibao
Company:       Arcus Global Ltd
Date:          October 2013
Description:   This class is used to store information from the Confirm external server. 				
------------------------------------------------------------*/
public class ServerResponseObject 
{
	public Boolean success {get; set;}
	public String response {get; set;}
	
	public ServerResponseObject()
	{
		this.success= false;
		this.response= '';
	}
}