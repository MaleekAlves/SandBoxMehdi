/*------------------------------------------------------------
Author:        Tony Evans 
Company:       Arcus Global Ltd
Date:          26/07/2013
Description:   Hard coded version of the confirm web interface
Test Class:    
------------------------------------------------------------*/

public class ConfirmConnectorHTTP
{
    public String Username { get; set;}
    public String Password { get; set;}
    public String DatabaseID { get; set;}
    public String Endpoint { get; set;}
    
    public Map<String, String> enquiryParams { get; set;}
    public Map<String, String> customerParams { get; set;}

    
    public ConfirmConnectorHTTP()
    {
    //null constructor
    }
    
    /** (ANA) DEPRECATE THIS FUNCTION
    public String invoke(Boolean test){
        String response = '';
        HttpRequest req = new HttpRequest();
		req.setMethod('POST');
        req.setEndpoint(this.Endpoint);
        req.SetTimeout(10000);
        req.SetHeader('Content-Type','text/xml');
        
        String body = this.buildBody();
        System.debug('******** INFO: Buidling SOAP Body');
        req.setBody(body);
        System.debug('******** INFO: BODY:'+req.getBody());  
        System.debug('******** INFO: Sending SOAP');        
        Http http = new Http();
        if (test == null){
        	test = false;    
        }
        HttpResponse res= new HttpResponse();
        system.debug('********* test= ' + test);
        if (test){      	
            res.setBody('ERROR');
        	response = processResponse(res);
        } else {            
            try{
            	res = http.send(req);
            } catch (Exception e){
            	System.debug('******** ERROR: '+ e.getMessage());
                res.setBody('ERROR');	    
            }
        	System.debug('******** INFO: '+ res.toString());
        	System.debug('******** INFO: '+ res.getBody());
        	response = processResponse(res);
        	//response = res.toString();
        }
        return response;
    }
    */
    
    public ServerResponseObject invoke2(Boolean test)
    {
        ServerResponseObject response;
        HttpRequest req = new HttpRequest();
		req.setMethod('POST');
        req.setEndpoint(this.Endpoint);
        req.SetTimeout(10000);
        req.SetHeader('Content-Type','text/xml');
        
        String body = this.buildBody();
        req.setBody(body);
        Http http = new Http();
        if (test == null){
        	test = false;    
        }
        HttpResponse res= new HttpResponse();
        if (test)
        {   
        	response= new ServerResponseObject();
        	response.success= false;
        	response.response= 'This is a test.';
        	return response;    
        } else 
        {            
            try
            {
            	res = http.send(req);
            } catch (Exception e)
            {
            	response= new ServerResponseObject();
	        	response.success= false;
	        	response.response= e.getMessage();
	        	return response;    
            }
        	response = processResponse2(res); 
        }
        return response;
    }    
    
    private String buildBody(){
    	String body = '';
        String bodyHeader = '<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:web="http://www.confirm.co.uk/schema/am/connector/webservice"><soap:Header/>';
        String bodyFormer = '<soap:Body><web:ProcessOperationsRequest><Request><Authentication><Username>'+this.Username+'</Username><Password>'+this.Password+'</Password><DatabaseId>'+this.DatabaseID+'</DatabaseId></Authentication><Operation><NewEnquiry>';
        String bodyEnd = '</NewEnquiry></Operation></Request></web:ProcessOperationsRequest></soap:Body></soap:Envelope>';
        
        System.debug('******** INFO: Processing Enquiry keyset');
        for (String key : enquiryParams.keyset()){
        	String value = enquiryParams.get(key);
            String bodyFrag = '';
            if (value != null){
            	//bodyFrag = '<'+key+'><!CDATA['+enquiryParams.get(key)+']]></'+key+'>';
                bodyFrag = '<'+key+'>'+enquiryParams.get(key)+'</'+key+'>';
            } else {
            	//bodyFrag = '<'+key+'><!CDATA[ ]]></'+key+'>';
                bodyFrag = '<'+key+'></'+key+'>';
            }
            body = body+bodyFrag;
        }
        
        System.debug('******** INFO:'+body);
        System.debug('******** INFO: Processing Customer keyset');
        String customerStaticFrag = '<CustomerTypeCode>MOP</CustomerTypeCode><PointOfContactCode>SELF</PointOfContactCode><EnquiryMethodCode>WEB</EnquiryMethodCode>';
        String custFrag = '<EnquiryCustomer>'+customerStaticFrag;
        for (String key : customerParams.keyset()){
        	String value = customerParams.get(key);
            String bodyFrag = '';
            if (value != null){
            	//bodyFrag = '<'+key+'><!CDATA['+customerParams.get(key)+']]></'+key+'> ';
                bodyFrag = '<'+key+'>'+customerParams.get(key)+'</'+key+'>';
            } else {
            	bodyFrag = '<'+key+'><!CDATA[ ]]></'+key+'> ';
                bodyFrag = '<'+key+'></'+key+'>';
            }
            custFrag = custFrag+bodyFrag;
        }
      	body = body+custFrag+'</EnquiryCustomer>';
        
        body = bodyHeader+bodyFormer+body+bodyEnd;
        //body = bodyHeader+bodyFormer+bodyEnd;
    	return body;
    }
    
    /** (ANA) DEPRECATE THIS FUNCTION
    private String processResponse(HttpResponse response){
        String enqNum = '';
        String responseBody = response.getBody();
        
        if (responseBody.contains('EnquiryNumber')){
        	String[] res = responseBody.split('</EnquiryNumber>',2);
            String[] res2 = res[0].split('<EnquiryNumber>',2);
            enqNum = res2[1];
        } else {
        	enqNum = 'ERROR';   
        }
        return enqNum;
    }
    */
    
    private ServerResponseObject processResponse2(HttpResponse res)
    {
    	ServerResponseObject srObj= new ServerResponseObject();
    	String soapNS= 'http://www.w3.org/2003/05/soap-envelope';
    	String webServNS= 'http://www.confirm.co.uk/schema/am/connector/webservice';
    	
    	// parse the web service response
    	if (res.getBody().contains('EnquiryNumber'))
    	{	// web service returns success
        	String[] resL = res.getBody().split('</EnquiryNumber>',2);
            String[] res2 = resL[0].split('<EnquiryNumber>',2);
            srObj.success= true;
            srObj.response= res2[1];    		
    	}else
    	{	// web service returns error
	    	Dom.Xmlnode root= res.getBodyDocument().getRootElement();
	    	Dom.Xmlnode body= root.getChildElement('Body', soapNS);
	    	Dom.Xmlnode proc= body.getChildElement('ProcessOperationsResult', webServNS);
	    	Dom.Xmlnode response= proc.getChildElement('Response', '');
	   		Dom.Xmlnode fault= response.getChildElement('Fault', null);
	   		Dom.Xmlnode reason= fault.getChildElement('Reason', null);
	   		String reasonText= reason.getText();
	   		srObj.success= false;
	   		srObj.response= reasonText;
    	}
    	return srObj;  	
    } 
    
    

}