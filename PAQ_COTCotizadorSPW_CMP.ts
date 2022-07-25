<!--
  @description       : 
  @author            : ChangeMeIn@UserSettingsUnder.SFDoc
  @group             : 
  @last modified on  : 10-19-2021
  @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
-->
<apex:component controller="PAQ_CotizadorNacional_CTR">
    <div ng-controller="SWPController as SWP">
        <div class="row" >
            <div class="col-md-12 col-sm-12">
                    <div class="row" ng-show="Step1">
                        <div class="col-md-8 col-sm-8">
                            <!--STD Paquetexpress-->
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <a data-toggle="collapse" href="#CotConv"><h3 class="panel-title">FRECUENCIA DE ENVÍOS - SERVICIO ESTÁNDAR TERRESTRE (COBERTURA PAQUETEXPRESS)</h3></a>
                                </div>
                                <div id="CotConv" class="panel-collapse collapse in">
                                    <div class="panel-body" style="overflow: scroll;">
                                        <table class="table table-striped">
                                            <thead class="thead-light">
                                            <tr>
                                                <th>Rango KM</th>
                                                <th> TS</th>
                                                <th> T0</th>
                                                <th> T1</th>
                                                <th> T2</th>
                                                <th> T3</th>
                                                <th> T4</th>
                                                <th> T5</th>
                                                <th> T6</th>
                                                <th> T7</th>
                                                <th> TOTAL PAQUETES</th>
                                                <th> FRECUENCIA POR RANGOS KM</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr ng-repeat="(keyRange, strRange) in Convenio.listRange">
                                                <td ng-bind="strRange"></td>
                                                <td class="center" contenteditable="true" ng-repeat="(strFeeKey, quoteByFee) in Convenio.mapQuotes" ng-bind="quoteByFee.ranges[keyRange].intFrecuency | number:0" ng-blur="setValue('intFrecuency', keyRange, $event, strFeeKey)"></td>
                                                <td class=" center"  ng-bind="Convenio.mapTotal[keyRange].intRanTotal | number:0"></td>
                                                <td class=" center thead-light" contenteditable="true" ng-bind="Convenio.mapTotal[keyRange].fltRanTotalFrec | percentage:2" ng-blur="setValue('FreqByRange', keyRange, $event)"></td>
                                            </tr>
                                            <tr>
                                                <td> Total </td>
                                                <td class="center" ng-repeat="(strFeeKey, quoteByFee) in Convenio.mapQuotes" ng-bind="quoteByFee.intFeeTotalQ | number:0"></td>
                                                <td class="center thead-light" contenteditable="true" ng-bind="Convenio.intTotalQ | number:0" ng-blur="setValue('TotalQ', null, $event)" />
                                                <td/>
                                            </tr>
                                            <tr>
                                                <td> Frecuencia por tarifa </td>
                                                <td class="center thead-light" contenteditable="true" ng-repeat="(strFeeKey, quoteByFee) in Convenio.mapQuotes" ng-bind="quoteByFee.fltFeeTotalFrec | percentage:2" ng-blur="setValue('FeeTotalFrec', strFeeKey, $event)"></td>
                                                <td/>
                                                <td/>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <!--STD Zona plus-->
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <a data-toggle="collapse" href="#CotConvZP"><h3 class="panel-title">FRECUENCIA DE ENVÍOS - SERVICIO ESTÁNDAR TERRESTRE (COBERTURA ZONA PLUS)</h3></a>
                                </div>
                                <div id="CotConvZP" class="panel-collapse collapse in">
                                    <div class="panel-body" style="overflow: scroll;">
                                        <table class="table table-striped">
                                            <thead class="thead-light">
                                            <tr>
                                                <th>Rango KM</th>
                                                <th> TS</th>
                                                <th> T0</th>
                                                <th> T1</th>
                                                <th> T2</th>
                                                <th> T3</th>
                                                <th> T4</th>
                                                <th> T5</th>
                                                <th> T6</th>
                                                <th> T7</th>
                                                <th> TOTAL PAQUETES</th>
                                                <th> FRECUENCIA POR RANGOS KM</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr ng-repeat="(keyRange, strRange) in Convenio.listRange">
                                                <td ng-bind="strRange"></td>
                                                <td class="center" contenteditable="true" ng-repeat="(strFeeKey, quoteByFee) in ConvenioZP.mapQuotes" ng-bind="quoteByFee.ranges[keyRange].intFrecuency | number:0" ng-blur="setValue('intFrecuencyZP', keyRange, $event, strFeeKey)" ng-show=" strFeeKey !== 'T7'"></td>
                                                <td class="center" > 0 </td>
                                                <td class=" center"  ng-bind="ConvenioZP.mapTotal[keyRange].intRanTotal | number:0"></td>
                                                <td class=" center thead-light" contenteditable="true" ng-bind="ConvenioZP.mapTotal[keyRange].fltRanTotalFrec | percentage:2" ng-blur="setValue('FreqByRangeZP', keyRange, $event)" ></td>
                                            </tr>
                                            <tr>
                                                <td> Total </td>
                                                <td class="center" ng-repeat="(strFeeKey, quoteByFee) in ConvenioZP.mapQuotes" ng-bind="quoteByFee.intFeeTotalQ | number:0"></td>
                                                <td class="center thead-light" contenteditable="true" ng-bind="ConvenioZP.intTotalQ | number:0" ng-blur="setValue('TotalQZP', null, $event)" />
                                                <td/>
                                            </tr>
                                            <tr>
                                                <td> Frecuencia por tarifa </td>
                                                <td class="center thead-light" contenteditable="true" ng-repeat="(strFeeKey, quoteByFee) in ConvenioZP.mapQuotes" ng-bind="quoteByFee.fltFeeTotalFrec | percentage:2" ng-blur="setValue('FeeTotalFrecZP', strFeeKey, $event)" ng-show=" strFeeKey !== 'T7'"></td>
                                                <td>0%</td>
                                                <td/>
                                                <td/>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <!--SEG DS-->
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <a data-toggle="collapse" href="#CotConvDS"><h3 class="panel-title">FRECUENCIA DE ENVÍOS - DÍA SIGUIENTE (ONE'DAY)</h3></a>
                                </div>
                                <div id="CotConvDS" class="panel-collapse collapse in">
                                    <div class="panel-body" style="overflow: scroll;">
                                        <table class="table table-striped">
                                            <thead class="thead-light">
                                            <tr>
                                                <th>Rango de KM</th>
                                                <th>TOTAL PAQUETES</th>
                                                <th>FRECUENCIA POR RANGOS KM</th>
                                                <th>Peso volumétrico</th>
                                                <th>Peso predominante</th>
                                                <th>Peso báscula</th>
                                                <th>Largo (cm)</th>
                                                <th>Ancho (cm)</th>
                                                <th>Alto (cm)</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>Replicar en todos </td>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td class="center"><input type="checkbox" class="custom-control-input"  ng-model="ConvenioDS.blnSameWeight" ng-click="replicate('fltWeight', 'DS')" /></td>
                                                    <td class="center"><input type="checkbox" class="custom-control-input"  ng-model="ConvenioDS.blnSameLarge" ng-click="replicate('fltLarge', 'DS')" /></td>
                                                    <td class="center"><input type="checkbox" class="custom-control-input"  ng-model="ConvenioDS.blnSameWidth" ng-click="replicate('fltWidth', 'DS')" /></td>
                                                    <td class="center"><input type="checkbox" class="custom-control-input"  ng-model="ConvenioDS.blnSameHigh" ng-click="replicate('fltHigh', 'DS')" /></td>
                                                </tr>
                                                <tr ng-repeat="(keyRange, strRange) in Convenio.listRange">
                                                    <td ng-bind="strRange"></td>
                                                    <td class="center thead-light" contenteditable="true" ng-bind="ConvenioDS.ranges[keyRange].intFrecuency | number:0" ng-blur="setValue('intFrecc', keyRange, $event, null, 'DS')"></td>
                                                    <td class="center thead-light" contenteditable="true" ng-bind="ConvenioDS.ranges[keyRange].fltFrecuency | percentage:2" ng-blur="setValue('fltFrecc', keyRange, $event, null, 'DS')"></td>
                                                    <td class="center" ng-bind="ConvenioDS.ranges[keyRange].fltVolWeight | number:3" ></td>
                                                    <td class="center" ng-bind="ConvenioDS.ranges[keyRange].fltDominantWeight | number:3" ></td>
                                                    <td class="center thead-light" contenteditable="true" ng-bind="ConvenioDS.ranges[keyRange].fltWeight | number:2" ng-blur="setValue('fltWeight', keyRange, $event, null, 'DS')"></td>
                                                    <td class="center thead-light" contenteditable="true" ng-bind="ConvenioDS.ranges[keyRange].fltLarge | number:2" ng-blur="setValue('fltLarge', keyRange, $event, null, 'DS')"></td>
                                                    <td class="center thead-light" contenteditable="true" ng-bind="ConvenioDS.ranges[keyRange].fltWidth | number:2" ng-blur="setValue('fltWidth', keyRange, $event, null, 'DS')"></td>
                                                    <td class="center thead-light" contenteditable="true" ng-bind="ConvenioDS.ranges[keyRange].fltHigh | number:2" ng-blur="setValue('fltHigh', keyRange, $event, null, 'DS')"></td>
                                                </tr>
                                                <tr>
                                                    <td>Total </td>
                                                    <td class="center thead-light" contenteditable="true" ng-bind="ConvenioDS.intTotalQ | number:0" ng-blur="setValue('intTotalQ', null, $event, null, 'DS')"></td>
                                                    <td class="center" ng-bind="ConvenioDS.fltTotalFrec | percentage:2"></td>
                                                    <td/>
                                                    <td/>
                                                    <td/>
                                                    <td/>
                                                    <td/>
                                                </tr>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <!--SEG 2D-->
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <a data-toggle="collapse" href="#CotConv2D"><h3 class="panel-title">FRECUENCIA DE ENVÍOS - DOS DÍAS (2'DAYS)</h3></a>
                                </div>
                                <div id="CotConv2D" class="panel-collapse collapse in">
                                    <div class="panel-body" style="overflow: scroll;">
                                        <table class="table table-striped">
                                            <thead class="thead-light">
                                            <tr>
                                                <th>Rango de KM</th>
                                                <th>TOTAL PAQUETES</th>
                                                <th>FRECUENCIA POR RANGOS KM</th>
                                                <th>Peso volumétrico</th>
                                                <th>Peso predominante</th>
                                                <th>Peso báscula</th>
                                                <th>Largo (cm)</th>
                                                <th>Ancho (cm)</th>
                                                <th>Alto (cm)</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                <td>Replicar en todos </td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td class="center"><input type="checkbox" class="custom-control-input"  ng-model="Convenio2D.blnSameWeight" ng-click="replicate('fltWeight', '2D')" /></td>
                                                <td class="center"><input type="checkbox" class="custom-control-input"  ng-model="Convenio2D.blnSameLarge" ng-click="replicate('fltLarge', '2D')" /></td>
                                                <td class="center"><input type="checkbox" class="custom-control-input"  ng-model="Convenio2D.blnSameWidth" ng-click="replicate('fltWidth', '2D')" /></td>
                                                <td class="center"><input type="checkbox" class="custom-control-input"  ng-model="Convenio2D.blnSameHigh" ng-click="replicate('fltHigh', '2D')" /></td>
                                            </tr>
                                            <tr ng-repeat="(keyRange, strRange) in Convenio.listRange">
                                                <td ng-bind="strRange"></td>
                                                <td class="center thead-light" contenteditable="true" ng-bind="Convenio2D.ranges[keyRange].intFrecuency | number:0" ng-blur="setValue('intFrecc', keyRange, $event, null, '2D')"></td>
                                                <td class="center thead-light" contenteditable="true" ng-bind="Convenio2D.ranges[keyRange].fltFrecuency | percentage:2" ng-blur="setValue('fltFrecc', keyRange, $event, null, '2D')"></td>
                                                <td class="center" ng-bind="Convenio2D.ranges[keyRange].fltVolWeight | number:3" ></td>
                                                <td class="center" ng-bind="Convenio2D.ranges[keyRange].fltDominantWeight | number:3" ></td>
                                                <td class="center thead-light" contenteditable="true" ng-bind="Convenio2D.ranges[keyRange].fltWeight | number:2" ng-blur="setValue('fltWeight', keyRange, $event, null, '2D')"></td>
                                                <td class="center thead-light" contenteditable="true" ng-bind="Convenio2D.ranges[keyRange].fltLarge | number:2" ng-blur="setValue('fltLarge', keyRange, $event, null, '2D')"></td>
                                                <td class="center thead-light" contenteditable="true" ng-bind="Convenio2D.ranges[keyRange].fltWidth | number:2" ng-blur="setValue('fltWidth', keyRange, $event, null, '2D')"></td>
                                                <td class="center thead-light" contenteditable="true" ng-bind="Convenio2D.ranges[keyRange].fltHigh | number:2" ng-blur="setValue('fltHigh', keyRange, $event, null, '2D')"></td>
                                            </tr>
                                            <tr>
                                                <td>Total </td>
                                                <td class="center thead-light" contenteditable="true" ng-bind="Convenio2D.intTotalQ | number:0" ng-blur="setValue('intTotalQ', null, $event, null, '2D')"></td>
                                                <td class="center" ng-bind="Convenio2D.fltTotalFrec | percentage:2"></td>
                                                <td/>
                                                <td/>
                                                <td/>
                                                <td/>
                                                <td/>
                                            </tr>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <!--SEG A12-->
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <a data-toggle="collapse" href="#CotConvA12"><h3 class="panel-title">FRECUENCIA DE ENVÍOS - ANTES DE LAS 12 (MID'DAY)</h3></a>
                                </div>
                                <div id="CotConvA12" class="panel-collapse collapse in">
                                    <div class="panel-body" style="overflow: scroll;">
                                        <table class="table table-striped">
                                            <thead class="thead-light">
                                            <tr>
                                                <th>Rango de KM</th>
                                                <th>TOTAL PAQUETES</th>
                                                <th>FRECUENCIA POR RANGOS KM</th>
                                                <th>Peso volumétrico</th>
                                                <th>Peso predominante</th>
                                                <th>Peso báscula</th>
                                                <th>Largo (cm)</th>
                                                <th>Ancho (cm)</th>
                                                <th>Alto (cm)</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                <td>Replicar en todos </td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td class="center"><input type="checkbox" class="custom-control-input"  ng-model="ConvenioA12.blnSameWeight" ng-click="replicate('fltWeight', 'A12')" /></td>
                                                <td class="center"><input type="checkbox" class="custom-control-input"  ng-model="ConvenioA12.blnSameLarge" ng-click="replicate('fltLarge', 'A12')" /></td>
                                                <td class="center"><input type="checkbox" class="custom-control-input"  ng-model="ConvenioA12.blnSameWidth" ng-click="replicate('fltWidth', 'A12')" /></td>
                                                <td class="center"><input type="checkbox" class="custom-control-input"  ng-model="ConvenioA12.blnSameHigh" ng-click="replicate('fltHigh', 'A12')" /></td>
                                            </tr>
                                            <tr ng-repeat="(keyRange, strRange) in Convenio.listRange">
                                                <td ng-bind="strRange"></td>
                                                <td class="center thead-light" contenteditable="true" ng-bind="ConvenioA12.ranges[keyRange].intFrecuency | number:0" ng-blur="setValue('intFrecc', keyRange, $event, null, 'A12')"></td>
                                                <td class="center thead-light" contenteditable="true" ng-bind="ConvenioA12.ranges[keyRange].fltFrecuency | percentage:2" ng-blur="setValue('fltFrecc', keyRange, $event, null, 'A12')"></td>
                                                <td class="center" ng-bind="ConvenioA12.ranges[keyRange].fltVolWeight | number:3" ></td>
                                                <td class="center" ng-bind="ConvenioA12.ranges[keyRange].fltDominantWeight | number:3" ></td>
                                                <td class="center thead-light" contenteditable="true" ng-bind="ConvenioA12.ranges[keyRange].fltWeight | number:2" ng-blur="setValue('fltWeight', keyRange, $event, null, 'A12')"></td>
                                                <td class="center thead-light" contenteditable="true" ng-bind="ConvenioA12.ranges[keyRange].fltLarge | number:2" ng-blur="setValue('fltLarge', keyRange, $event, null, 'A12')"></td>
                                                <td class="center thead-light" contenteditable="true" ng-bind="ConvenioA12.ranges[keyRange].fltWidth | number:2" ng-blur="setValue('fltWidth', keyRange, $event, null, 'A12')"></td>
                                                <td class="center thead-light" contenteditable="true" ng-bind="ConvenioA12.ranges[keyRange].fltHigh | number:2" ng-blur="setValue('fltHigh', keyRange, $event, null, 'A12')"></td>
                                            </tr>
                                            <tr>
                                                <td>Total </td>
                                                <td class="center thead-light" contenteditable="true" ng-bind="ConvenioA12.intTotalQ | number:0" ng-blur="setValue('intTotalQ', null, $event, null, 'A12')"></td>
                                                <td class="center" ng-bind="ConvenioA12.fltTotalFrec | percentage:2"></td>
                                                <td/>
                                                <td/>
                                                <td/>
                                                <td/>
                                                <td/>
                                            </tr>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 col-sm-4">
                            <!--T7 Weigth && Vol-->
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <a data-toggle="collapse" href="#CotConvT7"><h3 class="panel-title">T7</h3></a>
                                </div>
                                <div id="CotConvT7" class="panel-collapse collapse in">
                                    <div class="panel-body">
                                        <table class="table table-striped">
                                            <thead class="thead-light">
                                            <tr>
                                                <th>Rango KM</th>
                                                <th>Promedio Peso tarimas</th>
                                                <th>Promedio Volumen tarimas</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                <td>Replicar en todos </td>
                                                <td><input type="checkbox" class="custom-control-input"  ng-model="Convenio.blnSameWeight" ng-click="replicateDimensionsAVR(); calculateConvACK()" /></td>
                                                <td><input type="checkbox" class="custom-control-input"  ng-model="Convenio.blnSameVol" ng-click="replicateDimensionsAVR(); calculateConvACK()"/></td>
                                            </tr>
                                            <tr ng-repeat="(keyRange, totalByRange) in Convenio.mapTotal">
                                                <td ng-bind="Convenio.listRange[keyRange]"></td>
                                                <td contenteditable="true" ng-bind="totalByRange.fltWeightAVR | number:2" ng-blur="setValue('WeightAVR', keyRange, $event)"/>
                                                <td contenteditable="true" ng-bind="totalByRange.fltVolAVR | number:2" ng-blur="setValue('VolAVR', keyRange, $event)"/>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <!-- Servicios -->
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <a data-toggle="collapse" href="#CotConvSA"><h3 class="panel-title">SERVICIOS QUE UTILIZARÁ</h3></a>
                                </div>
                                <div id="CotConvSA" class="panel-collapse collapse in">
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-sm-5 col-md-5 right">
                                                Descuento
                                            </div>
                                            <div class="col-sm-6 col-md-6 right">
                                                Descuento
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-3 col-md-3">
                                                <input type="checkbox" class="custom-control-input" id="PAK" name="PAK" ng-model="Convenio.blnPack"/>
                                                <label>Paquetes</label>
                                            </div>
                                            <div class="col-sm-3 col-md-3">
                                                <input type="number" class="rouded-med" ng-model="Convenio.fltDiscPack" ng-change="calculateConvACK()"/>
                                            </div>
                                            <div class="col-sm-3 col-md-3">
                                                <input type="checkbox" class="custom-control-input" id="SOB" name="SOB" ng-model="Convenio.blnSobre"/>
                                                <label>Sobres</label>
                                            </div>
                                            <div class="col-sm-3 col-md-3">
                                                <input type="number" class="rouded-med" ng-model="Convenio.fltDiscSobre" ng-change="calculateConvACK()"/>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-3 col-md-3">
                                                <input type="checkbox" class="custom-control-input" id="RAD" name="RAD" ng-model="Convenio.blnRAD" ng-click="calculateConvACK()"/>
                                                <label>RAD</label>
                                            </div>
                                            <div class="col-sm-3 col-md-3">
                                                <input type="number" class="rouded-med" ng-model="Convenio.fltDiscRAD" ng-change="calculateConvACK()"/>
                                            </div>
                                            <div class="col-sm-3 col-md-3">
                                                <input type="checkbox" class="custom-control-input" id="SEG" name="SEG" ng-model="Convenio.blnSEG" ng-click="calculateConvACK()"/>
                                                <label>Seguro</label>
                                                <input type="number" class="rouded-med" ng-model="Convenio.fltSEG" placeholder="monto" ng-show="Convenio.blnSEG" />
                                            </div>
                                            <div class="col-sm-3 col-md-3">
                                                <input type="number" class="rouded-med" ng-model="Convenio.fltDiscSEG" ng-change="calculateConvACK()" ng-disabled="!Convenio.blnDescSeg" ng-class="{disabled: !Convenio.blnDescSeg}"/>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-6 col-md-6">
                                                <input type="checkbox" class="custom-control-input" id="EAD" name="EAD" ng-model="Convenio.blnEAD" ng-click="calculateConvACK()"/>
                                                <label>EAD</label>
                                            </div>

                                            <div class="col-sm-3 col-md-3">
                                                <input type="checkbox" class="custom-control-input" id="ACK" name="ACK" ng-model="Convenio.blnACK" ng-click="calculateConvACK()"/>
                                                <label>Acuse</label>
                                            </div>
                                            <div class="col-sm-3 col-md-3">
                                                <input type="number" class="rouded-med" ng-model="Convenio.fltDiscACK" ng-change="calculateConvACK()"/>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-3 col-md-3">
                                                <label>Paquetexpress</label>
                                            </div>
                                            <div class="col-sm-3 col-md-3">
                                                <input type="number" class="rouded-med" ng-model="Convenio.fltDiscEAD" ng-change="calculateConvACK()"/>
                                            </div>
                                            <div class="col-sm-6 col-md-6">
                                                <input type="radio" class="custom-control-input" ng-model="Convenio.strACK" value="Interno" ng-click="calculateConvACK()"/>
                                                <label>Interno</label>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-3 col-md-3">
                                                <label>Zona plus</label>
                                            </div>
                                            <div class="col-sm-3 col-md-3">
                                                <input type="number" class="rouded-med" ng-model="Convenio.fltDiscZP" ng-change="calculateConvACK()"/>
                                            </div>
                                            <div class="col-sm-6 col-md-6">
                                                <input type="radio" class="custom-control-input" ng-model="Convenio.strACK" value="Empresa" ng-click="calculateConvACK()"/>
                                                <label>Empresa</label>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-6 col-md-6" />
                                            <div class="col-sm-6 col-md-6">
                                                <input type="radio" class="custom-control-input" ng-model="Convenio.strACK" value="XT" ng-click="calculateConvACK()"/>
                                                <label>XT</label>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-3 col-md-3">
                                                <input type="checkbox" class="custom-control-input" id="PAK" name="PAK" ng-model="ConvenioDS.blnDisc"/>
                                                <label>DS</label>
                                            </div>
                                            <div class="col-sm-3 col-md-3">
                                                <input type="number" class="rouded-med" ng-model="ConvenioDS.fltDisc" ng-change="calculateProjection()"/>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-3 col-md-3">
                                                <input type="checkbox" class="custom-control-input" id="PAK" name="PAK" ng-model="Convenio2D.blnDisc"/>
                                                <label>2D</label>
                                            </div>
                                            <div class="col-sm-3 col-md-3">
                                                <input type="number" class="rouded-med" ng-model="Convenio2D.fltDisc" ng-change="calculateProjection()"/>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-3 col-md-3">
                                                <input type="checkbox" class="custom-control-input" id="PAK" name="PAK" ng-model="ConvenioA12.blnDisc"/>
                                                <label>A12</label>
                                            </div>
                                            <div class="col-sm-3 col-md-3">
                                                <input type="number" class="rouded-med" ng-model="ConvenioA12.fltDisc" ng-change="calculateProjection()"/>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-3 col-md-3" />
                                            <div class="col-sm-6 col-md-6">
                                                <label>Promedio de envíos con acuse</label>
                                            </div>
                                            <div class="col-sm-3 col-md-3">
                                                <input type="number" class="rouded-med" ng-model="Convenio.promDeliveryACK" ng-blur="calculateConvACK()"/>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-3 col-md-3"/>
                                            <div class="col-sm-6 col-md-6">
                                                <label>Paquetes promedio por guía</label>
                                            </div>
                                            <div class="col-sm-3 col-md-3">
                                                <input type="number" class="rouded-med" ng-model="Convenio.promPackByDeslivery" ng-blur="calculateConvACK()"/>
                                            </div>
                                        </div>
                                        <br/><br/>
                                        <div id="MainMenu">
                                            <div class="list-group panel">
                                                <a href="#demo3" class="list-group-item list-group-item-default" data-toggle="collapse" data-parent="#MainMenu">
                                                    <div class="row">
                                                        <div class="col-md-6 col-sm-6">
                                                            <label for="">TOTAL TARIFA LLENA</label>
                                                        </div>
                                                        <div class="col-md-6 col-sm-6">
                                                            <span class="bold" ng-bind="ProjectionSumary['Total'] | currency"></span>
                                                        </div>
                                                    </div>
                                                </a>
                                                <div class="collapse" id="demo3">
                                                    <div class="row list-group-item">
                                                        <div class="col-md-6 col-sm-6">SERVICIO ESTÁNDAR TERRESTRE</div>
                                                        <div class="col-md-6 col-sm-6">
                                                            <span ng-bind="ProjectionFull['fltTotal'] | currency"></span>
                                                        </div>
                                                    </div>
                                                    <div class="row list-group-item">
                                                        <div class="col-md-6 col-sm-6">SERVICIO EXPRESS ONE'DAY</div>
                                                        <div class="col-md-6 col-sm-6">
                                                            <span ng-bind="ProjectionDS.fltTotal | currency"></span>
                                                        </div>
                                                    </div>
                                                    <div class="row list-group-item">
                                                        <div class="col-md-6 col-sm-6">SERVICIO EXPRESS 2'DAYS</div>
                                                        <div class="col-md-6 col-sm-6">
                                                            <span ng-bind="Projection2D.fltTotal | currency"></span>
                                                        </div>
                                                    </div>
                                                    <div class="row list-group-item">
                                                        <div class="col-md-6 col-sm-6">SERVICIO EXPRESS MID'DAY</div>
                                                        <div class="col-md-6 col-sm-6">
                                                            <span ng-bind="ProjectionA12.fltTotal | currency"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <a href="#demo4" class="list-group-item list-group-item-default" data-toggle="collapse" data-parent="#MainMenu">
                                                    <div class="row">
                                                        <div class="col-md-6 col-sm-6">
                                                            <label for="">TOTAL PROPUESTO</label>
                                                        </div>
                                                        <div class="col-md-6 col-sm-6">
                                                            <span class="bold" ng-bind="ProjectionSumary['TotalDisc'] | currency"></span>
                                                        </div>
                                                    </div>
                                                </a>
                                                <div class="collapse" id="demo4">
                                                    <div class="row list-group-item">
                                                        <div class="col-md-6 col-sm-6">SERVICIO ESTÁNDAR TERRESTRE</div>
                                                        <div class="col-md-6 col-sm-6">
                                                            <span ng-bind="ProjectionDisc['fltTotal'] | currency"></span>
                                                        </div>
                                                    </div>
                                                    <div class="row list-group-item">
                                                        <div class="col-md-6 col-sm-6">SERVICIO EXPRESS ONE'DAY</div>
                                                        <div class="col-md-6 col-sm-6">
                                                            <span ng-bind="ProjectionDS.fltTotalDisc | currency"></span>
                                                        </div>
                                                    </div>
                                                    <div class="row list-group-item">
                                                        <div class="col-md-6 col-sm-6">SERVICIO EXPRESS 2'DAYS</div>
                                                        <div class="col-md-6 col-sm-6">
                                                            <span ng-bind="Projection2D.fltTotalDisc | currency"></span>
                                                        </div>
                                                    </div>
                                                    <div class="row list-group-item">
                                                        <div class="col-md-6 col-sm-6">SERVICIO EXPRESS MID'DAY</div>
                                                        <div class="col-md-6 col-sm-6">
                                                            <span ng-bind="ProjectionA12.fltTotalDisc | currency"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <a href="#demo5" class="list-group-item list-group-item-default" data-toggle="collapse" data-parent="#MainMenu">
                                                    <div class="row">
                                                        <div class="col-md-6 col-sm-6">
                                                            <label for="">DESCUENTO GLOBAL</label>
                                                        </div>
                                                        <div class="col-md-6 col-sm-6">
                                                            <span class="bold" ng-bind="ProjectionSumary['GlobalDisc'] | percentage:2"></span>
                                                        </div>
                                                    </div>
                                                </a>
                                                <div class="collapse" id="demo5">
                                                    <div class="row list-group-item">
                                                        <div class="col-md-6 col-sm-6">DESCUENTO STD </div>
                                                        <div class="col-md-6 col-sm-6">
                                                            <span class="bold" ng-bind="ProjectionSumary['GlobalSTD'] | percentage:2"></span>
                                                        </div>
                                                    </div>
                                                    <div class="row list-group-item">
                                                        <div class="col-md-6 col-sm-6">DESCUENTO SEG</div>
                                                        <div class="col-md-6 col-sm-6">
                                                            <span class="bold" ng-bind="ProjectionSumary['GlobalSEG'] | percentage:2"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12 col-sm-12 right">
                            <div class="btn-group ">
                                <button type="button" class="btn btn-default" ng-click="exit()">
                                    <span class="glyphicon glyphicon-menu-left"></span> Salir
                                </button>
                                <button type="button" class="btn btn-danger" ng-click="dataTest()" ng-show="isAdmin()">
                                    Data Test <span class="glyphicon glyphicon-menu-right"></span>
                                </button>
                                <button type="button" class="btn btn-primary" ng-show="hasRecord()" data-toggle="modal" data-target="#ModalApprovalSPW">
                                    Enviar a Autorización <span class="glyphicon glyphicon-check"></span>
                                </button>
                                <button type="button" class="btn btn-primary" ng-click="createQuotes()">
                                    Guardar <span class="glyphicon glyphicon-floppy-disk"></span>
                                </button>
                                <button type="button" class="btn btn-primary" ng-click="nextStep('one')" ng-show="isAdmin()">
                                    Siguiente
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="row" ng-show="Step2">
                        <div class="col-md-12 col-sm-12">
                            <div class="row">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <a data-toggle="collapse" href="#CotProy"><h3 class="panel-title">PROYECCIÓN DE COSTO TARIFA LLENA (ANTES DE DESCUENTOS) Paquetexpress</h3></a>
                                    </div>
                                    <div id="CotProy" class="panel-collapse collapse in">
                                        <div class="panel-body">
                                            <div class="row">
                                                <table class="table table-striped">
                                                    <thead class="thead-light">
                                                    <tr>
                                                        <th>Rango KM</th>
                                                        <th> TS</th>
                                                        <th> T0</th>
                                                        <th> T1</th>
                                                        <th> T2</th>
                                                        <th> T3</th>
                                                        <th> T4</th>
                                                        <th> T5</th>
                                                        <th> T6</th>
                                                        <th> T7</th>
                                                        <th> T7-P</th>
                                                        <th> T7-V</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <tr ng-repeat="(keyRange, strRange) in Convenio.listRange">
                                                        <td ng-bind="strRange"></td>
                                                        <td ng-repeat="(strFeeKey, pro) in Projection" ng-bind="pro.ranges[keyRange].fltAmount | currency" ></td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td ng-repeat="(strFeeKey, pro) in Projection" ng-show="strFeeKey!== 'TS' && strFeeKey!== 'TARIFA T7P' && strFeeKey!== 'TARIFA T7V'"></td>
                                                    </tr>
                                                    <tr>
                                                        <td >Paquetes</td>
                                                        <td></td>
                                                        <td ng-repeat="(strFeeKey, pro) in Projection" ng-bind="pro.fltTotalByFee | currency" ng-show="strFeeKey!== 'TS' && strFeeKey!== 'TARIFA T7P' && strFeeKey!== 'TARIFA T7V'"></td>
                                                    </tr>
                                                    <tr>
                                                        <td >Sobres</td>
                                                        <td ng-bind="Projection['TS'].fltTotalByFee | currency" ></td>
                                                        <td ng-repeat="(strFeeKey, pro) in Projection" ng-show="strFeeKey!== 'TS'  && strFeeKey!== 'TARIFA T7P' && strFeeKey!== 'TARIFA T7V'"></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            RAD
                                                        </td>
                                                        <td></td>
                                                        <td ng-repeat="(strFeeKey, pro) in Projection" ng-bind="pro.fltTotalRAD | currency" ng-show="strFeeKey!== 'TS' && strFeeKey!== 'TARIFA T7P' && strFeeKey!== 'TARIFA T7V'"></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            EAD PAQUETEXPRESS
                                                        </td>
                                                        <td></td>
                                                        <td ng-repeat="(strFeeKey, pro) in Projection" ng-bind="pro.fltTotalEAD | currency" ng-show="strFeeKey!== 'TS' && strFeeKey!== 'TARIFA T7P' && strFeeKey!== 'TARIFA T7V'"></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            SEGURO
                                                        </td>
                                                        <td></td>
                                                        <td ng-repeat="(strFeeKey, pro) in Projection" ng-bind="pro.fltTotalSEG | currency" ng-show="strFeeKey!== 'TS' && strFeeKey!== 'TARIFA T7P' && strFeeKey!== 'TARIFA T7V'"></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            ACUSE
                                                        </td>
                                                        <td ng-repeat="(strFeeKey, pro) in Projection" ng-bind="pro.fltTotalACK | currency" ng-show="strFeeKey!== 'TARIFA T7P' && strFeeKey!== 'TARIFA T7V'"></td>
                                                    </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <a data-toggle="collapse" href="#CotProyZP"><h3 class="panel-title">PROYECCIÓN DE COSTO TARIFA LLENA (ANTES DE DESCUENTOS) Zona Plus</h3></a>
                                    </div>
                                    <div id="CotProyZP" class="panel-collapse collapse in">
                                        <div class="panel-body">
                                            <div class="row">
                                                <table class="table table-striped">
                                                    <thead class="thead-light">
                                                    <tr>
                                                        <th>Rango KM</th>
                                                        <th> TS</th>
                                                        <th> T0</th>
                                                        <th> T1</th>
                                                        <th> T2</th>
                                                        <th> T3</th>
                                                        <th> T4</th>
                                                        <th> T5</th>
                                                        <th> T6</th>
                                                        <th> T7</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <tr ng-repeat="(keyRange, strRange) in Convenio.listRange">
                                                        <td ng-bind="strRange"></td>
                                                        <td ng-repeat="(strFeeKey, pro) in ProjectionZP" ng-bind="pro.ranges[keyRange].fltAmount | currency" ></td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td ng-repeat="(strFeeKey, pro) in ProjectionZP" ></td>
                                                    </tr>
                                                    <tr>
                                                        <td >Paquetes</td>
                                                        <td></td>
                                                        <td ng-repeat="(strFeeKey, pro) in ProjectionZP" ng-bind="pro.fltTotalByFee | currency" ng-show="strFeeKey!== 'TS'"></td>
                                                    </tr>
                                                    <tr>
                                                        <td >Sobres</td>
                                                        <td ng-bind="ProjectionZP['TS'].fltTotalByFee | currency" ></td>
                                                        <td ng-repeat="(strFeeKey, pro) in ProjectionZP" ng-show="strFeeKey!== 'TS'"></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            RAD
                                                        </td>
                                                        <td></td>
                                                        <td ng-repeat="(strFeeKey, pro) in ProjectionZP" ng-bind="pro.fltTotalRAD | currency" ng-show="strFeeKey!== 'TS'"></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            EAD PAQUETEXPRESS
                                                        </td>

                                                        <td ng-repeat="(strFeeKey, pro) in ProjectionZP" ng-bind="pro.fltTotalEAD | currency" ></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            SEGURO
                                                        </td>
                                                        <td></td>
                                                        <td ng-repeat="(strFeeKey, pro) in ProjectionZP" ng-bind="pro.fltTotalSEG | currency" ng-show="strFeeKey!== 'TS'"></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            ACUSE
                                                        </td>
                                                        <td ng-repeat="(strFeeKey, pro) in ProjectionZP" ng-bind="pro.fltTotalACK | currency" ></td>
                                                    </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12 col-sm-12 right">
                                    <div class="btn-group ">
                                        <button type="button" class="btn btn-default" ng-click="previousStep('two')">
                                            <span class="glyphicon glyphicon-menu-left" ></span> Anterior
                                        </button>
                                        <button type="button" class="btn btn-primary" ng-click="nextStep('two')">
                                            Siguiente <span class="glyphicon glyphicon-menu-right"></span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" ng-show="Step3">
                        <div class="col-md-12 col-sm-12">
                            <div class="row">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <a data-toggle="collapse" href="#CotProyFULL"><h3 class="panel-title">PROYECCIÓN DE COSTO TARIFA LLENA (ANTES DE DESCUENTOS) Todas las Zonas</h3></a>
                                    </div>
                                    <div id="CotProyFULL" class="panel-collapse collapse in">
                                        <div class="panel-body">
                                            <div class="row">
                                                <table class="table table-striped">
                                                    <thead class="thead-light">
                                                    <tr>
                                                        <th>Rango KM</th>
                                                        <th> TS</th>
                                                        <th> T0</th>
                                                        <th> T1</th>
                                                        <th> T2</th>
                                                        <th> T3</th>
                                                        <th> T4</th>
                                                        <th> T5</th>
                                                        <th> T6</th>
                                                        <th> T7</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>

                                                    <tr>
                                                        <td >Paquetes</td>
                                                        <td></td>
                                                        <td ng-repeat="(strFeeKey, pro) in ProjectionFull" ng-bind="pro.fltTotalByFee | currency" ng-show="strFeeKey!== 'TS'"></td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td >Sobres</td>
                                                        <td ng-bind="ProjectionFull['TS'].fltTotalByFee | currency" ></td>
                                                        <td ng-repeat="(strFeeKey, pro) in ProjectionFull" ng-show="strFeeKey!== 'TS'"></td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            RAD
                                                        </td>
                                                        <td></td>
                                                        <td ng-repeat="(strFeeKey, pro) in ProjectionFull" ng-bind="pro.fltTotalRAD | currency" ng-show="strFeeKey!== 'TS'"></td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            EAD PAQUETEXPRESS
                                                        </td>
                                                        <td></td>
                                                        <td ng-repeat="(strFeeKey, pro) in ProjectionFull" ng-bind="pro.fltTotalEAD | currency" ng-show="strFeeKey!== 'TS'"></td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            EAD ZONA PLUS
                                                        </td>
                                                        <td ng-repeat="(strFeeKey, pro) in ProjectionZP" ng-bind="pro.fltTotalEAD | currency" ng-show="strFeeKey!== 'T7'"></td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            SEGURO
                                                        </td>
                                                        <td></td>
                                                        <td ng-repeat="(strFeeKey, pro) in ProjectionFull" ng-bind="pro.fltTotalSEG | currency" ng-show="strFeeKey!== 'TS'"></td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            ACUSE
                                                        </td>
                                                        <td ng-repeat="(strFeeKey, pro) in ProjectionFull" ng-bind="pro.fltTotalACK | currency"></td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="bold">
                                                            Total
                                                        </td>
                                                        <td class="bold" ng-repeat="(strFeeKey, pro) in ProjectionFull" ng-bind="pro.fltTotal | currency"></td>
                                                        <td class="bold" ng-bind="ProjectionFull['fltTotal'] | currency"></td>
                                                    </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 col-sm-12 right">
                                    <div class="btn-group ">
                                        <button type="button" class="btn btn-default" ng-click="previousStep('three')">
                                            <span class="glyphicon glyphicon-menu-left" ></span> Anterior
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
            </div>
        </div>
        <!--modal approval-->
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <div class="modal fade" id="ModalApprovalSPW" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                                    <textarea class="form-control" rows="3" ng-model="Convenio.strApprovalComment"></textarea>
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
        <!-- Messages -->
        <div class="row center">
            <div class="col-sm-12 col-md-12">
                <div class="alert alert-danger" role="alert" ng-repeat="(i, errorMessage) in DML.listErrors">
                    <span ng-bind="errorMessage"></span>
                </div>
                <div class="alert alert-success" role="alert" ng-show="DML.blnSuccess && sent">
                    <span ng-bind="SuccessMessage"></span>  <span ng-show="Wrapper.objQuote.Id"> Ver: <a href="/{{Wrapper.objQuote.Id}}">{{ Wrapper.objQuote.Name }}</a> </span>
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
            var app = angular.module('Cotizador', []);
            // main controller
            /*
            * Angular module controllers
            * Begin Angular Controller
            */
            app.controller('SWPController', ['$scope',function($scope) {

                /*
                * Controller variables
                */
                $scope.Convenio = {
                    strApprovalComment : ''
                    , blnPack : false
                    , blnSobre : false
                    , blnEAD : false
                    , blnRAD : false
                    , blnSEG : false
                    , fltSEG : 0
                    , blnACK : false
                    , strACK : ''
                    , blnZP : false
                    , fltAVGDeliveryByACK : 0
                    , fltAVGPackByDay : 0
                    , fltDiscPack : 0
                    , fltDiscSobre : 0
                    , fltDiscRAD : 0
                    , fltDiscSEG : 0
                    , fltDiscEAD : 0
                    , fltDiscZP : 0
                    , fltDiscACK : 0
                    , intTotalQ : 0
                    , promDeliveryACK : 0
                    , promPackByDeslivery : 0
                    , blnSameWeight : false
                    , blnSameVol : false
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

                    }
                    , mapTotal:{

                    }

                };
                $scope.ConvenioZP = {
                    intTotalQ : 0
                    , mapQuotes:{

                    }
                    , mapTotal:{

                    }
                };
                $scope.ConvenioDS = {
                    intTotalQ : 0
                    , fltTotalFrec : 0
                    , ranges : {}
                    , blnSameWeight : false
                    , blnSameLarge : false
                    , blnSameWidth : false
                    , blnSameHigh : false
                    , blnDisc : false
                    , fltDisc : 0
                };
                $scope.Convenio2D = {
                    intTotalQ : 0
                    , fltTotalFrec : 0
                    , ranges : {}
                    , blnSameWeight : false
                    , blnSameLarge : false
                    , blnSameWidth : false
                    , blnSameHigh : false
                    , blnDisc : false
                    , fltDisc : 0
                };
                $scope.ConvenioA12 = {
                    intTotalQ : 0
                    , fltTotalFrec : 0
                    , ranges : {}
                    , blnSameWeight : false
                    , blnSameLarge : false
                    , blnSameWidth : false
                    , blnSameHigh : false
                    , blnDisc : false
                    , fltDisc : 0
                };
                $scope.Managers = [];
                $scope.Projection = {};
                $scope.ProjectionZP = {};
                $scope.ProjectionDS = {
                    fltTotal: 0
                    , fltTotalSEG : 0
                    , fltTotalACK : 0
                    , fltTotalDisc : 0
                    , ranges :{}
                };
                $scope.Projection2D = {
                    fltTotal: 0
                    , fltTotalSEG : 0
                    , fltTotalACK : 0
                    , fltTotalDisc : 0
                    , ranges :{}
                };
                $scope.ProjectionA12 = {
                    fltTotal: 0
                    , fltTotalSEG : 0
                    , fltTotalACK : 0
                    , fltTotalDisc : 0
                    , ranges :{}
                };
                $scope.ProjectionFull = {};
                $scope.ProjectionDisc = {};
                $scope.ProjectionSumary = {};
                $scope.Step1 = true;
                $scope.Step2 = false;
                $scope.Step3 = false;
                j$.each(
                    $scope.Convenio.listFee,
                        function(keyFee, fee){
                            $scope.Convenio.mapQuotes[keyFee] = {
                                ranges : []
                                , intFeeTotalQ : 0
                                , fltFeeTotalFrec:0
                            };
                            $scope.ConvenioZP.mapQuotes[keyFee] = {
                                ranges : []
                                , intFeeTotalQ : 0
                                , fltFeeTotalFrec:0
                            };
                            $scope.Projection[keyFee] = {
                                fltTotalByFee: 0
                                , fltTotalRAD : 0
                                , fltTotalEAD : 0
                                , fltTotalSEG : 0
                                , fltTotalACK : 0
                                ,ranges:[]
                            };
                            $scope.ProjectionZP[keyFee] = {
                                fltTotalByFee: 0
                                , fltTotalRAD : 0
                                , fltTotalEAD : 0
                                , fltTotalSEG : 0
                                , fltTotalACK : 0
                                ,ranges:[]
                            };
                            $scope.ProjectionFull[keyFee] = {
                                fltTotalByFee: 0
                                , fltTotalRAD : 0
                                , fltTotalEAD : 0
                                , fltTotalEADZP : 0
                                , fltTotalSEG : 0
                                , fltTotalACK : 0
                                , fltTotal : 0
                            };
                            $scope.ProjectionDisc[keyFee] = {
                                fltTotalByFee: 0
                                , fltTotalRAD : 0
                                , fltTotalEAD : 0
                                , fltTotalEADZP : 0
                                , fltTotalSEG : 0
                                , fltTotalACK : 0
                                , fltTotal : 0
                                , ranges:[]
                            };
                        }
                );

                $scope.Projection['TARIFA T7P'] = {
                    fltTotalByFee: 0
                    ,ranges:[]
                };
                $scope.Projection['TARIFA T7V'] = {
                    fltTotalByFee: 0
                    ,ranges:[]
                };
                $scope.ProjectionFull['fltTotal'] = 0;
                $scope.ProjectionDisc['fltTotal'] = 0;
                $scope.ProjectionDisc['fltGlobalDisc'] = 0;

                j$.each(
                        $scope.Convenio.listFee,
                        function (key, value) {
                            j$.each(
                                    $scope.Convenio.listRange,
                                    function(keyRange, strRange){
                                        $scope.Convenio.mapQuotes[key].ranges[keyRange] = {
                                            intFrecuency : 0
                                        };
                                        $scope.ConvenioZP.mapQuotes[key].ranges[keyRange] = {
                                            intFrecuency : 0
                                        };

                                        $scope.Projection[key].ranges[keyRange] = {fltAmount:0};
                                        $scope.ProjectionZP[key].ranges[keyRange] = {fltAmount:0};
                                        $scope.ProjectionDisc[key].ranges[keyRange] = {fltAmount:0};

                                    }
                            );
                        }
                );

                j$.each(
                        $scope.Convenio.listRange,
                        function(keyRange, strRange){
                            $scope.Projection['TARIFA T7P'].ranges[keyRange] ={ fltAmount : 0 };
                            $scope.Projection['TARIFA T7V'].ranges[keyRange] ={ fltAmount : 0 };
                            $scope.ConvenioDS.ranges[keyRange] = {
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
                            };
                            $scope.Convenio2D.ranges[keyRange] = {
                                intFrecuency : 0
                                , fltFrecuency :0
                                , fltWeight:0
                                , fltVol:0
                                , fltVolWeight:0
                                , fltDominantWeight:0
                                , fltLarge:0
                                , fltHigh:0
                                , fltWidth:0
                            };
                            $scope.ConvenioA12.ranges[keyRange] = {
                                intFrecuency : 0
                                , fltFrecuency :0
                                , fltWeight:0
                                , fltVol:0
                                , fltVolWeight:0
                                , fltDominantWeight:0
                                , fltLarge:0
                                , fltHigh:0
                                , fltWidth:0
                            };

                            $scope.Convenio.mapTotal[keyRange] = {
                                intRanTotal:0
                                , fltRanTotalFrec:0
                                , fltWeightAVR : 0
                                , fltVolAVR : 0
                            };
                            $scope.ConvenioZP.mapTotal[keyRange] = {
                                intRanTotal:0
                                , fltRanTotalFrec :0
                            };

                            $scope.ProjectionDS.ranges[keyRange] = {
                                fltAmount : 0
                                , fltTotalDisc : 0
                                , fltAditionalKg : 0
                                , fltTotalSEG : 0
                                , fltTotalACK: 0
                            };
                            $scope.Projection2D.ranges[keyRange] = {
                                fltAmount : 0
                                , fltTotalDisc : 0
                                , fltAditionalKg : 0
                                , fltTotalSEG : 0
                                , fltTotalACK: 0
                            };
                            $scope.ProjectionA12.ranges[keyRange] = {
                                fltAmount : 0
                                , fltTotalDisc : 0
                                , fltAditionalKg : 0
                                , fltTotalSEG : 0
                                , fltTotalACK : 0
                                , fltTotal : 0
                            };
                        }
                );
                //debugger;
                /*
                * Controller functions
                */
                $scope.calculateConvACK = function(){
                    j$.each($scope.Convenio.listFee
                            , function (keyFee, strFee) {
                                $scope.Projection[keyFee].fltTotalACK = 0;
                                $scope.ProjectionZP[keyFee].fltTotalACK = 0;
                                $scope.ProjectionFull[keyFee].fltTotalACK = 0;
                                $scope.ProjectionDisc[keyFee].fltTotalACK = 0;

                                if(notEmpty($scope.Convenio.strACK) && $scope.Convenio.blnACK ){

                                    if($scope.Convenio.mapQuotes[keyFee].intFeeTotalQ)
                                        $scope.Projection[keyFee].fltTotalACK   = ($scope.Convenio.mapQuotes[keyFee].intFeeTotalQ / $scope.Convenio.promPackByDeslivery) *  $scope.Wrapper.mapACK[$scope.Convenio.strACK] * ($scope.Convenio.promDeliveryACK /100) ;
                                    if($scope.ConvenioZP.mapQuotes[keyFee].intFeeTotalQ)
                                        $scope.ProjectionZP[keyFee].fltTotalACK   = ($scope.ConvenioZP.mapQuotes[keyFee].intFeeTotalQ / $scope.Convenio.promPackByDeslivery) *  $scope.Wrapper.mapACK[$scope.Convenio.strACK] * ($scope.Convenio.promDeliveryACK /100);
                                    $scope.ProjectionFull[keyFee].fltTotalACK = $scope.Projection[keyFee].fltTotalACK + $scope.ProjectionZP[keyFee].fltTotalACK;
                                    $scope.ProjectionDisc[keyFee].fltTotalACK = $scope.desc($scope.ProjectionFull[keyFee].fltTotalACK, $scope.Convenio.fltDiscACK);
                                }
                                else
                                    $scope.Convenio.strACK = '';

                            }
                    );
                    $scope.calculateProjection();

                };

                $scope.calculateConvDomServ = function(){
                    $scope.ProjectionFull['fltTotal'] = 0;
                    $scope.ProjectionDisc['fltTotal'] = 0;

                    j$.each($scope.Convenio.listFee
                            , function (keyFee, strFee) {
                                if($scope.Convenio.blnRAD && keyFee != 'TS'){
                                    $scope.Projection[keyFee].fltTotalRAD   = $scope.Projection[keyFee].fltTotalByFee * ($scope.Wrapper.mapCS['RAD'] / 100);
                                    if(keyFee !== 'T7') {
                                        $scope.ProjectionZP[keyFee].fltTotalRAD = $scope.ProjectionZP[keyFee].fltTotalByFee * ($scope.Wrapper.mapCS['RAD'] / 100);
                                        $scope.ProjectionFull[keyFee].fltTotalRAD = $scope.Projection[keyFee].fltTotalRAD + $scope.ProjectionZP[keyFee].fltTotalRAD;
                                    } else
                                        $scope.ProjectionFull[keyFee].fltTotalRAD = $scope.Projection[keyFee].fltTotalRAD;

                                    $scope.ProjectionDisc[keyFee].fltTotalRAD = $scope.desc($scope.ProjectionFull[keyFee].fltTotalRAD , $scope.Convenio.fltDiscRAD);
                                }
                                else{
                                    $scope.ProjectionFull[keyFee].fltTotalRAD = 0;
                                    $scope.ProjectionDisc[keyFee].fltTotalRAD = 0;
                                }

                                if($scope.Convenio.blnEAD){
                                    if(keyFee !== 'TS')
                                        $scope.Projection[keyFee].fltTotalEAD   = $scope.Projection[keyFee].fltTotalByFee * ($scope.Wrapper.mapCS['EAD'] / 100);

                                    $scope.ProjectionFull[keyFee].fltTotalEAD = $scope.Projection[keyFee].fltTotalEAD;
                                    $scope.ProjectionDisc[keyFee].fltTotalEAD = $scope.desc($scope.ProjectionFull[keyFee].fltTotalEAD , $scope.Convenio.fltDiscEAD);
                                }
                                else{
                                    $scope.ProjectionFull[keyFee].fltTotalEAD = 0;
                                    $scope.ProjectionDisc[keyFee].fltTotalEAD = 0;
                                }

                                if(keyFee !== 'T7'){
                                    $scope.ProjectionZP[keyFee].fltTotalEAD   = $scope.ConvenioZP.mapQuotes[keyFee].intFeeTotalQ * $scope.Wrapper.mapCS['AEZP'];
                                    $scope.ProjectionFull[keyFee].fltTotalEADZP = $scope.ProjectionZP[keyFee].fltTotalEAD;
                                    $scope.ProjectionDisc[keyFee].fltTotalEADZP = $scope.desc($scope.ProjectionFull[keyFee].fltTotalEADZP , $scope.Convenio.fltDiscZP);
                                }

                                if($scope.Convenio.blnSEG && keyFee !== 'TS'){
                                    $scope.Projection[keyFee].fltTotalSEG   = ($scope.Convenio.mapQuotes[keyFee].intFeeTotalQ * $scope.Convenio.fltSEG) * ($scope.Wrapper.mapCS['SEG'] / 1000);
                                    if(keyFee !== 'T7') {
                                        $scope.ProjectionZP[keyFee].fltTotalSEG = ($scope.ConvenioZP.mapQuotes[keyFee].intFeeTotalQ * $scope.Convenio.fltSEG) * ($scope.Wrapper.mapCS['SEG'] / 1000);
                                        $scope.ProjectionFull[keyFee].fltTotalSEG = $scope.Projection[keyFee].fltTotalSEG + $scope.ProjectionZP[keyFee].fltTotalSEG;
                                    }
                                    else
                                        $scope.ProjectionFull[keyFee].fltTotalSEG = $scope.Projection[keyFee].fltTotalSEG;

                                    $scope.ProjectionDisc[keyFee].fltTotalSEG = $scope.desc($scope.ProjectionFull[keyFee].fltTotalSEG, $scope.Convenio.fltDiscSEG);
                                }
                                else {
                                    $scope.ProjectionFull[keyFee].fltTotalSEG = 0;
                                    $scope.ProjectionDisc[keyFee].fltTotalSEG = 0;
                                }
                                $scope.ProjectionFull[keyFee].fltTotal = 0;
                                $scope.ProjectionDisc[keyFee].fltTotal = 0;
                                $scope.ProjectionFull[keyFee].fltTotal =  $scope.ProjectionFull[keyFee].fltTotalByFee
                                        + $scope.ProjectionFull[keyFee].fltTotalACK
                                        + $scope.ProjectionFull[keyFee].fltTotalRAD
                                        + $scope.ProjectionFull[keyFee].fltTotalEAD
                                        + $scope.ProjectionFull[keyFee].fltTotalEADZP
                                        + $scope.ProjectionFull[keyFee].fltTotalSEG;

                                $scope.ProjectionDisc[keyFee].fltTotal =  $scope.ProjectionDisc[keyFee].fltTotalByFee
                                        + $scope.ProjectionDisc[keyFee].fltTotalACK
                                        + $scope.ProjectionDisc[keyFee].fltTotalRAD
                                        + $scope.ProjectionDisc[keyFee].fltTotalEAD
                                        + $scope.ProjectionDisc[keyFee].fltTotalEADZP
                                        + $scope.ProjectionDisc[keyFee].fltTotalSEG;

                                j$.each($scope.Convenio.listRange
                                        , function (keyRange, strRange) {
                                            $scope.ProjectionDisc[keyFee].ranges[keyRange].fltAmount = $scope.Projection[keyFee].ranges[keyRange].fltAmount;
                                            $scope.ProjectionDisc[keyFee].ranges[keyRange].fltAmount += $scope.desc($scope.Projection[keyFee].ranges[keyRange].fltAmount, $scope.Convenio.fltDiscACK);
                                            if(!keyFee==='TS'){
                                                $scope.ProjectionDisc[keyFee].ranges[keyRange].fltAmount += $scope.desc($scope.Projection[keyFee].ranges[keyRange].fltAmount * ($scope.Wrapper.mapCS['RAD'] / 100), $scope.Convenio.fltDiscACK);
                                                $scope.ProjectionDisc[keyFee].ranges[keyRange].fltAmount += $scope.desc($scope.Projection[keyFee].ranges[keyRange].fltAmount * ($scope.Wrapper.mapCS['RAD'] / 100), $scope.Convenio.fltDiscRAD);
                                                $scope.ProjectionDisc[keyFee].ranges[keyRange].fltAmount += $scope.desc($scope.Projection[keyFee].ranges[keyRange].fltAmount * ($scope.Wrapper.mapCS['EAD'] / 100), $scope.Convenio.fltDiscEAD);
                                                $scope.ProjectionDisc[keyFee].ranges[keyRange].fltAmount += $scope.desc(($scope.Convenio.mapQuotes[keyFee].intFeeTotalQ * $scope.Convenio.fltSEG) * ($scope.Wrapper.mapCS['SEG'] / 1000), $scope.Convenio.fltDiscSEG);
                                            }
                                        }
                                );

                                $scope.ProjectionFull['fltTotal'] += $scope.ProjectionFull[keyFee].fltTotal;
                                $scope.ProjectionDisc['fltTotal'] += $scope.ProjectionDisc[keyFee].fltTotal;

                            }
                    );
                    //$scope.ProjectionDisc['fltGlobalDisc'] = $scope.ProjectionDisc['fltTotal'] / $scope.ProjectionFull['fltTotal'] - 1;
                    $scope.ProjectionSumary['Total']     = 0;
                    $scope.ProjectionSumary['TotalDisc'] = 0;

                    $scope.ProjectionSumary['Total']        += $scope.ProjectionFull['fltTotal'];
                    $scope.ProjectionSumary['TotalDisc']    += $scope.ProjectionDisc['fltTotal'];
                    $scope.ProjectionSumary['TotalSTD']        = $scope.ProjectionFull['fltTotal'];
                    $scope.ProjectionSumary['TotalDiscSTD']    = $scope.ProjectionDisc['fltTotal'];

                    $scope.ProjectionSumary['Total']        += $scope.ProjectionDS.fltTotal;
                    $scope.ProjectionSumary['TotalDisc']    += $scope.ProjectionDS.fltTotalDisc;

                    $scope.ProjectionSumary['Total']        += $scope.Projection2D.fltTotal;
                    $scope.ProjectionSumary['TotalDisc']    += $scope.Projection2D.fltTotalDisc;

                    $scope.ProjectionSumary['Total']        += $scope.ProjectionA12.fltTotal;
                    $scope.ProjectionSumary['TotalDisc']    += $scope.ProjectionA12.fltTotalDisc;

                    $scope.ProjectionSumary['TotalEXP']      = $scope.ProjectionDS.fltTotal + $scope.Projection2D.fltTotal + $scope.ProjectionA12.fltTotal;
                    $scope.ProjectionSumary['TotalDiscEXP']  = $scope.ProjectionDS.fltTotalDisc + $scope.Projection2D.fltTotalDisc + $scope.ProjectionA12.fltTotalDisc;

                    $scope.ProjectionSumary['GlobalDisc']   = $scope.ProjectionSumary['TotalDisc'] / $scope.ProjectionSumary['Total'] - 1;
                    $scope.ProjectionSumary['GlobalSTD']   = $scope.ProjectionSumary['TotalDiscSTD'] / $scope.ProjectionSumary['TotalSTD'] - 1;
                    $scope.ProjectionSumary['GlobalSEG']   = $scope.ProjectionSumary['TotalDiscEXP'] / $scope.ProjectionSumary['TotalEXP'] - 1;

                };

                $scope.calculateDimensions = function(fee, key){
                    switch (fee) {
                        case 'DS':
                            $scope.ConvenioDS.ranges[key].fltVol = ($scope.ConvenioDS.ranges[key].fltLarge * $scope.ConvenioDS.ranges[key].fltWidth * $scope.ConvenioDS.ranges[key].fltHigh) / 100;
                            $scope.ConvenioDS.ranges[key].fltVolWeight = ($scope.ConvenioDS.ranges[key].fltLarge * $scope.ConvenioDS.ranges[key].fltWidth * $scope.ConvenioDS.ranges[key].fltHigh) / $scope.Wrapper.mapCS['CPV'];

                            if($scope.ConvenioDS.ranges[key].fltVolWeight > $scope.ConvenioDS.ranges[key].fltWeight)
                                $scope.ConvenioDS.ranges[key].fltDominantWeight = $scope.ConvenioDS.ranges[key].fltVolWeight;
                            else
                                $scope.ConvenioDS.ranges[key].fltDominantWeight = $scope.ConvenioDS.ranges[key].fltWeight;
                            break;
                        case '2D':
                            $scope.Convenio2D.ranges[key].fltVol = ($scope.Convenio2D.ranges[key].fltLarge * $scope.Convenio2D.ranges[key].fltWidth * $scope.Convenio2D.ranges[key].fltHigh) / 100;
                            $scope.Convenio2D.ranges[key].fltVolWeight = ($scope.Convenio2D.ranges[key].fltLarge * $scope.Convenio2D.ranges[key].fltWidth * $scope.Convenio2D.ranges[key].fltHigh) / $scope.Wrapper.mapCS['CPV'];

                            if($scope.Convenio2D.ranges[key].fltVolWeight > $scope.Convenio2D.ranges[key].fltWeight)
                                $scope.Convenio2D.ranges[key].fltDominantWeight = $scope.Convenio2D.ranges[key].fltVolWeight;
                            else
                                $scope.Convenio2D.ranges[key].fltDominantWeight = $scope.Convenio2D.ranges[key].fltWeight;
                            break;
                        case 'A12':
                            $scope.ConvenioA12.ranges[key].fltVol = ($scope.ConvenioA12.ranges[key].fltLarge * $scope.ConvenioA12.ranges[key].fltWidth * $scope.ConvenioA12.ranges[key].fltHigh) / 100;
                            $scope.ConvenioA12.ranges[key].fltVolWeight = ($scope.ConvenioA12.ranges[key].fltLarge * $scope.ConvenioA12.ranges[key].fltWidth * $scope.ConvenioA12.ranges[key].fltHigh) / $scope.Wrapper.mapCS['CPV'];

                            if($scope.ConvenioA12.ranges[key].fltVolWeight > $scope.ConvenioA12.ranges[key].fltWeight)
                                $scope.ConvenioA12.ranges[key].fltDominantWeight = $scope.ConvenioA12.ranges[key].fltVolWeight;
                            else
                                $scope.ConvenioA12.ranges[key].fltDominantWeight = $scope.ConvenioA12.ranges[key].fltWeight;
                            break;
                    }
                    $scope.calculateProjection();
                };

                $scope.calculatePercentEXP = function(fee){
                    switch (fee) {
                        case 'DS':
                            $scope.ConvenioDS.fltTotalFrec = 0;
                                j$.each($scope.Convenio.listRange
                                        , function (key, value) {
                                                $scope.ConvenioDS.ranges[key].intFrecuency = $scope.ConvenioDS.ranges[key].fltFrecuency * $scope.ConvenioDS.intTotalQ;
                                                $scope.ConvenioDS.fltTotalFrec += $scope.ConvenioDS.ranges[key].fltFrecuency;
                                        }
                                );
                            break;
                        case '2D':
                            $scope.Convenio2D.fltTotalFrec = 0;
                                j$.each($scope.Convenio.listRange
                                        , function (key, value) {
                                            $scope.Convenio2D.ranges[key].intFrecuency = $scope.Convenio2D.ranges[key].fltFrecuency * $scope.Convenio2D.intTotalQ;
                                            $scope.Convenio2D.fltTotalFrec += $scope.Convenio2D.ranges[key].fltFrecuency;
                                        }
                                );
                            break;
                        case 'A12':
                            $scope.ConvenioA12.fltTotalFrec = 0;
                                j$.each($scope.Convenio.listRange
                                        , function (key, value) {
                                            $scope.ConvenioA12.ranges[key].intFrecuency = $scope.ConvenioA12.ranges[key].fltFrecuency * $scope.ConvenioA12.intTotalQ;
                                            $scope.ConvenioA12.fltTotalFrec += $scope.ConvenioA12.ranges[key].fltFrecuency;
                                        }
                                );
                            break;
                    }
                    $scope.calculateProjection();
                };

                $scope.calculateFreccEXP = function(fee, intTotalQ){
                    switch (fee) {
                        case 'DS':
                            if(intTotalQ != null){
                                $scope.ConvenioDS.intTotalQ = intTotalQ;
                                if(intTotalQ === 0){
                                    j$.each($scope.Convenio.listRange
                                            , function (key, value) {
                                                if($scope.ConvenioDS.ranges[key].intFrecuency > 0)
                                                    $scope.ConvenioDS.intTotalQ += $scope.ConvenioDS.ranges[key].intFrecuency;
                                            }
                                    );
                                }
                                j$.each($scope.Convenio.listRange
                                        , function (key, value) {
                                            if($scope.ConvenioDS.ranges[key].intFrecuency > 0) {
                                                if ($scope.ConvenioDS.intTotalQ > 0 )
                                                    $scope.ConvenioDS.ranges[key].fltFrecuency = $scope.ConvenioDS.ranges[key].intFrecuency / $scope.ConvenioDS.intTotalQ;
                                                else
                                                    $scope.ConvenioDS.ranges[key].fltFrecuency = 0;
                                            }
                                        }
                                );
                            }
                            else
                                j$.each($scope.Convenio.listRange
                                        , function (key, value) {
                                            $scope.ConvenioDS.ranges[key].intFrecuency = 0;
                                            $scope.ConvenioDS.ranges[key].fltFrecuency = 0;
                                            $scope.ConvenioDS.fltTotalFrec = 0;
                                        }
                                );
                            $scope.ConvenioDS.fltTotalFrec = 1;
                            break;
                        case '2D':
                            if(intTotalQ != null){
                                $scope.Convenio2D.intTotalQ = intTotalQ;
                                if(intTotalQ === 0){
                                    j$.each($scope.Convenio.listRange
                                            , function (key, value) {
                                                if($scope.Convenio2D.ranges[key].intFrecuency > 0)
                                                    $scope.Convenio2D.intTotalQ += $scope.Convenio2D.ranges[key].intFrecuency;
                                            }
                                    );
                                }
                                j$.each($scope.Convenio.listRange
                                        , function (key, value) {
                                            if($scope.Convenio2D.ranges[key].intFrecuency > 0) {
                                                if ($scope.Convenio2D.intTotalQ > 0 )
                                                    $scope.Convenio2D.ranges[key].fltFrecuency = $scope.Convenio2D.ranges[key].intFrecuency / $scope.Convenio2D.intTotalQ;
                                                else
                                                    $scope.Convenio2D.ranges[key].fltFrecuency = 0;
                                            }
                                        }
                                );
                            }
                            else
                                j$.each($scope.Convenio.listRange
                                        , function (key, value) {
                                            $scope.Convenio2D.ranges[key].intFrecuency = 0;
                                            $scope.Convenio2D.ranges[key].fltFrecuency = 0;
                                            $scope.Convenio2D.fltTotalFrec = 0;
                                        }
                                );
                            $scope.Convenio2D.fltTotalFrec = 1;
                            break;
                        case 'A12':
                            if(intTotalQ != null){
                                $scope.ConvenioA12.intTotalQ = intTotalQ;
                                if(intTotalQ === 0){
                                    j$.each($scope.Convenio.listRange
                                            , function (key, value) {
                                                if($scope.ConvenioA12.ranges[key].intFrecuency > 0)
                                                    $scope.ConvenioA12.intTotalQ += $scope.ConvenioA12.ranges[key].intFrecuency;
                                            }
                                    );
                                }
                                j$.each($scope.Convenio.listRange
                                        , function (key, value) {
                                            if($scope.ConvenioA12.ranges[key].intFrecuency > 0) {
                                                if ($scope.ConvenioA12.intTotalQ > 0 )
                                                    $scope.ConvenioA12.ranges[key].fltFrecuency = $scope.ConvenioA12.ranges[key].intFrecuency / $scope.ConvenioA12.intTotalQ;
                                                else
                                                    $scope.ConvenioA12.ranges[key].fltFrecuency = 0;
                                            }
                                        }
                                );
                            }
                            else
                                j$.each($scope.Convenio.listRange
                                        , function (key, value) {
                                            $scope.ConvenioA12.ranges[key].intFrecuency = 0;
                                            $scope.ConvenioA12.ranges[key].fltFrecuency = 0;
                                            $scope.ConvenioA12.fltTotalFrec = 0;
                                        }
                                );
                            $scope.ConvenioA12.fltTotalFrec = 1;
                            break;
                    }
                    $scope.calculateProjection();
                };

                $scope.calculateProjection = function() {
                    $scope.sent = false;
                    if ($scope.Convenio.intTotalQ > 0){

                        j$.each($scope.Convenio.listFee
                                , function (keyFee, strFee) {
                                    $scope.Projection[keyFee].fltTotalByFee = 0;
                                    $scope.ProjectionZP[keyFee].fltTotalByFee = 0;

                                    j$.each($scope.Convenio.listRange
                                            , function (keyRange, strRange) {
                                                $scope.Projection[keyFee].ranges[keyRange].fltAmount = 0;
                                                if(keyFee !== 'T7'){
                                                    $scope.Projection[keyFee].ranges[keyRange].fltAmount = $scope.Convenio.mapQuotes[keyFee].ranges[keyRange].intFrecuency * $scope.Wrapper.mapTarifarioT['TARIFA ' + keyFee][strRange].Flete__c;
                                                    $scope.Projection[keyFee].fltTotalByFee += $scope.Projection[keyFee].ranges[keyRange].fltAmount;
                                                }
                                                else{
                                                    $scope.getProjection(keyRange, $scope.Convenio.mapQuotes[keyFee].ranges[keyRange].intFrecuency);
                                                    $scope.Projection[keyFee].fltTotalByFee += $scope.Projection[keyFee].ranges[keyRange].fltAmount;
                                                }

                                                $scope.ProjectionFull[keyFee].fltTotalByFee = $scope.Projection[keyFee].fltTotalByFee + $scope.ProjectionZP[keyFee].fltTotalByFee;

                                                if(keyFee === 'TS')
                                                    $scope.ProjectionDisc[keyFee].fltTotalByFee = $scope.desc($scope.ProjectionFull[keyFee].fltTotalByFee, $scope.Convenio.fltDiscSobre);
                                                else
                                                    $scope.ProjectionDisc[keyFee].fltTotalByFee = $scope.desc($scope.ProjectionFull[keyFee].fltTotalByFee, $scope.Convenio.fltDiscPack);


                                            }
                                    );

                                }
                        );
                    }

                    if ( $scope.ConvenioZP.intTotalQ > 0){
                        j$.each($scope.Convenio.listFee
                                , function (keyFee, strFee) {
                                    $scope.ProjectionZP[keyFee].fltTotalByFee = 0;

                                    j$.each($scope.Convenio.listRange
                                            , function (keyRange, strRange) {
                                                if(keyFee !== 'T7') {
                                                    $scope.ProjectionZP[keyFee].ranges[keyRange].fltAmount = 0;
                                                    $scope.ProjectionZP[keyFee].ranges[keyRange].fltAmount = $scope.ConvenioZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency * $scope.Wrapper.mapTarifarioT['TARIFA ' + keyFee][strRange].Flete__c;
                                                    $scope.ProjectionZP[keyFee].fltTotalByFee += $scope.ProjectionZP[keyFee].ranges[keyRange].fltAmount;
                                                    $scope.ProjectionFull[keyFee].fltTotalByFee = $scope.Projection[keyFee].fltTotalByFee + $scope.ProjectionZP[keyFee].fltTotalByFee;
                                                }

                                                if(keyFee === 'TS')
                                                    $scope.ProjectionDisc[keyFee].fltTotalByFee = $scope.desc($scope.ProjectionFull[keyFee].fltTotalByFee, $scope.Convenio.fltDiscSobre);
                                                else
                                                    $scope.ProjectionDisc[keyFee].fltTotalByFee = $scope.desc($scope.ProjectionFull[keyFee].fltTotalByFee, $scope.Convenio.fltDiscPack);


                                            }
                                    );

                                }
                        );
                    }

                    $scope.ProjectionDS.fltTotal = 0;
                    $scope.ProjectionDS.fltTotalDisc = 0;
                    $scope.Projection2D.fltTotal = 0;
                    $scope.Projection2D.fltTotalDisc = 0;
                    $scope.ProjectionA12.fltTotal = 0;
                    $scope.ProjectionA12.fltTotalDisc = 0;
                    if ($scope.ConvenioDS.intTotalQ > 0){
                        j$.each(
                            $scope.Convenio.listRange
                            , function (keyRange, strRange) {
                                if($scope.Wrapper.mapTarifarioEXP && $scope.Wrapper.mapTarifarioEXP['DS'] && $scope.Wrapper.mapTarifarioEXP['DS'][strRange]){

                                    $scope.ConvenioDS.ranges[keyRange].fltAmount = $scope.Wrapper.mapTarifarioEXP['DS'][strRange].GuiaDeArranque1Kg__c * $scope.ConvenioDS.ranges[keyRange].intFrecuency;

                                    $scope.ConvenioDS.ranges[keyRange].fltAditionalKg = $scope.Wrapper.mapTarifarioEXP['DS'][strRange].Kg_adicional__c * $scope.ConvenioDS.ranges[keyRange].intFrecuency * ($scope.ConvenioDS.ranges[keyRange].fltDominantWeight -1);

                                    if($scope.Convenio.blnSEG)
                                        $scope.ProjectionDS.ranges[keyRange].fltTotalSEG = ($scope.ConvenioDS.ranges[keyRange].intFrecuency * $scope.Convenio.fltSEG) * ($scope.Wrapper.mapCS['SEG'] / 1000);
                                    else
                                        $scope.ProjectionDS.ranges[keyRange].fltTotalSEG = 0;

                                    if($scope.Convenio.blnACK)
                                        $scope.ProjectionDS.ranges[keyRange].fltTotalACK = ($scope.ConvenioDS.ranges[keyRange].intFrecuency / $scope.Convenio.promPackByDeslivery) *  $scope.Wrapper.mapACK[$scope.Convenio.strACK] * ($scope.Convenio.promDeliveryACK /100);
                                    else
                                        $scope.ProjectionDS.ranges[keyRange].fltTotalACK = 0;

                                    $scope.ProjectionDS.ranges[keyRange].fltTotal       =  $scope.ConvenioDS.ranges[keyRange].fltAmount
                                                                                        + $scope.ConvenioDS.ranges[keyRange].fltAditionalKg
                                                                                        + $scope.ProjectionDS.ranges[keyRange].fltTotalSEG
                                                                                        + $scope.ProjectionDS.ranges[keyRange].fltTotalACK;

                                    $scope.ProjectionDS.ranges[keyRange].fltTotalDisc       =  $scope.desc($scope.ConvenioDS.ranges[keyRange].fltAmount, $scope.ConvenioDS.fltDisc)
                                                                                            + $scope.desc($scope.ConvenioDS.ranges[keyRange].fltAditionalKg, $scope.ConvenioDS.fltDisc)
                                                                                            + $scope.desc($scope.ProjectionDS.ranges[keyRange].fltTotalSEG, $scope.Convenio.fltDiscSEG)
                                                                                            + $scope.desc($scope.ProjectionDS.ranges[keyRange].fltTotalACK, $scope.Convenio.fltDiscACK);

                                    $scope.ProjectionDS.fltTotal        += $scope.ProjectionDS.ranges[keyRange].fltTotal;
                                    $scope.ProjectionDS.fltTotalDisc    += $scope.ProjectionDS.ranges[keyRange].fltTotalDisc;
                                }
                            }
                        );
                    }

                    if ($scope.Convenio2D.intTotalQ > 0){

                        j$.each(
                                $scope.Convenio.listRange
                                , function (keyRange, strRange) {
                                    if($scope.Wrapper.mapTarifarioEXP && $scope.Wrapper.mapTarifarioEXP['2D'] && $scope.Wrapper.mapTarifarioEXP['2D'][strRange]){

                                        $scope.Convenio2D.ranges[keyRange].fltAmount = $scope.Wrapper.mapTarifarioEXP['2D'][strRange].GuiaDeArranque1Kg__c * $scope.Convenio2D.ranges[keyRange].intFrecuency;

                                        $scope.Convenio2D.ranges[keyRange].fltAditionalKg = $scope.Wrapper.mapTarifarioEXP['2D'][strRange].Kg_adicional__c * $scope.Convenio2D.ranges[keyRange].intFrecuency * ($scope.Convenio2D.ranges[keyRange].fltDominantWeight -1);

                                        if($scope.Convenio.blnSEG)
                                            $scope.Projection2D.ranges[keyRange].fltTotalSEG = ($scope.Convenio2D.ranges[keyRange].intFrecuency * $scope.Convenio.fltSEG) * ($scope.Wrapper.mapCS['SEG'] / 1000);
                                        else
                                            $scope.Projection2D.ranges[keyRange].fltTotalSEG = 0;

                                        if($scope.Convenio.blnACK)
                                            $scope.Projection2D.ranges[keyRange].fltTotalACK = ($scope.Convenio2D.ranges[keyRange].intFrecuency / $scope.Convenio.promPackByDeslivery) *  $scope.Wrapper.mapACK[$scope.Convenio.strACK] * ($scope.Convenio.promDeliveryACK /100);
                                        else
                                            $scope.Projection2D.ranges[keyRange].fltTotalACK = 0;

                                        $scope.Projection2D.ranges[keyRange].fltTotal       =  $scope.Convenio2D.ranges[keyRange].fltAmount
                                                + $scope.Convenio2D.ranges[keyRange].fltAditionalKg
                                                + $scope.Projection2D.ranges[keyRange].fltTotalSEG
                                                + $scope.Projection2D.ranges[keyRange].fltTotalACK;

                                        $scope.Projection2D.ranges[keyRange].fltTotalDisc       =  $scope.desc($scope.Convenio2D.ranges[keyRange].fltAmount, $scope.Convenio2D.fltDisc)
                                                + $scope.desc($scope.Convenio2D.ranges[keyRange].fltAditionalKg, $scope.Convenio2D.fltDisc)
                                                + $scope.desc($scope.Projection2D.ranges[keyRange].fltTotalSEG, $scope.Convenio.fltDiscSEG)
                                                + $scope.desc($scope.Projection2D.ranges[keyRange].fltTotalACK, $scope.Convenio.fltDiscACK);

                                        $scope.Projection2D.fltTotal        += $scope.Projection2D.ranges[keyRange].fltTotal;
                                        $scope.Projection2D.fltTotalDisc    += $scope.Projection2D.ranges[keyRange].fltTotalDisc;
                                    }
                                }
                        );
                    }

                    if ($scope.ConvenioA12.intTotalQ > 0){

                        j$.each(
                                $scope.Convenio.listRange
                                , function (keyRange, strRange) {
                                    if($scope.Wrapper.mapTarifarioEXP && $scope.Wrapper.mapTarifarioEXP['A12'] && $scope.Wrapper.mapTarifarioEXP['A12'][strRange]){

                                        $scope.ConvenioA12.ranges[keyRange].fltAmount = $scope.Wrapper.mapTarifarioEXP['A12'][strRange].GuiaDeArranque1Kg__c * $scope.ConvenioA12.ranges[keyRange].intFrecuency;

                                        $scope.ConvenioA12.ranges[keyRange].fltAditionalKg = $scope.Wrapper.mapTarifarioEXP['A12'][strRange].Kg_adicional__c * $scope.ConvenioA12.ranges[keyRange].intFrecuency * ($scope.ConvenioA12.ranges[keyRange].fltDominantWeight -1);

                                        if($scope.Convenio.blnSEG)
                                            $scope.ProjectionA12.ranges[keyRange].fltTotalSEG = ($scope.ConvenioA12.ranges[keyRange].intFrecuency * $scope.Convenio.fltSEG) * ($scope.Wrapper.mapCS['SEG'] / 1000);
                                        else
                                            $scope.ProjectionA12.ranges[keyRange].fltTotalSEG = 0;

                                        if($scope.Convenio.blnACK)
                                            $scope.ProjectionA12.ranges[keyRange].fltTotalACK = ($scope.ConvenioA12.ranges[keyRange].intFrecuency / $scope.Convenio.promPackByDeslivery) *  $scope.Wrapper.mapACK[$scope.Convenio.strACK] * ($scope.Convenio.promDeliveryACK /100);
                                        else
                                            $scope.ProjectionA12.ranges[keyRange].fltTotalACK = 0;

                                        $scope.ProjectionA12.ranges[keyRange].fltTotal       =  $scope.ConvenioA12.ranges[keyRange].fltAmount
                                                + $scope.ConvenioA12.ranges[keyRange].fltAditionalKg
                                                + $scope.ProjectionA12.ranges[keyRange].fltTotalSEG
                                                + $scope.ProjectionA12.ranges[keyRange].fltTotalACK;

                                        $scope.ProjectionA12.ranges[keyRange].fltTotalDisc       =  $scope.desc($scope.ConvenioA12.ranges[keyRange].fltAmount, $scope.ConvenioA12.fltDisc)
                                                + $scope.desc($scope.ConvenioA12.ranges[keyRange].fltAditionalKg, $scope.ConvenioA12.fltDisc)
                                                + $scope.desc($scope.ProjectionA12.ranges[keyRange].fltTotalSEG, $scope.Convenio.fltDiscSEG)
                                                + $scope.desc($scope.ProjectionA12.ranges[keyRange].fltTotalACK, $scope.Convenio.fltDiscACK);

                                        $scope.ProjectionA12.fltTotal        += $scope.ProjectionA12.ranges[keyRange].fltTotal;
                                        $scope.ProjectionA12.fltTotalDisc    += $scope.ProjectionA12.ranges[keyRange].fltTotalDisc;
                                    }
                                }
                        );
                    }

                    $scope.calculateConvDomServ();
                };

                $scope.calculateQuote = function() {
                    if ($scope.Convenio.intTotalQ >= 0){
                        j$.each($scope.Convenio.mapTotal
                                , function (keyRange, objRangeTotal) {
                                    objRangeTotal.intRanTotal = $scope.Convenio.intTotalQ * objRangeTotal.fltRanTotalFrec;
                                }
                        );
                        j$.each($scope.Convenio.mapQuotes
                                , function (keyFee, quoteByFee) {
                                    quoteByFee.intFeeTotalQ = $scope.Convenio.intTotalQ * quoteByFee.fltFeeTotalFrec;
                                }
                        );

                        j$.each($scope.Convenio.listFee
                                , function (keyFee, strFee) {

                                    j$.each($scope.Convenio.listRange
                                            , function (keyRange, strRange) {
                                                $scope.Convenio.mapQuotes[keyFee].ranges[keyRange].intFrecuency = Math.round($scope.Convenio.mapTotal[keyRange].fltRanTotalFrec * $scope.Convenio.mapQuotes[keyFee].intFeeTotalQ);
                                            }
                                    );

                                }
                        );
                    }
                    if ($scope.ConvenioZP.intTotalQ >= 0){
                        j$.each($scope.ConvenioZP.mapTotal
                                , function (keyRange, objRangeTotal) {
                                    objRangeTotal.intRanTotal = $scope.ConvenioZP.intTotalQ * (objRangeTotal.fltRanTotalFrec);
                                }
                        );
                        j$.each($scope.ConvenioZP.mapQuotes
                                , function (keyFee, quoteByFee) {
                                    quoteByFee.intFeeTotalQ = $scope.ConvenioZP.intTotalQ * (quoteByFee.fltFeeTotalFrec);
                                }
                        );
                        j$.each($scope.Convenio.listFee
                                , function (keyFee, strFee) {
                                    j$.each($scope.Convenio.listRange
                                            , function (keyRange, strRange) {
                                                if(keyFee !== 'T7')
                                                    $scope.ConvenioZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency = Math.round($scope.ConvenioZP.mapTotal[keyRange].fltRanTotalFrec * $scope.ConvenioZP.mapQuotes[keyFee].intFeeTotalQ);
                                            }
                                    );
                                }
                        );
                    }
                    $scope.calculateConvACK();
                };

                $scope.calculateXY = function(strType){
                    switch (strType) {
                        case 'ZP':
                            $scope.resetConvenio('ZP');
                            j$.each($scope.Convenio.listFee
                                    , function (keyFee, strFee) {
                                        j$.each($scope.Convenio.listRange
                                                , function (keyRange, strRange) {
                                                    $scope.ConvenioZP.intTotalQ += $scope.ConvenioZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                    if($scope.ConvenioZP.intTotalQ > 0){
                                                        $scope.ConvenioZP.mapTotal[keyRange].intRanTotal += $scope.ConvenioZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                        $scope.ConvenioZP.mapQuotes[keyFee].intFeeTotalQ  += $scope.ConvenioZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                    }
                                                }
                                        );
                                    }
                            );
                            j$.each($scope.Convenio.listFee
                                    , function (keyFee, strFee) {
                                        $scope.ConvenioZP.mapQuotes[keyFee].fltFeeTotalFrec = $scope.ConvenioZP.mapQuotes[keyFee].intFeeTotalQ / $scope.ConvenioZP.intTotalQ;
                                        j$.each($scope.Convenio.listRange
                                                , function (keyRange, strRange) {
                                                    if($scope.Convenio.intTotalQ > 0)
                                                        $scope.ConvenioZP.mapTotal[keyRange].fltRanTotalFrec = $scope.ConvenioZP.mapTotal[keyRange].intRanTotal/ $scope.ConvenioZP.intTotalQ;
                                                }
                                        );
                                    }
                            );
                            break;
                        default:
                            $scope.resetConvenio();
                            j$.each($scope.Convenio.listFee
                                    , function (keyFee, strFee) {
                                        j$.each($scope.Convenio.listRange
                                                , function (keyRange, strRange) {
                                                    $scope.Convenio.intTotalQ += $scope.Convenio.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                    if($scope.Convenio.intTotalQ > 0){
                                                        $scope.Convenio.mapTotal[keyRange].intRanTotal += $scope.Convenio.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                        $scope.Convenio.mapQuotes[keyFee].intFeeTotalQ  +=$scope.Convenio.mapQuotes[keyFee].ranges[keyRange].intFrecuency;
                                                    }
                                                }
                                        );
                                    }
                            );
                            j$.each($scope.Convenio.listFee
                                    , function (keyFee, strFee) {
                                        $scope.Convenio.mapQuotes[keyFee].fltFeeTotalFrec = $scope.Convenio.mapQuotes[keyFee].intFeeTotalQ / $scope.Convenio.intTotalQ;
                                        j$.each($scope.Convenio.listRange
                                                , function (keyRange, strRange) {
                                                    if($scope.Convenio.intTotalQ > 0)
                                                        $scope.Convenio.mapTotal[keyRange].fltRanTotalFrec = $scope.Convenio.mapTotal[keyRange].intRanTotal/ $scope.Convenio.intTotalQ;
                                                }
                                        );
                                    }
                            );
                            break;
                    }
                    $scope.calculateConvACK();
                };

                $scope.createQuotes = function(){
                    var listDelete = [];
                    var listQuoteItem = [];
                    $scope.Convenio.blnZP = false;
                    var Quote = {
                        Acuse__c: $scope.Convenio.strACK
                        , SBQQ__Primary__c : true
                        , Modelo_de_tarifas__c : 'Tarifario abierto de piso'
                        , Tipo_de_documentacion__c :'En Piso-Sipweb'
                        , TipoCotizacion__c : 'Por convenio'
                        , Descuento_Global__c : $scope.ProjectionSumary['GlobalSTD'] * - 100
                        , Descuento_Global_Express__c : $scope.ProjectionSumary['GlobalSEG'] * - 100
                        , PAQ_DescuentoGlobal__c: $scope.ProjectionSumary['GlobalDisc'] * - 100
                        , Ingreso_Mensual__c : $scope.ProjectionSumary['TotalDisc']
                        , TarifaLlenaMensual__c: $scope.ProjectionSumary['Total']
                        , Paquetes_Mensuales__c : $scope.Convenio.intTotalQ + $scope.ConvenioZP.intTotalQ + $scope.ConvenioDS.intTotalQ + $scope.Convenio2D.intTotalQ + $scope.ConvenioA12.intTotalQ
                        , AVRDeliveryACK__c : $scope.Convenio.promDeliveryACK
                        , AVRPackByDelivery__c : $scope.Convenio.promPackByDeslivery
                        , Gerente_de_sucursal_aprobacion__c : $scope.Managers['GSU']
                        , KAM_aprobacion__c : $scope.Managers['KAM']
                        , Gerente_desarrollo_aprobacion__c : $scope.Managers['GDS']
                        , Director_comercial_aprobacion__c : $scope.Managers['DCO']
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

                    Quote.Servicios_adicionales__c = "";
                    if($scope.Convenio.blnRAD)
                        Quote.Servicios_adicionales__c = "RAD;";
                    if($scope.Convenio.blnEAD)
                        Quote.Servicios_adicionales__c += "EAD;";
                    if($scope.Convenio.blnSEG)
                        Quote.Servicios_adicionales__c += "Seguro;";
                    if($scope.Convenio.blnACK)
                        Quote.Servicios_adicionales__c += "Acuse " + $scope.Convenio.strACK;
                    var serviceDiscount = 0;
                    var serviceDiscountEXP = 0;
                    var arrayTarifas = '';

                    if($scope.Convenio.intTotalQ > 0 || $scope.ConvenioZP.intTotalQ > 0){
                        Quote.PAQ_TipoServicio__c = 'Estándar terrestre (STD)';
                        j$.each(
                                $scope.Convenio.listFee
                                , function (keyFee, strFee) {
                                    j$.each($scope.Convenio.listRange
                                            , function(keyRange, strRange){
                                                if ($scope.Convenio.mapQuotes[keyFee].ranges[keyRange].intFrecuency > 0) {
                                                    var QuoteItem = {
                                                        SBQQ__Quantity__c : Math.round($scope.Convenio.mapQuotes[keyFee].ranges[keyRange].intFrecuency)
                                                        , SBQQ__CustomerPrice__c : $scope.desc($scope.Projection[keyFee].ranges[keyRange].fltAmount /  $scope.Convenio.mapQuotes[keyFee].ranges[keyRange].intFrecuency, $scope.ProjectionDisc['fltGlobalDisc'] * -100)
                                                        , SBQQ__NetPrice__c :  $scope.Projection[keyFee].ranges[keyRange].fltAmount /  $scope.Convenio.mapQuotes[keyFee].ranges[keyRange].intFrecuency
                                                        , PackWeightAVG__c : $scope.Convenio.mapTotal[keyRange].fltWeightAVR
                                                        , PackVolAVG__c : $scope.Convenio.mapTotal[keyRange].fltVolAVR
                                                        , Pack_Seg__c : $scope.Convenio.fltSEG
                                                        , DiscountAcuse__c : $scope.Convenio.fltDiscACK
                                                        , DiscountRecolection__c : $scope.Convenio.fltDiscRAD
                                                        , DiscountDelivery__c : $scope.Convenio.fltDiscEAD
                                                        //, DiscountSeg__c : $scope.Convenio.fltDiscSEG
                                                        , SEG__c : $scope.Convenio.mapQuotes[keyFee].ranges[keyRange].fltSegAmount
                                                        , QuoteSub__c : $scope.Projection[keyFee].ranges[keyRange].fltAmount
                                                        , QuoteIVA__c : $scope.Projection[keyFee].ranges[keyRange].fltAmount * ($scope.Wrapper.mapCS['IVA']/100)
                                                        , QuoteTotal__c : $scope.desc($scope.Projection[keyFee].ranges[keyRange].fltAmount, 0-$scope.Wrapper.mapCS['IVA'])
                                                        , Tarifa__c : strFee
                                                        , Rango_KM__c : strRange
                                                        , SBQQ__Quote__c: Quote.Id
                                                        , Id: $scope.Convenio.mapQuotes[keyFee].ranges[keyRange].Id
                                                    };

                                                    if(keyFee==='TS')
                                                        QuoteItem.DiscountFlete__c = $scope.Convenio.fltDiscSobre;
                                                    else
                                                        QuoteItem.DiscountFlete__c = $scope.Convenio.fltDiscPack;

                                                    if (!arrayTarifas.includes(strFee))
                                                        arrayTarifas += strFee + ' ,';

                                                    listQuoteItem.push(QuoteItem);
                                                }
                                                else if($scope.Convenio.mapQuotes[keyFee].ranges[keyRange].intFrecuency === 0 && $scope.Convenio.mapQuotes[keyFee].ranges[keyRange].Id)
                                                    listDelete.push($scope.Convenio.mapQuotes[keyFee].ranges[keyRange].Id);

                                                if ($scope.ConvenioZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency > 0) {
                                                    $scope.Convenio.blnZP = true;
                                                    var QuoteItemZP = {
                                                        SBQQ__Quantity__c : Math.round($scope.ConvenioZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency)
                                                        , SBQQ__CustomerPrice__c : $scope.desc($scope.ProjectionZP[keyFee].ranges[keyRange].fltAmount /  $scope.ConvenioZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency, $scope.ProjectionDisc['fltGlobalDisc'] * -100)
                                                        , SBQQ__NetPrice__c :  $scope.ProjectionZP[keyFee].ranges[keyRange].fltAmount /  $scope.ConvenioZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency
                                                        , Pack_Seg__c : $scope.Convenio.fltSEG
                                                        , DiscountAcuse__c : $scope.Convenio.fltDiscACK
                                                        , DiscountRecolection__c : $scope.Convenio.fltDiscRAD
                                                        , DiscountDelivery__c : $scope.Convenio.fltDiscZP
                                                        //, DiscountSeg__c : $scope.Convenio.fltDiscSEG
                                                        , SEG__c : $scope.ConvenioZP.mapQuotes[keyFee].ranges[keyRange].fltSegAmount
                                                        , QuoteSub__c : $scope.ProjectionZP[keyFee].ranges[keyRange].fltAmount
                                                        , QuoteIVA__c : $scope.ProjectionZP[keyFee].ranges[keyRange].fltAmount * ($scope.Wrapper.mapCS['IVA']/100)
                                                        , QuoteTotal__c : $scope.desc($scope.ProjectionZP[keyFee].ranges[keyRange].fltAmount, 0-$scope.Wrapper.mapCS['IVA'])
                                                        , Tarifa__c : strFee
                                                        , Rango_KM__c : strRange
                                                        , ZonaPlus__c : true
                                                        , SBQQ__Quote__c: Quote.Id
                                                        , Id : $scope.ConvenioZP.mapQuotes[keyFee].ranges[keyRange].Id
                                                    };


                                                    if(keyFee==='TS')
                                                        QuoteItemZP.DiscountFlete__c = $scope.Convenio.fltDiscSobre;
                                                    else
                                                        QuoteItemZP.DiscountFlete__c = $scope.Convenio.fltDiscPack;

                                                    listQuoteItem.push(QuoteItemZP);


                                                }
                                                else if($scope.ConvenioZP.mapQuotes[keyFee].ranges[keyRange].intFrecuency === 0 && $scope.ConvenioZP.mapQuotes[keyFee].ranges[keyRange].Id)
                                                    listDelete.push($scope.ConvenioZP.mapQuotes[keyFee].ranges[keyRange].Id);


                                                if($scope.Convenio.mapQuotes['T7'].ranges[keyRange].intFrecuency > 0 )
                                                    Quote.Tarifa_7__c = true;

                                                if($scope.Convenio.fltDiscSobre > serviceDiscount)
                                                    serviceDiscount = $scope.Convenio.fltDiscSobre;

                                                if($scope.Convenio.fltDiscPack > serviceDiscount)
                                                    serviceDiscount = $scope.Convenio.fltDiscPack;

                                                if($scope.Convenio.fltDiscRAD > serviceDiscount)
                                                    serviceDiscount = $scope.Convenio.fltDiscRAD;

                                                if($scope.Convenio.fltDiscEAD > serviceDiscount)
                                                    serviceDiscount = $scope.Convenio.fltDiscEAD;

                                                if($scope.Convenio.fltDiscZP > serviceDiscount)
                                                    serviceDiscount = $scope.Convenio.fltDiscZP;

                                                if($scope.Convenio.fltDiscACK > serviceDiscount)
                                                    serviceDiscount = $scope.Convenio.fltDiscACK;

                                                if($scope.Convenio.fltDiscSEG > serviceDiscount)
                                                    serviceDiscount = $scope.Convenio.fltDiscSEG;

                                                if (!arrayTarifas.includes(strFee))
                                                    arrayTarifas += strFee + ' ,';
                                            }
                                    );
                                }
                        );

                        /*if($scope.Convenio.fltDiscSobre > $scope.Convenio.fltDiscPack)
                            Quote.Descuento_por_linea_o_rangokm__c =  $scope.Convenio.fltDiscSobre;
                        else
                            Quote.Descuento_por_linea_o_rangokm__c =  $scope.Convenio.fltDiscPack;*/

                    }
                    if($scope.Convenio.blnZP)
                        Quote.Servicios_adicionales__c += ";EAD Zona plus";
                    Quote.Descuento_maximo_de_servicios__c = serviceDiscount;

                    if($scope.ConvenioDS.intTotalQ > 0 || $scope.Convenio2D.intTotalQ > 0 || $scope.ConvenioA12.intTotalQ > 0){
                        if(Quote.PAQ_TipoServicio__c == 'Estándar terrestre (STD)')
                            Quote.PAQ_TipoServicio__c += '; Servicio Express Garantizado (SEG)';
                        else
                            Quote.PAQ_TipoServicio__c = 'Servicio Express Garantizado (SEG)';
                        j$.each($scope.Convenio.listRange
                                , function(keyRange, strRange){

                                    if($scope.ConvenioDS.intTotalQ > 0){
                                        if($scope.ConvenioDS.ranges[keyRange].intFrecuency){
                                            var QuoteItem = {
                                                SBQQ__Quantity__c : Math.round($scope.ConvenioDS.ranges[keyRange].intFrecuency)
                                                , SBQQ__CustomerPrice__c : $scope.ProjectionDS.ranges[keyRange].fltTotalDisc / Math.round($scope.ConvenioDS.ranges[keyRange].intFrecuency)
                                                , SBQQ__NetPrice__c : $scope.ProjectionDS.ranges[keyRange].fltTotal / Math.round($scope.ConvenioDS.ranges[keyRange].intFrecuency)
                                                , SBQQ__Discount__c : $scope.ConvenioDS.fltDisc
                                                , PackWeightAVG__c : $scope.ConvenioDS.ranges[keyRange].fltWeight
                                                , PackVolAVG__c : $scope.ConvenioDS.ranges[keyRange].fltVol
                                                , Weight__c :  $scope.ConvenioDS.ranges[keyRange].fltWeight
                                                , Large__c :  $scope.ConvenioDS.ranges[keyRange].fltLarge
                                                , High__c :  $scope.ConvenioDS.ranges[keyRange].fltWidth
                                                , Width__c :  $scope.ConvenioDS.ranges[keyRange].fltHigh
                                                , VolWeight__c : $scope.ConvenioDS.ranges[keyRange].fltVolWeight
                                                , Pack_Seg__c : $scope.Convenio.fltSEG
                                                , DiscountAcuse__c : $scope.Convenio.fltDiscACK
                                                , DiscountSeg__c : $scope.Convenio.fltDiscSEG
                                                , ACK__c : $scope.desc($scope.ProjectionDS.ranges[keyRange].fltTotalACK, $scope.Convenio.fltDiscACK)
                                                , SEG__c :  $scope.desc($scope.ProjectionDS.ranges[keyRange].fltTotalSEG, $scope.Convenio.fltDiscSEG)
                                                , QuoteTotal__c : $scope.ProjectionDS.ranges[keyRange].fltTotalDisc
                                                , Tarifa__c : 'SEG-DS'
                                                , Rango_KM__c : strRange
                                                , SBQQ__Quote__c: Quote.Id
                                                , Id : $scope.ConvenioDS.ranges[keyRange].Id
                                            };
                                            listQuoteItem.push(QuoteItem);
                                            if (!arrayTarifas.includes('SEG-DS'))
                                                arrayTarifas += 'SEG-DS' + ' ,';

                                            if($scope.Convenio.fltDiscACK > serviceDiscountEXP)
                                                serviceDiscountEXP = $scope.Convenio.fltDiscACK;

                                            if(serviceDiscountEXP < QuoteItem.SBQQ__Discount__c)
                                                serviceDiscountEXP = QuoteItem.SBQQ__Discount__c;
                                        }
                                        else if($scope.ConvenioDS.ranges[keyRange].intFrecuency === 0 && $scope.ConvenioDS.ranges[keyRange].Id)
                                            listDelete.push($scope.ConvenioDS.ranges[keyRange].Id);
                                    }

                                    if($scope.Convenio2D.intTotalQ > 0){
                                        if($scope.Convenio2D.ranges[keyRange].intFrecuency > 0){
                                            var QuoteItem = {
                                                SBQQ__Quantity__c : Math.round($scope.Convenio2D.ranges[keyRange].intFrecuency)
                                                , SBQQ__CustomerPrice__c : $scope.Projection2D.ranges[keyRange].fltTotalDisc / Math.round($scope.Convenio2D.ranges[keyRange].intFrecuency)
                                                , SBQQ__NetPrice__c : $scope.Projection2D.ranges[keyRange].fltTotal / Math.round($scope.Convenio2D.ranges[keyRange].intFrecuency)
                                                , SBQQ__Discount__c : $scope.Convenio2D.fltDisc
                                                , PackWeightAVG__c : $scope.Convenio2D.ranges[keyRange].fltWeight
                                                , PackVolAVG__c : $scope.Convenio2D.ranges[keyRange].fltVol
                                                , Weight__c :  $scope.Convenio2D.ranges[keyRange].fltWeight
                                                , Large__c :  $scope.Convenio2D.ranges[keyRange].fltLarge
                                                , High__c :  $scope.Convenio2D.ranges[keyRange].fltWidth
                                                , Width__c :  $scope.Convenio2D.ranges[keyRange].fltHigh
                                                , VolWeight__c : $scope.Convenio2D.ranges[keyRange].fltVolWeight
                                                , Pack_Seg__c : $scope.Convenio.fltSEG
                                                , DiscountAcuse__c : $scope.Convenio.fltDiscACK
                                                , DiscountSeg__c : $scope.Convenio.fltDiscSEG
                                                , ACK__c : $scope.desc($scope.Projection2D.ranges[keyRange].fltTotalACK, $scope.Convenio.fltDiscACK)
                                                , SEG__c :  $scope.desc($scope.Projection2D.ranges[keyRange].fltTotalSEG, $scope.Convenio.fltDiscSEG)
                                                , QuoteTotal__c : $scope.Projection2D.ranges[keyRange].fltTotalDisc
                                                , Tarifa__c : 'SEG-2D'
                                                , Rango_KM__c : strRange
                                                , SBQQ__Quote__c: Quote.Id
                                                , Id : $scope.Convenio2D.ranges[keyRange].Id
                                            };

                                            if (!arrayTarifas.includes('SEG-2D'))
                                                arrayTarifas += 'SEG-2D' + ' ,';

                                            listQuoteItem.push(QuoteItem);
                                            if($scope.Convenio.fltDiscACK > serviceDiscountEXP)
                                                serviceDiscountEXP = $scope.Convenio.fltDiscACK;

                                            if(serviceDiscountEXP < QuoteItem.SBQQ__Discount__c)
                                                serviceDiscountEXP = QuoteItem.SBQQ__Discount__c;
                                        }
                                        else if($scope.Convenio2D.ranges[keyRange].intFrecuency === 0 && $scope.Convenio2D.ranges[keyRange].Id)
                                            listDelete.push($scope.Convenio2D.ranges[keyRange].Id);

                                    }

                                    if($scope.ConvenioA12.intTotalQ > 0){
                                        if($scope.ConvenioA12.ranges[keyRange].intFrecuency > 0){
                                            var QuoteItem = {
                                                SBQQ__Quantity__c : Math.round($scope.ConvenioA12.ranges[keyRange].intFrecuency)
                                                , SBQQ__CustomerPrice__c : $scope.ProjectionA12.ranges[keyRange].fltTotalDisc / Math.round($scope.ConvenioA12.ranges[keyRange].intFrecuency)
                                                , SBQQ__NetPrice__c : $scope.ProjectionA12.ranges[keyRange].fltTotal / Math.round($scope.ConvenioA12.ranges[keyRange].intFrecuency)
                                                , SBQQ__Discount__c : $scope.ConvenioA12.fltDisc
                                                , PackWeightAVG__c : $scope.ConvenioA12.ranges[keyRange].fltWeight
                                                , PackVolAVG__c : $scope.ConvenioA12.ranges[keyRange].fltVol
                                                , Weight__c :  $scope.ConvenioA12.ranges[keyRange].fltWeight
                                                , Large__c :  $scope.ConvenioA12.ranges[keyRange].fltLarge
                                                , High__c :  $scope.ConvenioA12.ranges[keyRange].fltWidth
                                                , Width__c :  $scope.ConvenioA12.ranges[keyRange].fltHigh
                                                , VolWeight__c : $scope.ConvenioA12.ranges[keyRange].fltVolWeight
                                                , Pack_Seg__c : $scope.Convenio.fltSEG
                                                , DiscountAcuse__c : $scope.Convenio.fltDiscACK
                                                , DiscountSeg__c : $scope.Convenio.fltDiscSEG
                                                , ACK__c : $scope.desc($scope.ProjectionA12.ranges[keyRange].fltTotalACK, $scope.Convenio.fltDiscACK)
                                                , SEG__c :  $scope.desc($scope.ProjectionA12.ranges[keyRange].fltTotalSEG, $scope.Convenio.fltDiscSEG)
                                                , QuoteTotal__c : $scope.ProjectionA12.ranges[keyRange].fltTotalDisc
                                                , Tarifa__c : 'SEG-A12'
                                                , Rango_KM__c : strRange
                                                , SBQQ__Quote__c: Quote.Id
                                                , Id : $scope.ConvenioA12.ranges[keyRange].Id
                                            };

                                            if (!arrayTarifas.includes('SEG-A12'))
                                                arrayTarifas += 'SEG-A12' + ' ,';

                                            listQuoteItem.push(QuoteItem);

                                            if($scope.Convenio.fltDiscACK > serviceDiscountEXP)
                                                serviceDiscountEXP = $scope.Convenio.fltDiscACK;

                                            if(serviceDiscountEXP < QuoteItem.SBQQ__Discount__c)
                                                serviceDiscountEXP = QuoteItem.SBQQ__Discount__c;
                                        }
                                        else if($scope.ConvenioA12.ranges[keyRange].intFrecuency === 0 && $scope.ConvenioA12.ranges[keyRange].Id)
                                            listDelete.push($scope.ConvenioA12.ranges[keyRange].Id);
                                    }

                                    if($scope.Convenio.fltDiscACK > serviceDiscountEXP)
                                        serviceDiscountEXP = $scope.Convenio.fltDiscACK;

                                    if($scope.Convenio.fltDiscSEG > serviceDiscountEXP)
                                        serviceDiscountEXP = $scope.Convenio.fltDiscSEG;

                                }
                        );
                    }
                    else {
                        j$.each($scope.Convenio.listRange
                                , function(keyRange, strRange){
                                    if($scope.ConvenioDS.ranges[keyRange].Id)
                                        listDelete.push($scope.ConvenioDS.ranges[keyRange].Id);
                                    if($scope.Convenio2D.ranges[keyRange].Id)
                                        listDelete.push($scope.Convenio2D.ranges[keyRange].Id);
                                    if($scope.ConvenioA12.ranges[keyRange].Id)
                                        listDelete.push($scope.ConvenioA12.ranges[keyRange].Id);
                                }
                        );
                    }

                    Quote.Descuento_M_ximo_por_Servicios_Express__c = serviceDiscountEXP;

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

                $scope.copy = function(a, b){
                    var idB;
                    idB = b.Id;
                    b = Object.assign(b, a);
                    b.Id = idB;
                    return b
                };

                $scope.desc = function(fltNum, descNum){
                    return fltNum - ((fltNum * descNum) / 100);
                };

                $scope.exceptionAD = function(strFeeKey){
                    return strFeeKey === 'TS';
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

                $scope.isException = function(objQuote, strProfile){
                    var exception = false;
                    if(objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')) {
                            if (objQuote.SBQQ__Opportunity2__c && strProfile === 'Ejecutivo de venta') {
                                if (objQuote.Descuento_maximo_de_servicios__c <= 10)
                                    exception = true;
                            } else if (strProfile === 'Gerente de sucursal') {
                                if (objQuote.Descuento_maximo_de_servicios__c <= 25)
                                    exception = true;
                            } else if (strProfile === 'KAM Regional') {
                                if (objQuote.Descuento_maximo_de_servicios__c <= 40)
                                    exception = true;
                            } else if (strProfile === 'Gerentes de desarrollo de Negocios') {
                                if (objQuote.Descuento_maximo_de_servicios__c <= 60)
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
                                if (objQuote.Descuento_M_ximo_por_Servicios_Express__c <= 10)
                                    exception = true;
                            } else if (strProfile === 'Gerente de sucursal') {
                                if (objQuote.Descuento_M_ximo_por_Servicios_Express__c <= 25)
                                    exception = true;
                            } else if (strProfile === 'KAM Regional') {
                                if (objQuote.Descuento_M_ximo_por_Servicios_Express__c <= 25)
                                    exception = true;
                            } else if (strProfile === 'Gerentes de desarrollo de Negocios') {
                                if (objQuote.Descuento_M_ximo_por_Servicios_Express__c <= 25)
                                    exception = true;
                            } else if (strProfile === 'Director comercial') {
                                exception = true;
                            }
                    }
                    return exception;
                };

                $scope.nextStep = function(strStep){
                    switch (strStep) {
                        case 'one':
                            $scope.step1 = false;
                            $scope.step2 = true;
                            $scope.calculateConvACK();
                            break;
                        case 'two':
                            $scope.step2 = false;
                            $scope.step3 = true;
                            break;
                    }

                };

                $scope.previousStep = function(strStep){
                    switch (strStep) {
                        case 'two':
                            $scope.step1 = true;
                            $scope.step2 = false;
                            break;
                        case 'three':
                            $scope.step2 = true;
                            $scope.step3 = false;
                            break;
                    }

                };

                $scope.replicateDimensionsAVR = function(){
                    j$.each(
                            $scope.Convenio.mapTotal,
                            function(keyRange, total){
                                if($scope.Convenio.blnSameVol)
                                    total.fltVolAVR = $scope.Convenio.mapTotal['0-400'].fltVolAVR;

                                if($scope.Convenio.blnSameWeight)
                                    total.fltWeightAVR = $scope.Convenio.mapTotal['0-400'].fltWeightAVR;

                            }
                    );

                };

                $scope.replicate = function(field, fee){
                    switch (field) {
                        case 'fltWeight':
                            var fltWeight = 0;
                            if($scope.ConvenioDS.blnSameWeight || $scope.Convenio2D.blnSameWeight || $scope.ConvenioA12.blnSameWeight)
                                j$.each($scope.Convenio.listRange
                                    , function (keyRange, strRange) {
                                        if(fee === 'DS' && fltWeight == 0)
                                            fltWeight = $scope.ConvenioDS.ranges[keyRange].fltWeight;
                                        else if(fee === 'DS')
                                            $scope.ConvenioDS.ranges[keyRange].fltWeight = fltWeight;

                                        if(fee === '2D' && fltWeight == 0)
                                            fltWeight = $scope.Convenio2D.ranges[keyRange].fltWeight;
                                        else if(fee === '2D')
                                            $scope.Convenio2D.ranges[keyRange].fltWeight = fltWeight;

                                        if(fee === 'A12' && fltWeight == 0)
                                            fltWeight = $scope.ConvenioA12.ranges[keyRange].fltWeight;
                                        else if(fee === 'A12')
                                            $scope.ConvenioA12.ranges[keyRange].fltWeight = fltWeight;

                                        $scope.calculateDimensions(fee, keyRange);
                                    }
                                );

                            break;
                        case 'fltLarge':
                            var fltLarge = 0;
                            if($scope.ConvenioDS.blnSameLarge || $scope.Convenio2D.blnSameLarge || $scope.ConvenioA12.blnSameLarge)
                                j$.each($scope.Convenio.listRange
                                        , function (keyRange, strRange) {
                                            if(fee === 'DS' && fltLarge == 0)
                                                fltLarge = $scope.ConvenioDS.ranges[keyRange].fltLarge;
                                            else if(fee === 'DS')
                                                $scope.ConvenioDS.ranges[keyRange].fltLarge = fltLarge;

                                            if(fee === '2D' && fltLarge == 0)
                                                fltLarge = $scope.Convenio2D.ranges[keyRange].fltLarge;
                                            else if(fee === '2D')
                                                $scope.Convenio2D.ranges[keyRange].fltLarge = fltLarge;

                                            if(fee === 'A12' && fltLarge == 0)
                                                fltLarge = $scope.ConvenioA12.ranges[keyRange].fltLarge;
                                            else if(fee === 'A12')
                                                $scope.ConvenioA12.ranges[keyRange].fltLarge = fltLarge;

                                            $scope.calculateDimensions(fee, keyRange);
                                        }
                                );
                            break;
                        case 'fltWidth':
                            var fltWidth = 0;
                            if($scope.ConvenioDS.blnSameWidth || $scope.Convenio2D.blnSameWidth || $scope.ConvenioA12.blnSameWidth)
                                j$.each($scope.Convenio.listRange
                                        , function (keyRange, strRange) {
                                            if(fee === 'DS' && fltWidth == 0)
                                                fltWidth = $scope.ConvenioDS.ranges[keyRange].fltWidth;
                                            else if(fee === 'DS')
                                                $scope.ConvenioDS.ranges[keyRange].fltWidth = fltWidth;

                                            if(fee === '2D' && fltWidth == 0)
                                                fltWidth = $scope.Convenio2D.ranges[keyRange].fltWidth;
                                            else if(fee === '2D')
                                                $scope.Convenio2D.ranges[keyRange].fltWidth = fltWidth;

                                            if(fee === 'A12' && fltWidth == 0)
                                                fltWidth = $scope.ConvenioA12.ranges[keyRange].fltWidth;
                                            else if(fee === 'A12')
                                                $scope.ConvenioA12.ranges[keyRange].fltWidth = fltWidth;

                                            $scope.calculateDimensions(fee, keyRange);
                                        }
                                );
                            break;
                        case 'fltHigh':
                            var fltHigh = 0;
                            if($scope.ConvenioDS.blnSameHigh || $scope.Convenio2D.blnSameHigh || $scope.ConvenioA12.blnSameHigh)
                                j$.each($scope.Convenio.listRange
                                        , function (keyRange, strRange) {
                                            if(fee === 'DS' && fltHigh == 0)
                                                fltHigh = $scope.ConvenioDS.ranges[keyRange].fltHigh;
                                            else if(fee === 'DS')
                                                $scope.ConvenioDS.ranges[keyRange].fltHigh = fltHigh;

                                            if(fee === '2D' && fltHigh == 0)
                                                fltHigh = $scope.Convenio2D.ranges[keyRange].fltHigh;
                                            else if(fee === '2D')
                                                $scope.Convenio2D.ranges[keyRange].fltHigh = fltHigh;

                                            if(fee === 'A12' && fltHigh == 0)
                                                fltHigh = $scope.ConvenioA12.ranges[keyRange].fltHigh;
                                            else if(fee === 'A12')
                                                $scope.ConvenioA12.ranges[keyRange].fltHigh = fltHigh;

                                            $scope.calculateDimensions(fee, keyRange);
                                        }
                                );
                            break;
                    }
                };

                $scope.resetConvenio  = function(strName){
                    switch (strName) {
                        case 'ZP':
                            $scope.ConvenioZP.intTotalQ = 0;
                            j$.each($scope.Convenio.listRange
                                    , function (key, str) {
                                        $scope.ConvenioZP.mapTotal[key].intRanTotal = 0;
                                        $scope.ConvenioZP.mapTotal[key].fltRanTotalFrec = 0;
                                    });
                            j$.each($scope.Convenio.listFee
                                    , function (key, strKey) {
                                        $scope.ConvenioZP.mapQuotes[key].intFeeTotalQ = 0;
                                        $scope.ConvenioZP.mapQuotes[key].fltFeeTotalFrec = 0;
                                    });
                            break;
                        default:
                            $scope.Convenio.intTotalQ = 0;
                            j$.each($scope.Convenio.listRange
                                    , function (key, str) {
                                        $scope.Convenio.mapTotal[key].intRanTotal = 0;
                                        $scope.Convenio.mapTotal[key].fltRanTotalFrec = 0;
                                    });
                            j$.each($scope.Convenio.listFee
                                    , function (key, strKey) {
                                        $scope.Convenio.mapQuotes[key].intFeeTotalQ = 0;
                                        $scope.Convenio.mapQuotes[key].fltFeeTotalFrec = 0;
                                    });
                            break;
                    }


                };

                $scope.setValue = function(name, key, cmp, keyX, fee){
                    if (notEmpty(cmp.target.textContent))
                        switch (name) {
                            case 'intFrecuency':
                                $scope.Convenio.mapQuotes[keyX].ranges[key].intFrecuency = getNum(cmp.target.textContent);
                                $scope.calculateXY();
                                break;
                            case 'intFrecuencyZP':
                                $scope.ConvenioZP.mapQuotes[keyX].ranges[key].intFrecuency = getNum(cmp.target.textContent);
                                $scope.calculateXY('ZP');
                                break;
                            case 'FreqByRange':
                                $scope.Convenio.mapTotal[key].fltRanTotalFrec = getNumFromPercent(cmp.target.textContent);
                                $scope.calculateQuote();
                                break;
                            case 'TotalQ':
                                $scope.Convenio.intTotalQ = getNum(cmp.target.textContent);
                                $scope.calculateQuote();
                                break;
                            case 'FeeTotalFrec':
                                $scope.Convenio.mapQuotes[key].fltFeeTotalFrec = getNumFromPercent(cmp.target.textContent);
                                $scope.calculateQuote();
                                break;
                            case 'WeightAVR':
                                $scope.Convenio.mapTotal[key].fltWeightAVR = getNum(cmp.target.textContent);
                                $scope.calculateQuote();
                                break;
                            case 'VolAVR':
                                $scope.Convenio.mapTotal[key].fltVolAVR = getNum(cmp.target.textContent);
                                $scope.calculateQuote();
                                break;
                            case 'FreqByRangeZP':
                                $scope.ConvenioZP.mapTotal[key].fltRanTotalFrec = getNumFromPercent(cmp.target.textContent);
                                $scope.calculateQuote();
                                break;
                            case 'TotalQZP':
                                $scope.ConvenioZP.intTotalQ = getNum(cmp.target.textContent);
                                $scope.calculateQuote();
                                break;
                            case 'FeeTotalFrecZP':
                                $scope.ConvenioZP.mapQuotes[key].fltFeeTotalFrec = getNumFromPercent(cmp.target.textContent);
                                $scope.calculateQuote();
                                break;
                            case 'intTotalQ':
                                var intQTotal = getNum(cmp.target.textContent);
                                if(intQTotal > 0)
                                    $scope.calculateFreccEXP(fee, intQTotal);
                                else
                                    $scope.calculateFreccEXP(fee, null);
                                break;
                            case 'intFrecc':
                                if(fee === 'DS')
                                    $scope.ConvenioDS.ranges[key].intFrecuency = getNum(cmp.target.textContent);
                                if(fee === '2D')
                                    $scope.Convenio2D.ranges[key].intFrecuency = getNum(cmp.target.textContent);
                                if(fee === 'A12')
                                    $scope.ConvenioA12.ranges[key].intFrecuency = getNum(cmp.target.textContent);
                                $scope.calculateFreccEXP(fee, 0);
                                break;
                            case 'fltFrecc':
                                if(fee === 'DS') {
                                    $scope.ConvenioDS.ranges[key].fltFrecuency = getNumFromPercent(cmp.target.textContent);
                                    $scope.calculatePercentEXP(fee);
                                }
                                if(fee === '2D') {
                                    $scope.Convenio2D.ranges[key].fltFrecuency = getNumFromPercent(cmp.target.textContent);
                                    $scope.calculatePercentEXP(fee);
                                }
                                if(fee === 'A12') {
                                    $scope.ConvenioA12.ranges[key].fltFrecuency = getNumFromPercent(cmp.target.textContent);
                                    $scope.calculatePercentEXP(fee);
                                }
                                break;
                            case 'fltWeight':
                                if(fee === 'DS')
                                    $scope.ConvenioDS.ranges[key].fltWeight = getNum(cmp.target.textContent);
                                if(fee === '2D')
                                    $scope.Convenio2D.ranges[key].fltWeight = getNum(cmp.target.textContent);
                                if(fee === 'A12')
                                    $scope.ConvenioA12.ranges[key].fltWeight = getNum(cmp.target.textContent);
                                $scope.calculateDimensions(fee, key);
                                break;
                            case 'fltLarge':
                                if(fee === 'DS')
                                    $scope.ConvenioDS.ranges[key].fltLarge = getNum(cmp.target.textContent);
                                if(fee === '2D')
                                    $scope.Convenio2D.ranges[key].fltLarge = getNum(cmp.target.textContent);
                                if(fee === 'A12')
                                    $scope.ConvenioA12.ranges[key].fltLarge = getNum(cmp.target.textContent);
                                $scope.calculateDimensions(fee, key);
                                break;
                            case 'fltWidth':
                                if(fee === 'DS')
                                    $scope.ConvenioDS.ranges[key].fltWidth = getNum(cmp.target.textContent);
                                if(fee === '2D')
                                    $scope.Convenio2D.ranges[key].fltWidth = getNum(cmp.target.textContent);
                                if(fee === 'A12')
                                    $scope.ConvenioA12.ranges[key].fltWidth = getNum(cmp.target.textContent);
                                $scope.calculateDimensions(fee, key);
                                break;
                            case 'fltHigh':
                                if(fee === 'DS')
                                    $scope.ConvenioDS.ranges[key].fltHigh = getNum(cmp.target.textContent);
                                if(fee === '2D')
                                    $scope.Convenio2D.ranges[key].fltHigh = getNum(cmp.target.textContent);
                                if(fee === 'A12')
                                    $scope.ConvenioA12.ranges[key].fltHigh = getNum(cmp.target.textContent);
                                $scope.calculateDimensions(fee, key);
                                break;
                        }
                    else
                        switch (name) {
                            case 'TotalQ':
                                $scope.Convenio.intTotalQ = 0;
                                $scope.calculateQuote();
                                break;
                            case 'TotalQZP':
                                $scope.ConvenioZP.intTotalQ = 0;
                                $scope.calculateQuote();
                                break;
                            case 'intTotalQ':
                                if(fee === 'DS')
                                    $scope.ConvenioDS.intTotalQ = 0;
                                if(fee === '2D')
                                    $scope.Convenio2D.intTotalQ = 0;
                                if(fee === 'A12')
                                    $scope.ConvenioA12.intTotalQ = 0;
                                $scope.calculateFreccEXP(fee, null);
                                break;
                            case 'fltFrecc':
                                if(fee === 'DS')
                                    $scope.ConvenioDS.ranges[key].fltFrecuency = 0;
                                if(fee === '2D')
                                    $scope.Convenio2D.ranges[key].fltFrecuency = 0;
                                if(fee === 'A12')
                                    $scope.ConvenioA12.ranges[key].fltFrecuency = 0;
                                $scope.calculateFreccEXP(fee, 0);
                                break;
                            default:
                                cmp.target.innerText = 0;
                                break;
                        }
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
                              if(objQuote.Descuento_maximo_de_servicios__c >= 0
                                     && objQuote.Descuento_maximo_de_servicios__c <= 10
                                     && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')
                                     && objQuote.Lead__c) {
                                     if (strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'SipWeb_global_10_1_a_25_preau';
                                }
                                if(objQuote.Descuento_maximo_de_servicios__c >= 10.01
                                     && objQuote.Descuento_maximo_de_servicios__c <= 25
                                     && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')) {
                                    if (strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'SipWeb_global_10_1_a_25_preau';
                                }
                               
                               if(objQuote.Descuento_M_ximo_por_Servicios_Express__c >= 10.01
                                        && objQuote.Descuento_M_ximo_por_Servicios_Express__c <= 25
                                        && objQuote.PAQ_TipoServicio__c.includes('Servicio Express Garantizado (SEG)')){
                                    if(strProfile === 'Gerente de sucursal')
                                        strNameProcess = 'AEREO_SIPWEB_global_10_1_a_25_pre';
                                }                               
                                if(objQuote.Descuento_maximo_de_servicios__c >= 25.01
                                        && objQuote.Descuento_maximo_de_servicios__c <= 40
                                        && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'preautorizacion_mayor_25_gerente';
                                    if(strProfile === 'Gerente de sucursal')
                                        strNameProcess = 'preautorizacion_mayor_25_gerente';
                                }
                               if(objQuote.Descuento_maximo_de_servicios__c >= 40.01
                                        && objQuote.Descuento_maximo_de_servicios__c <= 60
                                        && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'preautorizacion_mayor_25_gerente';
                                    if(strProfile === 'Gerente de sucursal')
                                        strNameProcess = 'preautorizacion_mayor_25_gerente';
                                    if(strProfile === 'KAM Regional')
                                        strNameProcess = 'SipWeb_global_40_al_60_KAM_Regional';
                                }
                                if(objQuote.Descuento_M_ximo_por_Servicios_Express__c > 25
                                    && objQuote.PAQ_TipoServicio__c.includes('Servicio Express Garantizado (SEG)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'preautorizacion_mayor_25_gerente';
                                    if(strProfile === 'Gerente de sucursal')
                                        strNameProcess = 'preautorizacion_mayor_25_gerente';
                                    if(strProfile === 'KAM Regional')
                                        strNameProcess = 'AEREO_SIPWEB_mayor_de_25_KAM';
                                    if(strProfile === 'Gerentes de desarrollo de Negocios')
                                        strNameProcess = 'AEREO_SIPWEB_mayor_de_25_GDE';
                                }
                                if(objQuote.Descuento_maximo_de_servicios__c > 60
                                   && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'preautorizacion_mayor_25_gerente';
                                    if(strProfile === 'Gerente de sucursal')
                                        strNameProcess = 'preautorizacion_mayor_25_gerente';
                                    if(strProfile === 'KAM Regional')
                                        strNameProcess = 'SipWeb_global_mayor_a_60_KAM_Regional';
                                    if(strProfile === 'Gerentes de desarrollo de Negocios')
                                        strNameProcess = 'SipWeb_global_mayor_a_60_Gerentes_de_des';
                                }
                        }

                        if(notEmpty(strNameProcess))
                            callSent($scope, $scope.Wrapper.objQuote.Id, strNameProcess, $scope.Convenio.strApprovalComment);
                            //19/10/2021 Salvador (sramirez@freewayconsulting.com): Se cambia el último argumento para que ahora mande los comentarios al aprobador ya que antes mandaba el ID del aprobador pero esto no espera del lado del servidor
                        else
                            $scope.DML.listErrors.push('NO se encontró el proceso de aprobación aplicable');
                    }
                     else if(objQuote.SBQQ__Opportunity2__c){
                        if(objQuote.SBQQ__Status__c === 'Draft')
                        {
                                if(objQuote.Descuento_maximo_de_servicios__c >= 10.01
                                     && objQuote.Descuento_maximo_de_servicios__c <= 25
                                     && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')) {
                                    if (strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'SipWeb_global_10_1_a_25';
                                }
                                if(objQuote.Descuento_M_ximo_por_Servicios_Express__c >= 10.01
                                        && objQuote.Descuento_M_ximo_por_Servicios_Express__c <= 25
                                        && objQuote.PAQ_TipoServicio__c.includes('Servicio Express Garantizado (SEG)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'AEREO_SIPWEB_global_10_1_a_25';
                                }
                                if(objQuote.Descuento_maximo_de_servicios__c >= 25.01
                                        && objQuote.Descuento_maximo_de_servicios__c <= 40
                                        && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'SipWeb_global_25_1_a_40';
                                    if(strProfile === 'Gerente de sucursal')
                                        strNameProcess = 'SipWeb_global_25_1_a_40_GE_SUCURSAL';
                                }
                                if(objQuote.Descuento_maximo_de_servicios__c >= 40.01
                                        && objQuote.Descuento_maximo_de_servicios__c <= 60
                                        && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'SipWeb_global_40_al_60';
                                    if(strProfile === 'Gerente de sucursal')
                                        strNameProcess = 'SipWeb_global_40_al_60_Gerente_de_sucur';
                                    if(strProfile === 'KAM Regional')
                                        strNameProcess = 'SipWeb_global_40_al_60_KAM_Regional';

                                }
                                  if(objQuote.Descuento_M_ximo_por_Servicios_Express__c > 25
                                    && objQuote.PAQ_TipoServicio__c.includes('Servicio Express Garantizado (SEG)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'AEREO_SIPWEB_mayor_de_25';
                                    if(strProfile === 'Gerente de sucursal')
                                        strNameProcess = 'AEREO_SIPWEB_mayor_de_25_GSU';
                                    if(strProfile === 'KAM Regional')
                                        strNameProcess = 'AEREO_SIPWEB_mayor_de_25_KAM';
                                    if(strProfile === 'Gerentes de desarrollo de Negocios')
                                        strNameProcess = 'AEREO_SIPWEB_mayor_de_25_GDE';
                                }
                                if(objQuote.Descuento_maximo_de_servicios__c > 60
                                   && objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')){
                                    if(strProfile === 'Ejecutivo de venta')
                                        strNameProcess = 'SipWeb_global_mayor_a_60';
                                    if(strProfile === 'Gerente de sucursal')
                                        strNameProcess = 'SipWeb_global_mayor_a_60_Gerente_de_sucu';
                                    if(strProfile === 'KAM Regional')
                                        strNameProcess = 'SipWeb_global_mayor_a_60_KAM_Regional';
                                    if(strProfile === 'Gerentes de desarrollo de Negocios')
                                        strNameProcess = 'SipWeb_global_mayor_a_60_Gerentes_de_des';
                                }

                        }

                        if(notEmpty(strNameProcess))
                            callSent($scope, $scope.Wrapper.objQuote.Id, strNameProcess, $scope.Convenio.strApprovalComment);
                            //19/10/2021 Salvador (sramirez@freewayconsulting.com): Se cambia el último argumento para que ahora mande los comentarios al aprobador ya que antes mandaba el ID del aprobador pero esto no espera del lado del servidor
                        else
                            $scope.DML.listErrors.push('NO se encontró el proceso de aprobación aplicable');
                    }
                         
                };

                $scope.dataTest = function() {
                    $scope.Convenio.mapTotal['0-400'].fltRanTotalFrec = getNumFromPercent('70%');
                    $scope.Convenio.mapTotal['401-800'].fltRanTotalFrec = getNumFromPercent('15%');
                    $scope.Convenio.mapTotal['801-1200'].fltRanTotalFrec = getNumFromPercent('7%');
                    $scope.Convenio.mapTotal['1201-1600'].fltRanTotalFrec = getNumFromPercent('4%');
                    $scope.Convenio.mapTotal['1601-2000'].fltRanTotalFrec = getNumFromPercent('2%');
                    $scope.Convenio.mapTotal['2001-2400'].fltRanTotalFrec = getNumFromPercent('1%');
                    $scope.Convenio.mapTotal['+2400'].fltRanTotalFrec = getNumFromPercent('1%');
                    $scope.Convenio.intTotalQ = getNum('9000');
                    $scope.Convenio.mapQuotes['TS'].fltFeeTotalFrec = getNumFromPercent('8%');
                    $scope.Convenio.mapQuotes['T0'].fltFeeTotalFrec = getNumFromPercent('10%');
                    $scope.Convenio.mapQuotes['T1'].fltFeeTotalFrec = getNumFromPercent('15%');
                    $scope.Convenio.mapQuotes['T2'].fltFeeTotalFrec = getNumFromPercent('20%');
                    $scope.Convenio.mapQuotes['T3'].fltFeeTotalFrec = getNumFromPercent('25%');
                    $scope.Convenio.mapQuotes['T4'].fltFeeTotalFrec = getNumFromPercent('14%');
                    $scope.Convenio.mapQuotes['T5'].fltFeeTotalFrec = getNumFromPercent('1%');
                    $scope.Convenio.mapQuotes['T6'].fltFeeTotalFrec = getNumFromPercent('4%');
                    $scope.Convenio.mapQuotes['T7'].fltFeeTotalFrec = getNumFromPercent('3%');
                    $scope.ConvenioZP.mapTotal['0-400'].fltRanTotalFrec = getNumFromPercent('70%');
                    $scope.ConvenioZP.mapTotal['401-800'].fltRanTotalFrec = getNumFromPercent('15%');
                    $scope.ConvenioZP.mapTotal['801-1200'].fltRanTotalFrec = getNumFromPercent('7%');
                    $scope.ConvenioZP.mapTotal['1201-1600'].fltRanTotalFrec = getNumFromPercent('4%');
                    $scope.ConvenioZP.mapTotal['1601-2000'].fltRanTotalFrec = getNumFromPercent('2%');
                    $scope.ConvenioZP.mapTotal['2001-2400'].fltRanTotalFrec = getNumFromPercent('1%');
                    $scope.ConvenioZP.mapTotal['+2400'].fltRanTotalFrec = getNumFromPercent('1%');
                    $scope.ConvenioZP.intTotalQ = getNum('1000');
                    $scope.ConvenioZP.mapQuotes['TS'].fltFeeTotalFrec = getNumFromPercent('8%');
                    $scope.ConvenioZP.mapQuotes['T0'].fltFeeTotalFrec = getNumFromPercent('10%');
                    $scope.ConvenioZP.mapQuotes['T1'].fltFeeTotalFrec = getNumFromPercent('15%');
                    $scope.ConvenioZP.mapQuotes['T2'].fltFeeTotalFrec = getNumFromPercent('20%');
                    $scope.ConvenioZP.mapQuotes['T3'].fltFeeTotalFrec = getNumFromPercent('25%');
                    $scope.ConvenioZP.mapQuotes['T4'].fltFeeTotalFrec = getNumFromPercent('14%');
                    $scope.ConvenioZP.mapQuotes['T5'].fltFeeTotalFrec = getNumFromPercent('4%');
                    $scope.ConvenioZP.mapQuotes['T6'].fltFeeTotalFrec = getNumFromPercent('4%');
                    $scope.Convenio.mapTotal['0-400'].fltWeightAVR = getNum('250');
                    $scope.Convenio.mapTotal['0-400'].fltVolAVR = getNum('1');
                    $scope.Convenio.blnSameWeight = true;
                    $scope.Convenio.blnSameVol = true;
                    $scope.Convenio.blnRAD = true;
                    $scope.Convenio.blnEAD = true;
                    $scope.Convenio.blnSEG = true;
                    $scope.Convenio.fltSEG = 2000;
                    $scope.Convenio.blnACK = true;
                    $scope.Convenio.promDeliveryACK = 50;
                    $scope.Convenio.promPackByDeslivery = 6;
                    $scope.replicateDimensionsAVR();
                    $scope.calculateQuote();
                    $scope.Convenio.strACK = 'Interno';
                    $scope.Convenio.blnPack = true;
                    $scope.Convenio.blnSobre = true;
                    $scope.Convenio.fltDiscPack = 50;
                    $scope.Convenio.fltDiscSobre = 30;
                    $scope.Convenio.fltDiscRAD = 80;
                    $scope.Convenio.fltDiscEAD = 30;
                    $scope.Convenio.fltDiscZP = 20;
                    $scope.Convenio.fltDiscACK = 30;
                    $scope.ConvenioDS.fltDisc = 30;
                    $scope.ConvenioDS.blnDisc = true;
                    $scope.ConvenioA12.fltDisc = 25;
                    $scope.ConvenioA12.blnDisc = true;
                    $scope.Convenio.blnSEG = true;
                    $scope.ConvenioDS.intTotalQ = 500;
                    $scope.ConvenioDS.ranges['0-400'].fltWeight = getNum('12');
                    $scope.ConvenioDS.ranges['0-400'].fltLarge = getNum('32');
                    $scope.ConvenioDS.ranges['0-400'].fltWidth = getNum('66');
                    $scope.ConvenioDS.ranges['0-400'].fltHigh = getNum('40');
                    /*$scope.Convenio2D.ranges['0-400'].fltWeight = getNum('12');
                    $scope.Convenio2D.ranges['0-400'].fltLarge = getNum('50');
                    $scope.Convenio2D.ranges['0-400'].fltWidth = getNum('18');
                    $scope.Convenio2D.ranges['0-400'].fltHigh = getNum('30');*/
                    $scope.ConvenioA12.ranges['0-400'].fltWeight = getNum('7');
                    $scope.ConvenioA12.ranges['0-400'].fltLarge = getNum('40');
                    $scope.ConvenioA12.ranges['0-400'].fltWidth = getNum('22');
                    $scope.ConvenioA12.ranges['0-400'].fltHigh = getNum('18');
                    $scope.ConvenioDS.blnSameWeight = true;
                    $scope.ConvenioDS.blnSameLarge = true;
                    $scope.ConvenioDS.blnSameWidth = true;
                    $scope.ConvenioDS.blnSameHigh = true;
                    /*$scope.Convenio2D.blnSameWeight = true;
                    $scope.Convenio2D.blnSameLarge = true;
                    $scope.Convenio2D.blnSameWidth = true;
                    $scope.Convenio2D.blnSameHigh = true;*/
                    $scope.ConvenioA12.blnSameWeight = true;
                    $scope.ConvenioA12.blnSameLarge = true;
                    $scope.ConvenioA12.blnSameWidth = true;
                    $scope.ConvenioA12.blnSameHigh = true;
                    $scope.replicate('fltWeight', 'DS');
                    $scope.replicate('fltLarge', 'DS');
                    $scope.replicate('fltWidth', 'DS');
                    $scope.replicate('fltHigh', 'DS');
                    /*$scope.replicate('fltWeight', '2D');
                    $scope.replicate('fltLarge', '2D');
                    $scope.replicate('fltWidth', '2D');
                    $scope.replicate('fltHigh', '2D');*/
                    $scope.replicate('fltWeight', 'A12');
                    $scope.replicate('fltLarge', 'A12');
                    $scope.replicate('fltWidth', 'A12');
                    $scope.replicate('fltHigh', 'A12');
                    $scope.ConvenioA12.intTotalQ = 200;
                    $scope.ConvenioDS.ranges['0-400'].fltFrecuency = getNumFromPercent('70%');
                    $scope.ConvenioDS.ranges['401-800'].fltFrecuency = getNumFromPercent('15%');
                    $scope.ConvenioDS.ranges['801-1200'].fltFrecuency = getNumFromPercent('7%');
                    $scope.ConvenioDS.ranges['1201-1600'].fltFrecuency = getNumFromPercent('4%');
                    $scope.ConvenioDS.ranges['1601-2000'].fltFrecuency = getNumFromPercent('2%');
                    $scope.ConvenioDS.ranges['2001-2400'].fltFrecuency = getNumFromPercent('1%');
                    $scope.ConvenioDS.ranges['+2400'].fltFrecuency = getNumFromPercent('1%');
                    /*$scope.Convenio2D.ranges['0-400'].fltFrecuency = getNumFromPercent('20%');
                    $scope.Convenio2D.ranges['401-800'].fltFrecuency = getNumFromPercent('20%');
                    $scope.Convenio2D.ranges['801-1200'].fltFrecuency = getNumFromPercent('20%');
                    $scope.Convenio2D.ranges['1201-1600'].fltFrecuency = getNumFromPercent('10%');
                    $scope.Convenio2D.ranges['1601-2000'].fltFrecuency = getNumFromPercent('10%');
                    $scope.Convenio2D.ranges['2001-2400'].fltFrecuency = getNumFromPercent('10%');
                    $scope.Convenio2D.ranges['+2400'].fltFrecuency = getNumFromPercent('10%');*/
                    $scope.ConvenioA12.ranges['0-400'].fltFrecuency = getNumFromPercent('87%');
                    $scope.ConvenioA12.ranges['401-800'].fltFrecuency = getNumFromPercent('6%');
                    $scope.ConvenioA12.ranges['801-1200'].fltFrecuency = getNumFromPercent('5%');
                    $scope.ConvenioA12.ranges['1201-1600'].fltFrecuency = getNumFromPercent('2%');
                    /*$scope.ConvenioA12.ranges['1601-2000'].fltFrecuency = getNumFromPercent('0%');
                    $scope.ConvenioA12.ranges['2001-2400'].fltFrecuency = getNumFromPercent('0%');
                    $scope.ConvenioA12.ranges['+2400'].fltFrecuency = getNumFromPercent('0%');*/
                    j$.each($scope.Convenio.listRange
                    , function (key, value) {
                                $scope.calculateDimensions('DS', key);
                                $scope.calculateDimensions('2D', key);
                                $scope.calculateDimensions('A12', key);
                        }
                    );
                    $scope.calculateFreccEXP('DS');
                    $scope.calculateFreccEXP('2D');
                    $scope.calculateFreccEXP('A12');

                };

                /*
                * initial Call
                */
                console.log('END LOAD Angular Controller SPW');
                //debugger;
                if($scope.hasRecord()){
                    $scope.Convenio.blnDescSeg = $scope.Wrapper.objQuote.SegDiscountAllowed__c;
                    $scope.Convenio.strACK = $scope.Wrapper.objQuote.Acuse__c;
                    $scope.Convenio.promDeliveryACK = $scope.Wrapper.objQuote.AVRDeliveryACK__c;
                    $scope.Convenio.promPackByDeslivery = $scope.Wrapper.objQuote.AVRPackByDelivery__c;
                    if(notEmpty($scope.Wrapper.objQuote.Acuse__c))
                        $scope.Convenio.blnACK = true;
                    if($scope.Wrapper.objQuote.Servicios_adicionales__c)
                        j$.each( $scope.Wrapper.objQuote.Servicios_adicionales__c.split(';')
                                ,function (key, service) {
                                    switch (service) {
                                        case 'RAD':
                                            $scope.Convenio.blnRAD = true;
                                            break;
                                        case 'EAD':
                                            $scope.Convenio.blnEAD = true;
                                            break;
                                        case 'Seguro':
                                            $scope.Convenio.blnSEG = true;
                                            break;
                                    }
                                }

                        );
                    if($scope.Wrapper.listQuoteItem) {
                        var quoteItemFST;
                        $scope.ConvenioDS.intTotalQ = 0;
                        $scope.Convenio2D.intTotalQ = 0;
                        $scope.ConvenioA12.intTotalQ = 0;
                        j$.each($scope.Wrapper.listQuoteItem
                                , function (index, quoteItem) {
                                    if(quoteItem.ZonaPlus__c){
                                        $scope.ConvenioZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.Convenio.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                        $scope.ConvenioZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.Convenio.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].Id = quoteItem.Id;
                                        if($scope.Convenio.fltDiscZP === 0)
                                            $scope.Convenio.fltDiscZP = quoteItem.DiscountDelivery__c;
                                        if(getId(quoteItem.Tarifa__c, $scope.Convenio.listFee)==='TS'){
                                            $scope.Convenio.fltDiscSobre = quoteItem.DiscountFlete__c;
                                            $scope.Convenio.blnSobre = true;
                                        }
                                        else{
                                            $scope.Convenio.fltDiscPack = quoteItem.DiscountFlete__c;
                                            $scope.Convenio.blnPack = true;
                                            if (!quoteItemFST)
                                                quoteItemFST = quoteItem;

                                        }
                                    } else if(quoteItem.Tarifa__c !== 'SEG-DS' && quoteItem.Tarifa__c !== 'SEG-2D' && quoteItem.Tarifa__c !== 'SEG-A12'){
                                        $scope.Convenio.mapQuotes[getId(quoteItem.Tarifa__c, $scope.Convenio.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                        $scope.Convenio.mapQuotes[getId(quoteItem.Tarifa__c, $scope.Convenio.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].Id = quoteItem.Id;
                                        $scope.Convenio.mapTotal[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].fltWeightAVR = quoteItem.PackWeightAVG__c;
                                        $scope.Convenio.mapTotal[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].fltVolAVR = quoteItem.PackVolAVG__c;
                                        if($scope.Convenio.fltDiscEAD === 0)
                                            $scope.Convenio.fltDiscEAD = quoteItem.DiscountDelivery__c;
                                        if(getId(quoteItem.Tarifa__c, $scope.Convenio.listFee)==='TS'){
                                            $scope.Convenio.fltDiscSobre = quoteItem.DiscountFlete__c;
                                            $scope.Convenio.blnSobre = true;
                                        }
                                        else{
                                            $scope.Convenio.fltDiscPack = quoteItem.DiscountFlete__c;
                                            $scope.Convenio.blnPack = true;
                                            if (!quoteItemFST)
                                                quoteItemFST = quoteItem;

                                        }

                                    }
                                    else if(quoteItem.Tarifa__c === 'SEG-DS'){
                                        $scope.ConvenioDS.ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                        $scope.ConvenioDS.ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].fltWeight = quoteItem.Weight__c;
                                        $scope.ConvenioDS.ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].fltLarge = quoteItem.Large__c;
                                        $scope.ConvenioDS.ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].fltHigh = quoteItem.High__c;
                                        $scope.ConvenioDS.ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].fltWidth = quoteItem.Width__c;
                                        $scope.ConvenioDS.ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].Id = quoteItem.Id;
                                        $scope.calculateDimensions('DS', getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange));
                                        $scope.ConvenioDS.intTotalQ += quoteItem.SBQQ__Quantity__c;
                                        if(quoteItem.SBQQ__Discount__c && !$scope.ConvenioDS.blnDisc){
                                            $scope.ConvenioDS.blnDisc = true;
                                            $scope.ConvenioDS.fltDisc = quoteItem.SBQQ__Discount__c;
                                        }
                                        if (!quoteItemFST)
                                            quoteItemFST = quoteItem;
                                    }
                                    else if(quoteItem.Tarifa__c === 'SEG-2D'){
                                        $scope.Convenio2D.ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                        $scope.Convenio2D.ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].fltWeight = quoteItem.Weight__c;
                                        $scope.Convenio2D.ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].fltLarge = quoteItem.Large__c;
                                        $scope.Convenio2D.ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].fltHigh = quoteItem.High__c;
                                        $scope.Convenio2D.ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].fltWidth = quoteItem.Width__c;
                                        $scope.Convenio2D.ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].Id = quoteItem.Id;
                                        $scope.calculateDimensions('2D', getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange));
                                        $scope.Convenio2D.intTotalQ += quoteItem.SBQQ__Quantity__c;
                                        if(quoteItem.SBQQ__Discount__c && !$scope.Convenio2D.blnDisc){
                                            $scope.Convenio2D.blnDisc = true;
                                            $scope.Convenio2D.fltDisc = quoteItem.SBQQ__Discount__c;
                                        }
                                        if (!quoteItemFST)
                                            quoteItemFST = quoteItem;
                                    }
                                    else if(quoteItem.Tarifa__c === 'SEG-A12'){
                                        $scope.ConvenioA12.ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                        $scope.ConvenioA12.ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].fltWeight = quoteItem.Weight__c;
                                        $scope.ConvenioA12.ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].fltLarge = quoteItem.Large__c;
                                        $scope.ConvenioA12.ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].fltHigh = quoteItem.High__c;
                                        $scope.ConvenioA12.ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].fltWidth = quoteItem.Width__c;
                                        $scope.ConvenioA12.ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].Id = quoteItem.Id;
                                        $scope.calculateDimensions('A12', getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange));
                                        $scope.ConvenioA12.intTotalQ += quoteItem.SBQQ__Quantity__c;
                                        if(quoteItem.SBQQ__Discount__c && !$scope.ConvenioA12.blnDisc){
                                            $scope.ConvenioA12.blnDisc = true;
                                            $scope.ConvenioA12.fltDisc = quoteItem.SBQQ__Discount__c;
                                        }
                                        if (!quoteItemFST)
                                            quoteItemFST = quoteItem;
                                    }
                                }
                        );
                        j$.each($scope.Convenio.listRange
                                , function (key, value) {
                                    $scope.ConvenioDS.ranges[key].fltFrecuency = $scope.ConvenioDS.ranges[key].intFrecuency / $scope.ConvenioDS.intTotalQ;
                                    $scope.Convenio2D.ranges[key].fltFrecuency = $scope.Convenio2D.ranges[key].intFrecuency / $scope.Convenio2D.intTotalQ;
                                    $scope.ConvenioA12.ranges[key].fltFrecuency = $scope.ConvenioA12.ranges[key].intFrecuency / $scope.ConvenioA12.intTotalQ;
                                }
                        );
                        $scope.calculateFreccEXP('DS', $scope.ConvenioDS.intTotalQ );
                        $scope.calculateFreccEXP('2D', $scope.Convenio2D.intTotalQ );
                        $scope.calculateFreccEXP('A12', $scope.ConvenioA12.intTotalQ );
                        if (quoteItemFST) {
                            $scope.Convenio.fltDiscSEG = quoteItemFST.DiscountSeg__c;
                            $scope.Convenio.fltSEG = quoteItemFST.Pack_Seg__c;
                            $scope.Convenio.fltDiscACK = quoteItemFST.DiscountAcuse__c;
                            $scope.Convenio.fltDiscRAD = quoteItemFST.DiscountRecolection__c;
                            $scope.calculateXY();
                            $scope.calculateXY('ZP');

                        }
                    }
                }
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
                            //debugger;
                            if (event.status) {
                                $scope.DML = result;
                                $scope.Wrapper.objQuote = result.objQuote;
                                j$.each(result.listQuoteItem, function (index, quoteItem) {
                                    if(quoteItem.ZonaPlus__c)
                                        $scope.ConvenioZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.Convenio.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].Id = quoteItem.Id;
                                    else if(quoteItem.Tarifa__c !== 'SEG-DS' && quoteItem.Tarifa__c !== 'SEG-2D' && quoteItem.Tarifa__c !== 'SEG-A12')
                                        $scope.Convenio.mapQuotes[getId(quoteItem.Tarifa__c, $scope.Convenio.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].Id = quoteItem.Id;
                                    else if(quoteItem.Tarifa__c === 'SEG-DS')
                                        $scope.ConvenioDS.ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].Id = quoteItem.Id;
                                    else if(quoteItem.Tarifa__c === 'SEG-2D')
                                        $scope.Convenio2D.ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].Id = quoteItem.Id;
                                    else if(quoteItem.Tarifa__c === 'SEG-A12')
                                        $scope.ConvenioA12.ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].Id = quoteItem.Id;
                                });
                                if(result.blnSuccess)
                                    $scope.SuccessMessage = 'Se han guardado los cambios con exito.';
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

            function callUpdateQuoteConv($scope, objQuote, listQuoteItem, leadObj, oppObj, listDeletItems) {
                j$.blockUI({ message: '<h3><span class="glyphicon glyphicon-time"></span> Por favor espere... </h3>' });
                $scope.SuccessMessage = '';
                $scope.sent = true;
                $scope.DML.listErrors = [];
                Visualforce.remoting.Manager.invokeAction(
                        '{!$RemoteAction.PAQ_CotizadorNacional_CTR.updateQuoteConv}'
                        , objQuote
                        , listQuoteItem
                        , leadObj
                        , oppObj
                        , listDeletItems
                        , null
                        , null
                        , function (result, event) {
                            if (event.status) {
                                $scope.DML = result;
                                $scope.Wrapper.objQuote = result.objQuote;
                                j$.each(result.listQuoteItem, function (index, quoteItem) {
                                    if(quoteItem.ZonaPlus__c)
                                        $scope.ConvenioZP.mapQuotes[getId(quoteItem.Tarifa__c, $scope.Convenio.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].Id = quoteItem.Id;
                                    else if(quoteItem.Tarifa__c !== 'SEG-DS' && quoteItem.Tarifa__c !== 'SEG-2D' && quoteItem.Tarifa__c !== 'SEG-A12')
                                        $scope.Convenio.mapQuotes[getId(quoteItem.Tarifa__c, $scope.Convenio.listFee)].ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].Id = quoteItem.Id;
                                    else if(quoteItem.Tarifa__c === 'SEG-DS')
                                        $scope.ConvenioDS.ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].Id = quoteItem.Id;
                                    else if(quoteItem.Tarifa__c === 'SEG-2D')
                                        $scope.Convenio2D.ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].Id = quoteItem.Id;
                                    else if(quoteItem.Tarifa__c === 'SEG-A12')
                                        $scope.ConvenioA12.ranges[getId(quoteItem.Rango_KM__c, $scope.Convenio.listRange)].Id = quoteItem.Id;
                                });
                                if(result.blnSuccess)
                                    $scope.SuccessMessage = 'Se han guardado los cambios con exito';

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

            function getNumFromPercent(str) {
                var strNum = '';
                var index = str.indexOf("%");
                strNum = str.slice(0, index);
                if (getNum(strNum) > 0)
                    return  getNum(strNum) / 100;
                else
                    return 0;
            }

            function getNum(strNum) {
                if(notEmpty(strNum))
                    if(isNaN(strNum))
                        return 0;
                    else
                        return parseFloat(strNum);
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
