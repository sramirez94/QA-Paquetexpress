//Frecuencia cotizada - PREPAGO
global class BatchSeguimiento2b implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
	 
    public String query;
    public String AccId;
    public String Inicioo;
    public String Fiin;
    public String Quote;
    public List<SBQQ__QuoteLine__c> partidas = new List<SBQQ__QuoteLine__c>();
    public Map<String, Map<String, SBQQ__QuoteLine__c>> quotes = new Map<String, Map<String, SBQQ__QuoteLine__c>>();
    public Map<String, String> sAdicionales = new Map<String, String>();
    public Map<String, Date> fechas = new Map<String, Date>();
    public Map<String, String> cotizacion = new Map<String, String>();
    public List<FrecuenciaDeEnvios__c> insertFrecuencias = new List<FrecuenciaDeEnvios__c>();
    public List<String> listRange = new List<String> {
                '0-400', '401-800', '801-1200', '1201-1600', '1601-2000', '2001-2400', 'Más de 2400'
        };
    public List<String> listFee = new List<String> {
                'TS', 'T0', 'T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7',
                'TS ZP', 'T0 ZP', 'T1 ZP', 'T2 ZP', 'T3 ZP', 'T4 ZP', 'T5 ZP', 'T6 ZP', 'T7 ZP',
                'A12', 'DS', '2DS'
    	};
    
    public BatchSeguimiento2b(String AccountId, String Inicio, String Fin){
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
            	'Tipo_de_documentacion__c, PAQ_TipoServicio__c FROM SBQQ__Quote__c ' +
            	'WHERE (SBQQ__Account__c = \'' + AccId + '\' OR SBQQ__Account__r.ParentId = \'' + AccId + '\') ' +
            	'AND SBQQ__Status__c = \'Approved\' ' +
            	'AND Tipo_de_documentacion__c = \'Guías prepagadas\' ' +
            	'ORDER BY Fecha_de_autorizada__c ASC NULLS FIRST';
        } else {
        query = 'SELECT Id, Name, SBQQ__Account__c, Fecha_de_autorizada__c, SBQQ__Status__c, SBQQ__Account__r.ParentId, ' +
            	'Tipo_de_documentacion__c, PAQ_TipoServicio__c FROM SBQQ__Quote__c ' +
            	'WHERE SBQQ__Account__c = \'' + AccId + '\'';
        }
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        system.debug(query);
    	return Database.getQueryLocator(query);	
    }
    
    global void execute(Database.BatchableContext bc, List<SBQQ__Quote__c> records) {
        for (SBQQ__Quote__c q: records) {
            quote = q.Id;
            partidas = [SELECT SBQQ__Quote__c, Tarifa__c, ZonaPlus__c, SBQQ__Quantity__c, Rango_KM__c, PackWeightAVG__c, PackVolAVG__c,
                        SBQQ__CustomerTotal__c, SBQQ__NetTotal__c, SBQQ__AdditionalDiscount__c, 
                        SBQQ__Quote__r.Name, SBQQ__Quote__r.Servicios_adicionales__c, SBQQ__Quote__r.Fecha_de_autorizada__c
                        FROM SBQQ__QuoteLine__c 
                        WHERE SBQQ__Quote__c =: q.Id];
            
            if(q.PAQ_TipoServicio__c == 'Estándar terrestre (STD)'){
            	for(SBQQ__QuoteLine__c p:partidas){
            	if(p.ZonaPlus__c == false){
                	if(p.Tarifa__c == 'TARIFA SOBRE'){
                        for(String keyRange: listRange){
                            if(p.Rango_KM__c == keyRange){
                                quotes.get('TS').put(keyRange, p);
                            }     
                        }
                    } else if(p.Tarifa__c == 'TARIFA T0'){
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
                } else if(p.ZonaPlus__c == true){
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
            } else if(q.PAQ_TipoServicio__c == 'Servicio Express Garantizado (SEG)'){
                for(SBQQ__QuoteLine__c p:partidas){
                    if(p.Tarifa__c == 'SEG-DS'){
                        for(String keyRange: listRange){
                            if(p.Rango_KM__c == keyRange){
                                quotes.get('DS').put(keyRange, p);
                            }     
                        }
                    }
                    if(p.Tarifa__c == 'SEG-2D'){
                        for(String keyRange: listRange){
                            if(p.Rango_KM__c == keyRange){
                                quotes.get('2DS').put(keyRange, p);
                            }     
                        }
                    }
                    if(p.Tarifa__c == 'SEG-A12'){
                        for(String keyRange: listRange){
                            if(p.Rango_KM__c == keyRange){
                                quotes.get('A12').put(keyRange, p);
                            }     
                        }
                    }
                }
            }
        }
    }
    
    global void finish(Database.BatchableContext bc) {
        try{
        //Crear registros de Frecuencia cotizada y llamar el siguiente batch
        List<FrecuenciaDeEnvios__c> borrar2 = new List<FrecuenciaDeEnvios__c>();
        borrar2 = [SELECT Id, Cuenta__c, Tipo__c, RecordType.Name
                   FROM FrecuenciaDeEnvios__c
                   WHERE Cuenta__c =: AccId
                   AND Tipo__c = 'Prepago'
                   AND RecordType.Name = 'Frecuencia Cotizada'];
        
            Id tipo = [SELECT Id, Name FROM RecordType WHERE Name = 'Frecuencia Cotizada'].Id;
            
        for(String keyFee: listFee){
            for(String keyRange: listRange){
                FrecuenciaDeEnvios__c fr = new FrecuenciaDeEnvios__c();
                fr.Cuenta__c = AccId;
                fr.RecordTypeId = tipo;
                fr.Tipo__c = 'Prepago';
                fr.Rango__c = keyRange;
                fr.Tarifa__c = keyFee;
                fr.Bultos__c = quotes.get(keyFee).get(keyRange).SBQQ__Quantity__c;
                fr.Peso__c = quotes.get(keyFee).get(keyRange).PackWeightAVG__c;
                fr.Volumen__c = quotes.get(keyFee).get(keyRange).PackVolAVG__c;
                fr.Zona_Plus__c = quotes.get(keyFee).get(keyRange).ZonaPlus__c;
                fr.Total_tarifa_llena__c = quotes.get(keyFee).get(keyRange).SBQQ__NetTotal__c;
                fr.Total_propuesta__c = quotes.get(keyFee).get(keyRange).SBQQ__CustomerTotal__c;
                fr.Servicios__c = quotes.get(keyFee).get(keyRange).SBQQ__Quote__r.Servicios_adicionales__c;
                fr.Cotizacion__c = quotes.get(keyFee).get(keyRange).SBQQ__Quote__r.Name;
                fr.Fecha_de_Aprobacion__c = quotes.get(keyFee).get(keyRange).SBQQ__Quote__r.Fecha_de_autorizada__c;
                //fr.Mes__c = 
                //fr.Anio__c = ;
                
                if(quotes.get(keyFee).get(keyRange).SBQQ__Quantity__c != 0 && quotes.get(keyFee).get(keyRange).SBQQ__Quantity__c != null){
                    insertFrecuencias.add(fr);}
            }
        }
            
            if(insertFrecuencias.size()>0){
            	if(borrar2.size()>0) { Delete borrar2; }
            	Insert insertFrecuencias;
        	}
            
        if(!test.isRunningTest()){
        BatchSeguimiento3b batch3 = new BatchSeguimiento3b(AccId, Inicioo, Fiin, quote); 
		database.executeBatch(batch3);
        }
            
        } catch (Exception ex){
            System.debug('Error en finish ' + + ex.getLineNumber()+' '+ex.getMessage());
        }
    }
}
