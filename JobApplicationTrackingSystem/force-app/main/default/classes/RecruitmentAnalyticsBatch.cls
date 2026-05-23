public class RecruitmentAnalyticsBatch
implements Database.Batchable<SObject> {

    public Database.QueryLocator start(

        Database.BatchableContext bc

    ){

        return Database.getQueryLocator(

            [

                SELECT Id,
                       Application_Status__c
                FROM Job_Application__c

            ]

        );

    }

    public void execute(

        Database.BatchableContext bc,
        List<Job_Application__c> scope

    ){

        Integer selectedCount = 0;
        Integer rejectedCount = 0;
        Integer interviewCount = 0;

        for(Job_Application__c app : scope){

            if(app.Application_Status__c
                == 'Selected'){

                selectedCount++;

            }

            else if(app.Application_Status__c
                == 'Rejected'){

                rejectedCount++;

            }

            else if(app.Application_Status__c
                == 'Interview Scheduled'){

                interviewCount++;

            }

        }

        System.debug(
            'Selected Candidates: '
            + selectedCount
        );

        System.debug(
            'Rejected Candidates: '
            + rejectedCount
        );

        System.debug(
            'Interview Scheduled: '
            + interviewCount
        );

    }

    public void finish(

        Database.BatchableContext bc

    ){

        System.debug(
            'Recruitment Analytics Batch Completed'
        );

    }

}