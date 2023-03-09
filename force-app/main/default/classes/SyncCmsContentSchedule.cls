global with sharing class SyncCmsContentSchedule implements Schedulable{
    global void execute(SchedulableContext sc) {
        SyncCmsContentQueue sq = new SyncCmsContentQueue('0ap5g000000xROFAA2');
        System.enqueueJob(sq);
    }
}

