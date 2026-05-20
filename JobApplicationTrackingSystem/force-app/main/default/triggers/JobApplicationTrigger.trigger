trigger JobApplicationTrigger on Job_Application__c (
    before insert,
    after update
    ) {
    if(Trigger.isBefore && Trigger.isInsert){
        JobApplicationTriggerHandler.screenCandidates(Trigger.NEW);
    }

    if(trigger.isAfter && trigger.isUpdate){
        
    }
}