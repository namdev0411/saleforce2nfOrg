public with sharing class CMSController {
    public CMSController() {

    }


    @AuraEnabled(cacheable = true)
    public static List<ContentDto> getAllContentByChannel(String channelName,Integer pageParam,Integer pageSize ,String language,
        String managedContentType, Boolean includeMetadata, String startDate ,String endDate){

        //ctDtoForReturn
        List<ContentDto> ctDtoForReturn = new List<ContentDto>();

        if (channelName <> null) {
            channelName = channelName.trim();
        }

        try {
            //validation
            if(!validationRequestContent(channelName)){
                throw new CMSControllerException('channelName is required!');
            }

            String channelId = getChannelIdByChannelName(channelName);
            if (channelId == null) {
                throw new CMSControllerException('channelName is not found!');
            }

            // if (endDate == null) {
            //     endDate = System.now().formatGmt('yyyy-MM-dd\'T\'HH:mm:ssXXX');
            // }
            
            ConnectApi.ManagedContentVersionCollection mnContent = ConnectApi.ManagedContent.getAllContent(
                channelId,
                pageParam,
                pageSize,
                language,
                managedContentType,
                includeMetadata,
                startDate,
                endDate
            );

            //ContentVersion
            List<ConnectApi.ManagedContentVersion> items = mnContent.items;

            if (items <> null) {
                for (ConnectApi.ManagedContentVersion item : items) {
                    ContentDto cdDto = new ContentDto();
                    cdDto.title = item.title;

                    //get url
                    Map<String, ConnectApi.ManagedContentNodeValue> noteMap = item.contentNodes;
                    for (String str : noteMap.keySet()) {
                        if (str == 'source') {
                            cdDto.url = ((ConnectApi.ManagedContentMediaSourceNodeValue)noteMap.get(str)).url;
                        }
                    }

                    ctDtoForReturn.add(cdDto);
                }
            }

            return ctDtoForReturn;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        
    }

    /*
        getChannelIdByChannelName
    */
    public static String getChannelIdByChannelName(String channelName){
        ConnectApi.ManagedContentChannelCollection mchannelColls = 
        ConnectApi.ManagedContent.getAllDeliveryChannels(0,25);

        List<ConnectApi.ManagedContentChannel> mchannels = mchannelColls.channels;
        for (ConnectApi.ManagedContentChannel channel : mchannels) {
            if (channel.channelName == channelName) {
                return channel.channelId;
            }
        }
        return null;
    }

    public static Boolean validationRequestContent(String channelName){
        if (channelName == null) {
            return false;
        }

        return true;
    }

    class ContentDto {
        @AuraEnabled
        public String title {get;set;}
        @AuraEnabled
        public String url {get;set;}
    }

    class CMSControllerException extends Exception{}
}