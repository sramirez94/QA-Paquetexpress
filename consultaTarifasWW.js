import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import CargaInfoSipweb from '@salesforce/apex/consultaTarifasWW_CTR.CargaInfoSipweb';
const fields = ['Account.Id_SIpWeb__c']
export default class ConsultaTarifasWW extends LightningElement {
    @api recordId;
    account;
    Id_SIpWeb;
    @wire(getRecord, { recordId: '$recordId', fields : fields})
    wiredRecord({ error, data }) {
        if (error) {
            let message = 'Unknown error';
            if (Array.isArray(error.body)) {
                message = error.body.map(e => e.message).join(', ');
            } else if (typeof error.body.message === 'string') {
                message = error.body.message;
            }
        } else if (data){
            this.account = data;
            this.Id_SIpWeb = this.account.fields.Id_SIpWeb__c.value;
        }
        this.getConveniosWW();
    }
    getConveniosWW(){
        CargaInfoSipweb({
            idSipweb : this.Id_SIpWeb
        })
    }
    /*renderedCallback(){
        var delay = 5000;
        setTimeout(function(){
            console.log('id sipweb: ' + getFieldValue(this.account.data, Id_SIpWeb));
        }, delay);
    }
    handleClick(event){
        console.log('id sipweb: ' + getFieldValue(this.account.data, Id_SIpWeb));
        CargaInfoSipweb({
            idSipweb : getFieldValue(this.account.data, Id_SIpWeb)
        })
        console.log('variable obtenida del controlador: ' + blnPtpConfig);
    }*/
}
