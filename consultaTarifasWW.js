import { LightningElement, api, wire, track } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import CargaInfoSipweb from '@salesforce/apex/consultaTarifasWW_CTR.CargaInfoSipweb';
const fields = ['Account.Id_SIpWeb__c']
const ptpConfig = [];
const kmConfig = [];
export default class ConsultaTarifasWW extends LightningElement {
    @api recordId;
    ptpConfig           = ptpConfig;
    kmConfig            = kmConfig;
    renderJSON          = false;
    renderCFT           = false;
    renderCBMEGMP       = false;
    strError;
    strResponse;
    objResponse;
    account;
    Id_SIpWeb;
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
                    let arrayPtpConfig  = [];
                    let arrayKmConfig   = [];
                    let strCliente      = this.objResponse.body.response.data.clntId;
                    let strTarifa       = this.objResponse.body.response.data.trifType;
                    let Multipieza      = '';
                    if(this.objResponse.body.response.data.ptpConfig){
                        arrayPtpConfig  = this.objResponse.body.response.data.ptpConfig[0];
                    }
                    if(this.objResponse.body.response.data.kmConfig){
                        arrayKmConfig   = this.objResponse.body.response.data.kmConfig[0];
                    }
                    if(this.objResponse.body.response.data.pieceMulti !== ''){
                        Multipieza = 'SI';
                    } else {
                        Multipieza = 'NO';
                    }
                    if(strTarifa === 'C'){
                        this.renderCBMEGMP = true;
                        if(arrayPtpConfig){
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
                                                    let Tarifa = {
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
                                                    ptpConfig.push(Tarifa);
                                                } else {
                                                    break;
                                                }
                                            }
                                        } else {
                                            break;
                                        }
                                    }
                                    ptpConfig.sort();
                                } else {
                                    break;
                                }
                            }
                        }
                        if(arrayKmConfig){
                            for(let i = 0; arrayKmConfig.kmServicesTrif.length;i++){
                                let kmServicesTrif = arrayKmConfig.kmServicesTrif[i];
                                if(kmServicesTrif){
                                    let RangoKM = kmServicesTrif.fromKm +'-'+ kmServicesTrif.toKm;
                                    for(let j = 0; kmServicesTrif.servicesTrifCbe.length; j++){
                                        let servicesTrifCbe = kmServicesTrif.servicesTrifCbe[j];
                                        if(servicesTrifCbe){
                                            let serviceId       = servicesTrifCbe.serviceId;
                                            let factor          = servicesTrifCbe.factor;
                                            let trifAmountExce  = servicesTrifCbe.trifAmountExce;
                                            for(let k = 0; servicesTrifCbe.serviceTrif.length;k++){
                                                let serviceTrif = servicesTrifCbe.serviceTrif[k];
                                                if(serviceTrif){
                                                    let Tarifa = {
                                                        id : 'km' + i,
                                                        Cliente : strCliente,
                                                        RangoKM : RangoKM,
                                                        Tarifa : strTarifa,
                                                        Servicio : serviceId,
                                                        Factor : factor,
                                                        Peso_Vol_Inicial : serviceTrif.factorValue,
                                                        Monto : serviceTrif.trifAmount,
                                                        Monto_Excedente : trifAmountExce,
                                                        Multipieza : Multipieza,
                                                        Cotizacion : serviceTrif.quotation
                                                    }
                                                    kmConfig.push(Tarifa);
                                                } else {
                                                    break;
                                                }
                                            }
                                        } else {
                                            break;
                                        }
                                    }
                                } else {
                                    break;
                                }
                            }
                        }
                    } else {
                        this.renderCFT = true;
                        if(arrayKmConfig){
                            for(let i = 0;arrayKmConfig.kmServicesTrif.length; i++){
                                let kmServicesTrif = arrayKmConfig.kmServicesTrif[i];
                                if(kmServicesTrif){
                                    let strRange = kmServicesTrif.fromKm + '-' + kmServicesTrif.toKm;
                                    for(let j = 0;kmServicesTrif.servicesTrifDtl.length; j++){
                                        let servicesTrifDtl = kmServicesTrif.servicesTrifDtl[j];
                                        if(servicesTrifDtl){
                                            let strTarifa = servicesTrifDtl.slabNo;
                                            for(let k = 0; servicesTrifDtl.serviceTrif.length; k++){
                                                let serviceTrif = servicesTrifDtl.serviceTrif[k];
                                                if(serviceTrif){
                                                    let Tarifa = {
                                                        Id : 'km' + k,
                                                        Cliente : strCliente,
                                                        RangoKM : strRange,
                                                        Servicio : serviceTrif.serviceId,
                                                        Tarifa : strTarifa,
                                                        Monto : serviceTrif.trifAmount,
                                                        Cotizacion : serviceTrif.quotation
                                                    };
                                                    kmConfig.push(Tarifa);
                                                } else {
                                                    break;
                                                }
                                            }
                                        } else {
                                            break;
                                        }
                                    }
                                } else {
                                    break;
                                }
                            }
                        }
                    }
                    
                    this.renderJSON = true; //Salvador Ramírez (sramirez@freewayconsulting.com): Se indica que se está renderizando
                }
            }).catch(error => {
                console.log('Error: ' + error);
            })
    }
}
