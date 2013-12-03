<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Escalation_to_the_Owner</fullName>
        <description>Escalation to the Owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>LBH_Automatic_Notifications/GOAL_Goal_Escalation_notification_Generic</template>
    </alerts>
    <alerts>
        <fullName>SLA_Breached</fullName>
        <description>SLA Breached</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>LBH_Automatic_Notifications/GOAL_Goal_SLA_Breach_notification_Generic</template>
    </alerts>
    <fieldUpdates>
        <fullName>Days_Opened_zero</fullName>
        <description>Set the number of Working Days Elapsed to zero</description>
        <field>Working_Days_Elapsed__c</field>
        <formula>0</formula>
        <name>Set WorkingDaysElapsed to zero</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>GOAL_SUBJECT_Update</fullName>
        <field>Subject</field>
        <formula>Case_Summary__c</formula>
        <name>GOAL SUBJECT Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>GOAL_Set_Days_on_Hold_to_null</fullName>
        <description>Set number of coninuous working days on Hold to null</description>
        <field>Continuous_Working_Days_on_Hold__c</field>
        <formula>null</formula>
        <name>GOAL Set Days on Hold to null</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Goal_Escalate</fullName>
        <description>Set Goal Status to Escalated</description>
        <field>Status</field>
        <literalValue>Escalated</literalValue>
        <name>SLA Set Status Escalate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Goal_Off_Hold_Set_Opened_Date_to_Today</fullName>
        <description>When Goal Status is changed from On Hold, set Opened Date to today&apos;s date</description>
        <field>Opened_Date__c</field>
        <formula>TODAY()</formula>
        <name>Goal Off Hold Set Opened Date to Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Goal_SLA_default_for_RFI</fullName>
        <description>Default SLA for RFI should be defaulted to 20 days</description>
        <field>Active_SLA__c</field>
        <literalValue>20 Working Days</literalValue>
        <name>GOAL SLA default for RFI</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IsReopenGoal_to_False</fullName>
        <description>Set Reopened Goal checkbox to unchecked</description>
        <field>IsReopenGoal__c</field>
        <literalValue>0</literalValue>
        <name>IsReopenGoal to False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SLA_default_for_Complaint</fullName>
        <field>Active_SLA__c</field>
        <literalValue>10 Working Days</literalValue>
        <name>SLA default for Complaint</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Calendar_Days_Elapsed_to_zero</fullName>
        <description>Set Calendar Days Elapsed to zero on Goal</description>
        <field>Calendar_Days_Elapsed__c</field>
        <formula>0</formula>
        <name>Set Calendar Days Elapsed to zero</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Case_Reply_Sent_Date_to_Today</fullName>
        <field>Reply_Sent_Date__c</field>
        <formula>TODAY()</formula>
        <name>Set Case Reply Sent Date to Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Customer_Default_comm_pref_to_email</fullName>
        <description>Set customer comm pref to email.</description>
        <field>Preferred_Contact_Method__c</field>
        <literalValue>Email</literalValue>
        <name>Set Customer Default comm pref to email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Goal_Status_to_Close</fullName>
        <description>Set Goal Status to Close</description>
        <field>Status</field>
        <literalValue>Closed</literalValue>
        <name>Set Goal Status to Close</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Goal_Status_to_Open</fullName>
        <description>Set Goal Status to Open</description>
        <field>Status</field>
        <literalValue>Open</literalValue>
        <name>Set Goal Status to Open</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_SLA_Breached_Status</fullName>
        <description>Set SLA Breached Status on Goal</description>
        <field>Status</field>
        <literalValue>SLA Breached</literalValue>
        <name>Set SLA Breached Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Email_Subject</fullName>
        <field>Email_Subject__c</field>
        <formula>&quot;New Email&quot;</formula>
        <name>Update Email Subject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_date_opened_field</fullName>
        <description>Set Open Date to Today on Goal</description>
        <field>Opened_Date__c</field>
        <formula>TODAY()</formula>
        <name>Update date opened field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>CASE - Close ticket when reply Sent</fullName>
        <actions>
            <name>Set_Goal_Status_to_Close</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>When a date is entered into the reply sent field close the case.</description>
        <formula>ISCHANGED( Reply_Sent_Date__c ) &amp;&amp; !ISNULL(Reply_Sent_Date__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CASE - Perform Closing Actions</fullName>
        <actions>
            <name>Set_Case_Reply_Sent_Date_to_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>When a case closes perform these actions.</description>
        <formula>ISCHANGED( Status ) &amp;&amp;  ISPICKVAL(Status , &quot;Closed&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>GOAL Close Inactive Record</fullName>
        <actions>
            <name>Set_Goal_Status_to_Close</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Continuous_Working_Days_on_Hold__c</field>
            <operation>greaterThan</operation>
            <value>20</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Goal_Sub_Type__c</field>
            <operation>equals</operation>
            <value>Make an FOI request</value>
        </criteriaItems>
        <description>If Continuous Working Days on Hold &gt; 20 &amp; Sub-Type is Make an FOI request, Status changed to Closed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>GOAL Perform SLA Breach Actions</fullName>
        <actions>
            <name>SLA_Breached</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>When Goal Status was changed to SLA Breached, send email alert to the Goal owner</description>
        <formula>IF ( SLA__r.Working_Days__c = TRUE,  Working_Days_Elapsed__c &gt; SLA__r.SLA_Length_Days__c,  Calendar_Days_Elapsed__c &gt; SLA__r.SLA_Length_Days__c)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>GOAL SLA Default sla value Complaint</fullName>
        <actions>
            <name>SLA_default_for_Complaint</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Case_Summary__c</field>
            <operation>contains</operation>
            <value>Complaint</value>
        </criteriaItems>
        <description>Complaints/Enquiry SLA should be defaulted to 10 Days</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>GOAL SLA Escalation Actions to Owner</fullName>
        <actions>
            <name>Escalation_to_the_Owner</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>When Goal Status was changed to Escalated, send email to the owner</description>
        <formula>IF( SLA__r.Escalation_Prior_to_SLA_Breach_Days__c &lt;&gt; 0 &amp;&amp; SLA_Days_Remaining__c &gt; 0,   IF(SLA__r.Working_Days__c = TRUE ,   Working_Days_Elapsed__c &gt;= ( SLA__r.SLA_Length_Days__c - SLA__r.Escalation_Prior_to_SLA_Breach_Days__c ),   Calendar_Days_Elapsed__c &gt;= ( SLA__r.SLA_Length_Days__c - SLA__r.Escalation_Prior_to_SLA_Breach_Days__c )),   null)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>GOAL SLA On Hold Days</fullName>
        <actions>
            <name>GOAL_Set_Days_on_Hold_to_null</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>On Hold</value>
        </criteriaItems>
        <description>Set Days on Hold to null when Status is not On Hold</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>GOAL SLA Set Breached Status</fullName>
        <actions>
            <name>Set_SLA_Breached_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Set Goal status SLA Breached when Days Elapsed are more than SLA days</description>
        <formula>IF ( SLA__r.Working_Days__c = TRUE, Working_Days_Elapsed__c &gt;   SLA__r.SLA_Length_Days__c, Calendar_Days_Elapsed__c &gt;   SLA__r.SLA_Length_Days__c)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>GOAL SLA Set Status Escalated</fullName>
        <actions>
            <name>Goal_Escalate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Set Escalated status on Goal when it should be auto-escalated based on Escalate prior SLA days</description>
        <formula>IF( SLA__r.Escalation_Prior_to_SLA_Breach_Days__c &lt;&gt; 0 &amp;&amp;  SLA_Days_Remaining__c  &gt; 0,   IF(SLA__r.Working_Days__c = TRUE ,   Working_Days_Elapsed__c &gt;= ( SLA__r.SLA_Length_Days__c - SLA__r.Escalation_Prior_to_SLA_Breach_Days__c ),   Calendar_Days_Elapsed__c &gt;= ( SLA__r.SLA_Length_Days__c - SLA__r.Escalation_Prior_to_SLA_Breach_Days__c )),   null)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>GOAL SLA Set Status Open</fullName>
        <actions>
            <name>Days_Opened_zero</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>IsReopenGoal_to_False</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Calendar_Days_Elapsed_to_zero</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Goal_Status_to_Open</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_date_opened_field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.IsReopenGoal__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>When Record was manually reopened via button, set the number of Days Elapsed to 0, Goal&apos;s status to Open and Set Opened Date to today.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>GOAL SLA Take Off Hold</fullName>
        <actions>
            <name>Goal_Off_Hold_Set_Opened_Date_to_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Open</value>
        </criteriaItems>
        <description>When Goal status is changed to Open from being on hold, Set Opened Date as today, keep the record of Days Elapsed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>GOAL SLA default for FOI</fullName>
        <actions>
            <name>Goal_SLA_default_for_RFI</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Case_Summary__c</field>
            <operation>contains</operation>
            <value>Request for Information</value>
        </criteriaItems>
        <description>SLA for FIO should be defaulted to 20 days</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>GOAL SUBJECT - Set to Summary</fullName>
        <actions>
            <name>GOAL_SUBJECT_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Set the subject to the summary field.</description>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Email Comm Pref</fullName>
        <actions>
            <name>Set_Customer_Default_comm_pref_to_email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If the person account for the customer has an email comm preference set this on the goal unless a comm preference has already been entered on the goal.</description>
        <formula>ISPICKVAL(Contact.Account.Person_Preferred_Contact_Method__c , &apos;Email&apos;) &amp;&amp; ISPICKVAL( Preferred_Contact_Method__c , &quot;&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set case account anonymous if checked</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Case.Anonymous_Customer__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>If the anonymous account field is checked on a goal (case), set the account to be a specific account.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Open Date</fullName>
        <actions>
            <name>Update_date_opened_field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Open</value>
        </criteriaItems>
        <description>When the goal status changes to open update the goal opened time</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
