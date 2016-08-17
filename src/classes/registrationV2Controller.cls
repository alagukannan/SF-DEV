@RestResource(urlMapping='/registrations/v2/*')
global  class  registrationV2Controller {
	
	

	@HttpGet
    global static string doGet(){
        string message = 'error';      
        string token = RestContext.request.params.get('token');
        string status = RestContext.request.params.get('status').toLowercase().capitalize();
        if(RCCProperties.PARTICIPANT_STATUS_VALUES.contains(status))
        {
            List<alagukannan__Participant__c> participantRecords = [select Id,alagukannan__Event__r.Name,alagukannan__Event__r.Id,alagukannan__status__c,alagukannan__Guests__c,alagukannan__Comments__c, alagukannan__Player__r.Name from alagukannan__Participant__c where  alagukannan__token__c = :token and alagukannan__Event__r.alagukannan__Status__c = :RCCEnums.EVENT_STATUS_VALUES.Active.Name()];

            if(participantRecords.size() == 1)
            {
                alagukannan__Participant__c participantRecord = participantRecords[0];
                List<alagukannan__Participant__c> participants = [select Id,alagukannan__Player__r.Name,alagukannan__status__c,alagukannan__Guests__c,alagukannan__Comments__c from alagukannan__Participant__c where  alagukannan__Event__r.Id = :participantRecord.alagukannan__Event__r.Id]; 

                
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

    @HttpPost
    global static Boolean create() {

        return false;

    }


}