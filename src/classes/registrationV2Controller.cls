@RestResource(urlMapping='/registrations/v2/*')
global  class  registrationV2Controller {
	
	

	@HttpGet
    global static participantResponseV2 doGet(){
        string message = 'error';      
        string token = RestContext.request.params.get('token');

        List<alagukannan__Participant__c> participant = [select Id,alagukannan__Event__r.Name,alagukannan__Event__r.Id,alagukannan__Event__r.alagukannan__Start_Time__c,alagukannan__Event__r.alagukannan__Status__c,alagukannan__Event__r.alagukannan__description__c,alagukannan__Event__r.alagukannan__Guest_Count__c,alagukannan__Event__r.alagukannan__Participant_Count__c,alagukannan__Event__r.alagukannan__Total_Maybe__c,alagukannan__Event__r.alagukannan__Total_No__c,alagukannan__Event__r.alagukannan__Total_Yes__c,alagukannan__Event__r.alagukannan__Ground__r.Name,
            alagukannan__status__c,alagukannan__Guests__c,alagukannan__Comments__c, alagukannan__Player__r.Name from alagukannan__Participant__c where  alagukannan__token__c = :token];

        if(participant.size() == 1)
        {
            alagukannan__Participant__c participantRecord = participant[0];
            List<alagukannan__Participant__c> participants = [select Id,alagukannan__Player__r.Name,alagukannan__status__c,alagukannan__Guests__c,alagukannan__Comments__c from alagukannan__Participant__c where  alagukannan__Event__r.Id = :participantRecord.alagukannan__Event__r.Id]; 

            //lets build the response object
            participantResponseV2 res = new participantResponseV2();
            res.Participant = new participantResponseV2.Participant(participantRecord.Id,participantRecord.alagukannan__Player__r.Name, participantRecord.alagukannan__status__c, participantRecord.alagukannan__Guests__c, participantRecord.alagukannan__Comments__c);
            res.event = new participantResponseV2.event();
            res.event.Id = participantRecord.alagukannan__Event__r.Id;
            res.event.Name = participantRecord.alagukannan__Event__r.Name;
            res.event.status = participantRecord.alagukannan__Event__r.alagukannan__status__c;
            res.event.starttime = participantRecord.alagukannan__Event__r.alagukannan__Start_Time__c;
            res.event.description = participantRecord.alagukannan__Event__r.alagukannan__description__c;
            res.event.Ground = new participantResponseV2.Ground(participantRecord.alagukannan__Event__r.alagukannan__Ground__r.Id, participantRecord.alagukannan__Event__r.alagukannan__Ground__r.Name);
            res.event.totalGuestCount = participantRecord.alagukannan__Event__r.alagukannan__Guest_Count__c;
            res.event.totalYesCount = participantRecord.alagukannan__Event__r.alagukannan__Total_Yes__c;
            res.event.totalNoCount= participantRecord.alagukannan__Event__r.alagukannan__Total_No__c;
            res.event.totalMaybeCount = participantRecord.alagukannan__Event__r.alagukannan__Total_Maybe__c;
            res.event.totalParticipantCount = participantRecord.alagukannan__Event__r.alagukannan__Participant_Count__c;
            res.event.participants= new List<participantResponseV2.Participant>();

            for(alagukannan__Participant__c player : participants)
            {
               participantResponseV2.Participant tempParticipant = new participantResponseV2.Participant(player.Id,player.alagukannan__Player__r.Name, player.alagukannan__status__c, player.alagukannan__Guests__c, player.alagukannan__Comments__c);                   
                res.event.participants.add(tempParticipant);
            }
            return res;
            
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

    @HttpPost
    global static void doUpdate(Id id, String token, String status, decimal guests, String comments)
    {
        RestResponse response = RestContext.response;
        response.statusCode = 200;
        response.responseBody = BLob.valueof(Id + ' ' + token + ' ' + status + ' ' + guests + ' ' + comments); 

        if(RCCEnums.PARTICIPANT_STATUS_VALUES.contains(status))
        {
            List<alagukannan__Participant__c> participantRecords = [select Id,alagukannan__status__c,alagukannan__Guests__c,alagukannan__Comments__c from alagukannan__Participant__c where  alagukannan__token__c = :token and alagukannan__Event__r.alagukannan__Status__c = : RCCEnums.EVENT_STATUS_VALUES.name()];
            if(participantRecords.size() == 1)
            {
                alagukannan__Participant__c participant = participantRecords[0];
                if (participant.alagukannan__status__c != status)
                {
                    participant.alagukannan__status__c = status;
                    if (string.isnotblank(comments))
                        participant.alagukannan__Comments__c = comments;
                    if(guests != Null)
                        participant.alagukannan__Guests__c = guests;
                    

                    update participant;                    
                }
            }
            else if (participantRecords.size() > 1)
            {
                throw new QueryException('Multiple Records found for token : ' + token);
                response.statusCode = 500;
            }
            else
            {
                // do nothing
            }
        }
        else
        {
            response.statusCode = 406;
        }


        return;
    }


}