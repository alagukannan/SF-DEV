@RestResource(urlMapping='/registrations/v2/*')
global  class  registrationV2Controller {
	
	

	@HttpGet
    global static string doGet(){
        string message = 'error';      
        string token = RestContext.request.params.get('token');
        string status = RestContext.request.params.get('status').toLowercase().capitalize();
        if(RCCEnums.PARTICIPANT_STATUS_VALUES.contains(status))
        {
            List<alagukannan__Participant__c> participant = [select Id,alagukannan__Event__r.Name,alagukannan__Event__r.Id,alagukannan__Event__r.alagukannan__Start_Time__c,alagukannan__Event__r.alagukannan__Status__c,alagukannan__Event__r.alagukannan__description__c,alagukannan__Event__r.alagukannan__Guest_Count__c,alagukannan__Event__r.alagukannan__Participant_Count__c,alagukannan__Event__r.alagukannan__Total_Maybe__c,alagukannan__Event__r.alagukannan__Total_No__c,alagukannan__Event__r.alagukannan__Total_Yes__c,alagukannan__Event__r.alagukannan__Ground__r.Name,
                alagukannan__status__c,alagukannan__Guests__c,alagukannan__Comments__c, alagukannan__Player__r.Name from alagukannan__Participant__c where  alagukannan__token__c = :token];

            if(participant.size() == 1)
            {
                alagukannan__Participant__c participantRecord = participant[0];
                List<alagukannan__Participant__c> participants = [select Id,alagukannan__Player__r.Name,alagukannan__status__c,alagukannan__Guests__c,alagukannan__Comments__c from alagukannan__Participant__c where  alagukannan__Event__r.Id = :participantRecord.alagukannan__Event__r.Id]; 

                
            }
            else if (participant.size() > 1)
            {
                throw new QueryException('Multiple Records found for token : ' + token);
            }
            else
            {
                throw new QueryException('Invalid');
            }
        }
        

        return message;
    }

    @HttpPost
    global static Boolean create() {

        return false;

    }


}