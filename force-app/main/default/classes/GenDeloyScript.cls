public with sharing class GenDeloyScript {
    
    @AuraEnabled
    public static List<Org__c> getAllOrgs(){
        try {
            return [SELECT Name FROM Org__c LIMIT 50000];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}