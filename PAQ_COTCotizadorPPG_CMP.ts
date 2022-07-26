<!--
  @description       : 
  @author            : ChangeMeIn@UserSettingsUnder.SFDoc
  @group             : 
  @last modified on  : 02-17-2022
  @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
-->
<apex:component controller="PAQ_CotizadorNacional_CTR">
    <div ng-controller="PPGController as PPGCTR">
        <div ng-show="PPstep1">
            <!--header-->
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="row">
                        <div class="col-md-2 col-sm-2">
                            <div class="row center">
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#ModalFee">
                                    Tarifas  <span class="glyphicon glyphicon-plus"></span>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-2 col-sm-2">
                            <div class="row center">
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#ModalServices">
                                    Servicios <span class="glyphicon glyphicon-plus"></span>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-2 col-sm-2">
                            <div class="row center">
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#ModalQuickDisc">
                                    Descuentos rápidos <span class="glyphicon glyphicon-plus"></span>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-6">
                            <div class="row">
                                <div class="col-md-3 col-sm-3 center"><span class="bold">TOTAL NORMAL</span></div>
                                <div class="col-md-3 col-sm-3 center"><span class="bold">TOTAL PROPUESTA</span></div>
                                <div class="col-md-3 col-sm-3 center"><span class="bold">TOTAL DESCUENTO</span></div>
                                <div class="col-md-3 col-sm-3 center"><span class="bold">TOTAL PAQUETES</span></div>
                            </div>
                            <div class="row">
                                <div class="col-md-3 col-sm-3 center"><span ng-bind="PP.TOTAL['NORMAL'] | currency"></span></div>
                                <div class="col-md-3 col-sm-3 center"><span ng-bind="PP.TOTAL['PROPUESTA'] | currency"></span></div>
                                <div class="col-md-3 col-sm-3 center"><span ng-bind="PP.TOTAL['DESCUENTO'] | percentage:2"></span></div>
                                <div class="col-md-3 col-sm-3 center"><span ng-bind="PP.TOTAL['PAQUETES'] | number"></span></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--dual tables-->
            <div class="row">
                <div class="col-md-6 col-sm-6">
                    <div class="panel panel-default" ng-repeat="(strFeeKey, fee) in PP.listFee" ng-show="PP.mapQuotes[strFeeKey].blnShow && strFeeKey !== 'T7'" style="overflow: scroll;">
                        <div class="panel-heading">
                            <a data-toggle="collapse" href="#{{strFeeKey}}"><h3 class="panel-title" ng-bind="fee"></h3></a>
                        </div>
                        <div id="{{strFeeKey}}" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <table class="table table-striped">
                                    <thead class="thead-light">
                                    <tr>
                                        <th>Rango KM</th>
                                        <th>Tarifa llena</th>
                                        <th># Paquetes (Frecuencia)</th>
                                        <th>Tarifa propuesta</th>
                                        <th>TOTAL PROPUESTA</th>
                                        <th>Descuento</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td colspan="2">Replicar en todos los rangos</td>
                                        <td class="thead-light center"><input type="checkbox" ng-model="PP.mapQuotes[strFeeKey].blnSameFrecuency" ng-click="replicate('Quantity', PP.mapQuotes[strFeeKey].ranges['0-400'].intFrecuency, strFeeKey)" /> </td>
                                        <td class="thead-light center"><input type="checkbox" ng-model="PP.mapQuotes[strFeeKey].blnSameQuote" ng-click="replicate('Quote', PP.mapQuotes[strFeeKey].ranges['0-400'].fltQuoteFee, strFeeKey)" /></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr ng-repeat="(keyRange, strRange) in PP.listRange">
                                        <td ng-bind="strRange"></td>
                                        <td ng-bind="PP.mapQuotes[strFeeKey].ranges[keyRange].fltFullFee | currency"></td>
                                        <td class="thead-light center" contenteditable="true" ng-bind="PP.mapQuotes[strFeeKey].ranges[keyRange].intFrecuency | number" ng-blur="setValue('PPintFrecuency', keyRange, $event, strFeeKey)"></td>
                                        <td class="thead-light center" contenteditable="true" ng-bind="PP.mapQuotes[strFeeKey].ranges[keyRange].fltQuoteFee | currency" ng-blur="setValue('PPfltQuoteFee', keyRange, $event, strFeeKey)"></td>
                                        <td ng-bind="PP.mapQuotes[strFeeKey].ranges[keyRange].fltTotalQuote | currency"></td>
                                        <td ng-bind="PP.mapQuotes[strFeeKey].ranges[keyRange].fltDiscount | percentage:2"></td>
                                    </tr>
                                    <tr>
                                        <td>Total</td>
                                        <td></td>
                                        <td class="center"><span ng-bind="PP.mapQuotes[strFeeKey].intFeeTotalFrec | number"></span></td>
                                        <td></td>
                                        <td><span ng-bind="PP.mapQuotes[strFeeKey].fltFeeTotalQuote | currency"></span></td>
                                        <td><span ng-bind="PP.mapQuotes[strFeeKey].fltFeeTotalDesc | percentage:2"></span></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-sm-6">
                    <div class="panel panel-default" ng-repeat="(strFeeKey, fee) in PPZP.listFee" ng-show="PP.mapQuotes[strFeeKey].blnShow" style="overflow: scroll;">
                        <div class="panel-heading">
                            <a data-toggle="collapse" href="#{{strFeeKey}}-ZP"><h3 class="panel-title" ng-bind="fee+' ZP'"></h3></a>
                        </div>
                        <div id="{{strFeeKey}}-ZP" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <table class="table table-striped" >
                                    <thead class="thead-light">
                                    <tr>
                                        <th>Rango KM</th>
                                        <th>Tarifa llena</th>
                                        <th># Paquetes (Frecuencia)</th>
                                        <th>Tarifa propuesta</th>
                                        <th>TOTAL PROPUESTA</th>
                                        <th>Descuento</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td colspan="2">Replicar en todos los rangos</td>
                                        <td class="thead-light center"><input type="checkbox" ng-model="PPZP.mapQuotes[strFeeKey].blnSameFrecuency" ng-click="replicate('QuantityZP', PPZP.mapQuotes[strFeeKey].ranges['0-400'].intFrecuency, strFeeKey)"/></td>
                                        <td class="thead-light center"><input type="checkbox" ng-model="PPZP.mapQuotes[strFeeKey].blnSameQuote" ng-click="replicate('QuoteZP', PPZP.mapQuotes[strFeeKey].ranges['0-400'].fltQuoteFee, strFeeKey)"/></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr ng-repeat="(keyRange, strRange) in PPZP.listRange">
                                        <td class="thead-light" ng-bind="strRange"></td>
                                        <td ng-bind="PPZP.mapQuotes[strFeeKey].ranges[keyRange].fltFullFee | currency"></td>
                                        <td class="thead-light center" contenteditable="true" ng-bind="PPZP.mapQuotes[strFeeKey].ranges[keyRange].intFrecuency | number" ng-blur="setValue('PPintFrecuencyZP', keyRange, $event, strFeeKey)"></td>
                                        <td class="thead-light center" contenteditable="true" ng-bind="PPZP.mapQuotes[strFeeKey].ranges[keyRange].fltQuoteFee | currency" ng-blur="setValue('PPfltQuoteFeeZP', keyRange, $event, strFeeKey)"></td>
                                        <td ng-bind="PPZP.mapQuotes[strFeeKey].ranges[keyRange].fltTotalQuote | currency"></td>
                                        <td ng-bind="PPZP.mapQuotes[strFeeKey].ranges[keyRange].fltDiscount | percentage:2"></td>
                                    </tr>
                                    <tr>
                                        <td>Total</td>
                                        <td></td>
                                        <td class="center"><span ng-bind="PPZP.mapQuotes[strFeeKey].intFeeTotalFrec | number"></span></td>
                                        <td></td>
                                        <td><span ng-bind="PPZP.mapQuotes[strFeeKey].fltFeeTotalQuote | currency"></span></td>
                                        <td><span ng-bind="PPZP.mapQuotes[strFeeKey].fltFeeTotalDesc | percentage:2"></span></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--T7 tables-->
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="panel panel-default" ng-show="PP.mapQuotes['T7'].blnShow" style="overflow: scroll;">
                        <div class="panel-heading">
                            <a data-toggle="collapse" href="#T7PV"><h3 class="panel-title" >TARIFA T7</h3></a>
                        </div>
                        <div id="T7PV" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <div class="row" ng-show="PPT7Calc === 'byDelivery'">
                                    <table class="table table-striped">
                                        <thead class="thead-light">
                                        <tr>
                                            <th>Rango KM</th>
                                            <th>Tarifa llena</th>
                                            <th># Paquetes (Frecuencia)</th>
                                            <th>Tarifa propuesta</th>
                                            <th>TOTAL PROPUESTA</th>
                                            <th>Descuento</th>
                                            <th>Volumen de la tarima</th>
                                            <th>Peso de la Tarima</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td colspan="2">Replicar en todos los rangos</td>
                                            <td class="thead-light center"><input type="checkbox" ng-model="PP.mapQuotes['T7'].blnSameFrecuency" ng-click="replicate('Quantity', PP.mapQuotes['T7'].ranges['0-400'].intFrecuency, 'T7')"/></td>
                                            <td class="thead-light center"><input type="checkbox" ng-model="PP.mapQuotes['T7'].blnSameQuote" ng-click="replicate('Quote', PP.mapQuotes['T7'].ranges['0-400'].fltQuoteFee, 'T7')"/></td>
                                            <td></td>
                                            <td></td>
                                            <td class="thead-light center"><input type="checkbox" ng-model="PP.mapQuotes['T7'].blnSameVolAVR" ng-click="replicate('VolAVR', PP.mapQuotes['T7'].ranges['0-400'].fltVolAVR, 'T7')"/></td>
                                            <td class="thead-light center"><input type="checkbox" ng-model="PP.mapQuotes['T7'].blnSameWeigthAVR" ng-click="replicate('WeigthAVR', PP.mapQuotes['T7'].ranges['0-400'].fltWeightAVR, 'T7')"/></td>
                                        </tr>
                                        <tr ng-repeat="(keyRange, strRange) in PP.listRange">
                                            <td ng-bind="strRange"></td>
                                            <td ng-bind="PP.mapQuotes['T7'].ranges[keyRange].fltFullFee | currency"></td>
                                            <td class="thead-light center" contenteditable="true" ng-bind="PP.mapQuotes['T7'].ranges[keyRange].intFrecuency | number" ng-blur="setValue('PPintFrecuency', keyRange, $event, 'T7')"></td>
                                            <td class="thead-light center" contenteditable="true" ng-bind="PP.mapQuotes['T7'].ranges[keyRange].fltQuoteFee | currency" ng-blur="setValue('PPfltQuoteFee', keyRange, $event, 'T7')"></td>
                                            <td ng-bind="PP.mapQuotes['T7'].ranges[keyRange].fltTotalQuote | currency"></td>
                                            <td ng-bind="PP.mapQuotes['T7'].ranges[keyRange].fltDiscount | percentage:2"></td>
                                            <td class="thead-light center" contenteditable="true" ng-bind="PP.mapQuotes['T7'].ranges[keyRange].fltVolAVR | number" ng-blur="setValue('PPfltVolAVR', keyRange, $event, 'T7')"></td>
                                            <td class="thead-light center" contenteditable="true" ng-bind="PP.mapQuotes['T7'].ranges[keyRange].fltWeightAVR | number" ng-blur="setValue('PPfltWeightAVR', keyRange, $event, 'T7')"></td>
                                        </tr>
                                        <tr>
                                            <td>Total</td>
                                            <td></td>
                                            <td><span ng-bind="PP.mapQuotes['T7'].intFeeTotalFrec | number"></span></td>
                                            <td></td>
                                            <td><span ng-bind="PP.mapQuotes['T7'].fltFeeTotalQuote | currency"></span></td>
                                            <td><span ng-bind="PP.mapQuotes['T7'].fltTotalDisc | percentage:2"></span></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="row" ng-show="PPT7Calc === 'byDimension'">
                                    <div class="col-md-12 col-sm-12">
                                        <table class="table table-striped" >
                                            <thead class="thead-light">
                                            <tr>
                                                <th>Rango KM</th>
                                                <th>Tarifa llena</th>
                                                <th># Paquetes (Frecuencia)</th>
                                                <th>Tarifa propuesta m3</th>
                                                <th>TOTAL PROPUESTA</th>
                                                <th>Descuento</th>
                                                <th>Volumen (m3)</th>
                                                <th>Volumen promedio tarima</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                <td colspan="2">Replicar en todos los rangos</td>
                                                <td class="thead-light center"><input type="checkbox" ng-model="PP.mapQuotes['T7V'].blnSameFrecuency" ng-click="replicate('Quantity', PP.mapQuotes['T7'].ranges['0-400'].intFrecuency, 'T7V')"/></td>
                                                <td class="thead-light center"><input type="checkbox" ng-model="PP.mapQuotes['T7V'].blnSameQuote" ng-click="replicate('Quote', PP.mapQuotes['T7V'].ranges['0-400'].fltQuoteFee, 'T7V')"/></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td class="thead-light center"><input type="checkbox" ng-model="PP.mapQuotes['T7V'].blnSameVolAVR" ng-click="replicate('VolAVR', PP.mapQuotes['T7V'].ranges['0-400'].fltVolAVR, 'T7V')"/></td>
                                            </tr>
                                            <tr ng-repeat="(keyRange, strRange) in PP.listRange">
                                                <td ng-bind="strRange"></td>
                                                <td ng-bind="PP.mapQuotes['T7V'].ranges[keyRange].fltFullFee | currency"></td>
                                                <td class="thead-light center" contenteditable="true" ng-bind="PP.mapQuotes['T7V'].ranges[keyRange].intFrecuency | number" ng-blur="setValue('PPintFrecuency', keyRange, $event, 'T7V')"></td>
                                                <td class="thead-light center" contenteditable="true" ng-bind="PP.mapQuotes['T7V'].ranges[keyRange].fltQuoteFee | currency" ng-blur="setValue('PPfltQuoteFee', keyRange, $event, 'T7V')"></td>
                                                <td ng-bind="PP.mapQuotes['T7V'].ranges[keyRange].fltTotalQuote | currency"></td>
                                                <td ng-bind="PP.mapQuotes['T7V'].ranges[keyRange].fltDiscount | percentage:2"></td>
                                                <td ng-bind="PP.mapQuotes['T7V'].ranges[keyRange].fltVol | number" ></td>
                                                <td class="thead-light center" contenteditable="true" ng-bind="PP.mapQuotes['T7V'].ranges[keyRange].fltVolAVR | number" ng-blur="setValue('PPfltVolAVR', keyRange, $event, 'T7V')"></td>
                                            </tr>
                                            <tr>
                                                <td>Total</td>
                                                <td></td>
                                                <td><span class="center" ng-bind="PP.mapQuotes['T7V'].intFeeTotalFrec | number"></span></td>
                                                <td></td>
                                                <td><span ng-bind="PP.mapQuotes['T7V'].fltFeeTotalQuote | currency"></span></td>
                                                <td><span ng-bind="PP.mapQuotes['T7V'].fltTotalDisc | percentage:2"></span></td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                            </tbody>
                                        </table>

                                        <table class="table table-striped" >
                                            <thead class="thead-light">
                                            <tr>
                                                <th>Rango KM</th>
                                                <th>Tarifa llena</th>
                                                <th># Paquetes (Frecuencia)</th>
                                                <th>Tarifa propuesta Kg</th>
                                                <th>TOTAL PROPUESTA</th>
                                                <th>Descuento</th>
                                                <th>Peso (Kg)</th>
                                                <th>Peso promedio tarima</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                <td colspan="2">Replicar en todos los rangos</td>
                                                <td class="thead-light center"><input type="checkbox" ng-model="PP.mapQuotes['T7P'].blnSameFrecuency" ng-click="replicate('Quantity', PP.mapQuotes['T7P'].ranges['0-400'].intFrecuency, 'T7P')"/></td>
                                                <td class="thead-light center"><input type="checkbox" ng-model="PP.mapQuotes['T7P'].blnSameQuote" ng-click="replicate('Quote', PP.mapQuotes['T7P'].ranges['0-400'].fltQuoteFee, 'T7P')"/></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td class="thead-light center"><input type="checkbox" ng-model="PP.mapQuotes['T7P'].blnSameWeigthAVR" ng-click="replicate('WeigthAVR', PP.mapQuotes['T7P'].ranges['0-400'].fltWeightAVR, 'T7P')"/></td>
                                            </tr>
                                            <tr ng-repeat="(keyRange, strRange) in PP.listRange">
                                                <td ng-bind="strRange"></td>
                                                <td ng-bind="PP.mapQuotes['T7P'].ranges[keyRange].fltFullFee | currency"></td>
                                                <td class="thead-light center" contenteditable="true" ng-bind="PP.mapQuotes['T7P'].ranges[keyRange].intFrecuency | number" ng-blur="setValue('PPintFrecuency', keyRange, $event, 'T7P')"></td>
                                                <td class="thead-light center" contenteditable="true" ng-bind="PP.mapQuotes['T7P'].ranges[keyRange].fltQuoteFee | currency" ng-blur="setValue('PPfltQuoteFee', keyRange, $event, 'T7P')"></td>
                                                <td ng-bind="PP.mapQuotes['T7P'].ranges[keyRange].fltTotalQuote | currency"></td>
                                                <td ng-bind="PP.mapQuotes['T7P'].ranges[keyRange].fltDiscount | percentage:2"></td>
                                                <td ng-bind="PP.mapQuotes['T7P'].ranges[keyRange].fltWeight | number" ></td>
                                                <td class="thead-light center" contenteditable="true" ng-bind="PP.mapQuotes['T7P'].ranges[keyRange].fltWeightAVR | number" ng-blur="setValue('PPfltWeightAVR', keyRange, $event, 'T7P')"></td>
                                            </tr>
                                            <tr>
                                                <td>Total</td>
                                                <td></td>
                                                <td><span class="center" ng-bind="PP.mapQuotes['T7P'].intFeeTotalFrec | number"></span></td>
                                                <td></td>
                                                <td><span ng-bind="PP.mapQuotes['T7P'].fltFeeTotalQuote | currency"></span></td>
                                                <td><span ng-bind="PP.mapQuotes['T7P'].fltTotalDisc | percentage:2"></span></td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--SEG DS-->
            <div class="panel panel-default" ng-show="PPDS.blnShow">
                <div class="panel-heading">
                    <a data-toggle="collapse" href="#PP-DS"><h3 class="panel-title">FRECUENCIA DE ENVÍOS - DÍA SIGUIENTE (ONE'DAY)</h3></a>
                </div>
                <div id="PP-DS" class="panel-collapse collapse in">
                    <div class="panel-body" style="overflow: scroll;">
                        <table class="table table-striped">
                            <thead class="thead-light">
                            <tr>
                                <th>Rango de KM</th>
                                <th>Tarifa llena</th>
                                <th># Paquetes (Frecuencia)</th>
                                <th>Tarifa propuesta</th>
                                <th>Peso báscula</th>
                                <th>Largo (cm)</th>
                                <th>Ancho (cm)</th>
                                <th>Alto (cm)</th>
                                <th>Peso Volumétrico</th>
                                <th>TOTAL PROPUESTA</th>
                                <th>Descuento</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>Replicar en todos </td>
                                <td></td>
                                <td class="center"><input type="checkbox" class="center custom-control-input"  ng-model="PPDS.blnSameFrec" ng-click="replicate('intFrecc', null, null, 'DS')" /></td>
                                <td class="center"><input type="checkbox" class="center custom-control-input"  ng-model="PPDS.blnSameQuote" ng-click="replicate('fltQuote', null, null, 'DS')" /></td>
                                <td class="center"><input type="checkbox" class="center custom-control-input"  ng-model="PPDS.blnSameWeight" ng-click="replicate('fltWeight', null, null, 'DS')" /></td>
                                <td class="center"><input type="checkbox" class="center custom-control-input"  ng-model="PPDS.blnSameLarge" ng-click="replicate('fltLarge', null, null, 'DS')" /></td>
                                <td class="center"><input type="checkbox" class="center custom-control-input"  ng-model="PPDS.blnSameWidth" ng-click="replicate('fltWidth', null, null, 'DS')" /></td>
                                <td class="center"><input type="checkbox" class="center custom-control-input"  ng-model="PPDS.blnSameHigh" ng-click="replicate('fltHigh', null, null, 'DS')" /></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr ng-repeat="(keyRange, strRange) in PP.listRange">
                                <td ng-bind="strRange"></td>
                                <td class="center" ng-bind="PPDS.ranges[keyRange].fltFullFee | currency" ></td>
                                <td class="center thead-light" contenteditable="true" ng-bind="PPDS.ranges[keyRange].intFrecuency | number" ng-blur="setValue('intFrecc', keyRange, $event, null, 'DS')"></td>
                                <td class="center thead-light" contenteditable="true" ng-bind="PPDS.ranges[keyRange].fltQuoteFee | currency" ng-blur="setValue('fltQuote', keyRange, $event, null, 'DS')"></td>
                                <td class="center thead-light" contenteditable="true" ng-bind="PPDS.ranges[keyRange].fltWeight | number:2" ng-blur="setValue('fltWeight', keyRange, $event, null, 'DS')"></td>
                                <td class="center thead-light" contenteditable="true" ng-bind="PPDS.ranges[keyRange].fltLarge | number:2" ng-blur="setValue('fltLarge', keyRange, $event, null, 'DS')"></td>
                                <td class="center thead-light" contenteditable="true" ng-bind="PPDS.ranges[keyRange].fltWidth | number:2" ng-blur="setValue('fltWidth', keyRange, $event, null, 'DS')"></td>
                                <td class="center thead-light" contenteditable="true" ng-bind="PPDS.ranges[keyRange].fltHigh | number:2" ng-blur="setValue('fltHigh', keyRange, $event, null, 'DS')"></td>
                                <td class="center" ng-bind="PPDS.ranges[keyRange].fltVolWeight | number:2" ></td>
                                <td class="center" ng-bind="PPDS.ranges[keyRange].fltTotalQuote | currency" ></td>
                                <td class="center" ng-bind="PPDS.ranges[keyRange].fltDisc | percentage:2" ></td>
                            </tr>
                            <tr>
                                <td>Total </td>
                                <td/>
                                <td class="center" ng-bind="PPDS.intTotalQ | number:0" ></td>
                                <td/>
                                <td/>
                                <td/>
                                <td/>
                                <td/>
                                <td/>
                                <td class="center" ng-bind="PPDS.intTotalQuote | currency" ></td>
                                <td class="center" ng-bind="PPDS.intTotalDisc | percentage:2" ></td>
                            </tr>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!--SEG 2D-->
            <div class="panel panel-default" ng-show="PP2D.blnShow">
                <div class="panel-heading">
                    <a data-toggle="collapse" href="#PP-2D"><h3 class="panel-title">FRECUENCIA DE ENVÍOS - DOS DÍAS SIGUIENTES (2'DAYS)</h3></a>
                </div>
                <div id="PP-2D" class="panel-collapse collapse in">
                    <div class="panel-body" style="overflow: scroll;">
                        <table class="table table-striped">
                            <thead class="thead-light">
                            <tr>
                                <th>Rango de KM</th>
                                <th>Tarifa llena</th>
                                <th># Paquetes (Frecuencia)</th>
                                <th>Tarifa propuesta</th>
                                <th>Peso báscula</th>
                                <th>Largo (cm)</th>
                                <th>Ancho (cm)</th>
                                <th>Alto (cm)</th>
                                <th>Peso Volumétrico</th>
                                <th>TOTAL PROPUESTA</th>
                                <th>Descuento</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>Replicar en todos </td>
                                <td></td>
                                <td class="center"><input type="checkbox" class="center custom-control-input"  ng-model="PP2D.blnSameFrec" ng-click="replicate('intFrecc', null, null, '2D')" /></td>
                                <td class="center"><input type="checkbox" class="center custom-control-input"  ng-model="PP2D.blnSameQuote" ng-click="replicate('fltQuote', null, null, '2D')" /></td>
                                <td class="center"><input type="checkbox" class="center custom-control-input"  ng-model="PP2D.blnSameWeight" ng-click="replicate('fltWeight', null, null, '2D')" /></td>
                                <td class="center"><input type="checkbox" class="center custom-control-input"  ng-model="PP2D.blnSameLarge" ng-click="replicate('fltLarge', null, null, '2D')" /></td>
                                <td class="center"><input type="checkbox" class="center custom-control-input"  ng-model="PP2D.blnSameWidth" ng-click="replicate('fltWidth', null, null, '2D')" /></td>
                                <td class="center"><input type="checkbox" class="center custom-control-input"  ng-model="PP2D.blnSameHigh" ng-click="replicate('fltHigh', null, null, '2D')" /></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr ng-repeat="(keyRange, strRange) in PP.listRange">
                                <td ng-bind="strRange"></td>
                                <td class="center" ng-bind="PP2D.ranges[keyRange].fltFullFee | currency" ></td>
                                <td class="center thead-light" contenteditable="true" ng-bind="PP2D.ranges[keyRange].intFrecuency | number" ng-blur="setValue('intFrecc', keyRange, $event, null, '2D')"></td>
                                <td class="center thead-light" contenteditable="true" ng-bind="PP2D.ranges[keyRange].fltQuoteFee | currency" ng-blur="setValue('fltQuote', keyRange, $event, null, '2D')"></td>
                                <td class="center thead-light" contenteditable="true" ng-bind="PP2D.ranges[keyRange].fltWeight | number:2" ng-blur="setValue('fltWeight', keyRange, $event, null, '2D')"></td>
                                <td class="center thead-light" contenteditable="true" ng-bind="PP2D.ranges[keyRange].fltLarge | number:2" ng-blur="setValue('fltLarge', keyRange, $event, null, '2D')"></td>
                                <td class="center thead-light" contenteditable="true" ng-bind="PP2D.ranges[keyRange].fltWidth | number:2" ng-blur="setValue('fltWidth', keyRange, $event, null, '2D')"></td>
                                <td class="center thead-light" contenteditable="true" ng-bind="PP2D.ranges[keyRange].fltHigh | number:2" ng-blur="setValue('fltHigh', keyRange, $event, null, '2D')"></td>
                                <td class="center" ng-bind="PP2D.ranges[keyRange].fltVolWeight | number:2" ></td>
                                <td class="center" ng-bind="PP2D.ranges[keyRange].fltTotalQuote | currency" ></td>
                                <td class="center" ng-bind="PP2D.ranges[keyRange].fltDisc | percentage:2" ></td>
                            </tr>
                            <tr>
                                <td>Total </td>
                                <td/>
                                <td class="center" ng-bind="PP2D.intTotalQ | number:0" ></td>
                                <td/>
                                <td/>
                                <td/>
                                <td/>
                                <td/>
                                <td/>
                                <td class="center" ng-bind="PP2D.intTotalQuote | currency" ></td>
                                <td class="center" ng-bind="PP2D.intTotalDisc | percentage:2" ></td>
                            </tr>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!--SEG A12-->
            <div class="panel panel-default" ng-show="PPA12.blnShow">
                <div class="panel-heading">
                    <a data-toggle="collapse" href="#PP-A12"><h3 class="panel-title">FRECUENCIA DE ENVÍOS - ANTES DE LAS 12 (MID'DAY)</h3></a>
                </div>
                <div id="PP-A12" class="panel-collapse collapse in">
                    <div class="panel-body" style="overflow: scroll;">
                        <table class="table table-striped">
                            <thead class="thead-light">
                            <tr>
                                <th>Rango de KM</th>
                                <th>Tarifa llena</th>
                                <th># Paquetes (Frecuencia)</th>
                                <th>Tarifa propuesta</th>
                                <th>Peso báscula</th>
                                <th>Largo (cm)</th>
                                <th>Ancho (cm)</th>
                                <th>Alto (cm)</th>
                                <th>Peso Volumétrico</th>
                                <th>TOTAL PROPUESTA</th>
                                <th>Descuento</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>Replicar en todos </td>
                                <td></td>
                                <td class="center"><input type="checkbox" class="center custom-control-input"  ng-model="PPA12.blnSameFrec" ng-click="replicate('intFrecc', null, null, 'A12')" /></td>
                                <td class="center"><input type="checkbox" class="center custom-control-input"  ng-model="PPA12.blnSameQuote" ng-click="replicate('fltQuote', null, null, 'A12')" /></td>
                                <td class="center"><input type="checkbox" class="center custom-control-input"  ng-model="PPA12.blnSameWeight" ng-click="replicate('fltWeight', null, null, 'A12')" /></td>
                                <td class="center"><input type="checkbox" class="center custom-control-input"  ng-model="PPA12.blnSameLarge" ng-click="replicate('fltLarge', null, null, 'A12')" /></td>
                                <td class="center"><input type="checkbox" class="center custom-control-input"  ng-model="PPA12.blnSameWidth" ng-click="replicate('fltWidth', null, null, 'A12')" /></td>
                                <td class="center"><input type="checkbox" class="center custom-control-input"  ng-model="PPA12.blnSameHigh" ng-click="replicate('fltHigh', null, null, 'A12')" /></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr ng-repeat="(keyRange, strRange) in PP.listRange">
                                <td ng-bind="strRange"></td>
                                <td class="center" ng-bind="PPA12.ranges[keyRange].fltFullFee | currency" ></td>
                                <td class="center thead-light" contenteditable="true" ng-bind="PPA12.ranges[keyRange].intFrecuency | number" ng-blur="setValue('intFrecc', keyRange, $event, null, 'A12')"></td>
                                <td class="center thead-light" contenteditable="true" ng-bind="PPA12.ranges[keyRange].fltQuoteFee | currency" ng-blur="setValue('fltQuote', keyRange, $event, null, 'A12')"></td>
                                <td class="center thead-light" contenteditable="true" ng-bind="PPA12.ranges[keyRange].fltWeight | number:2" ng-blur="setValue('fltWeight', keyRange, $event, null, 'A12')"></td>
                                <td class="center thead-light" contenteditable="true" ng-bind="PPA12.ranges[keyRange].fltLarge | number:2" ng-blur="setValue('fltLarge', keyRange, $event, null, 'A12')"></td>
                                <td class="center thead-light" contenteditable="true" ng-bind="PPA12.ranges[keyRange].fltWidth | number:2" ng-blur="setValue('fltWidth', keyRange, $event, null, 'A12')"></td>
                                <td class="center thead-light" contenteditable="true" ng-bind="PPA12.ranges[keyRange].fltHigh | number:2" ng-blur="setValue('fltHigh', keyRange, $event, null, 'A12')"></td>
                                <td class="center" ng-bind="PPA12.ranges[keyRange].fltVolWeight | number:2" ></td>
                                <td class="center" ng-bind="PPA12.ranges[keyRange].fltTotalQuote | currency" ></td>
                                <td class="center" ng-bind="PPA12.ranges[keyRange].fltDisc | percentage:2" ></td>
                            </tr>
                            <tr>
                                <td>Total </td>
                                <td/>
                                <td class="center" ng-bind="PPA12.intTotalQ | number:0" ></td>
                                <td/>
                                <td/>
                                <td/>
                                <td/>
                                <td/>
                                <td/>
                                <td class="center" ng-bind="PPA12.intTotalQuote | currency" ></td>
                                <td class="center" ng-bind="PPA12.intTotalDisc | percentage:2" ></td>
                            </tr>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div ng-show="PPstep2">
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="panel panel-default" ng-repeat="(strFeeKey, fee) in PP.listFee" ng-show="PP.mapQuotes[strFeeKey].blnShow">
                        <div class="panel-heading">
                            <a data-toggle="collapse" href="#{{strFeeKey}}"><h3 class="panel-title" ng-bind="fee"></h3></a>
                        </div>
                        <div id="{{strFeeKey}}" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <table class="table table-striped">
                                    <thead class="thead-light">
                                    <tr>
                                        <th>Rango KM</th>
                                        <th>Flete</th>
                                        <th>RAD</th>
                                        <th>EAD</th>
                                        <th>Acuse</th>
                                        <th>Seguro</th>
                                        <th>T. Llena</th>
                                        <th>T. Prop</th>
                                        <th>#</th>
                                        <th>Total N</th>
                                        <th>Total P</th>
                                        <th>Desc. </th>
                                        <th ng-hide="strFeeKey==='T7'">Flete ZP</th>
                                        <th ng-hide="strFeeKey==='T7'"># ZP</th>
                                        <th ng-hide="strFeeKey==='T7'">EAD ZP</th>
                                        <th ng-hide="strFeeKey==='T7'">T.Llena ZP</th>
                                        <th ng-hide="strFeeKey==='T7'">T.Prop ZP</th>
                                        <th ng-hide="strFeeKey==='T7'">Total N ZP</th>
                                        <th ng-hide="strFeeKey==='T7'">Total P ZP</th>
                                        <th ng-hide="strFeeKey==='T7'">Desc. ZP</th>
                                        <th ng-show="strFeeKey==='T7'">Volumen de la tarima</th>
                                        <th ng-show="strFeeKey==='T7'">Precio por m3</th>
                                        <th ng-show="strFeeKey==='T7'">Peso de la Tarima</th>
                                        <th ng-show="strFeeKey==='T7'">Precio por kg</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr ng-repeat="(keyRange, strRange) in PP.listRange">
                                        <td class="thead-light" ng-bind="strRange"></td>
                                        <td ng-bind="PP.mapQuotes[strFeeKey].ranges[keyRange].fltAmount | currency"></td>
                                        <td ng-bind="PP.mapQuotes[strFeeKey].ranges[keyRange].fltRAD | currency" ></td>
                                        <td ng-bind="PP.mapQuotes[strFeeKey].ranges[keyRange].fltEAD | currency" ></td>
                                        <td ng-bind="PP.mapQuotes[strFeeKey].ranges[keyRange].fltACK | currency" ></td>
                                        <td ng-bind="PP.mapQuotes[strFeeKey].ranges[keyRange].fltAmountSeg | currency"></td>
                                        <td ng-bind="PP.mapQuotes[strFeeKey].ranges[keyRange].fltFullFee | currency"></td>
                                        <td ng-bind="PP.mapQuotes[strFeeKey].ranges[keyRange].fltQuoteFee | currency" ></td>
                                        <td ng-bind="PP.mapQuotes[strFeeKey].ranges[keyRange].intFrecuency | number" ></td>
                                        <td ng-bind="PP.mapQuotes[strFeeKey].ranges[keyRange].fltNormalFee | currency"></td>
                                        <td ng-bind="PP.mapQuotes[strFeeKey].ranges[keyRange].fltTotalQuote | currency"></td>
                                        <td ng-bind="PP.mapQuotes[strFeeKey].ranges[keyRange].fltDiscount | percentage:2"></td>
                                        <td ng-bind="PPZP.mapQuotes[strFeeKey].ranges[keyRange].fltAmount | currency" ng-hide="strFeeKey==='T7'"></td>
                                        <td ng-bind="PPZP.mapQuotes[strFeeKey].ranges[keyRange].fltEAD | currency"  ng-hide="strFeeKey==='T7'"></td>
                                        <td ng-bind="PPZP.mapQuotes[strFeeKey].ranges[keyRange].intFrecuency | number"  ng-hide="strFeeKey==='T7'"></td>
                                        <td ng-bind="PPZP.mapQuotes[strFeeKey].ranges[keyRange].fltFullFee | currency" ng-hide="strFeeKey==='T7'"></td>
                                        <td ng-bind="PPZP.mapQuotes[strFeeKey].ranges[keyRange].fltQuoteFee | currency"  ng-hide="strFeeKey==='T7'"></td>
                                        <td ng-bind="PPZP.mapQuotes[strFeeKey].ranges[keyRange].fltNormalFee | currency" ng-hide="strFeeKey==='T7'"></td>
                                        <td ng-bind="PPZP.mapQuotes[strFeeKey].ranges[keyRange].fltTotalQuote | currency" ng-hide="strFeeKey==='T7'"></td>
                                        <td ng-bind="PPZP.mapQuotes[strFeeKey].ranges[keyRange].fltDiscount | percentage:2" ng-hide="strFeeKey==='T7'"></td>
                                        <td ng-bind="PP.mapQuotes[strFeeKey].ranges[keyRange].fltVolAVR | number" ng-show="strFeeKey==='T7'" ></td>
                                        <td ng-bind="wrapper.mapTarifarioT['TARIFA T7V'][strRange].Flete__c | currency" ng-show="strFeeKey==='T7'"></td>
                                        <td ng-bind="PP.mapQuotes[strFeeKey].ranges[keyRange].fltWeightAVR | number" ng-show="strFeeKey==='T7'" ></td>
                                        <td ng-bind="wrapper.mapTarifarioT['TARIFA T7P'][strRange].Flete__c | currency" ng-show="strFeeKey==='T7'"></td>
                                    </tr>
                                    <tr>
                                        <td>Total</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td><span class="center" ng-bind="PP.mapQuotes[strFeeKey].intFeeTotalFrec | number"></span></td>
                                        <td><span ng-bind="PP.mapQuotes[strFeeKey].fltFeeTotalNormal | number"></span></td>
                                        <td><span ng-bind="PP.mapQuotes[strFeeKey].fltFeeTotalQuote | currency"></span></td>
                                        <td><span ng-bind="PP.mapQuotes[strFeeKey].fltTotalDisc | percentage:2"></span></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>Total</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td><span class="center" ng-bind="PPZP.mapQuotes[strFeeKey].intFeeTotalFrec | number"></span></td>
                                        <td><span ng-bind="PPZP.mapQuotes[strFeeKey].fltFeeTotalNormal | number"></span></td>
                                        <td><span ng-bind="PPZP.mapQuotes[strFeeKey].fltFeeTotalQuote | currency"></span></td>
                                        <td><span ng-bind="PPZP.mapQuotes[strFeeKey].fltTotalDisc | percentage:2"></span></td>
                                        <td></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default" ng-show="PP.mapQuotes['T7'].blnShow">
                        <div class="panel-heading">
                            <a data-toggle="collapse" href="#{{strFeeKey}}"><h3 class="panel-title" ng-bind="fee"></h3></a>
                        </div>
                        <div id="{{strFeeKey}}" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <table class="table table-striped">
                                    <thead class="thead-light">
                                    <tr>
                                        <th>Rango KM</th>
                                        <th>Flete</th>
                                        <th>RAD</th>
                                        <th>EAD</th>
                                        <th>Acuse</th>
                                        <th>Seguro</th>
                                        <th>Tarifa llena</th>
                                        <th>Tarifa propuesta</th>
                                        <th># Paquetes (Frecuencia)</th>
                                        <th>TOTAL NORMAL</th>
                                        <th>TOTAL PROPUESTA</th>
                                        <th>Descuento</th>
                                        <th>Valor declarado</th>
                                        <th>Volumen promedio</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr ng-repeat="(keyRange, strRange) in PP.listRange">
                                        <td class="thead-light" ng-bind="strRange"></td>
                                        <td ng-bind="PP.mapQuotes['T7V'].ranges[keyRange].fltAmount | currency"></td>
                                        <td ng-bind="PP.mapQuotes['T7V'].ranges[keyRange].fltRAD | currency" ></td>
                                        <td ng-bind="PP.mapQuotes['T7V'].ranges[keyRange].fltEAD | currency" ></td>
                                        <td ng-bind="PP.mapQuotes['T7V'].ranges[keyRange].fltACK | currency" ></td>
                                        <td ng-bind="PP.mapQuotes['T7V'].ranges[keyRange].fltAmountSeg | currency"></td>
                                        <td ng-bind="PP.mapQuotes['T7V'].ranges[keyRange].fltFullFee | currency"></td>
                                        <td ng-bind="PP.mapQuotes['T7V'].ranges[keyRange].fltQuoteFee | currency" ></td>
                                        <td ng-bind="PP.mapQuotes['T7V'].ranges[keyRange].intFrecuency | number" ></td>
                                        <td ng-bind="PP.mapQuotes['T7V'].ranges[keyRange].fltNormalFee | currency"></td>
                                        <td ng-bind="PP.mapQuotes['T7V'].ranges[keyRange].fltTotalQuote | currency"></td>
                                        <td ng-bind="PP.mapQuotes['T7V'].ranges[keyRange].fltDiscount | percentage:2"></td>
                                        <td ng-bind="PP.fltSEG | currency" ></td>
                                        <td ng-bind="PP.mapQuotes['T7V'].ranges[keyRange].fltVolAVR | number"></td>
                                    </tr>
                                    <tr>
                                        <td>Total</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td><span ng-bind="PP.mapQuotes['T7V'].intFeeTotalFrec | number"></span></td>
                                        <td><span ng-bind="PP.mapQuotes['T7V'].fltFeeTotalNormal | number"></span></td>
                                        <td><span ng-bind="PP.mapQuotes['T7V'].fltFeeTotalQuote | currency"></span></td>
                                        <td><span ng-bind="PP.mapQuotes['T7V'].fltTotalDisc | percentage:2"></span></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default" ng-show="PP.mapQuotes['T7'].blnShow">
                        <div class="panel-heading">
                            <a data-toggle="collapse" href="#{{strFeeKey}}"><h3 class="panel-title" ng-bind="fee"></h3></a>
                        </div>
                        <div id="{{strFeeKey}}" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <table class="table table-striped">
                                    <thead class="thead-light">
                                    <tr>
                                        <th>Rango KM</th>
                                        <th>Flete</th>
                                        <th>RAD</th>
                                        <th>EAD</th>
                                        <th>Acuse</th>
                                        <th>Seguro</th>
                                        <th>Tarifa llena</th>
                                        <th>Tarifa propuesta</th>
                                        <th># Paquetes (Frecuencia)</th>
                                        <th>TOTAL NORMAL</th>
                                        <th>TOTAL PROPUESTA</th>
                                        <th>Descuento</th>
                                        <th>Valor declarado</th>
                                        <th >Peso promedio</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr ng-repeat="(keyRange, strRange) in PP.listRange">
                                        <td class="thead-light" ng-bind="strRange"></td>
                                        <td ng-bind="PP.mapQuotes['T7P'].ranges[keyRange].fltAmount | currency"></td>
                                        <td ng-bind="PP.mapQuotes['T7P'].ranges[keyRange].fltRAD | currency" ></td>
                                        <td ng-bind="PP.mapQuotes['T7P'].ranges[keyRange].fltEAD | currency" ></td>
                                        <td ng-bind="PP.mapQuotes['T7P'].ranges[keyRange].fltACK | currency" ></td>
                                        <td ng-bind="PP.mapQuotes['T7P'].ranges[keyRange].fltAmountSeg | currency"></td>
                                        <td ng-bind="PP.mapQuotes['T7P'].ranges[keyRange].fltFullFee | currency"></td>
                                        <td ng-bind="PP.mapQuotes['T7P'].ranges[keyRange].fltQuoteFee | currency" ></td>
                                        <td ng-bind="PP.mapQuotes['T7P'].ranges[keyRange].intFrecuency | number" ></td>
                                        <td ng-bind="PP.mapQuotes['T7P'].ranges[keyRange].fltNormalFee | currency"></td>
                                        <td ng-bind="PP.mapQuotes['T7P'].ranges[keyRange].fltTotalQuote | currency"></td>
                                        <td ng-bind="PP.mapQuotes['T7P'].ranges[keyRange].fltDiscount | percentage:2"></td>
                                        <td ng-bind="PP.fltSEG | currency" ></td>
                                        <td ng-bind="PP.mapQuotes['T7P'].ranges[keyRange].fltWeightAVR | number"></td>
                                    </tr>
                                    <tr>
                                        <td>Total</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td><span ng-bind="PP.mapQuotes['T7P'].intFeeTotalFrec | number"></span></td>
                                        <td><span ng-bind="PP.mapQuotes['T7P'].fltFeeTotalNormal | number"></span></td>
                                        <td><span ng-bind="PP.mapQuotes['T7P'].fltFeeTotalQuote | currency"></span></td>
                                        <td><span ng-bind="PP.mapQuotes['T7P'].fltTotalDisc | percentage:2"></span></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--buttons-->
        <div class="row right">
            <div class="btn-group ">
                <button type="button" class="btn btn-default" ng-click="exit()">
                    <span class="glyphicon glyphicon-menu-left"></span> Salir
                </button>
                <button type="button" class="btn btn-primary" ng-show="hasRecord()" data-toggle="modal" data-target="#ModalApproval">
                    Enviar a Autorización <span class="glyphicon glyphicon-check"></span>
                </button>
                <button type="button" class="btn btn-primary" ng-click="createQuotesPP()" ng-show="PP.blnBotonActivo">
                    Guardar <span class="glyphicon glyphicon-floppy-disk"></span>
                </button>
                <button type="button" class="btn btn-default" ng-click="backPP()" ng-show="PPstep2 && isAdmin()">
                    <span class="glyphicon glyphicon-menu-left"></span> Atras
                </button>
                <button type="button" class="btn btn-primary" ng-click="nextPP()" ng-show="PPstep1 && isAdmin()">
                    Siguiente <span class="glyphicon glyphicon-menu-right"></span>
                </button>
            </div>
        </div>
        <!--mensagges-->
        <div class="row center">
            <div class="col-sm-12 col-md-12">
                <!--<div class="alert alert-danger" role="alert" ng-show="!dml.blnSuccess && sent">
                    <strong>Error:</strong>
                    Se ha producido un error, contacte a su administrador: <span ng-bind="errorMessage"></span>
                    <span class="glyphicon glyphicon-alert"></span>
                </div>-->
                <div class="alert alert-danger" role="alert" ng-repeat="(i, errorMessage) in DML.listErrors">
                    <span ng-bind="errorMessage"></span>
                </div>
                <div class="alert alert-success" role="alert" ng-show="DML.blnSuccess && sent" >
                    <span ng-bind="SuccessMessage"></span>  <span ng-show="Wrapper.objQuote.Id"> Ver: <a href="/{{Wrapper.objQuote.Id}}">{{ Wrapper.objQuote.Name }}</a> </span>
                </div>
            </div>
        </div>
        <!--modal tarfas-->
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <div class="modal fade" id="ModalFee" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog big-modal" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Agregar Tarifas</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="bootstrap snippet">
                                    <div class="row">
                                        <div class="col-sm-4 col-sm-offset-1">
                                            <div class="list-group" id="list1">
                                                <a href="#" class="list-group-item active">Tarifas Disponibles <input title="toggle all" type="checkbox" class="all pull-right" ng-model="PP.blnFeeAddAll" ng-click="addAll('fee', 'add')"/></a>
                                                <a href="#" class="list-group-item" ng-repeat="(i, fee) in PP.FeeSelect.available" ng-click="clickFee(i, 'feeAdd')">
                                                    <span ng-bind="fee.label"></span>
                                                    <span class="glyphicon glyphicon-ok" ng-show="fee.blnSelected"/>
                                                </a>
                                            </div>
                                        </div>
                                        <div class="col-md-2 v-center">
                                            <button title="Send to list 2" class="btn btn-default center-block add" ng-click="updateFees('add', 'fee')"><i class="glyphicon glyphicon-chevron-right" ></i></button>
                                            <button title="Send to list 1" class="btn btn-default center-block remove" ng-click="updateFees('remove', 'fee')"><i class="glyphicon glyphicon-chevron-left" ></i></button>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="list-group" id="list2">
                                                <a href="#" class="list-group-item active">Tarifas Seleccionadas <input title="toggle all" type="checkbox" class="all pull-right" ng-model="PP.blnFeeRemoveAll" ng-click="addAll('fee', 'remove')"/></a>
                                                <a href="#" class="list-group-item" ng-repeat="(i, fee) in PP.FeeSelect.selected" ng-click="clickFee(i, 'feeRemove')">
                                                    <span ng-bind="fee.label"></span>
                                                    <span class="glyphicon glyphicon-remove" ng-show="fee.blnSelected"/>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="center" ng-show="PP.mapQuotes['T7'].blnShow">
                                    <div class="alert alert-info" role="alert">
                                        Se ha seleccionado la Tarifa T7, debes elegir la modalidad de calculo.
                                    </div>
                                </div>
                                <div ng-show="PP.mapQuotes['T7'].blnShow">
                                    <div class="row custom-control custom-radio">
                                        <div class="col-sm-1 col-md-1" />
                                        <div class="col-sm-3 col-md-3"><label class="custom-control-label" >Por tarima</label></div>
                                        <div class="col-sm-3 col-md-3"><input type="radio" class="custom-control-input" ng-model="PPT7Calc" value="byDelivery" /></div>
                                    </div>
                                    <div class="row custom-control custom-radio">
                                        <div class="col-sm-1 col-md-1" />
                                        <div class="col-sm-3 col-md-3"><label class="custom-control-label" >Por Kg / m3</label></div>
                                        <div class="col-sm-3 col-md-3"><input type="radio" class="custom-control-input" ng-model="PPT7Calc" value="byDimension" /></div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" data-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--modal servicios-->
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <div class="modal fade" id="ModalServices" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog big-modal" role="document">
                        <div class="modal-content big-modal">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Agregar Servicios</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="bootstrap snippet">
                                    <div class="row">
                                        <div class="col-sm-4 col-sm-offset-1">
                                            <div class="list-group" id="list3">
                                                <a href="#" class="list-group-item active">Servicios Disponibles<input title="toggle all" type="checkbox" class="all pull-right" ng-model="PP.blnServiceAddAll" ng-click="addAll('service', 'add')"/></a>
                                                <a href="#" class="list-group-item" ng-repeat="(i, service) in PP.ServiceSelect.available" ng-click="clickFee(i, 'serviceAdd')">
                                                    <span ng-bind="service.label"></span>
                                                    <span class="glyphicon glyphicon-ok" ng-show="service.blnSelected"/>
                                                </a>
                                            </div>
                                        </div>
                                        <div class="col-md-2 v-center">
                                            <button title="Send to list 2" class="btn btn-default center-block add" ng-click="updateFees('add', 'service')"><i class="glyphicon glyphicon-chevron-right"></i></button>
                                            <button title="Send to list 1" class="btn btn-default center-block remove" ng-click="updateFees('remove', 'service')"><i class="glyphicon glyphicon-chevron-left"></i></button>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="list-group" id="list4">
                                                <a href="#" class="list-group-item active">Servicios Seleccionados <input title="toggle all" type="checkbox" class="all pull-right" ng-model="PP.blnServiceRemoveAll" ng-click="addAll('service', 'remove')"/></a>
                                                <a href="#" class="list-group-item" ng-repeat="(i, service) in PP.ServiceSelect.selected" ng-click="clickFee(i, 'serviceRemove')">
                                                    <span ng-bind="service.label"></span>
                                                    <span class="glyphicon glyphicon-remove" ng-show="service.blnSelected"/>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row custom-control custom-radio" ng-show="PP.blnACK">
                                    <div class="col-sm-1 col-md-1" />
                                    <div class="col-sm-3 col-md-3"><label class="custom-control-label" >Acuse a Empresa</label></div>
                                    <div class="col-sm-3 col-md-3"><input type="radio" class="custom-control-input" ng-model="PP.strAck" value="Empresa" ng-click="calculateEXP();"/></div>
                                </div>
                                <div class="row custom-control custom-radio" ng-show="PP.blnACK">
                                    <div class="col-sm-1 col-md-1" />
                                    <div class="col-sm-3 col-md-3"><label class="custom-control-label" >Acuse a Interno</label></div>
                                    <div class="col-sm-3 col-md-3"><input type="radio" class="custom-control-input" ng-model="PP.strAck" value="Interno" ng-click="calculateEXP();"/></div>
                                </div>
                                <div class="row custom-control custom-radio" ng-show="PP.blnACK">
                                    <div class="col-sm-1 col-md-1" />
                                    <div class="col-sm-3 col-md-3"><label class="custom-control-label" >Acuse a XT</label></div>
                                    <div class="col-sm-3 col-md-3"><input type="radio" class="custom-control-input" ng-model="PP.strAck" value="XT" ng-click="calculateEXP();"/></div>
                                </div>
                                <div class="row custom-control custom-radio" ng-show="PP.blnSEG">
                                    <div class="col-sm-1 col-md-1" />
                                    <div class="col-sm-3 col-md-3"><label class="custom-control-label" >Monto asegurado</label></div>
                                    <div class="col-sm-3 col-md-3"><input type="number" class="custom-control-input rouded-med" ng-model="PP.fltSEG" ng-change="calculateEXP();"/></div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" data-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--modal descuentos-->
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <div class="modal fade" id="ModalQuickDisc" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog big-modal" role="document">
                        <div class="modal-content big-modal">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Agregar Descuentos Rápidos</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="row custom-control custom-radio">

                                    <div class="col-sm-3 col-md-3"><label class="custom-control-label" >Descuento general rápido</label></div>
                                    <div class="col-sm-3 col-md-3"><input type="number" class="custom-control-input rouded" ng-model="PP.fltGENDisc" ng-change="quickDisc('GENDISC')"/></div>

                                    <div class="col-sm-3 col-md-3"><label class="custom-control-label" >Costo flat general</label></div>
                                    <div class="col-sm-3 col-md-3"><input type="number" class="custom-control-input rouded" ng-model="PP.fltGENCost" ng-change="quickDisc('GENCOST')"/></div>
                                </div>
                                <br/><br/>
                                <div class="row custom-control custom-radio">
                                    <div class="col-md-6 col-sm-6 "><label class="custom-control-label" >Costo flat Tarifa</label></div>
                                    <div class="col-md-6 col-sm-6 "><label class="custom-control-label" >Costo flat Rango KM</label></div>
                                </div>
                                <div class="row custom-control custom-radio">
                                    <div class="col-md-6 col-sm-6">
                                        <div class="row"  ng-repeat="(idFee, labelFee) in PP.listFee" ng-show="PP.mapQuotes[idFee].blnShow">
                                            <div class="col-md-3 col-sm-3" />
                                            <div class="col-md-3 col-sm-3"><label class="custom-control-label" ng-bind="labelFee"></label></div>
                                            <div class="col-md-3 col-sm-3"><input type="number" class="custom-control-input rouded-med" ng-model="PP.mapQuotes[idFee].fltCost" ng-change="quickDisc('FEECOST')"/></div>
                                        </div>
                                        <div class="row" ng-show="isSelected('DS')">
                                            <div class="col-md-3 col-sm-3" />
                                            <div class="col-md-3 col-sm-3"><label class="custom-control-label" >ONE DAY</label></div>
                                            <div class="col-md-3 col-sm-3"><input type="number" class="custom-control-input rouded-med" ng-model="PP.mapQuotes['DS'].fltCost" ng-change="quickDisc('FEECOST')"/></div>
                                        </div>
                                        <div class="row" ng-show="isSelected('2D')">
                                            <div class="col-md-3 col-sm-3" />
                                            <div class="col-md-3 col-sm-3"><label class="custom-control-label" >TWO DAY</label></div>
                                            <div class="col-md-3 col-sm-3"><input type="number" class="custom-control-input rouded-med" ng-model="PP.mapQuotes['2D'].fltCost" ng-change="quickDisc('FEECOST')"/></div>
                                        </div>
                                        <div class="row" ng-show="isSelected('A12')">
                                            <div class="col-md-3 col-sm-3" />
                                            <div class="col-md-3 col-sm-3"><label class="custom-control-label" >MID DAY</label></div>
                                            <div class="col-md-3 col-sm-3"><input type="number" class="custom-control-input rouded-med" ng-model="PP.mapQuotes['A12'].fltCost" ng-change="quickDisc('FEECOST')"/></div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-sm-6">
                                        <div class="row" ng-repeat="(idRange, labelRange) in PP.listRange">
                                            <div class="col-md-3 col-sm-3" />
                                            <div class="col-md-3 col-sm-3"><label class="custom-control-label" ng-bind="labelRange" ></label></div>
                                            <div class="col-md-3 col-sm-3"><input type="number" class="custom-control-input rouded-med" ng-model="PP.mapRanges[idRange].fltCost" ng-change="quickDisc('RANGECOST')"/></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" data-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--modal approval-->
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <div class="modal fade" id="ModalApproval" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Enviar a Aprobación</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label for="exampleFormControlTextarea1">Agregar comentarios</label>
                                    <textarea class="form-control" rows="3" ng-model="PP.strApprovalComment"></textarea>
                                </div>
                                <div class="row center">
                                    <div class="col-sm-12 col-md-12">
                                        <!--<div class="alert alert-danger" role="alert" ng-show="!dml.blnSuccess && sent">
                                            <strong>Error:</strong>
                                            Se ha producido un error, contacte a su administrador: <span ng-bind="errorMessage"></span>
                                            <span class="glyphicon glyphicon-alert"></span>
                                        </div>-->
                                        <div class="alert alert-danger" role="alert" ng-repeat="(i, errorMessage) in DML.listErrors">
                                            <span ng-bind="errorMessage"></span>
                                        </div>
                                        <div class="alert alert-success" role="alert" ng-show="DML.blnSuccess && sent" >
                                            <span ng-bind="SuccessMessage"></span>  <span ng-show="Wrapper.objQuote.Id"> Ver: <a href="/{{Wrapper.objQuote.Id}}">{{ Wrapper.objQuote.Name }}</a> </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" ng-click="sumbit()" ng-show="hasRecord()">
                                    Enviar a Autorización <span class="glyphicon glyphicon-check"></span>
                                </button>
                                <button type="button" class="btn btn-primary" data-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript" lang="js">
        var j$ = jQuery.noConflict();
        //j$.blockUI({ message: '<h3><span class="glyphicon glyphicon-time"></span> Por favor espere... </h3>' });
        j$(document).ready(function(){
            //console.clear();
            j$('.container-fluid').show();
        });
        (function(){
            // angujar module
            var app = angular.module('Cotizador');
            // main controller
            /*
            * Angular module controllers
            * Begin Angular Controller
            */
            app.controller('PPGController', ['$scope',function($scope) {

                /*
                * Controller variables
                */
                $scope.Managers = [];
                $scope.PP = {
                    strAck : ''
                    , strApprovalComment : ''
                    , blnEAD: false
                    , blnBotonActivo : true
                    , blnRAD :false
                    , blnSEG : false
                    , blnMAN : false
                    , blnEDD : false
                    , blnEDC : false
                    , blnCRF : false
                    , blnZP : false
                    , fltSEG : 0
                    , fltAmountSEG : 0
                    , blnFeeAddAll : false
                    , blnServiceAddAll :false
                    , blnFeeRemoveAll : false
                    , blnServiceRemoveAll :false
                    , listFee : {
                        'TS': 'TARIFA SOBRE'
                        , 'T0': 'TARIFA T0'
                        , 'T1': 'TARIFA T1'
                        , 'T2': 'TARIFA T2'
                        , 'T3': 'TARIFA T3'
                        , 'T4': 'TARIFA T4'
                        , 'T5': 'TARIFA T5'
                        , 'T6': 'TARIFA T6'
                        , 'T7': 'TARIFA T7'

                    }
                    , listRange : {
                        '0-400': '0-400'
                        , '401-800': '401-800'
                        , '801-1200': '801-1200'
                        , '1201-1600': '1201-1600'
                        , '1601-2000': '1601-2000'
                        , '2001-2400': '2001-2400'
                        , '+2400' :'Más de 2400'
                    }
                    , mapQuotes:{
                        'DS' : {
                            fltCost :0
                        }
                        , '2D' : {
                            fltCost :0
                        }
                        , 'A12' : {
                            fltCost :0
                        }
                    }
                    , mapTotal:{


                    }
                    , FeeSelect : {
                        available : [
                            {id:'TS' , label :'TARIFA SOBRE', blnSelected : false , order : 0}
                            , {id:'T0' , label :'TARIFA T0', blnSelected : false , order : 1}
                            , {id:'T1' , label :'TARIFA T1', blnSelected : false , order : 2}
                            , {id:'T2' , label :'TARIFA T2', blnSelected : false , order : 3}
                            , {id:'T3' , label :'TARIFA T3', blnSelected : false , order : 4}
                            , {id:'T4' , label :'TARIFA T4', blnSelected : false , order : 5}
                            , {id:'T5' , label :'TARIFA T5', blnSelected : false , order : 6}
                            , {id:'T6' , label :'TARIFA T6', blnSelected : false , order : 7}
                            , {id:'T7', label : 'TARIFA T7', blnSelected : false , order : 8}
                            , {id:'DS', label : 'ONE\' DAY', blnSelected : false , order : 9}
                            , {id:'2D', label : 'TWO\' DAYS', blnSelected : false , order : 10}
                            , {id:'A12', label : 'MID\' DAY', blnSelected : false , order : 11}
                        ]
                        , selected : [

                        ]
                    }
                    , ServiceSelect : {
                        available : [
                            {id:'RAD' , label : 'Recolección a domicilio', blnSelected : false }
                            , {id:'EAD' , label : 'Entrega a domicilio', blnSelected : false }
                            , {id:'SEG' , label : 'Seguro', blnSelected : false }
                            , {id:'ACK' , label : 'Acuse', blnSelected : false }
                        ]
                        , selected : []
                    }
                    , TOTAL : []
                    , fltGENDisc : 0
                    , fltGENCost : 0
                };
                $scope.PPDS = {
                     ranges : {}
                    , blnSameWeight : false
                    , blnSameLarge : false
                    , blnSameWidth : false
                    , blnSameHigh : false
                    , blnShow : false
                    , blnSameFrec : false
                    , blnSameQuote : false
                    , intTotalQ :0
                    , intTotalFull: 0
                    , intTotalQuote : 0
                    , intTotalDisc : 0
                    , fltSegAmount : 0
                };
                $scope.PP2D = {
                     ranges : {}
                    , blnSameWeight : false
                    , blnSameLarge : false
                    , blnSameWidth : false
                    , blnSameHigh : false
                    , blnShow : false
                    , blnSameFrec : false
                    , blnSameQuote : false
                    , intTotalQ : 0
                    , intTotalFull : 0
                    , intTotalDisc : 0
                    , intTotalQuote : 0
                    , fltSegAmount : 0
                };
                $scope.PPA12 = {
                    ranges : {}
                    , blnSameWeight : false
                    , blnSameLarge : false
                    , blnSameWidth : false
                    , blnSameHigh : false
                    , blnShow : false
                    , blnSameFrec : false
                    , blnSameQuote : false
                    , intTotalQ : 0
                    , intTotalFull : 0
                    , intTotalDisc : 0
                    , intTotalQuote : 0
                    , fltSegAmount : 0
                };
                $scope.PP.mapQuotes['T7P'] = {
                    ranges : []
                    , intFeeTotalQ : 0
                    , fltFeeTotalFrec:0
                    , blnShow: false
                    , blnSameFrecuency : false
                    , blnSameQuote : false
                    , blnSameWeigthAVR: false
                };
                $scope.PP.mapQuotes['T7V'] = {
                    ranges : []
                    , intFeeTotalQ : 0
                    , fltFeeTotalFrec:0
                    , blnShow: false
                    , blnSameFrecuency : false
                    , blnSameQuote : false
                    , blnSameWeigthAVR: false
                };
                $scope.PP.TOTAL['NORMAL'] = 0;
                $scope.PP.TOTAL['PROPUESTA'] = 0;
                $scope.PP.TOTAL['DESCUENTO'] = 0;
                $scope.PP.TOTAL['PAQUETES'] = 0;
                $scope.PP.TOTAL['SEGURO'] = 0;
                $scope.PPZP = {
                    strAck : ''
                    , blnEAD: false
                    , blnRAD :false
                    , blnSEG : false
                    , fltSEG : 0
                    , fltAmountSEG : 0
                    , blnFeeAddAll : false
                    , blnServiceAddAll :false
                    , blnFeeRemoveAll : false
                    , blnServiceRemoveAll :false
                    , listFee : {
                        'TS': 'TARIFA SOBRE'
                        , 'T0': 'TARIFA T0'
                        , 'T1': 'TARIFA T1'
                        , 'T2': 'TARIFA T2'
                        , 'T3': 'TARIFA T3'
                        , 'T4': 'TARIFA T4'
                        , 'T5': 'TARIFA T5'
                        , 'T6': 'TARIFA T6'
                    }
                    , listRange : {
                        '0-400': '0-400'
                        , '401-800': '401-800'
                        , '801-1200': '801-1200'
                        , '1201-1600': '1201-1600'
                        , '1601-2000': '1601-2000'
                        , '2001-2400': '2001-2400'
                        , '+2400' :'Más de 2400'
                    }
                    , mapQuotes:{

                    }
                    , mapTotal:{


                    }

                };
                $scope.PPstep1 = true;
                $scope.PPstep2 = false;
                $scope.Sent = false;
                $scope.SPW = false;
                $scope.StrSTDCotiType = '';
                $scope.SuccessMessage = '';
                $scope.PP.mapRanges = {};
                $scope.PP.FeeSelect.available.sort(function (a, b) {
                    if (a.order > b.order) {
                        return 1;
                    }
                    if (a.order < b.order) {
                        return -1;
                    }
                    // a must be equal to b
                    return 0;
                });
                $scope.PP.FeeSelect.selected.sort(function (a, b) {
                    if (a.order > b.order) {
                        return 1;
                    }
                    if (a.order < b.order) {
                        return -1;
                    }
                    // a must be equal to b
                    return 0;
                });
                j$.each(
                        $scope.PP.listFee,
                        function(keyFee, fee){
                            $scope.PP.mapQuotes[keyFee] = {
                                ranges : []
                                , intFeeTotalFrec : 0
                                , fltFeeTotalDesc : 0
                                , fltFeeTotalNormal : 0
                                , fltFeeTotalQuote : 0
                                , blnShow : false
                                , fltFeeTotalSEG : 0
                                , blnSameFrecuency : false
                                , blnSameQuote : false
                                , fltCost : 0
                            };
                            j$.each(
                                    $scope.PP.listRange,
                                    function(keyRange, strRange){
                                        $scope.PP.mapQuotes[keyFee].ranges[keyRange] = {
                                            fltSeg : 0
                                            , fltFullFee : 0
                                            , fltNormalFee : 0
                                            , fltTotalQuote : 0
                                            , fltDiscount : 0
                                            , intFrecuency : 0
                                            , fltQuoteFee : 0
                                            , fltAmountSeg : 0
                                            , fltEAD: 0
                                            , fltEADZP: 0
                                            , fltRAD : 0
                                            , fltAmount : 0
                                            , fltACK : 0
                                            , fltMAN : 0
                                            , fltEDC : 0
                                            , fltEDD : 0
                                            , fltCRF : 0
                                        };
                                    }
                            );
                        }
                );
                j$.each(
                        $scope.PPZP.listFee,
                        function(keyFee, fee){
                            $scope.PPZP.mapQuotes[keyFee] = {
                                ranges : []
                                , intFeeTotalFrec : 0
                                , fltFeeTotalDesc : 0
                                , fltFeeTotalNormal : 0
                                , fltFeeTotalQuote : 0
                                , fltFeeTotalSEG : 0
                                , blnSameFrecuency : false
                                , blnSameQuote : false
                                , fltCost : 0
                            };
                            j$.each(
                                    $scope.PPZP.listRange,
                                    function(keyRange, strRange){
                                        $scope.PPZP.mapQuotes[keyFee].ranges[keyRange] = {
                                            fltSeg : 0
                                            , fltFullFee : 0
                                            , fltNormalFee : 0
                                            , fltTotalQuote : 0
                                            , fltDiscount : 0
                                            , intFrecuency : 0
                                            , fltQuoteFee : 0
                                            , fltAmountSeg : 0
                                            , fltEAD: 0
                                            , fltEADZP: 0
                                            , fltRAD : 0
                                            , fltAmount : 0
                                            , fltACK : 0
                                            , fltMAN : 0
                                            , fltEDC : 0
                                            , fltEDD : 0
                                            , fltCRF : 0

                                        };
                                    }
                            );
                        }
                );
                j$.each(
                        $scope.PP.listRange,
                        function(keyRange, strRange){
                            $scope.PP.mapQuotes['T7'].ranges[keyRange].fltVolAVR = 0;
                            $scope.PP.mapQuotes['T7'].ranges[keyRange].fltWeightAVR = 0;
                            $scope.PP.mapQuotes['T7P'].ranges[keyRange] = {
                                fltSeg : 0
                                , fltFullFee : 0
                                , fltNormalFee : 0
                                , fltTotalQuote : 0
                                , fltDiscount : 0
                                , intFrecuency : 0
                                , fltQuoteFee : 0
                                , fltAmountSeg : 0
                                , fltEAD: 0
                                , fltEADZP: 0
                                , fltRAD : 0
                                , fltAmount : 0
                                , fltACK : 0
                                , fltVolAVR : 1
                                , fltVol : 1
                                , fltWeightAVR : 1
                                , fltWeight : 1
                                , fltWeightAmount : 0
                                , fltVolAmount : 0
                            };
                            $scope.PP.mapQuotes['T7V'].ranges[keyRange] = {
                                fltSeg : 0
                                , fltFullFee : 0
                                , fltNormalFee : 0
                                , fltTotalQuote : 0
                                , fltDiscount : 0
                                , intFrecuency : 0
                                , fltQuoteFee : 0
                                , fltAmountSeg : 0
                                , fltEAD: 0
                                , fltEADZP: 0
                                , fltRAD : 0
                                , fltAmount : 0
                                , fltACK : 0
                                , fltVolAVR : 1
                                , fltVol : 1
                                , fltWeightAVR : 1
                                , fltWeight : 1
                                , fltWeightAmount : 0
                                , fltVolAmount : 0
                            };
                            $scope.PP.mapRanges[keyRange] = {
                                fltCost: 0
                            };
                            $scope.PPDS.ranges[keyRange] = {
                                intFrecuency : 0
                                , fltFrecuency :0
                                , fltWeight:0
                                , fltVol:0
                                , fltVolWeight:0
                                , fltDominantWeight:0
                                , fltLarge:0
                                , fltHigh:0
                                , fltWidth:0
                                , fltAmount:0
                                , fltFullFee : 0
                                , fltTotalFull : 0
                                , fltQuoteFee : 0
                                , fltTotalQuote : 0
                                , fltDisc : 0
                            };
                            $scope.PP2D.ranges[keyRange] = {
                                intFrecuency : 0
                                , fltFrecuency :0
                                , fltWeight:0
                                , fltVol:0
                                , fltVolWeight:0
                                , fltDominantWeight:0
                                , fltLarge:0
                                , fltHigh:0
                                , fltWidth:0
                                , fltFullFee : 0
                                , fltTotalFull : 0
                                , fltQuoteFee : 0
                                , fltTotalQuote : 0
                                , fltDisc : 0
                            };
                            $scope.PPA12.ranges[keyRange] = {
                                intFrecuency : 0
                                , fltFrecuency :0
                                , fltWeight:0
                                , fltVol:0
                                , fltVolWeight:0
                                , fltDominantWeight:0
                                , fltLarge:0
                                , fltHigh:0
                                , fltWidth:0, fltFullFee : 0
                                , fltTotalFull : 0
                                , fltQuoteFee : 0
                                , fltTotalQuote : 0
                                , fltDisc : 0
                            };
                        }
                );

                //debugger;
                /*
                * Controller functions
                */
                $scope.addAll = function(strType, strOpr){
                    switch (strType) {
                        case 'fee':
                            if(strOpr === 'add')
                                j$.each($scope.PP.FeeSelect.available, function (i, fee) {
                                    fee.blnSelected = $scope.PP.blnFeeAddAll;
                                });
                            else if(strOpr === 'remove')
                                j$.each($scope.PP.FeeSelect.selected, function (i, fee) {
                                    fee.blnSelected = $scope.PP.blnFeeRemoveAll;
                                });
                            break;
                        case 'service':
                            if(strOpr === 'add')
                                j$.each($scope.PP.ServiceSelect.available, function (i, serv) {
                                    serv.blnSelected = $scope.PP.blnServiceAddAll;
                                });
                            else if(strOpr === 'remove')
                                j$.each($scope.PP.ServiceSelect.selected, function (i, serv) {
                                    serv.blnSelected = $scope.PP.blnServiceRemoveAll;
                                });
                            break;
                    }
                };

                $scope.addFee = function(fee){
                    var index =  j$.inArray(fee, $scope.PP.FeeSelect.available);
                    $scope.PP.FeeSelect.available.splice(index, 1);
                    $scope.PP.FeeSelect.selected.push(fee);
                    switch (fee.id) {
                        case 'DS' :
                            $scope.PPDS.blnShow = true;
                            break;
                        case '2D':
                            $scope.PP2D.blnShow = true;
                            break;
                        case 'A12':
                            $scope.PPA12.blnShow = true;
                            break;
                        default :
                            $scope.PP.mapQuotes[fee.id].blnShow = true;
                            break;
                    }
                    $scope.PP.FeeSelect.selected.sort(function (a, b) {
                        if (a.order > b.order) {
                            return 1;
                        }
                        if (a.order < b.order) {
                            return -1;
                        }
                        // a must be equal to b
                        return 0;
                    });

                    if(fee.id == 'T7')
                        $scope.calculateEXP();
                };

                $scope.addService = function(service){
                    var index =  j$.inArray(service, $scope.PP.ServiceSelect.available);
                    $scope.PP.ServiceSelect.available.splice(index, 1);
                    $scope.PP.ServiceSelect.selected.push(service);
                    switch (service.id) {
                        case 'EAD':
                            $scope.PP.blnEAD = true;
                            break;
                        case 'RAD':
                            $scope.PP.blnRAD = true;
                            break;
                        case 'SEG':
                            $scope.PP.blnSEG = true;
                            break;
                        case 'ACK':
                            $scope.PP.blnACK = true;
                            break;
                    }
                    if($scope.PPDS.intTotalQ > 0)
                        $scope.calculatePPEXP('DS');
                    if($scope.PP2D.intTotalQ > 0)
                        $scope.calculatePPEXP('2D');
                    if($scope.PPA12.intTotalQ > 0)
                        $scope.calculatePPEXP('A12');
                };

                $scope.backPP = function(){
                    $scope.PPstep1 = true;
                    $scope.PPstep2 = false;
                    $scope.ODCstep1 = true;
                    $scope.ODCstep2 = false;
                };

                $scope.calculateDimensionsPP = function(fee, key){
                    switch (fee) {
                        case 'DS':
                            $scope.PPDS.ranges[key].fltVol = ($scope.PPDS.ranges[key].fltLarge * $scope.PPDS.ranges[key].fltWidth * $scope.PPDS.ranges[key].fltHigh) / 100;
                            $scope.PPDS.ranges[key].fltVolWeight = ($scope.PPDS.ranges[key].fltLarge * $scope.PPDS.ranges[key].fltWidth * $scope.PPDS.ranges[key].fltHigh) / $scope.Wrapper.mapCS['CPV'];

                            if($scope.PPDS.ranges[key].fltVolWeight > $scope.PPDS.ranges[key].fltWeight)
                                $scope.PPDS.ranges[key].fltDominantWeight = $scope.PPDS.ranges[key].fltVolWeight;
                            else
                                $scope.PPDS.ranges[key].fltDominantWeight = $scope.PPDS.ranges[key].fltWeight;
                            break;
                        case '2D':
                            $scope.PP2D.ranges[key].fltVol = ($scope.PP2D.ranges[key].fltLarge * $scope.PP2D.ranges[key].fltWidth * $scope.PP2D.ranges[key].fltHigh) / 100;
                            $scope.PP2D.ranges[key].fltVolWeight = ($scope.PP2D.ranges[key].fltLarge * $scope.PP2D.ranges[key].fltWidth * $scope.PP2D.ranges[key].fltHigh) / $scope.Wrapper.mapCS['CPV'];

                            if($scope.PP2D.ranges[key].fltVolWeight > $scope.PP2D.ranges[key].fltWeight)
                                $scope.PP2D.ranges[key].fltDominantWeight = $scope.PP2D.ranges[key].fltVolWeight;
                            else
                                $scope.PP2D.ranges[key].fltDominantWeight = $scope.PP2D.ranges[key].fltWeight;
                            break;
                        case 'A12':
                            $scope.PPA12.ranges[key].fltVol = ($scope.PPA12.ranges[key].fltLarge * $scope.PPA12.ranges[key].fltWidth * $scope.PPA12.ranges[key].fltHigh) / 100;
                            $scope.PPA12.ranges[key].fltVolWeight = ($scope.PPA12.ranges[key].fltLarge * $scope.PPA12.ranges[key].fltWidth * $scope.PPA12.ranges[key].fltHigh) / $scope.Wrapper.mapCS['CPV'];

                            if($scope.PPA12.ranges[key].fltVolWeight > $scope.PPA12.ranges[key].fltWeight)
                                $scope.PPA12.ranges[key].fltDominantWeight = $scope.PPA12.ranges[key].fltVolWeight;
                            else
                                $scope.PPA12.ranges[key].fltDominantWeight = $scope.PPA12.ranges[key].fltWeight;
                            break;
                    }
                    $scope.calculateEXP();
                };

                $scope.calculateEXP = function(){
                    $scope.PP.TOTAL['NORMAL-STD'] = 0;
                    $scope.PP.TOTAL['PROPUESTA-STD'] = 0;
                    $scope.PP.TOTAL['DESCUENTO-STD'] = 0;

                    $scope.PP.TOTAL['NORMAL-SEG'] = 0;
                    $scope.PP.TOTAL['PROPUESTA-SEG'] = 0;
                    $scope.PP.TOTAL['DESCUENTO-SEG'] = 0;

                    $scope.calculatePP();

                    if($scope.PPDS.intTotalQ > 0)
                        $scope.calculatePPEXP('DS');
                    if($scope.PP2D.intTotalQ > 0)
                        $scope.calculatePPEXP('2D');
                    if($scope.PPA12.intTotalQ > 0)
                        $scope.calculatePPEXP('A12');

                    $scope.PP.TOTAL['NORMAL-STD']       = $scope.PP.TOTAL['NORMAL'];
                    $scope.PP.TOTAL['PROPUESTA-STD']    = $scope.PP.TOTAL['PROPUESTA'];
                    $scope.PP.TOTAL['DESCUENTO-STD']    = $scope.PP.TOTAL['DESCUENTO'];
                    $scope.PP.TOTAL['SEGURO-STD']       = $scope.PP.TOTAL['SEGURO'];

                    $scope.PP.TOTAL['NORMAL'] += $scope.PPDS.intTotalFull;
                    $scope.PP.TOTAL['NORMAL'] += $scope.PP2D.intTotalFull;
                    $scope.PP.TOTAL['NORMAL'] += $scope.PPA12.intTotalFull;

                    $scope.PP.TOTAL['PROPUESTA'] += $scope.PPDS.intTotalQuote;
                    $scope.PP.TOTAL['PROPUESTA'] += $scope.PP2D.intTotalQuote;
                    $scope.PP.TOTAL['PROPUESTA'] += $scope.PPA12.intTotalQuote;

                    $scope.PP.TOTAL['PAQUETES'] += $scope.PPDS.intTotalQ;
                    $scope.PP.TOTAL['PAQUETES'] += $scope.PP2D.intTotalQ;
                    $scope.PP.TOTAL['PAQUETES'] += $scope.PPA12.intTotalQ;

                    $scope.PP.TOTAL['SEGURO'] += $scope.PPDS.fltSegAmount;
                    $scope.PP.TOTAL['SEGURO'] += $scope.PP2D.fltSegAmount;
                    $scope.PP.TOTAL['SEGURO'] += $scope.PPA12.fltSegAmount;

                    $scope.PP.TOTAL['NORMAL-SEG'] = $scope.PPDS.intTotalFull + $scope.PP2D.intTotalFull + $scope.PPA12.intTotalFull;
                    $scope.PP.TOTAL['PROPUESTA-SEG'] = $scope.PPDS.intTotalQuote + $scope.PP2D.intTotalQuote + $scope.PPA12.intTotalQuote;
                    $scope.PP.TOTAL['SEGURO-SEG'] = $scope.PPDS.fltSegAmount + $scope.PP2D.fltSegAmount + $scope.PPA12.fltSegAmount;

                    $scope.PP.TOTAL['DESCUENTO'] = ($scope.PP.TOTAL['PROPUESTA'] - $scope.PP.TOTAL['SEGURO']) / ($scope.PP.TOTAL['NORMAL'] - $scope.PP.TOTAL['SEGURO']) -1;
                    $scope.PP.TOTAL['DESCUENTO-STD'] = ($scope.PP.TOTAL['PROPUESTA-STD'] - $scope.PP.TOTAL['SEGURO-STD']) / ($scope.PP.TOTAL['NORMAL-STD'] - $scope.PP.TOTAL['SEGURO-STD']) -1;
                    $scope.PP.TOTAL['DESCUENTO-SEG'] = ($scope.PP.TOTAL['PROPUESTA-SEG'] - $scope.PP.TOTAL['SEGURO-SEG']) / ($scope.PP.TOTAL['NORMAL-SEG'] - $scope.PP.TOTAL['SEGURO-SEG']) -1;

                };

                $scope.calculatePP = function(){
                    $scope.sent = false;
                    $scope.PP.TOTAL['NORMAL'] = 0;
                    $scope.PP.TOTAL['PROPUESTA'] = 0;
                    $scope.PP.TOTAL['DESCUENTO'] = 0;
                    $scope.PP.TOTAL['PAQUETES'] = 0;
                    $scope.PP.TOTAL['SEGURO'] = 0;

                    if($scope.PP.blnSEG) {
                        $scope.PP.fltAmountSEG = ($scope.Wrapper.mapCS['SEG'] / 1000) * $scope.PP.fltSEG;
                        $scope.PPZP.fltAmountSEG = ($scope.Wrapper.mapCS['SEG'] / 1000) * $scope.PP.fltSEG;
                    }
                    j$.each($scope.PPZP.listFee
                            , function (keyFee, strFee) {
                                $scope.PP.mapQuotes[keyFee].intFeeTotalFrec = 0;
                                $scope.PP.mapQuotes[keyFee].fltFeeTotalDesc = 0;
                                $scope.PP.mapQuotes[keyFee].fltFeeTotalNormal = 0;
                                $scope.PP.mapQuotes[keyFee].fltFeeTotalQuote = 0;
                                $scope.PP.mapQuotes[keyFee].fltFeeTotalSEG = 0;
                                if(keyFee !== 'T7'){
                                    $scope.PPZP.mapQuotes[keyFee].intFeeTotalFrec = 0;
                                    $scope.PPZP.mapQuotes[keyFee].fltFeeTotalDesc = 0;
                                    $scope.PPZP.mapQuotes[keyFee].fltFeeTotalNormal = 0;
                                    $scope.PPZP.mapQuotes[keyFee].fltFeeTotalQuote = 0;
                                    $scope.PPZP.mapQuotes[keyFee].fltFeeTotalSEG = 0;
                                }
                                if($scope.PP.mapQuotes[keyFee].blnShow)
                                    j$.each($scope.PP.listRange
                                            ,function (keyRange, strRange) {
                                                if(keyFee !== 'T7')
                                                    $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltEAD = $scope.Wrapper.mapCS['AEZP'];

                                                if (!$scope.exceptionAD(keyFee)) {
                                                    if ($scope.PP.blnEAD) {
                                                        $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltEAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinEAD'], $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltAmount );
                                                    } else
                                                        $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltEAD = 0;

                                                    if ($scope.PP.blnRAD){
                                                        $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltRAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinRAD'], $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltAmount);
                                                        $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltRAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinRAD'], $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltAmount);
                                                    }

                                                    else {
                                                        $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltRAD = 0;
                                                        $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltRAD = 0;
                                                    }
                                                    if ($scope.PP.blnSEG) {
                                                        $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg = $scope.PP.fltAmountSEG;
                                                        $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg = $scope.PP.fltAmountSEG;
                                                    } else {
                                                        $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg = 0;
                                                        $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg = 0;
                                                    }

                                                }

                                                if($scope.PP.blnACK && notEmpty($scope.PP.strAck) && $scope.Wrapper.mapACK[$scope.PP.strAck]) {
                                                    $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltACK = $scope.Wrapper.mapACK[$scope.PP.strAck];
                                                    $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltACK = $scope.Wrapper.mapACK[$scope.PP.strAck];
                                                }
                                                else{
                                                    $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltACK = 0;
                                                    $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltACK = 0;
                                                }

                                                $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltFullFee = $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltAmount
                                                        + $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltACK
                                                        + $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltEAD
                                                        + $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltRAD
                                                        + $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg;

                                                $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltFullFee = $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltAmount
                                                        + $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltACK
                                                        + $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltEAD
                                                        + $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltRAD
                                                        + $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg;

                                                // Costo General
                                                if(keyFee !== 'T7' && $scope.PP.fltGENCost > 0){
                                                    $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee = $scope.PP.fltGENCost;
                                                    $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee = $scope.PP.fltGENCost;
                                                }

                                                // Descuento general
                                                if($scope.PP.fltGENDisc > 0) {
                                                    $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee = $scope.desc($scope.PP.mapQuotes[keyFee].ranges[keyRange].fltFullFee - $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg, $scope.PP.fltGENDisc) + $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg;
                                                    if (keyFee !== 'T7')
                                                        $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee = $scope.desc($scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltFullFee - $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg, $scope.PP.fltGENDisc) + $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg;
                                                }

                                                // Costo flat por tarifa
                                                if($scope.PP.mapQuotes[keyFee].fltCost > 0) {
                                                    $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee = $scope.PP.mapQuotes[keyFee].fltCost;
                                                    $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee =  $scope.PP.mapQuotes[keyFee].fltCost;
                                                }

                                                // Costo por Rango KM
                                                if($scope.PP.mapRanges[keyRange].fltCost > 0){
                                                    $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee =  $scope.PP.mapRanges[keyRange].fltCost;
                                                    $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee = $scope.PP.mapRanges[keyRange].fltCost;
                                                }

                                                if(keyFee !== 'T7' && keyFee !== 'T7V' && keyFee !== 'T7P'){
                                                    $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltNormalFee = $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltFullFee * $scope.PP.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                    $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote = $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee * $scope.PP.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                    if($scope.PP.mapQuotes[keyFee].ranges[keyRange].fltNormalFee > 0)
                                                        $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltDiscount = ($scope.PP.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote - ($scope.PP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg * $scope.PP.mapQuotes[keyFee].ranges[keyRange].intFrecuency))
                                                                / ($scope.PP.mapQuotes[keyFee].ranges[keyRange].fltNormalFee - ($scope.PP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg * $scope.PP.mapQuotes[keyFee].ranges[keyRange].intFrecuency))  -1;
                                                    else
                                                        $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltDiscount = 0;

                                                    $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltNormalFee = $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltFullFee * $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                    $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote = $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee * $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                    if($scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltNormalFee > 0)
                                                        $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltDiscount = ($scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote - ($scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg * $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency))
                                                                / ($scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltNormalFee - ($scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg * $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency))  -1;
                                                    else
                                                        $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltDiscount = 0;

                                                    $scope.PP.mapQuotes[keyFee].fltFeeTotalNormal += $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltNormalFee;
                                                    $scope.PP.mapQuotes[keyFee].intFeeTotalFrec += $scope.PP.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                    $scope.PP.mapQuotes[keyFee].fltFeeTotalQuote += $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote;
                                                    if($scope.PP.mapQuotes[keyFee].ranges[keyRange].intFrecuency > 0)
                                                        $scope.PP.mapQuotes[keyFee].fltFeeTotalSEG += $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg * $scope.PP.mapQuotes[keyFee].ranges[keyRange].intFrecuency;

                                                    if($scope.PPZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency > 0){
                                                        $scope.PPZP.mapQuotes[keyFee].fltFeeTotalNormal += $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltNormalFee;
                                                        $scope.PPZP.mapQuotes[keyFee].intFeeTotalFrec += $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                        $scope.PPZP.mapQuotes[keyFee].fltFeeTotalQuote += $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote;
                                                        $scope.PPZP.mapQuotes[keyFee].fltFeeTotalSEG += $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg * $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                    }
                                                }
                                                /**/
                                            }
                                    );

                                if($scope.PP.mapQuotes[keyFee].fltFeeTotalNormal > 0)
                                    $scope.PP.mapQuotes[keyFee].fltFeeTotalDesc = ($scope.PP.mapQuotes[keyFee].fltFeeTotalQuote - $scope.PP.mapQuotes[keyFee].fltFeeTotalSEG)
                                            / ($scope.PP.mapQuotes[keyFee].fltFeeTotalNormal - $scope.PP.mapQuotes[keyFee].fltFeeTotalSEG) - 1;

                                if(keyFee !== 'T7' && $scope.PPZP.mapQuotes[keyFee].fltFeeTotalNormal > 0)
                                    $scope.PPZP.mapQuotes[keyFee].fltFeeTotalDesc = ($scope.PPZP.mapQuotes[keyFee].fltFeeTotalQuote - $scope.PPZP.mapQuotes[keyFee].fltFeeTotalSEG)
                                            / ($scope.PPZP.mapQuotes[keyFee].fltFeeTotalNormal - $scope.PPZP.mapQuotes[keyFee].fltFeeTotalSEG) - 1;

                                if(keyFee !== 'T7' && keyFee !== 'T7V' && keyFee !== 'T7P'){
                                    $scope.PP.TOTAL['NORMAL'] += $scope.PP.mapQuotes[keyFee].fltFeeTotalNormal + $scope.PPZP.mapQuotes[keyFee].fltFeeTotalNormal;
                                    $scope.PP.TOTAL['PROPUESTA'] += $scope.PP.mapQuotes[keyFee].fltFeeTotalQuote + $scope.PPZP.mapQuotes[keyFee].fltFeeTotalQuote;
                                    $scope.PP.TOTAL['PAQUETES'] += $scope.PP.mapQuotes[keyFee].intFeeTotalFrec + $scope.PPZP.mapQuotes[keyFee].intFeeTotalFrec;
                                    $scope.PP.TOTAL['SEGURO'] += $scope.PP.mapQuotes[keyFee].fltFeeTotalSEG + $scope.PPZP.mapQuotes[keyFee].fltFeeTotalSEG;
                                }

                            }
                    );

                    if($scope.PP.TOTAL['NORMAL'] > 0)
                        $scope.PP.TOTAL['DESCUENTO'] = ($scope.PP.TOTAL['PROPUESTA'] - $scope.PP.TOTAL['SEGURO'])
                                / ($scope.PP.TOTAL['NORMAL'] - $scope.PP.TOTAL['SEGURO']) -1;

                    $scope.PP.mapQuotes['T7'].intFeeTotalFrec = 0;
                    $scope.PP.mapQuotes['T7'].fltFeeTotalNormal = 0;
                    $scope.PP.mapQuotes['T7'].fltFeeTotalQuote = 0;
                    $scope.PP.mapQuotes['T7'].fltFeeTotalSEG = 0;
                    $scope.PP.mapQuotes['T7V'].intFeeTotalFrec = 0;
                    $scope.PP.mapQuotes['T7V'].fltFeeTotalNormal = 0;
                    $scope.PP.mapQuotes['T7V'].fltFeeTotalQuote = 0;
                    $scope.PP.mapQuotes['T7V'].fltFeeTotalSEG = 0;
                    $scope.PP.mapQuotes['T7P'].intFeeTotalFrec = 0;
                    $scope.PP.mapQuotes['T7P'].fltFeeTotalNormal = 0;
                    $scope.PP.mapQuotes['T7P'].fltFeeTotalQuote = 0;
                    $scope.PP.mapQuotes['T7P'].fltFeeTotalSEG = 0;

                    if($scope.PP.mapQuotes['T7'].blnShow)
                        j$.each($scope.PP.listRange
                                ,function (keyRange, strRange) {

                                    if ($scope.PP.blnEAD) {
                                        $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltEAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinEAD'], $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltAmount * $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltVolAVR);
                                        $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltEAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinEAD'], $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltAmount * $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltWeightAVR);
                                    } else {
                                        $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltEAD = 0;
                                        $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltEAD = 0;
                                    }
                                    if ($scope.PP.blnRAD) {
                                        $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltRAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinRAD'], $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltAmount * $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltVolAVR);
                                        $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltRAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinRAD'], $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltAmount * $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltWeightAVR);
                                    } else {
                                        $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltRAD = 0;
                                        $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltRAD = 0;
                                    }
                                    if ($scope.PP.blnSEG) {
                                        $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltAmountSeg = $scope.PP.fltAmountSEG;
                                        $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltAmountSeg = $scope.PP.fltAmountSEG;
                                    } else {
                                        $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltAmountSeg = 0;
                                        $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltAmountSeg = 0;
                                    }
                                    if($scope.PP.blnACK && notEmpty($scope.PP.strAck) && $scope.Wrapper.mapACK[$scope.PP.strAck]) {
                                        $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltACK = $scope.Wrapper.mapACK[$scope.PP.strAck];
                                        $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltACK = $scope.Wrapper.mapACK[$scope.PP.strAck];
                                    }else{
                                        $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltACK = 0;
                                        $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltACK = 0;
                                    }

                                    if($scope.PPT7Calc === 'byDelivery'){
                                        $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltVolAVR =  $scope.PP.mapQuotes['T7'].ranges[keyRange].fltVolAVR;
                                        $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltWeightAVR = $scope.PP.mapQuotes['T7'].ranges[keyRange].fltWeightAVR;
                                        $scope.PP.mapQuotes['T7V'].ranges[keyRange].intFrecuency = $scope.PP.mapQuotes['T7'].ranges[keyRange].intFrecuency;
                                        $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltQuoteFee = $scope.PP.mapQuotes['T7'].ranges[keyRange].fltQuoteFee;

                                        $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltVolAVR = $scope.PP.mapQuotes['T7'].ranges[keyRange].fltVolAVR;
                                        $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltWeightAVR = $scope.PP.mapQuotes['T7'].ranges[keyRange].fltWeightAVR;
                                        $scope.PP.mapQuotes['T7P'].ranges[keyRange].intFrecuency = $scope.PP.mapQuotes['T7'].ranges[keyRange].intFrecuency;
                                        $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltQuoteFee = $scope.PP.mapQuotes['T7'].ranges[keyRange].fltQuoteFee;
                                    }

                                    $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltFullFee = ($scope.PP.mapQuotes['T7V'].ranges[keyRange].fltAmount * $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltVolAVR)
                                            + $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltEAD
                                            + $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltRAD
                                            + $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltAmountSeg
                                            + $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltACK;

                                    $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltFullFee = ($scope.PP.mapQuotes['T7P'].ranges[keyRange].fltAmount * $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltWeightAVR)
                                            + $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltEAD
                                            + $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltRAD
                                            + $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltAmountSeg
                                            + $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltACK;

                                    $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltNormalFee = $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltFullFee * $scope.PP.mapQuotes['T7V'].ranges[keyRange].intFrecuency;
                                    $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltNormalFee = $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltFullFee * $scope.PP.mapQuotes['T7P'].ranges[keyRange].intFrecuency;

                                    if($scope.PPT7Calc === 'byDelivery' ){
                                        // Costo General
                                        if($scope.PP.fltGENCost > 0 ){
                                            $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltQuoteFee = $scope.PP.fltGENCost;
                                            $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltQuoteFee = $scope.PP.fltGENCost;
                                        } else if($scope.PP.fltGENCost > 0 && $scope.OnlineDocByDestiny && !$scope.OnlineDocByRangeKM){
                                            $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltQuoteFee = $scope.PP.fltGENCost;
                                            $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltQuoteFee = $scope.PP.fltGENCost;
                                        }
                                        // Descuento general
                                        if($scope.PP.fltGENDisc > 0 ) {
                                            $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltQuoteFee = $scope.desc($scope.PP.mapQuotes['T7V'].ranges[keyRange].fltFullFee - $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltAmountSeg, $scope.PP.fltGENDisc) + $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltAmountSeg;
                                            $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltQuoteFee = $scope.desc($scope.PP.mapQuotes['T7P'].ranges[keyRange].fltFullFee - $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltAmountSeg, $scope.PP.fltGENDisc) + $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltAmountSeg;
                                        } else if($scope.PP.fltGENDisc > 0 && $scope.OnlineDocByDestiny  && !$scope.OnlineDocByRangeKM){
                                            $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltQuoteFee = $scope.desc($scope.PP.mapQuotes['T7V'].ranges[keyRange].fltFullFee - $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltAmountSeg, $scope.PP.fltGENDisc) + $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltAmountSeg;
                                            $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltQuoteFee = $scope.desc($scope.PP.mapQuotes['T7P'].ranges[keyRange].fltFullFee - $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltAmountSeg, $scope.PP.fltGENDisc) + $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltAmountSeg;
                                        }
                                        //	Costo flat por tarifa
                                        if($scope.PP.mapQuotes['T7'].fltCost > 0 ) {
                                            $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltQuoteFee = $scope.PP.mapQuotes['T7'].fltCost;
                                            $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltQuoteFee = $scope.PP.mapQuotes['T7'].fltCost;
                                        } else if($scope.PP.mapQuotes['T7'].fltCost > 0 && $scope.OnlineDocByDestiny  && !$scope.OnlineDocByRangeKM){
                                            $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltQuoteFee = $scope.PP.mapQuotes['T7'].fltCost;
                                            $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltQuoteFee = $scope.PP.mapQuotes['T7'].fltCost;
                                        }
                                        // Costo por Rango KM
                                        if($scope.PP.mapRanges[keyRange].fltCost > 0 ){
                                            $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltQuoteFee =  $scope.PP.mapRanges[keyRange].fltCost;
                                            $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltQuoteFee =  $scope.PP.mapRanges[keyRange].fltCost;
                                        }

                                        $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltTotalQuote = $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltQuoteFee
                                                * $scope.PP.mapQuotes['T7V'].ranges[keyRange].intFrecuency;

                                        $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltTotalQuote = $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltQuoteFee
                                                * $scope.PP.mapQuotes['T7P'].ranges[keyRange].intFrecuency;
                                    } else {
                                        $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltTotalQuote = $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltQuoteFee
                                                * $scope.PP.mapQuotes['T7V'].ranges[keyRange].intFrecuency
                                                * $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltVolAVR;

                                        $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltTotalQuote = $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltQuoteFee
                                                * $scope.PP.mapQuotes['T7P'].ranges[keyRange].intFrecuency
                                                * $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltWeightAVR;
                                    }

                                    if($scope.PP.mapQuotes['T7V'].ranges[keyRange].fltNormalFee > 0)
                                        $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltDiscount = ($scope.PP.mapQuotes['T7V'].ranges[keyRange].fltTotalQuote - ($scope.PP.mapQuotes['T7V'].ranges[keyRange].fltAmountSeg * $scope.PP.mapQuotes['T7V'].ranges[keyRange].intFrecuency))
                                                / ($scope.PP.mapQuotes['T7V'].ranges[keyRange].fltNormalFee - ($scope.PP.mapQuotes['T7V'].ranges[keyRange].fltAmountSeg * $scope.PP.mapQuotes['T7V'].ranges[keyRange].intFrecuency)) -1;

                                    if($scope.PP.mapQuotes['T7P'].ranges[keyRange].fltNormalFee > 0)
                                        $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltDiscount = ($scope.PP.mapQuotes['T7P'].ranges[keyRange].fltTotalQuote - ($scope.PP.mapQuotes['T7P'].ranges[keyRange].fltAmountSeg * $scope.PP.mapQuotes['T7P'].ranges[keyRange].intFrecuency))
                                                / ($scope.PP.mapQuotes['T7P'].ranges[keyRange].fltNormalFee - ($scope.PP.mapQuotes['T7P'].ranges[keyRange].fltAmountSeg * $scope.PP.mapQuotes['T7P'].ranges[keyRange].intFrecuency)) -1;

                                    if($scope.PPT7Calc === 'byDelivery' && $scope.PP.fltGENDisc > 0){
                                        if ($scope.PP.mapQuotes['T7V'].ranges[keyRange].fltFullFee > $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltFullFee)
                                            $scope.PP.mapQuotes['T7'].ranges[keyRange] = $scope.copy($scope.PP.mapQuotes['T7V'].ranges[keyRange], $scope.PP.mapQuotes['T7'].ranges[keyRange]);
                                        else
                                            $scope.PP.mapQuotes['T7'].ranges[keyRange] = $scope.copy($scope.PP.mapQuotes['T7P'].ranges[keyRange], $scope.PP.mapQuotes['T7'].ranges[keyRange]);
                                    } else {
                                        if ($scope.PP.mapQuotes['T7V'].ranges[keyRange].fltDiscount < $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltDiscount) {
                                            $scope.PP.mapQuotes['T7'].ranges[keyRange] = $scope.copy($scope.PP.mapQuotes['T7V'].ranges[keyRange], $scope.PP.mapQuotes['T7'].ranges[keyRange]);
                                            $scope.PP.mapQuotes['T7'].ranges[keyRange].strTarifaDom = 'TARIFA T7-V';
                                        }else{
                                            $scope.PP.mapQuotes['T7'].ranges[keyRange] = $scope.copy($scope.PP.mapQuotes['T7P'].ranges[keyRange], $scope.PP.mapQuotes['T7'].ranges[keyRange]);
                                            $scope.PP.mapQuotes['T7'].ranges[keyRange].strTarifaDom = 'TARIFA T7-P';
                                        }
                                    }

                                    $scope.PP.mapQuotes['T7V'].fltFeeTotalNormal += $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltNormalFee;
                                    $scope.PP.mapQuotes['T7V'].intFeeTotalFrec += $scope.PP.mapQuotes['T7V'].ranges[keyRange].intFrecuency;
                                    $scope.PP.mapQuotes['T7V'].fltFeeTotalQuote += $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltTotalQuote;
                                    if($scope.PP.mapQuotes['T7V'].fltFeeTotalNormal > 0 )
                                        $scope.PP.mapQuotes['T7V'].fltTotalDisc = ($scope.PP.mapQuotes['T7V'].fltFeeTotalQuote - $scope.PP.mapQuotes['T7'].fltFeeTotalSEG * $scope.PP.mapQuotes['T7V'].ranges[keyRange].intFrecuency)
                                                / ($scope.PP.mapQuotes['T7V'].fltFeeTotalNormal - $scope.PP.mapQuotes['T7'].fltFeeTotalSEG  * $scope.PP.mapQuotes['T7V'].ranges[keyRange].intFrecuency) -1;

                                    $scope.PP.mapQuotes['T7P'].fltFeeTotalNormal += $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltNormalFee;
                                    $scope.PP.mapQuotes['T7P'].intFeeTotalFrec += $scope.PP.mapQuotes['T7P'].ranges[keyRange].intFrecuency;
                                    $scope.PP.mapQuotes['T7P'].fltFeeTotalQuote += $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltTotalQuote;
                                    if($scope.PP.mapQuotes['T7P'].fltFeeTotalNormal > 0 )
                                        $scope.PP.mapQuotes['T7P'].fltTotalDisc = ($scope.PP.mapQuotes['T7P'].fltFeeTotalQuote - $scope.PP.mapQuotes['T7'].fltFeeTotalSEG * $scope.PP.mapQuotes['T7P'].ranges[keyRange].intFrecuency)
                                                / ($scope.PP.mapQuotes['T7P'].fltFeeTotalNormal - $scope.PP.mapQuotes['T7'].fltFeeTotalSEG  * $scope.PP.mapQuotes['T7P'].ranges[keyRange].intFrecuency) -1;

                                    $scope.PP.mapQuotes['T7'].fltFeeTotalNormal += $scope.PP.mapQuotes['T7'].ranges[keyRange].fltNormalFee;
                                    $scope.PP.mapQuotes['T7'].intFeeTotalFrec += $scope.PP.mapQuotes['T7'].ranges[keyRange].intFrecuency;
                                    $scope.PP.mapQuotes['T7'].fltFeeTotalQuote += $scope.PP.mapQuotes['T7'].ranges[keyRange].fltTotalQuote;
                                    if($scope.PP.mapQuotes['T7'].fltFeeTotalNormal > 0 )
                                        $scope.PP.mapQuotes['T7'].fltTotalDisc = ($scope.PP.mapQuotes['T7'].fltFeeTotalQuote - $scope.PP.mapQuotes['T7'].fltFeeTotalSEG * $scope.PP.mapQuotes['T7'].ranges[keyRange].intFrecuency)
                                                / ($scope.PP.mapQuotes['T7'].fltFeeTotalNormal - $scope.PP.mapQuotes['T7'].fltFeeTotalSEG * $scope.PP.mapQuotes['T7'].ranges[keyRange].intFrecuency) -1;
                                    /**/
                                }
                        );
                    $scope.PP.TOTAL['NORMAL'] += $scope.PP.mapQuotes['T7'].fltFeeTotalNormal;
                    $scope.PP.TOTAL['PROPUESTA'] += $scope.PP.mapQuotes['T7'].fltFeeTotalQuote;
                    $scope.PP.TOTAL['PAQUETES'] += $scope.PP.mapQuotes['T7'].intFeeTotalFrec;
                    $scope.PP.TOTAL['SEGURO'] += $scope.PP.mapQuotes['T7'].fltFeeTotalSEG;


                    if($scope.PP.TOTAL['NORMAL'] > 0)
                        $scope.PP.TOTAL['DESCUENTO'] = ($scope.PP.TOTAL['PROPUESTA'] - $scope.PP.TOTAL['SEGURO'])
                                / ($scope.PP.TOTAL['NORMAL'] - $scope.PP.TOTAL['SEGURO']) -1;
                };

                $scope.calculatePPEXP = function(fee){
                    var full = 0;
                    var quote = 0;
                    var totalFull = 0;
                    var totalQuote = 0;
                    switch (fee) {
                        case 'DS':
                            $scope.PPDS.intTotalQ = 0;
                            $scope.PPDS.intTotalFull = 0;
                            $scope.PPDS.intTotalQuote = 0;
                            $scope.PPDS.intTotalDisc = 0;
                            $scope.PPDS.fltSegAmount = 0;
                            j$.each($scope.PP.listRange
                                    , function (keyRange, strRange) {
                                        if ($scope.PPDS.ranges[keyRange].intFrecuency > 0){
                                            $scope.PPDS.intTotalQ += $scope.PPDS.ranges[keyRange].intFrecuency;
                                            $scope.PPDS.ranges[keyRange].fltFullFee = $scope.Wrapper.mapTarifarioEXP[fee][strRange].GuiaDeArranque1Kg__c
                                                                                    + ($scope.Wrapper.mapTarifarioEXP[fee][strRange].Kg_adicional__c * ($scope.PPDS.ranges[keyRange].fltDominantWeight - 1));

                                            if($scope.PP.blnACK && notEmpty($scope.PP.strAck) && $scope.Wrapper.mapACK[$scope.PP.strAck])
                                                $scope.PPDS.ranges[keyRange].fltFullFee += $scope.Wrapper.mapACK[$scope.PP.strAck];

                                            $scope.PPDS.ranges[keyRange].fltNormalFee = $scope.PPDS.ranges[keyRange].fltFullFee * $scope.PPDS.ranges[keyRange].intFrecuency;
                                            // Costo General
                                            if($scope.PP.fltGENCost > 0)
                                                $scope.PPDS.ranges[keyRange].fltQuoteFee = $scope.PP.fltGENCost;
                                            // Descuento general
                                            if($scope.PP.fltGENDisc > 0)
                                                $scope.PPDS.ranges[keyRange].fltQuoteFee = $scope.desc($scope.PPDS.ranges[keyRange].fltFullFee, $scope.PP.fltGENDisc);
                                            // Costo flat por tarifa
                                            if($scope.PP.mapQuotes['DS'].fltCost > 0)
                                                $scope.PPDS.ranges[keyRange].fltQuoteFee = $scope.PP.mapQuotes['DS'].fltCost;
                                            // Costo por Rango KM
                                            if($scope.PP.mapRanges[keyRange].fltCost > 0)
                                                $scope.PPDS.ranges[keyRange].fltQuoteFee = $scope.PP.mapRanges[keyRange].fltCost;

                                            $scope.PPDS.ranges[keyRange].fltTotalQuote = $scope.PPDS.ranges[keyRange].fltQuoteFee * $scope.PPDS.ranges[keyRange].intFrecuency;

                                            if($scope.PPDS.ranges[keyRange].fltNormalFee > 0)
                                                $scope.PPDS.ranges[keyRange].fltDisc = $scope.PPDS.ranges[keyRange].fltTotalQuote / $scope.PPDS.ranges[keyRange].fltNormalFee - 1;

                                            full = $scope.PPDS.ranges[keyRange].fltFullFee;

                                            if ($scope.PP.blnSEG && $scope.PPDS.ranges[keyRange].fltFullFee > 0){
                                                $scope.PPDS.ranges[keyRange].fltFullFee += $scope.PP.fltAmountSEG;
                                                quote = $scope.PPDS.ranges[keyRange].fltQuoteFee - $scope.PP.fltAmountSEG;
                                                $scope.PPDS.ranges[keyRange].fltDisc = quote / full -1;
                                                $scope.PPDS.fltSegAmount += $scope.PP.fltAmountSEG * $scope.PPDS.ranges[keyRange].intFrecuency;
                                            }

                                            $scope.PPDS.ranges[keyRange].fltNormalFee = $scope.PPDS.ranges[keyRange].fltFullFee * $scope.PPDS.ranges[keyRange].intFrecuency;
                                            $scope.PPDS.ranges[keyRange].fltTotalQuote = $scope.PPDS.ranges[keyRange].fltQuoteFee * $scope.PPDS.ranges[keyRange].intFrecuency;


                                            $scope.PPDS.intTotalFull += $scope.PPDS.ranges[keyRange].fltNormalFee;
                                            $scope.PPDS.intTotalQuote += $scope.PPDS.ranges[keyRange].fltTotalQuote;

                                            if ($scope.PP.blnSEG && $scope.PPDS.ranges[keyRange].fltFullFee > 0){
                                                totalQuote += quote;
                                                totalFull += full;
                                                $scope.PPDS.intTotalDisc = totalQuote / totalFull -1;
                                            }
                                            else
                                                $scope.PPDS.intTotalDisc = $scope.PPDS.intTotalQuote / $scope.PPDS.intTotalFull -1
                                        }
                                    }
                            );
                            break;
                        case '2D':
                            $scope.PP2D.intTotalQ = 0;
                            $scope.PP2D.intTotalFull = 0;
                            $scope.PP2D.intTotalQuote = 0;
                            $scope.PP2D.intTotalDisc = 0;
                            $scope.PP2D.fltSegAmount = 0;
                            j$.each($scope.PP.listRange
                                    , function (keyRange, strRange) {
                                        if ($scope.PP2D.ranges[keyRange].intFrecuency > 0){
                                            $scope.PP2D.intTotalQ += $scope.PP2D.ranges[keyRange].intFrecuency;
                                            $scope.PP2D.ranges[keyRange].fltFullFee = $scope.Wrapper.mapTarifarioEXP[fee][strRange].GuiaDeArranque1Kg__c
                                                    + ($scope.Wrapper.mapTarifarioEXP[fee][strRange].Kg_adicional__c * ($scope.PP2D.ranges[keyRange].fltDominantWeight - 1));

                                            if($scope.PP.blnACK && notEmpty($scope.PP.strAck) && $scope.Wrapper.mapACK[$scope.PP.strAck])
                                                $scope.PP2D.ranges[keyRange].fltFullFee += $scope.Wrapper.mapACK[$scope.PP.strAck];

                                            // Costo General
                                            if($scope.PP.fltGENCost > 0)
                                                $scope.PP2D.ranges[keyRange].fltQuoteFee = $scope.PP.fltGENCost;
                                            // Descuento general
                                            if($scope.PP.fltGENDisc > 0)
                                                $scope.PP2D.ranges[keyRange].fltQuoteFee = $scope.desc($scope.PP2D.ranges[keyRange].fltFullFee, $scope.PP.fltGENDisc);
                                            // Costo flat por tarifa
                                            if($scope.PP.mapQuotes['2D'].fltCost > 0)
                                                $scope.PP2D.ranges[keyRange].fltQuoteFee = $scope.PP.mapQuotes['2D'].fltCost;
                                            // Costo por Rango KM
                                            if($scope.PP.mapRanges[keyRange].fltCost > 0)
                                                $scope.PP2D.ranges[keyRange].fltQuoteFee = $scope.PP.mapRanges[keyRange].fltCost;

                                            $scope.PP2D.ranges[keyRange].fltNormalFee = $scope.PP2D.ranges[keyRange].fltFullFee * $scope.PP2D.ranges[keyRange].intFrecuency;
                                            $scope.PP2D.ranges[keyRange].fltTotalQuote = $scope.PP2D.ranges[keyRange].fltQuoteFee * $scope.PP2D.ranges[keyRange].intFrecuency;

                                            if($scope.PP2D.ranges[keyRange].fltNormalFee > 0)
                                                $scope.PP2D.ranges[keyRange].fltDisc = $scope.PP2D.ranges[keyRange].fltTotalQuote / $scope.PP2D.ranges[keyRange].fltNormalFee - 1;

                                            full = $scope.PP2D.ranges[keyRange].fltFullFee;

                                            if ($scope.PP.blnSEG && $scope.PP2D.ranges[keyRange].fltFullFee > 0){
                                                $scope.PP2D.ranges[keyRange].fltFullFee += $scope.PP.fltAmountSEG;
                                                quote = $scope.PP2D.ranges[keyRange].fltQuoteFee - $scope.PP.fltAmountSEG;
                                                $scope.PP2D.ranges[keyRange].fltDisc = quote / full -1;
                                                $scope.PP2D.fltSegAmount += $scope.PP.fltAmountSEG * $scope.PP2D.ranges[keyRange].intFrecuency;
                                            }

                                            $scope.PP2D.ranges[keyRange].fltNormalFee = $scope.PP2D.ranges[keyRange].fltFullFee * $scope.PP2D.ranges[keyRange].intFrecuency;
                                            $scope.PP2D.ranges[keyRange].fltTotalQuote = $scope.PP2D.ranges[keyRange].fltQuoteFee * $scope.PP2D.ranges[keyRange].intFrecuency;


                                            $scope.PP2D.intTotalFull += $scope.PP2D.ranges[keyRange].fltNormalFee;
                                            $scope.PP2D.intTotalQuote += $scope.PP2D.ranges[keyRange].fltTotalQuote;

                                            if ($scope.PP.blnSEG && $scope.PP2D.ranges[keyRange].fltFullFee > 0){
                                                totalQuote += quote;
                                                totalFull += full;
                                                $scope.PP2D.intTotalDisc = totalQuote / totalFull -1;
                                            }
                                            else
                                                $scope.PP2D.intTotalDisc = $scope.PP2D.intTotalQuote / $scope.PP2D.intTotalFull -1
                                        }
                                    }
                            );
                            break;
                        case 'A12':
                            $scope.PPA12.intTotalQ = 0;
                            $scope.PPA12.intTotalFull = 0;
                            $scope.PPA12.intTotalQuote = 0;
                            $scope.PPA12.intTotalDisc = 0;
                            $scope.PPA12.fltSegAmount = 0;
                            j$.each($scope.PP.listRange
                                    , function (keyRange, strRange) {
                                        if ($scope.PPA12.ranges[keyRange].intFrecuency > 0){
                                            $scope.PPA12.intTotalQ += $scope.PPA12.ranges[keyRange].intFrecuency;
                                            $scope.PPA12.ranges[keyRange].fltFullFee = $scope.Wrapper.mapTarifarioEXP[fee][strRange].GuiaDeArranque1Kg__c
                                                    + ($scope.Wrapper.mapTarifarioEXP[fee][strRange].Kg_adicional__c * ($scope.PPA12.ranges[keyRange].fltDominantWeight - 1));

                                            if($scope.PP.blnACK && notEmpty($scope.PP.strAck) && $scope.Wrapper.mapACK[$scope.PP.strAck])
                                                $scope.PPA12.ranges[keyRange].fltFullFee += $scope.Wrapper.mapACK[$scope.PP.strAck];

                                            // Costo General
                                            if($scope.PP.fltGENCost > 0)
                                                $scope.PPA12.ranges[keyRange].fltQuoteFee = $scope.PP.fltGENCost;
                                            // Descuento general
                                            if($scope.PP.fltGENDisc > 0)
                                                $scope.PPA12.ranges[keyRange].fltQuoteFee = $scope.desc($scope.PPA12.ranges[keyRange].fltFullFee, $scope.PP.fltGENDisc);
                                            // Costo flat por tarifa
                                            if($scope.PP.mapQuotes['A12'].fltCost > 0)
                                                $scope.PPA12.ranges[keyRange].fltQuoteFee = $scope.PP.mapQuotes['A12'].fltCost;
                                            // Costo por Rango KM
                                            if($scope.PP.mapRanges[keyRange].fltCost > 0)
                                                $scope.PPA12.ranges[keyRange].fltQuoteFee = $scope.PP.mapRanges[keyRange].fltCost;

                                            $scope.PPA12.ranges[keyRange].fltNormalFee = $scope.PPA12.ranges[keyRange].fltFullFee * $scope.PPA12.ranges[keyRange].intFrecuency;
                                            $scope.PPA12.ranges[keyRange].fltTotalQuote = $scope.PPA12.ranges[keyRange].fltQuoteFee * $scope.PPA12.ranges[keyRange].intFrecuency;

                                            if($scope.PPA12.ranges[keyRange].fltNormalFee > 0)
                                                $scope.PPA12.ranges[keyRange].fltDisc = $scope.PPA12.ranges[keyRange].fltTotalQuote / $scope.PPA12.ranges[keyRange].fltNormalFee - 1;

                                            full = $scope.PPA12.ranges[keyRange].fltFullFee;

                                            if ($scope.PP.blnSEG && $scope.PPA12.ranges[keyRange].fltFullFee > 0){
                                                $scope.PPA12.ranges[keyRange].fltFullFee += $scope.PP.fltAmountSEG;
                                                quote = $scope.PPA12.ranges[keyRange].fltQuoteFee - $scope.PP.fltAmountSEG;
                                                $scope.PPA12.ranges[keyRange].fltDisc = quote / full -1;
                                                $scope.PPA12.fltSegAmount += $scope.PP.fltAmountSEG * $scope.PPA12.ranges[keyRange].intFrecuency;
                                            }

                                            $scope.PPA12.ranges[keyRange].fltNormalFee = $scope.PPA12.ranges[keyRange].fltFullFee * $scope.PPA12.ranges[keyRange].intFrecuency;
                                            $scope.PPA12.ranges[keyRange].fltTotalQuote = $scope.PPA12.ranges[keyRange].fltQuoteFee * $scope.PPA12.ranges[keyRange].intFrecuency;


                                            $scope.PPA12.intTotalFull += $scope.PPA12.ranges[keyRange].fltNormalFee;
                                            $scope.PPA12.intTotalQuote += $scope.PPA12.ranges[keyRange].fltTotalQuote;

                                            if ($scope.PP.blnSEG && $scope.PPA12.ranges[keyRange].fltFullFee > 0){
                                                totalQuote += quote;
                                                totalFull += full;
                                                $scope.PPA12.intTotalDisc = totalQuote / totalFull -1;
                                            }
                                            else
                                                $scope.PPA12.intTotalDisc = $scope.PPA12.intTotalQuote / $scope.PPA12.intTotalFull -1
                                        }
                                    }
                            );
                            break;
                    }
                };

                $scope.copy = function(a, b){
                    var idB;
                    idB = b.Id;
                    b = Object.assign(b, a);
                    b.Id = idB;
                    return b
                };

                $scope.createQuotesPP = function(){
                    var listDelete = [];
                    var Quote = {
                        Acuse__c: $scope.PP.strAck
                        , SBQQ__Primary__c : true
                        //, PAQ_TipoServicio__c : 'Estándar terrestre (STD)'
                        , Modelo_de_tarifas__c : 'Costos fijos por Tarifas: Por Destinos / Por rangos de km'
                        , Descuento_Global__c : $scope.PP.TOTAL['DESCUENTO-STD'] * - 100
                        , Descuento_Global_Express__c : $scope.PP.TOTAL['DESCUENTO-SEG'] * - 100
                        , PAQ_DescuentoGlobal__c : $scope.PP.TOTAL['DESCUENTO'] * -100
                        , Ingreso_Mensual__c : $scope.PP.TOTAL['PROPUESTA']
                        , TarifaLlenaMensual__c : $scope.PP.TOTAL['NORMAL']
                        , Paquetes_Mensuales__c : $scope.PP.TOTAL['PAQUETES']
                        , Gerente_de_sucursal_aprobacion__c : $scope.Managers['GSU']
                        , KAM_aprobacion__c : $scope.Managers['KAM']
                        , Gerente_desarrollo_aprobacion__c : $scope.Managers['GDS']
                        , Director_comercial_aprobacion__c : $scope.Managers['DCO']
                        , Tipo_de_documentacion__c : 'Guías prepagadas'
                        , Electronicas__c : $scope.BlnElectricGuide
                        , Impresas__c : $scope.BlnPrintedGuide
                    };

                    if($scope.Wrapper.objQuote && $scope.Wrapper.objQuote.Id){
                        Quote.Id = $scope.Wrapper.objQuote.Id;
                        Quote.SBQQ__Status__c = $scope.Wrapper.objQuote.SBQQ__Status__c;
                    }

                    if($scope.Wrapper.objLead && notEmpty($scope.Wrapper.objLead.Id))
                        Quote.Lead__c = $scope.Wrapper.objLead.Id;
                    if($scope.Wrapper.objOpp && notEmpty($scope.Wrapper.objOpp.Id))
                        Quote.SBQQ__Opportunity2__c = $scope.Wrapper.objOpp.Id;
                    if($scope.Wrapper.objOpp && $scope.Wrapper.objOpp.AccountId)
                        Quote.SBQQ__Account__c = $scope.Wrapper.objOpp.AccountId;

                    var listQuoteItem = [];
                    Quote.Servicios_adicionales__c = "";
                    if($scope.PP.blnRAD)
                        Quote.Servicios_adicionales__c = "RAD;";
                    if($scope.PP.blnEAD)
                        Quote.Servicios_adicionales__c += "EAD;";
                    if($scope.PP.blnSEG)
                        Quote.Servicios_adicionales__c += "Seguro;";

                    var rangeDisc = 0;
                    var rangeDiscEXP = 0;
                    var arrayTarifas = '';
                    $scope.PP.blnZP = false;
                    //STD TS -T6
                    j$.each(
                            $scope.PP.listFee
                            , function (keyFee, strFee) {
                                if($scope.PP.mapQuotes[keyFee].blnShow)
                                    j$.each($scope.PP.listRange
                                            , function(keyRange, strRange){
                                                if($scope.PP.mapQuotes[keyFee].ranges[keyRange].intFrecuency > 0 ){
                                                    Quote.PAQ_TipoServicio__c = 'Estándar terrestre (STD)';
                                                    var QuoteItem = {
                                                        SBQQ__Quantity__c :  $scope.PP.mapQuotes[keyFee].ranges[keyRange].intFrecuency
                                                        , SBQQ__Discount__c :  $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltDiscount * 100
                                                        , SBQQ__CustomerPrice__c :  $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee
                                                        , SBQQ__NetPrice__c :  $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltFullFee
                                                        , SBQQ__SpecialPrice__c :  $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltFullFee
                                                        , QuoteTotal__c :  $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee
                                                        , PackWeightAVG__c : $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltWeightAVR
                                                        , PackVolAVG__c : $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltVolAVR
                                                        , ACK__c :  $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltACK
                                                        , EAD__c :  $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltEAD
                                                        , RAD__c :  $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltRAD
                                                        , SEG__c :  $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg
                                                        , Tarifa__c : strFee
                                                        , Rango_KM__c : strRange
                                                        , ZonaPlus__c : false
                                                        , Pack_Seg__c : $scope.PP.fltSEG
                                                        , Id : $scope.PP.mapQuotes[keyFee].ranges[keyRange].Id
                                                        , SBQQ__VolumeDiscount__c : $scope.PP.mapQuotes[keyFee].fltFeeTotalDesc * 100
                                                        , SBQQ__Quote__c : Quote.Id
                                                    };
                                                    if(keyFee === 'T7') {
                                                        QuoteItem.TarifaDominante__c = $scope.PP.mapQuotes['T7'].ranges[keyRange].strTarifaDom;
                                                        QuoteItem.SBQQ__VolumeDiscount__c = $scope.PP.mapQuotes['T7'].fltTotalDisc * 100;
                                                        if($scope.PPT7Calc === 'byDimension'){
                                                            if($scope.PP.mapQuotes['T7'].ranges[keyRange].fltVolAVR > 1)
                                                                QuoteItem.SBQQ__SpecialPrice__c = $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee * $scope.PP.mapQuotes['T7'].ranges[keyRange].fltVolAVR * $scope.PP.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                            if($scope.PP.mapQuotes['T7'].ranges[keyRange].fltWeightAVR > 1)
                                                                QuoteItem.SBQQ__SpecialPrice__c = $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee * $scope.PP.mapQuotes['T7'].ranges[keyRange].fltWeightAVR * $scope.PP.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                            QuoteItem.PackWeightAVG__c = $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltWeightAVR;
                                                            QuoteItem.PackVolAVG__c = $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltVolAVR;
                                                            QuoteItem.SBQQ__CustomerPrice__c =  $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote / $scope.PP.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                        }
                                                    }
                                                    if ((QuoteItem.SBQQ__Discount__c * -1) > rangeDisc)
                                                        rangeDisc = QuoteItem.SBQQ__Discount__c * -1;
                                                    listQuoteItem.push(QuoteItem);

                                                    if (!arrayTarifas.includes(strFee))
                                                        arrayTarifas += strFee + ' ,';
                                                }
                                                else if($scope.PP.mapQuotes[keyFee].ranges[keyRange].intFrecuency === 0  && $scope.PP.mapQuotes[keyFee].ranges[keyRange].Id)
                                                    listDelete.push($scope.PP.mapQuotes[keyFee].ranges[keyRange].Id);

                                                if(keyFee !== 'T7'){
                                                    if($scope.PPZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency > 0 ){
                                                        Quote.PAQ_TipoServicio__c = 'Estándar terrestre (STD)';
                                                        $scope.PP.blnZP = true;
                                                        var QuoteItemZP = {
                                                            SBQQ__Quantity__c :  $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency
                                                            , SBQQ__Discount__c :  $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltDiscount * 100
                                                            , SBQQ__CustomerPrice__c :  $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee
                                                            , SBQQ__NetPrice__c :  $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltFullFee
                                                            , SBQQ__SpecialPrice__c :  $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltFullFee
                                                            , QuoteTotal__c :  $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote
                                                            , ACK__c :  $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltACK
                                                            , EAD__c :  $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltEAD
                                                            , RAD__c :  $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltRAD
                                                            , SEG__c :  $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg
                                                            , Tarifa__c : strFee
                                                            , Rango_KM__c : strRange
                                                            , ZonaPlus__c : true
                                                            , Pack_Seg__c : $scope.PP.fltSEG
                                                            , SBQQ__VolumeDiscount__c : $scope.PPZP.mapQuotes[keyFee].fltFeeTotalDesc * 100
                                                            , Id : $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].Id
                                                            , SBQQ__Quote__c : Quote.Id
                                                        };
                                                        if ((QuoteItemZP.SBQQ__Discount__c * -1) > rangeDisc)
                                                            rangeDisc = QuoteItemZP.SBQQ__Discount__c * -1;

                                                        listQuoteItem.push(QuoteItemZP);
                                                        if (!arrayTarifas.includes(strFee))
                                                            arrayTarifas += strFee + ' ,';
                                                    }
                                                    else if($scope.PPZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency === 0 && $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].Id)
                                                        listDelete.push($scope.PPZP.mapQuotes[keyFee].ranges[keyRange].Id);
                                                }
                                            }
                                    );
                            }
                    );

                    //STD T7
                    if($scope.PP.mapQuotes['T7'].blnShow){
                        Quote.Tarifa_7__c = true;
                        Quote.TipoCotizacion__c = $scope.PPT7Calc;
                        if($scope.PPT7Calc === 'byDimension')
                            j$.each(
                                    {'T7P':'TARIFA T7-P', 'T7V':'TARIFA T7-V'}
                                    , function (keyFee, strFee) {
                                        j$.each($scope.PP.listRange
                                                , function(keyRange, strRange){
                                                    if($scope.PP.mapQuotes[keyFee].ranges[keyRange].intFrecuency > 0 ){
                                                        Quote.PAQ_TipoServicio__c = 'Estándar terrestre (STD)';
                                                        var QuoteItem = {
                                                            SBQQ__Quantity__c :  $scope.PP.mapQuotes[keyFee].ranges[keyRange].intFrecuency
                                                            , SBQQ__Discount__c :  $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltDiscount * 100
                                                            , SBQQ__CustomerPrice__c :  $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee
                                                            , SBQQ__NetPrice__c :  $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltFullFee
                                                            , QuoteTotal__c :  $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote
                                                            , PackWeightAVG__c : $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltWeightAVR
                                                            , PackVolAVG__c : $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltVolAVR
                                                            , ACK__c :  $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltACK
                                                            , EAD__c :  0
                                                            , RAD__c :  0
                                                            , SEG__c :  $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg
                                                            , Tarifa__c : strFee
                                                            , Rango_KM__c : strRange
                                                            , ZonaPlus__c : false
                                                            , Pack_Seg__c : $scope.PP.fltSEG
                                                            , Id : $scope.PP.mapQuotes[keyFee].ranges[keyRange].Id
                                                            , SBQQ__VolumeDiscount__c : $scope.PP.mapQuotes[keyFee].fltFeeTotalDesc * 100
                                                            , SBQQ__Quote__c : Quote.Id
                                                        };

                                                        if ((QuoteItem.SBQQ__Discount__c * -1) > rangeDisc)
                                                            rangeDisc = QuoteItem.SBQQ__Discount__c * -1;
                                                        listQuoteItem.push(QuoteItem);

                                                        if(keyFee === 'T7V')
                                                            QuoteItem.SBQQ__SpecialPrice__c = $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee * $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltVolAVR;
                                                        if(keyFee === 'T7P')
                                                            QuoteItem.SBQQ__SpecialPrice__c = $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee * $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltWeightAVR;

                                                        if (!arrayTarifas.includes(strFee))
                                                            arrayTarifas += strFee + ' ,';
                                                    }
                                                    else if($scope.PP.mapQuotes[keyFee].ranges[keyRange].intFrecuency === 0 && $scope.PP.mapQuotes[keyFee].ranges[keyRange].Id)
                                                        listDelete.push($scope.PP.mapQuotes[keyFee].ranges[keyRange].Id);

                                                }
                                        );
                                    }
                            );
                    }
                    if($scope.PP.blnZP)
                        Quote.Servicios_adicionales__c += ";EAD Zona plus";
                    Quote.Descuento_por_linea_o_rangokm__c = rangeDisc;

                    //SEG
                    j$.each(
                            $scope.PP.listRange,
                            function(keyRange, strRange){
                                // DS
                                if($scope.PPDS.ranges[keyRange] && $scope.PPDS.ranges[keyRange].intFrecuency > 0){
                                    if(Quote.PAQ_TipoServicio__c == 'Estándar terrestre (STD)')
                                        Quote.PAQ_TipoServicio__c += '; Servicio Express Garantizado (SEG)';
                                    else if(Quote.PAQ_TipoServicio__c == undefined || Quote.PAQ_TipoServicio__c =='')
                                        Quote.PAQ_TipoServicio__c = 'Servicio Express Garantizado (SEG)';
                                   var QuoteItem = {
                                       SBQQ__Quantity__c :  $scope.PPDS.ranges[keyRange].intFrecuency
                                       , SBQQ__Discount__c :  $scope.PPDS.ranges[keyRange].fltDisc * 100
                                       , SBQQ__CustomerPrice__c :  $scope.PPDS.ranges[keyRange].fltQuoteFee
                                       , SBQQ__NetPrice__c :  $scope.PPDS.ranges[keyRange].fltFullFee
                                       , QuoteTotal__c : $scope.PPDS.ranges[keyRange].fltTotalQuote
                                       , Tarifa__c : 'SEG-DS'
                                       , Rango_KM__c : strRange
                                       , Pack_Seg__c : $scope.PP.fltSEG
                                       , Id : $scope.PPDS.ranges[keyRange].Id
                                       , SBQQ__VolumeDiscount__c : $scope.PPDS.intTotalDisc  * 100
                                       , SBQQ__Quote__c : Quote.Id
                                       , Weight__c : $scope.PPDS.ranges[keyRange].fltWeight
                                       , Large__c : $scope.PPDS.ranges[keyRange].fltLarge
                                       , Width__c : $scope.PPDS.ranges[keyRange].fltWidth
                                       , High__c : $scope.PPDS.ranges[keyRange].fltHigh
                                       , VolWeight__c : $scope.PPDS.ranges[keyRange].fltVolWeight
                                       , SEG__c : $scope.PP.fltAmountSEG
                                   };
                                   listQuoteItem.push(QuoteItem);

                                    if ((QuoteItem.SBQQ__Discount__c * -1) > rangeDiscEXP)
                                        rangeDiscEXP = QuoteItem.SBQQ__Discount__c * -1;
                                    if (!arrayTarifas.includes('SEG-DS'))
                                        arrayTarifas += 'SEG-DS' + ' ,';

                                } else if($scope.PPDS.ranges[keyRange].Id)
                                   listDelete.push($scope.PPDS.ranges[keyRange].Id);
                                // 2D
                                if($scope.PP2D.ranges[keyRange] && $scope.PP2D.ranges[keyRange].intFrecuency > 0){
                                    if(Quote.PAQ_TipoServicio__c == 'Estándar terrestre (STD)')
                                        Quote.PAQ_TipoServicio__c += '; Servicio Express Garantizado (SEG)';
                                    else if(Quote.PAQ_TipoServicio__c == undefined || Quote.PAQ_TipoServicio__c =='')
                                        Quote.PAQ_TipoServicio__c = 'Servicio Express Garantizado (SEG)';
                                    var QuoteItem = {
                                        SBQQ__Quantity__c :  $scope.PP2D.ranges[keyRange].intFrecuency
                                        , SBQQ__Discount__c :  $scope.PP2D.ranges[keyRange].fltDisc * 100
                                        , SBQQ__CustomerPrice__c :  $scope.PP2D.ranges[keyRange].fltQuoteFee
                                        , SBQQ__NetPrice__c :  $scope.PP2D.ranges[keyRange].fltFullFee
                                        , QuoteTotal__c : $scope.PP2D.ranges[keyRange].fltTotalQuote
                                        , Tarifa__c : 'SEG-2D'
                                        , Rango_KM__c : strRange
                                        , Pack_Seg__c : $scope.PP.fltSEG
                                        , Id : $scope.PP2D.ranges[keyRange].Id
                                        , SBQQ__VolumeDiscount__c : $scope.PP2D.intTotalDisc  * 100
                                        , SBQQ__Quote__c : Quote.Id
                                        , Weight__c : $scope.PP2D.ranges[keyRange].fltWeight
                                        , Large__c : $scope.PP2D.ranges[keyRange].fltLarge
                                        , Width__c : $scope.PP2D.ranges[keyRange].fltWidth
                                        , High__c : $scope.PP2D.ranges[keyRange].fltHigh
                                        , VolWeight__c : $scope.PP2D.ranges[keyRange].fltVolWeight
                                        , SEG__c : $scope.PP.fltAmountSEG
                                    };
                                    listQuoteItem.push(QuoteItem);

                                    if ((QuoteItem.SBQQ__Discount__c * -1) > rangeDiscEXP)
                                        rangeDiscEXP = QuoteItem.SBQQ__Discount__c * -1;
                                    if (!arrayTarifas.includes('SEG-2D'))
                                        arrayTarifas += 'SEG-2D' + ' ,';

                                } else if($scope.PP2D.ranges[keyRange].Id)
                                    listDelete.push($scope.PP2D.ranges[keyRange].Id);
                                // A12
                                if($scope.PPA12.ranges[keyRange] && $scope.PPA12.ranges[keyRange].intFrecuency > 0){
                                    if(Quote.PAQ_TipoServicio__c == 'Estándar terrestre (STD)')
                                        Quote.PAQ_TipoServicio__c += '; Servicio Express Garantizado (SEG)';
                                    else if(Quote.PAQ_TipoServicio__c == undefined || Quote.PAQ_TipoServicio__c =='')
                                        Quote.PAQ_TipoServicio__c = 'Servicio Express Garantizado (SEG)';
                                    var QuoteItem = {
                                        SBQQ__Quantity__c :  $scope.PPA12.ranges[keyRange].intFrecuency
                                        , SBQQ__Discount__c :  $scope.PPA12.ranges[keyRange].fltDisc * 100
                                        , SBQQ__CustomerPrice__c :  $scope.PPA12.ranges[keyRange].fltQuoteFee
                                        , SBQQ__NetPrice__c :  $scope.PPA12.ranges[keyRange].fltFullFee
                                        , QuoteTotal__c : $scope.PPA12.ranges[keyRange].fltTotalQuote
                                        , Tarifa__c : 'SEG-A12'
                                        , Rango_KM__c : strRange
                                        , Pack_Seg__c : $scope.PP.fltSEG
                                        , Id : $scope.PPA12.ranges[keyRange].Id
                                        , SBQQ__VolumeDiscount__c : $scope.PPA12.intTotalDisc  * 100
                                        , SBQQ__Quote__c : Quote.Id
                                        , Weight__c : $scope.PPA12.ranges[keyRange].fltWeight
                                        , Large__c : $scope.PPA12.ranges[keyRange].fltLarge
                                        , Width__c : $scope.PPA12.ranges[keyRange].fltWidth
                                        , High__c : $scope.PPA12.ranges[keyRange].fltHigh
                                        , VolWeight__c : $scope.PPA12.ranges[keyRange].fltVolWeight
                                        , SEG__c : $scope.PP.fltAmountSEG
                                    };
                                    listQuoteItem.push(QuoteItem);

                                    if ((QuoteItem.SBQQ__Discount__c * -1) > rangeDiscEXP)
                                        rangeDiscEXP = QuoteItem.SBQQ__Discount__c * -1;
                                    if (!arrayTarifas.includes('SEG-A12'))
                                        arrayTarifas += 'SEG-A12' + ' ,';

                                } else if($scope.PPA12.ranges[keyRange].Id)
                                    listDelete.push($scope.PPA12.ranges[keyRange].Id);

                            }
                    );

                    Quote.Descuento_por_linea_o_rango_km_Express__c = rangeDiscEXP;

                    if($scope.Wrapper.objLead && notEmpty($scope.Wrapper.objLead.Id))
                        $scope.Wrapper.objLead.Hay_Cotizacion__c = true;
                    else
                        $scope.Wrapper.objLead = null;

                    if($scope.Wrapper.objOpp && notEmpty($scope.Wrapper.objOpp.Id)){
                        var blnHasQuotePending = false;
                        var blnHasQuoteApproved = false;
                        j$.each(
                                $scope.Wrapper.listPrevQuotes
                                , function (index , quoteOpp) {
                                    if(quoteOpp.SBQQ__Status__c === 'In Review')
                                        blnHasQuotePending = true;
                                    if(quoteOpp.SBQQ__Status__c === 'Approved')
                                        blnHasQuoteApproved = true;
                                }
                        );
                        if(blnHasQuoteApproved)
                            $scope.Wrapper.objOpp.StageName = 'Seguimiento a cierre / revisión de condiciones\n';

                        $scope.Wrapper.objOpp.Hay_Cotizacion__c = true;
                        $scope.Wrapper.objOpp.TarifasIncluidas__c = arrayTarifas;

                        if(blnHasQuotePending)
                            $scope.DML.listErrors.push('Esta oportunidad ya tiene una cotización pendiente de autorización, no es posible crear una nueva en este momento');
                        else if(Quote.Id)
                            if(Quote.SBQQ__Status__c === 'Draft' || Quote.SBQQ__Status__c === 'Rejected' || $scope.isAdmin())
                                callUpdateQuoteConv($scope, Quote,listQuoteItem,  $scope.Wrapper.objLead, $scope.Wrapper.objOpp, listDelete);
                            else
                                $scope.DML.listErrors.push('El Estatus actual de la cotización no permite modificaciones');
                        else
                            callCreateQuoteConv($scope, Quote,listQuoteItem,  $scope.Wrapper.objLead, $scope.Wrapper.objOpp);

                    }
                    else{
                        if(Quote.Id)
                            if(Quote.SBQQ__Status__c === 'Draft' || Quote.SBQQ__Status__c === 'Rejected' || $scope.isAdmin())
                                callUpdateQuoteConv($scope, Quote,listQuoteItem,  $scope.Wrapper.objLead, null, listDelete);
                            else
                                $scope.DML.listErrors.push('El Estatus actual de la cotización no permite modificaciones');
                        else
                            callCreateQuoteConv($scope, Quote,listQuoteItem,  $scope.Wrapper.objLead, null);
                    }
                };

                $scope.clickFee = function(index, strType){
                    switch (strType) {
                        case 'feeAdd':
                            $scope.PP.FeeSelect.available[index].blnSelected = !$scope.PP.FeeSelect.available[index].blnSelected;
                            break;
                        case 'feeRemove':
                            $scope.PP.FeeSelect.selected[index].blnSelected = !$scope.PP.FeeSelect.selected[index].blnSelected;
                            break;
                        case 'serviceAdd':
                            $scope.PP.ServiceSelect.available[index].blnSelected = !$scope.PP.ServiceSelect.available[index].blnSelected;
                            break;
                        case 'serviceRemove':
                            $scope.PP.ServiceSelect.selected[index].blnSelected = !$scope.PP.ServiceSelect.selected[index].blnSelected;
                            break;


                    }

                };

                $scope.desc = function(fltNum, descNum){
                    var num = fltNum - (fltNum * (descNum / 100));
                    return parseFloat(parseFloat(num).toFixed(2));
                };

                $scope.exceptionAD = function(strFeeKey){
                    return strFeeKey === 'TS';
                };

                $scope.getProjection = function(keyRange, intFreq){
                    var FeeP = 0;
                    var FeeV = 0;

                    FeeP = intFreq * $scope.PP.mapTotal[keyRange].fltWeightAVR * $scope.Wrapper.mapTarifarioT['TARIFA T7P'][$scope.PP.listRange[keyRange]].Flete__c;
                    FeeV = intFreq * $scope.PP.mapTotal[keyRange].fltVolAVR * $scope.Wrapper.mapTarifarioT['TARIFA T7V'][$scope.PP.listRange[keyRange]].Flete__c;

                    if(FeeP > FeeV){
                        $scope.Projection['T7'].ranges[keyRange].fltAmount = FeeP;
                        //$scope.ProjectionZP['T7'].ranges[keyRange].fltAmount = FeeP;
                    } else{
                        $scope.Projection['T7'].ranges[keyRange].fltAmount = FeeV;
                        //$scope.ProjectionZP['T7'].ranges[keyRange].fltAmount = FeeV;
                    }

                    $scope.Projection['TARIFA T7P'].ranges[keyRange].fltAmount = FeeP;
                    $scope.Projection['TARIFA T7V'].ranges[keyRange].fltAmount = FeeV;


                    $scope.Projection['TARIFA T7P'].fltTotalByFee += $scope.Projection['TARIFA T7P'].ranges[keyRange].fltAmount;
                    $scope.Projection['TARIFA T7V'].fltTotalByFee += $scope.Projection['TARIFA T7V'].ranges[keyRange].fltAmount;

                };

                $scope.getTarifaKey = function(strKey){
                    if (strKey === 'T7')
                        return 'TARIFA T7P';
                    else
                        return 'TARIFA '+strKey;
                };

                $scope.isException = function(objQuote, strProfile){
                    var exception = false;
                    if(objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')) {
                        if (objQuote.SBQQ__Opportunity2__c && strProfile === 'Ejecutivo de venta') {
                            if (objQuote.Descuento_por_linea_o_rangokm__c <= 60
                                    && objQuote.Descuento_Global__c < 10.01)
                                exception = true;
                        } else if (objQuote.SBQQ__Opportunity2__c && strProfile === 'Gerente de sucursal') {
                            if (objQuote.Descuento_por_linea_o_rangokm__c <= 60
                                    && objQuote.Descuento_Global__c < 25.01)
                                exception = true;
                        } else if (objQuote.Lead__c && strProfile === 'Gerente de sucursal') {
                            if (objQuote.Descuento_por_linea_o_rangokm__c >= 60.01
                                    && objQuote.Descuento_Global__c < 25.01)
                                exception = true;    
                        } else if (strProfile === 'KAM Regional') {
                            if (objQuote.Descuento_por_linea_o_rangokm__c <= 60
                                    && objQuote.Descuento_Global__c < 40.01)
                                exception = true;
                        } else if (strProfile === 'Gerentes de desarrollo de Negocios') {
                            if (objQuote.Descuento_Global__c < 60.01)
                                exception = true;
                        } else if (strProfile === 'Director comercial') {
                            exception = true;
                        }
                    }
                    else
                        exception = true;
                    if(exception && objQuote.PAQ_TipoServicio__c.includes('Servicio Express Garantizado (SEG)')){
                        exception = false;
                        if (objQuote.SBQQ__Opportunity2__c && strProfile === 'Ejecutivo de venta') {
                            if (objQuote.Descuento_por_linea_o_rango_km_Express__c <= 25
                                    && objQuote.Descuento_Global_Express__c <= 10)
                                exception = true;
                        } else if (objQuote.SBQQ__Opportunity2__c && strProfile === 'Gerente de sucursal') {
                            if (objQuote.Descuento_por_linea_o_rango_km_Express__c <= 25
                                    && objQuote.Descuento_Global_Express__c <= 25)
                                exception = true;
                        } else if (objQuote.Lead__c && strProfile === 'Gerente de sucursal') {
                            if (objQuote.Descuento_por_linea_o_rango_km_Express__c >= 25.01
                                    && objQuote.Descuento_Global_Express__c <= 25)
                                exception = true;
                        } else if (strProfile === 'KAM Regional') {
                            if (objQuote.Descuento_por_linea_o_rango_km_Express__c <= 25
                                    && objQuote.Descuento_Global_Express__c <= 25)
                                exception = true;
                        } else if (strProfile === 'Gerentes de desarrollo de Negocios') {
                            if (objQuote.Descuento_Global_Express__c <= 25)
                                exception = true;
                        } else if (strProfile === 'Director comercial') {
                            exception = true;
                        }
                    }
                    return exception;
                };

                $scope.isSelected = function (fee){
                    var blnSelected = false;
                    if(getModel(fee, $scope.PP.FeeSelect.selected))
                        blnSelected = true;
                    return blnSelected;
                };

                $scope.nextPP = function(){
                    $scope.PPstep1 = false;
                    $scope.PPstep2 = true;
                    $scope.ODCstep1 = false;
                    $scope.ODCstep2 = true;
                };

                $scope.quickDisc = function(strName){
                    switch (strName) {
                        case 'GENCOST':
                            $scope.PP.fltGENDisc = 0;
                            j$.each($scope.PP.listFee, function (keyFee, strFee) {
                                $scope.PP.mapQuotes[keyFee].fltCost = 0;
                            });
                            j$.each($scope.PP.listRange, function (keyRange, strRange) {
                                $scope.PP.mapRanges[keyRange].fltCost = 0;
                            });
                            $scope.PP.mapQuotes['DS'].fltCost = 0;
                            $scope.PP.mapQuotes['2D'].fltCost = 0;
                            $scope.PP.mapQuotes['A12'].fltCost = 0;
                            break;
                        case 'GENDISC':
                            $scope.PP.fltGENCost = 0;
                            j$.each($scope.PP.listFee, function (keyFee, strFee) {
                                $scope.PP.mapQuotes[keyFee].fltCost = 0;
                            });
                            j$.each($scope.PP.listRange, function (keyRange, strRange) {
                                $scope.PP.mapRanges[keyRange].fltCost = 0;
                            });
                            $scope.PP.mapQuotes['DS'].fltCost = 0;
                            $scope.PP.mapQuotes['2D'].fltCost = 0;
                            $scope.PP.mapQuotes['A12'].fltCost = 0;
                            break;
                        case 'FEECOST':
                            $scope.PP.fltGENCost = 0;
                            $scope.PP.fltGENDisc = 0;
                            j$.each($scope.PP.listRange, function (keyRange, strRange) {
                                $scope.PP.mapRanges[keyRange].fltCost = 0;
                            });
                            break;
                        case 'RANGECOST':
                            $scope.PP.fltGENCost = 0;
                            $scope.PP.fltGENDisc = 0;
                            j$.each($scope.PP.listFee, function (keyFee, strFee) {
                                $scope.PP.mapQuotes[keyFee].fltCost = 0;
                            });
                            $scope.PP.mapQuotes['DS'].fltCost = 0;
                            $scope.PP.mapQuotes['2D'].fltCost = 0;
                            $scope.PP.mapQuotes['A12'].fltCost = 0;
                            break;
                    }
                    $scope.calculateEXP();
                };

                $scope.removeFee = function(fee){
                    var index =  j$.inArray(fee, $scope.PP.FeeSelect.selected);
                    $scope.PP.FeeSelect.selected.splice(index, 1);
                    $scope.PP.FeeSelect.available.push(fee);
                    switch (fee.id) {
                        case 'DS' :
                            $scope.PPDS.blnShow = false;
                            $scope.PPDS = {
                                ranges : {}
                                , blnSameWeight : false
                                , blnSameLarge : false
                                , blnSameWidth : false
                                , blnSameHigh : false
                                , blnShow : false
                                , blnSameFrec : false
                                , blnSameQuote : false
                                , intTotalQ :0
                                , intTotalFull: 0
                                , intTotalQuote : 0
                                , intTotalDisc : 0
                                , fltSegAmount : 0
                            };
                            j$.each(
                                    $scope.PP.listRange,
                                    function(keyRange, strRange){
                                        $scope.PPDS.ranges[keyRange] = {
                                            intFrecuency : 0
                                            , fltFrecuency :0
                                            , fltWeight:0
                                            , fltVol:0
                                            , fltVolWeight:0
                                            , fltDominantWeight:0
                                            , fltLarge:0
                                            , fltHigh:0
                                            , fltWidth:0
                                            , fltAmount:0
                                            , fltFullFee : 0
                                            , fltTotalFull : 0
                                            , fltQuoteFee : 0
                                            , fltTotalQuote : 0
                                            , fltDisc : 0
                                        };
                                    }
                            );
                            break;
                        case '2D':
                            $scope.PP2D.blnShow = false;
                            $scope.PP2D = {
                                ranges : {}
                                , blnSameWeight : false
                                , blnSameLarge : false
                                , blnSameWidth : false
                                , blnSameHigh : false
                                , blnShow : false
                                , blnSameFrec : false
                                , blnSameQuote : false
                                , intTotalQ : 0
                                , intTotalFull : 0
                                , intTotalDisc : 0
                                , intTotalQuote : 0
                                , fltSegAmount : 0
                            };
                            j$.each(
                                    $scope.PP.listRange,
                                    function(keyRange, strRange){
                                        $scope.PP2D.ranges[keyRange] = {
                                            intFrecuency : 0
                                            , fltFrecuency :0
                                            , fltWeight:0
                                            , fltVol:0
                                            , fltVolWeight:0
                                            , fltDominantWeight:0
                                            , fltLarge:0
                                            , fltHigh:0
                                            , fltWidth:0
                                            , fltAmount:0
                                            , fltFullFee : 0
                                            , fltTotalFull : 0
                                            , fltQuoteFee : 0
                                            , fltTotalQuote : 0
                                            , fltDisc : 0
                                        };
                                    }
                            );
                            break;
                        case 'A12':
                            $scope.PPA12.blnShow = false;
                            $scope.PPA12 = {
                                ranges : {}
                                , blnSameWeight : false
                                , blnSameLarge : false
                                , blnSameWidth : false
                                , blnSameHigh : false
                                , blnShow : false
                                , blnSameFrec : false
                                , blnSameQuote : false
                                , intTotalQ : 0
                                , intTotalFull : 0
                                , intTotalDisc : 0
                                , intTotalQuote : 0
                                , fltSegAmount : 0
                            };
                            j$.each(
                                    $scope.PP.listRange,
                                    function(keyRange, strRange){
                                        $scope.PPA12.ranges[keyRange] = {
                                            intFrecuency : 0
                                            , fltFrecuency :0
                                            , fltWeight:0
                                            , fltVol:0
                                            , fltVolWeight:0
                                            , fltDominantWeight:0
                                            , fltLarge:0
                                            , fltHigh:0
                                            , fltWidth:0
                                            , fltAmount:0
                                            , fltFullFee : 0
                                            , fltTotalFull : 0
                                            , fltQuoteFee : 0
                                            , fltTotalQuote : 0
                                            , fltDisc : 0
                                        };
                                    }
                            );
                            break;
                        default :
                            $scope.PP.mapQuotes[fee.id].blnShow = false;
                            break;
                    }
                    $scope.PP.FeeSelect.available.sort(function (a, b) {
                        if (a.order > b.order) {
                            return 1;
                        }
                        if (a.order < b.order) {
                            return -1;
                        }
                        // a must be equal to b
                        return 0;
                    });
                    if(notEmpty(fee.id) && fee.id != 'DS' && fee.id != '2D' && fee.id != 'A12'){
                        $scope.PP.mapQuotes[fee.id].blnShow = false;
                        $scope.PP.mapQuotes[fee.id] = {
                            ranges : []
                            , intFeeTotalFrec : 0
                            , fltFeeTotalDesc : 0
                            , fltFeeTotalNormal : 0
                            , fltFeeTotalQuote : 0
                            , blnShow : false
                        };
                        if(fee.id !== 'T7')
                            $scope.PPZP.mapQuotes[fee.id] = {
                                ranges : []
                                , intFeeTotalFrec : 0
                                , fltFeeTotalDesc : 0
                                , fltFeeTotalNormal : 0
                                , fltFeeTotalQuote : 0
                                , blnShow : false
                            };
                        else{
                            $scope.PPT7Calc = '';
                            $scope.PP.mapQuotes['T7V'] = {
                                ranges : []
                                , intFeeTotalQ : 0
                                , fltFeeTotalFrec:0
                                , blnShow: false
                                , blnSameFrecuency : false
                                , blnSameQuote : false
                                , blnSameVolAVR : false
                            };
                            $scope.PP.mapQuotes['T7P'] = {
                                ranges : []
                                , intFeeTotalQ : 0
                                , fltFeeTotalFrec:0
                                , blnShow: false
                                , blnSameFrecuency : false
                                , blnSameQuote : false
                                , blnSameWeigthAVR: false
                            };
                        }
                        j$.each(
                                $scope.PP.listRange
                                , function(keyRange, strRange) {
                                    if(fee.id !== 'T7'){
                                        $scope.PP.mapQuotes[fee.id].ranges[keyRange] = {
                                            fltSeg : 0
                                            , fltFullFee : 0
                                            , fltNormalFee : 0
                                            , fltTotalQuote : 0
                                            , fltDiscount : 0
                                            , intFrecuency : 0
                                            , fltQuoteFee : 0
                                            , fltAmountSeg : 0
                                            , fltEAD: dominantFeeServiceDom($scope.Wrapper.mapCS['MinEAD'], $scope.Wrapper.mapTarifarioT['TARIFA ' + fee.id][strRange].Flete__c)
                                            , fltRAD : dominantFeeServiceDom($scope.Wrapper.mapCS['MinRAD'], $scope.Wrapper.mapTarifarioT['TARIFA ' + fee.id][strRange].Flete__c)
                                            , fltAmount : $scope.Wrapper.mapTarifarioT['TARIFA ' + fee.id][strRange].Flete__c
                                            , fltACK : 0
                                        };
                                        $scope.PPZP.mapQuotes[fee.id].ranges[keyRange] = {
                                            fltSeg : 0
                                            , fltFullFee : 0
                                            , fltNormalFee : 0
                                            , fltTotalQuote : 0
                                            , fltDiscount : 0
                                            , intFrecuency : 0
                                            , fltQuoteFee : 0
                                            , fltAmountSeg : 0
                                            , fltEAD: $scope.Wrapper.mapCS['EAZP']
                                            , fltRAD : dominantFeeServiceDom($scope.Wrapper.mapCS['MinRAD'], $scope.Wrapper.mapTarifarioT['TARIFA ' + fee.id][strRange].Flete__c)
                                            , fltAmount : $scope.Wrapper.mapTarifarioT['TARIFA ' + fee.id][strRange].Flete__c
                                            , fltACK : 0
                                        };
                                    } else{
                                        $scope.PP.mapQuotes['T7'].ranges[keyRange] = {
                                            fltSeg : 0
                                            , fltFullFee : 0
                                            , fltNormalFee : 0
                                            , fltTotalQuote : 0
                                            , fltDiscount : 0
                                            , intFrecuency : 0
                                            , fltQuoteFee : 0
                                            , fltAmountSeg : 0
                                            , fltEAD: dominantFeeServiceDom($scope.Wrapper.mapCS['MinEAD'], $scope.Wrapper.mapTarifarioT['TARIFA T7P'][strRange].Flete__c)
                                            , fltRAD : dominantFeeServiceDom($scope.Wrapper.mapCS['MinRAD'], $scope.Wrapper.mapTarifarioT['TARIFA T7P'][strRange].Flete__c)
                                            , fltAmount : $scope.Wrapper.mapTarifarioT['TARIFA T7P'][strRange].Flete__c
                                            , fltACK : 0
                                            , fltVolAVR : 1
                                            , fltWeightAVR : 1
                                        };
                                        $scope.PP.mapQuotes['T7V'].ranges[keyRange] = {
                                            fltSeg : 0
                                            , fltFullFee : 0
                                            , fltNormalFee : 0
                                            , fltTotalQuote : 0
                                            , fltDiscount : 0
                                            , intFrecuency : 0
                                            , fltQuoteFee : 0
                                            , fltAmountSeg : 0
                                            , fltEAD: dominantFeeServiceDom($scope.Wrapper.mapCS['MinEAD'], $scope.Wrapper.mapTarifarioT['TARIFA T7V'][strRange].Flete__c)
                                            , fltRAD : dominantFeeServiceDom($scope.Wrapper.mapCS['MinRAD'], $scope.Wrapper.mapTarifarioT['TARIFA T7V'][strRange].Flete__c)
                                            , fltAmount : $scope.Wrapper.mapTarifarioT['TARIFA T7V'][strRange].Flete__c
                                            , fltACK : 0
                                            , fltVolAVR : 1
                                            , fltWeightAVR : 1
                                        };
                                        $scope.PP.mapQuotes['T7P'].ranges[keyRange] = {
                                            fltSeg : 0
                                            , fltFullFee : 0
                                            , fltNormalFee : 0
                                            , fltTotalQuote : 0
                                            , fltDiscount : 0
                                            , intFrecuency : 0
                                            , fltQuoteFee : 0
                                            , fltAmountSeg : 0
                                            , fltEAD: dominantFeeServiceDom($scope.Wrapper.mapCS['MinEAD'], $scope.Wrapper.mapTarifarioT['TARIFA T7P'][strRange].Flete__c)
                                            , fltRAD : dominantFeeServiceDom($scope.Wrapper.mapCS['MinRAD'], $scope.Wrapper.mapTarifarioT['TARIFA T7P'][strRange].Flete__c)
                                            , fltAmount : $scope.Wrapper.mapTarifarioT['TARIFA T7P'][strRange].Flete__c
                                            , fltACK : 0
                                            , fltVolAVR : 1
                                            , fltWeightAVR : 1
                                        };
                                    }
                                });
                    }
                    $scope.calculateEXP();

                };

                $scope.removeService = function(service){
                    var index =  j$.inArray(service, $scope.PP.ServiceSelect.selected);
                    $scope.PP.ServiceSelect.selected.splice(index, 1);
                    $scope.PP.ServiceSelect.available.push(service);
                    switch (service.id) {
                        case 'EAD':
                            $scope.PP.blnEAD = false;
                            break;
                        case 'RAD':
                            $scope.PP.blnRAD = false;
                            break;
                        case 'SEG':
                            $scope.PP.blnSEG = false;
                            break;
                        case 'ACK':
                            $scope.PP.blnACK = false;
                            $scope.PP.strAck = '';
                            break;
                        case 'MAN':
                            $scope.PP.blnMAN = false;
                            $scope.fetchSS('MAN', false);
                            break;
                        case 'EDD':
                            $scope.PP.blnEDD = false;
                            $scope.fetchSS('EDD', false);
                            break;
                        case 'EDC':
                            $scope.PP.blnEDC = false;
                            $scope.fetchSS('EDC', false);
                            break;
                        case 'CRF':
                            $scope.PP.blnCRF = false;
                            $scope.fetchSS('CRF', false);
                            break;
                    }
                };

                $scope.replicate = function(field, num, key, fee){
                    switch (field) {
                        case 'Quantity':
                            if($scope.PP.mapQuotes[key].blnSameFrecuency)
                                j$.each(
                                        $scope.PP.listRange
                                        , function (keyRange, strRange) {
                                            $scope.PP.mapQuotes[key].ranges[keyRange].intFrecuency = num;
                                            if(key === 'T7' || key === 'T7V' || key === 'T7P'){
                                                $scope.PP.mapQuotes['T7'].ranges[keyRange].intFrecuency = num;
                                                $scope.PP.mapQuotes['T7P'].ranges[keyRange].intFrecuency = num;
                                                $scope.PP.mapQuotes['T7V'].ranges[keyRange].intFrecuency = num;
                                            }
                                        }
                                );
                            break;
                        case 'QuantityZP':
                            if($scope.PPZP.mapQuotes[key].blnSameFrecuency)
                                j$.each(
                                        $scope.PP.listRange
                                        , function (keyRange, strRange) {
                                            $scope.PPZP.mapQuotes[key].ranges[keyRange].intFrecuency = num;
                                        }
                                );
                            break;
                        case 'Quote':
                            if($scope.PP.mapQuotes[key].blnSameQuote)
                                j$.each(
                                        $scope.PP.listRange
                                        , function (keyRange, strRange) {
                                            $scope.PP.mapQuotes[key].ranges[keyRange].fltQuoteFee = num;
                                        }
                                );
                            break;
                        case 'QuoteZP':
                            if($scope.PPZP.mapQuotes[key].blnSameQuote)
                                j$.each(
                                        $scope.PP.listRange
                                        , function (keyRange, strRange) {
                                            $scope.PPZP.mapQuotes[key].ranges[keyRange].fltQuoteFee = num;
                                        }
                                );
                            break;
                        case 'VolAVR':
                            if($scope.PP.mapQuotes[key].blnSameVolAVR)
                                j$.each(
                                        $scope.PP.listRange
                                        , function (keyRange, strRange) {
                                            $scope.PP.mapQuotes[key].ranges[keyRange].fltVolAVR = num;
                                        }
                                );
                            break;
                        case 'WeigthAVR':
                            if($scope.PP.mapQuotes[key].blnSameWeigthAVR)
                                j$.each(
                                        $scope.PP.listRange
                                        , function (keyRange, strRange) {
                                            $scope.PP.mapQuotes[key].ranges[keyRange].fltWeightAVR = num;
                                        }
                                );
                            break;
                        case 'fltWeight':
                            var fltWeight = 0;
                            if($scope.PPDS.blnSameWeight || $scope.PP2D.blnSameWeight || $scope.PPA12.blnSameWeight)
                                j$.each($scope.PP.listRange
                                        , function (keyRange, strRange) {
                                            if(fee === 'DS' && fltWeight == 0)
                                                fltWeight = $scope.PPDS.ranges[keyRange].fltWeight;
                                            else if(fee === 'DS' && $scope.PPDS.blnSameWeight)
                                                $scope.PPDS.ranges[keyRange].fltWeight = fltWeight;

                                            if(fee === '2D' && fltWeight == 0)
                                                fltWeight = $scope.PP2D.ranges[keyRange].fltWeight;
                                            else if(fee === '2D' && $scope.PP2D.blnSameWeight)
                                                $scope.PP2D.ranges[keyRange].fltWeight = fltWeight;

                                            if(fee === 'A12' && fltWeight == 0)
                                                fltWeight = $scope.PPA12.ranges[keyRange].fltWeight;
                                            else if(fee === 'A12' && $scope.PPA12.blnSameWeight)
                                                $scope.PPA12.ranges[keyRange].fltWeight = fltWeight;

                                            $scope.calculateDimensionsPP(fee, keyRange);
                                        }
                                );

                            break;
                        case 'fltLarge':
                            var fltLarge = 0;
                            if($scope.PPDS.blnSameLarge || $scope.PP2D.blnSameLarge || $scope.PPA12.blnSameLarge)
                                j$.each($scope.PP.listRange
                                        , function (keyRange, strRange) {
                                            if(fee === 'DS' && fltLarge == 0)
                                                fltLarge = $scope.PPDS.ranges[keyRange].fltLarge;
                                            else if(fee === 'DS' && $scope.PPDS.blnSameLarge)
                                                $scope.PPDS.ranges[keyRange].fltLarge = fltLarge;

                                            if(fee === '2D' && fltLarge == 0)
                                                fltLarge = $scope.PP2D.ranges[keyRange].fltLarge;
                                            else if(fee === '2D' && $scope.PP2D.blnSameLarge)
                                                $scope.PP2D.ranges[keyRange].fltLarge = fltLarge;

                                            if(fee === 'A12' && fltLarge == 0)
                                                fltLarge = $scope.PPA12.ranges[keyRange].fltLarge;
                                            else if(fee === 'A12' && $scope.PPA12.blnSameLarge)
                                                $scope.PPA12.ranges[keyRange].fltLarge = fltLarge;

                                            $scope.calculateDimensionsPP(fee, keyRange);
                                        }
                                );
                            break;
                        case 'fltWidth':
                            var fltWidth = 0;
                            if($scope.PPDS.blnSameWidth || $scope.PP2D.blnSameWidth || $scope.PPA12.blnSameWidth)
                                j$.each($scope.PP.listRange
                                        , function (keyRange, strRange) {
                                            if(fee === 'DS' && fltWidth == 0)
                                                fltWidth = $scope.PPDS.ranges[keyRange].fltWidth;
                                            else if(fee === 'DS' && $scope.PPDS.blnSameWidth)
                                                $scope.PPDS.ranges[keyRange].fltWidth = fltWidth;

                                            if(fee === '2D' && fltWidth == 0)
                                                fltWidth = $scope.PP2D.ranges[keyRange].fltWidth;
                                            else if(fee === '2D' && $scope.PP2D.blnSameWidth)
                                                $scope.PP2D.ranges[keyRange].fltWidth = fltWidth;

                                            if(fee === 'A12' && fltWidth == 0)
                                                fltWidth = $scope.PPA12.ranges[keyRange].fltWidth;
                                            else if(fee === 'A12' && $scope.PPA12.blnSameWidth)
                                                $scope.PPA12.ranges[keyRange].fltWidth = fltWidth;

                                            $scope.calculateDimensionsPP(fee, keyRange);
                                        }
                                );
                            break;
                        case 'fltHigh':
                            var fltHigh = 0;
                            if($scope.PPDS.blnSameHigh || $scope.PP2D.blnSameHigh || $scope.PPA12.blnSameHigh)
                                j$.each($scope.PP.listRange
                                        , function (keyRange, strRange) {
                                            if(fee === 'DS' && fltHigh == 0)
                                                fltHigh = $scope.PPDS.ranges[keyRange].fltHigh;
                                            else if(fee === 'DS' && $scope.PPDS.blnSameHigh)
                                                $scope.PPDS.ranges[keyRange].fltHigh = fltHigh;

                                            if(fee === '2D' && fltHigh == 0)
                                                fltHigh = $scope.PP2D.ranges[keyRange].fltHigh;
                                            else if(fee === '2D' && $scope.PP2D.blnSameHigh)
                                                $scope.PP2D.ranges[keyRange].fltHigh = fltHigh;

                                            if(fee === 'A12' && fltHigh == 0)
                                                fltHigh = $scope.PPA12.ranges[keyRange].fltHigh;
                                            else if(fee === 'A12' && $scope.PPA12.blnSameHigh)
                                                $scope.PPA12.ranges[keyRange].fltHigh = fltHigh;

                                            $scope.calculateDimensionsPP(fee, keyRange);
                                        }
                                );
                            break;
                        case 'intFrecc':
                            var intFrecc = 0;
                            if($scope.PPDS.blnSameFrec || $scope.PP2D.blnSameFrec || $scope.PPA12.blnSameFrec)
                                j$.each($scope.PP.listRange
                                        , function (keyRange, strRange) {
                                            if(fee === 'DS' && intFrecc == 0)
                                                intFrecc = $scope.PPDS.ranges[keyRange].intFrecuency;
                                            else if(fee === 'DS' && $scope.PPDS.blnSameFrec)
                                                $scope.PPDS.ranges[keyRange].intFrecuency = intFrecc;

                                            if(fee === '2D' && intFrecc == 0)
                                                intFrecc = $scope.PP2D.ranges[keyRange].intFrecuency;
                                            else if(fee === '2D' && $scope.PP2D.blnSameFrec)
                                                $scope.PP2D.ranges[keyRange].intFrecuency = intFrecc;

                                            if(fee === 'A12' && intFrecc == 0)
                                                intFrecc = $scope.PPA12.ranges[keyRange].intFrecuency;
                                            else if(fee === 'A12' && $scope.PPA12.blnSameFrec)
                                                $scope.PPA12.ranges[keyRange].intFrecuency = intFrecc;

                                            $scope.calculateDimensionsPP(fee, keyRange);
                                        }
                                );
                            break;
                        case 'fltQuote':
                            var fltQuote = 0;
                            if($scope.PPDS.blnSameQuote || $scope.PP2D.blnSameQuote || $scope.PPA12.blnSameQuote)
                                j$.each($scope.PP.listRange
                                        , function (keyRange, strRange) {
                                            if(fee === 'DS' && fltQuote == 0)
                                                fltQuote = $scope.PPDS.ranges[keyRange].fltQuoteFee;
                                            else if(fee === 'DS' && $scope.PPDS.blnSameQuote)
                                                $scope.PPDS.ranges[keyRange].fltQuoteFee = fltQuote;

                                            if(fee === '2D' && fltQuote == 0)
                                                fltQuote = $scope.PP2D.ranges[keyRange].fltQuoteFee;
                                            else if(fee === '2D' && $scope.PP2D.blnSameQuote)
                                                $scope.PP2D.ranges[keyRange].fltQuoteFee = fltQuote;

                                            if(fee === 'A12' && fltQuote == 0)
                                                fltQuote = $scope.PPA12.ranges[keyRange].fltQuoteFee;
                                            else if(fee === 'A12' && $scope.PPA12.blnSameQuote)
                                                $scope.PPA12.ranges[keyRange].fltQuoteFee = fltQuote;

                                            $scope.calculatePPEXP(fee, keyRange);
                                        }
                                );
                            break;
                    }
                    $scope.calculateEXP();
                };

                $scope.resetPP  = function(strName){
                    switch (strName) {
                        case 'ZP':
                            $scope.PPZP.intTotalQ = 0;
                            j$.each($scope.PP.listRange
                                    , function (key, str) {
                                        $scope.PPZP.mapTotal[key].intRanTotal = 0;
                                        $scope.PPZP.mapTotal[key].fltRanTotalFrec = 0;
                                    });
                            j$.each($scope.PP.listFee
                                    , function (key, strKey) {
                                        $scope.PPZP.mapQuotes[key].intFeeTotalQ = 0;
                                        $scope.PPZP.mapQuotes[key].fltFeeTotalFrec = 0;
                                    });
                            break;
                        default:
                            $scope.PP.intTotalQ = 0;
                            j$.each($scope.PP.listRange
                                    , function (key, str) {
                                        $scope.PP.mapTotal[key].intRanTotal = 0;
                                        $scope.PP.mapTotal[key].fltRanTotalFrec = 0;
                                    });
                            j$.each($scope.PP.listFee
                                    , function (key, strKey) {
                                        $scope.PP.mapQuotes[key].intFeeTotalQ = 0;
                                        $scope.PP.mapQuotes[key].fltFeeTotalFrec = 0;
                                    });
                            break;
                    }


                };

                $scope.setValue = function(name, key, cmp, keyX, fee) {
                    if (notEmpty(cmp.target.textContent))
                        switch (name) {
                            case 'PPintFrecuency':
                                $scope.PP.mapQuotes[keyX].ranges[key].intFrecuency = getNum(cmp.target.textContent);
                                if (keyX === 'T7' || keyX === 'T7V' || keyX === 'T7P') {
                                    $scope.PP.mapQuotes['T7'].ranges[key].intFrecuency = getNum(cmp.target.textContent);
                                    $scope.PP.mapQuotes['T7P'].ranges[key].intFrecuency = getNum(cmp.target.textContent);
                                    $scope.PP.mapQuotes['T7V'].ranges[key].intFrecuency = getNum(cmp.target.textContent);
                                }
                                $scope.calculateEXP();
                                break;
                            case 'PPfltQuoteFee':
                                $scope.PP.mapQuotes[keyX].ranges[key].fltQuoteFee = getNumFromCurrency(cmp.target.textContent);
                                $scope.calculateEXP();
                                break;
                            case 'PPfltVolAVR':
                                $scope.PP.mapQuotes[keyX].ranges[key].fltVolAVR = getNum(cmp.target.textContent);
                                $scope.calculateEXP();
                                break;
                            case 'PPfltWeightAVR':
                                $scope.PP.mapQuotes[keyX].ranges[key].fltWeightAVR = getNum(cmp.target.textContent);
                                $scope.calculateEXP();
                                break;
                            case 'PPintFrecuencyZP':
                                $scope.PPZP.mapQuotes[keyX].ranges[key].intFrecuency = getNum(cmp.target.textContent);
                                $scope.calculateEXP();
                                break;
                            case 'PPfltQuoteFeeZP':
                                $scope.PPZP.mapQuotes[keyX].ranges[key].fltQuoteFee = getNumFromCurrency(cmp.target.textContent);
                                $scope.calculateEXP();
                                break;
                            case 'fltEAD':
                                $scope.PP.mapQuotes[keyX].ranges[key].fltEAD = getNum(cmp.target.textContent);
                                $scope.calculateEXP();
                                break;
                            case 'fltRAD':
                                $scope.PP.mapQuotes[keyX].ranges[key].fltRAD = getNum(cmp.target.textContent);
                                $scope.calculateEXP();
                                break;
                            case 'fltACK':
                                $scope.PP.mapQuotes[keyX].ranges[key].fltACK = getNum(cmp.target.textContent);
                                $scope.calculateEXP();
                                break;
                            case 'intFrecc':
                                if (fee === 'DS'){
                                    $scope.PPDS.ranges[key].intFrecuency = getNum(cmp.target.textContent);
                                    $scope.PPDS.intTotalQ += $scope.PPDS.ranges[key].intFrecuency;
                                }
                                if (fee === '2D'){
                                    $scope.PP2D.ranges[key].intFrecuency = getNum(cmp.target.textContent);
                                    $scope.PP2D.intTotalQ += $scope.PP2D.ranges[key].intFrecuency;
                                }
                                if (fee === 'A12'){
                                    $scope.PPA12.ranges[key].intFrecuency = getNum(cmp.target.textContent);
                                    $scope.PPA12.intTotalQ += $scope.PPA12.ranges[key].intFrecuency;
                                }
                                $scope.calculateEXP();
                                break;
                            case 'fltWeight':
                                if (fee === 'DS')
                                    $scope.PPDS.ranges[key].fltWeight = getNum(cmp.target.textContent);
                                if (fee === '2D')
                                    $scope.PP2D.ranges[key].fltWeight = getNum(cmp.target.textContent);
                                if (fee === 'A12')
                                    $scope.PPA12.ranges[key].fltWeight = getNum(cmp.target.textContent);
                                $scope.calculateDimensionsPP(fee, key);
                                break;
                            case 'fltLarge':
                                if (fee === 'DS')
                                    $scope.PPDS.ranges[key].fltLarge = getNum(cmp.target.textContent);
                                if (fee === '2D')
                                    $scope.PP2D.ranges[key].fltLarge = getNum(cmp.target.textContent);
                                if (fee === 'A12')
                                    $scope.PPA12.ranges[key].fltLarge = getNum(cmp.target.textContent);
                                $scope.calculateDimensionsPP(fee, key);
                                break;
                            case 'fltWidth':
                                if (fee === 'DS')
                                    $scope.PPDS.ranges[key].fltWidth = getNum(cmp.target.textContent);
                                if (fee === '2D')
                                    $scope.PP2D.ranges[key].fltWidth = getNum(cmp.target.textContent);
                                if (fee === 'A12')
                                    $scope.PPA12.ranges[key].fltWidth = getNum(cmp.target.textContent);
                                $scope.calculateDimensionsPP(fee, key);
                                break;
                            case 'fltHigh':
                                if (fee === 'DS')
                                    $scope.PPDS.ranges[key].fltHigh = getNum(cmp.target.textContent);
                                if (fee === '2D')
                                    $scope.PP2D.ranges[key].fltHigh = getNum(cmp.target.textContent);
                                if (fee === 'A12')
                                    $scope.PPA12.ranges[key].fltHigh = getNum(cmp.target.textContent);
                                $scope.calculateDimensionsPP(fee, key);
                                break;
                            case 'fltQuote':
                                if (fee === 'DS')
                                    $scope.PPDS.ranges[key].fltQuoteFee = getNumFromCurrency(cmp.target.textContent);
                                if (fee === '2D')
                                    $scope.PP2D.ranges[key].fltQuoteFee = getNumFromCurrency(cmp.target.textContent);
                                if (fee === 'A12')
                                    $scope.PPA12.ranges[key].fltQuoteFee = getNumFromCurrency(cmp.target.textContent);
                                $scope.calculateEXP();
                                break;
                        }
                    else if (name === 'PPintFrecuency') {
                        $scope.PP.mapQuotes[keyX].ranges[key].intFrecuency = 0;
                        if (keyX === 'T7' || keyX === 'T7V' || keyX === 'T7P') {
                            $scope.PP.mapQuotes['T7'].ranges[key].intFrecuency = 0;
                            $scope.PP.mapQuotes['T7P'].ranges[key].intFrecuency = 0;
                            $scope.PP.mapQuotes['T7V'].ranges[key].intFrecuency = 0;
                        }
                        $scope.calculateEXP();
                    } else if (name === 'PPintFrecuencyZP') {
                        $scope.PPZP.mapQuotes[keyX].ranges[key].intFrecuency = 0;
                        $scope.calculateEXP();
                    } else if (name ==='intFrecc'){
                        if (fee === 'DS')
                            $scope.PPDS.ranges[key].intFrecuency = 0;
                        if (fee === '2D')
                            $scope.PP2D.ranges[key].intFrecuency = 0;
                        if (fee === 'A12')
                            $scope.PPA12.ranges[key].intFrecuency = 0;
                        $scope.calculatePPEXP(fee);
                    } else
                        cmp.target.innerText = 0;
                };

                $scope.sumbit = function (){
                    debugger;
                    var strNameProcess = '';
                    var strProfile = "{!profileObj}";
                    var objQuote;
                    var gerenteSucursal = null;

                    if(strProfile === 'Ejecutivo de telemarketing'
                        || strProfile === 'Supervisor Telemarketing'
                        || strProfile === 'Gerente comercial nacional')
                        gerenteSucursal = $scope.Managers['GSU'];

                    if(strProfile === 'Ejecutivo de telemarketing' || 'Ejecutivo de telemarketing y CC')
                       strProfile = 'Ejecutivo de venta';
                    
                    if(strProfile === 'Supervisor Telemarketing' )
                       strProfile = 'KAM Regional';
                    
                    if(strProfile === 'Gerente comercial nacional' )
                       strProfile = 'Gerentes de desarrollo de Negocios';

                    if(notEmpty($scope.DML.objQuote))
                        objQuote = $scope.DML.objQuote;
                    else
                        objQuote = $scope.Wrapper.objQuote;

                    $scope.DML.listErrors = [];

                    if($scope.isException(objQuote, strProfile)){
                        if(objQuote.SBQQ__Opportunity2__c){
                            objQuote.SBQQ__Status__c = 'Approved';
                        }
                        else if(objQuote.Lead__c && strProfile === 'Gerente de sucursal'){
                        objQuote.SBQQ__Status__c = 'preauthorized';
                        }
                        else if(objQuote.Lead__c && strProfile === 'KAM Regional'){
                        objQuote.SBQQ__Status__c = 'Approved';
                        }
                        else if(objQuote.Lead__c && strProfile === 'Gerentes de desarrollo de Negocios'){
                        objQuote.SBQQ__Status__c = 'Approved';
                        }
                        else if(objQuote.Lead__c && strProfile === 'Director comercial'){
                        objQuote.SBQQ__Status__c = 'Approved';
                        }
                        if(objQuote.Lead__c)
                            callUpdateStatus($scope, objQuote, objQuote.Lead__r.Name);
                        if(objQuote.SBQQ__Account__c)
                            callUpdateStatus($scope, objQuote, objQuote.SBQQ__Account__r.Name);
                    }
                    else if(objQuote.Lead__c){
                        if(objQuote.SBQQ__Status__c === 'Draft')
                         {
                            if(objQuote.Descuento_por_linea_o_rangokm__c < 60.01 ){
                                if(objQuote.Descuento_Global__c > 0
                                        && objQuote.Descuento_Global__c < 10.01
                                        && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'SipWeb_global_10_1_a_25_preau';
                                }
                                if(objQuote.Descuento_Global__c >= 10.01
                                        && objQuote.Descuento_Global__c < 25.01
                                        && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'SipWeb_global_10_1_a_25_preau';
                                }
                                if(objQuote.Descuento_por_linea_o_rango_km_Express__c < 25 ){
                                    if( objQuote.Descuento_Global_Express__c > 0
                                            && objQuote.Descuento_Global_Express__c < 10.01
                                            && objQuote.PAQ_TipoServicio__c.includes('Servicio Express Garantizado (SEG)')
                                            && strProfile === 'Ejecutivo de venta'
                                    )
                                        strNameProcess = 'SipWeb_global_10_1_a_25_preau';
                                }
                                if(objQuote.Descuento_por_linea_o_rango_km_Express__c < 25.00 ){
                                    if( objQuote.Descuento_Global_Express__c >= 10.01
                                            && objQuote.Descuento_Global_Express__c < 25.01
                                            && objQuote.PAQ_TipoServicio__c.includes('Servicio Express Garantizado (SEG)')
                                            && strProfile === 'Ejecutivo de venta'
                                    )
                                        strNameProcess = 'SipWeb_global_10_1_a_25_preau';
                                }
                                if(objQuote.Descuento_Global__c >= 25.01
                                        && objQuote.Descuento_Global__c < 40.01
                                        && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'preautorizacion_mayor_25_gerente';
                                    if(strProfile === 'Gerente de sucursal')
                                        strNameProcess = 'preautorizacion_mayor_25_gerente';
                                }
                                if(objQuote.Descuento_Global__c >= 40.01
                                        && objQuote.Descuento_Global__c < 60.01
                                        && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'preautorizacion_mayor_25_gerente';
                                    if(strProfile === 'Gerente de sucursal')
                                        strNameProcess = 'preautorizacion_mayor_25_gerente';
                                    if(strProfile === 'KAM Regional')
                                        strNameProcess = 'global_40_1_a_60_Km_menor_a_60_KAM_Regio';
                                }
                                if(objQuote.Descuento_Global__c >= 60.01
                                        && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'preautorizacion_mayor_25_gerente';
                                    if(strProfile === 'Gerente de sucursal')
                                        strNameProcess = 'preautorizacion_mayor_25_gerente';
                                    if(strProfile === 'KAM Regional')
                                        strNameProcess = 'global_60_O_mas_KAM_Regional';
                                    if(strProfile === 'Gerentes de desarrollo de Negocios')
                                        strNameProcess = 'global_60_O_mas_GE_DESARROLLO';
                                }
                            }
                            if(objQuote.Descuento_por_linea_o_rango_km_Express__c >= 25.01 ){
								if( objQuote.Descuento_Global_Express__c < 10.01
                                        && objQuote.PAQ_TipoServicio__c.includes('Servicio Express Garantizado (SEG)')
                                        && (strProfile === 'Ejecutivo de venta'
                                        )
                                )
                                    strNameProcess = 'SipWeb_global_10_1_a_25_preau';
                                if( objQuote.Descuento_Global_Express__c < 10.01
                                        && objQuote.PAQ_TipoServicio__c.includes('Servicio Express Garantizado (SEG)')
                                        && (strProfile === 'KAM Regional'
                                        )
                                )
                                    strNameProcess = 'AEREO_0_A_10_GBAL_25_O_MAS_KM';
                                if( objQuote.Descuento_Global_Express__c >= 10.01
                                        && objQuote.Descuento_Global_Express__c < 25.01
                                        && objQuote.PAQ_TipoServicio__c.includes('Servicio Express Garantizado (SEG)')
                                )
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'SipWeb_global_10_1_a_25_preau';
                                if(strProfile === 'KAM Regional')
                                    strNameProcess = 'AEREO_10_1_A_25_GBAL_MAYOR_25_KM_GE_SUC';
                            }
                            if(objQuote.Descuento_por_linea_o_rangokm__c >= 60.01 ){
                                if(objQuote.Descuento_Global__c < 10.01
                                        && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'SipWeb_global_10_1_a_25_preau';
                                    if(strProfile === 'KAM Regional')
                                        strNameProcess = 'global_0_a_10_y_km_mayor_a_60_KAM';
                                }
                                if(objQuote.Descuento_Global__c >= 10.01
                                        && objQuote.Descuento_Global__c < 25.01
                                        && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'SipWeb_global_10_1_a_25_preau';
                                    if(strProfile === 'KAM Regional')
                                        strNameProcess = 'global_10_1_a_25_y_km_60_o_mas_KAM';
                                }
                                if(objQuote.Descuento_Global__c >= 25.01
                                        && objQuote.Descuento_Global__c < 40.01
                                        && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'preautorizacion_mayor_25_gerente';
                                    if(strProfile === 'Gerente de sucursal')
                                        strNameProcess = 'preautorizacion_mayor_25_gerente';
                                    if(strProfile === 'KAM Regional')
                                        strNameProcess = 'global_25_a_40_y_km_60_o_mas_KAM_Regiona';
                                }
                                if(objQuote.Descuento_Global__c >= 40.01
                                        && objQuote.Descuento_Global__c < 60.01
                                        && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'preautorizacion_mayor_25_gerente';
                                    if(strProfile === 'Gerente de sucursal')
                                        strNameProcess = 'preautorizacion_mayor_25_gerente';
                                    if(strProfile === 'KAM Regional')
                                        strNameProcess = 'global_40_1_a_60_km_mayor_a_60_KAM_Regi';
                                }
                                if(objQuote.Descuento_Global__c >= 60.01
                                        && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'preautorizacion_mayor_25_gerente';
                                    if(strProfile === 'Gerente de sucursal')
                                        strNameProcess = 'preautorizacion_mayor_25_gerente';
                                    if(strProfile === 'KAM Regional')
                                        strNameProcess = 'global_60_O_mas_KAM_Regional';
                                    if(strProfile === 'Gerentes de desarrollo de Negocios')
                                        strNameProcess = 'global_60_O_mas_GE_DESARROLLO';

                                }

                            }
                            if(objQuote.Descuento_Global_Express__c >= 25.01
                                    && objQuote.PAQ_TipoServicio__c.includes('Servicio Express Garantizado (SEG)')) {
                                if(strProfile === 'Ejecutivo de venta')
                                    strNameProcess = 'preautorizacion_mayor_25_gerente';
                                if(strProfile === 'Gerente de sucursal')
                                    strNameProcess = 'preautorizacion_mayor_25_gerente';
                                if(strProfile === 'KAM Regional')
                                    strNameProcess = 'AEREO_MAYOR_DE_25_GLOBAL_KAM';
                                if(strProfile === 'Gerentes de desarrollo de Negocios')
                                    strNameProcess = 'AEREO_MAYOR_DE_25_GERENTE_DESARROLLO';
                            }
                        }
                        if(notEmpty(strNameProcess))
                            callSent($scope, $scope.Wrapper.objQuote.Id, strNameProcess, $scope.PP.strApprovalComment);
                        else
                            $scope.DML.listErrors.push('NO se encontró el proceso de aprobación aplicable');
                    }
                    else if(objQuote.SBQQ__Opportunity2__c){
                        if(objQuote.SBQQ__Status__c === 'Draft')
                         {
                            if(objQuote.Descuento_por_linea_o_rangokm__c < 60.01 ){
                                if(objQuote.Descuento_Global__c > 10
                                        && objQuote.Descuento_Global__c < 25.01
                                        && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'global_10_1_a_25_y_km_menor_a_60';
                                }
                                if(objQuote.Descuento_por_linea_o_rango_km_Express__c < 25 ){
                                    if( objQuote.Descuento_Global_Express__c > 10
                                            && objQuote.Descuento_Global_Express__c < 25.01
                                            && objQuote.PAQ_TipoServicio__c.includes('Servicio Express Garantizado (SEG)')
                                            && strProfile === 'Ejecutivo de venta'
                                    )
                                        strNameProcess = 'AEREO_10_1_A_25_GBAL_MENOR_25_KM';
                                }
                                if(objQuote.Descuento_Global__c > 25
                                        && objQuote.Descuento_Global__c < 40.01
                                        && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'global_25_a_40_y_km_menor_que_60';
                                    if(strProfile === 'Gerente de sucursal')
                                        strNameProcess = 'global_25_a_40_y_km_menor_que_60_GE_SUCU';
                                }
                                if(objQuote.Descuento_Global__c > 40
                                        && objQuote.Descuento_Global__c < 60.01
                                        && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'global_40_1_a_60_km_menor_a_60_V2';
                                    if(strProfile === 'Gerente de sucursal')
                                        strNameProcess = 'global_40_1_a_60_km_menor_a_60_GE_SUCURS';
                                    if(strProfile === 'KAM Regional')
                                        strNameProcess = 'global_40_1_a_60_Km_menor_a_60_KAM_Regio';
                                }
                                if(objQuote.Descuento_Global__c > 60
                                        && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'global_60_o_mas';
                                    if(strProfile === 'Gerente de sucursal')
                                        strNameProcess = 'global_60_o_mas_GE_SUCURSAL';
                                    if(strProfile === 'KAM Regional')
                                        strNameProcess = 'global_60_O_mas_KAM_Regional';
                                    if(strProfile === 'Gerentes de desarrollo de Negocios')
                                        strNameProcess = 'global_60_O_mas_GE_DESARROLLO';
                                }
                            }
                            if(objQuote.Descuento_por_linea_o_rango_km_Express__c > 25 ){

                                if( objQuote.Descuento_Global_Express__c < 10.01
                                        && objQuote.PAQ_TipoServicio__c.includes('Servicio Express Garantizado (SEG)')
                                        && (strProfile === 'Ejecutivo de venta'
                                                || strProfile === 'Gerente de sucursal'
                                                || strProfile === 'KAM Regional'
                                        )
                                )
                                    strNameProcess = 'AEREO_0_A_10_GBAL_25_O_MAS_KM';
                                if( objQuote.Descuento_Global_Express__c > 10
                                        && objQuote.Descuento_Global_Express__c < 25.01
                                        && objQuote.PAQ_TipoServicio__c.includes('Servicio Express Garantizado (SEG)')
                                )
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'AEREO_10_1_A_25_GBAL_MAYOR_25_KM';
                                if(strProfile === 'Gerente de sucursal' || strProfile === 'KAM Regional')
                                    strNameProcess = 'AEREO_10_1_A_25_GBAL_MAYOR_25_KM_GE_SUC';
                            }
                            if(objQuote.Descuento_por_linea_o_rangokm__c > 60 ){
                                if(objQuote.Descuento_Global__c < 10.01
                                        && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'global_0_a_10_y_km_mayor_a_60';
                                    if(strProfile === 'Gerente de sucursal')
                                        strNameProcess = 'global_0_a_10_y_km_mayor_a_60_GE_SUCURSA';
                                    if(strProfile === 'KAM Regional')
                                        strNameProcess = 'global_0_a_10_y_km_mayor_a_60_KAM';
                                }
                                if(objQuote.Descuento_Global__c > 10
                                        && objQuote.Descuento_Global__c < 25.01
                                        && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'global_10_1_a_25_y_km_60_o_mas';
                                    if(strProfile === 'Gerente de sucursal')
                                        strNameProcess = 'global_10_1_a_25_y_km_60_o_mas_GE_SUCURS';
                                    if(strProfile === 'KAM Regional')
                                        strNameProcess = 'global_10_1_a_25_y_km_60_o_mas_KAM';
                                }
                                if(objQuote.Descuento_Global__c > 25
                                        && objQuote.Descuento_Global__c < 40.01
                                        && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'global_25_a_40_y_km_60_o_mas';
                                    if(strProfile === 'Gerente de sucursal')
                                        strNameProcess = 'global_25_a_40_y_km_60_o_mas_GE_SUCURSAL';
                                    if(strProfile === 'KAM Regional')
                                        strNameProcess = 'global_25_a_40_y_km_60_o_mas_KAM_Regiona';
                                }
                                if(objQuote.Descuento_Global__c > 40
                                        && objQuote.Descuento_Global__c < 60.01
                                        && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'global_40_1_a_60_km_mayor_a_60';
                                    if(strProfile === 'Gerente de sucursal')
                                        strNameProcess = 'global_40_1_a_60_km_mayor_a_60_GE_SUCU';
                                    if(strProfile === 'KAM Regional')
                                        strNameProcess = 'global_40_1_a_60_km_mayor_a_60_KAM_Regi';
                                }
                                if(objQuote.Descuento_Global__c > 60
                                        && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'global_60_o_mas';
                                    if(strProfile === 'Gerente de sucursal')
                                        strNameProcess = 'global_60_o_mas_GE_SUCURSAL';
                                    if(strProfile === 'KAM Regional')
                                        strNameProcess = 'global_60_O_mas_KAM_Regional';
                                    if(strProfile === 'Gerentes de desarrollo de Negocios')
                                        strNameProcess = 'global_60_O_mas_GE_DESARROLLO';

                                }

                            }
                            if(objQuote.Descuento_Global_Express__c > 25
                                    && objQuote.PAQ_TipoServicio__c.includes('Servicio Express Garantizado (SEG)')) {
                                if(strProfile === 'Ejecutivo de venta')
                                    strNameProcess = 'AEREO_MAYOR_DE_25_GLOBAL';
                                if(strProfile === 'Gerente de sucursal')
                                    strNameProcess = 'AEREO_MAYOR_DE_25_GLOBAL_G_SUC';
                                if(strProfile === 'KAM Regional')
                                    strNameProcess = 'AEREO_MAYOR_DE_25_GLOBAL_KAM';
                                if(strProfile === 'Gerentes de desarrollo de Negocios')
                                    strNameProcess = 'AEREO_MAYOR_DE_25_GERENTE_DESARROLLO';
                            }
                        }
                        if(notEmpty(strNameProcess))
                            callSent($scope, $scope.Wrapper.objQuote.Id, strNameProcess, $scope.PP.strApprovalComment);
                        else
                            $scope.DML.listErrors.push('NO se encontró el proceso de aprobación aplicable');
                    }
                };
                
                $scope.updateFees = function(strOpp, strList){
                    switch (strOpp) {
                        case 'add':
                            if(strList=== 'fee')
                                for (var index = 0; index <= $scope.PP.FeeSelect.available.length; index++){
                                    var fee = $scope.PP.FeeSelect.available[index];
                                    if(fee && fee.blnSelected){
                                        fee.blnSelected = false;
                                        $scope.addFee(fee);
                                        index--;
                                    }
                                }
                            if(strList=== 'service')
                                for (var index = 0; index <= $scope.PP.ServiceSelect.available.length; index++){
                                    var service = $scope.PP.ServiceSelect.available[index];
                                    if(service && service.blnSelected){
                                        service.blnSelected = false;
                                        $scope.addService(service);
                                        index--;
                                    }
                                }
                            $scope.calculateEXP();
                            break;
                        case 'remove':
                            if(strList=== 'fee')
                                for (var index = 0; index <= $scope.PP.FeeSelect.selected.length; index++){
                                    var fee = $scope.PP.FeeSelect.selected[index];
                                    if(fee && fee.blnSelected){
                                        fee.blnSelected = false;
                                        $scope.removeFee(fee);
                                        index--;
                                        j$.each($scope.PP.mapQuotes[fee.id].ranges, function(keyRange, item){
                                            $scope.PP.mapQuotes[fee.id].ranges[keyRange] = {
                                                fltSeg : 0
                                                , fltFullFee : 0
                                                , fltNormalFee : 0
                                                , fltTotalQuote : 0
                                                , fltDiscount : 0
                                                , intFrecuency : 0
                                                , fltQuoteFee : 0
                                                , fltAmountSeg : 0
                                                , fltEAD: 0
                                                , fltEADZP: 0
                                                , fltRAD : 0
                                                , fltAmount : 0
                                                , fltACK : 0
                                                , fltMAN : 0
                                                , fltEDC : 0
                                                , fltEDD : 0
                                                , fltCRF : 0
                                            };
                                            if(fee.id === 'T7'){
                                                $scope.PP.mapQuotes['T7-P'].ranges[keyRange] = {
                                                    fltSeg : 0
                                                    , fltFullFee : 0
                                                    , fltNormalFee : 0
                                                    , fltTotalQuote : 0
                                                    , fltDiscount : 0
                                                    , intFrecuency : 0
                                                    , fltQuoteFee : 0
                                                    , fltAmountSeg : 0
                                                    , fltEAD: 0
                                                    , fltEADZP: 0
                                                    , fltRAD : 0
                                                    , fltAmount : 0
                                                    , fltACK : 0
                                                    , fltMAN : 0
                                                    , fltEDC : 0
                                                    , fltEDD : 0
                                                    , fltCRF : 0
                                                };
                                                $scope.PP.mapQuotes['T7-V'].ranges[keyRange] = {
                                                    fltSeg : 0
                                                    , fltFullFee : 0
                                                    , fltNormalFee : 0
                                                    , fltTotalQuote : 0
                                                    , fltDiscount : 0
                                                    , intFrecuency : 0
                                                    , fltQuoteFee : 0
                                                    , fltAmountSeg : 0
                                                    , fltEAD: 0
                                                    , fltEADZP: 0
                                                    , fltRAD : 0
                                                    , fltAmount : 0
                                                    , fltACK : 0
                                                    , fltMAN : 0
                                                    , fltEDC : 0
                                                    , fltEDD : 0
                                                    , fltCRF : 0
                                                };
                                            }
                                        });
                                    }
                                }
                            else if(strList=== 'service')
                                for (var index = 0; index <= $scope.PP.ServiceSelect.selected.length; index++){
                                    var service = $scope.PP.ServiceSelect.selected[index];
                                    if(service && service.blnSelected){
                                        service.blnSelected = false;
                                        $scope.removeService(service);
                                        index--;
                                    }
                                }
                            $scope.calculateEXP();
                            break;
                    }
                    $scope.PP.blnFeeAddAll = false;
                    $scope.PP.blnFeeRemoveAll = false;
                    $scope.PP.blnServiceAddAll = false;
                    $scope.PP.blnServiceRemoveAll = false;
                };

                $scope.dataTest = function() {

                };

                /*
                * initial Call
                */
                console.log('END LOAD Angular Controller PPG');
                //debugger;
                var t7Fee = {'T7P':'TARIFA T7-P', 'T7V':'TARIFA T7-V'};
                if($scope.hasRecord()){
                    $scope.PP.strAck = $scope.Wrapper.objQuote.Acuse__c;
                    if(notEmpty($scope.Wrapper.objQuote.Acuse__c))
                        $scope.PP.blnACK = true;
                    if($scope.Wrapper.objQuote.Servicios_adicionales__c)
                        j$.each( $scope.Wrapper.objQuote.Servicios_adicionales__c.split(';'),function (key, service) {
                            switch (service) {
                                case 'RAD':
                                    $scope.PP.blnRAD = true;
                                    break;
                                case 'EAD':
                                    $scope.PP.blnEAD = true;
                                    break;
                                case 'Seguro':
                                    $scope.PP.blnSEG = true;
                                    break;
                                /*case 'Acuse Empresa':
                                    $scope.PP.blnACK = true;
                                    break;
                                case 'Acuse Interno':
                                    $scope.PP.blnACK = true;
                                    break;
                                case 'Acuse XT':
                                    $scope.PP.blnACK = true;
                                    break;*/
                            }

                        });
                    j$.each($scope.PP.ServiceSelect.available, function(key, value){
                        switch (value.id) {
                            case 'RAD':
                                value.blnSelected = $scope.PP.blnRAD;
                                break;
                            case 'EAD':
                                value.blnSelected = $scope.PP.blnEAD;
                                break;
                            case 'SEG':
                                value.blnSelected = $scope.PP.blnSEG;
                                break;
                            case 'ACK':
                                value.blnSelected = $scope.PP.blnACK;
                                break;
                        }
                    });
                    $scope.updateFees('add', 'service');
                    if($scope.Wrapper.listQuoteItem) {
                        j$.each($scope.Wrapper.listQuoteItem
                                , function (index, quoteItem) {
                                    if(!getModel(getId(quoteItem.Tarifa__c, $scope.PP.listFee), $scope.PP.FeeSelect.selected)
                                            && getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) !== 'T7P' && getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) !== 'T7V'
                                            && quoteItem.Tarifa__c.toUpperCase() !== 'SEG-DS' && quoteItem.Tarifa__c.toUpperCase() !== 'SEG-2D' && quoteItem.Tarifa__c.toUpperCase() !== 'SEG-A12'
                                    )
                                        $scope.addFee(getModel(getId(quoteItem.Tarifa__c, $scope.PP.listFee), $scope.PP.FeeSelect.available));
                                    if($scope.PP.fltSEG === 0)
                                        $scope.PP.fltSEG = quoteItem.Pack_Seg__c;
                                    if(quoteItem.Tarifa__c === 'TARIFA T7')
                                        $scope.PPT7Calc = $scope.Wrapper.objQuote.TipoCotizacion__c;
                                    if(quoteItem.Tarifa__c.toUpperCase() === 'SEG-DS' || quoteItem.Tarifa__c.toUpperCase() === 'SEG-2D' || quoteItem.Tarifa__c.toUpperCase() === 'SEG-A12'){
                                        var keyRange = getId(quoteItem.Rango_KM__c, $scope.PP.listRange);
                                        if(quoteItem.Tarifa__c.toUpperCase() === 'SEG-A12'){
                                            if(!getModel('A12', $scope.PP.FeeSelect.selected))
                                                $scope.addFee(getModel('A12', $scope.PP.FeeSelect.available));
                                            $scope.PPA12.ranges[keyRange].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                            $scope.PPA12.ranges[keyRange].fltDisc = quoteItem.SBQQ__Discount__c / 100;
                                            $scope.PPA12.ranges[keyRange].fltQuoteFee = quoteItem.SBQQ__CustomerPrice__c;
                                            $scope.PPA12.ranges[keyRange].fltFullFee = quoteItem.SBQQ__NetPrice__c;
                                            $scope.PPA12.ranges[keyRange].fltTotalQuote = quoteItem.QuoteTotal__c;
                                            $scope.PP.fltSEG = quoteItem.Pack_Seg__c;
                                            $scope.PPA12.ranges[keyRange].Id = quoteItem.Id;
                                            $scope.PPA12.intTotalDisc = quoteItem.SBQQ__VolumeDiscount__c;
                                            $scope.PPA12.ranges[keyRange].fltWeight = quoteItem.Weight__c;
                                            $scope.PPA12.ranges[keyRange].fltLarge = quoteItem.Large__c;
                                            $scope.PPA12.ranges[keyRange].fltWidth = quoteItem.Width__c;
                                            $scope.PPA12.ranges[keyRange].fltHigh = quoteItem.High__c;
                                            $scope.calculateDimensionsPP('A12', keyRange);
                                        }
                                        else if(quoteItem.Tarifa__c.toUpperCase() === 'SEG-2D'){
                                            if(!getModel('2D', $scope.PP.FeeSelect.selected))
                                                $scope.addFee(getModel('2D', $scope.PP.FeeSelect.available));
                                            $scope.PP2D.ranges[keyRange].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                            $scope.PP2D.ranges[keyRange].fltDisc = quoteItem.SBQQ__Discount__c / 100;
                                            $scope.PP2D.ranges[keyRange].fltQuoteFee = quoteItem.SBQQ__CustomerPrice__c;
                                            $scope.PP2D.ranges[keyRange].fltFullFee = quoteItem.SBQQ__NetPrice__c;
                                            $scope.PP2D.ranges[keyRange].fltTotalQuote = quoteItem.QuoteTotal__c;
                                            $scope.PP.fltSEG = quoteItem.Pack_Seg__c;
                                            $scope.PP2D.ranges[keyRange].Id = quoteItem.Id;
                                            $scope.PP2D.intTotalDisc = quoteItem.SBQQ__VolumeDiscount__c;
                                            $scope.PP2D.ranges[keyRange].fltWeight = quoteItem.Weight__c;
                                            $scope.PP2D.ranges[keyRange].fltLarge = quoteItem.Large__c;
                                            $scope.PP2D.ranges[keyRange].fltWidth = quoteItem.Width__c;
                                            $scope.PP2D.ranges[keyRange].fltHigh = quoteItem.High__c;
                                            $scope.calculateDimensionsPP('2D', keyRange);
                                        }
                                        else if(quoteItem.Tarifa__c.toUpperCase() === 'SEG-DS'){
                                            if(!getModel('DS', $scope.PP.FeeSelect.selected))
                                                $scope.addFee(getModel('DS', $scope.PP.FeeSelect.available));
                                            $scope.PPDS.ranges[keyRange].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                            $scope.PPDS.ranges[keyRange].fltDisc = quoteItem.SBQQ__Discount__c / 100;
                                            $scope.PPDS.ranges[keyRange].fltQuoteFee = quoteItem.SBQQ__CustomerPrice__c;
                                            $scope.PPDS.ranges[keyRange].fltFullFee = quoteItem.SBQQ__NetPrice__c;
                                            $scope.PPDS.ranges[keyRange].fltTotalQuote = quoteItem.QuoteTotal__c;
                                            $scope.PP.fltSEG = quoteItem.Pack_Seg__c;
                                            $scope.PPDS.ranges[keyRange].Id = quoteItem.Id;
                                            $scope.PPDS.intTotalDisc = quoteItem.SBQQ__VolumeDiscount__c;
                                            $scope.PPDS.ranges[keyRange].fltWeight = quoteItem.Weight__c;
                                            $scope.PPDS.ranges[keyRange].fltLarge = quoteItem.Large__c;
                                            $scope.PPDS.ranges[keyRange].fltWidth = quoteItem.Width__c;
                                            $scope.PPDS.ranges[keyRange].fltHigh = quoteItem.High__c;
                                            $scope.calculateDimensionsPP('DS', keyRange);
                                        }
                                        $scope.calculatePPEXP('DS');
                                        $scope.calculatePPEXP('2D');
                                        $scope.calculatePPEXP('A12');
                                    }
                                    else if(quoteItem.ZonaPlus__c){
                                        $scope.PPZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].Id = quoteItem.Id;
                                        $scope.PPZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                        $scope.PPZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltDiscount = quoteItem.SBQQ__Discount__c;
                                        $scope.PPZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltQuoteFee = quoteItem.SBQQ__CustomerPrice__c;
                                        $scope.PPZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltFullFee = quoteItem.SBQQ__NetPrice__c;
                                        $scope.PPZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltTotalQuote = quoteItem.QuoteTotal__c;
                                        if(quoteItem.ACK__c)
                                            $scope.PPZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltACK = quoteItem.ACK__c;
                                        if(quoteItem.EAD__c)
                                            $scope.PPZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltEAD = quoteItem.EAD__c;
                                        if(quoteItem.RAD__c)
                                            $scope.PPZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltRAD = quoteItem.RAD__c;
                                        if(quoteItem.SEG__c)
                                            $scope.PPZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltAmountSeg = quoteItem.SEG__c;
                                    }
                                    else if (getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) !== 'T7P' && getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) !== 'T7V'){
                                        $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].Id = quoteItem.Id;
                                        $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                        $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltDiscount = quoteItem.SBQQ__Discount__c;
                                        $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltQuoteFee = quoteItem.SBQQ__CustomerPrice__c;
                                        $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltFullFee = quoteItem.SBQQ__NetPrice__c;
                                        $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltTotalQuote = quoteItem.QuoteTotal__c;
                                        if(quoteItem.ACK__c)
                                            $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltACK = quoteItem.ACK__c;
                                        if(quoteItem.EAD__c)
                                            $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltEAD = quoteItem.EAD__c;
                                        if(quoteItem.RAD__c)
                                            $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltRAD = quoteItem.RAD__c;
                                        if(quoteItem.SEG__c)
                                            $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltAmountSeg = quoteItem.SEG__c;
                                        if(quoteItem.Tarifa__c === 'TARIFA T7'){
                                            $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltVolAVR = quoteItem.PackVolAVG__c;
                                            $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltWeightAVR  = quoteItem.PackWeightAVG__c;
                                        }
                                    }
                                    else if (getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) === 'T7P' || getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) === 'T7V'){
                                        $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].Id = quoteItem.Id;
                                        $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                        $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltDiscount = quoteItem.SBQQ__Discount__c;
                                        $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltQuoteFee = quoteItem.SBQQ__CustomerPrice__c;
                                        $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltFullFee = quoteItem.SBQQ__NetPrice__c;
                                        $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltTotalQuote = quoteItem.QuoteTotal__c;
                                        $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltACK = quoteItem.ACK__c;
                                        $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltEAD = quoteItem.EAD__c;
                                        $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltRAD = quoteItem.RAD__c;
                                        $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltAmountSeg = quoteItem.SEG__c;
                                        $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltVolAVR = quoteItem.PackVolAVG__c;
                                        $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].fltWeightAVR  = quoteItem.PackWeightAVG__c;
                                    }
                                }
                        );

                    }
                }
                if($scope.Wrapper.mapTarifarioT)
                    j$.each($scope.PP.listFee
                            , function (keyFee, strFee) {
                                j$.each($scope.PP.listRange
                                        ,function (keyRange, strRange) {
                                            if(keyFee !==  'T7') {
                                                $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltAmount = $scope.Wrapper.mapTarifarioT['TARIFA ' + keyFee][strRange].Flete__c;
                                                $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltAmount = $scope.Wrapper.mapTarifarioT['TARIFA ' + keyFee][strRange].Flete__c;
                                            }
                                            else{
                                                $scope.PP.mapQuotes['T7V'].ranges[keyRange].fltAmount = $scope.Wrapper.mapTarifarioT['TARIFA T7V'][strRange].Flete__c;
                                                $scope.PP.mapQuotes['T7P'].ranges[keyRange].fltAmount = $scope.Wrapper.mapTarifarioT['TARIFA T7P'][strRange].Flete__c;
                                            }
                                            if(!$scope.exceptionAD(keyFee)){
                                                $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltEAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinEAD'], $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltAmount);
                                                $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltRAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinRAD'], $scope.PP.mapQuotes[keyFee].ranges[keyRange].fltAmount);
                                                if(keyFee !==  'T7') {
                                                    $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltEAD = $scope.Wrapper.mapCS['EAZP'];
                                                    $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltRAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinEAD'], $scope.PPZP.mapQuotes[keyFee].ranges[keyRange].fltAmount);
                                                }
                                            }
                                        }
                                );
                            }
                    );
                if($scope.Wrapper.mapTarifarioEXP)
                    j$.each(['DS', '2D', 'A12']
                            , function (i, keyFee) {
                                j$.each($scope.PP.listRange
                                        ,function (keyRange, strRange) {
                                            if(keyFee === 'DS')
                                                $scope.PPDS.ranges[keyRange].fltFullFee = $scope.Wrapper.mapTarifarioEXP[keyFee][strRange].GuiaDeArranque1Kg__c;
                                            if(keyFee === '2D')
                                                $scope.PP2D.ranges[keyRange].fltFullFee = $scope.Wrapper.mapTarifarioEXP[keyFee][strRange].GuiaDeArranque1Kg__c;
                                            if(keyFee === 'A12')
                                                $scope.PPA12.ranges[keyRange].fltFullFee = $scope.Wrapper.mapTarifarioEXP[keyFee][strRange].GuiaDeArranque1Kg__c;
                                        }
                                );
                            }
                    );
                $scope.sent = false;
                $scope.calculateEXP();
                $scope.calculateEXP();
                callGetHierarchy($scope);
            }]);
            /*
            * Angular module filters
            */
            app.filter('percentage', ['$filter', function ($filter) {
                return function (input, decimals) {
                    return $filter('number')(input * 100, decimals) + '%';
                };
            }]);
            // JSRemoting Call InitialInfo
            function callGetHierarchy($scope) {
                j$.blockUI({ message: '<h3><span class="glyphicon glyphicon-time"></span> Por favor espere... </h3>' });
                $scope.sent = true;
                Visualforce.remoting.Manager.invokeAction(
                        '{!$RemoteAction.PAQ_CotizadorNacional_CTR.getHierarchyUser}'
                        , function (result, event) {
                            debugger;
                            if (event.status) {
                                $scope.Wrapper.mapHierarchy = result.mapHierarchy;
                                j$.each(result.mapHierarchy,
                                        function(key, userId){
                                              if(key.toUpperCase().includes('SUPERVISOR_TELEMARKETING'))
                                                $scope.Managers['KAM'] = userId;
                                           
                                            else if(key.toUpperCase().includes('GERENCIA_MARKETING_Y_PDV'))
                                                $scope.Managers['GDS'] = userId;
                                           
                                            else if(key.toUpperCase().includes('DIRECTOR_COMERCIAL'))
                                                $scope.Managers['DCO'] = userId;
                                        }
                                );
                                if(!notEmpty($scope.Managers['GSU']) && $scope.Wrapper.objEstructura && notEmpty($scope.Wrapper.objEstructura.Gerente_Sucursal__c))
                                    $scope.Managers['GSU'] = $scope.Wrapper.objEstructura.Gerente_Sucursal__c;
                                if(!notEmpty($scope.Managers['KAM']) && $scope.Wrapper.objEstructura && notEmpty($scope.Wrapper.objEstructura.KAM_regional__c))
                                    $scope.Managers['KAM'] = $scope.Wrapper.objEstructura.KAM_regional__c;
                                if(!notEmpty($scope.Managers['GDS']) && $scope.Wrapper.objEstructura && notEmpty($scope.Wrapper.objEstructura.Gerente_desarrollo_de_negocios__c	))
                                    $scope.Managers['GDS'] = $scope.Wrapper.objEstructura.Gerente_desarrollo_de_negocios__c	;
                                if(!notEmpty($scope.Managers['DCO']) && $scope.Wrapper.objEstructura && notEmpty($scope.Wrapper.objEstructura.Director_Comercial__c))
                                    $scope.Managers['DCO'] = $scope.Wrapper.objEstructura.Director_Comercial__c;
                                
                                $scope.$apply();
                                j$.unblockUI();
                            }
                            else {
                                $scope.DML.blnSuccess = false;
                                $scope.DML.listErrors.push(logErrorMessage(event.message.split(',')));
                                $scope.$apply();
                                j$.unblockUI();
                            }
                        },
                        {escape: false, timeout: 120000}
                );
            }

            function callCreateQuoteConv($scope, objQuote, listQuoteItem, leadObj, oppObj) {
                j$.blockUI({ message: '<h3><span class="glyphicon glyphicon-time"></span> Por favor espere... </h3>' });
                $scope.SuccessMessage = '';
                $scope.DML.listErrors = [];
                $scope.sent = true;
                Visualforce.remoting.Manager.invokeAction(
                        '{!$RemoteAction.PAQ_CotizadorNacional_CTR.saveQuoteConv}'
                        , objQuote
                        , listQuoteItem
                        , leadObj
                        , oppObj
                        , null
                        , function (result, event) {
                            debugger;
                            if (event.status) {
                                $scope.DML = result;
                                $scope.Wrapper.objQuote = result.objQuote;
                                var t7Fee = {'T7P':'TARIFA T7-P', 'T7V':'TARIFA T7-V'};
                                j$.each(result.listQuoteItem, function (index, quoteItem) {
                                    var keyRange = getId(quoteItem.Rango_KM__c, $scope.PP.listRange);
                                    if(quoteItem.Tarifa__c.toUpperCase() === 'SEG-2D')
                                        $scope.PP2D.ranges[keyRange].Id = quoteItem.Id;
                                    else if(quoteItem.Tarifa__c.toUpperCase() === 'SEG-DS')
                                        $scope.PPDS.ranges[keyRange].Id = quoteItem.Id;
                                    else if(quoteItem.Tarifa__c.toUpperCase() === 'SEG-A12')
                                        $scope.PPA12.ranges[keyRange].Id = quoteItem.Id;
                                    else if(quoteItem.ZonaPlus__c)
                                        $scope.PPZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].Id = quoteItem.Id;
                                    else if (getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) !== 'T7P' && getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) !== 'T7V')
                                        $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].Id = quoteItem.Id;
                                    else if (getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) === 'T7P' || getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) === 'T7V')
                                        $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].Id = quoteItem.Id;
                                });

                                if($scope.DML.blnSuccess)
                                    $scope.SuccessMessage = 'Se han guardado los cambios con exito.';
                                $scope.PP.blnBotonActivo = false;
                                $scope.$apply();
                                j$.unblockUI();

                            } else {
                                $scope.DML.blnSuccess = false;
                                $scope.DML.listErrors.push(logErrorMessage(event.message.split(',')));
                                $scope.$apply();
                                j$.unblockUI();
                            }
                        },
                        {escape: false, timeout: 120000}
                );
            }

            function callUpdateQuoteConv($scope, objQuote, listQuoteItem, leadObj, oppObj, listDeleteItems) {
                j$.blockUI({ message: '<h3><span class="glyphicon glyphicon-time"></span> Por favor espere... </h3>' });
                $scope.SuccessMessage = '';
                $scope.DML.listErrors = [];
                $scope.sent = true;
                Visualforce.remoting.Manager.invokeAction(
                        '{!$RemoteAction.PAQ_CotizadorNacional_CTR.updateQuoteConv}'
                        , objQuote
                        , listQuoteItem
                        , leadObj
                        , oppObj
                        , listDeleteItems
                        , null
                        , null
                        , function (result, event) {
                            debugger;
                            if (event.status) {
                                $scope.DML = result;
                                var t7Fee = {'T7P':'TARIFA T7-P', 'T7V':'TARIFA T7-V'};
                                j$.each(result.listQuoteItem, function (index, quoteItem) {
                                    var keyRange = getId(quoteItem.Rango_KM__c, $scope.PP.listRange);
                                    if(quoteItem.Tarifa__c.toUpperCase() === 'SEG-2D')
                                        $scope.PP2D.ranges[keyRange].Id = quoteItem.Id;
                                    else if(quoteItem.Tarifa__c.toUpperCase() === 'SEG-DS')
                                        $scope.PPDS.ranges[keyRange].Id = quoteItem.Id;
                                    else if(quoteItem.Tarifa__c.toUpperCase() === 'SEG-A12')
                                        $scope.PPA12.ranges[keyRange].Id = quoteItem.Id;
                                    else if(quoteItem.ZonaPlus__c)
                                        $scope.PPZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].Id = quoteItem.Id;
                                    else if (getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) !== 'T7P' && getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) !== 'T7V')
                                        $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.PP.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].Id = quoteItem.Id;
                                    else if (getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) === 'T7P' || getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) === 'T7V')
                                        $scope.PP.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.PP.listRange)].Id = quoteItem.Id;
                                });

                                $scope.$apply();
                                j$.unblockUI();
                            }
                            else {
                                $scope.DML.blnSuccess = false;
                                $scope.DML.listErrors.push(logErrorMessage(event.message.split(',')));
                                $scope.$apply();
                                j$.unblockUI();
                            }
                        },
                        {escape: false, timeout: 120000}
                );
            }

            function callSent($scope, strIdQuote, strNameAP, strComment) {
                j$.blockUI({ message: '<h3><span class="glyphicon glyphicon-time"></span> Por favor espere... </h3>' });
                $scope.SuccessMessage = '';
                $scope.sent = true;
                Visualforce.remoting.Manager.invokeAction(
                        '{!$RemoteAction.PAQ_CotizadorNacional_CTR.sumbitAPP}'
                        , strIdQuote
                        , strNameAP
                        , strComment
                        , function (result, event) {
                            debugger;
                            if (event.status) {
                                $scope.DML = result;
                                if(result.blnSuccess)
                                    $scope.SuccessMessage = 'La cotización se ha enviado a revisión';
                                $scope.$apply();
                                j$.unblockUI();
                            }
                            else {
                                $scope.DML.blnSuccess = false;
                                $scope.DML.listErrors.push(logErrorMessage(event.message.split(',')));
                                $scope.$apply();
                                j$.unblockUI();
                            }
                        },
                        {escape: false, timeout: 120000}
                );
            }

            function callUpdateStatus($scope, objQuote, strName) {
                j$.blockUI({ message: '<h3><span class="glyphicon glyphicon-time"></span> Por favor espere... </h3>' });
                $scope.SuccessMessage = '';
                $scope.sent = true;
                Visualforce.remoting.Manager.invokeAction(
                        '{!$RemoteAction.PAQ_CotizadorNacional_CTR.updateStatusQuote}'
                        , objQuote
                        , strName
                        , function (result, event) {
                            debugger;
                            if (event.status) {
                                $scope.DML = result;
                                if(result.blnSuccess)
                                    $scope.SuccessMessage = 'La cotización se ha autorizado automáticamente';

                                $scope.$apply();
                                j$.unblockUI();
                            }
                            else {
                                $scope.DML.blnSuccess = false;
                                $scope.DML.listErrors.push(logErrorMessage(event.message.split(',')));
                                $scope.$apply();
                                j$.unblockUI();
                            }
                        },
                        {escape: false, timeout: 120000}
                );
            }

            function dominantFeeServiceDom(fltMinFee, fltAmount) {
                var fltFee = fltAmount * 0.11;
                if(fltMinFee > fltFee)
                    return fltMinFee;
                else
                    return fltFee;
            }

            function getNum(strNum) {
                if(notEmpty(strNum))
                    if(isNaN(strNum))
                        return 0;
                    else
                        return parseFloat(strNum);
            }

            function getNumFromCurrency(strNum) {
                var subStr = '';
                if(notEmpty(strNum)){
                    if(strNum.indexOf('$') !== -1)
                        subStr = strNum.substring(1, strNum.length);
                    else
                        subStr = strNum;
                    if(subStr.length > 3 && strNum.indexOf(',') !== -1)
                        subStr = subStr.replace(',', '');
                    if(isNaN(subStr))
                        return 0;
                    else
                        return parseFloat(subStr);
                } else
                    return 0;
            }

            function getModel(strId, arrayOptions) {
                var model;
                j$.each(arrayOptions
                        ,function (key, value) {
                            if(value.id === strId)
                                model = value;
                        }
                );
                return model
            }

            function getId(strLabel, arrayOptions) {
                var model;
                j$.each(arrayOptions
                        ,function (key, value) {
                            if(value === strLabel)
                                model = key;
                        }
                );
                return model
            }

            function isIn(strFee, arrayFee){
                return j$.inArray(strFee, arrayFee) !== -1;
            }

            function notEmpty(str){
                return str !== undefined  && str !== "" && str!== null;
            }

            function logErrorMessage (messages){
                var errorMessage = messages;
                if (errorMessage[1] !== undefined) {
                    errorMessage = errorMessage[1].split(':');
                }
                else {
                    errorMessage = errorMessage[0].split(':');
                }
                return errorMessage[0];
            }

        })();
    </script>
</apex:component>
