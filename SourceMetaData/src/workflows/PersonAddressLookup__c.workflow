<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Set_Current_Correspondence_Address_Field</fullName>
        <field>Current_Correspondence_Address__c</field>
        <formula>IF ( 
    Correspondence_Address__c , 
    Full_Address_Line_1__c + &quot;, &quot; +  Full_Address_Line_2__c + &quot;, &quot; +  Full_Address_Line_3__c,
    &quot;NONE SPECIFIED&quot;
)</formula>
        <name>Set Current Primary Address Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Related_Person__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Contact_Prim_House_No</fullName>
        <description>Update the primary address house number field on contact (for person account). ASSUMING THAT PAON HOLDS HOUSE NUMBER!</description>
        <field>Primary_Address_House_Number__pc</field>
        <formula>Address__r.PAON__c</formula>
        <name>Update Contact Prim House No</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Related_Person__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Contact_Prim_Postcode</fullName>
        <description>Update the primary address postcode field on contact (for person account)</description>
        <field>Primary_Address_Postcode__pc</field>
        <formula>Address__r.Postcode__c</formula>
        <name>Update Contact Prim Postcode</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Related_Person__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>Update Person Primary Address</fullName>
        <actions>
            <name>Set_Current_Correspondence_Address_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Contact_Prim_House_No</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Contact_Prim_Postcode</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Set the correspondence address (primary address) field on the person record when an address they are associated with is marked as the primary addr association</description>
        <formula>ISNEW() || ISCHANGED(Correspondence_Address__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
