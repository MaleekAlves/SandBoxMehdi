<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Ticket_Escalation_CS_to_the_Escalation_Email</fullName>
        <description>Ticket Escalation CustServ to the Escalation Email</description>
        <protected>false</protected>
        <recipients>
            <field>GLOBAL_Escalation_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>customerservices@hounslow.gov.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>LBH_Automatic_Notifications/TICKET_SLA_is_about_to_be_overdue</template>
    </alerts>
    <alerts>
        <fullName>Ticket_Escalation_CS_to_the_Owner</fullName>
        <description>Ticket Escalation CustServ to the Owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>customerservices@hounslow.gov.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>LBH_Automatic_Notifications/TICKET_SLA_is_about_to_be_overdue</template>
    </alerts>
    <alerts>
        <fullName>Ticket_Escalation_Complaints_to_the_Escalation_Email</fullName>
        <description>Ticket Escalation Complaints to the Escalation Email</description>
        <protected>false</protected>
        <recipients>
            <field>GLOBAL_Escalation_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>customerrelations@hounslow.gov.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>LBH_Automatic_Notifications/TICKET_SLA_Complaints_is_about_to_be_overdue</template>
    </alerts>
    <alerts>
        <fullName>Ticket_Escalation_Complaints_to_the_Owner</fullName>
        <description>Ticket Escalation Complaints to the Owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>customerrelations@hounslow.gov.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>LBH_Automatic_Notifications/TICKET_SLA_Complaints_is_about_to_be_overdue</template>
    </alerts>
    <alerts>
        <fullName>Ticket_Escalation_RFI_to_the_Escalation_Email</fullName>
        <description>Ticket Escalation RFI to the Escalation Email</description>
        <protected>false</protected>
        <recipients>
            <field>GLOBAL_Escalation_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>customerrelations@hounslow.gov.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>LBH_Automatic_Notifications/TICKET_SLA_RFI_is_about_to_be_overdue</template>
    </alerts>
    <alerts>
        <fullName>Ticket_Escalation_RFI_to_the_Owner</fullName>
        <description>Ticket Escalation RFI to the Owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>customerrelations@hounslow.gov.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>LBH_Automatic_Notifications/TICKET_SLA_RFI_is_about_to_be_overdue</template>
    </alerts>
    <alerts>
        <fullName>Ticket_Escalation_to_the_Escalation_Email</fullName>
        <description>Ticket Escalation to the Escalation Email</description>
        <protected>false</protected>
        <recipients>
            <field>GLOBAL_Escalation_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>customerservices@hounslow.gov.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>LBH_Automatic_Notifications/TICKET_SLA_is_about_to_be_overdue</template>
    </alerts>
    <alerts>
        <fullName>Ticket_Escalation_to_the_Owner</fullName>
        <description>Ticket Escalation to the Owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>customerservices@hounslow.gov.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>LBH_Automatic_Notifications/TICKET_SLA_is_about_to_be_overdue</template>
    </alerts>
    <alerts>
        <fullName>Ticket_SLA_Breached_Alert_CS_to_Owner</fullName>
        <description>Ticket SLA Breached Alert CustServ to Owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>customerservices@hounslow.gov.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>LBH_Automatic_Notifications/TICKET_SLA_Overdue</template>
    </alerts>
    <alerts>
        <fullName>Ticket_SLA_Breached_Alert_RFI_to_Esc_Email</fullName>
        <description>Ticket SLA RFI Breached Alert to Esc Email</description>
        <protected>false</protected>
        <recipients>
            <field>GLOBAL_Escalation_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>customerrelations@hounslow.gov.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>LBH_Automatic_Notifications/TICKET_RFI_SLA_Overdue</template>
    </alerts>
    <alerts>
        <fullName>Ticket_SLA_Breached_Alert_RFI_to_Owner</fullName>
        <description>Ticket SLA RFI Breached Alert to Owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>customerrelations@hounslow.gov.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>LBH_Automatic_Notifications/TICKET_RFI_SLA_Overdue</template>
    </alerts>
    <alerts>
        <fullName>Ticket_SLA_Breached_Alert_to_Esc_Email</fullName>
        <description>Ticket SLA Breached Alert to Esc Email</description>
        <protected>false</protected>
        <recipients>
            <field>GLOBAL_Escalation_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>customerservices@hounslow.gov.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>LBH_Automatic_Notifications/TICKET_SLA_Overdue</template>
    </alerts>
    <alerts>
        <fullName>Ticket_SLA_Breached_Alert_to_Owner</fullName>
        <description>Ticket SLA Breached Alert to Owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>customerservices@hounslow.gov.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>LBH_Automatic_Notifications/TICKET_SLA_Overdue</template>
    </alerts>
    <alerts>
        <fullName>Ticket_SLA_Breached_Alertto_Esc_Email</fullName>
        <description>Ticket SLA Complaints Breached Alert to Esc Email</description>
        <protected>false</protected>
        <recipients>
            <field>GLOBAL_Escalation_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>customerrelations@hounslow.gov.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>LBH_Automatic_Notifications/TICKET_Complaints_SLA_Overdue</template>
    </alerts>
    <alerts>
        <fullName>Ticket_SLA_Breached_Alertto_Owner</fullName>
        <description>Ticket SLA Complaints Breached Alert to Owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderAddress>customerrelations@hounslow.gov.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>LBH_Automatic_Notifications/TICKET_Complaints_SLA_Overdue</template>
    </alerts>
    <alerts>
        <fullName>Ticket_SLA_Breached_CS_Alert_to_Esc_Email</fullName>
        <description>Ticket SLA Breached Alert CustServ to Esc Email</description>
        <protected>false</protected>
        <recipients>
            <field>GLOBAL_Escalation_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>customerservices@hounslow.gov.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>LBH_Automatic_Notifications/TICKET_SLA_Overdue</template>
    </alerts>
    <fieldUpdates>
        <fullName>Close_ticket</fullName>
        <field>GLOBAL_Ticket_Status__c</field>
        <literalValue>Closed</literalValue>
        <name>Close ticket</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Datestamp_Esc_email_to_esc_email</fullName>
        <description>Record the datetime that the ESC email was sent to the escalation queue</description>
        <field>GLOBAL_Auto_Esc_Email_to_Esc_Email__c</field>
        <formula>NOW()</formula>
        <name>Datestamp Esc email to esc email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Datestamp_Esc_email_to_owner</fullName>
        <description>Record the datetime that the ESC email was sent to the ticket owner</description>
        <field>GLOBAL_Auto_Esc_Email_Sent_to_Owner__c</field>
        <formula>NOW()</formula>
        <name>Datestamp Esc email to owner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Datestamp_SLA_Breach_email_to_escalation</fullName>
        <description>Record the datetime that the SLA breach email was sent to the escalation email</description>
        <field>GLOBALAuto_SLA_Breach_Email_to_EscEmail__c</field>
        <formula>NOW()</formula>
        <name>Datestamp SLA Breach email to escalation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Datestamp_SLA_Breach_email_to_owner</fullName>
        <description>Record the datetime that the SLA breach email was sent to the owner</description>
        <field>GLOBAL_Auto_SLA_Breach_Sent_Owner__c</field>
        <formula>NOW()</formula>
        <name>Datestamp SLA Breach email to owner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Highways_Location_Generic</fullName>
        <description>If location of Highways ticket is not found on Target, users ticks Hounslow Borough checkbox, which should populate Location field.</description>
        <field>HHW_Location__c</field>
        <formula>&quot;Hounslow Borough&quot;</formula>
        <name>Highways Location Borough</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IsReopenTicket_to_False</fullName>
        <description>Set Reopened Ticket checkbox to unchecked</description>
        <field>GLOBAL_IsReopenTicket__c</field>
        <literalValue>0</literalValue>
        <name>IsReopenTicket to False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Acknowledgement_Days</fullName>
        <description>Sets the number of complaint acknowledgement days</description>
        <field>GLOBAL_Days_to_Acknowledge__c</field>
        <formula>2</formula>
        <name>Set Acknowledgement Days</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Date_Reply_Sent_to_Today</fullName>
        <description>Set Date Reply Sent to today</description>
        <field>GLOBAL_Reply_Sent_Date__c</field>
        <formula>TODAY()</formula>
        <name>Set Date Reply Sent to Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Opened_Date</fullName>
        <description>Set Opened Date to Today</description>
        <field>GLOBAL_Opened_Date__c</field>
        <formula>TODAY()</formula>
        <name>Set Opened Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Ticket_Status_to_Closed</fullName>
        <description>Set Ticket Status to Closed</description>
        <field>GLOBAL_Ticket_Status__c</field>
        <literalValue>Closed</literalValue>
        <name>Set Ticket Status to Closed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Ticket_Status_to_Open</fullName>
        <description>Set Ticket Status to Open</description>
        <field>GLOBAL_Ticket_Status__c</field>
        <literalValue>Open</literalValue>
        <name>Set Ticket Status to Open</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_closed_date_to_today</fullName>
        <description>Sets the closed date field to today.</description>
        <field>GLOBAL_Closed_Date__c</field>
        <formula>Today()</formula>
        <name>Set closed date to today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_to_Breach_on_Manual_Resolution</fullName>
        <description>Set Status to Breach</description>
        <field>GLOBAL_Ticket_Status__c</field>
        <literalValue>SLA Breach</literalValue>
        <name>Status to Breach</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_to_Escalated</fullName>
        <description>Set Ticket Status to Escalated</description>
        <field>GLOBAL_Ticket_Status__c</field>
        <literalValue>Escalated</literalValue>
        <name>Status to Escalated</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>T_Default_Received_Date</fullName>
        <description>Set default value of received date to Created date</description>
        <field>GLOBAL_Received_Date__c</field>
        <formula>GLOBAL_Ticket_Date_Created__c</formula>
        <name>T_Default Received Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>T_Default_SLA_for_Complaints</fullName>
        <description>Complaints/Enquiry SLA should be defaulted to 10 Days</description>
        <field>GLOBAL_Active_SLA__c</field>
        <literalValue>10 Working Days</literalValue>
        <name>T_Default SLA for Complaints</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>T_SLA_Set_Status_Escalate</fullName>
        <description>Set Ticket Status to Escalated</description>
        <field>GLOBAL_Ticket_Status__c</field>
        <literalValue>Escalated</literalValue>
        <name>T_SLA Set Status Escalate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>T_SLA_default_for_RFI</fullName>
        <description>SLA for FIO should be defaulted to 20 days</description>
        <field>GLOBAL_Active_SLA__c</field>
        <literalValue>20 Working Days</literalValue>
        <name>T_SLA default for RFI</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>T_Set_Calendar_Days_Elapsed_to_zero</fullName>
        <description>Set Calendar Days Elapsed to zero on Goal</description>
        <field>GLOBAL_Calendar_Days_Elapsed__c</field>
        <formula>0</formula>
        <name>T_Set Calendar Days Elapsed to zero</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>T_Set_Days_on_Hold_to_null</fullName>
        <description>Set Days on Hold to 0 for Ticket</description>
        <field>GLOBAL_Continuous_Working_Days_on_Hold__c</field>
        <formula>0</formula>
        <name>T_Set Days on Hold to null</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>T_Set_SLA_Breached_Status</fullName>
        <description>Set SLA Breached Status on Goal</description>
        <field>GLOBAL_Ticket_Status__c</field>
        <literalValue>SLA Breach</literalValue>
        <name>T_Set SLA Breached Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>T_Set_WorkingDaysElapsed_to_0_When_Open</fullName>
        <description>When Ticket Status is changed to Open, set the number of Working Days Elapsed to zero</description>
        <field>GLOBAL_Working_Days_Elapsed__c</field>
        <formula>0</formula>
        <name>T_Set WorkingDaysElapsed to 0 When Open</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ticket_Off_Hold_Set_Opened_Date_to_Today</fullName>
        <description>When Goal Status is changed from On Hold, set Opened Date to today&apos;s date</description>
        <field>GLOBAL_Opened_Date__c</field>
        <formula>TODAY()</formula>
        <name>Ticket Off Hold Set Opened Date to Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Authorised_Date</fullName>
        <description>Update the Authorised Date when the Authorised checkbox is ticked</description>
        <field>FIN_Authorised_Date__c</field>
        <formula>Today()</formula>
        <name>Update Authorised Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status</fullName>
        <description>Update Status to Open</description>
        <field>GLOBAL_Ticket_Status__c</field>
        <literalValue>Open</literalValue>
        <name>Update Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Highways Location Generic</fullName>
        <actions>
            <name>Highways_Location_Generic</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Ticket__c.HHW_Hounslow_Borough__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>If user can not find an address via Target, they tick Hounslow Highway checkbox. This should populate Location.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TICKET - Close Ticket When Reply Sent</fullName>
        <actions>
            <name>Close_ticket</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>When a date is entered into the reply sent field or the date resolved field close the ticket.</description>
        <formula>( ISCHANGED( GLOBAL_Reply_Sent_Date__c ) &amp;&amp; !ISNULL(GLOBAL_Reply_Sent_Date__c) ) || ( ISCHANGED(  GLOBAL_Date_Resolved__c  ) &amp;&amp; !ISNULL(GLOBAL_Date_Resolved__c) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>TICKET - Perform Closing Actions</fullName>
        <actions>
            <name>Set_Date_Reply_Sent_to_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_closed_date_to_today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>When a ticket is closed perform these actions.</description>
        <formula>ISPICKVAL(GLOBAL_Ticket_Status__c, &quot;Closed&quot;) &amp;&amp;  ISCHANGED(GLOBAL_Ticket_Status__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>TICKET Close Inactive Record</fullName>
        <actions>
            <name>Set_Ticket_Status_to_Closed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Ticket__c.GLOBAL_Continuous_Working_Days_on_Hold__c</field>
            <operation>greaterThan</operation>
            <value>20</value>
        </criteriaItems>
        <criteriaItems>
            <field>Ticket__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>CCC - FOI</value>
        </criteriaItems>
        <description>If Continuous Working Days on Hold &gt; 20 &amp; Sub-Type is Make an FOI request, Status changed to Closed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TICKET Default Received Date</fullName>
        <actions>
            <name>T_Default_Received_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Set default value of received date to Created date (when record is created) but only if the user has not specified their own received date</description>
        <formula>ISNULL( GLOBAL_Received_Date__c )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>TICKET Perform Breach actions for Manual Resolution Date ticket to esc email</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Ticket__c.GLOBAL_Ticket_Status__c</field>
            <operation>equals</operation>
            <value>Escalated,Open</value>
        </criteriaItems>
        <criteriaItems>
            <field>Ticket__c.CMP_Manual_Resolution_Date_Agreed__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Ticket__c.GLOBAL_Escalation_Email__c</field>
            <operation>contains</operation>
            <value>@</value>
        </criteriaItems>
        <description>Perform Breach actions for Manual Resolution Date ticket  to esc email</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Ticket_SLA_Breached_Alertto_Esc_Email</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>Datestamp_SLA_Breach_email_to_escalation</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>Breach_Notification_Sent_to_Escalation_Queue</name>
                <type>Task</type>
            </actions>
            <offsetFromField>Ticket__c.CMP_Agreed_Resolution_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>TICKET Perform Breach actions for Manual Resolution Date ticket to owner</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Ticket__c.GLOBAL_Ticket_Status__c</field>
            <operation>equals</operation>
            <value>Escalated,Open</value>
        </criteriaItems>
        <criteriaItems>
            <field>Ticket__c.CMP_Manual_Resolution_Date_Agreed__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Perform Breach actions for Manual Resolution Date ticket  to owner</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Ticket_SLA_Breached_Alertto_Owner</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>Datestamp_SLA_Breach_email_to_owner</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>Status_to_Breach_on_Manual_Resolution</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>Breach_Notification_Sent_to_Owner</name>
                <type>Task</type>
            </actions>
            <offsetFromField>Ticket__c.CMP_Agreed_Resolution_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>TICKET Perform Escalation actions for Manual Resolution Date ticket to esc email</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Ticket__c.GLOBAL_Ticket_Status__c</field>
            <operation>equals</operation>
            <value>Escalated,Open</value>
        </criteriaItems>
        <criteriaItems>
            <field>Ticket__c.CMP_Manual_Resolution_Date_Agreed__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Ticket__c.GLOBAL_Escalation_Email__c</field>
            <operation>contains</operation>
            <value>@</value>
        </criteriaItems>
        <description>TICKET Perform Escalation actions for Manual Resolution Date ticket to esc email</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Ticket_Escalation_Complaints_to_the_Escalation_Email</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>Datestamp_Esc_email_to_esc_email</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>Escalation_Email_Sent_to_Escalation_Queue</name>
                <type>Task</type>
            </actions>
            <offsetFromField>Ticket__c.CMP_Agreed_Resolution_Reminder_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>TICKET Perform Escalation actions for Manual Resolution Date ticket to owner</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Ticket__c.GLOBAL_Ticket_Status__c</field>
            <operation>equals</operation>
            <value>Open</value>
        </criteriaItems>
        <criteriaItems>
            <field>Ticket__c.CMP_Manual_Resolution_Date_Agreed__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>TICKET Perform Escalation actions for Manual Resolution Date ticket to owner</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Ticket_Escalation_Complaints_to_the_Owner</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>Datestamp_Esc_email_to_owner</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>Status_to_Escalated</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>Escalation_Email_Sent_to_Owner</name>
                <type>Task</type>
            </actions>
            <offsetFromField>Ticket__c.CMP_Agreed_Resolution_Reminder_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>TICKET Perform SLA Breach Actions</fullName>
        <actions>
            <name>Ticket_SLA_Breached_Alert_to_Esc_Email</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Ticket_SLA_Breached_Alert_to_Owner</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>When Ticket Status was changed to SLA Breached, send email alert to the Ticket owner and escalation email</description>
        <formula>IF ( GLOBAL_SLA__r.Working_Days__c = TRUE,   GLOBAL_Working_Days_Elapsed__c &gt; GLOBAL_SLA__r.SLA_Length_Days__c ,   GLOBAL_Calendar_Days_Elapsed__c &gt; GLOBAL_SLA__r.SLA_Length_Days__c)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TICKET Perform SLA Breach Actions Complaint</fullName>
        <actions>
            <name>Ticket_SLA_Breached_Alertto_Esc_Email</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Ticket_SLA_Breached_Alertto_Owner</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Customer Relations Team, complaint: When Ticket Status was changed to SLA Breached, send email alert to the Ticket owner and escalation email</description>
        <formula>IF (  
    RecordType.DeveloperName = &quot;CCC_Complaints&quot;    &amp;&amp;  GLOBAL_SLA__r.Working_Days__c = TRUE,
    GLOBAL_Working_Days_Elapsed__c  &gt; GLOBAL_SLA__r.SLA_Length_Days__c ,   
    GLOBAL_Calendar_Days_Elapsed__c &gt; GLOBAL_SLA__r.SLA_Length_Days__c
)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TICKET Perform SLA Breach Actions Complaint to Escalation Email</fullName>
        <actions>
            <name>Ticket_SLA_Breached_Alertto_Esc_Email</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Datestamp_SLA_Breach_email_to_escalation</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Breach_Notification_Sent_to_Escalation_Queue</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <description>Customer Relations Team, complaint: WhenBreach Actions Complaint to Owner Ticket Status was changed to SLA Breached, send email alert to the  escalation email</description>
        <formula>IF (       CONTAINS(RecordType.DeveloperName, &quot;Complaint&quot;)   &amp;&amp;  ISBLANK(  GLOBALAuto_SLA_Breach_Email_to_EscEmail__c  )&amp;&amp; !ISBLANK( GLOBAL_Escalation_Email__c ),     IF (         GLOBAL_SLA__r.Working_Days__c = TRUE,            GLOBAL_Working_Days_Elapsed__c &gt;= GLOBAL_SLA__r.SLA_Length_Days__c ,         GLOBAL_Calendar_Days_Elapsed__c &gt;= GLOBAL_SLA__r.SLA_Length_Days__c     ),     FALSE )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TICKET Perform SLA Breach Actions Complaint to Owner</fullName>
        <actions>
            <name>Ticket_SLA_Breached_Alertto_Owner</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Datestamp_SLA_Breach_email_to_owner</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Breach_Notification_Sent_to_Owner</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <description>Customer Relations Team, complaint: When Ticket Status was changed to SLA Breached, send email alert to the Ticket owner</description>
        <formula>IF (      CONTAINS(RecordType.DeveloperName, &quot;Complaint&quot;)   &amp;&amp;  ISBLANK( GLOBAL_Auto_SLA_Breach_Sent_Owner__c ),     IF (         GLOBAL_SLA__r.Working_Days__c = TRUE,            GLOBAL_Working_Days_Elapsed__c &gt;= GLOBAL_SLA__r.SLA_Length_Days__c ,         GLOBAL_Calendar_Days_Elapsed__c &gt;= GLOBAL_SLA__r.SLA_Length_Days__c     ),     FALSE )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TICKET Perform SLA Breach Actions CustServ</fullName>
        <actions>
            <name>Ticket_SLA_Breached_Alert_CS_to_Owner</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Ticket_SLA_Breached_CS_Alert_to_Esc_Email</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Customer Services: When Ticket Status was changed to SLA Breached, send email alert to the Ticket owner and escalation email</description>
        <formula>IF (( RecordType.DeveloperName = &quot;CCC_Default&quot; ||  RecordType.DeveloperName = &quot;CCC_Other&quot; ||  RecordType.DeveloperName = &quot;CCC_Payment&quot; ||  RecordType.DeveloperName = &quot;Environmental_Projects&quot; ||  RecordType.DeveloperName = &quot;Highways&quot; ||  RecordType.DeveloperName = &quot;Street_Care_Team&quot; )   &amp;&amp;  GLOBAL_SLA__r.Working_Days__c = TRUE,   GLOBAL_Working_Days_Elapsed__c &gt; GLOBAL_SLA__r.SLA_Length_Days__c ,   GLOBAL_Calendar_Days_Elapsed__c &gt; GLOBAL_SLA__r.SLA_Length_Days__c)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TICKET Perform SLA Breach Actions CustServ to Escalation Email</fullName>
        <actions>
            <name>Ticket_SLA_Breached_CS_Alert_to_Esc_Email</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Datestamp_SLA_Breach_email_to_escalation</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Breach_Notification_Sent_to_Escalation_Queue</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <description>Customer Services: When Ticket Status was changed to SLA Breached, send email alert to the Escalation email (unless it is blank)</description>
        <formula>IF (      ISBLANK(  GLOBALAuto_SLA_Breach_Email_to_EscEmail__c  ) &amp;&amp; !ISBLANK( GLOBAL_Escalation_Email__c ) &amp;&amp;  NOT( CONTAINS(RecordType.DeveloperName, &quot;Complaint&quot;)  ||  RecordType.DeveloperName = &quot;CCC_Request_for_Information&quot; ),         IF (         GLOBAL_SLA__r.Working_Days__c = TRUE,            GLOBAL_Working_Days_Elapsed__c &gt;= GLOBAL_SLA__r.SLA_Length_Days__c ,            GLOBAL_Calendar_Days_Elapsed__c &gt;= GLOBAL_SLA__r.SLA_Length_Days__c     ),     FALSE )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TICKET Perform SLA Breach Actions CustServ to Owner</fullName>
        <actions>
            <name>Ticket_SLA_Breached_Alert_CS_to_Owner</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Datestamp_SLA_Breach_email_to_owner</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Breach_Notification_Sent_to_Owner</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <description>Customer Services: When Ticket Status was changed to SLA Breached, send email alert to the Ticket owner</description>
        <formula>IF (      ISBLANK( GLOBAL_Auto_SLA_Breach_Sent_Owner__c ) &amp;&amp; NOT(CONTAINS(RecordType.DeveloperName, &quot;Complaint&quot;)   ||  RecordType.DeveloperName = &quot;CCC_Request_for_Information&quot; ) ,         IF (         GLOBAL_SLA__r.Working_Days__c = TRUE,            GLOBAL_Working_Days_Elapsed__c &gt;= GLOBAL_SLA__r.SLA_Length_Days__c ,            GLOBAL_Calendar_Days_Elapsed__c &gt;= GLOBAL_SLA__r.SLA_Length_Days__c     ),     FALSE )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TICKET Perform SLA Breach Actions RFI</fullName>
        <actions>
            <name>Ticket_SLA_Breached_Alert_RFI_to_Esc_Email</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Ticket_SLA_Breached_Alert_RFI_to_Owner</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Customer Relations Team, RFI: When Ticket Status was changed to SLA Breached, send email alert to the Ticket owner and escalation email</description>
        <formula>IF (   RecordType.DeveloperName = &quot;CCC_Request_for_Information&quot;   &amp;&amp;  GLOBAL_SLA__r.Working_Days__c = TRUE,   GLOBAL_Working_Days_Elapsed__c &gt; GLOBAL_SLA__r.SLA_Length_Days__c ,   GLOBAL_Calendar_Days_Elapsed__c &gt; GLOBAL_SLA__r.SLA_Length_Days__c)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TICKET Perform SLA Breach Actions RFI to Escalation Email</fullName>
        <actions>
            <name>Ticket_SLA_Breached_Alert_RFI_to_Esc_Email</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Datestamp_SLA_Breach_email_to_escalation</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Breach_Notification_Sent_to_Escalation_Queue</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <description>Customer Relations Team, RFI: When Ticket Status was changed to SLA Breached, send email alert to the Ticket escalatiation email (if it is not blank)</description>
        <formula>IF (        RecordType.DeveloperName = &quot;CCC_Request_for_Information&quot; &amp;&amp; !ISBLANK( GLOBAL_Escalation_Email__c ) &amp;&amp; ISBLANK(GLOBALAuto_SLA_Breach_Email_to_EscEmail__c) ,      IF (          GLOBAL_SLA__r.Working_Days__c = TRUE,            GLOBAL_Working_Days_Elapsed__c &gt;= GLOBAL_SLA__r.SLA_Length_Days__c ,                GLOBAL_Calendar_Days_Elapsed__c &gt;= GLOBAL_SLA__r.SLA_Length_Days__c     ),     FALSE )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TICKET Perform SLA Breach Actions RFI to Owner</fullName>
        <actions>
            <name>Ticket_SLA_Breached_Alert_RFI_to_Owner</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Datestamp_SLA_Breach_email_to_owner</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Breach_Notification_Sent_to_Owner</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <description>Customer Relations Team, RFI: When Ticket Status was changed to SLA Breached, send email alert to the Ticket owner</description>
        <formula>IF (        RecordType.DeveloperName = &quot;CCC_Request_for_Information&quot; &amp;&amp; ISBLANK( GLOBAL_Auto_SLA_Breach_Sent_Owner__c ),     IF (          GLOBAL_SLA__r.Working_Days__c = TRUE,            GLOBAL_Working_Days_Elapsed__c &gt;= GLOBAL_SLA__r.SLA_Length_Days__c ,                GLOBAL_Calendar_Days_Elapsed__c &gt;= GLOBAL_SLA__r.SLA_Length_Days__c     ),     FALSE )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TICKET SLA Escalation Actions Complaints to Escalation Email</fullName>
        <actions>
            <name>Ticket_Escalation_Complaints_to_the_Escalation_Email</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Datestamp_Esc_email_to_esc_email</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Escalation_Email_Sent_to_Escalation_Queue</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <description>Customer Relations Team: When Ticket Status was changed to Escalated, send email to the Ticket escalation email if it is not blank</description>
        <formula>IF(        ISBLANK(  GLOBAL_Auto_Esc_Email_to_Esc_Email__c ) &amp;&amp; CONTAINS(RecordType.DeveloperName, &quot;Complaint&quot;)    &amp;&amp;   NOT(ISBLANK(GLOBAL_Escalation_Email__c)) &amp;&amp; GLOBAL_SLA_Days_Remaining__c &gt; 0  &amp;&amp;  GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c &lt;&gt; 0,         IF( GLOBAL_SLA__r.Working_Days__c = TRUE ,        GLOBAL_Working_Days_Elapsed__c &gt;= ( GLOBAL_SLA__r.SLA_Length_Days__c - GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c ),      GLOBAL_Calendar_Days_Elapsed__c &gt;= ( GLOBAL_SLA__r.SLA_Length_Days__c - GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c )     ),        FALSE )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TICKET SLA Escalation Actions CustServ to Escalation Email</fullName>
        <actions>
            <name>Ticket_Escalation_CS_to_the_Escalation_Email</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Datestamp_Esc_email_to_esc_email</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Escalation_Email_Sent_to_Escalation_Queue</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <description>Customer Services: When Ticket Status was changed to Escalated, send email to the Ticket Escalation email if not blank</description>
        <formula>IF(     ISBLANK(  GLOBAL_Auto_Esc_Email_to_Esc_Email__c )  &amp;&amp; NOT( CONTAINS(RecordType.DeveloperName, &quot;Complaint&quot;)   ||  RecordType.DeveloperName = &quot;CCC_Request_for_Information&quot; )  &amp;&amp;   NOT(ISBLANK(GLOBAL_Escalation_Email__c  )) &amp;&amp; GLOBAL_SLA_Days_Remaining__c &gt; 0  &amp;&amp;  GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c &lt;&gt; 0,         IF(          GLOBAL_SLA__r.Working_Days__c = TRUE ,            GLOBAL_Working_Days_Elapsed__c &gt;= ( GLOBAL_SLA__r.SLA_Length_Days__c - GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c ),            GLOBAL_Calendar_Days_Elapsed__c &gt;= ( GLOBAL_SLA__r.SLA_Length_Days__c - GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c )     ),     FALSE )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TICKET SLA Escalation Actions CustServ to Owner</fullName>
        <actions>
            <name>Ticket_Escalation_CS_to_the_Owner</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Datestamp_Esc_email_to_owner</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Escalation_Email_Sent_to_Owner</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <description>Customer Services: When Ticket Status was changed to Escalated, send email to the Ticket owner</description>
        <formula>IF(          ISBLANK(  GLOBAL_Auto_Esc_Email_Sent_to_Owner__c  )  &amp;&amp; NOT( CONTAINS(RecordType.DeveloperName, &quot;Complaint&quot;)   ||  RecordType.DeveloperName = &quot;CCC_Request_for_Information&quot; )  &amp;&amp; GLOBAL_SLA_Days_Remaining__c &gt; 0  &amp;&amp;  GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c &lt;&gt; 0,              IF(                   GLOBAL_SLA__r.Working_Days__c = TRUE ,                     GLOBAL_Working_Days_Elapsed__c &gt;= ( GLOBAL_SLA__r.SLA_Length_Days__c - GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c ),                             GLOBAL_Calendar_Days_Elapsed__c &gt;= ( GLOBAL_SLA__r.SLA_Length_Days__c - GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c )          ),          FALSE  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TICKET SLA Escalation Actions RFI to Escalation Email</fullName>
        <actions>
            <name>Ticket_Escalation_RFI_to_the_Escalation_Email</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Datestamp_Esc_email_to_esc_email</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Escalation_Email_Sent_to_Escalation_Queue</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <description>Customer Relations Team, RFI tickets: When Ticket Status was changed to Escalated, send email to the Ticket escalation email (if not blank)</description>
        <formula>IF(     ISBLANK(  GLOBAL_Auto_Esc_Email_to_Esc_Email__c )  &amp;&amp; RecordType.DeveloperName = &quot;CCC_Request_for_Information&quot;  &amp;&amp;   NOT(ISBLANK(GLOBAL_Escalation_Email__c  )) &amp;&amp; GLOBAL_SLA_Days_Remaining__c &gt; 0  &amp;&amp;  GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c &lt;&gt; 0,         IF(          GLOBAL_SLA__r.Working_Days__c = TRUE ,            GLOBAL_Working_Days_Elapsed__c &gt;= ( GLOBAL_SLA__r.SLA_Length_Days__c - GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c ),            GLOBAL_Calendar_Days_Elapsed__c &gt;= ( GLOBAL_SLA__r.SLA_Length_Days__c - GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c )     ),     FALSE )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TICKET SLA Escalation Actions to Escalation Email</fullName>
        <actions>
            <name>Ticket_Escalation_to_the_Escalation_Email</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>When Ticket Status was changed to Escalated, send email to the Ticket owner</description>
        <formula>IF(   NOT(ISBLANK(GLOBAL_Escalation_Email__c  )) &amp;&amp; GLOBAL_SLA_Days_Remaining__c &gt; 0  &amp;&amp;  GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c &lt;&gt; 0,    IF( GLOBAL_SLA__r.Working_Days__c = TRUE ,   GLOBAL_Working_Days_Elapsed__c &gt;= ( GLOBAL_SLA__r.SLA_Length_Days__c - GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c ),   GLOBAL_Calendar_Days_Elapsed__c &gt;= ( GLOBAL_SLA__r.SLA_Length_Days__c - GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c )),   null)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TICKET SLA Escalation Actions to Owner</fullName>
        <actions>
            <name>Ticket_Escalation_to_the_Owner</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>When Ticket Status was changed to Escalated, send email to the Ticket owner</description>
        <formula>IF(  ISBLANK(GLOBAL_Escalation_Email__c  ) &amp;&amp; GLOBAL_SLA_Days_Remaining__c &gt; 0  &amp;&amp;  GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c &lt;&gt; 0,    IF( GLOBAL_SLA__r.Working_Days__c = TRUE ,   GLOBAL_Working_Days_Elapsed__c &gt;= ( GLOBAL_SLA__r.SLA_Length_Days__c - GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c ),   GLOBAL_Calendar_Days_Elapsed__c &gt;= ( GLOBAL_SLA__r.SLA_Length_Days__c - GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c )),   null)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TICKET SLA Escalation Actions to Owner Complaint</fullName>
        <actions>
            <name>Ticket_Escalation_Complaints_to_the_Owner</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Datestamp_Esc_email_to_owner</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Escalation_Email_Sent_to_Owner</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <description>Customer Relations Team, Complaint: When Ticket Status was changed to Escalated, send email to the Ticket owner</description>
        <formula>IF(       ISBLANK( GLOBAL_Auto_Esc_Email_Sent_to_Owner__c ) &amp;&amp;  CONTAINS(RecordType.DeveloperName, &quot;Complaint&quot;)    &amp;&amp;   GLOBAL_SLA_Days_Remaining__c &gt; 0  &amp;&amp;  GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c &lt;&gt; 0,         IF(          GLOBAL_SLA__r.Working_Days__c = TRUE ,            GLOBAL_Working_Days_Elapsed__c &gt;= ( GLOBAL_SLA__r.SLA_Length_Days__c - GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c ),   GLOBAL_Calendar_Days_Elapsed__c &gt;= ( GLOBAL_SLA__r.SLA_Length_Days__c - GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c )     ),     FALSE )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TICKET SLA Escalation Actions to Owner RFI</fullName>
        <actions>
            <name>Ticket_Escalation_RFI_to_the_Owner</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Datestamp_Esc_email_to_owner</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Escalation_Email_Sent_to_Owner</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <description>Customer Relations Team, RFI: When Ticket Status was changed to Escalated, send email to the Ticket owner</description>
        <formula>IF(     ISBLANK(   GLOBAL_Auto_Esc_Email_Sent_to_Owner__c  )  &amp;&amp; RecordType.DeveloperName = &quot;CCC_Request_for_Information&quot;  &amp;&amp;   GLOBAL_SLA_Days_Remaining__c &gt; 0  &amp;&amp;  GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c &lt;&gt; 0,         IF(          GLOBAL_SLA__r.Working_Days__c = TRUE ,            GLOBAL_Working_Days_Elapsed__c &gt;= ( GLOBAL_SLA__r.SLA_Length_Days__c - GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c ),            GLOBAL_Calendar_Days_Elapsed__c &gt;= ( GLOBAL_SLA__r.SLA_Length_Days__c - GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c )     ),     FALSE )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TICKET SLA On Hold Days</fullName>
        <actions>
            <name>T_Set_Days_on_Hold_to_null</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Ticket__c.GLOBAL_Ticket_Status__c</field>
            <operation>notEqual</operation>
            <value>On Hold</value>
        </criteriaItems>
        <description>Set Days on Hold to null when Status is not On Hold</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TICKET SLA Set Breached Status</fullName>
        <actions>
            <name>T_Set_SLA_Breached_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Set Ticket status SLA Breached when Days Elapsed are more than SLA days</description>
        <formula>IF ( GLOBAL_SLA__r.Working_Days__c = TRUE,        GLOBAL_Working_Days_Elapsed__c &gt;= GLOBAL_SLA__r.SLA_Length_Days__c ,        GLOBAL_Calendar_Days_Elapsed__c &gt;= GLOBAL_SLA__r.SLA_Length_Days__c)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TICKET SLA Set Status Escalated</fullName>
        <actions>
            <name>T_SLA_Set_Status_Escalate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Set Escalated status on Ticket when it should be auto-escalated based on Escalate prior SLA days</description>
        <formula>IF(  GLOBAL_SLA_Days_Remaining__c &gt; 0  &amp;&amp; GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c &lt;&gt; 0,   IF( GLOBAL_SLA__r.Working_Days__c = TRUE ,    GLOBAL_Working_Days_Elapsed__c &gt;= (  GLOBAL_SLA__r.SLA_Length_Days__c -  GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c ),    GLOBAL_Calendar_Days_Elapsed__c &gt;= (  GLOBAL_SLA__r.SLA_Length_Days__c -  GLOBAL_SLA__r.Escalation_Prior_to_SLA_Breach_Days__c )),   null)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TICKET SLA Set Status Open</fullName>
        <actions>
            <name>IsReopenTicket_to_False</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Opened_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Ticket_Status_to_Open</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>T_Set_Calendar_Days_Elapsed_to_zero</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>T_Set_WorkingDaysElapsed_to_0_When_Open</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Ticket__c.GLOBAL_IsReopenTicket__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>When Record was manually reopened via button, set the number of Days Elapsed to 0, Goal&apos;s status to Open and Set Opened Date to today.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TICKET SLA Take Off Hold</fullName>
        <actions>
            <name>Ticket_Off_Hold_Set_Opened_Date_to_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Ticket__c.GLOBAL_Ticket_Status__c</field>
            <operation>equals</operation>
            <value>Open</value>
        </criteriaItems>
        <description>When Ticket status is changed to Open from being on hold, Set Opened Date as today, keep the record of Days Elapsed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TICKET SLA default for Complaints</fullName>
        <actions>
            <name>T_Default_SLA_for_Complaints</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Ticket__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>CCC - Complaints</value>
        </criteriaItems>
        <description>Complaints/Enquiry SLA should be defaulted to 10 Days</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>TICKET SLA default for FOI</fullName>
        <actions>
            <name>T_SLA_default_for_RFI</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Ticket__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>CCC - Request for Information</value>
        </criteriaItems>
        <criteriaItems>
            <field>Ticket__c.FOI_Type__c</field>
            <operation>equals</operation>
            <value>FOI</value>
        </criteriaItems>
        <description>SLA for FIO should be defaulted to 20 days</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>TICKET_Finance_authorised_change_status</fullName>
        <actions>
            <name>Update_Authorised_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Ticket__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>CSC - Finance - Agresso Actions</value>
        </criteriaItems>
        <criteriaItems>
            <field>Ticket__c.FIN_Authorised__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Ticket__c.GLOBAL_Ticket_Status__c</field>
            <operation>equals</operation>
            <value>Draft</value>
        </criteriaItems>
        <description>If Authorised checkbox is ticked, and Status is Draft, change Status to Open</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Opened Date</fullName>
        <actions>
            <name>Set_Opened_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Ticket__c.GLOBAL_Ticket_Status__c</field>
            <operation>equals</operation>
            <value>Open</value>
        </criteriaItems>
        <description>When status of a ticket record is set to Open: set the Opened date for the ticket to today</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Ticket Closed Date</fullName>
        <actions>
            <name>Set_closed_date_to_today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>When a ticket records status is set to Closed: set the Closed date for the ticket to today.</description>
        <formula>ISPICKVAL(GLOBAL_Ticket_Status__c, &quot;Closed&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update no of open tickets on goal</fullName>
        <active>false</active>
        <description>Update the number of open tickets a goal has</description>
        <formula>ISNEW() ||  ISCHANGED( GLOBAL_Ticket_Status__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <tasks>
        <fullName>Breach_Notification_Sent_to_Escalation_Queue</fullName>
        <assignedTo>administrator@lbh.sf</assignedTo>
        <assignedToType>user</assignedToType>
        <description>An SLA Breach Notification has been sen to the email address contained in the escalation queue of the tickets current owning queue of the ticket</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Ticket__c.CreatedDate</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Breach Notification Sent to Escalation Queue</subject>
    </tasks>
    <tasks>
        <fullName>Breach_Notification_Sent_to_Owner</fullName>
        <assignedTo>administrator@lbh.sf</assignedTo>
        <assignedToType>user</assignedToType>
        <description>An SLA breach notification has been sen to the ticket owner</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Ticket__c.CreatedDate</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Breach Notification Sent to Owner</subject>
    </tasks>
    <tasks>
        <fullName>Escalation_Email_Sent_to_Escalation_Queue</fullName>
        <assignedTo>administrator@lbh.sf</assignedTo>
        <assignedToType>user</assignedToType>
        <description>An escalation email has been sen to the email address contained in the escalation queue of the tickets current owning queue</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Ticket__c.CreatedDate</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Escalation Email Sent to Escalation Queue</subject>
    </tasks>
    <tasks>
        <fullName>Escalation_Email_Sent_to_Owner</fullName>
        <assignedTo>administrator@lbh.sf</assignedTo>
        <assignedToType>user</assignedToType>
        <description>An escalation email has been sen to the ticket owner</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Ticket__c.CreatedDate</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Escalation Email Sent to Owner</subject>
    </tasks>
</Workflow>
