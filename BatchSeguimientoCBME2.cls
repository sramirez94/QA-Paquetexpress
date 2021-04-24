/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-21-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   04-19-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
**/
global class BatchSeguimientoCBME2 implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
    public String query;
    public String AccId;
    public String strModelo;
    public String strIdQuote;
    public String strInicio;
    public String strFin;
    public Boolean blnRAD                                             = false;
    public Boolean blnEAD                                             = false;
    public Boolean blnACK                                             = false;
    public Map<String, Map<String, wpFrecuencias>> mapFrecuencias     = new Map<String, Map<String, wpFrecuencias>>();
    public Map<String, Map<String, wpFrecuencias>> mapFrecuenciasZP   = new Map<String, Map<String, wpFrecuencias>>();
    public Map<String, Map<String, wpFrecuencias>> mapGuias           = new Map<String, Map<String, wpFrecuencias>>();
    public Map<String, Map<String, wpFrecuencias>> mapGuiasZP         = new Map<String, Map<String, wpFrecuencias>>();
    public Map<String, Decimal> mapAcuse                              = new Map<String, Decimal>();
    public List<FrecuenciaDeEnvios__c> listFrecuencia                 = new List<FrecuenciaDeEnvios__c>();
    //public List<String> listTarifas                             = new List<String>{'TARIFA SOBRE', 'TARIFA T0', 'TARIFA T1', 'TARIFA T2', 'TARIFA T3', 'TARIFA T4', 'TARIFA T5', 'TARIFA T6', 'TARIFA T7-V', 'TARIFA T7-P'};
    public List<String> listTarifas                             = new List<String>();
    public List<String> listRangeDestiny                        = new List<String>{'0-400', '401-800', '801-1200', '1201-1600', '1601-2000', '2001-2400', 'Más de 2400'};
    public BatchSeguimientoCBME2(String AccountId, String Inicio, String Fin, String Modelo, Boolean RAD, Boolean EAD, Boolean ACK, Map<String, Decimal> mapAc) {
        this.AccId = AccountId;
        this.strModelo = Modelo;
        this.blnRAD = RAD;
        this.blnEAD = EAD;
        this.blnACK = ACK;
        this.mapAcuse = mapAc;
        this.strInicio = Inicio;
        this.strFin = Fin;
        Query = 'SELECT Id, Name, Servicios_adicionales__c, Fecha_de_autorizada__c FROM SBQQ__Quote__c WHERE (SBQQ__Account__c = \'' + AccountId + '\' OR SBQQ__Account__r.ParentId = \'' + AccountId + '\') ' +
        + 'AND Fecha_de_autorizada__c >= '+Inicio+' and Fecha_de_autorizada__c <= '+Fin+' AND SBQQ__Status__c = \'Approved\' AND Modelo_de_tarifas__c = \'' + Modelo + '\'';
    }
    global Database.QueryLocator start(Database.BatchableContext bc) {
        //System.debug('consulta: '+ query);
        return Database.getQueryLocator(this.Query);	
    }
    global void execute(Database.BatchableContext bc, List<SBQQ__Quote__c> records){
        try{
            String strRangeDest = '';
            this.strIdQuote = records[0].Id;
            //03/03/2021 Salvador: Recorre todas las frecuencias de todas las cotizaciones para irlas sumando y acomodando en cada mapa dependiendo si es zona plus o normal
            for(SBQQ__Quote__c objQuote : records){
                for(SBQQ__QuoteLine__c objQLine : [SELECT Id, ZonaPlus__c, PackWeightAVG__c, PackVolAVG__c, Tarifa__c, SBQQ__Quantity__c, Rango_KM__c, Destiny__c, Flete__c, RAD__c, EAD__c, ACK__C, PaqPorGuia__c FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c = :objQuote.Id]){
                    if(!objQLine.Tarifa__C.contains('TARIFA T7_')){
                        strRangeDest = '';
                        if(objQLine.Destiny__c != null)
                            strRangeDest = objQLine.Destiny__c.remove(' (').remove(objQLine.Rango_KM__c).remove(')');
                        else strRangeDest = objQLine.Rango_KM__c;
                        if(!objQLine.ZonaPlus__c){
                            if(!this.mapFrecuencias.containsKey(objQLine.Tarifa__c))
                                this.mapFrecuencias.put(objQLine.Tarifa__c, new Map<String, wpFrecuencias>());
                            if(!this.mapFrecuencias.get(objQLine.Tarifa__c).containsKey(strRangeDest)){
                                this.mapFrecuencias.get(objQLine.Tarifa__c).put(strRangeDest, new wpFrecuencias());
                                this.mapFrecuencias.get(objQLine.Tarifa__C).get(strRangeDest).decFrecuencia = objQLine.SBQQ__Quantity__c;
                            }else this.mapFrecuencias.get(objQLine.Tarifa__c).get(strRangeDest).decFrecuencia += objQLine.SBQQ__Quantity__c;
                            if(this.strModelo == 'Guía multipieza: Por Destinos / Por Rangos de km'){
                                if(!this.mapGuias.containsKey(objQLine.Tarifa__c))
                                    this.mapGuias.put(objQLine.Tarifa__c, new Map<String, wpFrecuencias>());
                                if(!this.mapGuias.get(objQLine.Tarifa__c).containsKey(strRangeDest)){
                                    this.mapGuias.get(objQLine.Tarifa__c).put(strRangeDest, new wpFrecuencias());
                                    this.mapGuias.get(objQLine.Tarifa__C).get(strRangeDest).decFrecuencia = objQLine.PaqPorGuia__c;
                                }else this.mapGuias.get(objQLine.Tarifa__c).get(strRangeDest).decFrecuencia += objQLine.PaqPorGuia__c;
                            }
                        } else {
                            if(!this.mapFrecuenciasZP.containsKey(objQLine.Tarifa__c))
                                this.mapFrecuenciasZP.put(objQLine.Tarifa__c, new Map<String, wpFrecuencias>());
                            if(!this.mapFrecuenciasZP.get(objQLine.Tarifa__c).containsKey(strRangeDest)){
                                this.mapFrecuenciasZP.get(objQLine.Tarifa__c).put(strRangeDest, new wpFrecuencias());
                                this.mapFrecuenciasZP.get(objQLine.Tarifa__C).get(strRangeDest).decFrecuencia = objQLine.SBQQ__Quantity__c;
                            }else this.mapFrecuenciasZP.get(objQLine.Tarifa__c).get(strRangeDest).decFrecuencia += objQLine.SBQQ__Quantity__c;
                            if(this.strModelo == 'Guía multipieza: Por Destinos / Por Rangos de km'){
                                if(!this.mapGuiasZP.containsKey(objQLine.Tarifa__c))
                                    this.mapGuiasZP.put(objQLine.Tarifa__c, new Map<String, wpFrecuencias>());
                                if(!this.mapGuiasZP.get(objQLine.Tarifa__c).containsKey(strRangeDest)){
                                    this.mapGuiasZP.get(objQLine.Tarifa__c).put(strRangeDest, new wpFrecuencias());
                                    this.mapGuiasZP.get(objQLine.Tarifa__C).get(strRangeDest).decFrecuencia = objQLine.PaqPorGuia__c;
                                }else this.mapGuiasZP.get(objQLine.Tarifa__c).get(strRangeDest).decFrecuencia += objQLine.PaqPorGuia__c;
                            }
                        }
                        if(!this.listTarifas.contains(objQLine.Tarifa__c))
                            this.listTarifas.add(objQLine.Tarifa__c);
                        if(!this.listRangeDestiny.contains(strRangeDest))
                            this.listRangeDestiny.add(strRangeDest);
                    }
                }
            }
            //03/03/2021 Salvador: Rellena los rangos de km que no se contuvieron en las cotizaciones.
            for(String strTarifa : this.listTarifas){
                for(String strRange : this.listRangeDestiny){
                    if(!strTarifa.contains('TARIFA T7_')){
                        if(!this.mapFrecuencias.containsKey(strTarifa))
                            this.mapFrecuencias.put(strTarifa, new Map<String, wpFrecuencias>());
                        if(!this.mapFrecuenciasZP.containsKey(strTarifa))
                            this.mapFrecuenciasZP.put(strTarifa, new Map<String, wpFrecuencias>());
                        if(!this.mapFrecuencias.get(strTarifa).containsKey(strRangeDest)){
                            this.mapFrecuencias.get(strTarifa).put(strRangeDest, new wpFrecuencias());
                        }
                        if(!this.mapFrecuenciasZP.get(strTarifa).containsKey(strRangeDest)){
                            this.mapFrecuenciasZP.get(strTarifa).put(strRangeDest, new wpFrecuencias());
                        }

                        if(!this.mapGuias.containsKey(strTarifa))
                            this.mapGuias.put(strTarifa, new Map<String, wpFrecuencias>());
                        if(!this.mapGuiasZP.containsKey(strTarifa))
                            this.mapGuiasZP.put(strTarifa, new Map<String, wpFrecuencias>());
                    }
                }
            }
        } catch(Exception ex){
            System.debug('Error en execute: ' + ex.getLineNumber()+' '+ex.getMessage());
        }
    }
    global void finish(Database.BatchableContext bc) {
        //System.debug('mapa frecuencias: ' + this.mapFrecuencias.get('TARIFA SOBRE'));
        try{
            for(String strTarifa : this.listTarifas){
                for(String strRange : this.listRangeDestiny){
                    //03/03/2021 Salvador: Tarifa paquetexpress
                    if(this.mapFrecuencias.get(strTarifa).containsKey(strRange)){
                        FrecuenciaDeEnvios__c f = new FrecuenciaDeEnvios__c();
                        f.Cuenta__c = AccId;
                        if(strTarifa == 'TARIFA SOBRE')
                            f.Tarifa__C = 'TS';
                        else f.Tarifa__C = strTarifa.remove('TARIFA ');
                        f.Rango__c = strRange;
                        f.Bultos__c = this.mapFrecuencias.get(strTarifa).get(strRange).decFrecuencia;
                        f.Zona_Plus__c = false;
                        if(this.strModelo == 'Guía multipieza: Por Destinos / Por Rangos de km')
                            f.GuiasPorPaq__c = this.mapGuias.get(strTarifa).get(strRange).decFrecuencia; 
                        this.listFrecuencia.add(f);
                    }
                    //03/03/2021 Salvador: Zona extendida o zona plus
                    if(this.mapFrecuenciasZP.get(strTarifa).containsKey(strRange)){
                        if(strTarifa != 'TARIFA T7' || !strTarifa.contains('TARIFA T7_')){
                            FrecuenciaDeEnvios__c f = new FrecuenciaDeEnvios__c();
                            f.Cuenta__c = AccId;
                            if(!strTarifa.contains('TARIFA T7_')){
                                if(strTarifa == 'TARIFA SOBRE')
                                    f.Tarifa__C = 'TS';
                                else f.Tarifa__C = strTarifa.remove('TARIFA ');
                            }
                            f.Rango__c = strRange;
                            f.Bultos__c = this.mapFrecuenciasZP.get(strTarifa).get(strRange).decFrecuencia;
                            f.Zona_Plus__c = true;
                            if(this.strModelo == 'Guía multipieza: Por Destinos / Por Rangos de km')
                                f.GuiasPorPaq__c = this.mapGuiasZP.get(strTarifa).get(strRange).decFrecuencia;
                            this.listFrecuencia.add(f);
                        }
                    }
                    

                }
            }
            for(Database.SaveResult resDeducUPD : Database.insert(this.listFrecuencia, false)){
                if(resDeducUPD.isSuccess())
                    System.debug('Se guardaron correctamente los cambios.');
                else {
                    for(Database.Error insError: resDeducUPD.getErrors())
                        System.debug('Error al guardar datos de partidas de cotización: ' + insError.getMessage());
                }
            }
            //Account theAcc = [SELECT Id, Id_SIpWeb__c FROM Account WHERE Id=: AccId];
            //CallWSDescuentoPorCliente.callDescuentoCliente(theAcc.Id_SIpWeb__c, theAcc);
            BatchSeguimientoCBME3 batch3 = new BatchSeguimientoCBME3(this.AccId, this.strInicio, this.strFin, this.strIdQuote, this.blnRAD, this.blnEAD, this.blnACK, this.mapAcuse);
            database.executeBatch(batch3,1);
        } catch (Exception ex){
            System.debug('Error en finish ' + + ex.getLineNumber()+' '+ex.getMessage());
        }
    }
    public class wpFrecuencias {
        public Decimal decFrecuencia;
        public wpFrecuencias(){
            this.decFrecuencia = 0;
        }
    }
}
