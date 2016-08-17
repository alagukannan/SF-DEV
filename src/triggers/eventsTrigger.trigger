trigger eventsTrigger on alagukannan__Event__c (
	before insert, 
	before update, 
	before delete, 
	after insert, 
	after update, 
	after delete, 
	after undelete) {

    EventsDomainController myhandler = new EventsDomainController();
    myhandler
        .bind(EventsDomainController.Evt.afterinsert, new EventsInsertAfterHandler());  
    myhandler.manage();
}