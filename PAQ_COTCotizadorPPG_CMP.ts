<!--
  @description       : 
  @author            : ChangeMeIn@UserSettingsUnder.SFDoc
  @group             : 
  @last modified on  : 02-10-2022
  @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
  Modifications Log 
  Ver   Date         Author                               Modification
  1.0   05-26-2021   ChangeMeIn@UserSettingsUnder.SFDoc   Initial Version
-->
<apex:component controller="PAQ_CotizadorNacional_CTR">
    <div ng-controller="ODCController as ODCCTR">
        <div ng-show="ODstep1">
            <!--header-->
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="row">
                        <div class="col-md-1 col-sm-1">
                            <div class="row center">
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#ODModalFee"  >
                                    Tarifas
                                </button>
                            </div>
                        </div>
                        <div class="col-md-1 col-sm-1">
                            <div class="row center">
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#ODModalServices"  >
                                    Servicios
                                </button>
                            </div>
                        </div>
                        <div class="col-md-1 col-sm-1">
                            <div class="row center">
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#ODModalQuickDisc"  >
                                    Descuentos
                                </button>
                            </div>
                        </div>
                        <div class="col-md-1 col-sm-1">
                            <div class="row center">
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#ODModalDestiny"  >
                                    Destinos
                                </button>
                            </div>
                        </div>
                        <div class="col-md-2 col-sm-2">
                            <div class="row center">
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#ODModalSpecialService"  >
                                    Servicios Especiales
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
                                <div class="col-md-3 col-sm-3 center"><span ng-bind="OD.TOTAL['NORMAL'] | currency"></span></div>
                                <div class="col-md-3 col-sm-3 center"><span ng-bind="OD.TOTAL['PROPUESTA'] | currency"></span></div>
                                <div class="col-md-3 col-sm-3 center"><span ng-bind="OD.TOTAL['DESCUENTO'] | percentage:2"></span></div>
                                <div class="col-md-3 col-sm-3 center"><span ng-bind="OD.TOTAL['PAQUETES'] | number"></span></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--dual tables-->
            <div class="row">
                <div class="col-md-6 col-sm-6">
                    <div class="panel panel-default" ng-repeat="(strFeeKey, fee) in OD.listFee" ng-show="OD.mapQuotes[strFeeKey].blnShow && strFeeKey !== 'T7'" style="overflow: scroll;">
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
                                        <td class="thead-light center"><input type="checkbox" ng-model="OD.mapQuotes[strFeeKey].blnSameFrecuency" ng-click="replicate('Quantity', OD.mapQuotes[strFeeKey].ranges['0-400'].intFrecuency, strFeeKey)" /> </td>
                                        <td class="thead-light center"><input type="checkbox" ng-model="OD.mapQuotes[strFeeKey].blnSameQuote" ng-click="replicate('Quote', OD.mapQuotes[strFeeKey].ranges['0-400'].fltQuoteFee, strFeeKey)" /></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr ng-repeat="(keyRange, strRange) in OD.listRange">
                                        <td ng-bind="strRange"></td>
                                        <td ng-bind="OD.mapQuotes[strFeeKey].ranges[keyRange].fltFullFee | currency"></td>
                                        <td class="thead-light center" contenteditable="true" ng-bind="OD.mapQuotes[strFeeKey].ranges[keyRange].intFrecuency | number" ng-blur="setValue('PPintFrecuency', keyRange, $event, strFeeKey)"></td>
                                        <td class="thead-light center" contenteditable="true" ng-bind="OD.mapQuotes[strFeeKey].ranges[keyRange].fltQuoteFee | currency" ng-blur="setValue('PPfltQuoteFee', keyRange, $event, strFeeKey)"></td>
                                        <td ng-bind="OD.mapQuotes[strFeeKey].ranges[keyRange].fltTotalQuote | currency"></td>
                                        <td ng-bind="OD.mapQuotes[strFeeKey].ranges[keyRange].fltDiscount | percentage:2"></td>
                                    </tr>
                                    <tr>
                                        <td>Total</td>
                                        <td></td>
                                        <td class="center"><span ng-bind="OD.mapQuotes[strFeeKey].intFeeTotalFrec | number"></span></td>
                                        <td></td>
                                        <td><span ng-bind="OD.mapQuotes[strFeeKey].fltFeeTotalQuote | currency"></span></td>
                                        <td><span ng-bind="OD.mapQuotes[strFeeKey].fltFeeTotalDesc | percentage:2"></span></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-sm-6">
                    <div class="panel panel-default" ng-repeat="(strFeeKey, fee) in ODZP.listFee" ng-show="OD.mapQuotes[strFeeKey].blnShow && OD.blnEAD" style="overflow: scroll;">
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
                                        <td class="thead-light center"><input type="checkbox" ng-model="ODZP.mapQuotes[strFeeKey].blnSameFrecuency" ng-click="replicate('QuantityZP', ODZP.mapQuotes[strFeeKey].ranges['0-400'].intFrecuency, strFeeKey)"/></td>
                                        <td class="thead-light center"><input type="checkbox" ng-model="ODZP.mapQuotes[strFeeKey].blnSameQuote" ng-click="replicate('QuoteZP', ODZP.mapQuotes[strFeeKey].ranges['0-400'].fltQuoteFee, strFeeKey)"/></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr ng-repeat="(keyRange, strRange) in ODZP.listRange">
                                        <td class="thead-light" ng-bind="strRange"></td>
                                        <td ng-bind="ODZP.mapQuotes[strFeeKey].ranges[keyRange].fltFullFee | currency"></td>
                                        <td class="thead-light center" contenteditable="true" ng-bind="ODZP.mapQuotes[strFeeKey].ranges[keyRange].intFrecuency | number" ng-blur="setValue('PPintFrecuencyZP', keyRange, $event, strFeeKey)"></td>
                                        <td class="thead-light center" contenteditable="true" ng-bind="ODZP.mapQuotes[strFeeKey].ranges[keyRange].fltQuoteFee | currency" ng-blur="setValue('PPfltQuoteFeeZP', keyRange, $event, strFeeKey)"></td>
                                        <td ng-bind="ODZP.mapQuotes[strFeeKey].ranges[keyRange].fltTotalQuote | currency"></td>
                                        <td ng-bind="ODZP.mapQuotes[strFeeKey].ranges[keyRange].fltDiscount | percentage:2"></td>
                                    </tr>
                                    <tr>
                                        <td>Total</td>
                                        <td></td>
                                        <td class="center"><span ng-bind="ODZP.mapQuotes[strFeeKey].intFeeTotalFrec | number"></span></td>
                                        <td></td>
                                        <td><span ng-bind="ODZP.mapQuotes[strFeeKey].fltFeeTotalQuote | currency"></span></td>
                                        <td><span ng-bind="ODZP.mapQuotes[strFeeKey].fltFeeTotalDesc | percentage:2"></span></td>
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
                    <div class="panel panel-default" ng-show="OD.mapQuotes['T7'].blnShow" style="overflow: scroll;">
                        <div class="panel-heading"> 
                            <a data-toggle="collapse" href="#T7PV"><h3 class="panel-title" >TARIFA T7</h3></a>
                        </div>
                        <div id="T7PV" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <div class="row" ng-show="PPT7Calc === 'byDelivery'">
                                    <table class="table table-striped">
                                        <thead class="thead-light">
                                        <tr>
                                            <th class="center">Rango KM</th>
                                            <th class="center">Tarifa llena</th>
                                            <th class="center"># Paquetes (Frecuencia)</th>
                                            <th class="center">Tarifa propuesta</th>
                                            <th class="center">TOTAL PROPUESTA</th>
                                            <th class="center">Descuento</th>
                                            <th class="center">Volumen de la tarima</th>
                                            <th class="center">Peso de la Tarima</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td colspan="2">Replicar en todos los rangos</td>
                                            <td class="thead-light center"><input type="checkbox" ng-model="OD.mapQuotes['T7'].blnSameFrecuency" ng-click="replicate('Quantity', OD.mapQuotes['T7'].ranges['0-400'].intFrecuency, 'T7')"/></td>
                                            <td class="thead-light center"><input type="checkbox" ng-model="OD.mapQuotes['T7'].blnSameQuote" ng-click="replicate('Quote', OD.mapQuotes['T7'].ranges['0-400'].fltQuoteFee, 'T7')"/></td>
                                            <td></td>
                                            <td></td>
                                            <td class="thead-light center"><input type="checkbox" ng-model="OD.mapQuotes['T7'].blnSameVolAVR" ng-click="replicate('VolAVR', OD.mapQuotes['T7'].ranges['0-400'].fltVolAVR, 'T7')"/></td>
                                            <td class="thead-light center"><input type="checkbox" ng-model="OD.mapQuotes['T7'].blnSameWeigthAVR" ng-click="replicate('WeigthAVR', OD.mapQuotes['T7'].ranges['0-400'].fltWeightAVR, 'T7')"/></td>
                                        </tr>
                                        <tr ng-repeat="(keyRange, strRange) in OD.listRange">
                                            <td ng-bind="strRange"></td>
                                            <td class="center" ng-bind="OD.mapQuotes['T7'].ranges[keyRange].fltFullFee | currency"></td>
                                            <td class="thead-light center" contenteditable="true" ng-bind="OD.mapQuotes['T7'].ranges[keyRange].intFrecuency | number" ng-blur="setValue('PPintFrecuency', keyRange, $event, 'T7')"></td>
                                            <td class="thead-light center" contenteditable="true" ng-bind="OD.mapQuotes['T7'].ranges[keyRange].fltQuoteFee | currency" ng-blur="setValue('PPfltQuoteFee', keyRange, $event, 'T7')"></td>
                                            <td class="center" ng-bind="OD.mapQuotes['T7'].ranges[keyRange].fltTotalQuote | currency"></td>
                                            <td class="center"  ng-bind="OD.mapQuotes['T7'].ranges[keyRange].fltDiscount | percentage:2"></td>
                                            <td class="thead-light center" contenteditable="true" ng-bind="OD.mapQuotes['T7'].ranges[keyRange].fltVolAVR | number" ng-blur="setValue('PPfltVolAVR', keyRange, $event, 'T7')"></td>
                                            <td class="thead-light center" contenteditable="true" ng-bind="OD.mapQuotes['T7'].ranges[keyRange].fltWeightAVR | number" ng-blur="setValue('PPfltWeightAVR', keyRange, $event, 'T7')"></td>
                                        </tr>
                                        <tr>
                                            <td>Total</td>
                                            <td></td>
                                            <td class="center"><span ng-bind="OD.mapQuotes['T7'].intFeeTotalFrec | number"></span></td>
                                            <td></td>
                                            <td class="center"><span ng-bind="OD.mapQuotes['T7'].fltFeeTotalQuote | currency"></span></td>
                                            <td class="center"><span ng-bind="OD.mapQuotes['T7'].fltTotalDisc | percentage:2"></span></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="row" ng-show="PPT7Calc === 'byDimension'">
                                    <div class="col-md-12 col-sm-12">
                                        <table class="table table-striped" >
                                            <thead class="thead-light">
                                            <tr>
                                                <th class="center" >Rango KM</th>
                                                <th class="center" >Tarifa llena</th>
                                                <th class="center" ># Paquetes (Frecuencia)</th>
                                                <th class="center" >Tarifa propuesta m3</th>
                                                <th class="center" >TOTAL PROPUESTA</th>
                                                <th class="center" >Descuento</th>
                                                <th class="center" >Volumen (m3)</th>
                                                <th class="center" >Volumen promedio tarima</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                <td colspan="2">Replicar en todos los rangos</td>
                                                <td class="thead-light center"><input type="checkbox" ng-model="OD.mapQuotes['T7V'].blnSameFrecuency" ng-click="replicate('Quantity', OD.mapQuotes['T7'].ranges['0-400'].intFrecuency, 'T7V')"/></td>
                                                <td class="thead-light center"><input type="checkbox" ng-model="OD.mapQuotes['T7V'].blnSameQuote" ng-click="replicate('Quote', OD.mapQuotes['T7V'].ranges['0-400'].fltQuoteFee, 'T7V')"/></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td class="thead-light center"><input type="checkbox" ng-model="OD.mapQuotes['T7V'].blnSameVolAVR" ng-click="replicate('VolAVR', OD.mapQuotes['T7V'].ranges['0-400'].fltVolAVR, 'T7V')"/></td>
                                            </tr>
                                            <tr ng-repeat="(keyRange, strRange) in OD.listRange">
                                                <td ng-bind="strRange"></td>
                                                <td class="center" ng-bind="OD.mapQuotes['T7V'].ranges[keyRange].fltFullFee | currency"></td>
                                                <td class="thead-light center" contenteditable="true" ng-bind="OD.mapQuotes['T7V'].ranges[keyRange].intFrecuency | number" ng-blur="setValue('PPintFrecuency', keyRange, $event, 'T7V')"></td>
                                                <td class="thead-light center" contenteditable="true" ng-bind="OD.mapQuotes['T7V'].ranges[keyRange].fltQuoteFee | currency" ng-blur="setValue('PPfltQuoteFee', keyRange, $event, 'T7V')"></td>
                                                <td class="center" ng-bind="OD.mapQuotes['T7V'].ranges[keyRange].fltTotalQuote | currency"></td>
                                                <td class="center" ng-bind="OD.mapQuotes['T7V'].ranges[keyRange].fltDiscount | percentage:2"></td>
                                                <td class="center" ng-bind="OD.mapQuotes['T7V'].ranges[keyRange].fltVol | number" ></td>
                                                <td class="thead-light center" contenteditable="true" ng-bind="OD.mapQuotes['T7V'].ranges[keyRange].fltVolAVR | number" ng-blur="setValue('PPfltVolAVR', keyRange, $event, 'T7V')"></td>
                                            </tr>
                                            <tr>
                                                <td>Total</td>
                                                <td></td>
                                                <td class="center"><span class="center" ng-bind="OD.mapQuotes['T7V'].intFeeTotalFrec | number"></span></td>
                                                <td></td>
                                                <td class="center"><span ng-bind="OD.mapQuotes['T7V'].fltFeeTotalQuote | currency"></span></td>
                                                <td class="center"><span ng-bind="OD.mapQuotes['T7V'].fltTotalDisc | percentage:2"></span></td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                            </tbody>
                                        </table>

                                        <table class="table table-striped" >
                                            <thead class="thead-light">
                                            <tr>
                                                <th class="center" >Rango KM</th>
                                                <th class="center" >Tarifa llena</th>
                                                <th class="center" ># Paquetes (Frecuencia)</th>
                                                <th class="center" >Tarifa propuesta Kg</th>
                                                <th class="center" >TOTAL PROPUESTA</th>
                                                <th class="center" >Descuento</th>
                                                <th class="center" >Peso (Kg)</th>
                                                <th class="center" >Peso promedio tarima</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                <td colspan="2">Replicar en todos los rangos</td>
                                                <td class="thead-light center"><input type="checkbox" ng-model="OD.mapQuotes['T7P'].blnSameFrecuency" ng-click="replicate('Quantity', OD.mapQuotes['T7P'].ranges['0-400'].intFrecuency, 'T7P')"/></td>
                                                <td class="thead-light center"><input type="checkbox" ng-model="OD.mapQuotes['T7P'].blnSameQuote" ng-click="replicate('Quote', OD.mapQuotes['T7P'].ranges['0-400'].fltQuoteFee, 'T7P')"/></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td class="thead-light center"><input type="checkbox" ng-model="OD.mapQuotes['T7P'].blnSameWeigthAVR" ng-click="replicate('WeigthAVR', OD.mapQuotes['T7P'].ranges['0-400'].fltWeightAVR, 'T7P')"/></td>
                                            </tr>
                                            <tr ng-repeat="(keyRange, strRange) in OD.listRange">
                                                <td ng-bind="strRange"></td>
                                                <td class="center" ng-bind="OD.mapQuotes['T7P'].ranges[keyRange].fltFullFee | currency"></td>
                                                <td class="thead-light center" contenteditable="true" ng-bind="OD.mapQuotes['T7P'].ranges[keyRange].intFrecuency | number" ng-blur="setValue('PPintFrecuency', keyRange, $event, 'T7P')"></td>
                                                <td class="thead-light center" contenteditable="true" ng-bind="OD.mapQuotes['T7P'].ranges[keyRange].fltQuoteFee | currency" ng-blur="setValue('PPfltQuoteFee', keyRange, $event, 'T7P')"></td>
                                                <td class="center" ng-bind="OD.mapQuotes['T7P'].ranges[keyRange].fltTotalQuote | currency"></td>
                                                <td class="center" ng-bind="OD.mapQuotes['T7P'].ranges[keyRange].fltDiscount | percentage:2"></td>
                                                <td class="center" ng-bind="OD.mapQuotes['T7P'].ranges[keyRange].fltWeight | number" ></td>
                                                <td class="thead-light center" contenteditable="true" ng-bind="OD.mapQuotes['T7P'].ranges[keyRange].fltWeightAVR | number" ng-blur="setValue('PPfltWeightAVR', keyRange, $event, 'T7P')"></td>
                                            </tr>
                                            <tr>
                                                <td>Total</td>
                                                <td></td>
                                                <td class="center" ><span ng-bind="OD.mapQuotes['T7P'].intFeeTotalFrec | number"></span></td>
                                                <td></td>
                                                <td class="center" ><span ng-bind="OD.mapQuotes['T7P'].fltFeeTotalQuote | currency"></span></td>
                                                <td class="center" ><span ng-bind="OD.mapQuotes['T7P'].fltTotalDisc | percentage:2"></span></td>
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
            <!--SEG tables-->
            <div class="row" ng-repeat="(keyBlock, listBlock) in ODEXP.mapBlock" >
                <div class="panel panel-default" ng-show="isSelected(keyBlock)">
                    <div class="panel-heading">
                        <a data-toggle="collapse" href="#{{keyBlock}}"><h3 class="panel-title">FRECUENCIA DE ENVÍOS - {{  ODEXP.mapBlock[keyBlock][0].strLabel }}</h3></a>
                    </div>
                    <div id="{{keyBlock}}" class="panel-collapse collapse in">
                        <div class="panel-body">
                            <div ng-repeat="(index, block) in listBlock" class="panel panel-default" style="overflow: scroll;">
                                <table class="table table-striped table-bordered">
                                <thead class="thead-light">
                                <tr>
                                    <th colspan="16"> BLOQUE {{index + 1}}</th>
                                </tr>
                                <tr>
                                    <th>Rango de KM</th>
                                    <th>Tarifa llena</th>
                                    <th># Paquetes (Frecuencia)</th>
                                    <th>Tarifa propuesta</th>
                                    <th>Guía arranque</th>
                                    <th>Kg arranque</th>
                                    <th ng-show="isLastBlock(keyBlock, index)">Kg adicional</th>
                                    <th ng-show="OD.blnACK">Costo de acuse</th>
                                    <th ng-show="OD.blnSEG">Costo de seguro</th>
                                    <th>Peso báscula</th>
                                    <th>Largo (cm)</th>
                                    <th>Ancho (cm)</th>
                                    <th>Alto (cm)</th>
                                    <th>Peso Volumétrico</th>
                                    <th>Peso que Predomina</th>
                                    <th>TOTAL PROPUESTA</th>
                                    <th>Descuento</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>Replicar en todos </td>
                                    <td></td>
                                    <td class="center"><input type="checkbox" class="center custom-control-input"  ng-model="block.blnSameFrec" ng-click="replicate('intFrecc', null, index, keyBlock)" /></td>
                                    <td></td>
                                    <td class="center"><input type="checkbox" class="center custom-control-input"  ng-model="block.blnSameQuoteG" ng-click="replicate('fltQuoteG', null, index, keyBlock)" /></td>
                                    <td></td>
                                    <td class="center" ng-show="isLastBlock(keyBlock, index)"><input type="checkbox" class="center custom-control-input"  ng-model="block.blnSameAditionalKG" ng-click="replicate('fltAditionalKG', null, index, keyBlock)" /></td>
                                    <td class="center" ng-show="OD.blnACK"><input type="checkbox" class="center custom-control-input"  ng-model="block.blnSameQuoteE" ng-click="replicate('fltQuoteE', null, index, keyBlock)" /></td>
                                    <td ng-show="OD.blnSEG"></td>
                                    <td class="center"><input type="checkbox" class="center custom-control-input"  ng-model="block.blnSameWeight" ng-click="replicate('fltWeight', null, index, keyBlock)" /></td>
                                    <td class="center"><input type="checkbox" class="center custom-control-input"  ng-model="block.blnSameLarge" ng-click="replicate('fltLarge', null, index, keyBlock)" /></td>
                                    <td class="center"><input type="checkbox" class="center custom-control-input"  ng-model="block.blnSameWidth" ng-click="replicate('fltWidth', null, index, keyBlock)" /></td>
                                    <td class="center"><input type="checkbox" class="center custom-control-input"  ng-model="block.blnSameHigh" ng-click="replicate('fltHigh', null, index, keyBlock)" /></td>
                                    <td colspan="4"></td>
                                </tr>
                                <tr ng-repeat="(keyRange, strRange) in OD.listRange">
                                    <td ng-bind="strRange"></td>
                                    <td class="center" ng-bind="block.ranges[keyRange].fltFullFee | currency" ></td>
                                    <td class="center thead-light" contenteditable="true" ng-bind="block.ranges[keyRange].intFrecuency | number" ng-blur="setValue('intFrecc', keyRange, $event, index, keyBlock)"></td>
                                    <td class="center" ng-bind="block.ranges[keyRange].fltQuoteFee | currency" ></td>
                                    <td class="center thead-light" contenteditable="true" ng-bind="block.ranges[keyRange].fltQuoteGuide | currency" ng-blur="setValue('fltQuoteG', keyRange, $event, index, keyBlock)" ng-class="{invalid: isNotValid('fltQuoteG', block.ranges[keyRange].fltQuoteGuide , keyBlock, index, keyRange) }"></td>
                                    <td class="center thead-light" contenteditable="true" ng-bind="block.fltBase | number:1" ng-blur="setValue('fltBase', keyRange, $event, index, keyBlock)" ng-class="{invalid: isNotValid('fltBase', block.fltBase , keyBlock, index, keyRange) }"></td>
                                    <td class="center thead-light" contenteditable="true" ng-bind="block.ranges[keyRange].fltAditionalKG | currency" ng-blur="setValue('fltAditionalKG', keyRange, $event, index, keyBlock)" ng-show="isLastBlock(keyBlock, index)"></td>
                                    <td class="center thead-light" contenteditable="true" ng-bind="block.ranges[keyRange].fltQuoteExtra | currency" ng-blur="setValue('fltQuoteE', keyRange, $event, index, keyBlock)" ng-show="OD.blnACK"></td>
                                    <td class="center thead-light" ng-bind="OD.fltAmountSEG | currency" ng-blur="setValue('fltQuoteE', keyRange, $event, index, keyBlock)" ng-show="OD.blnSEG"></td>
                                    <td class="center thead-light" contenteditable="true" ng-bind="block.ranges[keyRange].fltWeight | number:2" ng-blur="setValue('fltWeight', keyRange, $event, index, keyBlock)"></td>
                                    <td class="center thead-light" contenteditable="true" ng-bind="block.ranges[keyRange].fltLarge | number:2" ng-blur="setValue('fltLarge', keyRange, $event, index, keyBlock)"></td>
                                    <td class="center thead-light" contenteditable="true" ng-bind="block.ranges[keyRange].fltWidth | number:2" ng-blur="setValue('fltWidth', keyRange, $event, index, keyBlock)"></td>
                                    <td class="center thead-light" contenteditable="true" ng-bind="block.ranges[keyRange].fltHigh | number:2" ng-blur="setValue('fltHigh', keyRange, $event, index, keyBlock)"></td>
                                    <td class="center" ng-bind="block.ranges[keyRange].fltVolWeight | number:3" ></td>
                                    <td class="center" ng-bind="block.ranges[keyRange].fltDominantWeight | number:3" ></td>
                                    <td class="center" ng-bind="block.ranges[keyRange].fltTotalQuote | currency" ></td>
                                    <td class="center" ng-bind="block.ranges[keyRange].fltDisc | percentage:2" ></td>
                                </tr>
                                <tr>
                                    <td>Total </td>
                                    <td/>
                                    <td class="center" ng-bind="block.intTotalQ | number:0" ></td>
                                    <td colspan="5"/>
                                    <td ng-show="isLastBlock(keyBlock, index)"/>
                                    <td ng-show="OD.blnACK" />
                                    <td ng-show="OD.blnSEG" />
                                    <td colspan="4"/>
                                    <td class="center" ng-bind="block.intTotalQuote | currency" ></td>
                                    <td class="center" ng-bind="block.intTotalDisc | percentage:2" ></td>
                                </tr>
                                </tbody>
                            </table>
                            </div>
                            <div class="row" ng-repeat="(index, block) in listBlock" ng-show="isSelected(keyBlock)">
                                <div class="col-md-6 col-sm-6">
                                    <button class="btn btn-primary" ng-click="addBlock(keyBlock, index)" ng-show="isLastBlock(keyBlock, index)">Agregar bloque</button>

                                    <button class="btn btn-default" ng-click="removeBlock(keyBlock, index)" ng-show="index!== 0 && isLastBlock(keyBlock, index)">Eliminar bloque</button>
                                </div>
                                <div class="col-md-6 col-sm-6">
                                    <div class="row">
                                        <div class="alert alert-warning" role="alert" ng-repeat="strMessage in OD.lisMessages[keyBlock][index]">
                                            <span class="glyphicon glyphicon-info-sign"></span><span ng-bind="strMessage"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div ng-show="ODstep2">
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="panel panel-default" ng-repeat="(strFeeKey, fee) in OD.listFee" ng-show="OD.mapQuotes[strFeeKey].blnShow">
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
                                    <tr ng-repeat="(keyRange, strRange) in OD.listRange">
                                        <td class="thead-light" ng-bind="strRange"></td>
                                        <td ng-bind="OD.mapQuotes[strFeeKey].ranges[keyRange].fltAmount | currency"></td>
                                        <td ng-bind="OD.mapQuotes[strFeeKey].ranges[keyRange].fltRAD | currency" ></td>
                                        <td ng-bind="OD.mapQuotes[strFeeKey].ranges[keyRange].fltEAD | currency" ></td>
                                        <td ng-bind="OD.mapQuotes[strFeeKey].ranges[keyRange].fltACK | currency" ></td>
                                        <td ng-bind="OD.mapQuotes[strFeeKey].ranges[keyRange].fltAmountSeg | currency"></td>
                                        <td ng-bind="OD.mapQuotes[strFeeKey].ranges[keyRange].fltFullFee | currency"></td>
                                        <td ng-bind="OD.mapQuotes[strFeeKey].ranges[keyRange].fltQuoteFee | currency" ></td>
                                        <td ng-bind="OD.mapQuotes[strFeeKey].ranges[keyRange].intFrecuency | number" ></td>
                                        <td ng-bind="OD.mapQuotes[strFeeKey].ranges[keyRange].fltNormalFee | currency"></td>
                                        <td ng-bind="OD.mapQuotes[strFeeKey].ranges[keyRange].fltTotalQuote | currency"></td>
                                        <td ng-bind="OD.mapQuotes[strFeeKey].ranges[keyRange].fltDiscount | percentage:2"></td>
                                        <td ng-bind="ODZP.mapQuotes[strFeeKey].ranges[keyRange].fltAmount | currency" ng-hide="strFeeKey==='T7'"></td>
                                        <td ng-bind="ODZP.mapQuotes[strFeeKey].ranges[keyRange].fltEAD | currency"  ng-hide="strFeeKey==='T7'"></td>
                                        <td ng-bind="ODZP.mapQuotes[strFeeKey].ranges[keyRange].intFrecuency | number"  ng-hide="strFeeKey==='T7'"></td>
                                        <td ng-bind="ODZP.mapQuotes[strFeeKey].ranges[keyRange].fltFullFee | currency" ng-hide="strFeeKey==='T7'"></td>
                                        <td ng-bind="ODZP.mapQuotes[strFeeKey].ranges[keyRange].fltQuoteFee | currency"  ng-hide="strFeeKey==='T7'"></td>
                                        <td ng-bind="ODZP.mapQuotes[strFeeKey].ranges[keyRange].fltNormalFee | currency" ng-hide="strFeeKey==='T7'"></td>
                                        <td ng-bind="ODZP.mapQuotes[strFeeKey].ranges[keyRange].fltTotalQuote | currency" ng-hide="strFeeKey==='T7'"></td>
                                        <td ng-bind="ODZP.mapQuotes[strFeeKey].ranges[keyRange].fltDiscount | percentage:2" ng-hide="strFeeKey==='T7'"></td>
                                        <td ng-bind="OD.mapQuotes[strFeeKey].ranges[keyRange].fltVolAVR | number" ng-show="strFeeKey==='T7'" ></td>
                                        <td ng-bind="wrapper.mapTarifarioT['TARIFA T7V'][strRange].Flete__c | currency" ng-show="strFeeKey==='T7'"></td>
                                        <td ng-bind="OD.mapQuotes[strFeeKey].ranges[keyRange].fltWeightAVR | number" ng-show="strFeeKey==='T7'" ></td>
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
                                        <td><span class="center" ng-bind="OD.mapQuotes[strFeeKey].intFeeTotalFrec | number"></span></td>
                                        <td><span ng-bind="OD.mapQuotes[strFeeKey].fltFeeTotalNormal | number"></span></td>
                                        <td><span ng-bind="OD.mapQuotes[strFeeKey].fltFeeTotalQuote | currency"></span></td>
                                        <td><span ng-bind="OD.mapQuotes[strFeeKey].fltTotalDisc | percentage:2"></span></td>
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
                                        <td><span class="center" ng-bind="ODZP.mapQuotes[strFeeKey].intFeeTotalFrec | number"></span></td>
                                        <td><span ng-bind="ODZP.mapQuotes[strFeeKey].fltFeeTotalNormal | number"></span></td>
                                        <td><span ng-bind="ODZP.mapQuotes[strFeeKey].fltFeeTotalQuote | currency"></span></td>
                                        <td><span ng-bind="ODZP.mapQuotes[strFeeKey].fltTotalDisc | percentage:2"></span></td>
                                        <td></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default" ng-show="OD.mapQuotes['T7'].blnShow">
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
                                    <tr ng-repeat="(keyRange, strRange) in OD.listRange">
                                        <td class="thead-light" ng-bind="strRange"></td>
                                        <td ng-bind="OD.mapQuotes['T7V'].ranges[keyRange].fltAmount | currency"></td>
                                        <td ng-bind="OD.mapQuotes['T7V'].ranges[keyRange].fltRAD | currency" ></td>
                                        <td ng-bind="OD.mapQuotes['T7V'].ranges[keyRange].fltEAD | currency" ></td>
                                        <td ng-bind="OD.mapQuotes['T7V'].ranges[keyRange].fltACK | currency" ></td>
                                        <td ng-bind="OD.mapQuotes['T7V'].ranges[keyRange].fltAmountSeg | currency"></td>
                                        <td ng-bind="OD.mapQuotes['T7V'].ranges[keyRange].fltFullFee | currency"></td>
                                        <td ng-bind="OD.mapQuotes['T7V'].ranges[keyRange].fltQuoteFee | currency" ></td>
                                        <td ng-bind="OD.mapQuotes['T7V'].ranges[keyRange].intFrecuency | number" ></td>
                                        <td ng-bind="OD.mapQuotes['T7V'].ranges[keyRange].fltNormalFee | currency"></td>
                                        <td ng-bind="OD.mapQuotes['T7V'].ranges[keyRange].fltTotalQuote | currency"></td>
                                        <td ng-bind="OD.mapQuotes['T7V'].ranges[keyRange].fltDiscount | percentage:2"></td>
                                        <td ng-bind="OD.fltSEG | currency" ></td>
                                        <td ng-bind="OD.mapQuotes['T7V'].ranges[keyRange].fltVolAVR | number"></td>
                                    </tr>
                                    <tr>
                                        <td>Total</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td><span ng-bind="OD.mapQuotes['T7V'].intFeeTotalFrec | number"></span></td>
                                        <td><span ng-bind="OD.mapQuotes['T7V'].fltFeeTotalNormal | number"></span></td>
                                        <td><span ng-bind="OD.mapQuotes['T7V'].fltFeeTotalQuote | currency"></span></td>
                                        <td><span ng-bind="OD.mapQuotes['T7V'].fltTotalDisc | percentage:2"></span></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default" ng-show="OD.mapQuotes['T7'].blnShow">
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
                                    <tr ng-repeat="(keyRange, strRange) in OD.listRange">
                                        <td class="thead-light" ng-bind="strRange"></td>
                                        <td ng-bind="OD.mapQuotes['T7P'].ranges[keyRange].fltAmount | currency"></td>
                                        <td ng-bind="OD.mapQuotes['T7P'].ranges[keyRange].fltRAD | currency" ></td>
                                        <td ng-bind="OD.mapQuotes['T7P'].ranges[keyRange].fltEAD | currency" ></td>
                                        <td ng-bind="OD.mapQuotes['T7P'].ranges[keyRange].fltACK | currency" ></td>
                                        <td ng-bind="OD.mapQuotes['T7P'].ranges[keyRange].fltAmountSeg | currency"></td>
                                        <td ng-bind="OD.mapQuotes['T7P'].ranges[keyRange].fltFullFee | currency"></td>
                                        <td ng-bind="OD.mapQuotes['T7P'].ranges[keyRange].fltQuoteFee | currency" ></td>
                                        <td ng-bind="OD.mapQuotes['T7P'].ranges[keyRange].intFrecuency | number" ></td>
                                        <td ng-bind="OD.mapQuotes['T7P'].ranges[keyRange].fltNormalFee | currency"></td>
                                        <td ng-bind="OD.mapQuotes['T7P'].ranges[keyRange].fltTotalQuote | currency"></td>
                                        <td ng-bind="OD.mapQuotes['T7P'].ranges[keyRange].fltDiscount | percentage:2"></td>
                                        <td ng-bind="OD.fltSEG | currency" ></td>
                                        <td ng-bind="OD.mapQuotes['T7P'].ranges[keyRange].fltWeightAVR | number"></td>
                                    </tr>
                                    <tr>
                                        <td>Total</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td><span ng-bind="OD.mapQuotes['T7P'].intFeeTotalFrec | number"></span></td>
                                        <td><span ng-bind="OD.mapQuotes['T7P'].fltFeeTotalNormal | number"></span></td>
                                        <td><span ng-bind="OD.mapQuotes['T7P'].fltFeeTotalQuote | currency"></span></td>
                                        <td><span ng-bind="OD.mapQuotes['T7P'].fltTotalDisc | percentage:2"></span></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="row" ng-repeat="(keyBlock, listBlock) in ODEXP.mapBlock" >
                        <div class="panel panel-default" ng-show="isSelected(keyBlock)">
                            <div class="panel-heading">
                                <a data-toggle="collapse" href="#{{keyBlock}}"><h3 class="panel-title">FRECUENCIA DE ENVÍOS - {{  ODEXP.mapBlock[keyBlock][0].strLabel }}</h3></a>
                            </div>
                            <div id="{{keyBlock}}" class="panel-collapse collapse in">
                                <div class="panel-body">
                                    <div ng-repeat="(index, block) in listBlock" class="panel panel-default">
                                        <table class="table table-striped table-bordered">
                                            <thead class="thead-light">
                                            <tr>
                                                <th colspan="17"> BLOQUE {{index + 1}}</th>
                                            </tr>
                                            <tr>
                                                <th>Rango de KM</th>
                                                <th>Tarifa llena</th>
                                                <th>Seguro</th>
                                                <th># Paquetes (Frecuencia)</th>
                                                <th>Tarifa propuesta</th>
                                                <th>Guía arranque</th>
                                                <th>Kg arranque</th>
                                                <th ng-show="isLastBlock(keyBlock, index)">Kg adicional</th>
                                                <th ng-show="OD.blnACK">Costo de acuse</th>
                                                <th>Peso báscula</th>
                                                <th>Largo (cm)</th>
                                                <th>Ancho (cm)</th>
                                                <th>Alto (cm)</th>
                                                <th>Peso Volumétrico</th>
                                                <th>Peso que Predomina</th>
                                                <th>TOTAL NORMAL</th>
                                                <th>TOTAL PROPUESTA</th>
                                                <th>Descuento</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr ng-repeat="(keyRange, strRange) in OD.listRange">
                                                <td ng-bind="strRange"></td>
                                                <td class="center" ng-bind="block.ranges[keyRange].fltFullFee | currency"></td>
                                                <td class="center" ng-bind="block.fltSegAmount | currency"></td>
                                                <td class="center" ng-bind="block.ranges[keyRange].intFrecuency | number"></td>
                                                <td class="center" ng-bind="block.ranges[keyRange].fltQuoteFee | currency"></td>
                                                <td class="center" ng-bind="block.ranges[keyRange].fltQuoteGuide | currency"></td>
                                                <td class="center" ng-bind="block.fltBase | number:1"></td>
                                                <td class="center" ng-bind="block.ranges[keyRange].fltAditionalKG * (block.ranges[keyRange].fltDominantWeight - block.fltBase) | currency" ng-show="isLastBlock(keyBlock, index)"></td>
                                                <td class="center" ng-bind="block.ranges[keyRange].fltQuoteExtra | currency" ng-show="OD.blnACK"></td>
                                                <td class="center" ng-bind="block.ranges[keyRange].fltWeight | number:2"></td>
                                                <td class="center" ng-bind="block.ranges[keyRange].fltLarge | number:2"></td>
                                                <td class="center" ng-bind="block.ranges[keyRange].fltWidth | number:2"></td>
                                                <td class="center" ng-bind="block.ranges[keyRange].fltHigh | number:2"></td>
                                                <td class="center" ng-bind="block.ranges[keyRange].fltVolWeight | number:3" ></td>
                                                <td class="center" ng-bind="block.ranges[keyRange].fltDominantWeight | number:3"></td>
                                                <td class="center" ng-bind="block.ranges[keyRange].fltTotalFull | currency"></td>
                                                <td class="center" ng-bind="block.ranges[keyRange].fltTotalQuote | currency"></td>
                                                <td class="center" ng-bind="block.ranges[keyRange].fltDisc | percentage:2"></td>
                                            </tr>
                                            <tr>
                                                <td>Total </td>
                                                <td colspan="2"/>
                                                <td class="center" ng-bind="block.intTotalQ | number:0" ></td>
                                                <td colspan="5"/>
                                                <td ng-show="isLastBlock(keyBlock, index)"/>
                                                <td ng-show="OD.blnACK" />
                                                <td colaspan="4"/>
                                                <td class="center" ng-bind="block.intTotalFull | currency" ></td>
                                                <td class="center" ng-bind="block.intTotalQuote | currency" ></td>
                                                <td colaspan="3"/>
                                                <td class="center" ng-bind="block.intTotalDisc | percentage:2" ></td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="row" ng-repeat="(index, block) in listBlock" ng-show="isSelected(keyBlock)">
                                        <div class="col-md-6 col-sm-6">
                                            <button class="btn btn-primary" ng-click="addBlock(keyBlock, index)" ng-show="isLastBlock(keyBlock, index)">Agregar bloque</button>
                                        </div>
                                        <div class="col-md-6 col-sm-6">
                                            <div class="row">
                                                <div class="alert alert-warning" role="alert" ng-repeat="strMessage in OD.lisMessages[keyBlock][index]">
                                                    <span class="glyphicon glyphicon-info-sign"></span><span ng-bind="strMessage"></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--buttons-->
        <div class="row right">
            <div class="btn-group ">
                <button type="button" class="btn btn-primary" ng-click="redireccionar()" ng-show="OD.mapQuotes['T7'].blnShow">
                    Cotizar T7 zona plus
                </button>
                <button type="button" class="btn btn-default" ng-click="exit()">
                    <span class="glyphicon glyphicon-menu-left"></span> Salir
                </button>
                <button type="button" class="btn btn-primary" ng-show="hasRecord()" data-toggle="modal" data-target="#ModalApprovalOD">
                    Enviar a Autorización <span class="glyphicon glyphicon-check"></span>
                </button>
                <button type="button" class="btn btn-primary" ng-click="createQuotesOD()" ng-show="OD.blnBotonActivo">
                    Guardar <span class="glyphicon glyphicon-floppy-disk"></span>
                </button>
                <button type="button" class="btn btn-default" ng-click="backOD()" ng-show="ODstep2 && isAdmin()">
                    <span class="glyphicon glyphicon-menu-left"></span> Atras
                </button>
                <button type="button" class="btn btn-primary" ng-click="nextOD()" ng-show="ODstep1 && isAdmin()">
                    Siguiente <span class="glyphicon glyphicon-menu-right"></span>
                </button>
            </div>
        </div>
        <!--mensagges-->
        <div class="row center">
            <div class="col-sm-12 col-md-12">
                <!--<div class="alert alert-danger" role="alert" ng-show="!DML.blnSuccess && sent">
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
                <div class="modal fade" id="ODModalFee" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                                                <a href="#" class="list-group-item active">Tarifas Disponibles <input title="toggle all" type="checkbox" class="all pull-right" ng-model="OD.blnFeeAddAll" ng-click="addAll('fee', 'add')"/></a>
                                                <a href="#" class="list-group-item" ng-repeat="(i, fee) in OD.FeeSelect.available" ng-click="clickFee(i, 'feeAdd')">
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
                                                <a href="#" class="list-group-item active">Tarifas Seleccionadas <input title="toggle all" type="checkbox" class="all pull-right" ng-model="OD.blnFeeRemoveAll" ng-click="addAll('fee', 'remove')"/></a>
                                                <a href="#" class="list-group-item" ng-repeat="(i, fee) in OD.FeeSelect.selected" ng-click="clickFee(i, 'feeRemove')">
                                                    <span ng-bind="fee.label"></span>
                                                    <span class="glyphicon glyphicon-remove" ng-show="fee.blnSelected"/>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="center" ng-show="OD.mapQuotes['T7'].blnShow">
                                    <div class="alert alert-info" role="alert">
                                        Se ha seleccionado la Tarifa T7, debes elegir la modalidad de calculo.
                                    </div>
                                </div>
                                <div ng-show="OD.mapQuotes['T7'].blnShow">
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
                <div class="modal fade" id="ODModalServices" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                                                <a href="#" class="list-group-item active">Servicios Disponibles<input title="toggle all" type="checkbox" class="all pull-right" ng-model="OD.blnServiceAddAll" ng-click="addAll('service', 'add')"/></a>
                                                <a href="#" class="list-group-item" ng-repeat="(i, service) in OD.ServiceSelect.available" ng-click="clickFee(i, 'serviceAdd')">
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
                                                <a href="#" class="list-group-item active">Servicios Seleccionados <input title="toggle all" type="checkbox" class="all pull-right" ng-model="OD.blnServiceRemoveAll" ng-click="addAll('service', 'remove')"/></a>
                                                <a href="#" class="list-group-item" ng-repeat="(i, service) in OD.ServiceSelect.selected" ng-click="clickFee(i, 'serviceRemove')">
                                                    <span ng-bind="service.label"></span>
                                                    <span class="glyphicon glyphicon-remove" ng-show="service.blnSelected"/>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row custom-control custom-radio" ng-show="OD.blnACK">
                                    <div class="col-sm-1 col-md-1" />
                                    <div class="col-sm-3 col-md-3"><label class="custom-control-label" >Acuse a Empresa</label></div>
                                    <div class="col-sm-3 col-md-3"><input type="radio" class="custom-control-input" ng-model="OD.strAck" value="Empresa" ng-click="calculateEXPOD()"/></div>
                                    <div class="col-sm-2 col-md-2"><label class="custom-control-label" >Por Guía</label></div>
                                    <div class="col-sm-3 col-md-3"><input type="radio" class="custom-control-input" ng-model="OD.strAckCost" value="G" ng-click="calculateEXPOD()"/></div>
                                </div>
                                <div class="row custom-control custom-radio" ng-show="OD.blnACK">
                                    <div class="col-sm-1 col-md-1" />
                                    <div class="col-sm-3 col-md-3"><label class="custom-control-label" >Acuse a Interno</label></div>
                                    <div class="col-sm-3 col-md-3"><input type="radio" class="custom-control-input" ng-model="OD.strAck" value="Interno" ng-click="calculateEXPOD()"/></div>
                                    <div class="col-sm-2 col-md-2"><label class="custom-control-label" >Por Paquete</label></div>
                                    <div class="col-sm-3 col-md-3"><input type="radio" class="custom-control-input" ng-model="OD.strAckCost" value="P" ng-click="calculateEXPOD()"/></div>
                                </div>
                                <div class="row custom-control custom-radio" ng-show="OD.blnACK">
                                    <div class="col-sm-1 col-md-1" />
                                    <div class="col-sm-3 col-md-3"><label class="custom-control-label" >Acuse a XT</label></div>
                                    <div class="col-sm-3 col-md-3"><input type="radio" class="custom-control-input" ng-model="OD.strAck" value="XT" ng-click="calculateEXPOD()"/></div>
                                </div>
                                <div class="row custom-control custom-radio" ng-show="OD.blnSEG">
                                    <div class="col-sm-1 col-md-1" />
                                    <div class="col-sm-3 col-md-3"><label class="custom-control-label" >Monto asegurado</label></div>
                                    <div class="col-sm-3 col-md-3"><input type="number" class="custom-control-input rouded-med" ng-model="OD.fltSEG" ng-change="calculateEXPOD()"/></div>
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
                <div class="modal fade" id="ODModalQuickDisc" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                                    <div class="col-sm-3 col-md-3"><input type="number" class="custom-control-input rouded" ng-model="OD.fltGENDisc" ng-change="quickDisc('GENDISC')"/></div>

                                    <div class="col-sm-3 col-md-3"><label class="custom-control-label" >Costo flat general</label></div>
                                    <div class="col-sm-3 col-md-3"><input type="number" class="custom-control-input rouded" ng-model="OD.fltGENCost" ng-change="quickDisc('GENCOST')"/></div>
                                </div>
                                <br/><br/>
                                <div class="row custom-control custom-radio">
                                    <div class="col-md-6 col-sm-6 "><label class="custom-control-label" >Costo flat Tarifa</label></div>
                                    <div class="col-md-6 col-sm-6 "><label class="custom-control-label" >Costo flat Rango KM</label></div>
                                </div>
                                <div class="row custom-control custom-radio">
                                    <div class="col-md-6 col-sm-6">
                                        <div class="row"  ng-repeat="(idFee, labelFee) in OD.listFee" ng-show="OD.mapQuotes[idFee].blnShow">
                                            <div class="col-md-3 col-sm-3" />
                                            <div class="col-md-3 col-sm-3"><label class="custom-control-label" ng-bind="labelFee"></label></div>
                                            <div class="col-md-3 col-sm-3"><input type="number" class="custom-control-input rouded-med" ng-model="OD.mapQuotes[idFee].fltCost" ng-change="quickDisc('FEECOST')"/></div>
                                        </div>
                                        <div class="row" ng-show="isSelected('DS')">
                                            <div class="col-md-3 col-sm-3" />
                                            <div class="col-md-3 col-sm-3"><label class="custom-control-label" >ONE DAY</label></div>
                                            <div class="col-md-3 col-sm-3"><input type="number" class="custom-control-input rouded-med" ng-model="OD.mapQuotes['DS'].fltCost" ng-change="quickDisc('FEECOST')"/></div>
                                        </div>
                                        <div class="row" ng-show="isSelected('2D')">
                                            <div class="col-md-3 col-sm-3" />
                                            <div class="col-md-3 col-sm-3"><label class="custom-control-label" >TWO DAY</label></div>
                                            <div class="col-md-3 col-sm-3"><input type="number" class="custom-control-input rouded-med" ng-model="OD.mapQuotes['2D'].fltCost" ng-change="quickDisc('FEECOST')"/></div>
                                        </div>
                                        <div class="row" ng-show="isSelected('A12')">
                                            <div class="col-md-3 col-sm-3" />
                                            <div class="col-md-3 col-sm-3"><label class="custom-control-label" >MID DAY</label></div>
                                            <div class="col-md-3 col-sm-3"><input type="number" class="custom-control-input rouded-med" ng-model="OD.mapQuotes['A12'].fltCost" ng-change="quickDisc('FEECOST')"/></div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-sm-6">
                                        <div class="row" ng-repeat="(idRange, labelRange) in OD.listRange">
                                            <div class="col-md-3 col-sm-3" />
                                            <div class="col-md-3 col-sm-3"><label class="custom-control-label" ng-bind="labelRange" ></label></div>
                                            <div class="col-md-3 col-sm-3"><input type="number" class="custom-control-input rouded-med" ng-model="OD.mapRanges[idRange].fltCost" ng-change="quickDisc('RANGECOST')"/></div>
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
        <!--modal destinos-->
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <div class="modal fade" id="ODModalDestiny" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog big-modal" role="document">
                        <div class="modal-content big-modal">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Agregar Destinos</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-12 col-sm-12">
                                        <div class="row custom-control custom-radio">

                                            <div class="col-sm-3 col-md-3"><label class="custom-control-label" > Origen </label></div>
                                            <div class="col-sm-3 col-md-3"><input type="text" class="custom-control-input rouded" ng-model="OD.strOrigin" maxlength="3" ng-disabled="OD.OriginDisabled"/></div>

                                            <div class="col-sm-3 col-md-3"><label class="custom-control-label" > Destino </label></div>
                                            <div class="col-sm-3 col-md-3"><input type="text" class="custom-control-input rouded" ng-model="OD.strDestiny" maxlength="3"/></div>
                                        </div>
                                        <br/>
                                        <div class="row" ng-show="OD.OriginDisabled">
                                            <div class="col-md-4 col-sm-4">
                                                <div class="alert alert-warning" role="alert" >
                                                    <span class="glyphicon glyphicon-exclamation-sign"> Si modifica el Origen se eliminarán los destinos agregados</span>
                                                </div>
                                            </div>
                                            <div class="col-md-2 col-sm-2 ccenter">
                                                <button class="btn btn-primary" ng-click="editOrigin()">
                                                    Modificar Origen
                                                </button>
                                            </div>
                                        </div>
                                        <div class="row custom-control custom-radio">

                                            <div class="col-sm-6 col-md-6">
                                                <table class="table table-striped" >
                                                    <thead>
                                                    <tr>
                                                        <th> Destinos </th>
                                                        <th> Rango Km </th>
                                                        <th> Eliminar </th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <tr ng-repeat="(strDestinyKey, destiny) in OD.listDestiny" >
                                                        <td ng-bind="strDestinyKey"></td>
                                                        <td ng-bind="destiny.range"></td>
                                                        <td>
                                                            <button class="btn btn-danger" ng-click="removeDestiny(strDestinyKey)">
                                                                <span class="glyphicon glyphicon-minus"></span>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="col-sm-6 col-md-6">
                                                <div class="row">
                                                    <button type="button" class="btn btn-primary"
                                                            ng-click="addDestiny()">
                                                        Agregar destino <span class="glyphicon glyphicon-plus"></span>
                                                    </button>
                                                </div>
                                                <div class="row">
                                                    <div class="alert alert-danger" role="alert" ng-show="DestinyErrorMessage !==''">
                                                        <span ng-bind="DestinyErrorMessage"></span>
                                                    </div>
                                                    <div class="alert alert-success" role="alert" ng-show="DestinySuccessMessage !==''" >
                                                        <span ng-bind="DestinySuccessMessage"></span>
                                                    </div>
                                                </div>
                                            </div>

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
        <!--modal servicios especiales-->
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <div class="modal fade" id="ODModalSpecialService" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog big-modal" role="document" style="width: 95% !important;">
                        <div class="modal-content big-modal">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Agregar Servicios Especiales </h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body" style="overflow: scroll;">
                                <table class="table table-striped">
                                    <thead class="thead-light">
                                    <tr>
                                        <th>Rango KM</th>
                                        <th ng-repeat="(keySS, strSS) in SS.listService">
                                            <span ng-bind="strSS"></span>
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr ng-repeat="(keyRange, strRange) in OD.listRange">
                                        <td ng-bind="strRange"></td>
                                        <td class="thead-light" ng-repeat="(keyService, strService) in SS.listService">
                                            <span contenteditable="true" ng-bind="SS.ranges[keyRange].Service[keyService].fltAmount | currency" ng-blur="setValue('SSfltAmount', keyRange, $event, keyService)"></span>
                                            <select ng-options="option.label for option in SS.ranges[keyRange].Service[keyService].Option.aviableOptions" class="select" ng-model="SS.ranges[keyRange].Service[keyService].Option.model" ng-required="true" ng-change="calculateEXPOD()"></select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td ng-repeat="(keyService, strService) in SS.listService">
                                            <label>Principales Destinos:</label>
                                            <textarea cols="20" rows="4" ng-model="SS.service[keyService].mainDestinies"></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td ng-repeat="(keyService, strService) in SS.listService">
                                            <label>Potencial estimado en este servicio:</label>
                                            <span contenteditable="true" ng-bind="SS.service[keyService].potential | currency" ng-blur="setValue('SSfltPotencial', keyService, $event)" ></span>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
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
                <div class="modal fade" id="ModalApprovalOD" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
            app.controller('ODCController', ['$scope',function($scope) {

                /*
                * Controller variables
                */
                $scope.DeletedDestiny = [];
                $scope.Managers = [];
                $scope.OD = {
                    strAck : ''
                    , strApprovalComment : ''
                    , strAckCost : ''
                    , strOrigin : ''
                    , strDestiny : ''
                    , blnEAD: false
                    , blnRAD :false
                    , blnSEG : false
                    , blnMAN : false
                    , blnEDD : false
                    , blnEDC : false
                    , blnCRF : false
                    , fltSEG : 0
                    , blnZP : false
                    , fltAmountSEG : 0
                    , blnFeeAddAll : false
                    , blnServiceAddAll :false
                    , blnFeeRemoveAll : false
                    , blnServiceRemoveAll :false
                    , OriginDisabled : false
                    , OnlineDocByDestiny : false
                    , blnBotonActivo : true
                    , blnCotizaT7ZP : false
                    , strOrigen : ''
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
                    , listRange : {}
                    , OriginalListRange : {
                        '0-400': '0-400'
                        , '401-800': '401-800'
                        , '801-1200': '801-1200'
                        , '1201-1600': '1201-1600'
                        , '1601-2000': '1601-2000'
                        , '2001-2400': '2001-2400'
                        , '+2400' :'Más de 2400'
                    }
                    , listDestiny : {}
                    , mapQuotes:{

                    }
                    , mapTotal:{


                    }
                    , listRangePrecio : {

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
                    , lisMessages : {
                        'DS' : [{ }]
                        , '2D' : [{ }]
                        , 'A12' : [{ }]
                    }
                };
                $scope.OD.listRangePrecio['T7V'] = {
                    ranges : {}
                }
                $scope.OD.listRangePrecio['T7P'] = {
                    ranges : {}
                }
                $scope.OD.mapQuotes['T7V'] = {
                    ranges : []
                    , intFeeTotalQ : 0
                    , fltFeeTotalFrec:0
                    , blnShow: false
                    , blnSameFrecuency : false
                    , blnSameQuote : false
                    , blnSameVolAVR : false
                };
                $scope.OD.mapQuotes['T7P'] = {
                    ranges : []
                    , intFeeTotalQ : 0
                    , fltFeeTotalFrec:0
                    , blnShow: false
                    , blnSameFrecuency : false
                    , blnSameQuote : false
                    , blnSameWeigthAVR: false
                };
                $scope.OD.mapTender = {};
                $scope.OD.mapPropuesta = {};
                $scope.OD.mapQuotesT7ZP = {
                    Tender : []
                    , intFeeTotalFrec : 0
                    , fltFeeTotalNormal : 0
                    , fltFeeTotalQuote : 0
                    , fltFeeTotalSEG : 0
                    , fltFeeTotalDesc : 0
                    , blnSameFrecuency : false
                    , blnSameQuote : false
                    , blnSameWeigth : false
                    , blnSameVol : false
                    , blnSameHigh : false
                    , blnSameLarge : false
                    , blnSameAncho : false
                }
                $scope.OD.mapPropuesta['PROP'] = {
                    ranges : []
                    , intFeeTotalFrec : 0
                    , fltFeeTotalNormal : 0
                    , fltFeeTotalQuote : 0
                    , fltFeeTotalSEG : 0
                    , fltFeeTotalDesc : 0
                    , fltDisc : 0
                    , blnSameQuote : false
                };
                $scope.OD.TOTAL['NORMAL'] = 0;
                $scope.OD.TOTAL['PROPUESTA'] = 0;
                $scope.OD.TOTAL['DESCUENTO'] = 0;
                $scope.OD.TOTAL['PAQUETES'] = 0;
                $scope.OD.TOTAL['SEGURO'] = 0;
                $scope.ODZP = {
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

                    }
                    , mapQuotes:{

                    }
                    , mapTotal:{


                    }

                };
                $scope.ODstep1 = true;
                $scope.ODstep2 = false;
                $scope.sent = false;
                $scope.DestinyErrorMessage = '';
                $scope.DestinySuccessMessage = '';
                $scope.SS = {
                    service : []
                    , ranges : []
                    , listService: {
                        'MAN': 'Maniobras'
                        , 'EDC': 'EAD con cita'
                        , 'EDD': 'EAD a Detalle'
                        , 'SPK': 'Special Packing'
                        , 'PAP': 'Pick&Pack'
                        , 'CRF': 'Cruce Fronterizo'
                    }
                    , listOption : {
                        'G' : 'Guía'
                        , 'P' : 'Paquete'
                        , 'K' : 'kg báscula'
                    }
                };
                $scope.SuccessMessage = '';
                $scope.OD.mapRanges = {};
                $scope.ODEXP = {
                    listFeeEXP : {
                        'DS' : 'SEG-DS'
                        , '2D' : 'SEG-2D'
                        , 'A12' : 'SEG-A12'
                    }
                    , mapBlock : {}
                };
                $scope.MapQuoteLineEXP = {};
                $scope.SetBlocks = [];
                $scope.OD.FeeSelect.available.sort(function (a, b) {
                    if (a.order > b.order) {
                        return 1;
                    }
                    if (a.order < b.order) {
                        return -1;
                    }
                    // a must be equal to b
                    return 0;
                });
                $scope.OD.FeeSelect.selected.sort(function (a, b) {
                    if (a.order > b.order) {
                        return 1;
                    }
                    if (a.order < b.order) {
                        return -1;
                    }
                    // a must be equal to b
                    return 0;
                });
                $scope.listQLineDEL = [];
                j$.each(
                        $scope.OD.listFee
                        , function(keyFee, fee){
                            $scope.OD.mapQuotes[keyFee] = {
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
                        }
                );
                j$.each(
                        $scope.ODZP.listFee
                        , function(keyFee, fee){
                            $scope.ODZP.mapQuotes[keyFee] = {
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
                                j$.each($scope.OD.FeeSelect.available, function (i, fee) {
                                    fee.blnSelected = $scope.OD.blnFeeAddAll;
                                });
                            else if(strOpr === 'remove')
                                j$.each($scope.OD.FeeSelect.selected, function (i, fee) {
                                    fee.blnSelected = $scope.OD.blnFeeRemoveAll;
                                });
                            break;
                        case 'service':
                            if(strOpr === 'add')
                                j$.each($scope.OD.ServiceSelect.available, function (i, serv) {
                                    serv.blnSelected = $scope.OD.blnServiceAddAll;
                                });
                            else if(strOpr === 'remove')
                                j$.each($scope.OD.ServiceSelect.selected, function (i, serv) {
                                    serv.blnSelected = $scope.OD.blnServiceRemoveAll;;
                                });
                            break;
                    }
                };

                $scope.addBlock = function(key, index){
                    if(notEmpty(index))
                        j$.each($scope.OD.listRange, function (keyRange, strRange) {
                            $scope.ODEXP.mapBlock[key][index].ranges[keyRange].fltAditionalKG = 0;
                        });
                    var block = {
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
                        , strLabel : ''
                        , fltBase : 0
                    };
                    switch (key) {
                        case 'DS':
                            block.strLabel = 'DÍA SIGUIENTE (ONE\'DAY)';
                            break;
                        case '2D':
                            block.strLabel = 'DOS DÍAS (TWO\'DAYS)';
                            break;
                        case 'A12':
                            block.strLabel = 'ANTES DE LAS 12 (MID\'DAY)';
                            break;
                    };
                    j$.each($scope.OD.listRange, function (keyRange, labelRange) {
                        block.ranges[keyRange] = {
                            intFrecuency : 0
                            , fltFrecuency :0
                            , fltWeight : 0
                            , fltVol : 0
                            , fltVolWeight : 0
                            , fltDominantWeight : 0
                            , fltLarge : 0
                            , fltHigh : 0
                            , fltWidth : 0
                            , fltAmount : 0
                            , fltFullFee : 0
                            , fltTotalFull : 0
                            , fltQuoteFee : 0
                            , fltQuoteGuide : 0
                            , fltAditionalKG : 0
                            , fltQuoteExtra : $scope.ODEXP.mapBlock[key][0].ranges[keyRange].fltQuoteExtra
                            , fltTotalQuote : 0
                            , fltDisc : 0
                            , fltDiscKgAdd : 0
                        };
                    });
                    $scope.ODEXP.mapBlock[key].push(block);
                    $scope.OD.lisMessages[key].push({});
                    $scope.calculateEXPOD();
                };

                $scope.addDestiny = function(){
                    $scope.OD.OriginDisabled = true;
                    $scope.DestinyErrorMessage = '';
                    $scope.DestinySuccessMessage = '';
                    if(notEmpty($scope.OD.strOrigin)
                            && notEmpty($scope.OD.strDestiny)
                            && $scope.OD.strDestiny.length == 3
                            && !isIn($scope.OD.strDestiny, $scope.OD.listDestiny)
                    )
                        callCheckDestiny($scope);
                    else if(!notEmpty($scope.OD.strOrigin))
                        $scope.DestinyErrorMessage = 'Debe agregar un origen';
                    else if(!notEmpty($scope.OD.strDestiny))
                        $scope.DestinyErrorMessage = 'Debe agregar un destino';
                    else if(notEmpty($scope.OD.strDestiny) && $scope.OD.strDestiny.length < 3)
                        $scope.DestinyErrorMessage = 'El destino tener una longitud de 3 letras';

                };

                $scope.addFee = function(fee){
                    var index =  j$.inArray(fee, $scope.OD.FeeSelect.available);
                    $scope.OD.FeeSelect.available.splice(index, 1);
                    $scope.OD.FeeSelect.selected.push(fee);
                    $scope.OD.FeeSelect.selected.sort(function (a, b) {
                        /*if (a.order > b.order) {
                            return 1;
                        }
                        if (a.order < b.order) {
                            return -1;
                        }
                        // a must be equal to b
                        return 0;*/
                        return(a.order - b.order);
                    });
                    if(notEmpty(fee.id) && fee.id != 'DS' && fee.id != '2D' && fee.id != 'A12')
                        $scope.OD.mapQuotes[fee.id].blnShow = true;
                    if(fee.id == 'T7')
                        $scope.calculateEXPOD();
                };

                $scope.addService = function(service){
                    var index =  j$.inArray(service, $scope.OD.ServiceSelect.available);
                    $scope.OD.ServiceSelect.available.splice(index, 1);
                    $scope.OD.ServiceSelect.selected.push(service);
                    switch (service.id) {
                        case 'EAD':
                            $scope.OD.blnEAD = true;
                            break;
                        case 'RAD':
                            $scope.OD.blnRAD = true;
                            break;
                        case 'SEG':
                            $scope.OD.blnSEG = true;
                            break;
                        case 'ACK':
                            $scope.OD.blnACK = true;
                            break;

                    }

                };

                $scope.backOD = function(){
                    $scope.ODstep1 = true;
                    $scope.ODstep2 = false;
                };

                $scope.calculateDimensionsOD = function(fee, key, index){
                    $scope.ODEXP.mapBlock[fee][index].ranges[key].fltVol = ($scope.ODEXP.mapBlock[fee][index].ranges[key].fltLarge
                                                                            * $scope.ODEXP.mapBlock[fee][index].ranges[key].fltWidth
                                                                            * $scope.ODEXP.mapBlock[fee][index].ranges[key].fltHigh) / 100;
                    $scope.ODEXP.mapBlock[fee][index].ranges[key].fltVolWeight = ($scope.ODEXP.mapBlock[fee][index].ranges[key].fltLarge
                                                                                * $scope.ODEXP.mapBlock[fee][index].ranges[key].fltWidth
                                                                                * $scope.ODEXP.mapBlock[fee][index].ranges[key].fltHigh) / $scope.Wrapper.mapCS['CPV'];

                    if($scope.ODEXP.mapBlock[fee][index].ranges[key].fltVolWeight > $scope.ODEXP.mapBlock[fee][index].ranges[key].fltWeight)
                        $scope.ODEXP.mapBlock[fee][index].ranges[key].fltDominantWeight = $scope.ODEXP.mapBlock[fee][index].ranges[key].fltVolWeight;
                    else
                        $scope.ODEXP.mapBlock[fee][index].ranges[key].fltDominantWeight = $scope.ODEXP.mapBlock[fee][index].ranges[key].fltWeight;
                    $scope.calculateEXPOD();
                };

                $scope.calculateEXPOD = function(){
                    $scope.OD.TOTAL['NORMAL-STD'] = 0;
                    $scope.OD.TOTAL['PROPUESTA-STD'] = 0;
                    $scope.OD.TOTAL['DESCUENTO-STD'] = 0;

                    $scope.OD.TOTAL['NORMAL-SEG'] = 0;
                    $scope.OD.TOTAL['PROPUESTA-SEG'] = 0;
                    $scope.OD.TOTAL['DESCUENTO-SEG'] = 0;
                    $scope.OD.TOTAL['SEGURO-SEG'] = 0;

                    $scope.OD.TOTAL['NORMAL'] = 0;
                    $scope.OD.TOTAL['PROPUESTA'] = 0;
                    $scope.OD.TOTAL['DESCUENTO'] = 0;
                    $scope.OD.TOTAL['PAQUETES'] = 0;
                    $scope.OD.TOTAL['SEGURO'] = 0;

                    $scope.calculateOD();

                    $scope.OD.TOTAL['NORMAL-STD']       = $scope.OD.TOTAL['NORMAL'];
                    $scope.OD.TOTAL['PROPUESTA-STD']    = $scope.OD.TOTAL['PROPUESTA'];
                    $scope.OD.TOTAL['SEGURO-STD']       = $scope.OD.TOTAL['SEGURO'];
                    $scope.OD.TOTAL['DESCUENTO-STD']    = ($scope.OD.TOTAL['PROPUESTA-STD'] - $scope.OD.TOTAL['SEGURO-STD'] ) / ($scope.OD.TOTAL['NORMAL-STD'] - $scope.OD.TOTAL['SEGURO-STD']) -1;

                    j$.each($scope.ODEXP.listFeeEXP, function (keyFee, labelFee) {
                        if($scope.isSelected(keyFee))
                            j$.each($scope.ODEXP.mapBlock[keyFee], function (i, block) {
                                var segAmount = 0;
                                block.intTotalQ = 0;
                                block.intTotalQuote = 0;
                                block.intTotalFull = 0;
                                j$.each(block.ranges, function (keyRange, range) {
                                    if(range.intFrecuency > 0){
                                        var strRange = getLabel(keyRange, $scope.OD.listRange);
                                        if(!getId(strRange, $scope.OD.OriginalListRange))
                                            strRange = getRange(strRange);
                                        if(notEmpty(strRange)) {
                                            var segRange = 0;
                                            block.intTotalQ += range.intFrecuency;
                                            // Normal Fee
                                            range.fltFullFee = $scope.Wrapper.mapTarifarioEXP[keyFee][strRange].GuiaDeArranque1Kg__c
                                                    + ($scope.Wrapper.mapTarifarioEXP[keyFee][strRange].Kg_adicional__c * (range.fltDominantWeight - 1));

                                            if ($scope.OD.blnACK && $scope.OD.strAck)
                                                range.fltFullFee += $scope.Wrapper.mapACK[$scope.OD.strAck];
                                            if ($scope.OD.blnSEG)
                                                block.fltSegAmount = $scope.OD.fltAmountSEG;
                                            else
                                                block.fltSegAmount = 0;

                                            range.fltFullFee += block.fltSegAmount;
                                            segRange += block.fltSegAmount * range.intFrecuency;


                                            range.fltTotalFull = range.fltFullFee * range.intFrecuency;
                                            block.intTotalFull += range.fltTotalFull;

                                            // Quote Fee
                                            range.fltQuoteFee = range.fltQuoteGuide;

                                            //ADD KG
                                            if(range.fltDominantWeight > block.fltBase) {
                                                range.fltQuoteFee += range.fltAditionalKG * (range.fltDominantWeight - block.fltBase);
                                            }
                                            if(range.fltAditionalKG > 0 )
                                            range.fltDiscKgAdd = range.fltAditionalKG / $scope.Wrapper.mapTarifarioEXP[keyFee][strRange].Kg_adicional__c -1;

                                            //ACK
                                            if ($scope.OD.blnACK && range.fltQuoteFee > 0)
                                                range.fltQuoteFee += range.fltQuoteExtra;
                                            //SEG
                                            if ($scope.OD.blnSEG && range.fltQuoteFee > 0)
                                                range.fltQuoteFee += $scope.OD.fltAmountSEG;

                                            range.fltTotalQuote = range.fltQuoteFee * range.intFrecuency;
                                            block.intTotalQuote += range.fltTotalQuote;

                                            range.fltDisc = (range.fltTotalQuote - segRange ) / (range.fltTotalFull - segRange) - 1;
                                        }
                                    }
                                });
                                segAmount = block.intTotalQ * block.fltSegAmount;
                                block.intTotalDisc = (block.intTotalQuote - segAmount) / (block.intTotalFull - segAmount) -1;
                                $scope.OD.TOTAL['NORMAL-SEG']       += block.intTotalFull;
                                $scope.OD.TOTAL['PROPUESTA-SEG']    += block.intTotalQuote;
                                $scope.OD.TOTAL['SEGURO-SEG']       += segAmount;
                                $scope.OD.TOTAL['PAQUETES']         += block.intTotalQ;
                            });

                    });

                    $scope.OD.TOTAL['DESCUENTO-SEG']    = ($scope.OD.TOTAL['PROPUESTA-SEG'] - $scope.OD.TOTAL['SEGURO-SEG'] ) / ($scope.OD.TOTAL['NORMAL-SEG'] - $scope.OD.TOTAL['SEGURO-SEG']) -1;

                    $scope.OD.TOTAL['NORMAL'] += $scope.OD.TOTAL['NORMAL-SEG'];
                    $scope.OD.TOTAL['PROPUESTA'] += $scope.OD.TOTAL['PROPUESTA-SEG'];
                    $scope.OD.TOTAL['SEGURO'] += $scope.OD.TOTAL['SEGURO-SEG'];

                    $scope.OD.TOTAL['DESCUENTO'] = ($scope.OD.TOTAL['PROPUESTA']  - $scope.OD.TOTAL['SEGURO']) / ($scope.OD.TOTAL['NORMAL'] - $scope.OD.TOTAL['SEGURO']) -1;

                    /* Special Service */
                    j$.each($scope.SS.listService, function (keyService, strService) {
                        if(getLabel(keyService, $scope.SS.service)){
                            $scope.OD.TOTAL['NORMAL']  += $scope.SS.service[keyService].potential;
                            $scope.OD.TOTAL['PROPUESTA'] += $scope.SS.service[keyService].potential;
                        }
                    });

                };

                $scope.calculateOD = function(){
                    $scope.sent = false;
                    if($scope.OD.blnSEG) {
                        $scope.OD.fltAmountSEG = ($scope.Wrapper.mapCS['SEG'] / 1000) * $scope.OD.fltSEG;
                        $scope.ODZP.fltAmountSEG = ($scope.Wrapper.mapCS['SEG'] / 1000) * $scope.OD.fltSEG;
                    }

                    j$.each($scope.ODZP.listFee
                            , function (keyFee, strFee) {
                                $scope.OD.mapQuotes[keyFee].intFeeTotalFrec = 0;
                                $scope.OD.mapQuotes[keyFee].fltFeeTotalDesc = 0;
                                $scope.OD.mapQuotes[keyFee].fltFeeTotalNormal = 0;
                                $scope.OD.mapQuotes[keyFee].fltFeeTotalQuote = 0;
                                $scope.OD.mapQuotes[keyFee].fltFeeTotalSEG = 0;
                                if(keyFee !== 'T7'){
                                    $scope.ODZP.mapQuotes[keyFee].intFeeTotalFrec = 0;
                                    $scope.ODZP.mapQuotes[keyFee].fltFeeTotalDesc = 0;
                                    $scope.ODZP.mapQuotes[keyFee].fltFeeTotalNormal = 0;
                                    $scope.ODZP.mapQuotes[keyFee].fltFeeTotalQuote = 0;
                                    $scope.ODZP.mapQuotes[keyFee].fltFeeTotalSEG = 0;
                                }
                                if($scope.OD.mapQuotes[keyFee].blnShow)
                                    j$.each($scope.OD.listRange
                                            ,function (keyRange, strRange) {
                                                if(keyFee !== 'T7')
                                                    $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltEAD = $scope.Wrapper.mapCS['AEZP'];

                                                if (!$scope.exceptionAD(keyFee)) {
                                                    if ($scope.OD.blnEAD) {
                                                        $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltEAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinEAD'], $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltAmount );
                                                    } else
                                                        $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltEAD = 0;

                                                    if ($scope.OD.blnRAD){
                                                        $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltRAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinRAD'], $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltAmount);
                                                        $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltRAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinRAD'], $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltAmount);
                                                    }

                                                    else {
                                                        $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltRAD = 0;
                                                        $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltRAD = 0;
                                                    }
                                                    if ($scope.OD.blnSEG) {
                                                        $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg = $scope.OD.fltAmountSEG;
                                                        $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg = $scope.OD.fltAmountSEG;
                                                    } else {
                                                        $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg = 0;
                                                        $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg = 0;
                                                    }

                                                }

                                                if($scope.OD.blnACK && notEmpty($scope.OD.strAck) && $scope.Wrapper.mapACK[$scope.OD.strAck]) {
                                                        $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltACK = $scope.Wrapper.mapACK[$scope.OD.strAck];
                                                        $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltACK = $scope.Wrapper.mapACK[$scope.OD.strAck];
                                                }
                                                else{
                                                    $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltACK = 0;
                                                    $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltACK = 0;
                                                }

                                                $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltFullFee = $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltAmount
                                                        + $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltACK
                                                        + $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltEAD
                                                        + $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltRAD
                                                        + $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg;

                                                $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltFullFee = $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltAmount
                                                        + $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltACK
                                                        + $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltEAD
                                                        + $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltRAD
                                                        + $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg;

                                                // Costo General
                                                if(keyFee !== 'T7' && $scope.OD.fltGENCost > 0 && notEmpty(getId(strRange, $scope.OD.OriginalListRange)) && $scope.OnlineDocByRangeKM){
                                                    $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee = $scope.OD.fltGENCost;
                                                    $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee = $scope.OD.fltGENCost;
                                                } else if(keyFee !== 'T7' && $scope.OD.fltGENCost > 0 && $scope.OnlineDocByDestiny && !$scope.OnlineDocByRangeKM){
                                                    $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee = $scope.OD.fltGENCost;
                                                    $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee = $scope.OD.fltGENCost;
                                                }

                                                // Descuento general
                                                if($scope.OD.fltGENDisc > 0 && notEmpty(getId(strRange, $scope.OD.OriginalListRange)) && $scope.OnlineDocByRangeKM) {
                                                    $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee = $scope.desc($scope.OD.mapQuotes[keyFee].ranges[keyRange].fltFullFee - $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg, $scope.OD.fltGENDisc) + $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg;
                                                    if (keyFee !== 'T7')
                                                        $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee = $scope.desc($scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltFullFee - $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg, $scope.OD.fltGENDisc) + $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg;
                                                } else if($scope.OD.fltGENDisc > 0 && $scope.OnlineDocByDestiny  && !$scope.OnlineDocByRangeKM){
                                                    $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee = $scope.desc($scope.OD.mapQuotes[keyFee].ranges[keyRange].fltFullFee - $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg, $scope.OD.fltGENDisc) + $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg;
                                                    if (keyFee !== 'T7')
                                                        $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee = $scope.desc($scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltFullFee - $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg, $scope.OD.fltGENDisc) + $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg;
                                                }

                                                //	Costo flat por tarifa
                                                if($scope.OD.mapQuotes[keyFee].fltCost > 0 && notEmpty(getId(strRange, $scope.OD.OriginalListRange)) && $scope.OnlineDocByRangeKM) {
                                                    $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee = $scope.OD.mapQuotes[keyFee].fltCost;
                                                    $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee =  $scope.OD.mapQuotes[keyFee].fltCost;
                                                } else if($scope.OD.mapQuotes[keyFee].fltCost > 0 && $scope.OnlineDocByDestiny  && !$scope.OnlineDocByRangeKM){
                                                    $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee = $scope.OD.mapQuotes[keyFee].fltCost;
                                                    $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee =  $scope.OD.mapQuotes[keyFee].fltCost;
                                                }

                                                //Costo por Rango KM
                                                if($scope.OD.mapRanges[keyRange].fltCost > 0 ){
                                                    $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee =  $scope.OD.mapRanges[keyRange].fltCost;
                                                    $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee = $scope.OD.mapRanges[keyRange].fltCost;
                                                }

                                                if(keyFee !== 'T7' && keyFee !== 'T7V' && keyFee !== 'T7P'){
                                                    $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltNormalFee = $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltFullFee * $scope.OD.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                    $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote = $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee * $scope.OD.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                    if($scope.OD.mapQuotes[keyFee].ranges[keyRange].fltNormalFee > 0)
                                                        $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltDiscount = ($scope.OD.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote - $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg * $scope.OD.mapQuotes[keyFee].ranges[keyRange].intFrecuency)
                                                                / ($scope.OD.mapQuotes[keyFee].ranges[keyRange].fltNormalFee - $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg * $scope.OD.mapQuotes[keyFee].ranges[keyRange].intFrecuency)  -1;
                                                    else
                                                        $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltDiscount = 0;

                                                    $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltNormalFee = $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltFullFee * $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                    $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote = $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee * $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                    if($scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltNormalFee > 0)
                                                        $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltDiscount = ($scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote - $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg * $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency)
                                                                / ($scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltNormalFee - $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg * $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency)  -1;
                                                    else
                                                        $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltDiscount = 0;

                                                    $scope.OD.mapQuotes[keyFee].fltFeeTotalNormal += $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltNormalFee;
                                                    $scope.OD.mapQuotes[keyFee].intFeeTotalFrec += $scope.OD.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                    $scope.OD.mapQuotes[keyFee].fltFeeTotalQuote += $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote;
                                                    if($scope.OD.mapQuotes[keyFee].ranges[keyRange].intFrecuency > 0)
                                                        $scope.OD.mapQuotes[keyFee].fltFeeTotalSEG += $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg * $scope.OD.mapQuotes[keyFee].ranges[keyRange].intFrecuency;

                                                    if($scope.ODZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency > 0){
                                                        $scope.ODZP.mapQuotes[keyFee].fltFeeTotalNormal += $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltNormalFee;
                                                        $scope.ODZP.mapQuotes[keyFee].intFeeTotalFrec += $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                        $scope.ODZP.mapQuotes[keyFee].fltFeeTotalQuote += $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote;
                                                        $scope.ODZP.mapQuotes[keyFee].fltFeeTotalSEG += $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg * $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                    }
                                                }
                                            }
                                    );

                                if($scope.OD.mapQuotes[keyFee].fltFeeTotalNormal > 0)
                                    $scope.OD.mapQuotes[keyFee].fltFeeTotalDesc = ($scope.OD.mapQuotes[keyFee].fltFeeTotalQuote - $scope.OD.mapQuotes[keyFee].fltFeeTotalSEG)
                                            / ($scope.OD.mapQuotes[keyFee].fltFeeTotalNormal - $scope.OD.mapQuotes[keyFee].fltFeeTotalSEG) - 1;

                                if(keyFee !== 'T7' && $scope.ODZP.mapQuotes[keyFee].fltFeeTotalNormal > 0)
                                    $scope.ODZP.mapQuotes[keyFee].fltFeeTotalDesc = ($scope.ODZP.mapQuotes[keyFee].fltFeeTotalQuote - $scope.ODZP.mapQuotes[keyFee].fltFeeTotalSEG)
                                            / ($scope.ODZP.mapQuotes[keyFee].fltFeeTotalNormal - $scope.ODZP.mapQuotes[keyFee].fltFeeTotalSEG) - 1;

                                if(keyFee !== 'T7' && keyFee !== 'T7V' && keyFee !== 'T7P'){
                                    $scope.OD.TOTAL['NORMAL'] += $scope.OD.mapQuotes[keyFee].fltFeeTotalNormal + $scope.ODZP.mapQuotes[keyFee].fltFeeTotalNormal;
                                    $scope.OD.TOTAL['PROPUESTA'] += $scope.OD.mapQuotes[keyFee].fltFeeTotalQuote + $scope.ODZP.mapQuotes[keyFee].fltFeeTotalQuote;
                                    $scope.OD.TOTAL['PAQUETES'] += $scope.OD.mapQuotes[keyFee].intFeeTotalFrec + $scope.ODZP.mapQuotes[keyFee].intFeeTotalFrec;
                                    $scope.OD.TOTAL['SEGURO'] += $scope.OD.mapQuotes[keyFee].fltFeeTotalSEG + $scope.ODZP.mapQuotes[keyFee].fltFeeTotalSEG;
                                }

                            }
                    );

                    if($scope.OD.TOTAL['NORMAL'] > 0)
                        $scope.OD.TOTAL['DESCUENTO'] = ($scope.OD.TOTAL['PROPUESTA'] - $scope.OD.TOTAL['SEGURO'])
                                / ($scope.OD.TOTAL['NORMAL'] - $scope.OD.TOTAL['SEGURO']) -1;

                    $scope.OD.mapQuotes['T7'].intFeeTotalFrec = 0;
                    $scope.OD.mapQuotes['T7'].fltFeeTotalNormal = 0;
                    $scope.OD.mapQuotes['T7'].fltFeeTotalQuote = 0;
                    $scope.OD.mapQuotes['T7'].fltFeeTotalSEG = 0;
                    $scope.OD.mapQuotes['T7V'].intFeeTotalFrec = 0;
                    $scope.OD.mapQuotes['T7V'].fltFeeTotalNormal = 0;
                    $scope.OD.mapQuotes['T7V'].fltFeeTotalQuote = 0;
                    $scope.OD.mapQuotes['T7V'].fltFeeTotalSEG = 0;
                    $scope.OD.mapQuotes['T7P'].intFeeTotalFrec = 0;
                    $scope.OD.mapQuotes['T7P'].fltFeeTotalNormal = 0;
                    $scope.OD.mapQuotes['T7P'].fltFeeTotalQuote = 0;
                    $scope.OD.mapQuotes['T7P'].fltFeeTotalSEG = 0;

                    if($scope.OD.mapQuotes['T7'].blnShow)
                        j$.each($scope.OD.listRange
                                ,function (keyRange, strRange) {

                                    if ($scope.OD.blnEAD) {
                                        $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltEAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinEAD'], $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltAmount * $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltVolAVR);
                                        $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltEAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinEAD'], $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltAmount * $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltWeightAVR);
                                    } else {
                                        $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltEAD = 0;
                                        $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltEAD = 0;
                                    }
                                    if ($scope.OD.blnRAD) {
                                        $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltRAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinRAD'], $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltAmount * $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltVolAVR);
                                        $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltRAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinRAD'], $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltAmount * $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltWeightAVR);
                                    } else {
                                        $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltRAD = 0;
                                        $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltRAD = 0;
                                    }
                                    if ($scope.OD.blnSEG) {
                                        $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltAmountSeg = $scope.OD.fltAmountSEG;
                                        $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltAmountSeg = $scope.OD.fltAmountSEG;
                                    } else {
                                        $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltAmountSeg = 0;
                                        $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltAmountSeg = 0;
                                    }
                                    if($scope.OD.blnACK && notEmpty($scope.OD.strAck) && $scope.Wrapper.mapACK[$scope.OD.strAck]) {
                                            $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltACK = $scope.Wrapper.mapACK[$scope.OD.strAck];
                                            $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltACK = $scope.Wrapper.mapACK[$scope.OD.strAck];
                                    }else{
                                        $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltACK = 0;
                                        $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltACK = 0;
                                    }

                                    if($scope.PPT7Calc === 'byDelivery'){
                                        $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltVolAVR =  $scope.OD.mapQuotes['T7'].ranges[keyRange].fltVolAVR;
                                        $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltWeightAVR = $scope.OD.mapQuotes['T7'].ranges[keyRange].fltWeightAVR;
                                        $scope.OD.mapQuotes['T7V'].ranges[keyRange].intFrecuency = $scope.OD.mapQuotes['T7'].ranges[keyRange].intFrecuency;
                                        $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltQuoteFee = $scope.OD.mapQuotes['T7'].ranges[keyRange].fltQuoteFee;

                                        $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltVolAVR = $scope.OD.mapQuotes['T7'].ranges[keyRange].fltVolAVR;
                                        $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltWeightAVR = $scope.OD.mapQuotes['T7'].ranges[keyRange].fltWeightAVR;
                                        $scope.OD.mapQuotes['T7P'].ranges[keyRange].intFrecuency = $scope.OD.mapQuotes['T7'].ranges[keyRange].intFrecuency;
                                        $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltQuoteFee = $scope.OD.mapQuotes['T7'].ranges[keyRange].fltQuoteFee;
                                    }

                                    $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltFullFee = ($scope.OD.mapQuotes['T7V'].ranges[keyRange].fltAmount * $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltVolAVR)
                                            + $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltEAD
                                            + $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltRAD
                                            + $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltAmountSeg
                                            + $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltACK;

                                    $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltFullFee = ($scope.OD.mapQuotes['T7P'].ranges[keyRange].fltAmount * $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltWeightAVR)
                                            + $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltEAD
                                            + $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltRAD
                                            + $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltAmountSeg
                                            + $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltACK;

                                    $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltNormalFee = $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltFullFee * $scope.OD.mapQuotes['T7V'].ranges[keyRange].intFrecuency;
                                    $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltNormalFee = $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltFullFee * $scope.OD.mapQuotes['T7P'].ranges[keyRange].intFrecuency;

                                    if($scope.PPT7Calc === 'byDelivery' ){
                                        // Costo General
                                        if($scope.OD.fltGENCost > 0 && notEmpty(getId(strRange, $scope.OD.OriginalListRange)) && $scope.OnlineDocByRangeKM){
                                            $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltQuoteFee = $scope.OD.fltGENCost;
                                            $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltQuoteFee = $scope.OD.fltGENCost;
                                        } else if($scope.OD.fltGENCost > 0 && $scope.OnlineDocByDestiny && !$scope.OnlineDocByRangeKM){
                                            $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltQuoteFee = $scope.OD.fltGENCost;
                                            $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltQuoteFee = $scope.OD.fltGENCost;
                                        }
                                        // Descuento general
                                        if($scope.OD.fltGENDisc > 0 && notEmpty(getId(strRange, $scope.OD.OriginalListRange)) && $scope.OnlineDocByRangeKM) {
                                            $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltQuoteFee = $scope.desc($scope.OD.mapQuotes['T7V'].ranges[keyRange].fltFullFee - $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltAmountSeg, $scope.OD.fltGENDisc) + $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltAmountSeg;
                                            $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltQuoteFee = $scope.desc($scope.OD.mapQuotes['T7P'].ranges[keyRange].fltFullFee - $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltAmountSeg, $scope.OD.fltGENDisc) + $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltAmountSeg;
                                        } else if($scope.OD.fltGENDisc > 0 && $scope.OnlineDocByDestiny  && !$scope.OnlineDocByRangeKM){
                                            $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltQuoteFee = $scope.desc($scope.OD.mapQuotes['T7V'].ranges[keyRange].fltFullFee - $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltAmountSeg, $scope.OD.fltGENDisc) + $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltAmountSeg;
                                            $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltQuoteFee = $scope.desc($scope.OD.mapQuotes['T7P'].ranges[keyRange].fltFullFee - $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltAmountSeg, $scope.OD.fltGENDisc) + $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltAmountSeg;
                                        }
                                        //	Costo flat por tarifa
                                        if($scope.OD.mapQuotes['T7'].fltCost > 0 && notEmpty(getId(strRange, $scope.OD.OriginalListRange)) && $scope.OnlineDocByRangeKM) {
                                            $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltQuoteFee = $scope.OD.mapQuotes['T7'].fltCost;
                                            $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltQuoteFee = $scope.OD.mapQuotes['T7'].fltCost;
                                        } else if($scope.OD.mapQuotes['T7'].fltCost > 0 && $scope.OnlineDocByDestiny  && !$scope.OnlineDocByRangeKM){
                                            $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltQuoteFee = $scope.OD.mapQuotes['T7'].fltCost;
                                            $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltQuoteFee = $scope.OD.mapQuotes['T7'].fltCost;
                                        }
                                        // Costo por Rango KM
                                        if($scope.OD.mapRanges[keyRange].fltCost > 0 ){
                                            $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltQuoteFee =  $scope.OD.mapRanges[keyRange].fltCost;
                                            $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltQuoteFee =  $scope.OD.mapRanges[keyRange].fltCost;
                                        }

                                        $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltTotalQuote = $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltQuoteFee
                                            * $scope.OD.mapQuotes['T7V'].ranges[keyRange].intFrecuency;

                                        $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltTotalQuote = $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltQuoteFee
                                                * $scope.OD.mapQuotes['T7P'].ranges[keyRange].intFrecuency;
                                    } else {
                                        $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltTotalQuote = $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltQuoteFee
                                                * $scope.OD.mapQuotes['T7V'].ranges[keyRange].intFrecuency
                                                * $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltVolAVR;

                                        $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltTotalQuote = $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltQuoteFee
                                                * $scope.OD.mapQuotes['T7P'].ranges[keyRange].intFrecuency
                                                * $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltWeightAVR;
                                        $scope.OD.listRangePrecio['T7V'].ranges[keyRange].fltCost = $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltQuoteFee * $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltVolAVR;
                                        $scope.OD.listRangePrecio['T7P'].ranges[keyRange].fltCost = $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltQuoteFee * $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltWeightAVR;
                                    }

                                    if($scope.OD.mapQuotes['T7V'].ranges[keyRange].fltNormalFee > 0)
                                        $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltDiscount = ($scope.OD.mapQuotes['T7V'].ranges[keyRange].fltTotalQuote - $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltAmountSeg * $scope.OD.mapQuotes['T7V'].ranges[keyRange].intFrecuency)
                                                / ($scope.OD.mapQuotes['T7V'].ranges[keyRange].fltNormalFee - $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltAmountSeg * $scope.OD.mapQuotes['T7V'].ranges[keyRange].intFrecuency) -1;

                                    if($scope.OD.mapQuotes['T7P'].ranges[keyRange].fltNormalFee > 0)
                                        $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltDiscount = ($scope.OD.mapQuotes['T7P'].ranges[keyRange].fltTotalQuote - $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltAmountSeg * $scope.OD.mapQuotes['T7P'].ranges[keyRange].intFrecuency)
                                                / ($scope.OD.mapQuotes['T7P'].ranges[keyRange].fltNormalFee - $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltAmountSeg * $scope.OD.mapQuotes['T7P'].ranges[keyRange].intFrecuency) -1;

                                    if($scope.PPT7Calc === 'byDelivery' && $scope.OD.fltGENDisc > 0){
                                        if ($scope.OD.mapQuotes['T7V'].ranges[keyRange].fltFullFee > $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltFullFee)
                                            $scope.OD.mapQuotes['T7'].ranges[keyRange] = $scope.copy($scope.OD.mapQuotes['T7V'].ranges[keyRange], $scope.OD.mapQuotes['T7'].ranges[keyRange]);
                                        else
                                            $scope.OD.mapQuotes['T7'].ranges[keyRange] = $scope.copy($scope.OD.mapQuotes['T7P'].ranges[keyRange], $scope.OD.mapQuotes['T7'].ranges[keyRange]);
                                    } else {
                                        if ($scope.OD.mapQuotes['T7V'].ranges[keyRange].fltDiscount < $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltDiscount)
                                            $scope.OD.mapQuotes['T7'].ranges[keyRange] = $scope.copy($scope.OD.mapQuotes['T7V'].ranges[keyRange], $scope.OD.mapQuotes['T7'].ranges[keyRange]);
                                        else
                                            $scope.OD.mapQuotes['T7'].ranges[keyRange] = $scope.copy($scope.OD.mapQuotes['T7P'].ranges[keyRange], $scope.OD.mapQuotes['T7'].ranges[keyRange]);
                                    }

                                    $scope.OD.mapQuotes['T7V'].fltFeeTotalNormal += $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltNormalFee;
                                    $scope.OD.mapQuotes['T7V'].intFeeTotalFrec += $scope.OD.mapQuotes['T7V'].ranges[keyRange].intFrecuency;
                                    $scope.OD.mapQuotes['T7V'].fltFeeTotalQuote += $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltTotalQuote;
                                    if($scope.OD.mapQuotes['T7V'].fltFeeTotalNormal > 0 )
                                        $scope.OD.mapQuotes['T7V'].fltTotalDisc = ($scope.OD.mapQuotes['T7V'].fltFeeTotalQuote - $scope.OD.mapQuotes['T7'].fltFeeTotalSEG * $scope.OD.mapQuotes['T7V'].ranges[keyRange].intFrecuency)
                                                / ($scope.OD.mapQuotes['T7V'].fltFeeTotalNormal - $scope.OD.mapQuotes['T7'].fltFeeTotalSEG  * $scope.OD.mapQuotes['T7V'].ranges[keyRange].intFrecuency) -1;

                                    $scope.OD.mapQuotes['T7P'].fltFeeTotalNormal += $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltNormalFee;
                                    $scope.OD.mapQuotes['T7P'].intFeeTotalFrec += $scope.OD.mapQuotes['T7P'].ranges[keyRange].intFrecuency;
                                    $scope.OD.mapQuotes['T7P'].fltFeeTotalQuote += $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltTotalQuote;
                                    if($scope.OD.mapQuotes['T7P'].fltFeeTotalNormal > 0 )
                                        $scope.OD.mapQuotes['T7P'].fltTotalDisc = ($scope.OD.mapQuotes['T7P'].fltFeeTotalQuote - $scope.OD.mapQuotes['T7'].fltFeeTotalSEG * $scope.OD.mapQuotes['T7P'].ranges[keyRange].intFrecuency)
                                                / ($scope.OD.mapQuotes['T7P'].fltFeeTotalNormal - $scope.OD.mapQuotes['T7'].fltFeeTotalSEG  * $scope.OD.mapQuotes['T7P'].ranges[keyRange].intFrecuency) -1;

                                    $scope.OD.mapQuotes['T7'].fltFeeTotalNormal += $scope.OD.mapQuotes['T7'].ranges[keyRange].fltNormalFee;
                                    $scope.OD.mapQuotes['T7'].intFeeTotalFrec += $scope.OD.mapQuotes['T7'].ranges[keyRange].intFrecuency;
                                    $scope.OD.mapQuotes['T7'].fltFeeTotalQuote += $scope.OD.mapQuotes['T7'].ranges[keyRange].fltTotalQuote;
                                    if($scope.OD.mapQuotes['T7'].fltFeeTotalNormal > 0 )
                                        $scope.OD.mapQuotes['T7'].fltTotalDisc = ($scope.OD.mapQuotes['T7'].fltFeeTotalQuote - $scope.OD.mapQuotes['T7'].fltFeeTotalSEG * $scope.OD.mapQuotes['T7'].ranges[keyRange].intFrecuency)
                                                / ($scope.OD.mapQuotes['T7'].fltFeeTotalNormal - $scope.OD.mapQuotes['T7'].fltFeeTotalSEG * $scope.OD.mapQuotes['T7'].ranges[keyRange].intFrecuency) -1;
                                    /**/
                                }
                        );
                    $scope.OD.TOTAL['NORMAL'] += $scope.OD.mapQuotes['T7'].fltFeeTotalNormal;
                    $scope.OD.TOTAL['PROPUESTA'] += $scope.OD.mapQuotes['T7'].fltFeeTotalQuote;
                    $scope.OD.TOTAL['PAQUETES'] += $scope.OD.mapQuotes['T7'].intFeeTotalFrec;
                    $scope.OD.TOTAL['SEGURO'] += $scope.OD.mapQuotes['T7'].fltFeeTotalSEG;


                    if($scope.OD.TOTAL['NORMAL'] > 0)
                        $scope.OD.TOTAL['DESCUENTO'] = ($scope.OD.TOTAL['PROPUESTA'] - $scope.OD.TOTAL['SEGURO'])
                                / ($scope.OD.TOTAL['NORMAL'] - $scope.OD.TOTAL['SEGURO']) -1;



                    //Special Service
                    /*j$.each($scope.OD.listFee
                            , function (keyFee, strFee) {
                                if($scope.OD.mapQuotes[keyFee].blnShow){
                                    $scope.OD.mapQuotes[keyFee].fltFeeTotalNormal = 0;
                                    $scope.OD.mapQuotes[keyFee].fltFeeTotalQuote = 0;
                                    if(keyFee !== 'T7'){
                                        $scope.ODZP.mapQuotes[keyFee].fltFeeTotalNormal = 0;
                                        $scope.ODZP.mapQuotes[keyFee].fltFeeTotalQuote = 0;
                                    }

                                    j$.each($scope.OD.listRange
                                            ,function (keyRange, strRange){
                                                j$.each($scope.SS.listService
                                                        , function(keyService, strService){
                                                            if ($scope.SS.ranges[keyRange].Service[keyService].Option.model && $scope.SS.ranges[keyRange].Service[keyService].Option.model.id && $scope.SS.ranges[keyRange].Service[keyService].fltAmount > 0)
                                                                switch($scope.SS.ranges[keyRange].Service[keyService].Option.model.id){
                                                                    case 'G':
                                                                        $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltNormalFee += $scope.SS.ranges[keyRange].Service[keyService].fltAmount;
                                                                        $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote += $scope.SS.ranges[keyRange].Service[keyService].fltAmount;
                                                                        if(keyFee !== 'T7'){
                                                                            $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltNormalFee += $scope.SS.ranges[keyRange].Service[keyService].fltAmount;
                                                                            $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote += $scope.SS.ranges[keyRange].Service[keyService].fltAmount;
                                                                        }
                                                                        break;
                                                                    case 'P':
                                                                        $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltFullFee += $scope.SS.ranges[keyRange].Service[keyService].fltAmount;
                                                                        $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltNormalFee = $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltFullFee * $scope.OD.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                                        $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee = parseFloat($scope.OD.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee) + $scope.SS.ranges[keyRange].Service[keyService].fltAmount;
                                                                        $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote = $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee * $scope.OD.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                                        if(keyFee !== 'T7') {
                                                                            $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltFullFee += $scope.SS.ranges[keyRange].Service[keyService].fltAmount;
                                                                            $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltNormalFee = $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltFullFee * $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                                            $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee = parseFloat($scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee) + $scope.SS.ranges[keyRange].Service[keyService].fltAmount;
                                                                            $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote = $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee * $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                                        }
                                                                        break;
                                                                    case 'K':
                                                                        $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltFullFee += $scope.SS.ranges[keyRange].Service[keyService].fltAmount * $scope.Wrapper.mapTarifarioT[strFee][strRange].PesoMaximo__c;
                                                                        $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltNormalFee = $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltFullFee * $scope.OD.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                                        $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee = parseFloat($scope.OD.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee) + ($scope.SS.ranges[keyRange].Service[keyService].fltAmount * $scope.Wrapper.mapTarifarioT[strFee][strRange].PesoMaximo__c);
                                                                        $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote = $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee * $scope.OD.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                                        if(keyFee !== 'T7') {
                                                                            $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltFullFee += $scope.SS.ranges[keyRange].Service[keyService].fltAmount * $scope.Wrapper.mapTarifarioT[strFee][strRange].PesoMaximo__c;
                                                                            $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltNormalFee = $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltFullFee * $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                                            $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee = parseFloat($scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee) + ($scope.SS.ranges[keyRange].Service[keyService].fltAmount * $scope.Wrapper.mapTarifarioT[strFee][strRange].PesoMaximo__c);
                                                                            $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote = $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee * $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                                        }
                                                                        break;
                                                                }
                                                        }
                                                );
                                                $scope.OD.mapQuotes[keyFee].fltFeeTotalNormal += $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltNormalFee;
                                                $scope.OD.mapQuotes[keyFee].fltFeeTotalQuote += $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote;
                                                $scope.ODZP.mapQuotes[keyFee].fltFeeTotalNormal += $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltNormalFee;
                                                $scope.ODZP.mapQuotes[keyFee].fltFeeTotalQuote += $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote
                                            }
                                    );
                                    $scope.OD.TOTAL['NORMAL'] += $scope.OD.mapQuotes[keyFee].fltFeeTotalNormal + $scope.ODZP.mapQuotes[keyFee].fltFeeTotalNormal;
                                    $scope.OD.TOTAL['PROPUESTA'] += $scope.OD.mapQuotes[keyFee].fltFeeTotalQuote + $scope.ODZP.mapQuotes[keyFee].fltFeeTotalQuote;
                                }
                            }
                    );*/
                };

                $scope.copy = function(a, b){
                    var idB;
                    idB = b.Id;
                    b = Object.assign(b, a);
                    b.Id = idB;
                    return b
                };

                $scope.createQuotesOD = function(){
                    var hasError = false;
                    j$.each($scope.OD.lisMessages, function (keyBlock, listMessages) {
                        j$.each(listMessages, function (index, arrayMessages) {
                            if(!isArrayEmpy(arrayMessages))
                                hasError = true;
                        });
                    });
                    if(!hasError) {
                        var listDelete = [];
                        var strRange = '';
                        var Quote = {
                            Acuse__c: $scope.OD.strAck
                            , AcuseCosto__c: $scope.OD.strAckCost
                            , SBQQ__Primary__c: true
                            , PAQ_TipoServicio__c: ''
                            , Modelo_de_tarifas__c: 'Costos fijos por Tarifas: Por Destinos / Por rangos de km'
                            , Descuento_Global__c: $scope.OD.TOTAL['DESCUENTO-STD'] * (-100)
                            , Descuento_Global_Express__c: $scope.OD.TOTAL['DESCUENTO-SEG'] * (-100)
                            , PAQ_DescuentoGlobal__c: $scope.OD.TOTAL['DESCUENTO'] * (-100)
                            , Ingreso_Mensual__c: $scope.OD.TOTAL['PROPUESTA']
                            , TarifaLlenaMensual__c: $scope.OD.TOTAL['NORMAL']
                            , Paquetes_Mensuales__c: $scope.OD.TOTAL['PAQUETES']
                            , RangosKM__c: $scope.OnlineDocByRangeKM
                            , Destinos__c: $scope.OnlineDocByDestiny
                            , Gerente_de_sucursal_aprobacion__c: $scope.Managers['GSU']
                            , KAM_aprobacion__c: $scope.Managers['KAM']
                            , Gerente_desarrollo_aprobacion__c: $scope.Managers['GDS']
                            , Director_comercial_aprobacion__c: $scope.Managers['DCO']
                            , Tipo_de_documentacion__c: 'Documentación Remota'
                            , Plaza__c: $scope.OD.strOrigin
                            , OriginCity__c : $scope.OD.strOrigen
                            , Es_T7_Zona_plus__c : false
                        };

                        if ($scope.Wrapper.objQuote && $scope.Wrapper.objQuote.Id) {
                            Quote.Id = $scope.Wrapper.objQuote.Id;
                            Quote.SBQQ__Status__c = $scope.Wrapper.objQuote.SBQQ__Status__c;
                        }

                        if ($scope.Wrapper.objLead && notEmpty($scope.Wrapper.objLead.Id))
                            Quote.Lead__c = $scope.Wrapper.objLead.Id;
                        if ($scope.Wrapper.objOpp && notEmpty($scope.Wrapper.objOpp.Id))
                            Quote.SBQQ__Opportunity2__c = $scope.Wrapper.objOpp.Id;
                        if($scope.Wrapper.objOpp && $scope.Wrapper.objOpp.AccountId)
                            Quote.SBQQ__Account__c = $scope.Wrapper.objOpp.AccountId;

                        var listQuoteItem = [];
                        Quote.Servicios_adicionales__c = "";
                        if ($scope.OD.blnRAD)
                            Quote.Servicios_adicionales__c = "RAD;";
                        if ($scope.OD.blnEAD)
                            Quote.Servicios_adicionales__c += "EAD;";
                        if ($scope.OD.blnSEG)
                            Quote.Servicios_adicionales__c += "Seguro;";
                        if ($scope.OD.blnACK)
                            Quote.Servicios_adicionales__c += "Acuse " + $scope.OD.strAck;

                        var rangeDisc = 0;
                        var rangeDiscEXP = 0;
                        var arrayTarifas = '';
                        $scope.OD.blnZP = false;
                        debugger;
                        j$.each($scope.OD.listFee, function (keyFee, strFee) {
                            if ($scope.OD.mapQuotes[keyFee].blnShow){
                                j$.each($scope.OD.listRange, function (keyRange, labelRange) {
                                    if (getId(labelRange, $scope.OD.OriginalListRange))
                                        strRange = labelRange;
                                    else
                                        strRange = getRange(labelRange);
                                        if ($scope.OD.mapQuotes[keyFee].ranges[keyRange].intFrecuency > 0) {
                                            Quote.PAQ_TipoServicio__c = 'Estándar terrestre (STD)';
                                            var QuoteItem = {
                                                SBQQ__Quantity__c: $scope.OD.mapQuotes[keyFee].ranges[keyRange].intFrecuency
                                                , SBQQ__Discount__c: $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltDiscount * 100
                                                , SBQQ__CustomerPrice__c: $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee
                                                , SBQQ__NetPrice__c: $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltFullFee
                                                , SBQQ__SpecialPrice__c: $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltFullFee
                                                , QuoteTotal__c: $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee
                                                , PackWeightAVG__c: $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltWeightAVR
                                                , PackVolAVG__c: $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltVolAVR
                                                , ACK__c: $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltACK
                                                , EAD__c: $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltEAD
                                                , RAD__c: $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltRAD
                                                , SEG__c: $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg
                                                , Tarifa__c: strFee
                                                , Rango_KM__c: strRange
                                                , ZonaPlus__c: false
                                                , Pack_Seg__c: $scope.OD.fltSEG
                                                //, Id: $scope.OD.mapQuotes[keyFee].ranges[keyRange].Id
                                                , SBQQ__VolumeDiscount__c: $scope.OD.mapQuotes[keyFee].fltFeeTotalDesc * 100
                                                , SBQQ__Quote__c: Quote.Id
                                            };
                                            if($scope.OD.mapQuotes[keyFee].ranges[keyRange].Id)
                                                QuoteItem.Id = $scope.OD.mapQuotes[keyFee].ranges[keyRange].Id;
                                            if (!getId(labelRange, $scope.OD.OriginalListRange))
                                                QuoteItem.Destiny__c = keyRange;

                                            if (keyFee === 'T7') {
                                                QuoteItem.SBQQ__VolumeDiscount__c = $scope.OD.mapQuotes['T7'].fltTotalDisc * 100;
                                                if ($scope.PPT7Calc === 'byDimension') {
                                                    if ($scope.OD.mapQuotes['T7'].ranges[keyRange].fltVolAVR > 1)
                                                        QuoteItem.SBQQ__SpecialPrice__c = $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee * $scope.OD.mapQuotes['T7'].ranges[keyRange].fltVolAVR * $scope.OD.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                    if ($scope.OD.mapQuotes['T7'].ranges[keyRange].fltWeightAVR > 1)
                                                        QuoteItem.SBQQ__SpecialPrice__c = $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee * $scope.OD.mapQuotes['T7'].ranges[keyRange].fltWeightAVR * $scope.OD.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                    QuoteItem.PackWeightAVG__c = $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltWeightAVR;
                                                    QuoteItem.PackVolAVG__c = $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltVolAVR;
                                                    QuoteItem.SBQQ__CustomerPrice__c = $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote / $scope.OD.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                }
                                            }
                                            if ((QuoteItem.SBQQ__Discount__c * -1) > rangeDisc)
                                                rangeDisc = QuoteItem.SBQQ__Discount__c * -1;
                                            listQuoteItem.push(QuoteItem);

                                            if (!arrayTarifas.includes(strFee))
                                                arrayTarifas += strFee + ' ,';
                                        } else if ($scope.OD.mapQuotes[keyFee].ranges[keyRange].intFrecuency === 0 && $scope.OD.mapQuotes[keyFee].ranges[keyRange].Id)
                                            listDelete.push($scope.OD.mapQuotes[keyFee].ranges[keyRange].Id);

                                        if (keyFee !== 'T7') {
                                            if ($scope.ODZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency > 0) {
                                                Quote.PAQ_TipoServicio__c = 'Estándar terrestre (STD)';
                                                $scope.OD.blnZP = true;
                                                var QuoteItemZP = {
                                                    SBQQ__Quantity__c: $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency
                                                    , SBQQ__Discount__c: $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltDiscount * 100
                                                    , SBQQ__CustomerPrice__c: $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee
                                                    , SBQQ__NetPrice__c: $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltFullFee
                                                    , SBQQ__SpecialPrice__c: $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltFullFee
                                                    , QuoteTotal__c: $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote
                                                    , ACK__c: $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltACK
                                                    , EAD__c: $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltEAD
                                                    , RAD__c: $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltRAD
                                                    , SEG__c: $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg
                                                    , Tarifa__c: strFee
                                                    , Rango_KM__c: strRange
                                                    , ZonaPlus__c: true
                                                    , SBQQ__VolumeDiscount__c: $scope.ODZP.mapQuotes[keyFee].fltFeeTotalDesc * 100
                                                    //, Id: $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].Id
                                                    , SBQQ__Quote__c: Quote.Id
                                                };
                                                if($scope.ODZP.mapQuotes[keyFee].ranges[keyRange].Id)
                                                    QuoteItemZP.Id = $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].Id;
                                                if (!getId(labelRange, $scope.OD.OriginalListRange))
                                                    QuoteItemZP.Destiny__c = keyRange;

                                                if ((QuoteItemZP.SBQQ__Discount__c * -1) > rangeDisc)
                                                    rangeDisc = QuoteItemZP.SBQQ__Discount__c * -1;

                                                listQuoteItem.push(QuoteItemZP);
                                                if (!arrayTarifas.includes(strFee))
                                                    arrayTarifas += strFee + ' ,';
                                            } else if ($scope.ODZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency === 0 && $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].Id)
                                                listDelete.push($scope.ODZP.mapQuotes[keyFee].ranges[keyRange].Id);
                                        }
                                    }
                                );
                            }
                        });

                        if ($scope.OD.mapQuotes['T7'].blnShow) {
                            Quote.Tarifa_7__c = true;
                            Quote.TipoCotizacion__c = $scope.PPT7Calc;
                            if ($scope.PPT7Calc === 'byDimension')
                                j$.each(
                                        {'T7P': 'TARIFA T7-P', 'T7V': 'TARIFA T7-V'}
                                        , function (keyFee, strFee) {
                                            j$.each($scope.OD.listRange
                                                    , function (keyRange, labelRange) {

                                                        if (getId(labelRange, $scope.OD.OriginalListRange))
                                                            strRange = labelRange;
                                                        else
                                                            strRange = getRange(labelRange);

                                                        if ($scope.OD.mapQuotes[keyFee].ranges[keyRange].intFrecuency > 0) {
                                                            var QuoteItem = {
                                                                SBQQ__Quantity__c: $scope.OD.mapQuotes[keyFee].ranges[keyRange].intFrecuency
                                                                ,
                                                                SBQQ__Discount__c: $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltDiscount * 100
                                                                ,
                                                                SBQQ__CustomerPrice__c: $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee
                                                                ,
                                                                SBQQ__NetPrice__c: $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltFullFee
                                                                ,
                                                                QuoteTotal__c: $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltTotalQuote
                                                                ,
                                                                PackWeightAVG__c: $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltWeightAVR
                                                                ,
                                                                PackVolAVG__c: $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltVolAVR
                                                                ,
                                                                ACK__c: $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltACK
                                                                ,
                                                                EAD__c: 0
                                                                ,
                                                                RAD__c: 0
                                                                ,
                                                                SEG__c: $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltAmountSeg
                                                                ,
                                                                Tarifa__c: strFee
                                                                ,
                                                                Rango_KM__c: strRange
                                                                ,
                                                                ZonaPlus__c: false
                                                                ,
                                                                Pack_Seg__c: $scope.OD.fltSEG
                                                                ,
                                                                Id: $scope.OD.mapQuotes[keyFee].ranges[keyRange].Id
                                                                ,
                                                                SBQQ__VolumeDiscount__c: $scope.OD.mapQuotes['T7'].fltTotalDisc * 100
                                                                ,
                                                                SBQQ__Quote__c: Quote.Id
                                                            };

                                                            if (!getId(labelRange, $scope.OD.OriginalListRange))
                                                                QuoteItem.Destiny__c = keyRange;

                                                            if ((QuoteItem.SBQQ__Discount__c * -1) > rangeDisc)
                                                                rangeDisc = QuoteItem.SBQQ__Discount__c * -1;
                                                            listQuoteItem.push(QuoteItem);

                                                            if (keyFee === 'T7V')
                                                                QuoteItem.SBQQ__SpecialPrice__c = $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee * $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltVolAVR;
                                                            if (keyFee === 'T7P')
                                                                QuoteItem.SBQQ__SpecialPrice__c = $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltQuoteFee * $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltWeightAVR;

                                                            if (!arrayTarifas.includes(strFee))
                                                                arrayTarifas += strFee + ' ,';
                                                        } else if ($scope.OD.mapQuotes[keyFee].ranges[keyRange].intFrecuency === 0 && $scope.OD.mapQuotes[keyFee].ranges[keyRange].Id)
                                                            listDelete.push($scope.OD.mapQuotes[keyFee].ranges[keyRange].Id);

                                                    }
                                            );
                                        }
                                );
                                j$.each($scope.OD.mapTender, function(strTender, map){
                                    if($scope.OD.mapQuotesT7ZP.Tender[strTender].intFrecuency > 0){
                                        var QuoteItemT7ZP = {
                                            SBQQ__Quantity__c: $scope.OD.mapQuotesT7ZP.Tender[strTender].intFrecuency
                                            , SBQQ__Discount__c: $scope.OD.mapQuotesT7ZP.Tender[strTender].fltDiscount * 100
                                            , SBQQ__CustomerPrice__c: $scope.OD.mapQuotesT7ZP.Tender[strTender].flttarifaProp
                                            , SBQQ__NetPrice__c: $scope.OD.mapQuotesT7ZP.Tender[strTender].fltTotalQuote
                                            , SBQQ__SpecialPrice__c: $scope.OD.mapQuotesT7ZP.Tender[strTender].fltExc
                                            , QuoteTotal__c: $scope.OD.mapQuotesT7ZP.Tender[strTender].fltQuoteFee
                                            , PackWeightAVG__c: $scope.OD.mapQuotesT7ZP.Tender[strTender].fltPesoDom
                                            , PackVolAVG__c: $scope.OD.mapQuotesT7ZP.Tender[strTender].fltPesoVol
                                            , ACK__c: 0
                                            , EAD__c: 0
                                            , RAD__c: 0
                                            , SEG__c: 0
                                            , Tarifa__c: 'TARIFA T7'
                                            , Rango_KM__c: $scope.OD.mapQuotesT7ZP.Tender[strTender].strRange
                                            , ZonaPlus__c: true
                                            , Pack_Seg__c: 0
                                            //, Id: $scope.OD.mapQuotesT7ZP.Tender[strTender].Id
                                            , SBQQ__VolumeDiscount__c: 0
                                            , SBQQ__Quote__c: Quote.Id
                                            , Destiny__c : strTender
                                            , Large__c : $scope.OD.mapQuotesT7ZP.Tender[strTender].fltLargo
                                            , Width__c : $scope.OD.mapQuotesT7ZP.Tender[strTender].fltAncho
                                            , High__c : $scope.OD.mapQuotesT7ZP.Tender[strTender].fltAlto
                                            , Weight__c : $scope.OD.mapQuotesT7ZP.Tender[strTender].fltPeso
                                            , Flete__c : $scope.OD.mapQuotesT7ZP.Tender[strTender].fltFullFee
                                            , GUIA__c : $scope.OD.mapQuotesT7ZP.Tender[strTender].fltQuoteFull
                                            , SBQQ__Description__c : ''
                                        };
                                        if(map.blnDestino)
                                            QuoteItemT7ZP.SBQQ__Description__c = 'Destino';
                                        listQuoteItem.push(QuoteItemT7ZP);
                                        Quote.Es_T7_Zona_plus__c = true;
                                        $scope.OD.blnCotizaT7ZP = true;
                                    }
                                });
                                Quote.PAQ_TipoServicio__c = 'Estándar terrestre (STD)';
                                if($scope.OD.blnCotizaT7ZP){
                                    j$.each($scope.OD.listRange, function(keyRange, strRange){
                                        var QuoteItemT7ZPTotales = {
                                            SBQQ__Quantity__c: 0
                                            , SBQQ__Discount__c: $scope.OD.mapPropuesta['PROP'].ranges[keyRange].fltDescuento * 100
                                            , SBQQ__CustomerPrice__c: $scope.OD.mapPropuesta['PROP'].ranges[keyRange].fltTotalPropuesta
                                            , SBQQ__NetPrice__c: $scope.OD.mapPropuesta['PROP'].ranges[keyRange].fltTotalTarifaLlena
                                            , SBQQ__SpecialPrice__c: $scope.OD.mapPropuesta['PROP'].ranges[keyRange].fltCost
                                            , QuoteTotal__c: 0
                                            , PackWeightAVG__c: $scope.OD.mapQuotes['T7'].ranges[keyRange].fltVolAVR
                                            , PackVolAVG__c: 0
                                            , ACK__c: 0
                                            , EAD__c: $scope.OD.mapPropuesta['PROP'].ranges[keyRange].fltZP
                                            , RAD__c: $scope.OD.mapPropuesta['PROP'].ranges[keyRange].fltRAD
                                            , SEG__c: 0
                                            , Tarifa__c: 'TARIFA T7'
                                            //, Rango_KM__c: strRange
                                            , ZonaPlus__c: true
                                            , Pack_Seg__c: 0
                                            , SBQQ__VolumeDiscount__c: 0
                                            , SBQQ__Quote__c: Quote.Id
                                            , Destiny__c : ''
                                            , SBQQ__Description__c : 'Propuesta'
                                            //, Id : $scope.OD.mapPropuesta['PROP'].ranges[keyRange].Id
                                            , Flete__c : $scope.OD.mapPropuesta['PROP'].ranges[keyRange].fltTotalNormal
                                            , Guia__c : $scope.OD.mapPropuesta['PROP'].ranges[keyRange].fltTotPropuesta
                                        };
                                        if($scope.OnlineDocByDestiny){
                                            /*let rango = '';
                                            rango = strRange.replace(keyRange + ' (');
                                            rango = rango.replace(')');*/
                                            QuoteItemT7ZPTotales.Rango_KM__c = $scope.OD.mapPropuesta['PROP'].ranges[keyRange].strRango;
                                            QuoteItemT7ZPTotales.Destiny__c = keyRange;
                                        } else {
                                            let rango = '';
                                            if(strRange.includes('(')){
                                                rango = strRange.replace(keyRange + ' (', '');
                                                rango = rango.replace(')', '');
                                                QuoteItemT7ZPTotales.Destiny__c = keyRange;
                                            } else {
                                                rango = strRange;
                                            }
                                            QuoteItemT7ZPTotales.Rango_KM__c = rango;
                                        } 
                                        listQuoteItem.push(QuoteItemT7ZPTotales);
                                    });
                                }
                        }
                        if($scope.OD.blnZP)
                            Quote.Servicios_adicionales__c += ";EAD Zona plus";
                        Quote.Descuento_por_linea_o_rangokm__c = rangeDisc;

                        //SEG
                        j$.each($scope.ODEXP.listFeeEXP, function (keyFee, labelFee) {
                            j$.each($scope.ODEXP.mapBlock[keyFee], function (i, block) {
                                j$.each(block.ranges, function (keyRange, range) {
                                    if (range.intFrecuency > 0) {
                                        if (getId(getLabel(keyRange, $scope.OD.listRange), $scope.OD.OriginalListRange))
                                            strRange = getLabel(keyRange, $scope.OD.listRange);
                                        else
                                            strRange = getRange(getLabel(keyRange, $scope.OD.listRange));
                                        if (Quote.PAQ_TipoServicio__c == 'Estándar terrestre (STD)')
                                            Quote.PAQ_TipoServicio__c += '; Servicio Express Garantizado (SEG)';
                                        else if (Quote.PAQ_TipoServicio__c == undefined || Quote.PAQ_TipoServicio__c == '')
                                            Quote.PAQ_TipoServicio__c = 'Servicio Express Garantizado (SEG)';
                                        var QuoteItem = {
                                            SBQQ__Quantity__c: range.intFrecuency
                                            , SBQQ__Discount__c: range.fltDisc * 100
                                            , SBQQ__CustomerPrice__c: range.fltQuoteFee
                                            , SBQQ__NetPrice__c: range.fltFullFee
                                            , QuoteTotal__c: range.fltTotalQuote
                                            , Tarifa__c: labelFee
                                            , Rango_KM__c: strRange
                                            , Pack_Seg__c: $scope.OD.fltSEG
                                            , Id: range.Id
                                            , SBQQ__VolumeDiscount__c: block.intTotalDisc * 100
                                            , SBQQ__Quote__c: Quote.Id
                                            , Weight__c: range.fltWeight
                                            , Large__c: range.fltLarge
                                            , Width__c: range.fltWidth
                                            , High__c: range.fltHigh
                                            , VolWeight__c: range.fltVolWeight
                                            , SEG__c: $scope.OD.fltAmountSEG
                                            , ACK__c: range.fltQuoteExtra
                                            , FLETE__c: range.fltQuoteGuide
                                            , GUIA__c: block.fltBase
                                            , KG_ADICIONAL__c: range.fltAditionalKG
                                            , DiscKgAditional__c: range.fltDiscKgAdd
                                        };
                                        if (!getId(getLabel(keyRange, $scope.OD.listRange), $scope.OD.OriginalListRange))
                                            QuoteItem.Destiny__c = keyRange;
                                        listQuoteItem.push(QuoteItem);
                                        if ((QuoteItem.SBQQ__Discount__c * -1) > rangeDiscEXP)
                                            rangeDiscEXP = QuoteItem.SBQQ__Discount__c * -1;
                                        if (!arrayTarifas.includes(labelFee))
                                            arrayTarifas += labelFee + ' ,';
                                    } else if (range.Id)
                                        listDelete.push(range.Id);
                                });
                            });
                        });

                        j$.each($scope.DeletedDestiny, function (key, value) {
                            j$.each($scope.ODZP.listFee, function (keyFee, strFee) {
                                if ($scope.OD.mapQuotes[keyFee].ranges[value].Id)
                                    listDelete.push($scope.OD.mapQuotes[keyFee].ranges[value].Id);
                                if ($scope.ODZP.mapQuotes[keyFee].ranges[value].Id)
                                    listDelete.push($scope.ODZP.mapQuotes[keyFee].ranges[value].Id);
                            });
                            if ($scope.OD.mapQuotes['T7'].ranges[value].Id)
                                listDelete.push($scope.OD.mapQuotes['T7'].ranges[value].Id);
                            if ($scope.OD.mapQuotes['T7V'].ranges[value].Id)
                                listDelete.push($scope.OD.mapQuotes['T7V'].ranges[value].Id);
                            if ($scope.OD.mapQuotes['T7P'].ranges[value].Id)
                                listDelete.push($scope.OD.mapQuotes['T7P'].ranges[value].Id);
                        });

                        Quote.Descuento_por_linea_o_rango_km_Express__c = rangeDiscEXP;

                        if ($scope.Wrapper.objLead && notEmpty($scope.Wrapper.objLead.Id))
                            $scope.Wrapper.objLead.Hay_Cotizacion__c = true;
                        else
                            $scope.Wrapper.objLead = null;

                        j$.each($scope.listQLineDEL , function (i, item) {
                            listDelete.push(item);
                        });
                        var listSS = [];
                        var listDELSS = [];

                        // Special Service
                        j$.each($scope.OD.listRange
                                , function (keyRange, labelRange) {
                                    if (getId(labelRange, $scope.OD.OriginalListRange))
                                        strRange = labelRange;
                                    else
                                        strRange = getRange(labelRange);
                                    j$.each($scope.SS.listService
                                            , function (keyService, strService) {
                                                if ($scope.SS.ranges[keyRange].Service[keyService].Option.model && $scope.SS.ranges[keyRange].Service[keyService].Option.model.id && $scope.SS.ranges[keyRange].Service[keyService].fltAmount > 0) {
                                                    var SpecialService = {
                                                        Name: strService
                                                        ,
                                                        RangoKM__c: strRange
                                                        ,
                                                        Amount__c: $scope.SS.ranges[keyRange].Service[keyService].fltAmount
                                                        ,
                                                        Quote__c: Quote.Id
                                                        ,
                                                        Option__c: $scope.SS.ranges[keyRange].Service[keyService].Option.model.id
                                                        ,
                                                        MainDesinations__c: $scope.SS.service[keyService].mainDestinies
                                                        ,
                                                        Potencial__c: $scope.SS.service[keyService].potential
                                                        /*,
                                                        Id: $scope.SS.ranges[keyRange].Service[keyService].Id*/
                                                    };
                                                    if (!getId(labelRange, $scope.OD.OriginalListRange))
                                                        SpecialService.Destiny__c = keyRange;

                                                    listSS.push(SpecialService);
                                                } else if ($scope.SS.ranges[keyRange].Service[keyService] && $scope.SS.ranges[keyRange].Service[keyService].Id)
                                                    listDELSS.push($scope.SS.ranges[keyRange].Service[keyService].Id);
                                            }
                                    );
                                }
                        );

                        if ($scope.Wrapper.objOpp && notEmpty($scope.Wrapper.objOpp.Id)) {
                            var blnHasQuotePending = false;
                            var blnHasQuoteApproved = false;
                            j$.each(
                                    $scope.Wrapper.listPrevQuotes
                                    , function (index, quoteOpp) {
                                        if (quoteOpp.SBQQ__Status__c === 'In Review')
                                            blnHasQuotePending = true;
                                        if (quoteOpp.SBQQ__Status__c === 'Approved')
                                            blnHasQuoteApproved = true;
                                    }
                            );
                            if (blnHasQuoteApproved)
                                $scope.Wrapper.objOpp.StageName = 'Seguimiento a cierre / revisión de condiciones\n';

                            $scope.Wrapper.objOpp.Hay_Cotizacion__c = true;
                            $scope.Wrapper.objOpp.TarifasIncluidas__c = arrayTarifas;

                            if (blnHasQuotePending)
                                $scope.DML.listErrors.push('Esta oportunidad ya tiene una cotización pendiente de autorización, no es posible crear una nueva en este momento');
                            else if (Quote.Id)
                                if (Quote.SBQQ__Status__c === 'Draft' || Quote.SBQQ__Status__c === 'Rejected')
                                    callUpdateQuoteConv($scope, Quote, listQuoteItem, $scope.Wrapper.objLead, $scope.Wrapper.objOpp, listDelete, listSS, listDELSS);
                                    //EliminarPartidasAnteriores($scope, Quote.Id, Quote,listQuoteItem,  $scope.Wrapper.objLead, $scope.Wrapper.objOpp, listDelete, null, null);
                                else
                                    $scope.DML.listErrors.push('El Estatus actual de la cotización no permite modificaciones');
                            else
                                callCreateQuoteConv($scope, Quote, listQuoteItem, $scope.Wrapper.objLead, $scope.Wrapper.objOpp, listSS);

                        } else {
                            if (Quote.Id)
                                if (Quote.SBQQ__Status__c === 'Draft' || Quote.SBQQ__Status__c === 'Rejected')
                                    callUpdateQuoteConv($scope, Quote, listQuoteItem, $scope.Wrapper.objLead, null, listDelete, listSS, listDELSS);
                                else
                                    $scope.DML.listErrors.push('El Estatus actual de la cotización no permite modificaciones');
                            else
                                callCreateQuoteConv($scope, Quote, listQuoteItem, $scope.Wrapper.objLead, null, listSS);
                        }
                    }
                    $scope.listQLineDEL = [];
                };

                $scope.clickFee = function(index, strType){
                    switch (strType) {
                        case 'feeAdd':
                            $scope.OD.FeeSelect.available[index].blnSelected = !$scope.OD.FeeSelect.available[index].blnSelected;
                            break;
                        case 'feeRemove':
                            $scope.OD.FeeSelect.selected[index].blnSelected = !$scope.OD.FeeSelect.selected[index].blnSelected;
                            break;
                        case 'serviceAdd':
                            $scope.OD.ServiceSelect.available[index].blnSelected = !$scope.OD.ServiceSelect.available[index].blnSelected;
                            break;
                        case 'serviceRemove':
                            $scope.OD.ServiceSelect.selected[index].blnSelected = !$scope.OD.ServiceSelect.selected[index].blnSelected;
                            break;


                    }

                };

                $scope.desc = function(fltNum, descNum){
                    var num = fltNum - ((fltNum * descNum) / 100);
                    return parseFloat(num).toFixed(2);
                };

                $scope.editOrigin = function(){
                    $scope.OD.OriginDisabled = false;
                    $scope.OD.listDestiny = {};
                    $scope.fillRanges();
                };

                $scope.exceptionAD = function(strFeeKey){
                    return strFeeKey === 'TS';
                };

                $scope.fillRanges = function(){
                    j$.each($scope.ODEXP.listFeeEXP, function (key, label) {
                        $scope.ODEXP.mapBlock[key] = [];
                        var block = {
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
                            , strLabel : ''
                            , fltBase : 0
                        };
                        switch (key) {
                            case 'DS':
                                block.strLabel = 'DÍA SIGUIENTE '+ label;
                                break;
                            case '2D':
                                block.strLabel = 'DOS DÍAS' + label;
                                break;
                            case 'A12':
                                block.strLabel = 'ANTES DE LAS 12 ' + label;
                                break;
                        };
                        $scope.ODEXP.mapBlock[key].push(block);
                    });
                    if ($scope.OnlineDocByRangeKM || (!$scope.OnlineDocByRangeKM && !$scope.OnlineDocByDestiny)){
                        $scope.OD.listRange = {
                            '0-400': '0-400'
                            , '401-800': '401-800'
                            , '801-1200': '801-1200'
                            , '1201-1600': '1201-1600'
                            , '1601-2000': '1601-2000'
                            , '2001-2400': '2001-2400'
                            , '+2400' :'Más de 2400'
                        };
                        $scope.ODZP.listRange = {
                            '0-400': '0-400'
                            , '401-800': '401-800'
                            , '801-1200': '801-1200'
                            , '1201-1600': '1201-1600'
                            , '1601-2000': '1601-2000'
                            , '2001-2400': '2001-2400'
                            , '+2400' :'Más de 2400'
                        };
                        j$.each($scope.ODEXP.mapBlock, function (key, listBlock) {
                            j$.each(listBlock, function (index, block) {
                                j$.each($scope.OD.listRange, function (keyRange, labelRange) {
                                    block.ranges[keyRange] = {
                                        intFrecuency : 0
                                        , fltFrecuency :0
                                        , fltWeight : 0
                                        , fltVol : 0
                                        , fltVolWeight : 0
                                        , fltDominantWeight : 0
                                        , fltLarge : 0
                                        , fltHigh : 0
                                        , fltWidth : 0
                                        , fltAmount : 0
                                        , fltFullFee : 0
                                        , fltTotalFull : 0
                                        , fltQuoteFee : 0
                                        , fltQuoteGuide : 0
                                        , fltAditionalKG : 0
                                        , fltQuoteExtra : 0
                                        , fltTotalQuote : 0
                                        , fltDisc : 0
                                        , fltDiscKgAdd :0
                                    };
                                });
                            });
                        });

                        j$.each(
                                $scope.OD.listFee
                                , function(keyFee, fee){
                                    j$.each(
                                            $scope.OD.listRange,
                                            function(keyRange, strRange){
                                                $scope.OD.mapQuotes[keyFee].ranges[keyRange] = {
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
                                $scope.ODZP.listFee
                                , function(keyFee, fee){
                                    j$.each(
                                            $scope.ODZP.listRange,
                                            function(keyRange, strRange){
                                                $scope.ODZP.mapQuotes[keyFee].ranges[keyRange] = {
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
                                $scope.OD.listRange
                                , function(keyRange, strRange){
                                    $scope.OD.mapQuotes['T7'].ranges[keyRange].fltVolAVR = 0;
                                    $scope.OD.mapQuotes['T7'].ranges[keyRange].fltWeightAVR = 0;
                                    $scope.OD.mapQuotes['T7P'].ranges[keyRange] = {
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
                                    $scope.OD.mapQuotes['T7V'].ranges[keyRange] = {
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
                                    $scope.OD.mapPropuesta['PROP'].ranges[keyRange] = {
                                        fltCost : 0
                                        , fltTotalPropuesta : 0
                                        , fltTotalTarifaLlena : 0
                                        , fltTarima : 0
                                        , fltDescuento : 0
                                        , fltQuoteFee : 0
                                        , fltVol : 0
                                        , fltPeso : 0
                                        , fltFlete : 0
                                        , fltRAD : 0
                                        , fltEAD : 0
                                        , fltZP : 0
                                        , fltACK : 0
                                        , fltTarifaLlena : 0
                                        , fltTarifaPropuesta : 0
                                        , fltAdicZP : 0
                                        , fltTotalTarifaPropuesta : 0
                                        , fltPrecio : 0
                                        , fltTotalNormal : 0
                                        , fltTotPropuesta : 0
                                        , intFrecuency : 0
                                        , fltPesoVol : 0
                                        , fltPesoDom : 0
                                    };
                                    $scope.OD.listRangePrecio['T7P'].ranges[keyRange] = {
                                        fltCost : 0
                                    };
                                    $scope.OD.listRangePrecio['T7V'].ranges[keyRange] = {
                                        fltCost : 0
                                    };
                                    $scope.OD.mapRanges[keyRange] = {
                                        fltCost: 0
                                    };
                                    $scope.SS.ranges[keyRange] = {
                                        fltTotalByRange : 0
                                        , Service: []
                                    };
                                    j$.each($scope.SS.listService
                                            , function(keyService, strService){
                                                $scope.SS.service[keyService] = {
                                                    mainDestinies : ''
                                                    , potential : 0
                                                };
                                                $scope.SS.ranges[keyRange].Service[keyService] = {
                                                    Option : {
                                                        model : undefined
                                                        , aviableOptions : [] }
                                                    , fltAmount : 0
                                                };
                                                j$.each($scope.SS.listOption
                                                        , function(keyOption, strOption){
                                                            $scope.SS.ranges[keyRange].Service[keyService].Option.aviableOptions.push({id: keyOption, label: strOption});
                                                        }
                                                );
                                            }
                                    );
                                }
                        );
                    } else{
                        $scope.OD.listRange = {};
                        $scope.ODZP.listRange = {};
                    }
                };

                $scope.getMaxKM = function(strKey){
                    var max = 0;
                    var strRange = '';
                    if(getLabel(strKey, $scope.OD.listDestiny))
                        strRange = $scope.OD.listDestiny[strKey].range;
                    else
                        strRange = getLabel(strKey, $scope.OD.listRange);
                    switch(strRange){
                        case '0-400':
                            max = 400;
                            break;
                        case '401-800':
                            max = 800;
                            break;
                        case '801-1200':
                            max = 1200;
                            break;
                        case '1201-1600':
                            max = 1600;
                            break;
                        case '1601-2000':
                            max = 2000;
                            break;
                        case '2001-2400':
                            max = 2400;
                            break;
                        case 'Más de 2400':
                            max = 2401;
                            break;
                        default :
                            break;
                    }
                    return max;
                };

                $scope.getProjection = function(keyRange, intFreq){
                    var FeeP = 0;
                    var FeeV = 0;

                    FeeP = intFreq * $scope.Convenio.mapTotal[keyRange].fltWeightAVR * $scope.Wrapper.mapTarifarioT['TARIFA T7P'][$scope.Convenio.listRange[keyRange]].Flete__c;
                    FeeV = intFreq * $scope.Convenio.mapTotal[keyRange].fltVolAVR * $scope.Wrapper.mapTarifarioT['TARIFA T7V'][$scope.Convenio.listRange[keyRange]].Flete__c;

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

                $scope.isLastBlock = function(fee, index){
                    return $scope.ODEXP.mapBlock[fee].length === index + 1;
                };

                $scope.isSelected = function(srtFee){
                    return notEmpty(getModel(srtFee, $scope.OD.FeeSelect.selected));
                };

                $scope.isValid = function(strName, ftlQuoteG, fee, keyX,  range){
                    var isValidG = false;
                    switch(strName){
                        case 'fltQuoteG':
                            if(keyX > 0){
                                keyX --;
                                isValidG = ftlQuoteG > $scope.ODEXP.mapBlock[fee][keyX].ranges[range].fltQuoteGuide;
                                keyX++;
                                if(!isValidG)
                                    $scope.OD.lisMessages[fee][keyX]['errQuoteG'] = 'El Costo de arranque no puede menor que el anterior bloque';
                                else
                                    delete $scope.OD.lisMessages[fee][keyX]['errQuoteG'];
                            }
                            else {
                                isValidG = true;
                            }
                            break;
                        case 'fltBase':
                            if(keyX > 0){
                                keyX --;
                                isValidG = ftlQuoteG > $scope.ODEXP.mapBlock[fee][keyX].fltBase;
                                keyX++;
                                if(!isValidG)
                                    $scope.OD.lisMessages[fee][keyX]['errBase'] = 'El Peso de arranque no puede menor que el anterior bloque';
                                else
                                    delete $scope.OD.lisMessages[fee][keyX]['errBase'];
                            }
                            else {
                                isValidG = true;
                            }
                            break;
                        default:
                            isValidG = false;
                            break;
                    }
                    return isValidG;
                };

                $scope.isNotValid = function(strName, num, fee, keyX,  range){
                    if(keyX > 0) {
                        keyX--;
                        switch (strName) {
                            case 'fltQuoteG':
                                return num < $scope.ODEXP.mapBlock[fee][keyX].ranges[range].fltQuoteGuide;
                                break;
                            case 'fltBase':
                                return num < $scope.ODEXP.mapBlock[fee][keyX].fltBase;
                                break;
                            default:
                                return false;
                                break;
                        }
                    }
                    else
                        return false;
                };

                $scope.insertRange = function(strDestiny, strKM){
                    let newList = {};
                    if(isArrayEmpy($scope.OD.listRange))
                        newList[strDestiny] = strDestiny +' ('+ strKM +')';
                    else {
                        let sortable = [];
                        sortable.push([strDestiny, $scope.getMaxKM(strDestiny)]);
                        j$.each($scope.OD.listRange, function (range, key) {
                            sortable.push([range, $scope.getMaxKM(range)]);
                        });
                        sortable.sort();
                        sortable.sort(function (a, b) {
                            return a[1] - b[1];
                        });
                        j$.each(sortable, function (range, key) {
                            if(getLabel(key[0], $scope.OD.listRange))
                                newList[key[0]] = getLabel(key[0], $scope.OD.listRange);
                            else if(getLabel(key[0], $scope.OD.listDestiny))
                                newList[key[0]] = $scope.OD.listDestiny[key[0]].name;
                        });
                    }
                        let listDestiny = {};
                        Object.assign(listDestiny, $scope.OD.listDestiny);
                            $scope.OD.listRange = newList;
                            $scope.ODZP.listRange = newList;

                        $scope.OD.listDestiny = {};
                        if(!isArrayEmpy(listDestiny))
                            j$.each(newList, function (range, key) {
                                if(getLabel(range, listDestiny))
                                    $scope.OD.listDestiny[range] = {
                                        range: listDestiny[range].range
                                        , name: listDestiny[range].name
                                    };
                            });

                };

                $scope.nextOD = function(){
                    $scope.ODstep1 = false;
                    $scope.ODstep2 = true;
                };

                $scope.quickDisc = function(strName){
                    switch (strName) {
                        case 'GENCOST':
                            $scope.OD.fltGENDisc = 0;
                            j$.each($scope.OD.listFee, function (keyFee, strFee) {
                                $scope.OD.mapQuotes[keyFee].fltCost = 0;
                            });
                            j$.each($scope.OD.listRange, function (keyRange, strRange) {
                                $scope.OD.mapRanges[keyRange].fltCost = 0;
                            });
                            break;
                        case 'GENDISC':
                            $scope.OD.fltGENCost = 0;
                            j$.each($scope.OD.listFee, function (keyFee, strFee) {
                                $scope.OD.mapQuotes[keyFee].fltCost = 0;
                            });
                            j$.each($scope.OD.listRange, function (keyRange, strRange) {
                                $scope.OD.mapRanges[keyRange].fltCost = 0;
                            });
                            break;
                        case 'FEECOST':
                            $scope.OD.fltGENCost = 0;
                            $scope.OD.fltGENDisc = 0;
                            j$.each($scope.OD.listRange, function (keyRange, strRange) {
                                $scope.OD.mapRanges[keyRange].fltCost = 0;
                            });
                            break;
                        case 'RANGECOST':
                            $scope.OD.fltGENCost = 0;
                            $scope.OD.fltGENDisc = 0;
                            j$.each($scope.OD.listFee, function (keyFee, strFee) {
                                $scope.OD.mapQuotes[keyFee].fltCost = 0;
                            });
                            break;
                    }
                    $scope.calculateEXPOD();
                };

                $scope.removeBlock = function(key, index){
                    j$.each($scope.OD.listRange, function(keyRange, strRange){
                        $scope.listQLineDEL.push($scope.ODEXP.mapBlock[key][index].ranges[keyRange].Id);
                        $scope.ODEXP.mapBlock[key][index-1].ranges[keyRange].fltAditionalKG = $scope.ODEXP.mapBlock[key][index].ranges[keyRange].fltAditionalKG;
                    });
                    $scope.ODEXP.mapBlock[key].splice(index, 1);
                    $scope.OD.lisMessages[key].splice(index, 1);
                    $scope.calculateEXPOD();
                };

                $scope.removeDestiny = function(strDestinyKey){
                    delete $scope.OD.listRange[strDestinyKey];
                    delete $scope.OD.listDestiny[strDestinyKey];
                    j$.each($scope.ODZP.listFee, function(keyFee, strFee){
                        $scope.OD.mapQuotes[keyFee].ranges[strDestinyKey].intFrecuency = 0;
                        $scope.ODZP.mapQuotes[keyFee].ranges[strDestinyKey].intFrecuency = 0;
                    });
                    $scope.OD.mapQuotes['T7'].ranges[strDestinyKey].intFrecuency = 0;
                    $scope.OD.mapQuotes['T7V'].ranges[strDestinyKey].intFrecuency = 0;
                    $scope.OD.mapQuotes['T7P'].ranges[strDestinyKey].intFrecuency = 0;
                    j$.each($scope.ODEXP.mapBlock, function (key, listBlock) {
                        j$.each(listBlock, function (index, block) {
                            block.ranges[strDestinyKey].intFrecuency = 0;
                        });
                    });
                    $scope.calculateEXPOD();
                    $scope.DeletedDestiny.push(strDestinyKey);
                };

                $scope.removeFee = function(fee){
                    debugger;
                    var index =  j$.inArray(fee, $scope.OD.FeeSelect.selected);
                    $scope.OD.FeeSelect.selected.splice(index, 1);
                    $scope.OD.FeeSelect.available.push(fee);
                    $scope.OD.FeeSelect.available.sort(function (a, b) {
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
                        $scope.OD.mapQuotes[fee.id].blnShow = false;
                        j$.each($scope.OD.listRange, function(keyRange, strRange){
                            if($scope.OD.mapQuotes[fee.id].ranges[keyRange].Id)
                                $scope.listQLineDEL.push($scope.OD.mapQuotes[fee.id].ranges[keyRange].Id);
                            if($scope.ODZP.mapQuotes[fee.id].ranges[keyRange].Id)
                                $scope.listQLineDEL.push($scope.ODZP.mapQuotes[fee.id].ranges[keyRange].Id);
                        });
                        $scope.OD.mapQuotes[fee.id] = {
                            ranges : []
                            , intFeeTotalFrec : 0
                            , fltFeeTotalDesc : 0
                            , fltFeeTotalNormal : 0
                            , fltFeeTotalQuote : 0
                            , blnShow : false
                        };
                        if(fee.id !== 'T7')
                            $scope.ODZP.mapQuotes[fee.id] = {
                                ranges : []
                                , intFeeTotalFrec : 0
                                , fltFeeTotalDesc : 0
                                , fltFeeTotalNormal : 0
                                , fltFeeTotalQuote : 0
                                , blnShow : false
                            };
                        else{
                            $scope.PPT7Calc = '';
                            $scope.OD.mapQuotes['T7V'] = {
                                ranges : []
                                , intFeeTotalQ : 0
                                , fltFeeTotalFrec:0
                                , blnShow: false
                                , blnSameFrecuency : false
                                , blnSameQuote : false
                                , blnSameVolAVR : false
                            };
                            $scope.OD.mapQuotes['T7P'] = {
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
                            $scope.OD.listRange
                            , function(keyRange, strRange) {
                                if(fee.id !== 'T7'){
                                    $scope.OD.mapQuotes[fee.id].ranges[keyRange] = {
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
                                    $scope.ODZP.mapQuotes[fee.id].ranges[keyRange] = {
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
                                    $scope.OD.mapQuotes['T7'].ranges[keyRange] = {
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
                                    $scope.OD.mapQuotes['T7V'].ranges[keyRange] = {
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
                                    $scope.OD.mapQuotes['T7P'].ranges[keyRange] = {
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
                    else{
                        j$.each($scope.ODEXP.mapBlock[fee.id], function (index, block) {
                            j$.each($scope.OD.listRange, function (keyRange, strRange) {
                                block.ranges[keyRange].intFrecuency = 0;
                            });
                        });
                    }
                    $scope.calculateEXPOD();
                };

                $scope.removeService = function(service){
                    var index =  j$.inArray(service, $scope.OD.ServiceSelect.selected);
                    $scope.OD.ServiceSelect.selected.splice(index, 1);
                    $scope.OD.ServiceSelect.available.push(service);
                    switch (service.id) {
                        case 'EAD':
                            $scope.OD.blnEAD = false;
                            break;
                        case 'RAD':
                            $scope.OD.blnRAD = false;
                            break;
                        case 'SEG':
                            $scope.OD.blnSEG = false;
                            break;
                        case 'ACK':
                            $scope.OD.blnACK = false;
                            $scope.OD.strAck = '';
                            break;
                    }
                };

                $scope.replicate = function(field, num, key, fee){
                    num = null;
                    switch (field) {
                        case 'Quantity':
                            if($scope.OD.mapQuotes[key].blnSameFrecuency)
                                j$.each(
                                        $scope.OD.listRange
                                        , function (keyRange, strRange) {
                                            if(num == null)
                                                num = $scope.OD.mapQuotes[key].ranges[keyRange].intFrecuency;
                                            else
                                                $scope.OD.mapQuotes[key].ranges[keyRange].intFrecuency = num;
                                            if(key === 'T7' || key === 'T7V' || key === 'T7P'){
                                                if(num == null)
                                                    num = $scope.OD.mapQuotes[key].ranges[keyRange].intFrecuency;
                                                else{
                                                    $scope.OD.mapQuotes['T7'].ranges[keyRange].intFrecuency = num;
                                                    $scope.OD.mapQuotes['T7P'].ranges[keyRange].intFrecuency = num;
                                                    $scope.OD.mapQuotes['T7V'].ranges[keyRange].intFrecuency = num;
                                                }
                                            }
                                        }
                                );
                            break;
                        case 'QuantityZP':
                            if($scope.ODZP.mapQuotes[key].blnSameFrecuency)
                                j$.each(
                                        $scope.OD.listRange
                                        , function (keyRange, strRange) {
                                            if(num == null)
                                                num = $scope.ODZP.mapQuotes[key].ranges[keyRange].intFrecuency;
                                            else
                                                $scope.ODZP.mapQuotes[key].ranges[keyRange].intFrecuency = num;
                                        }
                                );
                            break;
                        case 'Quote':
                            if($scope.OD.mapQuotes[key].blnSameQuote)
                                j$.each(
                                        $scope.OD.listRange
                                        , function (keyRange, strRange) {
                                            if(num == null)
                                                num = $scope.OD.mapQuotes[key].ranges[keyRange].fltQuoteFee;
                                            else
                                                $scope.OD.mapQuotes[key].ranges[keyRange].fltQuoteFee = num;
                                        }
                                );
                            break;
                        case 'QuoteZP':
                            if($scope.ODZP.mapQuotes[key].blnSameQuote)
                                j$.each(
                                        $scope.OD.listRange
                                        , function (keyRange, strRange) {
                                            if(num == null)
                                                num = $scope.ODZP.mapQuotes[key].ranges[keyRange].fltQuoteFee;
                                            else
                                                $scope.ODZP.mapQuotes[key].ranges[keyRange].fltQuoteFee = num;
                                        }
                                );
                            break;
                        case 'VolAVR':
                            if($scope.OD.mapQuotes[key].blnSameVolAVR)
                                j$.each(
                                        $scope.OD.listRange
                                        , function (keyRange, strRange) {
                                            if(num == null)
                                                num = $scope.OD.mapQuotes[key].ranges[keyRange].fltVolAVR;
                                            else
                                                $scope.OD.mapQuotes[key].ranges[keyRange].fltVolAVR = num;
                                        }
                                );
                            break;
                        case 'WeigthAVR':
                            if($scope.OD.mapQuotes[key].blnSameWeigthAVR)
                                j$.each(
                                        $scope.OD.listRange
                                        , function (keyRange, strRange) {
                                            if(num == null)
                                                num = $scope.OD.mapQuotes[key].ranges[keyRange].fltWeightAVR;
                                            else
                                                $scope.OD.mapQuotes[key].ranges[keyRange].fltWeightAVR = num;
                                        }
                                );
                            break;
                        case 'fltWeight':
                            var fltWeight = 0;
                            if($scope.ODEXP.mapBlock[fee][key].blnSameWeight){
                                j$.each($scope.ODEXP.mapBlock[fee][key].ranges, function(keyRange, range){
                                    if(fltWeight === 0)
                                        fltWeight = range.fltWeight;
                                    $scope.calculateDimensionsOD(fee, keyRange, key);
                                });
                                j$.each($scope.ODEXP.mapBlock[fee][key].ranges, function(keyRange, range){
                                    range.fltWeight = fltWeight;
                                    $scope.calculateDimensionsOD(fee, keyRange, key);
                                });
                            }

                            break;
                        case 'fltLarge':
                            var fltLarge = 0;
                            if($scope.ODEXP.mapBlock[fee][key].blnSameLarge){
                                j$.each($scope.ODEXP.mapBlock[fee][key].ranges, function(keyRange, range){
                                    if(fltLarge === 0)
                                        fltLarge = range.fltLarge;
                                    $scope.calculateDimensionsOD(fee, keyRange, key);
                                });
                                j$.each($scope.ODEXP.mapBlock[fee][key].ranges, function(keyRange, range){
                                    range.fltLarge = fltLarge;
                                    $scope.calculateDimensionsOD(fee, keyRange, key);
                                });
                            }
                            break;
                        case 'fltWidth':
                            var fltWidth = 0;
                            if($scope.ODEXP.mapBlock[fee][key].blnSameWidth){
                                j$.each($scope.ODEXP.mapBlock[fee][key].ranges, function(keyRange, range){
                                    if(fltWidth === 0)
                                        fltWidth = range.fltWidth;
                                    $scope.calculateDimensionsOD(fee, keyRange, key);
                                });
                                j$.each($scope.ODEXP.mapBlock[fee][key].ranges, function(keyRange, range){
                                    range.fltWidth = fltWidth;
                                    $scope.calculateDimensionsOD(fee, keyRange, key);
                                });
                            }
                            break;
                        case 'fltHigh':
                            var fltHigh = 0;
                            if($scope.ODEXP.mapBlock[fee][key].blnSameHigh){
                                j$.each($scope.ODEXP.mapBlock[fee][key].ranges, function(keyRange, range){
                                    if(fltHigh === 0)
                                        fltHigh = range.fltHigh;
                                    $scope.calculateDimensionsOD(fee, keyRange, key);
                                });
                                j$.each($scope.ODEXP.mapBlock[fee][key].ranges, function(keyRange, range){
                                    range.fltHigh = fltHigh;
                                    $scope.calculateDimensionsOD(fee, keyRange, key);
                                });
                            }
                            break;
                        case 'intFrecc':
                            var intFrecc = 0;
                            if($scope.ODEXP.mapBlock[fee][key].blnSameFrec){
                                j$.each($scope.ODEXP.mapBlock[fee][key].ranges, function(keyRange, range){
                                    if(intFrecc === 0)
                                        intFrecc = range.intFrecuency;
                                });
                                j$.each($scope.ODEXP.mapBlock[fee][key].ranges, function(keyRange, range){
                                        range.intFrecuency = intFrecc;
                                });
                            }
                            break;
                        case 'fltQuoteG':
                            var fltQuoteG = 0;
                            if($scope.ODEXP.mapBlock[fee][key].blnSameQuoteG){
                                j$.each($scope.ODEXP.mapBlock[fee][key].ranges, function(keyRange, range){
                                    if(fltQuoteG === 0)
                                        fltQuoteG = range.fltQuoteGuide;
                                });
                                j$.each($scope.ODEXP.mapBlock[fee][key].ranges, function(keyRange, range){
                                    range.fltQuoteGuide = fltQuoteG;
                                });
                            }
                            break;
                        case 'fltAditionalKG':
                            var fltAditionalKG = 0;
                            if($scope.ODEXP.mapBlock[fee][key].blnSameAditionalKG){
                                j$.each($scope.ODEXP.mapBlock[fee][key].ranges, function(keyRange, range){
                                    if(fltAditionalKG === 0)
                                        fltAditionalKG = range.fltAditionalKG;
                                });
                                j$.each($scope.ODEXP.mapBlock[fee][key].ranges, function(keyRange, range){
                                    range.fltAditionalKG = fltAditionalKG;
                                });
                            }
                            break;
                        case 'fltQuoteE':
                            var fltQuoteE = 0;
                            var blnSameQuoteE = false;
                            j$.each($scope.ODEXP.mapBlock[fee], function (index, block) {
                                if(block.blnSameQuoteE)
                                    blnSameQuoteE = true;
                                if (blnSameQuoteE) {
                                    j$.each(block.ranges, function (keyRange, range) {
                                        if (fltQuoteE === 0)
                                            fltQuoteE = range.fltQuoteExtra;
                                    });
                                    j$.each(block.ranges, function (keyRange, range) {
                                        range.fltQuoteExtra = fltQuoteE;
                                    });
                                }
                            });
                            break;
                    }
                    $scope.calculateEXPOD();
                };

                $scope.setValue = function(name, key, cmp, keyX, fee){
                    if (notEmpty(cmp.target.textContent))
                        switch (name) {
                            case 'PPintFrecuency':
                                $scope.OD.mapQuotes[keyX].ranges[key].intFrecuency = getNum(cmp.target.textContent);
                                if(keyX === 'T7' || keyX === 'T7V' || keyX === 'T7P'){
                                    $scope.OD.mapQuotes['T7'].ranges[key].intFrecuency = getNum(cmp.target.textContent);
                                    $scope.OD.mapQuotes['T7P'].ranges[key].intFrecuency = getNum(cmp.target.textContent);
                                    $scope.OD.mapQuotes['T7V'].ranges[key].intFrecuency = getNum(cmp.target.textContent);
                                }
                                $scope.calculateEXPOD();
                                break;
                            case 'PPfltQuoteFee':
                                $scope.OD.mapQuotes[keyX].ranges[key].fltQuoteFee = getNumFromCurrency(cmp.target.textContent);
                                $scope.calculateEXPOD();
                                break;
                            case 'PPfltVolAVR':
                                $scope.OD.mapQuotes[keyX].ranges[key].fltVolAVR = getNum(cmp.target.textContent);
                                break;
                            case 'PPfltWeightAVR':
                                $scope.OD.mapQuotes[keyX].ranges[key].fltWeightAVR = getNum(cmp.target.textContent);
                                break;
                            case 'PPintFrecuencyZP':
                                $scope.ODZP.mapQuotes[keyX].ranges[key].intFrecuency = getNum(cmp.target.textContent);
                                $scope.calculateEXPOD();
                                break;
                            case 'PPfltQuoteFeeZP':
                                $scope.ODZP.mapQuotes[keyX].ranges[key].fltQuoteFee = getNumFromCurrency(cmp.target.textContent);
                                $scope.calculateEXPOD();
                                break;
                            case 'SSfltAmount':
                                $scope.SS.ranges[key].Service[keyX].fltAmount = getNumFromCurrency(cmp.target.textContent);
                                break;
                            case 'SSfltPotencial':
                                $scope.SS.service[key].potential = getNumFromCurrency(cmp.target.textContent);
                                break;
                            case 'intFrecc':
                                $scope.ODEXP.mapBlock[fee][keyX].ranges[key].intFrecuency = getNum(cmp.target.textContent);
                                $scope.ODEXP.mapBlock[fee][keyX].intTotalQ += $scope.ODEXP.mapBlock[fee][keyX].ranges[key].intFrecuency;
                                $scope.calculateEXPOD();
                                break;
                            case 'fltWeight':
                                $scope.ODEXP.mapBlock[fee][keyX].ranges[key].fltWeight = getNum(cmp.target.textContent);
                                $scope.calculateDimensionsOD(fee, key, keyX);
                                break;
                            case 'fltLarge':
                                $scope.ODEXP.mapBlock[fee][keyX].ranges[key].fltLarge = getNum(cmp.target.textContent);
                                $scope.calculateDimensionsOD(fee, key, keyX);
                                break;
                            case 'fltWidth':
                                $scope.ODEXP.mapBlock[fee][keyX].ranges[key].fltWidth = getNum(cmp.target.textContent);
                                $scope.calculateDimensionsOD(fee, key, keyX);
                                break;
                            case 'fltHigh':
                                $scope.ODEXP.mapBlock[fee][keyX].ranges[key].fltHigh = getNum(cmp.target.textContent);
                                $scope.calculateDimensionsOD(fee, key, keyX);
                                break;
                            case 'fltQuoteG': //keyRange, $event, index, keyBlock)
                                $scope.ODEXP.mapBlock[fee][keyX].ranges[key].fltQuoteGuide = getNumFromCurrency(cmp.target.textContent);
                                $scope.isValid('fltQuoteG', getNumFromCurrency(cmp.target.textContent), fee, keyX, key);
                                $scope.calculateEXPOD();
                                break;
                            case 'fltBase':
                                $scope.ODEXP.mapBlock[fee][keyX].fltBase = getNum(cmp.target.textContent);
                                $scope.isValid('fltBase', getNumFromCurrency(cmp.target.textContent), fee, keyX, key);
                                $scope.calculateEXPOD();
                                break;
                            case 'fltAditionalKG':
                                $scope.ODEXP.mapBlock[fee][keyX].ranges[key].fltAditionalKG = getNumFromCurrency(cmp.target.textContent);
                                $scope.calculateEXPOD();
                                break;
                            case 'fltQuoteE':
                                j$.each($scope.ODEXP.listFeeEXP, function (keyFee, labelFee) {
                                    if($scope.isSelected(keyFee))
                                        j$.each($scope.ODEXP.mapBlock[keyFee], function (i, block) {
                                            block.ranges[key].fltQuoteExtra = getNumFromCurrency(cmp.target.textContent);
                                        });
                                });
                                $scope.calculateEXPOD();
                                break;
                        }
                    else if(name === 'PPintFrecuency' ){
                        $scope.OD.mapQuotes[keyX].ranges[key].intFrecuency = 0;
                        if(keyX === 'T7' || keyX === 'T7V' || keyX === 'T7P'){
                            $scope.OD.mapQuotes['T7'].ranges[key].intFrecuency = 0;
                            $scope.OD.mapQuotes['T7P'].ranges[key].intFrecuency = 0;
                            $scope.OD.mapQuotes['T7V'].ranges[key].intFrecuency = 0;
                        }
                        $scope.calculateEXPOD();
                    }
                    else if(name === 'PPintFrecuencyZP' ){
                        $scope.ODZP.mapQuotes[keyX].ranges[key].intFrecuency = 0;
                        $scope.calculateEXPOD();
                    }
                    else if (name ==='intFrecc'){
                        $scope.ODEXP.mapBlock[fee][keyX].ranges[key].intFrecuency = 0;
                        $scope.calculatePPEXP(fee);
                    }
                    else
                        cmp.target.innerText = 0;
                };

                $scope.sumbit = function (){
                    var strNameProcess = '';
                    var strProfile = "{!profileObj}";
                    var objQuote;
                    var gerenteSucursal = null;
                    if($scope.OD.blnCotizaT7ZP){
                        alert('No puede ejecutar el flujo de aprobación desde este punto habiendo cotizado T7 zona plus. Favor de ejecutarlo desde fuera de la cotización.');
                        xhrInstance.abort();
                    }

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
                            callSent($scope, $scope.Wrapper.objQuote.Id, strNameProcess, $scope.OD.strApprovalComment);
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
                            callSent($scope, $scope.Wrapper.objQuote.Id, strNameProcess, $scope.OD.strApprovalComment);
                        else
                            $scope.DML.listErrors.push('NO se encontró el proceso de aprobación aplicable');
                    }
                };

                $scope.updateFees = function(strOpp, strList){
                    debugger;
                    switch (strOpp) {
                        case 'add':
                            if(strList=== 'fee')
                                for (var index = 0; index <= $scope.OD.FeeSelect.available.length; index++){
                                    var fee = $scope.OD.FeeSelect.available[index];
                                    if(fee && fee.blnSelected){
                                        fee.blnSelected = false;
                                        $scope.addFee(fee);
                                        index--;
                                    }
                                }
                            if(strList=== 'service')
                                for (var index = 0; index <= $scope.OD.ServiceSelect.available.length; index++){
                                    var service = $scope.OD.ServiceSelect.available[index];
                                    if(service && service.blnSelected){
                                        service.blnSelected = false;
                                        $scope.addService(service);
                                        index--;
                                    }
                                }
                            if($scope.OnlineDocByRangeKM)
                                $scope.calculateEXPOD();
                            break;
                        case 'remove':
                            if(strList=== 'fee')
                                for (var index = 0; index <= $scope.OD.FeeSelect.selected.length; index++){
                                    var fee = $scope.OD.FeeSelect.selected[index];
                                    if(fee && fee.blnSelected){
                                        fee.blnSelected = false;
                                        $scope.removeFee(fee);
                                        index--;
                                    }
                                }
                            else if(strList=== 'service')
                                for (var index = 0; index <= $scope.OD.ServiceSelect.selected.length; index++){
                                    var service = $scope.OD.ServiceSelect.selected[index];
                                    if(service && service.blnSelected){
                                        service.blnSelected = false;
                                        $scope.removeService(service);
                                        index--;
                                    }
                                }
                            if($scope.OnlineDocByRangeKM)
                                $scope.calculateEXPOD();
                            break;
                    }
                    $scope.OD.blnFeeAddAll = false;
                    $scope.OD.blnFeeRemoveAll = false;
                    $scope.OD.blnServiceAddAll = false;
                    $scope.OD.blnServiceRemoveAll = false;
                    $scope.calculateEXPOD();
                };

                $scope.redireccionar = function(){
                    debugger;
                    $scope.DocLineaTZP = true;
                    j$('.tabPill').removeClass('active');
                    j$('.tab-pane').removeClass('in active');
                    $scope.$parent.$parent.DocLineaTZP = true;
                    $scope.$parent.$parent.blnT7CostosFijos = true;
                    j$('#OZP').addClass('in active');
                    j$('#OZP').addClass('active');
                    //$scope.Quotes = $scope.OD.mapTender;
                    $scope.start();
                };

                $scope.dataTest = function() {

                };

                /*
                * initial Call
                */
                console.log('END LOAD Angular Controller ODC');
                debugger;
                var t7Fee = {'T7P':'TARIFA T7-P', 'T7V':'TARIFA T7-V'};
                $scope.fillRanges();
                if($scope.Wrapper.mapTender && !$scope.OnlineDocByDestiny)
                    LlenaMapaTenders($scope, true);
                $scope.OD.OnlineDocByDestiny = $scope.OnlineDocByDestiny;
                if($scope.hasRecord()){
                    $scope.OnlineDocByRangeKM = $scope.Wrapper.objQuote.RangosKM__c;
                    $scope.OnlineDocByDestiny = $scope.Wrapper.objQuote.Destinos__c;
                    $scope.OD.strOrigen       = $scope.Wrapper.objQuote.OriginCity__c;
                    $scope.OD.blnCotizaT7ZP   = $scope.Wrapper.objQuote.Es_T7_Zona_plus__c;
                    $scope.fillRanges();
                    $scope.OD.strAck = $scope.Wrapper.objQuote.Acuse__c;
                    $scope.OD.strOrigin = $scope.Wrapper.objQuote.Plaza__c;
                    $scope.OD.OnlineDocByDestiny = $scope.OnlineDocByDestiny;
                    if(notEmpty($scope.Wrapper.objQuote.Plaza__c))
                        $scope.OD.OriginDisabled = true;
                    if($scope.Wrapper.objQuote.Servicios_adicionales__c)
                        j$.each( $scope.Wrapper.objQuote.Servicios_adicionales__c.split(';'),function (key, service) {
                            switch (service) {
                                case 'RAD':
                                    $scope.OD.blnRAD = true;
                                    break;
                                case 'EAD':
                                    $scope.OD.blnEAD = true;
                                    break;
                                case 'Seguro':
                                    $scope.OD.blnSEG = true;
                                    break;
                                case 'Acuse Empresa':
                                    $scope.OD.blnACK = true;
                                    break;
                                case 'Acuse Interno':
                                    $scope.OD.blnACK = true;
                                    break;
                                case 'Acuse XT':
                                    $scope.OD.blnACK = true;
                                    break;
                            }

                        });
                    j$.each($scope.OD.ServiceSelect.available, function(key, value){
                        switch (value.id) {
                            case 'RAD':
                                value.blnSelected = $scope.OD.blnRAD;
                                break;
                            case 'EAD':
                                value.blnSelected = $scope.OD.blnEAD;
                                break;
                            case 'SEG':
                                value.blnSelected = $scope.OD.blnSEG;
                                break;
                            case 'ACK':
                                value.blnSelected = $scope.OD.blnACK;
                                break;
                        }
                    });
                    $scope.updateFees('add', 'service');
                    if($scope.OnlineDocByDestiny){
                        $scope.OD.mapQuotesT7ZP.Tender = {};
                        $scope.OD.mapTender = {};
                    }else {
                        j$.each($scope.OD.mapTender, function(keyTender, strTender){
                            $scope.OD.mapQuotesT7ZP.Tender[keyTender].strOrigen = $scope.OD.strOrigen;
                            ObtieneRangoKMT7ZP($scope, $scope.OD.strOrigen, keyTender.replace('70',''));
                        });
                    }
                    if($scope.Wrapper.listQuoteItem) {
                        j$.each($scope.Wrapper.listQuoteItem
                                , function (index, quoteItem) {
                                    if(!getModel(getId(quoteItem.Tarifa__c, $scope.OD.listFee), $scope.OD.FeeSelect.selected)
                                            && getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) !== 'T7P' && getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) !== 'T7V'
                                            && quoteItem.Tarifa__c.toUpperCase() !== 'SEG-DS' && quoteItem.Tarifa__c.toUpperCase() !== 'SEG-2D' && quoteItem.Tarifa__c.toUpperCase() !== 'SEG-A12'
                                    )
                                        $scope.addFee(getModel(getId(quoteItem.Tarifa__c, $scope.OD.listFee), $scope.OD.FeeSelect.available));
                                    if($scope.OD.fltSEG === 0)
                                        $scope.OD.fltSEG = quoteItem.Pack_Seg__c;
                                    if(quoteItem.Tarifa__c === 'TARIFA T7')
                                        $scope.PPT7Calc = $scope.Wrapper.objQuote.TipoCotizacion__c;
                                    

                                    if(quoteItem.Tarifa__c === 'TARIFA T7' && quoteItem.ZonaPlus__c){
                                        let rango = '';
                                        if($scope.OnlineDocByDestiny){
                                            rango = quoteItem.Destiny__c;
                                            $scope.OD.mapTender[quoteItem.Destiny__c] = {
                                                strName : quoteItem.Destiny__c
                                                , keyName : quoteItem.Destiny__c
                                                , fltLarge : 0//Tender.Largo__c
                                                , fltWidth : 0//Tender.Peso__c
                                                , fltHigh : 0//Tender.Alto__c
                                                , fltWeight : 0//Tender.Peso__c
                                                , fltVol : 0//Tender.Alto__c * Tender.Peso__c * Tender.Largo__c
                                                , fltCost : 0//Tender.Costo__c
                                                , fltExc : 0//Tender.Costo__c
                                                , blnDestino : true
                                                , id : ''
                                            };
                                            LlenaMapaTenders($scope, false);
                                        } else {
                                            if(quoteItem.SBQQ__Description__c === 'Destino')
                                                rango = quoteItem.Destiny__c;
                                            else if (quoteItem.SBQQ__Description__c === 'Propuesta' && quoteItem.Destiny__c)
                                                rango = quoteItem.Destiny__c;
                                            else {
                                                if(quoteItem.Rango_KM__c === 'Más de 2400')
                                                    rango = '+2400';
                                                else rango = quoteItem.Rango_KM__c;
                                            }
                                        }
                                        if(!quoteItem.SBQQ__Description__c)
                                            $scope.OD.mapQuotesT7ZP.Tender[quoteItem.Destiny__c] = {
                                                Id : quoteItem.Id
                                                , strName : quoteItem.Destiny__c.replace('70', '')
                                                , keyName : quoteItem.Destiny__c
                                                , fltLargo : quoteItem.Large__c
                                                , fltAncho : quoteItem.Width__c
                                                , fltAlto : quoteItem.High__c
                                                , fltPeso : quoteItem.Weight__c
                                                , fltVol : quoteItem.VolWeight__c
                                                , fltCost : quoteItem.SBQQ__SpecialPrice__c
                                                , fltExc : quoteItem.SBQQ__SpecialPrice__c
                                                , intFrecuency : quoteItem.SBQQ__Quantity__c
                                                , strRange : quoteItem.Rango_KM__c
                                                , strOrigen : $scope.OD.strOrigin
                                                , fltFullFee : quoteItem.Flete__c
                                                , strTenderDestino : quoteItem.Destiny__c
                                            }
                                        else{
                                            if(quoteItem.SBQQ__Description__c === 'Destino'){
                                                $scope.OD.mapQuotesT7ZP.Tender[quoteItem.Destiny__c] = {
                                                    Id : quoteItem.Id
                                                    , strName : quoteItem.Destiny__c.replace('70', '')
                                                    , keyName : quoteItem.Destiny__c
                                                    , fltLargo : quoteItem.Large__c
                                                    , fltAncho : quoteItem.Width__c
                                                    , fltAlto : quoteItem.High__c
                                                    , fltPeso : quoteItem.Weight__c
                                                    , fltVol : quoteItem.VolWeight__c
                                                    , fltCost : quoteItem.SBQQ__SpecialPrice__c
                                                    , fltExc : quoteItem.SBQQ__SpecialPrice__c
                                                    , intFrecuency : quoteItem.SBQQ__Quantity__c
                                                    , strRange : quoteItem.Rango_KM__c
                                                    , strOrigen : $scope.OD.strOrigin
                                                    , fltFullFee : quoteItem.Flete__c
                                                    , strTenderDestino : quoteItem.Destiny__c
                                                };
                                                $scope.OD.mapTender[quoteItem.Destiny__c] = {
                                                    strName : quoteItem.Destiny__c
                                                    , keyName : quoteItem.Destiny__c
                                                    , fltLarge : 0//Tender.Largo__c
                                                    , fltWidth : 0//Tender.Peso__c
                                                    , fltHigh : 0//Tender.Alto__c
                                                    , fltWeight : 0//Tender.Peso__c
                                                    , fltVol : 0//Tender.Alto__c * Tender.Peso__c * Tender.Largo__c
                                                    , fltCost : 0//Tender.Costo__c
                                                    , fltExc : 0//Tender.Costo__c
                                                    , blnDestino : true
                                                    , id : ''
                                                };
                                                LlenaMapaTenders($scope, false);
                                                $scope.OD.listRangePrecio['T7P'].ranges[quoteItem.Destiny__c] = {
                                                    fltCost : 0
                                                };
                                                $scope.OD.listRangePrecio['T7V'].ranges[quoteItem.Destiny__c] = {
                                                    fltCost : 0
                                                };
                                                $scope.OD.mapPropuesta['PROP'].ranges[quoteItem.Destiny__c] = {
                                                    fltDescuento : quoteItem.SBQQ__Discount__c
                                                    , fltTotalPropuesta : quoteItem.SBQQ__CustomerPrice__c
                                                    , fltTotalTarifaLlena : quoteItem.SBQQ__NetPrice__c
                                                    , fltCost : quoteItem.SBQQ__SpecialPrice__c
                                                    , intFrecuency : 0
                                                    , Id : quoteItem.Id
                                                };
                                            } else if(quoteItem.SBQQ__Description__c === 'Propuesta'){
                                                $scope.OD.mapPropuesta['PROP'].ranges[rango] = {
                                                    fltDescuento : quoteItem.SBQQ__Discount__c
                                                    , fltTotalPropuesta : quoteItem.SBQQ__CustomerPrice__c
                                                    , fltTotalTarifaLlena : quoteItem.SBQQ__NetPrice__c
                                                    , fltCost : quoteItem.SBQQ__SpecialPrice__c
                                                    , intFrecuency : 0
                                                    , Id : quoteItem.Id
                                                };
                                            }
                                                
                                            /*if($scope.OnlineDocByDestiny){
                                                if(!getId(quoteItem.Destiny__c +' ('+ quoteItem.Rango_KM__c +')', $scope.OD.listRange)){
                                                    $scope.OD.listRange[quoteItem.Destiny__c] = quoteItem.Destiny__c +' ('+ quoteItem.Rango_KM__c +')';
                                                    $scope.OD.listDestiny[quoteItem.Destiny__c] = {
                                                        range: quoteItem.Rango_KM__c
                                                        , name: quoteItem.Destiny__c +' ('+ quoteItem.Rango_KM__c +')'
                                                    } ;
                                                }
                                            }*/
                                            //$scope.OD.listRange[quoteItem.Destiny__c] = quoteItem.Destiny__c +' ('+ quoteItem.Rango_KM__c +')';
                                            /*$scope.OD.listDestiny[quoteItem.Destiny__c] = {
                                                range: quoteItem.Rango_KM__c
                                                , name: quoteItem.Destiny__c +' ('+ quoteItem.Rango_KM__c +')'
                                            } ;*/
                                            
                                            
                                        }
                                        
                                        if($scope.OnlineDocByDestiny) {
                                            if(!getId(
                                                    quoteItem.Destiny__c +' ('+ quoteItem.Rango_KM__c +')'
                                                    , $scope.OD.listRange
                                            )){
                                                $scope.OD.listRange[quoteItem.Destiny__c] = quoteItem.Destiny__c +' ('+ quoteItem.Rango_KM__c +')';
                                                $scope.ODZP.listRange[quoteItem.Destiny__c] = quoteItem.Destiny__c +' ('+ quoteItem.Rango_KM__c +')';
                                                $scope.OD.listDestiny[quoteItem.Destiny__c] = {
                                                    range: quoteItem.Rango_KM__c
                                                    , name: quoteItem.Destiny__c +' ('+ quoteItem.Rango_KM__c +')'
                                                } ;
                                                j$.each(
                                                        $scope.OD.listFee
                                                        , function(keyFee, fee){
                                                            $scope.OD.mapQuotes[keyFee].ranges[quoteItem.Destiny__c] = {
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
                                                            if(keyFee !== 'T7')
                                                                $scope.ODZP.mapQuotes[keyFee].ranges[quoteItem.Destiny__c] = {
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
                                                            $scope.OD.mapRanges[quoteItem.Destiny__c] = {
                                                                fltCost: 0
                                                            };
                                                            $scope.SS.ranges[quoteItem.Destiny__c] = {
                                                                fltTotalByRange : 0
                                                                , Service: []
                                                            };
                                                            j$.each($scope.SS.listService
                                                                    , function(keyService, strService){
                                                                        $scope.SS.service[keyService] = {
                                                                            mainDestinies : ''
                                                                            , potential : 0
                                                                        };
                                                                        $scope.SS.ranges[quoteItem.Destiny__c].Service[keyService] = {
                                                                            Option : {
                                                                                model : undefined
                                                                                , aviableOptions : [] }
                                                                            , fltAmount : 0
                                                                        };
                                                                        j$.each($scope.SS.listOption
                                                                                , function(keyOption, strOption){
                                                                                    $scope.SS.ranges[quoteItem.Destiny__c].Service[keyService].Option.aviableOptions.push({id: keyOption, label: strOption});
                                                                                }
                                                                        );
                                                                    }
                                                            );
                                                        }
                                                );
                                                $scope.OD.mapQuotes['T7'].ranges[quoteItem.Destiny__c].fltVolAVR = 0;
                                                $scope.OD.mapQuotes['T7'].ranges[quoteItem.Destiny__c].fltWeightAVR = 0;
                                                $scope.OD.mapQuotes['T7P'].ranges[quoteItem.Destiny__c] = {
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
                                                $scope.OD.mapQuotes['T7V'].ranges[quoteItem.Destiny__c] = {
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
                                                $scope.OD.listRangePrecio['T7P'].ranges[quoteItem.Destiny__c] = {
                                                    fltCost : 0
                                                };
                                                $scope.OD.listRangePrecio['T7V'].ranges[quoteItem.Destiny__c] = {
                                                    fltCost : 0
                                                };
                                                j$.each($scope.ODEXP.mapBlock, function (key, listBlock) {
                                                    j$.each(listBlock, function (i, block) {
                                                        block.ranges[quoteItem.Destiny__c] = {
                                                            intFrecuency : 0
                                                            , fltFrecuency :0
                                                            , fltWeight : 0
                                                            , fltVol : 0
                                                            , fltVolWeight : 0
                                                            , fltDominantWeight : 0
                                                            , fltLarge : 0
                                                            , fltHigh : 0
                                                            , fltWidth : 0
                                                            , fltAmount : 0
                                                            , fltFullFee : 0
                                                            , fltTotalFull : 0
                                                            , fltQuoteFee : 0
                                                            , fltQuoteGuide : 0
                                                            , fltAditionalKG : 0
                                                            , fltQuoteExtra : 0
                                                            , fltTotalQuote : 0
                                                            , fltDisc : 0
                                                        };
                                                    });
                                                });
                                            }
                                            quoteItem.Rango_KM__c = quoteItem.Destiny__c +' ('+ quoteItem.Rango_KM__c +')';
                                        }
                                    } else {
                                        if(notEmpty(quoteItem.Destiny__c)) {
                                            if(!getId(
                                                    quoteItem.Destiny__c +' ('+ quoteItem.Rango_KM__c +')'
                                                    , $scope.OD.listRange
                                            )){
                                                $scope.OD.listRange[quoteItem.Destiny__c] = quoteItem.Destiny__c +' ('+ quoteItem.Rango_KM__c +')';
                                                $scope.ODZP.listRange[quoteItem.Destiny__c] = quoteItem.Destiny__c +' ('+ quoteItem.Rango_KM__c +')';
                                                $scope.OD.listDestiny[quoteItem.Destiny__c] = {
                                                    range: quoteItem.Rango_KM__c
                                                    , name: quoteItem.Destiny__c +' ('+ quoteItem.Rango_KM__c +')'
                                                } ;
                                                j$.each(
                                                        $scope.OD.listFee
                                                        , function(keyFee, fee){
                                                            $scope.OD.mapQuotes[keyFee].ranges[quoteItem.Destiny__c] = {
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
                                                            if(keyFee !== 'T7')
                                                                $scope.ODZP.mapQuotes[keyFee].ranges[quoteItem.Destiny__c] = {
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
                                                            $scope.OD.mapRanges[quoteItem.Destiny__c] = {
                                                                fltCost: 0
                                                            };
                                                            $scope.SS.ranges[quoteItem.Destiny__c] = {
                                                                fltTotalByRange : 0
                                                                , Service: []
                                                            };
                                                            j$.each($scope.SS.listService
                                                                    , function(keyService, strService){
                                                                        $scope.SS.service[keyService] = {
                                                                            mainDestinies : ''
                                                                            , potential : 0
                                                                        };
                                                                        $scope.SS.ranges[quoteItem.Destiny__c].Service[keyService] = {
                                                                            Option : {
                                                                                model : undefined
                                                                                , aviableOptions : [] }
                                                                            , fltAmount : 0
                                                                        };
                                                                        j$.each($scope.SS.listOption
                                                                                , function(keyOption, strOption){
                                                                                    $scope.SS.ranges[quoteItem.Destiny__c].Service[keyService].Option.aviableOptions.push({id: keyOption, label: strOption});
                                                                                }
                                                                        );
                                                                    }
                                                            );
                                                        }
                                                );
                                                $scope.OD.mapQuotes['T7'].ranges[quoteItem.Destiny__c].fltVolAVR = 0;
                                                $scope.OD.mapQuotes['T7'].ranges[quoteItem.Destiny__c].fltWeightAVR = 0;
                                                $scope.OD.listRangePrecio['T7P'].ranges[quoteItem.Destiny__c] = {
                                                    fltCost : 0
                                                };
                                                $scope.OD.listRangePrecio['T7V'].ranges[quoteItem.Destiny__c] = {
                                                    fltCost : 0
                                                };
                                                $scope.OD.mapQuotes['T7P'].ranges[quoteItem.Destiny__c] = {
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
                                                $scope.OD.mapQuotes['T7V'].ranges[quoteItem.Destiny__c] = {
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
                                                j$.each($scope.ODEXP.mapBlock, function (key, listBlock) {
                                                    j$.each(listBlock, function (i, block) {
                                                        block.ranges[quoteItem.Destiny__c] = {
                                                            intFrecuency : 0
                                                            , fltFrecuency :0
                                                            , fltWeight : 0
                                                            , fltVol : 0
                                                            , fltVolWeight : 0
                                                            , fltDominantWeight : 0
                                                            , fltLarge : 0
                                                            , fltHigh : 0
                                                            , fltWidth : 0
                                                            , fltAmount : 0
                                                            , fltFullFee : 0
                                                            , fltTotalFull : 0
                                                            , fltQuoteFee : 0
                                                            , fltQuoteGuide : 0
                                                            , fltAditionalKG : 0
                                                            , fltQuoteExtra : 0
                                                            , fltTotalQuote : 0
                                                            , fltDisc : 0
                                                        };
                                                    });
                                                });
                                            }
                                            quoteItem.Rango_KM__c = quoteItem.Destiny__c +' ('+ quoteItem.Rango_KM__c +')';
                                        }
                                        if(quoteItem.Tarifa__c.toUpperCase() === 'SEG-DS' || quoteItem.Tarifa__c.toUpperCase() === 'SEG-2D' || quoteItem.Tarifa__c.toUpperCase() === 'SEG-A12'){
                                            var key = getId(quoteItem.Tarifa__c, $scope.ODEXP.listFeeEXP);
                                            var range = getId(quoteItem.Rango_KM__c, $scope.OD.listRange);
                                            if(!getModel(key, $scope.OD.FeeSelect.selected))
                                                $scope.addFee(getModel(key, $scope.OD.FeeSelect.available));
                                            if(!isIn(quoteItem.GUIA__c.toString(), $scope.SetBlocks))
                                                $scope.SetBlocks.push(quoteItem.GUIA__c.toString());
                                            quoteItem.key = key;
                                            quoteItem.range = range;
                                            if(notEmpty(getLabel(quoteItem.GUIA__c.toString(), $scope.MapQuoteLineEXP)))
                                                $scope.MapQuoteLineEXP[quoteItem.GUIA__c.toString()].push(quoteItem);
                                            else{
                                                $scope.MapQuoteLineEXP[quoteItem.GUIA__c.toString()] = [quoteItem];
                                            }
                                        }
                                        else if(quoteItem.ZonaPlus__c && quoteItem.Tarifa__c !== 'TARIFA T7'){
                                            $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].Id = quoteItem.Id;
                                            $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                            $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltDiscount = quoteItem.SBQQ__Discount__c;
                                            $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltQuoteFee = quoteItem.SBQQ__CustomerPrice__c;
                                            $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltFullFee = quoteItem.SBQQ__NetPrice__c;
                                            $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltTotalQuote = quoteItem.QuoteTotal__c;
                                            if(quoteItem.ACK__c)
                                                $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltACK = quoteItem.ACK__c;
                                            if(quoteItem.EAD__c)
                                                $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltEAD = quoteItem.EAD__c;
                                            if(quoteItem.RAD__c)
                                                $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltRAD = quoteItem.RAD__c;
                                            if(quoteItem.SEG__c)
                                                $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltAmountSeg = quoteItem.SEG__c;
                                        }
                                        else if (getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) !== 'T7P' && getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) !== 'T7V'){
                                            $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].Id = quoteItem.Id;
                                            $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                            $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltDiscount = quoteItem.SBQQ__Discount__c;
                                            $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltQuoteFee = quoteItem.SBQQ__CustomerPrice__c;
                                            $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltFullFee = quoteItem.SBQQ__NetPrice__c;
                                            $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltTotalQuote = quoteItem.QuoteTotal__c;
                                            if(quoteItem.ACK__c)
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltACK = quoteItem.ACK__c;
                                            if(quoteItem.EAD__c)
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltEAD = quoteItem.EAD__c;
                                            if(quoteItem.RAD__c)
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltRAD = quoteItem.RAD__c;
                                            if(quoteItem.SEG__c)
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltAmountSeg = quoteItem.SEG__c;
                                            if(quoteItem.Tarifa__c === 'TARIFA T7'){
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltVolAVR = quoteItem.PackVolAVG__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltWeightAVR  = quoteItem.PackWeightAVG__c;
                                            }
                                        }
                                        else if (getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) === 'T7P' || getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) === 'T7V'){
                                            $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].Id = quoteItem.Id;
                                            $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                            $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltDiscount = quoteItem.SBQQ__Discount__c;
                                            $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltQuoteFee = quoteItem.SBQQ__CustomerPrice__c;
                                            $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltFullFee = quoteItem.SBQQ__NetPrice__c;
                                            $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltTotalQuote = quoteItem.QuoteTotal__c;
                                            $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltACK = quoteItem.ACK__c;
                                            $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltEAD = quoteItem.EAD__c;
                                            $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltRAD = quoteItem.RAD__c;
                                            $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltAmountSeg = quoteItem.SEG__c;
                                            $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltVolAVR = quoteItem.PackVolAVG__c;
                                            $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltWeightAVR  = quoteItem.PackWeightAVG__c;
                                        }
                                    }
                                        
                                    //}
                                }
                        );
                    }
                    $scope.SetBlocks.sort(function (a, b) {
                        if (a.order > b.order) {
                            return 1;
                        }
                        if (a.order < b.order) {
                            return -1;
                        }
                        // a must be equal to b
                        return 0;
                    });
                    //fill SEG
                    j$.each($scope.MapQuoteLineEXP, function(fltBase, listBlocks){
                        j$.each(listBlocks, function(index,itemb){
                            if($scope.SetBlocks.indexOf(fltBase) === 0){
                                $scope.ODEXP.mapBlock[itemb.key][0].ranges[itemb.range].intFrecuency = itemb.SBQQ__Quantity__c;
                                $scope.ODEXP.mapBlock[itemb.key][0].ranges[itemb.range].fltWeight = itemb.Weight__c;
                                $scope.ODEXP.mapBlock[itemb.key][0].ranges[itemb.range].fltLarge = itemb.Large__c;
                                $scope.ODEXP.mapBlock[itemb.key][0].ranges[itemb.range].fltHigh = itemb.High__c;
                                $scope.ODEXP.mapBlock[itemb.key][0].ranges[itemb.range].fltWidth = itemb.Width__c;
                                $scope.ODEXP.mapBlock[itemb.key][0].ranges[itemb.range].fltQuoteGuide = itemb.FLETE__c;
                                $scope.ODEXP.mapBlock[itemb.key][0].ranges[itemb.range].fltAditionalKG = itemb.KG_ADICIONAL__c ;
                                $scope.ODEXP.mapBlock[itemb.key][0].ranges[itemb.range].fltQuoteExtra = itemb.ACK__c ;
                                $scope.ODEXP.mapBlock[itemb.key][0].ranges[itemb.range].Id = itemb.Id;
                                $scope.ODEXP.mapBlock[itemb.key][0].fltBase = parseFloat(fltBase);
                            }
                            else{
                                var index = $scope.SetBlocks.indexOf(fltBase);
                                if($scope.ODEXP.mapBlock[itemb.key][index] && $scope.ODEXP.mapBlock[itemb.key][index].ranges[itemb.range]){
                                    $scope.ODEXP.mapBlock[itemb.key][index].ranges[itemb.range].intFrecuency = itemb.SBQQ__Quantity__c;
                                    $scope.ODEXP.mapBlock[itemb.key][index].ranges[itemb.range].fltWeight = itemb.Weight__c;
                                    $scope.ODEXP.mapBlock[itemb.key][index].ranges[itemb.range].fltLarge = itemb.Large__c;
                                    $scope.ODEXP.mapBlock[itemb.key][index].ranges[itemb.range].fltHigh = itemb.High__c;
                                    $scope.ODEXP.mapBlock[itemb.key][index].ranges[itemb.range].fltWidth = itemb.Width__c;
                                    $scope.ODEXP.mapBlock[itemb.key][index].ranges[itemb.range].fltQuoteGuide = itemb.FLETE__c;
                                    $scope.ODEXP.mapBlock[itemb.key][index].ranges[itemb.range].fltAditionalKG = itemb.KG_ADICIONAL__c ;
                                    $scope.ODEXP.mapBlock[itemb.key][index].ranges[itemb.range].fltQuoteExtra = itemb.ACK__c ;
                                    $scope.ODEXP.mapBlock[itemb.key][index].ranges[itemb.range].Id = itemb.Id;
                                }
                                else if($scope.ODEXP.mapBlock[itemb.key][index]){
                                    var block = $scope.ODEXP.mapBlock[itemb.key][index];
                                    block.ranges[itemb.range] = {
                                                fltFrecuency :0
                                                , fltVol : 0
                                                , fltVolWeight : 0
                                                , fltDominantWeight : 0
                                                , fltAmount : 0
                                                , fltFullFee : 0
                                                , fltTotalFull : 0
                                                , fltQuoteFee : 0
                                                , fltTotalQuote : 0
                                                , fltDisc : 0
                                                , fltQuoteFull : 0
                                                , intFrecuency : itemb.SBQQ__Quantity__c
                                                , fltWeight : itemb.Weight__c
                                                , fltLarge : itemb.Large__c
                                                , fltHigh : itemb.High__c
                                                , fltWidth : itemb.Width__c
                                                , fltQuoteGuide : itemb.FLETE__c
                                                , fltAditionalKG : itemb.KG_ADICIONAL__c
                                                , fltQuoteExtra : itemb.ACK__c
                                                , Id : itemb.Id
                                            };
                                }
                                else{
                                    var block = {
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
                                        , strLabel : ''
                                        , fltBase : parseFloat(fltBase)
                                    };
                                    switch (itemb.key) {
                                        case 'DS':
                                            block.strLabel = 'DÍA SIGUIENTE (ONE\'DAY)';
                                            break;
                                        case '2D':
                                            block.strLabel = 'DOS DÍAS (TWO\'DAYS)';
                                            break;
                                        case 'A12':
                                            block.strLabel = 'ANTES DE LAS 12 (MID\'DAY)';
                                            break;
                                    };
                                    block.ranges[itemb.range] = {
                                         fltFrecuency :0
                                        , fltVol : 0
                                        , fltVolWeight : 0
                                        , fltDominantWeight : 0
                                        , fltAmount : 0
                                        , fltFullFee : 0
                                        , fltTotalFull : 0
                                        , fltQuoteFee : 0
                                        , fltTotalQuote : 0
                                        , fltDisc : 0
                                        , fltQuoteFull : 0
                                        , intFrecuency : itemb.SBQQ__Quantity__c
                                        , fltWeight : itemb.Weight__c
                                        , fltLarge : itemb.Large__c
                                        , fltHigh : itemb.High__c
                                        , fltWidth : itemb.Width__c
                                        , fltQuoteGuide : itemb.FLETE__c
                                        , fltAditionalKG : itemb.KG_ADICIONAL__c
                                        , fltQuoteExtra : itemb.ACK__c
                                        , Id : itemb.Id
                                    };
                                    $scope.ODEXP.mapBlock[itemb.key].push(block);
                                }
                            }
                        });
                    });
                    j$.each($scope.ODEXP.mapBlock, function(key, listBlocks){
                        j$.each(listBlocks, function(index, block){
                            j$.each(block.ranges, function(keyRange,itemb){
                                $scope.calculateDimensionsOD(key, keyRange, index);
                            });
                        });
                    });
                    // Special Service
                    if ($scope.Wrapper.listSS){
                        j$.each($scope.Wrapper.listSS
                                , function(index, itemSS){
                                    var keyRange = '';
                                    if(notEmpty(itemSS.Destiny__c))
                                        keyRange = itemSS.Destiny__c;
                                    else
                                        keyRange =  getId(itemSS.RangoKM__c, $scope.OD.OriginalListRange);
                                    var keyService = getId(itemSS.Name, $scope.SS.listService);
                                    $scope.SS.ranges[keyRange].Service[keyService].fltAmount = itemSS.Amount__c;
                                    $scope.SS.ranges[keyRange].Service[keyService].Option.model = getModel(itemSS.Option__c, $scope.SS.ranges[keyRange].Service[keyService].Option.aviableOptions);
                                    $scope.SS.service[keyService].mainDestinies = itemSS.MainDesinations__c;
                                    $scope.SS.service[keyService].potential = itemSS.Potencial__c;
                                    $scope.SS.ranges[keyRange].Service[keyService].Id = itemSS.Id;
                                }
                        );
                    }
                }
                if($scope.Wrapper.mapTarifarioT)
                    j$.each($scope.OD.listFee
                            , function (keyFee, strFee) {
                                j$.each($scope.OD.listRange
                                        ,function (keyRange, labelRange) {
                                            var strRange = '';
                                            if(getId(labelRange, $scope.OD.OriginalListRange))
                                                strRange = labelRange;
                                            else
                                                strRange = getRange(labelRange);
                                            if(keyFee !==  'T7') {
                                                $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltAmount = $scope.Wrapper.mapTarifarioT['TARIFA ' + keyFee][strRange].Flete__c;
                                                $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltAmount = $scope.Wrapper.mapTarifarioT['TARIFA ' + keyFee][strRange].Flete__c;
                                            }
                                            else{
                                                $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltAmount = $scope.Wrapper.mapTarifarioT['TARIFA T7V'][strRange].Flete__c;
                                                $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltAmount = $scope.Wrapper.mapTarifarioT['TARIFA T7P'][strRange].Flete__c;
                                            }
                                            if(!$scope.exceptionAD(keyFee)){
                                                $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltEAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinEAD'], $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltAmount);
                                                $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltRAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinRAD'], $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltAmount);
                                                if(keyFee !==  'T7') {
                                                    $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltEAD = $scope.Wrapper.mapCS['EAZP'];
                                                    $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltRAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinEAD'], $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltAmount);
                                                }
                                            }
                                        }
                                );
                            }
                    );
                $scope.sent = false;
                if(!isArrayEmpy($scope.OD.listRange))
                    $scope.calculateEXPOD();
                callGetHierarchy($scope);
                if($scope.OD.blnCotizaT7ZP)
                    $scope.redireccionar();
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
                //$scope.sent = true;
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

            function callCreateQuoteConv($scope, objQuote, listQuoteItem, leadObj, oppObj, listSS){
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
                        , listSS
                        , function (result, event) {
                            debugger;
                            if (event.status) {
                                $scope.DML = result;
                                $scope.Wrapper.objQuote = result.objQuote;
                                var t7Fee = {'T7P':'TARIFA T7-P', 'T7V':'TARIFA T7-V'};
                                $scope.MapQuoteLineEXP = {};
                                j$.each(result.listQuoteItem
                                        , function (index, quoteItem) {
                                            if(!getModel(getId(quoteItem.Tarifa__c, $scope.OD.listFee), $scope.OD.FeeSelect.selected)
                                                    && getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) !== 'T7P' && getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) !== 'T7V'
                                                    && quoteItem.Tarifa__c.toUpperCase() !== 'SEG-DS' && quoteItem.Tarifa__c.toUpperCase() !== 'SEG-2D' && quoteItem.Tarifa__c.toUpperCase() !== 'SEG-A12'
                                            )
                                                $scope.addFee(getModel(getId(quoteItem.Tarifa__c, $scope.OD.listFee), $scope.OD.FeeSelect.available));
                                            if($scope.OD.fltSEG === 0)
                                                $scope.OD.fltSEG = quoteItem.Pack_Seg__c;
                                            if(quoteItem.Tarifa__c === 'TARIFA T7')
                                                $scope.PPT7Calc = $scope.Wrapper.objQuote.TipoCotizacion__c;
                                            if(notEmpty(quoteItem.Destiny__c)) {
                                                if(!getId(
                                                        quoteItem.Destiny__c +' ('+ quoteItem.Rango_KM__c +')'
                                                        , $scope.OD.listRange
                                                )){
                                                    $scope.insertRange(quoteItem.Destiny__c, quoteItem.Rango_KM__c);
                                                    $scope.OD.listDestiny[quoteItem.Destiny__c] = {
                                                        range: quoteItem.Rango_KM__c
                                                        , name: quoteItem.Destiny__c +' ('+ quoteItem.Rango_KM__c +')'
                                                    } ;
                                                    j$.each(
                                                            $scope.OD.listFee
                                                            , function(keyFee, fee){
                                                                $scope.OD.mapQuotes[keyFee].ranges[quoteItem.Destiny__c] = {
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
                                                                if(keyFee !== 'T7')
                                                                    $scope.ODZP.mapQuotes[keyFee].ranges[quoteItem.Destiny__c] = {
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
                                                                $scope.OD.mapRanges[quoteItem.Destiny__c] = {
                                                                    fltCost: 0
                                                                };
                                                                $scope.SS.ranges[quoteItem.Destiny__c] = {
                                                                    fltTotalByRange : 0
                                                                    , Service: []
                                                                };
                                                                j$.each($scope.SS.listService
                                                                        , function(keyService, strService){
                                                                            $scope.SS.service[keyService] = {
                                                                                mainDestinies : ''
                                                                                , potential : 0
                                                                            };
                                                                            $scope.SS.ranges[quoteItem.Destiny__c].Service[keyService] = {
                                                                                Option : {
                                                                                    model : undefined
                                                                                    , aviableOptions : [] }
                                                                                , fltAmount : 0
                                                                            };
                                                                            j$.each($scope.SS.listOption
                                                                                    , function(keyOption, strOption){
                                                                                        $scope.SS.ranges[quoteItem.Destiny__c].Service[keyService].Option.aviableOptions.push({id: keyOption, label: strOption});
                                                                                    }
                                                                            );
                                                                        }
                                                                );
                                                            }
                                                    );
                                                    $scope.OD.mapQuotes['T7'].ranges[quoteItem.Destiny__c].fltVolAVR = 0;
                                                    $scope.OD.mapQuotes['T7'].ranges[quoteItem.Destiny__c].fltWeightAVR = 0;
                                                    $scope.OD.mapQuotes['T7P'].ranges[quoteItem.Destiny__c] = {
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
                                                    $scope.OD.mapQuotes['T7V'].ranges[quoteItem.Destiny__c] = {
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
                                                    j$.each($scope.ODEXP.mapBlock, function (key, listBlock) {
                                                        j$.each(listBlock, function (i, block) {
                                                            block.ranges[quoteItem.Destiny__c] = {
                                                                intFrecuency : 0
                                                                , fltFrecuency :0
                                                                , fltWeight : 0
                                                                , fltVol : 0
                                                                , fltVolWeight : 0
                                                                , fltDominantWeight : 0
                                                                , fltLarge : 0
                                                                , fltHigh : 0
                                                                , fltWidth : 0
                                                                , fltAmount : 0
                                                                , fltFullFee : 0
                                                                , fltTotalFull : 0
                                                                , fltQuoteFee : 0
                                                                , fltQuoteGuide : 0
                                                                , fltAditionalKG : 0
                                                                , fltQuoteExtra : 0
                                                                , fltTotalQuote : 0
                                                                , fltDisc : 0
                                                            };
                                                        });
                                                    });
                                                }
                                                quoteItem.Rango_KM__c = quoteItem.Destiny__c +' ('+ quoteItem.Rango_KM__c +')';
                                            }
                                            if(quoteItem.Tarifa__c.toUpperCase() === 'SEG-DS' || quoteItem.Tarifa__c.toUpperCase() === 'SEG-2D' || quoteItem.Tarifa__c.toUpperCase() === 'SEG-A12'){
                                                var key = getId(quoteItem.Tarifa__c, $scope.ODEXP.listFeeEXP);
                                                var range = getId(quoteItem.Rango_KM__c, $scope.OD.listRange);
                                                if(!getModel(key, $scope.OD.FeeSelect.selected))
                                                    $scope.addFee(getModel(key, $scope.OD.FeeSelect.available));
                                                if(!isIn(quoteItem.GUIA__c.toString(), $scope.SetBlocks))
                                                    $scope.SetBlocks.push(quoteItem.GUIA__c.toString());
                                                quoteItem.key = key;
                                                quoteItem.range = range;
                                                if(notEmpty(getLabel(quoteItem.GUIA__c.toString(), $scope.MapQuoteLineEXP)))
                                                    $scope.MapQuoteLineEXP[quoteItem.GUIA__c.toString()].push(quoteItem);
                                                else{
                                                    $scope.MapQuoteLineEXP[quoteItem.GUIA__c.toString()] = [quoteItem];
                                                }
                                            }
                                            else if(quoteItem.ZonaPlus__c){
                                                $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].Id = quoteItem.Id;
                                                $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                                $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltDiscount = quoteItem.SBQQ__Discount__c;
                                                $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltQuoteFee = quoteItem.SBQQ__CustomerPrice__c;
                                                $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltFullFee = quoteItem.SBQQ__NetPrice__c;
                                                $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltTotalQuote = quoteItem.QuoteTotal__c;
                                                if(quoteItem.ACK__c)
                                                    $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltACK = quoteItem.ACK__c;
                                                if(quoteItem.EAD__c)
                                                    $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltEAD = quoteItem.EAD__c;
                                                if(quoteItem.RAD__c)
                                                    $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltRAD = quoteItem.RAD__c;
                                                if(quoteItem.SEG__c)
                                                    $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltAmountSeg = quoteItem.SEG__c;
                                            }
                                            else if (getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) !== 'T7P' && getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) !== 'T7V'){
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].Id = quoteItem.Id;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltDiscount = quoteItem.SBQQ__Discount__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltQuoteFee = quoteItem.SBQQ__CustomerPrice__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltFullFee = quoteItem.SBQQ__NetPrice__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltTotalQuote = quoteItem.QuoteTotal__c;
                                                if(quoteItem.ACK__c)
                                                    $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltACK = quoteItem.ACK__c;
                                                if(quoteItem.EAD__c)
                                                    $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltEAD = quoteItem.EAD__c;
                                                if(quoteItem.RAD__c)
                                                    $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltRAD = quoteItem.RAD__c;
                                                if(quoteItem.SEG__c)
                                                    $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltAmountSeg = quoteItem.SEG__c;
                                                if(quoteItem.Tarifa__c === 'TARIFA T7'){
                                                    $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltVolAVR = quoteItem.PackVolAVG__c;
                                                    $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltWeightAVR  = quoteItem.PackWeightAVG__c;
                                                }
                                            }
                                            else if (getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) === 'T7P' || getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) === 'T7V'){
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].Id = quoteItem.Id;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltDiscount = quoteItem.SBQQ__Discount__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltQuoteFee = quoteItem.SBQQ__CustomerPrice__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltFullFee = quoteItem.SBQQ__NetPrice__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltTotalQuote = quoteItem.QuoteTotal__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltACK = quoteItem.ACK__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltEAD = quoteItem.EAD__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltRAD = quoteItem.RAD__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltAmountSeg = quoteItem.SEG__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltVolAVR = quoteItem.PackVolAVG__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltWeightAVR  = quoteItem.PackWeightAVG__c;
                                            }
                                        }
                                );
                                $scope.SetBlocks.sort(function (a, b) {
                                    if (a.order > b.order) {
                                        return 1;
                                    }
                                    if (a.order < b.order) {
                                        return -1;
                                    }
                                    // a must be equal to b
                                    return 0;
                                });
                                j$.each(result.listSS
                                        , function(index, itemSS){
                                            var keyRange = '';
                                            if(notEmpty(itemSS.Destiny__c))
                                                keyRange = itemSS.Destiny__c;
                                            else
                                                keyRange =  getId(itemSS.RangoKM__c, $scope.OD.OriginalListRange);
                                            var keyService = getId(itemSS.Name, $scope.SS.listService);
                                            $scope.SS.ranges[keyRange].Service[keyService].fltAmount = itemSS.Amount__c;
                                            $scope.SS.ranges[keyRange].Service[keyService].Option.model = getModel(itemSS.Option__c, $scope.SS.ranges[keyRange].Service[keyService].Option.aviableOptions);
                                            $scope.SS.service[keyService].mainDestinies = itemSS.MainDesinations__c;
                                            $scope.SS.service[keyService].potential = itemSS.Potencial__c;
                                            $scope.SS.ranges[keyRange].Service[keyService].Id = itemSS.Id;
                                        }
                                );
                                if($scope.DML.blnSuccess)
                                    $scope.SuccessMessage = 'Se han guardado los cambios con exito.';
                                $scope.OD.blnBotonActivo = false;
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

            function callUpdateQuoteConv($scope, objQuote, listQuoteItem, leadObj, oppObj, listDeleteItems, listSS, listDELSS) {
                j$.blockUI({ message: '<h3><span class="glyphicon glyphicon-time"></span> Por favor espere... </h3>' });
                $scope.SuccessMessage = '';
                $scope.sent = true;
                Visualforce.remoting.Manager.invokeAction(
                        '{!$RemoteAction.PAQ_CotizadorNacional_CTR.updateQuoteConv}'
                        , objQuote
                        , listQuoteItem
                        , leadObj
                        , oppObj
                        , listDeleteItems
                        , listSS
                        , listDELSS
                        , function (result, event) {
                            debugger;
                            if (event.status) {
                                $scope.DML = result;
                                $scope.Wrapper.objQuote = result.objQuote;
                                var t7Fee = {'T7P':'TARIFA T7-P', 'T7V':'TARIFA T7-V'};
                                $scope.MapQuoteLineEXP = {};
                                j$.each(result.listQuoteItem
                                        , function (index, quoteItem) {
                                            if(!getModel(getId(quoteItem.Tarifa__c, $scope.OD.listFee), $scope.OD.FeeSelect.selected)
                                                    && getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) !== 'T7P' && getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) !== 'T7V'
                                                    && quoteItem.Tarifa__c.toUpperCase() !== 'SEG-DS' && quoteItem.Tarifa__c.toUpperCase() !== 'SEG-2D' && quoteItem.Tarifa__c.toUpperCase() !== 'SEG-A12'
                                            )
                                                $scope.addFee(getModel(getId(quoteItem.Tarifa__c, $scope.OD.listFee), $scope.OD.FeeSelect.available));
                                            if($scope.OD.fltSEG === 0)
                                                $scope.OD.fltSEG = quoteItem.Pack_Seg__c;
                                            if(quoteItem.Tarifa__c === 'TARIFA T7')
                                                $scope.PPT7Calc = $scope.Wrapper.objQuote.TipoCotizacion__c;
                                            if(notEmpty(quoteItem.Destiny__c)) {
                                                if(!getId(
                                                        quoteItem.Destiny__c +' ('+ quoteItem.Rango_KM__c +')'
                                                        , $scope.OD.listRange
                                                )){
                                                    $scope.insertRange(quoteItem.Destiny__c, quoteItem.Rango_KM__c);
                                                    $scope.OD.listDestiny[quoteItem.Destiny__c] = {
                                                        range: quoteItem.Rango_KM__c
                                                        , name: quoteItem.Destiny__c +' ('+ quoteItem.Rango_KM__c +')'
                                                    } ;
                                                    j$.each(
                                                            $scope.OD.listFee
                                                            , function(keyFee, fee){
                                                                $scope.OD.mapQuotes[keyFee].ranges[quoteItem.Destiny__c] = {
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
                                                                if(keyFee !== 'T7')
                                                                    $scope.ODZP.mapQuotes[keyFee].ranges[quoteItem.Destiny__c] = {
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
                                                                $scope.OD.mapRanges[quoteItem.Destiny__c] = {
                                                                    fltCost: 0
                                                                };
                                                                $scope.SS.ranges[quoteItem.Destiny__c] = {
                                                                    fltTotalByRange : 0
                                                                    , Service: []
                                                                };
                                                                j$.each($scope.SS.listService
                                                                        , function(keyService, strService){
                                                                            $scope.SS.service[keyService] = {
                                                                                mainDestinies : ''
                                                                                , potential : 0
                                                                            };
                                                                            $scope.SS.ranges[quoteItem.Destiny__c].Service[keyService] = {
                                                                                Option : {
                                                                                    model : undefined
                                                                                    , aviableOptions : [] }
                                                                                , fltAmount : 0
                                                                            };
                                                                            j$.each($scope.SS.listOption
                                                                                    , function(keyOption, strOption){
                                                                                        $scope.SS.ranges[quoteItem.Destiny__c].Service[keyService].Option.aviableOptions.push({id: keyOption, label: strOption});
                                                                                    }
                                                                            );
                                                                        }
                                                                );
                                                            }
                                                    );
                                                    $scope.OD.mapQuotes['T7'].ranges[quoteItem.Destiny__c].fltVolAVR = 0;
                                                    $scope.OD.mapQuotes['T7'].ranges[quoteItem.Destiny__c].fltWeightAVR = 0;
                                                    $scope.OD.mapQuotes['T7P'].ranges[quoteItem.Destiny__c] = {
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
                                                    $scope.OD.mapQuotes['T7V'].ranges[quoteItem.Destiny__c] = {
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
                                                    j$.each($scope.ODEXP.mapBlock, function (key, listBlock) {
                                                        j$.each(listBlock, function (i, block) {
                                                            block.ranges[quoteItem.Destiny__c] = {
                                                                intFrecuency : 0
                                                                , fltFrecuency :0
                                                                , fltWeight : 0
                                                                , fltVol : 0
                                                                , fltVolWeight : 0
                                                                , fltDominantWeight : 0
                                                                , fltLarge : 0
                                                                , fltHigh : 0
                                                                , fltWidth : 0
                                                                , fltAmount : 0
                                                                , fltFullFee : 0
                                                                , fltTotalFull : 0
                                                                , fltQuoteFee : 0
                                                                , fltQuoteGuide : 0
                                                                , fltAditionalKG : 0
                                                                , fltQuoteExtra : 0
                                                                , fltTotalQuote : 0
                                                                , fltDisc : 0
                                                            };
                                                        });
                                                    });
                                                }
                                                quoteItem.Rango_KM__c = quoteItem.Destiny__c +' ('+ quoteItem.Rango_KM__c +')';
                                            }
                                            if(quoteItem.Tarifa__c.toUpperCase() === 'SEG-DS' || quoteItem.Tarifa__c.toUpperCase() === 'SEG-2D' || quoteItem.Tarifa__c.toUpperCase() === 'SEG-A12'){
                                                var key = getId(quoteItem.Tarifa__c, $scope.ODEXP.listFeeEXP);
                                                var range = getId(quoteItem.Rango_KM__c, $scope.OD.listRange);
                                                if(!getModel(key, $scope.OD.FeeSelect.selected))
                                                    $scope.addFee(getModel(key, $scope.OD.FeeSelect.available));
                                                if(!isIn(quoteItem.GUIA__c.toString(), $scope.SetBlocks))
                                                    $scope.SetBlocks.push(quoteItem.GUIA__c.toString());
                                                quoteItem.key = key;
                                                quoteItem.range = range;
                                                if(notEmpty(getLabel(quoteItem.GUIA__c.toString(), $scope.MapQuoteLineEXP)))
                                                    $scope.MapQuoteLineEXP[quoteItem.GUIA__c.toString()].push(quoteItem);
                                                else{
                                                    $scope.MapQuoteLineEXP[quoteItem.GUIA__c.toString()] = [quoteItem];
                                                }
                                            }
                                            else if(quoteItem.ZonaPlus__c){
                                                $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].Id = quoteItem.Id;
                                                $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                                $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltDiscount = quoteItem.SBQQ__Discount__c;
                                                $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltQuoteFee = quoteItem.SBQQ__CustomerPrice__c;
                                                $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltFullFee = quoteItem.SBQQ__NetPrice__c;
                                                $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltTotalQuote = quoteItem.QuoteTotal__c;
                                                if(quoteItem.ACK__c)
                                                    $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltACK = quoteItem.ACK__c;
                                                if(quoteItem.EAD__c)
                                                    $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltEAD = quoteItem.EAD__c;
                                                if(quoteItem.RAD__c)
                                                    $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltRAD = quoteItem.RAD__c;
                                                if(quoteItem.SEG__c)
                                                    $scope.ODZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltAmountSeg = quoteItem.SEG__c;
                                            }
                                            else if (getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) !== 'T7P' && getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) !== 'T7V'){
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].Id = quoteItem.Id;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltDiscount = quoteItem.SBQQ__Discount__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltQuoteFee = quoteItem.SBQQ__CustomerPrice__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltFullFee = quoteItem.SBQQ__NetPrice__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltTotalQuote = quoteItem.QuoteTotal__c;
                                                if(quoteItem.ACK__c)
                                                    $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltACK = quoteItem.ACK__c;
                                                if(quoteItem.EAD__c)
                                                    $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltEAD = quoteItem.EAD__c;
                                                if(quoteItem.RAD__c)
                                                    $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltRAD = quoteItem.RAD__c;
                                                if(quoteItem.SEG__c)
                                                    $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltAmountSeg = quoteItem.SEG__c;
                                                if(quoteItem.Tarifa__c === 'TARIFA T7'){
                                                    $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltVolAVR = quoteItem.PackVolAVG__c;
                                                    $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c, $scope.OD.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltWeightAVR  = quoteItem.PackWeightAVG__c;
                                                }
                                            }
                                            else if (getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) === 'T7P' || getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee) === 'T7V'){
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].Id = quoteItem.Id;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltDiscount = quoteItem.SBQQ__Discount__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltQuoteFee = quoteItem.SBQQ__CustomerPrice__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltFullFee = quoteItem.SBQQ__NetPrice__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltTotalQuote = quoteItem.QuoteTotal__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltACK = quoteItem.ACK__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltEAD = quoteItem.EAD__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltRAD = quoteItem.RAD__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltAmountSeg = quoteItem.SEG__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltVolAVR = quoteItem.PackVolAVG__c;
                                                $scope.OD.mapQuotes[getId(quoteItem.Tarifa__c.toUpperCase(), t7Fee)].ranges[getId(quoteItem.Rango_KM__c, $scope.OD.listRange)].fltWeightAVR  = quoteItem.PackWeightAVG__c;
                                            }
                                        }
                                );
                                $scope.SetBlocks.sort(function (a, b) {
                                    if (a.order > b.order) {
                                        return 1;
                                    }
                                    if (a.order < b.order) {
                                        return -1;
                                    }
                                    // a must be equal to b
                                    return 0;
                                });
                                j$.each(result.listSS
                                        , function(index, itemSS){
                                            var keyRange = '';
                                            if(notEmpty(itemSS.Destiny__c))
                                                keyRange = itemSS.Destiny__c;
                                            else
                                                keyRange =  getId(itemSS.RangoKM__c, $scope.OD.OriginalListRange);
                                            var keyService = getId(itemSS.Name, $scope.SS.listService);
                                            $scope.SS.ranges[keyRange].Service[keyService].fltAmount = itemSS.Amount__c;
                                            $scope.SS.ranges[keyRange].Service[keyService].Option.model = getModel(itemSS.Option__c, $scope.SS.ranges[keyRange].Service[keyService].Option.aviableOptions);
                                            $scope.SS.service[keyService].mainDestinies = itemSS.MainDesinations__c;
                                            $scope.SS.service[keyService].potential = itemSS.Potencial__c;
                                            $scope.SS.ranges[keyRange].Service[keyService].Id = itemSS.Id;
                                        }
                                );
                                if($scope.DML.blnSuccess)
                                    $scope.SuccessMessage = 'Se han guardado los cambios con exito';
                                $scope.OD.blnBotonActivo = false;
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

            function callSent($scope, strIdQuote, strNameAP, strIdGerente) {
                j$.blockUI({ message: '<h3><span class="glyphicon glyphicon-time"></span> Por favor espere... </h3>' });
                $scope.SuccessMessage = '';
                $scope.sent = true;
                Visualforce.remoting.Manager.invokeAction(
                        '{!$RemoteAction.PAQ_CotizadorNacional_CTR.sumbitAPP}'
                        , strIdQuote
                        , strNameAP
                        , strIdGerente
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

            function callCheckDestiny($scope) {
                j$.blockUI({ message: '<h3><span class="glyphicon glyphicon-time"></span> Por favor espere... </h3>' });
                $scope.SuccessMessage = '';
                $scope.sent = true;
                $scope.DestinyErrorMessage = '';
                $scope.DestinySuccessMessage = '';
                Visualforce.remoting.Manager.invokeAction(
                        '{!$RemoteAction.PAQ_CotizadorNacional_CTR.checkDestiny}'
                        , $scope.OD.strOrigin
                        , $scope.OD.strDestiny
                        , function (result, event) {
                            //debugger;
                            if (event.status) {
                                $scope.DML = result;
                                if(result.blnSuccess){
                                    var strDestiny = $scope.OD.strDestiny;
                                    $scope.DestinySuccessMessage = 'Se ha agregado el destino!';
                                    $scope.OD.listDestiny[strDestiny] = {
                                        range: result.strDestinyKM
                                        , name: strDestiny +' ('+ result.strDestinyKM +')'
                                    } ;
                                    $scope.insertRange(strDestiny, result.strDestinyKM);
                                    j$.each(
                                            $scope.OD.listFee
                                            , function(keyFee, fee){
                                                $scope.OD.mapQuotes[keyFee].ranges[strDestiny] = {
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
                                                if(keyFee !== 'T7')
                                                    $scope.ODZP.mapQuotes[keyFee].ranges[strDestiny] = {
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
                                                $scope.OD.mapRanges[strDestiny] = {
                                                    fltCost: 0
                                                };
                                                $scope.SS.ranges[strDestiny] = {
                                                    fltTotalByRange : 0
                                                    , Service: []
                                                };
                                                j$.each($scope.SS.listService
                                                        , function(keyService, strService){
                                                            $scope.SS.service[keyService] = {
                                                                mainDestinies : ''
                                                                , potential : 0
                                                            };
                                                            $scope.SS.ranges[strDestiny].Service[keyService] = {
                                                                Option : {
                                                                    model : undefined
                                                                    , aviableOptions : [] }
                                                                , fltAmount : 0
                                                            };
                                                            j$.each($scope.SS.listOption
                                                                    , function(keyOption, strOption){
                                                                        $scope.SS.ranges[strDestiny].Service[keyService].Option.aviableOptions.push({id: keyOption, label: strOption});
                                                                    }
                                                            );
                                                        }
                                                );
                                            }
                                    );
                                    $scope.OD.mapQuotes['T7'].ranges[strDestiny].fltVolAVR = 0;
                                    $scope.OD.mapQuotes['T7'].ranges[strDestiny].fltWeightAVR = 0;
                                    $scope.OD.mapQuotes['T7P'].ranges[strDestiny] = {
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
                                    $scope.OD.mapQuotes['T7V'].ranges[strDestiny] = {
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
                                    $scope.OD.strOrigen = $scope.OD.strOrigin;
                                    $scope.OD.mapTender[strDestiny] = {
                                        strName : strDestiny
                                        , keyName : strDestiny
                                        , fltLarge : 0//Tender.Largo__c
                                        , fltWidth : 0//Tender.Peso__c
                                        , fltHigh : 0//Tender.Alto__c
                                        , fltWeight : 0//Tender.Peso__c
                                        , fltVol : 0//Tender.Alto__c * Tender.Peso__c * Tender.Largo__c
                                        , fltCost : 0//Tender.Costo__c
                                        , fltExc : 0//Tender.Costo__c
                                        , blnDestino : true
                                        , id : ''
                                    };
                                    LlenaMapaTenders($scope, true);
                                    $scope.OD.mapQuotesT7ZP.Tender[strDestiny] = {
                                        fltSeg : 0
                                        , strOrigen : $scope.OD.strOrigin
                                        , strRange : result.strDestinyKM
                                        , strTenderDestino : ''
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
                                        , fltVolAVR : 0
                                        , fltPesoVol : 0
                                        , fltWeightAVR : 0
                                        , fltWeight : 0
                                        , fltWeightAmount : 0
                                        , fltVolAmount : 0
                                        , fltLargo : 0

                                        , fltPeso : 0
                                        , fltAlto : 0
                                        , fltAncho : 0
                                        , fltExc : 0
                                        , fltPesoDom : 0
                                        , flttarifaProp : 0
                                    };
                                    $scope.OD.mapPropuesta['PROP'].ranges[strDestiny] = {
                                        fltCost : 0
                                        , fltTotalPropuesta : 0
                                        , fltTotalTarifaLlena : 0
                                        , fltDescuento : 0
                                        , fltQuoteFee : 0
                                        , strRango : result.strDestinyKM
                                        , fltACK : 0
                                        , fltTarima : 0
                                        , fltPesoVol : 0
                                        , fltPesoDom : 0
                                    };
                                    $scope.OD.listRangePrecio['T7P'].ranges[strDestiny] = {
                                        fltCost : 0
                                    };
                                    $scope.OD.listRangePrecio['T7V'].ranges[strDestiny] = {
                                        fltCost : 0
                                    };
                                    j$.each($scope.OD.listFee
                                            , function (keyFee, strFee) {
                                                var keyRange = strDestiny;
                                                var strRange = result.strDestinyKM;
                                                if(keyFee !==  'T7') {
                                                    $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltAmount = $scope.Wrapper.mapTarifarioT['TARIFA ' + keyFee][strRange].Flete__c;
                                                    $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltAmount = $scope.Wrapper.mapTarifarioT['TARIFA ' + keyFee][strRange].Flete__c;
                                                }
                                                else{
                                                    $scope.OD.mapQuotes['T7V'].ranges[keyRange].fltAmount = $scope.Wrapper.mapTarifarioT['TARIFA T7V'][strRange].Flete__c;
                                                    $scope.OD.mapQuotes['T7P'].ranges[keyRange].fltAmount = $scope.Wrapper.mapTarifarioT['TARIFA T7P'][strRange].Flete__c;
                                                }
                                                if(!$scope.exceptionAD(keyFee)){
                                                    $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltEAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinEAD'], $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltAmount);
                                                    $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltRAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinRAD'], $scope.OD.mapQuotes[keyFee].ranges[keyRange].fltAmount);
                                                    if(keyFee !==  'T7') {
                                                        $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltEAD = $scope.Wrapper.mapCS['EAZP'];
                                                        $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltRAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinEAD'], $scope.ODZP.mapQuotes[keyFee].ranges[keyRange].fltAmount);
                                                    }
                                                }
                                            }
                                    );
                                    j$.each( $scope.OD.listFeeEXP
                                            , function(key, value){
                                                $scope.replicate('intFrecc', null, null, value);
                                                $scope.replicate('fltQuote', null, null, value);
                                                $scope.replicate('fltWeight', null, null, value);
                                                $scope.replicate('fltLarge', null, null, value);
                                                $scope.replicate('fltWidth', null, null, value);
                                                $scope.replicate('fltHigh', null, null, value);
                                            });
                                    j$.each($scope.ODEXP.mapBlock, function (key, listBlock) {
                                        j$.each(listBlock, function (i, block) {
                                            block.ranges[strDestiny] = {
                                                intFrecuency : 0
                                                , fltFrecuency :0
                                                , fltWeight : 0
                                                , fltVol : 0
                                                , fltVolWeight : 0
                                                , fltDominantWeight : 0
                                                , fltLarge : 0
                                                , fltHigh : 0
                                                , fltWidth : 0
                                                , fltAmount : 0
                                                , fltFullFee : 0
                                                , fltTotalFull : 0
                                                , fltQuoteFee : 0
                                                , fltQuoteGuide : 0
                                                , fltAditionalKG : 0
                                                , fltQuoteExtra : 0
                                                , fltTotalQuote : 0
                                                , fltDisc : 0
                                            };
                                        });
                                    });
                                    $scope.calculateEXPOD();
                                }
                                else
                                    $scope.DestinyErrorMessage = 'Destino no válido!';

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

            function getLabel(strId, arrayOptions) {
                var model;
                j$.each(arrayOptions
                        ,function (key, value) {
                            if(key === strId)
                                model = value;
                        }
                );
                return model
            }

            function getRange(strRange){ //VER (0-400)
                return strRange.substring(5, strRange.length-1);
            }

            function isArrayEmpy(obj){
                for(var key in obj) {
                    if(obj.hasOwnProperty(key))
                        return false;
                }
                return true;
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
            function LlenaMapaTenders($scope, blnNuevoTender){
                if(!$scope.OnlineDocByDestiny){
                    j$.each($scope.Wrapper.mapTender, function(Name, Tender){
                        if(Name !== 'TENDER')
                            $scope.OD.mapTender[Name.replace('70', '')] = {
                                strName : Name.replace('70', '')
                                , keyName : Name
                                , fltLarge : Tender.Largo__c
                                , fltWidth : Tender.Peso__c
                                , fltHigh : Tender.Alto__c
                                , fltWeight : Tender.Peso__c
                                , fltVol : Tender.Alto__c * Tender.Peso__c * Tender.Largo__c
                                , fltCost : Tender.Costo__c
                                , fltExc : Tender.Costo__c
                                , id : ''
                                , blnDestino : false
                            };
                        j$.each($scope.OD.listDestiny, function(keyDest, strDest){
                            if(Name.replace('70', '') === keyDest)
                                $scope.OD.mapTender[Name.replace('70', '')].blnDestino = true;
                        })
                        
                    });
                    if(blnNuevoTender)
                        j$.each($scope.OD.mapTender, function(keyName, strName){
                            $scope.OD.mapQuotesT7ZP.Tender[keyName] = {
                                fltSeg : 0
                                , strOrigen : ''
                                , strRange : ''
                                , strTenderDestino : ''
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
                                , fltVolAVR : 0
                                , fltPesoVol : 0
                                , fltWeightAVR : 0
                                , fltWeight : 0
                                , fltWeightAmount : 0
                                , fltVolAmount : 0
                                , fltLargo : 0

                                , fltPeso : 0
                                , fltAlto : 0
                                , fltAncho : 0
                                , fltExc : 0
                                , fltPesoDom : 0
                                , flttarifaProp : 0
                            };
                        });
                } else {
                    j$.each($scope.Wrapper.mapTender, function(Name, Tender){
                        j$.each($scope.OD.mapTender, function(strTender, map){
                            if(Name === strTender + '70'){
                                $scope.OD.mapTender[strTender].strName      = Name.replace('70', '');
                                $scope.OD.mapTender[strTender].keyName      = Name;
                                $scope.OD.mapTender[strTender].fltLarge     = Tender.Largo__c;
                                $scope.OD.mapTender[strTender].fltWidth     = Tender.Peso__c;
                                $scope.OD.mapTender[strTender].fltHigh      = Tender.Alto__c;
                                $scope.OD.mapTender[strTender].fltWeight    = Tender.Peso__c;
                                $scope.OD.mapTender[strTender].fltVol       = Tender.Alto__c * Tender.Peso__c * Tender.Largo__c;
                                $scope.OD.mapTender[strTender].fltCost      = Tender.Costo__c;
                                $scope.OD.mapTender[strTender].fltExc       = Tender.Costo__c;
                                $scope.OD.mapTender[strTender].id           = ''
                                $scope.OD.mapTender[strTender].blnDestino   = true;
                            }
                        });
                    });
                }
            }
            function ObtieneRangoKMT7ZP($scope, strOrigen, strTenderDestino){
                j$.blockUI({ message: '<h3><span class="glyphicon glyphicon-time"></span> Por favor espere... </h3>' });
                $scope.SuccessMessage = '';
                $scope.sent = true;
                $scope.DestinyErrorMessage = '';
                $scope.DestinySuccessMessage = '';
                Visualforce.remoting.Manager.invokeAction(
                        '{!$RemoteAction.PAQ_CotizadorNacional_CTR.checkDestiny}'
                        , strOrigen
                        , strTenderDestino
                        , function (result, event) {
                            if (event.status) {
                                $scope.DML = result;  
                                if(result.blnSuccess){
                                    var strDestiny = strTenderDestino;
                                    $scope.DestinySuccessMessage = 'Se ha agregado el destino!';
                                    $scope.OD.mapQuotesT7ZP.Tender[strTenderDestino].strRange = result.strDestinyKM;
                                    //return result.strDestinyKM;
                                } else $scope.OD.mapQuotesT7ZP.Tender[strTenderDestino].strRange = '0';
                            } else {
                                $scope.$apply();
                                j$.unblockUI();
                            }
                            $scope.$apply();
                            j$.unblockUI();
                        }
                        ,{escape: false, timeout: 120000}
                );
            }
            function EliminarPartidasAnteriores($scope, QuoteId, objQuote, listQuoteItem, leadObj, oppObj, listDeleteItems, listSS, listDELSS){
                j$.blockUI({ message: '<h3><span class="glyphicon glyphicon-time"></span> Por favor espere... </h3>' });
                $scope.sent = true;
                $scope.SuccessMessage = '';
                Visualforce.remoting.Manager.invokeAction(
                    '{!$RemoteAction.PAQ_CotizadorNacional_CTR.EliminaPartidasAnteriores}'
                    , QuoteId
                    , listQuoteItem
                    , objQuote
                    , function (result, event) {
                        if (event.status){
                            //if($scope.DML.blnSuccess)
                            $scope.DML.blnSuccess = true;
                            $scope.DML.listErrors = [];
                            $scope.OD.blnBotonActivo = false;
                            $scope.SuccessMessage = 'Se han guardado los cambios con exito.';
                            $scope.$apply();
                            j$.unblockUI();
                        } else {
                            $scope.DML.listErrors.push(logErrorMessage(event.message.split(',')));
                            $scope.$apply();
                            j$.unblockUI();
                        }
                    }//,{escape: false, timeout: 120000}
                );
            }
        })();
    </script>
</apex:component>
