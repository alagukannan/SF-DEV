trigger ParticipantTrigger on alagukannan__Participant__c (
	before insert, 
	before update, 
	before delete, 
	after insert, 
	after update, 
	after delete, 
	after undelete) {

    ParticipantTriggerController myhandler = new ParticipantTriggerController();
    myhandler
        .bind(ParticipantTriggerController.Evt.beforeinsert, new participantInsertBefore());  
    myhandler.manage();
}