import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import CargaInfoSipweb from '@salesforce/apex/consultaTarifasWW_CTR.CargaInfoSipweb';
const fields = ['Account.Id_SIpWeb__c']
const Columns = [{label: 'Cliente', fieldName: 'clntId', type:'text'},{label: 'Rango KM', fieldName: 'rangoKm', type:'text'}];
export default class ConsultaTarifasWW extends LightningElement {
    @api recordId;
    strError;
    strResponse;
    objResponse;
    account;
    Id_SIpWeb;
    Columns = Columns;
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
            .then(Respuesta => {
                console.log('Response recibido: ' + Respuesta);
                if(Respuesta !== null && Respuesta !== ''){
                    this.objResponse = JSON.parse(Respuesta)
                    console.log('convertido: ' + this.objResponse.body.response.data.ptpConfig[0].ptpServicesTrif[0].orgnSite);
                }
            }).catch(error => {
                console.log('Error: ' + error);
            })
    }
}
