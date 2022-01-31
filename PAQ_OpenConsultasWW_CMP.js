import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import {NavigationMixin} from 'lightning/navigation';
const fields = ['Account.Id_SIpWeb__c'];
export default class PAQ_OpenConsultasWW_CMP extends NavigationMixin(LightningElement) {
    @api recordId; //Salvador Ramírez (sramirez@freewayconsulting.com): Guarda el id de la cuenta
    Id_SIpWeb; //Salvador Ramírez (sramirez@freewayconsulting.com): Guardará el ID de sipweb de la cuenta
    account; //Salvador Ramírez (sramirez@freewayconsulting.com): Guardará los datos del objeto cuenta
    @wire(getRecord, { recordId: '$recordId', fields : fields}) //Salvador Ramírez (sramirez@freewayconsulting.com): Se obtiene el id del registro
    wiredRecord({ error, data }) {
        if (error) {
            let message = 'Unknown error';
            if (Array.isArray(error.body)) {
                message = error.body.map(e => e.message).join(', ');
            } else if (typeof error.body.message === 'string') {
                message = error.body.message;
            }
        } else if (data){
            this.account = data; //Salvador Ramírez (sramirez@freewayconsulting.com): Los datos de la cuenta se almacenan en el objeto
            this.Id_SIpWeb = this.account.fields.Id_SIpWeb__c.value; //Salvador Ramírez (sramirez@freewayconsulting.com): Se respalda el id de sipweb
            if(this.Id_SIpWeb){ //Salvador Ramírez (sramirez@freewayconsulting.com): Si el id de sipweb no es nulo
                //Salvador Ramírez (sramirez@freewayconsulting.com): Se manda a llamar al componente consultaTarifasWW que consumirá el WS para mostrar las tarifas
                var compDetails = {
                    componentDef : "c:consultaTarifasWW",
                    attributes : {
                        //Salvador Ramírez (sramirez@freewayconsulting.com): Se pasa como atributo el id de sipweb
                        propertyValue : this.Id_SIpWeb
                    }
                };
                var encodedCompDetails = btoa(JSON.stringify(compDetails)); //Salvador Ramírez (sramirez@freewayconsulting.com): Se encripta el url del componente
                this[NavigationMixin.Navigate]({
                    //Salvador Ramírez (sramirez@freewayconsulting.com): Se manda a llamar al componente
                    type:'standard__webPage',
                    attributes : {
                        url : 'one/one.app#' + encodedCompDetails
                    }
                });
            }
        }
    }
}
