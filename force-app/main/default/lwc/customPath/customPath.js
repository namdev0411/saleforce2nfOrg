import { LightningElement, track } from 'lwc';

export default class CustomPath extends LightningElement {
    @track pathData = [
        {
            name: 'Step1',
            isCurrent: true,
            isComplete: false
        },
        {   
            name: 'Step2',
            isCurrent: false,
            isComplete: false
        },
        {   
            name: 'Step3',
            isCurrent: false,
            isComplete: false
        }
    ]
    
    get pathDataDto(){
        if(this.pathData && this.pathData.length > 0){
            const converted = this.pathData.map(item =>({
                name: item.name,
                class: item.isCurrent ? 'slds-path__item slds-is-current slds-is-active' : item.isComplete ? 'slds-path__item slds-is-complete' : 'slds-path__item slds-is-incomplete',
            }))

            return converted;
        }
        return [];
    }
}