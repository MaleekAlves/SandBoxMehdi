<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Address_Field</fullName>
        <field>Name</field>
        <formula>LEFT(TRIM(Full_Address_Line_1__c) + &apos;, &apos; + TRIM(Full_Address_Line_2__c) + &apos;, &apos;,66) + 
TRIM(Postcode__c)</formula>
        <name>Update Address Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Address</fullName>
        <actions>
            <name>Update_Address_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Concatenate address parts to name for lookup.</description>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
