//DESCUENTO GLOBAL BI
//El descuento global BI se calcula con la integración de la venta diaria siguiendo la formula:
//TOTAL ANTES DE IMPUESTOS / (TOTAL ANTES DE IMPUESTOS + DESCUENTO) - 1
global class BatchSeguimiento1 implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
    public String AccId;
    public Date DInicio;
    public Date DFin;
    public String Inicio;
    public String Fin;
    public Decimal Descuento = 0;
    public Decimal Venta = 0;
    public String query;
    
    public BatchSeguimiento1(String AccountId){
        //Aquí formamos el query con el id que nos pasa la vf
        AccId = AccountId;
        Account A = [SELECT Id, Inicio_seguimiento__c, Fin_seguimiento__c FROM Account WHERE Id =: AccId];
        DInicio = A.Inicio_seguimiento__c;
        DFin = A.Fin_seguimiento__c;
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
        
        query = 'SELECT Cuenta__c, Cuenta__r.ParentId, ' +
    	'totalAntesdeImpuestos__c, fechaId__c, descuento__c, tipoPago__c, origenDoc__c ' +
    	'FROM Ventas__c WHERE (Cuenta__c = \'' + AccId + '\' OR Cuenta__r.ParentId = \'' + AccId + '\')' +
    	'AND fechaId__c >= ' + Inicio + ' AND fechaId__c <= ' + Fin ;
    	//Agregar tipo de cliente a los filtros
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        system.debug(query);
    	return Database.getQueryLocator(query);	
    }
    
    global void execute(Database.BatchableContext bc, List<Ventas__c> records) {
        for(Ventas__c v: records){
            //Solo aplica para Sipweb
            if(v.tipoPago__c == 'REGULAR' && v.origenDoc__c == 'SUCURSAL') {
                Venta = Venta + v.totalAntesdeImpuestos__c;
                Descuento = Descuento + v.descuento__c;//El descuento se suma a la venta para obtener Tarifa Llena
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
            DescuentoBI = (Venta/TarifaLlena) - 1;
            System.debug('Descuento = ' + Venta + '/' + TarifaLlena + '-1 = ' + DescuentoBI);
        }
        
        //------------------------ GUARDANDO LOS RESULTADOS EN LA CUENTA PROCESADA --------------------
        Account Acc = [SELECT Id, Descuento_Global_BI__c FROM Account WHERE Id =: AccId];
        
        Acc.Descuento_Global_BI__c = DescuentoBI;
        Update Acc;

    }

}
