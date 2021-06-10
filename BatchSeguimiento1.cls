/**
 * @description       : DESCUENTO GLOBAL BI
 * @author            : msalinas@freewayconsulting.com
 * @group             : 
 * @last modified on  : 06-07-2021
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                               Modification
 * 1.0   04-12-2021   msalinas@freewayconsulting.com	   Initial Version
**/

global class BatchSeguimiento1 implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
    public String AccId;
    public Date DInicio;
    public Date DFin;
    public String Inicio;
    public String Fin;
    public String TipoCotizador;
    public Decimal Descuento = 0;
    public Decimal Venta = 0;
    public String query;
    
    public BatchSeguimiento1(String AccountId){
        //Aquí formamos el query con el id que nos pasa la vf
        AccId = AccountId;
        system.debug('Cuenta: ' + AccId);
        Account A = [SELECT Id, Inicio_seguimiento__c, Fin_seguimiento__c, Tipo_cotizador__c FROM Account WHERE Id =: AccId];
        DInicio = A.Inicio_seguimiento__c;
        system.debug('Inicio: ' + A.Inicio_seguimiento__c);
        DFin = A.Fin_seguimiento__c;
        system.debug('Fin: ' + A.Fin_seguimiento__c);
        TipoCotizador = A.Tipo_cotizador__c;
        String year1 = String.valueOf(DInicio.year());
        String month1;
        if(DInicio.month()<10){
            month1 = '0' + DInicio.month().format();
        } else {
            month1 = DInicio.month().format(); 
        }
        
        String day1;
        if(DInicio.day()<10){
            day1 = '0' + DInicio.day().format();
        } else {
            day1 = DInicio.day().format();
        }
        
        Inicio = year1 + '-' + month1 + '-' + day1;
        
        String year2 = String.valueOf(DFin.year());
        String month2;
        if(DFin.month()<10){
            month2 = '0' + DFin.month().format();
        } else {
            month2 = DFin.month().format(); 
        }
        
        String day2;
        if(DFin.day()<10){
            day2 = '0' + DFin.day().format();
        } else {
            day2 = DFin.day().format();
        }
        
        Fin = year2 + '-' + month2 + '-' + day2;
        
        if(!test.isRunningTest()){
        query = 'SELECT Cuenta__c, Cuenta__r.ParentId, ' +
    	'totalAntesdeImpuestos__c, fechaId__c, descuento__c, tipoPago__c, origenDoc__c ' +
    	'FROM Ventas__c WHERE (Cuenta__c = \'' + AccId + '\' OR Cuenta__r.ParentId = \'' + AccId + '\')' +
    	'AND fechaId__c >= ' + Inicio + ' AND fechaId__c <= ' + Fin ;
    	
        } else{
            query = 'SELECT Cuenta__c, Cuenta__r.ParentId, ' +
    	'totalAntesdeImpuestos__c, fechaId__c, descuento__c, tipoPago__c, origenDoc__c ' +
    	'FROM Ventas__c LIMIT 200';
        }
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        system.debug(query);
    	return Database.getQueryLocator(query);	
    }
    
    global void execute(Database.BatchableContext bc, List<Ventas__c> records) {
        for(Ventas__c v: records){
            if(TipoCotizador=='Documentación en piso sipweb'){
            	//Solo aplica para Sipweb
            	if(v.tipoPago__c == 'REGULAR' && v.origenDoc__c == 'SUCURSAL') {
                	Venta = Venta + v.totalAntesdeImpuestos__c;
                	Descuento = Descuento + v.descuento__c;//El descuento se suma a la venta para obtener Tarifa Llena
            	}
            } else if(TipoCotizador=='Prepago'){
                if(v.tipoPago__c == 'PREPAGO'){
                    System.debug('total antes de impuestos: ' + v.totalAntesdeImpuestos__c + '. descuento: ' + v.descuento__c);
                    Venta = Venta + v.totalAntesdeImpuestos__c;
                	Descuento = Descuento + v.descuento__c;//El descuento se suma a la venta para obtener Tarifa Llena
                }
            }
        }
    }
    
    global void finish(Database.BatchableContext bc) {
        system.debug('Descuento = ' + Descuento);
        system.debug('Venta = ' + Venta);
        
        //------------------------------ CALCULANDO DESCUENTO BI ---------------------------------------
        system.debug('CALCULANDO DESCUENTO BI: ');
        Decimal TarifaLlena = 0;
        TarifaLlena = Descuento + Venta;
        system.debug('TarifaLlena = ' + TarifaLlena);
        Decimal DescuentoBI = 0;
        if(TarifaLlena > 0){
            DescuentoBI = ((Venta/TarifaLlena) - 1)*100;
            System.debug('Descuento = ' + Venta + '/' + TarifaLlena + '-1 = ' + DescuentoBI);
        }
        
        //------------------------ GUARDANDO LOS RESULTADOS EN LA CUENTA PROCESADA --------------------
        try{
        Account Acc = [SELECT Id, Venta__c, Tarifa_Llena__c, Descuento_Global_BI__c FROM Account WHERE Id =: AccId];
        
        Acc.Descuento_Global_BI__c = DescuentoBI;
        Acc.Venta__c = Venta;
        Acc.Tarifa_Llena__c = TarifaLlena;
        Update Acc;
            
        //-----------------------INICIO SIGUIENTE BATCH--------------------------------
        //Agregar un parámetro más para llamar al batch, que indique el tipo de cotización
        if(!test.isRunningTest()){
            if(TipoCotizador=='Documentación en piso sipweb'){
        		BatchSeguimiento2 batch2a = new BatchSeguimiento2(AccId, Inicio, Fin); 
				database.executeBatch(batch2a,1);
            }
            if(TipoCotizador=='Prepago'){
                BatchSeguimiento2b batch2b = new BatchSeguimiento2b(AccId, Inicio, Fin);
                database.executeBatch(batch2b,1);
            }
        }
            
        } catch (Exception ex){
            System.debug('Error en finish ' + + ex.getLineNumber()+' '+ex.getMessage());
        }
        
    }

}
