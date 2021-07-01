/**
 * @description       : Esta clase solo se encargará de obtener descuentos de acuerdo a una cantidad de argumentos que se le proporcionen.
 * @author            : Salvador Ramírez (sramirez@freewayconsulting.com)
 * @Project           : PaqueteXpress
 * @last modified on  : 06-30-2021
**/
public  class classDescuento {
    public classDescuento() {

    }
    public static Decimal getDescuentoReal(String idAccount, Date Fechainicio, Date FechaFin, Map<String, Map<String, Tarifario_general_terrestre__c>> mapTarifarioT){
        //Objetos
        Cotizador__c ObjCostos                                      = [SELECT EntregaDomicilioZonaPlus__c, SeguroMillarDeclarado__c, IVA__c, EAD__c, RAD__c, CoeficientePV__c, MinEAD__c, MinRAD__c FROM Cotizador__c LIMIT 1];
        List<Seguimiento_de_descuento_real__c> listDR               = new List<Seguimiento_de_descuento_real__c>(); //Almacena los registros de frecuencias reales
        Map<String, String> mapServicios                            = new Map<String, String>(); //Almacena las tarifas de las cotizaciones con los servicios que tienen
        Map<String, Map<String, SBQQ__QuoteLine__c>> mapQuotes      = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
        Map<String, Map<String, SBQQ__QuoteLine__c>> mapQuotesZP    = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
        //Variables decimales
        Decimal decDescuento                                        = 0; //Variable que almacenará todo el descuento para la cuenta y que se retornará como resultado de la función
        Decimal decDescuentoP                                       = 0;
        Decimal decDescuentoV                                       = 0;
        Decimal decTotalLlena                                       = 0; //Variable para guardar la tarifa llena de todas las recotizaciones que se le hicieron al cliente.
        Decimal decTotalPropuesta                                   = 0; //variable para almacenar la tarifa propuesta de todas las recotizaciones que se le hicieron al cliente.
        Decimal decTotalLlenaP                                      = 0; //Variable para guardar la tarifa llena de todas las recotizaciones que se le hicieron al cliente.
        Decimal decTotalPropuestaP                                  = 0; //variable para almacenar la tarifa propuesta de todas las recotizaciones que se le hicieron al cliente.
        Decimal decTotalLlenaV                                      = 0; //Variable para guardar la tarifa llena de todas las recotizaciones que se le hicieron al cliente.
        Decimal decTotalPropuestaV                                  = 0; //variable para almacenar la tarifa propuesta de todas las recotizaciones que se le hicieron al cliente.
        Decimal decFlete                                            = 0;
        Decimal decFleteV                                           = 0;
        Decimal decRAD                                              = 0;
        Decimal decEAD                                              = 0;
        Decimal decRADV                                             = 0;
        Decimal decEADV                                             = 0;
        Decimal decAcuse                                            = 0;
        Decimal decSEG                                              = 0;
        Decimal decTarifaLlena                                      = 0;
        Decimal decTarifaPropuesta                                  = 0;
        Decimal decTarifaLlenaV                                     = 0;
        Decimal decTarifaPropuestaV                                 = 0;
        //Variables tipo cadena
        String strTarifa                                            = '';
        String strRangeDest                                         = '';
        try{
            strTarifa = '';
            //Se recorren todas las partidas de presupuesto para conocer los servicios que contienen las tarifas.
            for(SBQQ__QuoteLine__c QL : [SELECT Tarifa__c, SBQQ__Quote__r.Servicios_adicionales__c, SBQQ__Quote__r.Acuse__c, SBQQ__CustomerPrice__c, Rango_KM__c, Destiny__c, ZonaPlus__c, ACK__c, SEG__c, EAD__c FROM SBQQ__QuoteLine__c 
                                    WHERE SBQQ__Quote__r.SBQQ__Account__c = :idAccount and SBQQ__Quote__r.Fecha_de_autorizada__c >= :Fechainicio AND SBQQ__Quote__r.Fecha_de_autorizada__c <= :FechaFin 
                                    order by SBQQ__Quote__r.Fecha_de_autorizada__c desc]){
                if(QL.Tarifa__c == 'TARIFA SOBRE')
                    strTarifa       = 'TARIFA TS';
                else strTarifa      = QL.Tarifa__c;
                if(QL.Destiny__c != null)
                    strRangeDest    = QL.Destiny__c.remove(' (').remove(QL.Rango_Km__c).remove(')');
                else strRangeDest   = QL.Rango_Km__c;
                if(!mapServicios.containsKey(strTarifa))
                    mapServicios.put(strTarifa, QL.SBQQ__Quote__r.Servicios_adicionales__c);
                if(!QL.ZonaPlus__c){
                    if(!mapQuotes.containsKey(strTarifa))
                        mapQuotes.put(strTarifa, new Map<String, SBQQ__QuoteLine__c>());
                    if(!mapQuotes.get(strTarifa).containsKey(strRangeDest))
                        mapQuotes.get(strTarifa).put(strRangeDest, QL);
                } else {
                    if(!mapQuotesZP.containsKey(strTarifa))
                        mapQuotesZP.put(strTarifa, new Map<String, SBQQ__QuoteLine__c>());
                    if(!mapQuotesZP.get(strTarifa).containsKey(strRangeDest))
                        mapQuotesZP.get(strTarifa).put(strRangeDest, QL);
                }
                
            }
            //Se obtienen todos los registros de descuento real tomando como filtro el rango de fechas indicado en la interfaz y la cuenta que se haya enviado como argumento
            listDR = [SELECT Linea__c, Rango_Kms__c, Tarifa_de_Bulto__c, Site_Destino__c, Site_Origen__c, Bultos__c FROM Seguimiento_de_descuento_real__c
                    WHERE (Cuenta__c = :idAccount OR Cuenta__r.ParentId = :idAccount) AND Fecha__c >= :Fechainicio AND Fecha__c <= :FechaFin];
            //Inicia proceso de recotización.
            for(Seguimiento_de_descuento_real__c s : listDR){
                //Reinicio de variables para evitar acumulados y por ende errores, solo se acumulan la total normal y total propuesta para sacar un descuento final.
                decFlete            = 0;
                decFleteV           = 0;
                decRAD              = 0;
                decEAD              = 0;
                decTarifaLlena      = 0;
                decTarifaLlenaV     = 0;
                decTotalLlenaP      = 0;
                decTotalLlenaV      = 0;
                decTotalPropuestaP  = 0;
                decTotalPropuestaV  = 0;
                decDescuentoV       = 0;
                decDescuentoP       = 0;
                //Si en el campo dice 'ALL' quiere decir que se vendió por rango de km, en caso contrario es porque se vendió por destino
                if(s.Site_Destino__c != 'ALL')
                    strRangeDest        = s.Site_Destino__c;
                else strRangeDest       = ObtieneRangoKM(s.Rango_Kms__c);
                if(s.Tarifa_de_Bulto__c == 'S')
                    strTarifa           = 'TARIFA TS';
                else strTarifa          = 'TARIFA ' + s.Tarifa_de_Bulto__c;
                System.debug('tarifa: ' + strTarifa + '. Rango: ' + ObtieneRangoKM(s.Rango_Kms__c));
                //Agregar validación para que si la tarifa solo dice "T7" se valide cual es la que debe tomar, si T7P o T7 V
                if(strTarifa != 'TARIFA T7'){
                    //Cuando se trata de una frecuencia real de T7 por peso/volumen o es cualquier tarifa menor a 7
                    decFlete                = mapTarifarioT.get(strTarifa).get(ObtieneRangoKM(s.Rango_Kms__c)).Flete__c;
                    if(mapServicios.containsKey(strTarifa)){
                        if(mapServicios.get(strTarifa).contains('RAD'))
                            decRAD          = decFlete * (ObjCostos.RAD__c / 100);
                        if((s.Linea__c == 'DOC_LINEA_ZE_PT' || s.Linea__c == 'DOC_LINEA_ZE' || s.Linea__c == 'PREPAGO_ZE') && mapServicios.get(strTarifa).contains('EAD Zona plus')){
                            if(mapQuotesZP.containsKey(strTarifa) && mapQuotesZP.get(strTarifa).containsKey(strRangeDest))
                                decEAD      = mapQuotesZP.get(strTarifa).get(strRangeDest).EAD__c;
                            else decEAD     = ObjCostos.EntregaDomicilioZonaPlus__c;
                        }else if((s.Linea__c == 'DOC_LINEA_ZE_PT' || s.Linea__c == 'DOC_LINEA_ZE' || s.Linea__c == 'PREPAGO_ZE') && !mapServicios.get(strTarifa).contains('EAD Zona plus'))
                            decEAD          = ObjCostos.EntregaDomicilioZonaPlus__c;
                        else {
                            if (mapServicios.get(strTarifa).contains(';EAD') || mapServicios.get(strTarifa).contains('EAD;'))
                                decEAD      = decFlete * (ObjCostos.EAD__c / 100);
                        }
                        if(mapQuotes.containsKey(strTarifa) && mapQuotes.get(strTarifa).containsKey(strRangeDest)){
                            if(mapQuotes.get(strTarifa).get(strRangeDest).ACK__c != null)
                                decAcuse    = mapQuotes.get(strTarifa).get(strRangeDest).ACK__c;
                            if(mapQuotes.get(strTarifa).get(strRangeDest).SEG__c != null)
                                decSEG      = mapQuotes.get(strTarifa).get(strRangeDest).SEG__c;
                        }
                    }
                    decTarifaLlena          = decFlete + decRAD + decEAD + decSEG + decAcuse;
                    if(mapQuotes.containsKey(strTarifa) && mapQuotes.get(strTarifa).containsKey(strRangeDest))
                        decTarifaPropuesta  = mapQuotes.get(strTarifa).get(strRangeDest).SBQQ__CustomerPrice__c;
                    else decTarifaPropuesta = decFlete;
                    decTotalLlena           += Decimal.valueOf(s.Bultos__c) * decTarifaLlena;
                    decTotalPropuesta       += decTarifaPropuesta * Decimal.valueOf(s.Bultos__c);
                } else {
                    //Cuando es una tarifa T7 y se generó su frecuencia real por tarifa.
                    decFlete                = mapTarifarioT.get('TARIFA T7P').get(ObtieneRangoKM(s.Rango_Kms__c)).Flete__c;
                    decFleteV               = mapTarifarioT.get('TARIFA T7V').get(ObtieneRangoKM(s.Rango_Kms__c)).Flete__c;
                    if(mapServicios.get(strTarifa).contains('RAD')){
                        decRAD              = decFlete * (ObjCostos.RAD__c / 100);
                        decRADV             = decFleteV * (ObjCostos.RAD__c / 100);
                    }
                    if((s.Linea__c == 'DOC_LINEA_ZE_PT' || s.Linea__c == 'DOC_LINEA_ZE' || s.Linea__c == 'PREPAGO_ZE') && mapServicios.get(strTarifa).contains('EAD Zona plus')){
                        if(mapQuotesZP.containsKey(strTarifa) && mapQuotesZP.get(strTarifa).containsKey(strRangeDest)){
                            decEAD          = mapQuotesZP.get(strTarifa).get(strRangeDest).EAD__c;
                            decEADV         = mapQuotesZP.get(strTarifa).get(strRangeDest).EAD__c;
                        } else {
                            decEAD          = ObjCostos.EntregaDomicilioZonaPlus__c;
                            decEADV         = ObjCostos.EntregaDomicilioZonaPlus__c;
                        }
                    }else if((s.Linea__c == 'DOC_LINEA_ZE_PT' || s.Linea__c == 'DOC_LINEA_ZE' || s.Linea__c == 'PREPAGO_ZE') && !mapServicios.get(strTarifa).contains('EAD Zona plus')){
                        decEAD              = ObjCostos.EntregaDomicilioZonaPlus__c;
                        decEADV             = ObjCostos.EntregaDomicilioZonaPlus__c;
                    } else {
                        if (mapServicios.get(strTarifa).contains(';EAD') || mapServicios.get(strTarifa).contains('EAD;')){
                            decEAD          = decFlete * (ObjCostos.EAD__c / 100);
                            decEADV         = decFleteV * (ObjCostos.EAD__c / 100);
                        }
                    }
                    if(mapQuotes.containsKey(strTarifa) && mapQuotes.get(strTarifa).containsKey(strRangeDest)){
                        if(mapQuotes.get(strTarifa).get(strRangeDest).ACK__c != null)
                            decAcuse        = mapQuotes.get(strTarifa).get(strRangeDest).ACK__c;
                        if(mapQuotes.get(strTarifa).get(strRangeDest).SEG__c != null)
                            decSEG          = mapQuotes.get(strTarifa).get(strRangeDest).SEG__c;
                    }
                    decTarifaLlena          = decFlete + decRAD + decEAD + decSEG + decAcuse;
                    decTarifaLlenaV         = decFleteV + decRADV + decEADV + decSEG + decAcuse;
                    if(mapQuotes.containsKey(strTarifa) && mapQuotes.get(strTarifa).containsKey(strRangeDest))
                        decTarifaPropuesta  = mapQuotes.get(strTarifa).get(strRangeDest).SBQQ__CustomerPrice__c;
                    else decTarifaPropuesta = decFlete;
                    decTotalLlenaP          = Decimal.valueOf(s.Bultos__c) * decTarifaLlena;
                    decTotalLlenaV          = Decimal.valueOf(s.Bultos__c) * decTarifaLlenaV;
                    decTotalPropuestaP      = decTarifaPropuesta * Decimal.valueOf(s.Bultos__c);
                    decTotalPropuestaV      = decTarifaPropuestaV * Decimal.valueOf(s.Bultos__c);
                }
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
