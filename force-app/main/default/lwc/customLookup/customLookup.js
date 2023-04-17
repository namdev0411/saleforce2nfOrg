import { api, LightningElement, wire } from 'lwc';
import getLookupOptionsQuery from '@salesforce/apex/CustomLookup.getLookupOptionsQuery';
import getLookupOptionsByParams from '@salesforce/apex/CustomLookup.getLookupOptionsByParams';

export default class CustomLookup extends LightningElement {
    
    @api objectApiName = 'Account';
    @api filterFields = '';
    @api selectFields = ['Id, Name'];

    filterValue;
    soqlFilter;

    @wire(getLookupOptionsByParams, {objectApiName: '$objectApiName', soqlFilter: '$soqlFilter', selectFields: '$selectFields'})
    wireGetOpption;

}