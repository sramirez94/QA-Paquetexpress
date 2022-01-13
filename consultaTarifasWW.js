import { LightningElement, api, wire, track } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import CargaInfoSipweb from '@salesforce/apex/consultaTarifasWW_CTR.CargaInfoSipweb';
const fields = ['Account.Id_SIpWeb__c']
const Columns = [{label: 'Cliente', fieldName: 'clntId', type:'text'},{label: 'Rango KM', fieldName: 'rangoKm', type:'text'}];
const ptpConfig = [];
export default class ConsultaTarifasWW extends LightningElement {
    @api recordId;
    @track arraynums = [];
    ptpConfig = ptpConfig;
    strError;
    strResponse;
    objResponse;
    account;
    Id_SIpWeb;
    renderJSON = false;
    Columns = Columns;
    @wire(getRecord, { recordId: '$recordId', fields : fields})
    wiredRecord({ error, data }) {
        debugger;
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
                if(Respuesta !== null && Respuesta !== ''){
                    //Salvador Ramírez (sramirez@freewayconsulting.com): Si la respuesta de la cotización devolvió algo
                    this.objResponse    = JSON.parse(Respuesta); //Salvador Ramírez (sramirez@freewayconsulting.com): Se recibe el response y se le da formato de JSON
                    let arrayPtpConfig  = this.objResponse.body.response.data.ptpConfig[0];
                    let strCliente      = this.objResponse.body.response.data.clntId;
                    let strTarifa       = this.objResponse.body.response.data.trifType;
                    let Multipieza      = '';
                    if(this.objResponse.body.response.data.pieceMulti !== ''){
                        Multipieza = 'SI';
                    } else {
                        Multipieza = 'NO';
                    }
                    for(let i = 0; arrayPtpConfig.ptpServicesTrif.length; i++){
                        let ptpServicesTrif     = arrayPtpConfig.ptpServicesTrif[i];
                        if(ptpServicesTrif){
                            let strRange    = ptpServicesTrif.orgnSite + '-' + ptpServicesTrif.destSite;
                            for(let j = 0; ptpServicesTrif.servicesTrifCbe.length; j++){
                                let servicesTrifCbe = ptpServicesTrif.servicesTrifCbe[j];
                                if(servicesTrifCbe){
                                    let serviceId       = servicesTrifCbe.serviceId;
                                    let factor          = servicesTrifCbe.factor;
                                    let trifAmountExce  = servicesTrifCbe.trifAmountExce;
                                    for(let k = 0; servicesTrifCbe.serviceTrif.length;k++){
                                        let serviceTrif = servicesTrifCbe.serviceTrif[k];
                                        if(serviceTrif){
                                            let cliente = {
                                                Id : 'ptp' + i,
                                                Cliente : strCliente,
                                                label: strCliente,
                                                fieldName: 'ptp' + i,
                                                RangoKM : strRange,
                                                Tarifa : strTarifa,
                                                Servicio : serviceId,
                                                Factor : factor,
                                                Peso_Vol_Inicial : serviceTrif.factorValue,
                                                Monto : serviceTrif.trifAmount,
                                                Monto_Excedente : trifAmountExce,
                                                Multipieza : Multipieza,
                                                Cotizacion : serviceTrif.quotation
                                                //type: 'text'
                                            };
                                            ptpConfig.push(cliente);
                                        } else {
                                            break;
                                        }
                                    }
                                } else {
                                    break;
                                }
                            }
                            ptpConfig.sort();
                            this.renderJSON = true; //Salvador Ramírez (sramirez@freewayconsulting.com): Se indica que se está renderizando
                        } else {
                            break;
                        }
                    }
                }
            }).catch(error => {
                console.log('Error: ' + error);
            })
    }
}
