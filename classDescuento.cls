/**
 * @description       : Esta clase solo se encargará de obtener descuentos de acuerdo a una cantidad de argumentos que se le proporcionen.
 * @author            : Salvador Ramírez (sramirez@freewayconsulting.com)
 * @Project           : PaqueteXpress
 * @last modified on  : 06-29-2021
**/
public  class classDescuento {
    public classDescuento() {

    }
    public static Decimal getDescuentoReal(String idAccount, Date Fechainicio, Date FechaFin, Map<String, Map<String, Tarifario_general_terrestre__c>> mapTarifarioT){
        //Objetos
        Cotizador__c ObjCostos                                  = [SELECT  EAD__c, RAD__c FROM Cotizador__c LIMIT 1];
        List<Seguimiento_de_descuento_real__c> listDR           = new List<Seguimiento_de_descuento_real__c>(); //Almacena los registros de frecuencias reales
        Map<String, String> mapServicios                        = new Map<String, String>(); //Almacena las tarifas de las cotizaciones con los servicios que tienen
        Map<String, Map<String, SBQQ__QuoteLine__c>> mapQuotes  = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
        //Variables decimales
        Decimal decDescuento                                    = 0.00; //Variable que almacenará todo el descuento para la cuenta y que se retornará como resultado de 
        Decimal decTotalLlena                                   = 0; //Variable para guardar la tarifa llena de todas las recotizaciones que se le hicieron al cliente.
        Decimal decTotalPropuesta                               = 0; //variable para almacenar la tarifa propuesta de todas las recotizaciones que se le hicieron al cliente.
        Decimal decFlete                                        = 0;
        Decimal decRAD                                          = 0;
        Decimal decEAD                                          = 0;
        Decimal decAcuse                                        = 0;
        Decimal decSEG                                          = 0;
        Decimal decTarifaLlena                                  = 0;
        Decimal decTarifaPropuesta                              = 0;
        //Variables tipo cadena
        String strTarifa                                        = '';
        String strRangeDest                                     = '';
        try{
            strTarifa = '';
            //Se recorren todas las partidas de presupuesto para conocer los servicios que contienen las tarifas.
            for(SBQQ__QuoteLine__c QL : [SELECT Tarifa__c, SBQQ__Quote__r.Servicios_adicionales__c, SBQQ__CustomerPrice__c, Rango_KM__c, Destiny__c FROM SBQQ__QuoteLine__c 
                                    WHERE SBQQ__Quote__r.SBQQ__Account__c = :idAccount and SBQQ__Quote__r.Fecha_de_autorizada__c >= :Fechainicio AND SBQQ__Quote__r.Fecha_de_autorizada__c <= :FechaFin order by SBQQ__Quote__r.Fecha_de_autorizada__c desc]){
                if(QL.Tarifa__c == 'TARIFA SOBRE')
                    strTarifa       = 'TARIFA TS';
                else strTarifa      = QL.Tarifa__c;
                if(QL.Destiny__c != null)
                    strRangeDest    = QL.Destiny__c.remove(' (').remove(QL.Rango_Km__c).remove(')');
                else strRangeDest   = QL.Rango_Km__c;
                if(!mapServicios.containsKey(strTarifa))
                    mapServicios.put(strTarifa, QL.SBQQ__Quote__r.Servicios_adicionales__c);
                if(!mapQuotes.containsKey(strTarifa))
                    mapQuotes.put(strTarifa, new Map<String, SBQQ__QuoteLine__c>());
                if(!mapQuotes.get(strTarifa).containsKey(strRangeDest))
                    mapQuotes.get(strTarifa).put(strRangeDest, QL);
            }
            //Se obtienen todos los registros de descuento real tomando como filtro el rango de fechas indicado en la interfaz y la cuenta que se haya enviado como argumento
            listDR = [SELECT Linea__c, Rango_Kms__c, Tarifa_de_Bulto__c, Site_Destino__c, Site_Origen__c FROM Seguimiento_de_descuento_real__c
                    WHERE (Cuenta__c = :idAccount OR Cuenta__r.ParentId = :idAccount) AND Fecha__c >= :Fechainicio AND Fecha__c <= :FechaFin];
            //Inicia proceso de recotización.
            for(Seguimiento_de_descuento_real__c s : listDR){
                decFlete        = 0;
                decRAD          = 0;
                decEAD          = 0;
                decTarifaLlena  = 0;
                if(s.Site_Destino__c != 'ALL')
                    strRangeDest        = s.Site_Destino__c;
                else strRangeDest       = ObtieneRangoKM(s.Rango_Kms__c);
                if(s.Tarifa_de_Bulto__c == 'S')
                    strTarifa           = 'TARIFA TS';
                else strTarifa          = 'TARIFA ' + s.Tarifa_de_Bulto__c;
                decFlete                = mapTarifarioT.get(strTarifa).get(ObtieneRangoKM(s.Rango_Kms__c)).Flete__c;
                if(mapServicios.containsKey(strTarifa)){
                    if(mapServicios.get(strTarifa).contains('RAD'))
                        decRAD          = decFlete * (ObjCostos.RAD__c / 100);
                    if(mapServicios.get(strTarifa).contains('EAD'))
                        decEAD          = decFlete * (ObjCostos.EAD__c / 100);
                }
                decTarifaLlena          = decFlete + decRAD + decEAD + decSEG + decAcuse;
                if(mapQuotes.containsKey(strTarifa) && mapQuotes.get(strTarifa).containsKey(strRangeDest))
                    decTarifaPropuesta  = mapQuotes.get(strTarifa).get(strRangeDest).SBQQ__CustomerPrice__c;
                else decTarifaPropuesta = decFlete;
                decTotalLlena           += Decimal.valueOf(s.Bultos__c) * decTarifaLlena;
                decTotalPropuesta       += decTarifaPropuesta * Decimal.valueOf(s.Bultos__c);
            }
            decDescuento = (decTotalPropuesta / decTotalLlena) - 1;
            return decDescuento;
        } catch(Exception ex){
            System.debug('Error getDescuentoReal: ' + ex.getMessage() + '. ' + ex.getLineNumber());
            return 0;
        }
    }
    public static String ObtieneRangoKM(String rango){
        if(rango == '0-400')
            return '0000-0400';
        else if(rango == '401-800')
            return '0401-0800';
        else if(rango == '801-1200')
            return '0801-1200';
        else if(rango == '1201-1600')
            return '1201-1600';
        else if(rango == '1601-2000')
            return '1601-2000';
        else if(rango == '2001-2400')
            return '2001-2400';
        else if(rango == 'Más de 2400' || rango == '+2400')
            return '2401-9999';
        else if(rango == '0000-0400')
            return '0-400';
        else if(rango == '0401-0800')
            return '401-800';
        else if(rango == '0801-1200')
            return '801-1200';
        else if(rango == '2401-9999')
            return 'Más de 2400';
        else return '';
    }
}
