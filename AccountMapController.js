({
    jsLoaded: function(component, event, helper) {
        //var map = L.map('map', {zoomControl: false, tap: false}).setView([19.3910038,-99.2837008], 14);
        var map = L.map('map', {zoomControl: false, tap: false, markerZoomAnimation: false}).setView([19.4377901,-99.1219083], 13);
        L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
            {
                attribution: 'Paquetexpress'
            }).addTo(map);
        component.set("v.map", map);
        var greenIcon = new L.Icon({
          iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-green.png',
          shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
          iconSize: [25, 41],
          iconAnchor: [12, 41],
          popupAnchor: [1, -34],
          shadowSize: [41, 41]
        });
        var map = component.get('v.map');
        var marker = L.marker(map.getCenter(), {icon: greenIcon}).addTo(map);
        var circle=L.circleMarker(map.getCenter(), 10).addTo(map);
        $('#cargandoubicacion').show();
        map.on('locationfound', function onLocationFound(e) {
          var radius = e.accuracy / 2;
          marker=marker.setLatLng(e.latlng).update().bindPopup("Usted se encuentra a " + radius + " metros de este punto");
          component.set("v.mylocation", marker);
          component.set("v.latitude", e.latlng.lat);
          component.set("v.longitude", e.latlng.lng);
          circle=circle.setLatLng(e.latlng);
          circle=circle.setRadius(radius);
		  $('#cargandoubicacion').hide();
        });
        $('#ubicacioncargada').show();
		map.locate({ watch: true});
		var action = component.get("c.checkVisit");
        action.setCallback(this, function(response) {
        	var state = response.getState();
        	if (state==="SUCCESS") {
        		var resultado=response.getReturnValue();
                if (resultado=="si") {
                	var evento = $A.get("e.c:EnVisita");
                	evento.fire();
                }
                if (resultado=="no") {
                    
                }
            } else {
                            //operación no fue exitosa, inserción fallida
                            
             }        	
        });
        $A.enqueueAction(action);
        var markers=L.layerGroup([]);
        markers.addTo(map);
        component.set("v.markers", markers);      
    },
    
    eventsLoaded: function(component, event, helper){
        var redIcon = new L.Icon({
          iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-red.png',
          shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
          iconSize: [25, 41],
          iconAnchor: [12, 41],
          popupAnchor: [1, -34],
          shadowSize: [41, 41]
        });
        var map = component.get('v.map');
        var accounts = event.getParam('accounts');
        var marker;
        var markers=L.layerGroup([]);
        for (var i=0; i<accounts.length; i++) {
            var account = accounts[i];
            if(account.Location__Latitude__s!=null && account.Location__Longitude__s!=null) {
            	var latLng = [account.Location__Latitude__s, account.Location__Longitude__s];
            	marker=L.marker(latLng, {account: account, icon: redIcon}).addTo(markers).bindPopup("Por visitar: "+account.Name);
            }
        }
        markers.addTo(map);
        component.set("v.markers", markers);
        
    },
    
    eventsLoaded2: function(component, event, helper){
        var orangeIcon = new L.Icon({
          iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-orange.png',
          shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
          iconSize: [25, 41],
          iconAnchor: [12, 41],
          popupAnchor: [1, -34],
          shadowSize: [41, 41]
        });
        var map = component.get('v.map');
        var accounts = event.getParam('accounts');
        var marker;
        var markers=L.layerGroup([]);
        for (var i=0; i<accounts.length; i++) {
            var account = accounts[i];
            if(account.Location__Latitude__s!=null && account.Location__Longitude__s!=null) {
            	var latLng = [account.Location__Latitude__s, account.Location__Longitude__s];
            	marker=L.marker(latLng, {account: account, icon: orangeIcon}).addTo(markers).bindPopup("En visita: "+account.Name);
            }
        }
        markers.addTo(map);
        component.set("v.markers", markers);
        
    },
    
    eventsLoaded3: function(component, event, helper){
        var yellowIcon = new L.Icon({
          iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-gold.png',
          shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
          iconSize: [25, 41],
          iconAnchor: [12, 41],
          popupAnchor: [1, -34],
          shadowSize: [41, 41]
        });
        var map = component.get('v.map');
        var accounts = event.getParam('accounts');
        var marker;
        var markers=L.layerGroup([]);
        for (var i=0; i<accounts.length; i++) {
            var account = accounts[i];
            if(account.Location__Latitude__s!=null && account.Location__Longitude__s!=null) {
            	var latLng = [account.Location__Latitude__s, account.Location__Longitude__s];
           		marker=L.marker(latLng, {account: account, icon: yellowIcon}).addTo(markers).bindPopup("Visita realizada: "+account.Name);
            }
        }
        markers.addTo(map);
        component.set("v.markers", markers);
        
    },
    
    LeadsLoaded: function(component, event, helper){
        var redLeadIcon = new L.Icon({
          iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-red.png',
          shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
          iconSize: [25, 41],
          iconAnchor: [12, 41],
          popupAnchor: [1, -34],
          shadowSize: [41, 41]
        });
        var map = component.get('v.map');
        var leads = event.getParam('leads');
        var marker;
        var markers=L.layerGroup([]);
        for (var i=0; i<leads.length; i++) {
            var lead = leads[i];
            if(lead.Location__Latitude__s!=null && lead.Location__Longitude__s!=null) {
            		var latLng = [lead.Location__Latitude__s, lead.Location__Longitude__s];
            marker=L.marker(latLng, {lead: lead, icon: redLeadIcon}).addTo(markers).bindPopup("Por visitar: "+ lead.Name);
            }
        }
        markers.addTo(map);
        component.set("v.markers", markers);
        
    },
    
	LeadsLoaded2: function(component, event, helper){
        var yellowLeadIcon = new L.Icon({
          iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-gold.png',
          shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
          iconSize: [25, 41],
          iconAnchor: [12, 41],
          popupAnchor: [1, -34],
          shadowSize: [41, 41]
        });
        var map = component.get('v.map');
        var leads = event.getParam('leads');
        var marker;
        var markers=L.layerGroup([]);
        for (var i=0; i<leads.length; i++) {
            var lead = leads[i];
            if(lead.Location__Latitude__s!=null && lead.Location__Longitude__s!=null) {
            		var latLng = [lead.Location__Latitude__s, lead.Location__Longitude__s];
            marker=L.marker(latLng, {lead: lead, icon: yellowLeadIcon}).addTo(markers).bindPopup("Visita realizada: "+ lead.Name);
            }
        }
        markers.addTo(map);
        component.set("v.markers", markers);
        
    },
    
    DescAccounts: function(component, event, helper){
        var violetIcon = new L.Icon({
          iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-violet.png',
          shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
          iconSize: [25, 41],
          iconAnchor: [12, 41],
          popupAnchor: [1, -34],
          shadowSize: [41, 41]
        });
        var map = component.get('v.map');
        var accounts = event.getParam('accounts');
        map.on('locationfound', function onLocationFound(e) {
            var from = [e.latitude, e.longitude];
        });
        var marker;
        var markers=L.layerGroup([]);
        for (var i=0; i<accounts.length; i++) {
            var account = accounts[i];
            if(account.Location__Latitude__s!=null && account.Location__Longitude__s!=null) {
            	var latLng = [account.Location__Latitude__s, account.Location__Longitude__s];
            	marker=L.marker(latLng, {account: account, icon: violetIcon}).addTo(markers).bindPopup("Cuenta decrecida: " + account.Name);
            }
        }
        markers.addTo(map);
        component.set("v.markers", markers);
        
    },

    accountsLoaded: function(component, event, helper) {
        /*
        var map = component.get('v.map');
        var accounts = event.getParam('accounts');
        var marker;
        var markers=L.layerGroup([]);
        for (var i=0; i<accounts.length; i++) {
            var account = accounts[i];
            var latLng = [account.Location__Latitude__s, account.Location__Longitude__s];
			marker=L.marker(latLng, {account: account}).addTo(markers).on('click', function(event) {
                helper.navigateToDetailsView(event.target.options.account.Id);
            });
        }
        markers.addTo(map);
        component.set("v.markers", markers);
        */
    },
    
    accountsReload: function(component, event, helper) {
        debugger;
        component.set("v.account", null);
        debugger;
        
        var map = component.get('v.map');
        var oldmarkers = component.get('v.markers');
		var oldmarkerslayer=oldmarkers[0];
		oldmarkerslayer.clearLayers();
        //debugger;
        /*
        for(var i = 0; i < oldmarkers.length; i++){
            map.removeLayer(oldmarkers[i]);
        }
        */
        //oldmarkerslayer._layers.clearLayers();
        var accounts = event.getParam('accounts');
        var marker;
        //var markers=[];
        //var markers=L.layerGroup([]);
        //oldmarkerslayer.remove();
        for (var i=0; i<accounts.length; i++) {
            var account = accounts[i];
            if(account.Location__Latitude__s!=null && account.Location__Longitude__s!=null) {
            var latLng = [account.Location__Latitude__s, account.Location__Longitude__s];
            /*
            marker=L.marker(latLng, {account: account}).addTo(map).on('click', function(event) {
                helper.navigateToDetailsView(event.target.options.account.Id);
            });
            */
            //debugger;
            marker=L.marker(latLng, {account: account}).addTo(oldmarkerslayer).bindPopup(account.Name);
            //debugger;
			//markers.push(marker);
			//markers.addLayer(marker);
        }
        //debugger;
        //oldmarkerslayer.addTo(map);
        //debugger;
        component.set("v.markers", oldmarkerslayer);
        }
    },

    LeadsReload: function(component, event, helper) {
        debugger;
        component.set("v.lead", null);
        debugger;
        
        var map = component.get('v.map');
        var oldmarkers = component.get('v.markers');
		var oldmarkerslayer=oldmarkers[0];
		oldmarkerslayer.clearLayers();
        var leads = event.getParam('leads');
        var marker;
        
        for (var i=0; i<leads.length; i++) {
            var lead = leads[i];
            if(lead.Location__Latitude__s!=null && lead.Location__Longitude__s!=null) {
            	var latLng = [lead.Location__Latitude__s, lead.Location__Longitude__s];
            	marker=L.marker(latLng, {lead: lead}).addTo(oldmarkerslayer).bindPopup(lead.Name);
            }
        component.set("v.markers", oldmarkerslayer);
        }
    },

    
    accountSelected: function(component, event, helper) {
        // Center the map on the account selected in the list
        var map = component.get('v.map');
 		map.locate({setView: false});
        //map.stopLocate();
        var account = event.getParam("account");
        component.set("v.account", account);
        if(account.Location__Latitude__s!=null && account.Location__Longitude__s!=null) {
        var latlng = L.latLng(account.Location__Latitude__s, account.Location__Longitude__s);
        map.flyTo(latlng);
        }
        
    },
    
    leadSelected: function(component, event, helper) {
        var map = component.get('v.map');
 		map.locate({setView: false});
        var lead = event.getParam("lead");
        component.set("v.lead", lead);
        if(lead.Location__Latitude__s!=null && lead.Location__Longitude__s!=null) {
        var latlng = L.latLng(lead.Location__Latitude__s, lead.Location__Longitude__s);
        map.flyTo(latlng);   
        }
        
    },
    
    accountMyLocationSelected: function (component, event, helper) {
        var map = component.get('v.map');
		//map.locate({setView: true, watch: true});
        var mylocation=component.get("v.mylocation");
        //mylocation.openPopup();
        map.flyTo(mylocation.getLatLng());
	},
    
    VisitCreation: function(component, event, helper) {
        var action = component.get("c.insertVisit");
        var action2 = component.get("c.insertVisit2");
        var account=component.get("v.account");
        var lead=component.get("v.lead");
        var map = component.get('v.map');
		var lat=component.get("v.latitude");
        var lng=component.get("v.longitude");
        var TipoVisita=event.getParam('TipoVisita');
        var NoLograda=event.getParam('NoLograda');
        var Lograda=event.getParam('Lograda');
        var Vehiculo=event.getParam('Vehiculo');
        if(account!=null) {
            var iddelacuenta=account.Id;
            action.setParams({ account : iddelacuenta, lat : lat, lng : lng, tipovisita : TipoVisita, nolograda : NoLograda, lograda : Lograda, vehiculo: Vehiculo});
                    action.setCallback(this, function(response) {
                        var state = response.getState();
                        if (state==="SUCCESS") {
                            var resultado=response.getReturnValue();
                            if (resultado=="exito") {
                                $('#mensajeexito').show();
                                var evento = $A.get("e.c:EnVisita");
                                evento.fire();
                            }
                            if (resultado=="exitonolograda") {
                                $('#mensajeexito').show();
                            }
                            if (resultado=="nocerca") {
                                $('#mensajenocerca').show();
                            }
                        } else {
                            //operación no fue exitosa, inserción fallida
                            
                        }
                    });
                    $A.enqueueAction(action); 
        } if(lead!=null) {
            var iddelprospecto=lead.Id;
            action2.setParams({ lead : iddelprospecto, lat : lat, lng : lng, tipovisita : TipoVisita, nolograda : NoLograda, lograda : Lograda, vehiculo: Vehiculo});
                    action2.setCallback(this, function(response) {
                        var state = response.getState();
                        if (state==="SUCCESS") {
                            var resultado=response.getReturnValue();
                            if (resultado=="exito") {
                                $('#mensajeexito').show();
                                var evento = $A.get("e.c:EnVisita");
                                evento.fire();
                            }
                            if (resultado=="exitonolograda") {
                                $('#mensajeexito').show();
                            }
                            if (resultado=="nocerca") {
                                $('#mensajenocerca').show();
                            }
                        } else {
                            //operación no fue exitosa, inserción fallida
                            
                        }
                    });
                    $A.enqueueAction(action2);
            
        } if(account==null && lead==null) {
            //no había cuenta seleccionada, no se hizo solicitud al servidor
            $('#mensajeerror').show();
        }


    },
    
    ocultarmensajeexito: function(component, event, helper) {
    	$('#mensajeexito').hide();
	},
    
    ocultarmensajeexito2: function(component, event, helper) {
    	$('#mensajeexito2').hide();
	}, 
    
    ocultarcargandoubicacion: function(component, event, helper) {
    	$('#cargandoubicacion').hide();
	},

    ocultarubicacioncargada: function(component, event, helper) {
    	$('#ubicacioncargada').hide();
	},    
    
    ocultarmensajenocerca: function(component, event, helper) {
    	$('#mensajenocerca').hide();
	},
    
    ocultarmensajeerror: function(component, event, helper) {
    	$('#mensajeerror').hide();
	},

    ocultarmensajenobusqueda: function(component, event, helper) {
    	$('#mensajenobusqueda').hide();
	},

    ocultarmensajenoseencontraron: function(component, event, helper) {
    	$('#mensajenoseencontraron').hide();
	},
    
    CreateAcc: function(component, event, helper) {
        var createAcountContactEvent = $A.get("e.force:createRecord");
		var lat=component.get("v.latitude");
        var lng=component.get("v.longitude");        
        createAcountContactEvent.setParams({
            "entityApiName": "Account",
            
            "defaultFieldValues": {
                'Location__Latitude__s' : lat,
                'Location__Longitude__s' : lng
            }
        });
        createAcountContactEvent.fire();    	
	},      
        
    ChangeLocationAccount: function(component, event, helper) {
        var account=component.get("v.account");
        var lead=component.get("v.lead");
        console.log(account + ", " + lead);
        if(account!=null) {
            var action = component.get("c.changeLocation");
			var lat=component.get("v.latitude");
        	var lng=component.get("v.longitude");
            var iddelacuenta=account.Id;
            action.setParams({ account : iddelacuenta, lat : lat, lng : lng });
            	action.setCallback(this, function(response) {
                        var state = response.getState();
                        if (state==="SUCCESS") {
                            var resultado=response.getReturnValue();
                            if (resultado=="exito") {
                                $('#mensajeexito2').show();
                            }
                        } else {
                            //operación no fue exitosa, inserción fallida
                            
                        }
                    });
                    $A.enqueueAction(action);
        } 
        if(lead!=null){
            var action = component.get("c.changeLocation2");
			var lat=component.get("v.latitude");
        		var lng=component.get("v.longitude");
            var iddelprospecto=lead.Id;
            action.setParams({ lead : iddelprospecto, lat : lat, lng : lng });
            	action.setCallback(this, function(response) {
                        var state = response.getState();
                        if (state==="SUCCESS") {
                            var resultado=response.getReturnValue();
                            if (resultado=="exito") {
                                $('#mensajeexito2').show();
                            }
                        } else {
                            //operación no fue exitosa, inserción fallida
                            
                        }
                    });
                    $A.enqueueAction(action);
        } 
        if(account==null && lead==null) {
            $('#mensajeerror').show();
        }
	},

    MyActualLocation: function(component, event, helper) {
        console.log("Empezando a cargar las coordenadas");
        var lat = component.get("v.latitude"); //19.1678097;
        var lng = component.get("v.longitude"); //-96.1331913;
        console.log("Coordenadas cargadas a variables: "+lat+" , "+lng);
        var setLocation = $A.get("e.c:coorOfMyActualLocation");
        console.log("Evento invocado");
        setLocation.setParams({ "lat" : lat,
                                "lng" : lng });
        console.log("setParams exito"+lat+","+lng);
        setLocation.fire();
        console.log("eventFire");
    },

})
