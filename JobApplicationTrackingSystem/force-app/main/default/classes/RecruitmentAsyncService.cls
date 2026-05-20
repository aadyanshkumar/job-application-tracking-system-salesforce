public class RecruitmentAsyncService {

    @future
    public static void sendInterviewEmails(

        List<Id> applicationIds

    ){

        List<Job_Application__c> applications = [

            SELECT Id,
                   Candidate__r.Email__c,
                   Candidate__r.Name,
                   Job_Opening__r.Name
            FROM Job_Application__c
            WHERE Id IN :applicationIds

        ];

        List<Messaging.SingleEmailMessage>
            emails =
                new List<Messaging.SingleEmailMessage>();

        for(Job_Application__c app : applications){

            if(app.Candidate__r.Email__c != null){

                Messaging.SingleEmailMessage
                    mail =
                        new Messaging.SingleEmailMessage();

                mail.setToAddresses(

                    new List<String>{

                        app.Candidate__r.Email__c

                    }

                );

                mail.setSubject(
                    'Interview Scheduled'
                );

                mail.setPlainTextBody(

                    'Hello '
                    + app.Candidate__r.Name +

                    ', your interview for '
                    + app.Job_Opening__r.Name +

                    ' has been scheduled.'

                );

                emails.add(mail);

            }

        }

        if(!emails.isEmpty()){

            Messaging.sendEmail(emails);

        }

    }

}