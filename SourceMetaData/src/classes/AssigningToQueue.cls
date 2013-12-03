global with sharing class AssigningToQueue implements Process.Plugin {

 // Member variables for status
    public static final String SUCCESS_CODE = 'SUCCESS';
    public static final String ERROR_CODE = 'ERROR';
    public static final String BAD_ID = 'INVALIDID';
public  Case[] acctsList;

    
        public String anErrorDescription;
 
 
 // The main method invoked by the Flow engine at run-time.
    global Process.PluginResult invoke(Process.PluginRequest request) {    

        String recordID = (String) request.inputParameters.get('recordID');
     String Queue = (String) request.inputParameters.get('Queue');
     
//Assigning to Queue   
  
   AssignQueue(recordID, Queue);                     
             
    
    Map<String,Object> result = new Map<String,Object>();
        result.put('Error Message', anErrorDescription);
     
        return new Process.PluginResult(result); 
    }
    

 /* This is the method the Cloud Flow Designer calls to show the Apex Plug-ins to the flow author
     * The implemnetation of this method drives how author of the flow interacts in the the Cloud Flow Designer 
     */   
         
    global Process.PluginDescribeResult describe() {
    
    Process.PluginDescribeResult result = new Process.PluginDescribeResult();
        //Shows the description visible in the Palette tab of the Cloud Flow Designer.    
        result.description = 'Assigning to the Queue base on service area';
        
        //Setting the 'tag' give the Apex Plug-in as its own section on the Cloud Flow Designer Palette tab.
        // Use this attribute to group related Apex Plug-ins together in the Cloud Flow Designer.        
        result.tag = 'Queue';
  
          //All the Inputs needed, their data type and the requiredness      
        result.inputParameters = new List<Process.PluginDescribeResult.InputParameter>{
            new Process.PluginDescribeResult.InputParameter('recordID', 
                Process.PluginDescribeResult.ParameterType.STRING, true),
                new Process.PluginDescribeResult.InputParameter('Queue', 
                Process.PluginDescribeResult.ParameterType.STRING, true)

                };

        //All the Outputs and their data type
        result.outputParameters = new List<Process.PluginDescribeResult.OutputParameter>{
                        new Process.PluginDescribeResult.OutputParameter('Error Message', 
                Process.PluginDescribeResult.ParameterType.STRING)    
                };
   
        
        return result;
        }
        
         
 
 
 Public void AssignQueue(String recordID,  String Queue) {  
 acctsList = [Select  Ownerid From Case WHERE   ID = :recordID   ];
  
        
       
   System.debug(acctsList); 
   
  for(Case t:acctsList){
  t.Ownerid = Queue;
  }
update acctsList;
  anErrorDescription = ERROR_CODE ;
  }

 
 
 
 
 
 
 
 
 static testMethod void basicTest() {

       
        // Create dummy lead
                             
                Case[] anApprovalList;
        String tmpID = '500g0000002BvhS';
        AssigningToQueue anApprovalPlugin = new AssigningToQueue();
        Map<String,Object> inputParams = new Map<String,Object>();
        Map<String,Object> outputParams = new Map<String,Object>();

        inputParams.put('recordID','500g0000002BvhS');
        inputParams.put('Queue','00Gb00000012ry7');

        Process.PluginRequest request = new Process.PluginRequest(inputParams);
        Process.PluginResult result;
        result = anApprovalPlugin.invoke(request);     
        anApprovalList = [select Ownerid from case where ID = :tmpID ];   
        if (anApprovalList.size() > 0)
            System.AssertEquals(result.OutputParameters.get('Error Message'), SUCCESS_CODE);
        else
            System.AssertEquals(result.OutputParameters.get('Error Message'), ERROR_CODE);
        }

 /* 
 * -ve test. This tests the fact that bad ids or non-existant IDs will always result in an ERROR status
 */ 
        static testMethod void negativeTest() {
        
        AssigningToQueue anApprovalPlugin = new AssigningToQueue();
        Map<String,Object> inputParams = new Map<String,Object>();
        Map<String,Object> outputParams = new Map<String,Object>();

        inputParams.put('recordID',BAD_ID);
        
        Process.PluginRequest request = new Process.PluginRequest(inputParams);
        Process.PluginResult result;
        result = anApprovalPlugin.invoke(request);
        System.AssertEquals(result.OutputParameters.get('Error Message'), ERROR_CODE);
        }        
        
        static testMethod void describeTest() {

                AssigningToQueue anApprovalPlugin = new AssigningToQueue();
                Process.PluginDescribeResult result = anApprovalPlugin.describe();
                
                System.AssertEquals(result.inputParameters.size(), 2);
                System.AssertEquals(result.OutputParameters.size(), 1);
        
        }

 
 
 
  
    }