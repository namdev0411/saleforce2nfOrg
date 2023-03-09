global with sharing class CommunityChannelSchedule implements Schedulable{
    global void execute(SchedulableContext sc) {
        CommunityChannelBatch.startBatch(200);
    }

    // To schedule the job, use the following code:
    // String schedule = '0 0/15 * * * ?'; // Runs daily at midnight
    // MyScheduledJob job = new MyScheduledJob();
    // System.schedule('チャンネル同期', sch, m);
}