public with sharing class participantInsertBefore implements ParticipantTriggerController.HandlerInterface {
	
	Configs myconfig = Configs.getInstance();
	helper myhelper = helper.getInstance();

	public participantInsertBefore() {
	}
	public void handle()
	{
	}

	public void handle(List<SObject> beforeNewList){

		List<alagukannan__Participant__c> newInsertedParticpants = (List<alagukannan__Participant__c>)trigger.new;
		for (alagukannan__Participant__c participant : newInsertedParticpants)
		{
			if (string.isnotblank(participant.alagukannan__token__c))
			{
				participant.alagukannan__token__c = myhelper.generateRandomString(myconfig.tokenLength);	
			}
			
		}
	}		
}