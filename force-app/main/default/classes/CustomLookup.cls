public with sharing class CustomLookup {
    
    @AuraEnabled(cacheable = true)
    public static List<sObject> getLookupOptionsQuery(String query){
        try {
            return Database.query(query);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable = true)
    public static List<sObject> getLookupOptionsByParams(String objectApiName, String soqlFilter, List<String> selectFields){
        try {
            String soql = 'SELECT ';

            for(Integer i = 0; i < selectFields.size(); i++){
                if (i == selectFields.size() -1) {
                    soql += selectFields[i];
                }else {
                    soql += selectFields[i] + ', ';
                }
            }

            soql += ' FROM ';
            soql += objectApiName;
            soql += ' WHERE ';
            soql += soqlFilter;

            return Database.query(soql);

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}