import { LightningElement, api, wire, track } from 'lwc';
//import { getRecord } from 'lightning/uiRecordApi';
import CargaInfoSipweb from '@salesforce/apex/consultaTarifasWW_CTR.CargaInfoSipweb';
//const fields = ['Account.Id_SIpWeb__c']
const ptpConfig         = [];
const kmConfig          = [];
const expressServices   = [];
const servAdic          = [];
export default class ConsultaTarifasWW extends LightningElement {
    //@api recordId;
    @api propertyValue;
    ptpConfig           = ptpConfig;
    kmConfig            = kmConfig;
    expressServices     = expressServices;
    servAdic            = servAdic;
    renderJSON          = false;
    renderCFT           = false;
    renderCBMEGMP       = false;
    renderXpress        = false;
    renderServAdic      = false;
    strError;
    strResponse;
    objResponse;
    Id_SIpWeb;
    renderedCallback(){
        this.getConveniosWW();
    }
    getConveniosWW(){
        CargaInfoSipweb({
            idSipweb : this.propertyValue
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
                    debugger;
                    if(strTarifa === 'C'){
                        this.renderCBMEGMP = true;
                        if(arrayPtpConfig){
                            if(arrayPtpConfig.ptpServicesTrif){
                                for(let i = 0; arrayPtpConfig.ptpServicesTrif.length; i++){
                                    let ptpServicesTrif     = arrayPtpConfig.ptpServicesTrif[i];
                                    if(ptpServicesTrif){
                                        let strRange    = ptpServicesTrif.orgnSite + '-' + ptpServicesTrif.destSite;
                                        if(ptpServicesTrif.servicesTrifCbe){
                                            for(let j = 0; ptpServicesTrif.servicesTrifCbe.length; j++){
                                                let servicesTrifCbe = ptpServicesTrif.servicesTrifCbe[j];
                                                if(servicesTrifCbe){
                                                    let serviceId       = servicesTrifCbe.serviceId;
                                                    let factor          = servicesTrifCbe.factor;
                                                    let trifAmountExce  = servicesTrifCbe.trifAmountExce;
                                                    if(servicesTrifCbe.serviceTrif){
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
                                                    }
                                                } else {
                                                    break;
                                                }
                                            }
                                            //ptpConfig.sort();
                                        }
                                        //Salvador Ramírez (sramirez@freewayconsulting.com): Recorrido para recabar información de servicios adicionales.
                                        if(ptpServicesTrif.serviceTrif){
                                            for(let j = 0; ptpServicesTrif.serviceTrif.length; j++){
                                                let serviceTrif = ptpServicesTrif.serviceTrif[j];
                                                if(serviceTrif){
                                                    let ServicioAdic = {
                                                        id : 'Adic' + j,
                                                        RangoKM : strRange,
                                                        Servicio : serviceTrif.serviceId,
                                                        Monto : serviceTrif.trifAmount
                                                    }
                                                    servAdic.push(ServicioAdic);
                                                    this.renderServAdic = true;
                                                } else {
                                                    break;
                                                }
                                            }
                                        } else {
                                            break;
                                        }
                                    } else {
                                        break;
                                    }
                                }
                            }
                        }
                        if(arrayKmConfig){
                            let ContadorKm = 0;
                            for(let i = 0; arrayKmConfig.kmServicesTrif.length;i++){
                                let kmServicesTrif = arrayKmConfig.kmServicesTrif[i];
                                if(kmServicesTrif){
                                    let RangoKM = kmServicesTrif.fromKm +'-'+ kmServicesTrif.toKm;
                                    if(kmServicesTrif.servicesTrifCbe){
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
                                                            id : ContadorKm,
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
                                                        };
                                                        kmConfig.push(Tarifa);
                                                        ContadorKm++;
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
                                } else {
                                    break;
                                }
                            }
                        }
                    } else {
                        this.renderCFT  = true;
                        let contador    = 0;
                        debugger;
                        if(arrayPtpConfig){
                            if(arrayPtpConfig.ptpServicesTrif){
                                for(let i = 0; arrayPtpConfig.ptpServicesTrif.length; i++){
                                    let ptpServicesTrif = arrayPtpConfig.ptpServicesTrif[i];
                                    if(ptpServicesTrif){
                                        let strRange = ptpServicesTrif.orgnSite + '-' + ptpServicesTrif.destSite;
                                        console.log('rango: ' + strRange);
                                        if(ptpServicesTrif.servicesTrifDtl){
                                            for(let j = 0;ptpServicesTrif.servicesTrifDtl.length;j++){
                                                let servicesTrifDtl = ptpServicesTrif.servicesTrifDtl[j];
                                                if(servicesTrifDtl){
                                                    let strTarifa = servicesTrifDtl.slabNo;
                                                    if(servicesTrifDtl.serviceTrif){
                                                        for(let k = 0; servicesTrifDtl.serviceTrif.length; k++){
                                                            let serviceTrif = servicesTrifDtl.serviceTrif[k];
                                                            if(serviceTrif){
                                                                let Tarifa = {
                                                                    id : contador,
                                                                    Cliente : strCliente,
                                                                    RangoKM : strRange,
                                                                    Servicio : serviceTrif.serviceId,
                                                                    Tarifa : strTarifa,
                                                                    Monto : serviceTrif.trifAmount,
                                                                    Cotizacion : serviceTrif.quotation
                                                                }
                                                                ptpConfig.push(Tarifa);
                                                                contador++;
                                                            } else {
                                                                break;
                                                            }
                                                        }
                                                    } else {
                                                        break;
                                                    }
                                                } else {
                                                    break;
                                                }
                                            }
                                        }
                                        //Salvador Ramírez (sramirez@freewayconsulting.com): Recorrido para recabar información de servicios adicionales.
                                        if(ptpServicesTrif.serviceTrif){
                                            for(let j = 0; ptpServicesTrif.serviceTrif.length; j++){
                                                let serviceTrif = ptpServicesTrif.serviceTrif[j];
                                                if(serviceTrif){
                                                    let ServicioAdic = {
                                                        id : 'Adic' + j,
                                                        RangoKM : strRange,
                                                        Servicio : serviceTrif.serviceId,
                                                        Monto : serviceTrif.trifAmount
                                                    }
                                                    servAdic.push(ServicioAdic);
                                                    this.renderServAdic = true;
                                                } else {
                                                    break;
                                                }
                                            }
                                        } else {
                                            break;
                                        }
                                    } else {
                                        break;
                                    }
                                }
                            }
                        }
                        if(arrayKmConfig){
                            if(arrayKmConfig.kmServicesTrif){
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
                                        if(kmServicesTrif.servicesTrifCbe){
                                            for(let j = 0; kmServicesTrif.servicesTrifCbe.length; j++){
                                                let servicesTrifCbe = kmServicesTrif.servicesTrifCbe[j];
                                                if(servicesTrifCbe){
                                                    let MontoExc = servicesTrifCbe.trifAmountExce;
                                                    for(let k = 0;servicesTrifCbe.serviceTrif.length; k++){
                                                        let serviceTrif = servicesTrifCbe.serviceTrif[k];
                                                        if(serviceTrif){
                                                            let Tarifa = {
                                                                id: 'km' + k,
                                                                Cliente : strCliente,
                                                                RangoKM : strRange,
                                                                tipoTar : strTarifa,
                                                                Servicio : servicesTrifCbe.serviceId,
                                                                Factor :serviceTrif.factor,
                                                                PesoVol : serviceTrif.factorValue,
                                                                Monto : serviceTrif.trifAmount,
                                                                Monto_Excedente : MontoExc,
                                                                Multipieza : Multipieza,
                                                                Cotizacion : serviceTrif.quotation
                                                            }
                                                            expressServices.push(Tarifa);
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
                                        
                                        if(expressServices){
                                            this.renderXpress = true;
                                        }
                                    } else {
                                        break;
                                    }
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
