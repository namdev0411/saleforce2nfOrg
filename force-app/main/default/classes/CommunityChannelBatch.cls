global class CommunityChannelBatch implements Database.Batchable<SObject> {

    global CommunityChannelBatch() {
        
    }
    
    global static void startBatch (Integer batchSize){
		CommunityChannelBatch bt = new CommunityChannelBatch();
        Database.executeBatch(bt, batchSize);
    }

    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id, Name,Type FROM ManagedContentChannel';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<ManagedContentChannel> scope) {
        List<CommunityChannel__c> cms = new List<CommunityChannel__c>();
        for(ManagedContentChannel mcc : scope) {
            CommunityChannel__c cm = new CommunityChannel__c();
            cm.Name = mcc.Name;
            cm.ChannelId__c = mcc.Id;
            cm.ChannelType__c = mcc.Type;
            cms.add(cm);
        }
        upsert cms ChannelId__c;
    }

    global void finish(Database.BatchableContext BC) {
        // Perform any post-processing tasks
        System.debug('Batch job finished successfully.');
    }
}