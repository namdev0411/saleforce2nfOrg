import { LightningElement, track, wire } from 'lwc';
import getAllOrgs from '@salesforce/apex/GenDeloyScript.getAllOrgs';
export default class GenDeloyScript extends LightningElement {

    @track OrgDatas = [];
    @track selectedOrg = {};

    connectedCallback(){
        getAllOrgs()
        .then(result=>{
            this.OrgDatas = result;
            this.selectedOrg = result.length > 0 ? result[0].Name: '';
        }).catch((error)=>{
            console.log(JSON.stringify(error));
        })
    }

    get OrgOptions(){
        const options = [];
        this.OrgDatas.forEach(org=>{
            options.push({
                label: org.Name,
                value: org.Name
            });
        })
        return options;
    }

    handleClick(){
        
    }

    handleChange(e){
        const value = e.target.value;
        this.selectedOrg = value;
        console.log(value);
    }
}