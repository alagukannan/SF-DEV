@RestResource(urlMapping='/registrations/*')
global  class registrationController  {

    @HttpGet
    global static string show() {
        string message = 'error';
        set<string> STATUS_VALUES = new set<string>{'Yes', 'No', 'Maybe'};
        string token = RestContext.request.params.get('token');
        string status = RestContext.request.params.get('status').toLowercase().capitalize();
        if(STATUS_VALUES.contains(status))
        {
            List<alagukannan__Participant__c> participantRecords = [select Id,alagukannan__Event__r.Name,alagukannan__Event__r.Id,alagukannan__status__c from alagukannan__Participant__c where  alagukannan__token__c = :token and alagukannan__Event__r.alagukannan__Status__c = 'Active'];
            if(participantRecords.size() == 1)
            {
                alagukannan__Participant__c participantRecord = participantRecords[0];
                if (participantRecord.alagukannan__status__c != status)
                {
                    participantRecord.alagukannan__status__c = status;
                    update participantRecord;                    
                }
                message = 'Thank you for responding  ' + status + ' for event ' + participantRecord.alagukannan__Event__r.Name + '. We will send a email confirmation soon.' ;

                if(status == 'Yes' || status == 'Maybe')
                {
                 List<alagukannan__Participant__c> participantYesRecords = [select Id,alagukannan__Player__r.Name,alagukannan__status__c from alagukannan__Participant__c where  alagukannan__Event__r.Id = :participantRecord.alagukannan__Event__r.Id and alagukannan__status__c in ('Yes','Maybe')]; 
                    message =  message + ' Other Confirmed Players : ';
                    for (alagukannan__Participant__c yesParticipant : participantYesRecords)
                    {
                        if(yesParticipant.alagukannan__status__c == 'Yes')
                            message = message +  yesParticipant.alagukannan__Player__r.Name +',';
                    }
                    message = message + ' . May be Players: ';
                    for (alagukannan__Participant__c maybeParticipant : participantYesRecords)
                    {
                        if(maybeParticipant.alagukannan__status__c == 'Maybe')
                            message = message +  maybeParticipant.alagukannan__Player__r.Name +',';
                    }
                }
                
            }
            else if (participantRecords.size() > 1)
            {
                throw new QueryException('Multiple Records found for token : ' + token);
            }
            else
            {
                // do nothing
            }
        }
        

        return message;
    }
/*
    @HttpPost
    global static alagukannan__Participant__c create() {

        alagukannan__Participant__c obj;

        return obj;

    }

    @HttpPut
    global static alagukannan__Participant__c updateObject() {

        alagukannan__Participant__c obj;

        return obj;

    }

    @HttpDelete
    global static void remove() {

    }
*/
}