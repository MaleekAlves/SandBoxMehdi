<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>HW_LocationDetails</fullName>
        <description>Populate Ticket field with additonal information written when selecting address via Target</description>
        <field>HHW_Location_Details__c</field>
        <formula>IF(CONTAINS(RecordType.Name, &quot;Location&quot;) , 
 Additional_Information__c , 
&quot;&quot;)</formula>
        <name>Highways Location Details</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Ticket__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Highways_Update_Location_Address</fullName>
        <description>Populate Ticket fields with address selected via Target</description>
        <field>HHW_Location__c</field>
        <formula>IF(CONTAINS(RecordType.Name, &quot;Location&quot;) , 
Full_Address_Line_1__c + BR() + Full_Address_Line_2__c  + BR()+ Full_Address_Line_3__c + BR(), 
&quot;Please select location via Target. If enquiry is not about a specific location, or you cannot find required street name in Target, please tick &apos;Hounslow Borough&apos; checkbox below.&quot;)</formula>
        <name>Highways Update Location Address</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Ticket__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Ticket_Target_Details_Field</fullName>
        <description>Update Ticket Target Details Field when target record is created or edited.</description>
        <field>CMP_Target_of_complaint__c</field>
        <formula>IF(CONTAINS(RecordType.Name, &quot;Area&quot;),
&quot;Service: &quot;+  Service_Remit__c + BR() +
&quot;Service Team:  &quot;+ TEXT(LBH_Service_Team__c) + BR() +
&quot;Parent Department: &quot; + TEXT( LBH_Department__c ) + BR() +
&quot;Parent Directorate: &quot; + TEXT( LBH_Directorate__c ) + BR(),
TRIM(Target_Description__c))</formula>
        <name>Update Ticket Target Details Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Ticket__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>Highways Ticket Location</fullName>
        <actions>
            <name>HW_LocationDetails</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Highways_Update_Location_Address</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Populate Location Details on Highways Ticket if the address was selected from Target</description>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set target description of ticket</fullName>
        <actions>
            <name>Update_Ticket_Target_Details_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates a field on ticket summerising the target assigned so that the ticket record contains all required information</description>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
