//DESCUENTO Y FRECUENCIA COTIZADA
//Para el reporte de descuentos reales se debe procesar en el WS la información real de Sipweb
//actualizando diariamente los registros de Descuentos Reales Sipweb relacionados a la cuenta
//En este batch se van a procesar las cotizaciones que entren en el rango de fechas proporcionadas
global class BatchSeguimiento2 implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
	 
    public String query;
    public String AccId;
    public String Inicioo;
    public String Fiin;
    public List<SBQQ__QuoteLine__c> partidas = new List<SBQQ__QuoteLine__c>();
    public Map<String, Map<String, SBQQ__QuoteLine__c>> quotes = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
    public Map<String, Decimal> descuentos = new Map<String, Decimal>();
    public Map<String, Date> fechas = new Map<String, Date>();
    public Map<String, String> cotizacion = new Map<String, String>();
    public List<Descuento_Real_SipWeb__c> insertDescuentos = new List<Descuento_Real_SipWeb__c>();
    public List<FrecuenciaDeEnvios__c> insertFrecuencias = new List<FrecuenciaDeEnvios__c>();
    public List<String> listRange = new List<String> {
                '0-400'
                , '401-800'
                , '801-1200'
                , '1201-1600'
                , '1601-2000'
                , '2001-2400'
                , 'Más de 2400'
        };
    public List<String> listFee = new List<String> {
                'TS', 'T0', 'T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7',
                'TS ZP', 'T0 ZP', 'T1 ZP', 'T2 ZP', 'T3 ZP', 'T4 ZP', 'T5 ZP', 'T6 ZP', 'T7 ZP'
    	};
    
    public BatchSeguimiento2(String AccountId, String Inicio, String Fin){
    	AccId = AccountId;
        Inicioo = Inicio;
        Fiin = Fin;
        for(String Fee:listFee){
            quotes.put(Fee, new Map<String, SBQQ__QuoteLine__c>());
            for(String Range:listRange){
                SBQQ__QuoteLine__c q = new SBQQ__QuoteLine__c();
                q.SBQQ__Quantity__c = 0;
                q.PackWeightAVG__c = 0;
                q.PackVolAVG__c = 0;
                quotes.get(Fee).put(Range, q);
            }
        }
        if(!test.isRunningTest()){
        query = 'SELECT Id, Name, SBQQ__Account__c, Fecha_de_autorizada__c, SBQQ__Status__c, SBQQ__Account__r.ParentId, ' +
            	'Tipo_de_documentacion__c FROM SBQQ__Quote__c ' +
            	'WHERE (SBQQ__Account__c = \'' + AccId + '\' OR SBQQ__Account__r.ParentId = \'' + AccId + '\') ' +
            	'AND SBQQ__Status__c = \'Approved\' AND Fecha_de_autorizada__c >= ' + Inicio + ' AND Fecha_de_autorizada__c <= ' + Fin +
            	' AND Tipo_de_documentacion__c = \'En Piso-Sipweb\' ' +
            	'ORDER BY Fecha_de_autorizada__c DESC NULLS LAST';
        } else {
        query = 'SELECT Id, Name, SBQQ__Account__c, Fecha_de_autorizada__c, SBQQ__Status__c, SBQQ__Account__r.ParentId, ' +
            	'Tipo_de_documentacion__c FROM SBQQ__Quote__c ' +
            	'WHERE SBQQ__Account__c = \'' + AccId + '\'';
        }
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        system.debug(query);
    	return Database.getQueryLocator(query);	
    }
    
    global void execute(Database.BatchableContext bc, List<SBQQ__Quote__c> records) {
        for (SBQQ__Quote__c q: records) {
            //El descuento en servicios Express esta en el campo Descuento adicional (SBQQ__Discount__c)
            //DiscountAcuse__c : ACK
            //DiscountFlete__c : PACKETS (Para T0-T7) y ENVELOPES (TS)
            //DiscountRecolection__c : RAD
            //DiscountDelivery__c : EAD (No zona plus) y *** (zona plus)
            //DiscountSeg__c : ***
            //SBQQ__Discount__c : SEG-A12, SEG-DS, SEG-2D, SEG-MD
            //STD-T : SIPWEB_NORMAL o SIPWEB_ZE
        	partidas = [SELECT SBQQ__Quote__c, Tarifa__c, DiscountAcuse__c, DiscountFlete__c, DiscountRecolection__c, DiscountDelivery__c,
                        DiscountSeg__c, SBQQ__Discount__c, ZonaPlus__c, SBQQ__Quantity__c, Rango_KM__c, PackWeightAVG__c, PackVolAVG__c	 
                        FROM SBQQ__QuoteLine__c 
                        WHERE SBQQ__Quote__c =: q.Id];
            
            for(SBQQ__QuoteLine__c p:partidas){
                if(p.ZonaPlus__c == false){
                    if(p.Tarifa__c == 'TARIFA SOBRE'){
                        //Guarda en el mapa resultado para ENVELOPES, DiscountFlete__c
                        descuentos.put('ENVELOPES', p.DiscountFlete__c);
                        fechas.put('ENVELOPES', q.Fecha_de_autorizada__c);
                        cotizacion.put('ENVELOPES', q.Name);
                        
                        for(String keyRange: listRange){
                        	if(p.Rango_KM__c == keyRange){
                            	quotes.get('TS').put(keyRange, p);	
                            }
                        }
                    } else if(p.Tarifa__c == 'SEG-DS' || p.Tarifa__c == 'SEG-2D' || p.Tarifa__c == 'SEG-A12' || p.Tarifa__c == 'SEG-MD'){
                        //Guarda SBQQ__Discount__c
                        descuentos.put(p.Tarifa__c, p.SBQQ__Discount__c);
                        fechas.put(p.Tarifa__c, q.Fecha_de_autorizada__c);
                        cotizacion.put(p.Tarifa__c, q.Name);
                    } else {
                        //Guarda Acuse, seguro, rad, ead
                        descuentos.put('ACK', p.DiscountAcuse__c);
                        fechas.put('ACK', q.Fecha_de_autorizada__c);
                        cotizacion.put('ACK', q.Name);
                        
                        descuentos.put('SEG', p.DiscountSeg__c);
                        fechas.put('SEG', q.Fecha_de_autorizada__c);
                        cotizacion.put('SEG', q.Name);
                        
                        descuentos.put('RAD', p.DiscountRecolection__c);
                        fechas.put('RAD', q.Fecha_de_autorizada__c);
                        cotizacion.put('RAD', q.Name);
                        
                        descuentos.put('EAD', p.DiscountDelivery__c);
                        fechas.put('EAD', q.Fecha_de_autorizada__c);
                        cotizacion.put('EAD', q.Name);
                        
                        if(p.Tarifa__c == 'TARIFA T0'){
                            for(String keyRange: listRange){
                                if(p.Rango_KM__c == keyRange){
                            		quotes.get('T0').put(keyRange, p);
                                }
                            }
                        } else if(p.Tarifa__c == 'TARIFA T1'){
                            for(String keyRange: listRange){
                                if(p.Rango_KM__c == keyRange){
                            		quotes.get('T1').put(keyRange, p);
                                }
                            }
                        } else if(p.Tarifa__c == 'TARIFA T2'){
                            for(String keyRange: listRange){
                                if(p.Rango_KM__c == keyRange){
                            		quotes.get('T2').put(keyRange, p);
                                }
                            }
                        } else if(p.Tarifa__c == 'TARIFA T3'){
                            for(String keyRange: listRange){
                                if(p.Rango_KM__c == keyRange){
                            		quotes.get('T3').put(keyRange, p);
                                }
                            }
                        } else if(p.Tarifa__c == 'TARIFA T4'){
                            for(String keyRange: listRange){
                                if(p.Rango_KM__c == keyRange){
                            		quotes.get('T4').put(keyRange, p);
                                }
                            }
                        } else if(p.Tarifa__c == 'TARIFA T5'){
                            for(String keyRange: listRange){
                                if(p.Rango_KM__c == keyRange){
                            		quotes.get('T5').put(keyRange, p);
                                }
                            }
                        } else if(p.Tarifa__c == 'TARIFA T6'){
                            for(String keyRange: listRange){
                                if(p.Rango_KM__c == keyRange){
                            		quotes.get('T6').put(keyRange, p);
                                }
                            }
                        } else if(p.Tarifa__c == 'TARIFA T7'){
                            for(String keyRange: listRange){
                                if(p.Rango_KM__c == keyRange){
                            		quotes.get('T7').put(keyRange, p);
                                }
                            }
                        }
                        
                    }
                } else if(p.ZonaPlus__c == true){
                    //Guardar el descuento de las tarifas t0-t7 en EXT
                    descuentos.put('EXT', p.DiscountDelivery__c);
                    fechas.put('EXT', q.Fecha_de_autorizada__c);
                    cotizacion.put('EXT', q.Name);
                    
                    if(p.Tarifa__c == 'TARIFA T0'){
                            for(String keyRange: listRange){
                                if(p.Rango_KM__c == keyRange){
                            		quotes.get('T0 ZP').put(keyRange, p);
                                }
                            }
                        } else if(p.Tarifa__c == 'TARIFA T1'){
                            for(String keyRange: listRange){
                                if(p.Rango_KM__c == keyRange){
                            		quotes.get('T1 ZP').put(keyRange, p);
                                }
                            }
                        } else if(p.Tarifa__c == 'TARIFA T2'){
                            for(String keyRange: listRange){
                                if(p.Rango_KM__c == keyRange){
                            		quotes.get('T2 ZP').put(keyRange, p);
                                }
                            }
                        } else if(p.Tarifa__c == 'TARIFA T3'){
                            for(String keyRange: listRange){
                                if(p.Rango_KM__c == keyRange){
                            		quotes.get('T3 ZP').put(keyRange, p);
                                }
                            }
                        } else if(p.Tarifa__c == 'TARIFA T4'){
                            for(String keyRange: listRange){
                                if(p.Rango_KM__c == keyRange){
                            		quotes.get('T4 ZP').put(keyRange, p);
                                }
                            }
                        } else if(p.Tarifa__c == 'TARIFA T5'){
                            for(String keyRange: listRange){
                                if(p.Rango_KM__c == keyRange){
                            		quotes.get('T5 ZP').put(keyRange, p);
                                }
                            }
                        } else if(p.Tarifa__c == 'TARIFA T6'){
                            for(String keyRange: listRange){
                                if(p.Rango_KM__c == keyRange){
                            		quotes.get('T6 ZP').put(keyRange, p);
                                }
                            }
                        } else if(p.Tarifa__c == 'TARIFA T7'){
                            for(String keyRange: listRange){
                                if(p.Rango_KM__c == keyRange){
                            		quotes.get('T7 ZP').put(keyRange, p);
                                }
                            }
                        }
                }   
            }
        }
        
    }
    
    global void finish(Database.BatchableContext bc) {
        try{
        //Crear registros de Descuentos Reales Sipweb con la información resultante guardando por cada
        //servicio un registro con su descuento y fecha de aprobación
        for(String serv : descuentos.keySet()){
        	Descuento_Real_SipWeb__c des = new Descuento_Real_SipWeb__c();
        	des.Servicio__c = serv;
            des.Descuento__c = descuentos.get(serv);
            des.Cuenta__c = AccId;
            des.Fecha_de_Aprobaci_n__c = fechas.get(serv);
            des.Cotizaci_n__c = cotizacion.get(serv);
            
            insertDescuentos.add(des);
        }
        
        List<Descuento_Real_SipWeb__c> borrar = new List<Descuento_Real_SipWeb__c>();
        borrar = [SELECT Id, Cuenta__c, Descuento_Real__c
                  FROM Descuento_Real_SipWeb__c 
                  WHERE Cuenta__c =: AccId AND Descuento_Real__c = false];
        
        List<FrecuenciaDeEnvios__c> borrar2 = new List<FrecuenciaDeEnvios__c>();
        borrar2 = [SELECT Id, Cuenta__c, RecordType.Name
                   FROM FrecuenciaDeEnvios__c
                   WHERE Cuenta__c =: AccId
                   AND RecordType.Name = 'Frecuencia Cotizada'];
        
            Id tipo = [SELECT Id, Name FROM RecordType WHERE Name = 'Frecuencia Cotizada'].Id;
            
        for(String keyFee: listFee){
            for(String keyRange: listRange){
                FrecuenciaDeEnvios__c fr = new FrecuenciaDeEnvios__c();
                fr.Cuenta__c = AccId;
                fr.RecordTypeId = tipo;
                fr.Rango__c = keyRange;
                fr.Tarifa__c = keyFee;
                fr.Bultos__c = quotes.get(keyFee).get(keyRange).SBQQ__Quantity__c;
                fr.Peso__c = quotes.get(keyFee).get(keyRange).PackWeightAVG__c;
                fr.Volumen__c = quotes.get(keyFee).get(keyRange).PackVolAVG__c;
                fr.Zona_Plus__c = quotes.get(keyFee).get(keyRange).ZonaPlus__c;
                //fr.Mes__c = 
                //fr.Anio__c = ;
                
                insertFrecuencias.add(fr);
            }
        }
        
        if(insertDescuentos.size()>0){
            if(borrar.size()>0) { Delete borrar; }
            Insert insertDescuentos;
        }
        
        if(insertFrecuencias.size()>0){
            if(borrar2.size()>0) { Delete borrar2; }
            Insert insertFrecuencias;
        }
        
        //-----------------------INICIO SIGUIENTE BATCH--------------------------------
        if(!test.isRunningTest()){
        BatchSeguimiento3 batch3 = new BatchSeguimiento3(AccId, Inicioo, Fiin); 
		database.executeBatch(batch3);
        }
            
        } catch (Exception ex){
            System.debug('Error en finish ' + + ex.getLineNumber()+' '+ex.getMessage());
        }
    }
}
