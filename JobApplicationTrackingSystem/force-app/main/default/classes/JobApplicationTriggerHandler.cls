public with sharing class JobApplicationTriggerHandler {
    public static void scheduleInterview(
        List<Job_Application__c> applications,
        Map<Id,Job_Application__c> oldMap
        ){

            List<Interview__c> interviews = new List<Interview__c>();
            List<Id> applicationIds = new List<Id>();

            for(Job_Application__c app: applications){
                Job_Application__c old = oldMap.get(app.Id);
                if(app.Application_Status__c == 'Interview Scheduled' 
                    && old.Application_Status__c != 'Interview Scheduled'
                ){
                    Interview__c interview = new Interview__c(
                        Job_Application__c = app.Id,
                        Interview_Status__c = 'Scheduled',
                        Interview_Type__c = 'HR',
                        Interview_Date__c = System.now().addDays(2)
                    );

                    interviews.add(interview);
                    applicationIds.add(app.Id);
                }
            }

            if(!interviews.isEmpty()){
                insert interviews;
            }

            if(!applicationIds.isEmpty()){
                // send emails asynchronously --> with @future method
                RecruitmentAsyncService.sendInterviewEmails(applicationIds);
            }

    }
    public static void screenCandidates(List<Job_Application__c> applications){
        // store new candidte ids in a set
        Set<Id> candidateIds = new Set<Id>();
        Set<Id> jobId = new Set<Id>();
        for(Job_Application__c app: applications){
            if(app.Candidate__c != null ){
                candidateIds.add(app.Candidate__c);
            }

            if(app.Job_Opening__c != null){
                jobId.add(app.Job_Opening__c);
            }
        }

        Map<Id,Candidate__c> candidateMap = new Map<Id,Candidate__c>(
            [
                SELECT Id,
                    Experience_Years__c
                FROM Candidate__c
                WHERE Id IN: candidateIds    
            ]
        );

        Map<Id,Job_Opening__c> jobMap = new Map<Id,Job_Opening__c>([
            SELECT Id,
                Required_Experience__c
                FROM Job_Opening__c
                WHERE Id IN: jobId
        ]);

        for(Job_Application__c app: applications){
            Candidate__c candidate = candidateMap.get(app.Candidate__c);

            Job_Opening__c jobs = jobMap.get(app.Job_Opening__c);

            if(candidate != null && jobs != null){

                if(candidate.Experience_Years__c >= jobs.Required_Experience__c){
                    app.Application_Status__c = 'Screening';
                }
                else{
                    app.Application_Status__c = 'Rejected';
                }
            }
        }
    }
}