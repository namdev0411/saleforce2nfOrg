public with sharing class SyncCmsContentQueue implements Queueable{
    public String channelId;

    public SyncCmsContentQueue(String channelId){
        this.channelId = channelId;
    }

    public void execute(QueueableContext context) {
        
        List<CMSController.ContentDto> ContentDtos =  CMSController.getAllContentByChannelId(
            this.channelId
        );

        List<ContentManaged__c> ctms = new  List<ContentManaged__c>();
        
        for (CMSController.ContentDto cto : ContentDtos) {
            CommunityChannel__c cmc = new CommunityChannel__c(
                ChannelId__c = this.channelId
            );

            ContentManaged__c ctm = new ContentManaged__c(
                Name = cto.title,
                ContentUrl__c = cto.url,
                ContentType__c = cto.type,
                ContentKey__c = cto.contentKey,
                CommunityChannel__r = cmc
            );
            ctms.add(ctm);
        }

        upsert ctms ContentKey__c;
    }
}