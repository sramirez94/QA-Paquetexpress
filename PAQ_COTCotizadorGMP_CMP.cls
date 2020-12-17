<apex:component controller="PAQ_CotizadorNacional_CTR">
    <div ng-controller="GMPController as GMP">
        <div class="row" ng-show="GM.step1">
            <div class="col-md-12 col-sm-12">
                <!-- Costos -->
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <a data-toggle="collapse" href="#Guide"><h3 class="panel-title">GUÍA DE ARRANQUE</h3></a>
                    </div>
                    <div id="Guide" class="panel-collapse collapse in">
                        <div class="panel-body">
                            <!--header-->
                            <div class="row">
                                <div class="col-sm-4 col-md-4 right">
                                    <div class="row">
                                        <div class="col-sm-8 col-md-8">
                                            <div class="alert alert-danger" role="alert" ng-show="validateKG(GM.fltMaxG)">
                                                <span> El peso debe ser un número mayor a 1</span>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 col-md-4">
                                            <input type="number" class="custom-control-input rouded-med" ng-model="GM.fltMaxG" min="1" ng-class="{missing: validateKG(GM.fltMaxG), valid: !validateKG(GM.fltMaxG)}"/>
                                            <label class="custom-control-label" >Kg</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3 col-md-3 left">
                                    <button type="button" class="btn btn-primary" ng-click="addBlock(GM.fltMaxG)">
                                        <span class="glyphicon glyphicon-plus"></span>
                                    </button>
                                    <label>Añadir más bloques de arranque</label>
                                </div>
                                <div class="col-sm- col-md-1 ">
                                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#ModalServicesGM"  >
                                        Servicios
                                    </button>
                                </div>
                                <div class="col-md-1 col-sm-1">
                                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#GMModalDestiny"  >
                                        Destinos
                                    </button>
                                </div>
                            </div>
                            <!-- Costo base y excedente -->
                            <div class="row">
                                <!--left-->
                                <div class="col-sm-9 col-md-9">
                                    <table class="table table-striped table-bordered">
                                        <thead class="thead-light">
                                            <th colspan="15" class="center">COSTO BASE</th>
                                            <tr>
                                                <th width="16%" class="thead-light verticalTH">Cotizar T7 zona plus</th>
                                                <th class="center" ng-repeat="(keyBlock, block) in GM.mapBlock"><input type="checkbox" name="radioTZP" ng-model="GM.mapBlock[keyBlock].blnT7ZP" id="radioTZP" ng-show="GM.mapBlock[keyBlock].fltMaxW > 60" ng-click="setValue('blnT7ZP', keyRange, $event, keyBlock)"/></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <th width="16%" class="thead-light verticalTH">Peso báscula kg</th>
                                                <td class="center" contenteditable="true" ng-repeat="(keyBlock, block) in GM.mapBlock" ng-bind="GM.mapBlock[keyBlock].fltMaxW | number" ng-blur="setValue('fltMaxW', keyRange, $event, keyBlock)"></td>
                                            </tr>
                                            <tr>
                                                <th width="16%" class="thead-light verticalTH">Volumen m3</th>
                                                <td class="center" contenteditable="true" ng-repeat="(keyBlock, block) in GM.mapBlock" ng-bind="GM.mapBlock[keyBlock].fltVolW | number:4" ng-blur="setValue('fltMaxV', keyRange, $event, keyBlock)"></td>
                                            </tr>
                                            <tr>
                                                <th width="16%" class="thead-light verticalTH">Kg volumétrico</th>
                                                <td class="center" ng-repeat="(keyBlock, block) in GM.mapBlock" ng-bind="GM.mapBlock[keyBlock].fltVolWeight | number:1"></td>
                                            </tr>
                                            <tr>
                                                <th width="16%" class="thead-light verticalTH">Remover</th>
                                                <td class="center" ng-repeat="(keyBlock, block) in GM.mapBlock">
                                                    <button type="button" class="btn btn-primary" ng-click="removeBlock(keyBlock)">
                                                        <span class="glyphicon glyphicon-minus"></span>
                                                    </button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <br/>
                                    <table class="table table-striped table-bordered">
                                        <thead class="thead-light">
                                            <tr>
                                                <th width="16%" class="center"> Kilómetros  </th>
                                                <th class="center" ng-repeat="(keyBlock, block) in GM.mapBlock" > Costo propuesto </th>
                                            </tr>
                                            <tr>
                                                <th width="16%" class="center"></th>
                                                <th class="center" ng-repeat="(keyBlock, block) in GM.mapBlock" > <input type="checkbox" ng-model="block.blnSameCost" ng-click="replicate('base', block.blnSameCost, keyBlock)"/>  </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr ng-repeat="(keyRange, strRange) in GM.listRange">
                                                <td class="verticalTH" ng-bind="strRange"></td>
                                                <td class="center" contenteditable="true" ng-repeat="(keyBlock, block) in GM.mapBlock" ng-bind="block.ranges[keyRange].fltCost | currency" ng-blur="setValue('fltCost', keyRange, $event, keyBlock)"></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <br/>
                                </div>
                                <!--right-->
                                <div class="col-sm-3 col-md-3">
                                    <table class="table table-striped table-bordered">
                                        <thead class="thead-light">
                                            <th colspan="2" class="center">COSTO EXCEDENTE</th>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <th class="thead-light" width="50%">Peso báscula kg</th>
                                                <td class="center">1</td>
                                            </tr>
                                            <tr>
                                                <th class="thead-light" width="50%">Volumen m3</th>
                                                <td class="center">0.005</td>
                                            </tr>
                                            <tr>
                                                <th class="thead-light" width="50%">Kg volumétrico</th>
                                                <td class="center">1</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <br/><br/>
                                    <br/><br/>
                                    <table class="table table-striped table-bordered">
                                        <thead class="thead-light">
                                            <tr>
                                                <th class="center"> Kilómetros  </th>
                                                <th class="center"> Costo por kg</th>
                                                <th class="center"> Costo por m3</th>
                                            </tr>
                                            <tr>
                                                <th class="center"></th>
                                                <th class="center"><input type="checkbox" ng-model="GM.blnSameAddCost" ng-click="replicate('Add', GM.blnSameAddCost)"/></th>
                                                <th class="center"></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr ng-repeat="(keyRange, strRange) in GM.listRange">
                                                <td ng-bind="strRange" width="33%"></td>
                                                <td class="center" contenteditable="true" ng-bind="GM.mapService['Add'].ranges[keyRange].fltCostWeight | currency" ng-blur="setValue('fltCostWeight', keyRange, $event, 'Add')"></td>
                                                <td class="center" ng-bind="GM.mapService['Add'].ranges[keyRange].fltCostVol | currency"></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <!-- Costo adicional -->
                            <div class="row">
                                <!-- left -->
                                <div class="col-sm-4 col-md-4">
                                    <br/>
                                    <table class="table table-striped table-bordered">
                                        <thead class="thead-light">
                                            <tr>
                                                <th class="center" colspan="2" data-toggle="collapse" data-target="#zpCost">
                                                    <a href="#zpCost"> Zona Plus </a>
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody id="zpCost" class="collapse">
                                            <tr>
                                                <th class="center"> Costo adicional </th>
                                                <th class="center"> Forma </th>
                                            </tr>
                                            <tr>
                                                <td width="20%" class="center">
                                                    EAD Zona plus
                                                </td>
                                                <td width="40%" class="center">
                                                    <select class="select" style="width: 70%" disabled="true">
                                                        <option value="B"> Por Bulto </option>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="center thead-light"> Kilómetros  </th>
                                                <th class="center thead-light" > Costo propuesto</th>
                                            </tr>
                                            <tr>
                                                <td width="40%"> Replicar</td>
                                                <td class="center" width="60%"><input type="checkbox" ng-model="GM.mapService['ZP'].blnSameCost" ng-click="replicate('ZP', GM.mapService['ZP'].blnSameCost)"/> </td>
                                            </tr>
                                            <tr ng-repeat="(keyRange, strRange) in GM.listRange">
                                                <td width="40%" ng-bind="strRange"></td>
                                                <td width="60%" class="center" contenteditable="true" ng-bind="GM.mapService['ZP'].ranges[keyRange].fltCost | currency" ng-blur="setValue('fltCostRange', keyRange, $event, 'ZP')"></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- center -->
                                <div class="col-sm-4 col-md-4">
                                    <br/>
                                    <table class="table table-striped table-bordered" ng-show="GM.blnACK">
                                        <thead class="thead-light">
                                            <tr>
                                                <th class="center"> Tipo Acuse </th>
                                                <th class="center"> Forma </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <tr >
                                            <td width="20%" class="center">
                                                <select ng-options="option.label for option in GM.mapService['ACK'].optOption.aviableOptions" class="select" ng-model="GM.mapService['ACK'].optOption.model" ng-required="true" ng-change="setACK(GM.mapService['ACK'].optOption.model)"></select>
                                            </td>
                                            <td width="40%" class="center">
                                                <select ng-options="option.label for option in  GM.mapService['ACK'].optForma.aviableOptions" class="select" ng-model="GM.mapService['ACK'].optForma.model" ng-required="true" style="width: 70%" ng-change="setACKmode(GM.mapService['ACK'].optForma.model)"></select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th class="center thead-light"> Kilómetros  </th>
                                            <th class="center thead-light" > Costo propuesto</th>
                                        </tr>
                                        <tr>
                                            <td width="40%"> Replicar</td>
                                            <td class="center" width="60%"><input type="checkbox" ng-model="GM.mapService['ACK'].blnSameCost"  ng-click="replicate('ACK', GM.mapService['ACK'].blnSameCost)"/> </td>
                                        </tr>
                                        <tr ng-repeat="(keyRange, strRange) in GM.listRange">
                                            <td width="40%" ng-bind="strRange"></td>
                                            <td width="60%" class="center" contenteditable="true" ng-bind="GM.mapService['ACK'].ranges[keyRange].fltCost | currency" ng-blur="setValue('fltCostRange', keyRange, $event, 'ACK')"></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- right -->
                                <div class="col-sm-4 col-md-4">
                                    <br/>
                                    <!--<table class="table table-striped table-bordered" ng-show="GM.blnACK && isACK('G')">
                                        <tbody>
                                            <tr>
                                                <th class="thead-light" width="70%">Promedio de envíos con acuse</th>
                                                <td class="center" contenteditable="true" ng-bind="GM.mapService['ACK'].fltAVGDeliveryByACK | percentage" ng-blur="setValue('AVGDeliveryACK', null, $event, 'ACK')"></td>
                                            </tr>
                                            <tr>
                                                <th class="thead-light" width="70%">Paquetes promedio por guía
                                                </th>
                                                <td class="center" contenteditable="true" ng-bind="GM.mapService['ACK'].fltAVGPackByDay | number" ng-blur="setValue('AVGPack', null, $event, 'ACK')"></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <br/>-->
                                    <div class="row">
                                        <div class="col-sm-6 col-md-6 bold right">BULTOS</div>
                                        <div class="col-sm-6 col-md-6" ng-bind="GM.TOTAL['PAQUETES'] | number" ></div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6 col-md-6 bold right">GUIAS</div>
                                        <div class="col-sm-6 col-md-6" ng-bind="GM.TOTAL['GUIAS'] | number" ></div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6 col-md-6 bold right">TOTAL NORMAL</div>
                                        <div class="col-sm-6 col-md-6" ng-bind="GM.TOTAL['NORMAL'] | currency" ></div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6 col-md-6 bold right">TOTAL PROPUESTO</div>
                                        <div class="col-sm-6 col-md-6" ng-bind="GM.TOTAL['PROPUESTA'] | currency" ></div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6 col-md-6 bold right">DESCUENTO GLOBAL</div>
                                        <div class="col-sm-6 col-md-6" ng-bind="GM.TOTAL['DESCUENTO'] | percentage:2" ></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Frecuencia -->
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <a data-toggle="collapse" href="#Frecc"><h3 class="panel-title">FRECUENCIA ENVÍOS</h3></a>
                    </div>
                    <div id="Frecc" class="panel-collapse collapse in">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-sm-12 col-md-12" ng-show="GM.hasOverWBlocks">
                                    <table class="table table-striped table-bordered">
                                        <thead class="thead-light">
                                            <tr>
                                                <th colspan="12" class="center" data-toggle="collapse" data-target="#PAQT6Table">
                                                    <a href="#PAQT6Table">COBERTURA PAQUETEXPRESS</a>
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody id="PAQT6Table" class="collapse in" >
                                            <tr>
                                                <th class="center"> Kilómetros  </th>
                                                <th class="center" ng-repeat="(keyFee, frecc) in GM.mapFrecc" ng-bind="keyFee" ng-show="isFrecc(keyFee)"></th>
                                                <th class="center">PAQUETES</th>
                                                <th class="center">FRECUENCIA</th>
                                            </tr>
                                            <tr ng-repeat="(keyRange, strRange) in GM.listRange">
                                                <td class="verticalTH" ng-bind="strRange"></td>
                                                <td class="center" width="7%" contenteditable="true" ng-repeat="(keyFee, frecc) in GM.mapFrecc"  ng-bind="frecc.ranges[keyRange].intFrecuency | number" ng-blur="setValue('intFrecuency', keyRange, $event, keyFee)" ng-show="isFrecc(keyFee)"></td>
                                                <td class="center thead-light" width="7%" ng-bind="GM.mapRanges[keyRange]['PAQ'].intQTotal | number"></td>
                                                <td class="center thead-light" width="7%" contenteditable="true" ng-bind="GM.mapRanges[keyRange]['PAQ'].fltFrecc | percentage:2" ng-blur="setValue('fltFreccRange', keyRange, $event, keyFee)"></td>
                                            </tr>
                                            <tr>
                                                <td class="thead-light">Total</td>
                                                <td class="center thead-light" ng-repeat="(keyFee, frecc) in GM.mapFrecc"  ng-bind="frecc.intQTotal | number" ng-show="isFrecc(keyFee)" ></td>
                                                <td class="center thead-light" contenteditable="true" ng-bind="GM.mapFrecc.intQTotal | number" ng-blur="setValue('intQTotal', keyRange, $event, keyFee)"></td>
                                                <td class="center" ng-bind="GM.mapFrecc.fltFTotal | percentage:2"></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td class="center thead-light" contenteditable="true" ng-repeat="(keyFee, frecc) in GM.mapFrecc" ng-bind="frecc.fltFrecc | percentage:2" ng-show="isFrecc(keyFee)" ng-blur="setValue('fltFreccFee', keyRange, $event, keyFee)"></td>
                                                <td class="center" ng-bind="GM.mapFrecc.fltFEETotal | percentage:2" ></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="col-sm-9 col-md-9" ng-hide="GM.hasOverWBlocks">
                                    <table class="table table-striped table-bordered">
                                        <thead class="thead-light">
                                        <tr>
                                            <th colspan="12" class="center" data-toggle="collapse" data-target="#PAQT7Table">
                                                <a href="#PAQT7Table">COBERTURA PAQUETEXPRESS</a>
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody id="PAQT7Table" class="collapse in" >
                                        <tr>
                                            <th class="center"> Kilómetros  </th>
                                            <th class="center" ng-repeat="(keyFee, frecc) in GM.mapFrecc" ng-bind="keyFee" ng-show="isFrecc(keyFee)"></th>
                                            <th class="center">PAQUETES</th>
                                            <th class="center">FRECUENCIA</th>
                                        </tr>
                                        <tr ng-repeat="(keyRange, strRange) in GM.listRange">
                                            <td class="verticalTH" ng-bind="strRange"></td>
                                            <td class="center" width="7%" contenteditable="true" ng-repeat="(keyFee, frecc) in GM.mapFrecc"  ng-bind="frecc.ranges[keyRange].intFrecuency | number" ng-blur="setValue('intFrecuency', keyRange, $event, keyFee)" ng-show="isFrecc(keyFee)"></td>
                                            <td class="center thead-light" width="7%" ng-bind="GM.mapRanges[keyRange]['PAQ'].intQTotal | number"></td>
                                            <td class="center thead-light" width="7%" contenteditable="true" ng-bind="GM.mapRanges[keyRange]['PAQ'].fltFrecc | percentage:2" ng-blur="setValue('fltFreccRange', keyRange, $event, keyFee)"></td>
                                        </tr>
                                        <tr>
                                            <td class="thead-light">Total</td>
                                            <td class="center thead-light" ng-repeat="(keyFee, frecc) in GM.mapFrecc"  ng-bind="frecc.intQTotal | number" ng-show="isFrecc(keyFee)" ></td>
                                            <td class="center thead-light" contenteditable="true" ng-bind="GM.mapFrecc.intQTotal | number" ng-blur="setValue('intQTotal', keyRange, $event, keyFee)"></td>
                                            <td class="center" ng-bind="GM.mapFrecc.fltFTotal | percentage:2"></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td class="center thead-light" contenteditable="true" ng-repeat="(keyFee, frecc) in GM.mapFrecc" ng-bind="frecc.fltFrecc | percentage:2" ng-show="isFrecc(keyFee)" ng-blur="setValue('fltFreccFee', keyRange, $event, keyFee)"></td>
                                            <td class="center" ng-bind="GM.mapFrecc.fltFEETotal | percentage:2" ></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="col-sm-3 col-md-3" ng-hide="GM.hasOverWBlocks">
                                    <table class="table table-striped table-bordered">
                                        <thead class="thead-light">
                                            <tr>
                                                <th colspan="12" class="center" data-toggle="collapse" data-target="#T7Table">
                                                    <a href="#T7Table"> T7 </a>
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody id="T7Table">
                                            <tr class="thead-light">
                                                <th class="center"> Kilómetros  </th>
                                                <th class="center"> Peso <input type="checkbox" ng-model="GM.mapFrecc['T7'].blnSameWeight" ng-click="replicate('AVGWeight', GM.mapFrecc['T7'].blnSameWeight, 'T7')"/></th>
                                                <th class="center"> Volumen <input type="checkbox" ng-model="GM.mapFrecc['T7'].blnSameVol" ng-click="replicate('AVGVol', GM.mapFrecc['T7'].blnSameVol, 'T7')"/> </th>
                                            </tr>
                                            <tr ng-repeat="(keyRange, strRange) in GM.listRange">
                                                <td ng-bind="strRange" width="33%"></td>
                                                <td class="center" contenteditable="true" ng-bind="GM.mapFrecc['T7'].ranges[keyRange].fltAVGWeight | number:2" ng-blur="setValue('fltAVGWeight', keyRange, $event, 'T7')"></td>
                                                <td class="center" contenteditable="true" ng-bind="GM.mapFrecc['T7'].ranges[keyRange].fltAVGVol | number:2" ng-blur="setValue('fltAVGVol', keyRange, $event, 'T7')"></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="row" ng-show="GM.hasOverWBlocks">
                                <!--left-->
                                <div class="col-sm-4 col-md-4">
                                        <table class="table table-striped table-bordered">
                                            <thead class="thead-light">
                                            <tr>
                                                <th colspan="12" class="center" data-toggle="collapse" data-target="#OWFrecc">
                                                    <a href="#OWFrecc">FRECUENCIA T7</a>
                                                </th>
                                            </tr>
                                            </thead>
                                            <tbody id="OWFrecc" class="collapse in" >
                                                <tr>
                                                    <th></th>
                                                    <th class="center" ng-repeat="(keyOW, oWBlock) in GM.OWFrecc" ng-bind="oWBlock.strName" ng-show="oWBlock.strName != undefined"></th>
                                                </tr>
                                                <tr>
                                                    <th class="center" width="25%"> Kilómetros  </th>
                                                    <th class="center" ng-repeat="(keyOW, oWBlock) in GM.OWFrecc" ng-show="oWBlock.strName != undefined">
                                                        <input type="checkbox" ng-model="oWBlock.blnSameFrecc" ng-click="replicate('OWFrecc', oWBlock.blnSameFrecc, keyOW)"/>
                                                    </th>
                                                </tr>
                                                <tr ng-repeat="(keyRange, strRange) in GM.listRange">
                                                    <td class="verticalTH" ng-bind="strRange"></td>
                                                    <td class="center" contenteditable="true" ng-repeat="(keyOW, oWBlock) in GM.OWFrecc"  ng-bind="oWBlock.ranges[keyRange].intFrecuency | number" ng-blur="setValue('intFrecuencyOW', keyRange, $event, keyOW)" ng-show="oWBlock.strName != undefined"></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                <!--left-->
                                <div class="col-sm-8 col-md-8">
                                    <table class="table table-striped table-bordered">
                                        <thead class="thead-light">
                                        <tr>
                                            <th colspan="12" class="center" data-toggle="collapse" data-target="#OWDimensions">
                                                <a href="#OWDimensions">DIMENSIONES PROMEDIO T7</a>
                                            </th>
                                        </tr>

                                        </thead>
                                        <tbody id="OWDimensions" class="collapse in" >
                                        <tr class="thead-light">
                                            <th></th>
                                            <th class="center" ng-repeat="(keyOW, oWBlock) in GM.OWFrecc" ng-bind="oWBlock.strName" ng-show="oWBlock.strName"></th>
                                        </tr>
                                        <tr>
                                            <th class="center" width="20%"> Kilómetros  </th>
                                            <td class="center" ng-repeat="(keyOW, oWBlock) in GM.OWFrecc" ng-show="oWBlock.strName">
                                                <table width="100%">
                                                    <tr>
                                                        <th class="center">Peso <input type="checkbox" ng-model="oWBlock.blnSameWeight" ng-click="replicate('AVGWeightOW', oWBlock.blnSameWeight, keyOW)"/></th>
                                                        <th class="center">Vol <input type="checkbox" ng-model="oWBlock.blnSameVol" ng-click="replicate('AVGVolOW', oWBlock.blnSameVol, keyOW)"/></th>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr ng-repeat="(keyRange, strRange) in GM.listRange">
                                            <td class="verticalTH" ng-bind="strRange"></td>
                                            <td ng-repeat="(keyOW, oWBlock) in GM.OWFrecc" ng-show="oWBlock.strName">
                                                <table width="100%">
                                                    <tr>
                                                        <td class="center" contenteditable="true" ng-bind="oWBlock.ranges[keyRange].fltAVGWeight | number:2" ng-blur="setValue('AVGWeightOW', keyRange, $event, keyOW)"></td>
                                                        <td class="center" contenteditable="true" ng-bind="oWBlock.ranges[keyRange].fltAVGVol | number:2" ng-blur="setValue('AVGVolOW', keyRange, $event, keyOW)"></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12 col-md-12" ng-show="GM.hasOverWBlocks">
                                    <table class="table table-striped table-bordered">
                                        <thead class="thead-light">
                                            <tr>
                                                <th colspan="12" class="center" data-toggle="collapse" data-target="#ZPTable"><a href="#ZPTable">COBERTURA ZONA PLUS</a> </th>
                                            </tr>
                                        </thead>
                                        <tbody id="ZPTable" class="collapse in" >
                                            <tr>
                                                <th class="center"> Kilómetros  </th>
                                                <th class="center" ng-repeat="(keyFee, frecc) in GM.mapFreccZP" ng-bind="keyFee" ng-show="isFrecc(keyFee)" ></th>
                                                <th class="center">PAQUETES</th>
                                                <th class="center">FRECUENCIA</th>
                                            </tr>
                                            <tr ng-repeat="(keyRange, strRange) in GM.listRange">
                                                <td class="verticalTH" ng-bind="strRange"></td>
                                                <td class="center" width="7%" contenteditable="true" ng-repeat="(keyFee, frecc) in GM.mapFreccZP"  ng-bind="frecc.ranges[keyRange].intFrecuency | number" ng-blur="setValue('intFrecuencyZP', keyRange, $event, keyFee)" ng-show="isFrecc(keyFee)"></td>
                                                <td class="center thead-light" width="7%" ng-bind="GM.mapRanges[keyRange]['ZP'].intQTotal | number"></td>
                                                <td class="center thead-light" width="7%" contenteditable="true" ng-bind="GM.mapRanges[keyRange]['ZP'].fltFrecc | percentage:2" ng-blur="setValue('fltFreccRangeZP', keyRange, $event, keyFee)"></td>
                                            </tr>
                                            <tr>
                                                <td class="thead-light">Total</td>
                                                <td class="center thead-light" ng-repeat="(keyFee, frecc) in GM.mapFreccZP"  ng-bind="frecc.intQTotal | number" ng-show="isFrecc(keyFee)"></td>
                                                <td class="center thead-light" contenteditable="true" ng-bind="GM.mapFreccZP.intQTotal | number" ng-blur="setValue('intQTotalZP', keyRange, $event, keyFee)"></td>
                                                <td class="center" ng-bind="GM.mapFreccZP.fltFTotal | percentage:2" ></td>
                                            </tr>
                                            <tr>
                                                <td/>
                                                <td class="center thead-light" contenteditable="true" ng-repeat="(keyFee, frecc) in GM.mapFreccZP" ng-bind="GM.mapFreccZP[keyFee].fltFrecc | percentage:2" ng-show="isFrecc(keyFee)" ng-blur="setValue('fltFreccFeeZP', keyRange, $event, keyFee)"></td>
                                                <td class="center" ng-bind="GM.mapFreccZP.fltFEETotal | percentage:2" ></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="col-sm-9 col-md-9" ng-hide="GM.hasOverWBlocks">
                                    <table class="table table-striped table-bordered">
                                        <thead class="thead-light">
                                        <tr>
                                            <th colspan="12" class="center" data-toggle="collapse" data-target="#ZPTableSmall"><a href="#ZPTableSmall">COBERTURA ZONA PLUS</a> </th>
                                        </tr>
                                        </thead>
                                        <tbody id="ZPTableSmall" class="collapse in" >
                                        <tr>
                                            <th class="center"> Kilómetros  </th>
                                            <th class="center" ng-repeat="(keyFee, frecc) in GM.mapFreccZP" ng-bind="keyFee" ng-show="isFrecc(keyFee)" ></th>
                                            <th></th>
                                            <th class="center">PAQUETES</th>
                                            <th class="center">FRECUENCIA</th>
                                        </tr>
                                        <tr ng-repeat="(keyRange, strRange) in GM.listRange">
                                            <td class="verticalTH" ng-bind="strRange"></td>
                                            <td class="center" width="7%" contenteditable="true" ng-repeat="(keyFee, frecc) in GM.mapFreccZP"  ng-bind="frecc.ranges[keyRange].intFrecuency | number" ng-blur="setValue('intFrecuencyZP', keyRange, $event, keyFee)" ng-show="isFrecc(keyFee)"></td>
                                            <td width="7%"/>
                                            <td class="center thead-light" width="7%" ng-bind="GM.mapRanges[keyRange]['ZP'].intQTotal | number"></td>
                                            <td class="center thead-light" width="7%" contenteditable="true" ng-bind="GM.mapRanges[keyRange]['ZP'].fltFrecc | percentage:2" ng-blur="setValue('fltFreccRangeZP', keyRange, $event, keyFee)"></td>
                                        </tr>
                                        <tr>
                                            <td class="thead-light">Total</td>
                                            <td class="center thead-light" ng-repeat="(keyFee, frecc) in GM.mapFreccZP"  ng-bind="frecc.intQTotal | number" ng-show="isFrecc(keyFee)"></td>
                                            <td/>
                                            <td class="center thead-light" contenteditable="true" ng-bind="GM.mapFreccZP.intQTotal | number" ng-blur="setValue('intQTotalZP', keyRange, $event, keyFee)"></td>
                                            <td class="center" ng-bind="GM.mapFreccZP.fltFTotal | percentage:2" ></td>
                                        </tr>
                                        <tr>
                                            <td/>
                                            <td class="center thead-light" contenteditable="true" ng-repeat="(keyFee, frecc) in GM.mapFreccZP" ng-bind="GM.mapFreccZP[keyFee].fltFrecc | percentage:2" ng-show="isFrecc(keyFee)" ng-blur="setValue('fltFreccFeeZP', keyRange, $event, keyFee)"></td>
                                            <td/>
                                            <td class="center" ng-bind="GM.mapFreccZP.fltFEETotal | percentage:2" ></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- -->
                                <div class="col-sm-9 col-md-9">
                                    <table class="table table-striped table-bordered">
                                        <thead class="thead-light">
                                        <tr>
                                            <th colspan="12" class="center" data-toggle="collapse" data-target="#ZPTableSmall"><a href="#ZPTableSmall">Frecuencia de envios Guias PXS</a> </th>
                                        </tr>
                                        </thead>
                                        <tbody id="ZPTableSmall" class="collapse in">
                                        <tr>
                                            <th class="center"> Kilómetros  </th>
                                            <th class="center" ng-repeat="(keyFee, frecc) in GM.mapFreccPorc" ng-bind="keyFee" ng-show="isFrecc(keyFee)" ></th>
                                            <th class="center">GUIAS</th>
                                            <th class="center">FRECUENCIA</th>
                                        </tr>
                                        <tr>
                                            <th class="center">Paquetes promedio</th>
                                            <th class="center" ng-repeat="(keyFee, frecc) in GM.mapFreccPorc" ng-bind="GM.mapFreccPorc[keyFee].fltCantidad" contenteditable="true" ng-blur="setValue('intFrecuencyPorc', keyFee, $event, keyFee)"  ng-show="isFrecc(keyFee)"></th>
                                        </tr>
                                        <tr>
                                            <th class="center">Calcular</th>
                                            <th class="center" ng-repeat="(keyFee, frecc) in GM.mapFreccPorc" ng-show="isFrecc(keyFee)"><input type="checkbox" ng-model="GM.mapFreccPorc[keyFee].blnCalcular" ng-click="replicate('frecPaqGuias', GM.mapFreccPorc[keyFee].blnCalcular, keyFee)"/></th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                        <tr ng-repeat="(keyRange, strRange) in GM.listRange">
                                            <td class="verticalTH" ng-bind="strRange"></td>
                                            <td class="center" width="7%" contenteditable="true" ng-repeat="(keyFee, frecc) in GM.mapFreccPorc"  ng-bind="frecc.ranges[keyRange].intFrecuency | number" ng-blur="setValue('intPaqGuias', keyRange, $event, keyFee)" ng-show="isFrecc(keyFee)"></td>
                                            <td class="center thead-light" width="7%" ng-bind="GM.mapRanges[keyRange]['POR'].intQTotal | number"></td>
                                            <td class="center thead-light" width="7%" contenteditable="true" ng-bind="GM.mapRanges[keyRange]['POR'].fltFrecc | percentage:2" ng-blur="setValue('fltFreccRangeZP', keyRange, $event, keyFee)"></td>
                                        </tr>
                                        <tr>
                                            <td class="thead-light">Total</td>
                                            <td class="center thead-light" ng-repeat="(keyFee, frecc) in GM.mapFreccPorc"  ng-bind="frecc.intQTotal | number" ng-show="isFrecc(keyFee)"></td>
                                            <td class="center thead-light" contenteditable="true" ng-bind="GM.mapFreccPorc.intQTotal | number" ng-blur="setValue('intQTotalZP', keyRange, $event, keyFee)"></td>
                                            <td class="center" ng-bind="GM.mapFreccPorc.fltFTotal | percentage:2" ></td>
                                        </tr>
                                        <tr>
                                            <td/>
                                            <td class="center thead-light" contenteditable="true" ng-repeat="(keyFee, frecc) in GM.mapFreccPorc" ng-bind="GM.mapFreccPorc[keyFee].fltFrecc | percentage:2" ng-show="isFrecc(keyFee)" ng-blur="setValue('fltFreccFeeZP', keyRange, $event, keyFee)"></td>
                                            <td class="center" ng-bind="GM.mapFreccPorc.fltFEETotal | percentage:2" ></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- -->
                                <div class="col-sm-9 col-md-9">
                                    <table class="table table-striped table-bordered">
                                        <thead class="thead-light">
                                        <tr>
                                            <th colspan="12" class="center" data-toggle="collapse" data-target="#ZPTableSmall"><a href="#ZPTableSmall">Frecuencia de envios Guias ZONA PLUS</a> </th>
                                        </tr>
                                        </thead>
                                        <tbody id="ZPTableSmall" class="collapse in">
                                        <tr>
                                            <th class="center"> Kilómetros  </th>
                                            <th class="center" ng-repeat="(keyFee, frecc) in GM.mapFreccPorcZP" ng-bind="keyFee" ng-show="isFrecc(keyFee)" ></th>
                                            <th></th>
                                            <th class="center">PAQUETES</th>
                                            <th class="center">FRECUENCIA</th>
                                        </tr>
                                        <tr>
                                            <th class="center">Paquetes promedio</th>
                                            <th class="center" ng-repeat="(keyFee, frecc) in GM.mapFreccPorcZP" ng-bind="GM.mapFreccPorcZP[keyFee].fltCantidad" contenteditable="true" ng-blur="setValue('intFrecuencyPorcZP', keyFee, $event, keyFee)"></th>
                                        </tr>
                                        <tr>
                                            <th class="center">Calcular</th>
                                            <th class="center" ng-repeat="(keyFee, frecc) in GM.mapFreccPorcZP" ng-show="isFrecc(keyFee)"><input type="checkbox" ng-model="GM.mapFreccPorcZP[keyFee].blnCalcular" ng-click="replicate('frecPaqGuiasZP', GM.mapFreccPorcZP[keyFee].blnCalcular, keyFee)"/></th>
                                            <th></th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                        <tr ng-repeat="(keyRange, strRange) in GM.listRange">
                                            <td class="verticalTH" ng-bind="strRange"></td>
                                            <td class="center" width="7%" contenteditable="true" ng-repeat="(keyFee, frecc) in GM.mapFreccPorcZP"  ng-bind="frecc.ranges[keyRange].intFrecuency | number" ng-blur="setValue('intPaqGuiasZP', keyRange, $event, keyFee)" ng-show="isFrecc(keyFee)"></td>
                                            <td width="7%"/>
                                            <td class="center thead-light" width="7%" ng-bind="GM.mapRanges[keyRange]['PORZP'].intQTotal | number"></td>
                                            <td class="center thead-light" width="7%" contenteditable="true" ng-bind="GM.mapRanges[keyRange]['PORZP'].fltFrecc | percentage:2" ng-blur="setValue('fltFreccRangeZP', keyRange, $event, keyFee)"></td>
                                        </tr>
                                        <tr>
                                            <td class="thead-light">Total</td>
                                            <td class="center thead-light" ng-repeat="(keyFee, frecc) in GM.mapFreccPorcZP"  ng-bind="frecc.intQTotal | number" ng-show="isFrecc(keyFee)"></td>
                                            <td/>
                                            <td class="center thead-light" contenteditable="true" ng-bind="GM.mapFreccPorcZP.intQTotal | number" ng-blur="setValue('intQTotalZP', keyRange, $event, keyFee)"></td>
                                            <td class="center" ng-bind="GM.mapFreccPorcZP.fltFTotal | percentage:2" ></td>
                                        </tr>
                                        <tr>
                                            <td/>
                                            <td class="center thead-light" contenteditable="true" ng-repeat="(keyFee, frecc) in GM.mapFreccPorcZP" ng-bind="GM.mapFreccZP[keyFee].fltFrecc | percentage:2" ng-show="isFrecc(keyFee)" ng-blur="setValue('fltFreccFeeZP', keyRange, $event, keyFee)"></td>
                                            <td/>
                                            <td class="center" ng-bind="GM.mapFreccPorcZP.fltFEETotal | percentage:2" ></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Descuentos -->
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <a data-toggle="collapse" href="#Desc"><h3 class="panel-title">DESCUENTOS </h3></a>
                    </div>
                    <div id="Desc" class="panel-collapse collapse in">
                        <div class="panel-body">
                            <div class="row">
                                <!--left-->
                                <div class="col-sm-6 col-md-6">
                                        <table class="table table-striped table-bordered">
                                        <thead class="thead-light">
                                        <tr>
                                            <th colspan="6" class="center"> COBERTURA PAQUETEXPRESS </th>
                                        </tr>
                                        <tr>
                                            <th class="center"></th>
                                            <th class="center"> Peso (kg)</th>
                                            <th class="center" colspan="2">Descuento máximo</th>
                                            <th class="center" colspan="2">Descuento promedio</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                            <tr ng-repeat="(keyFee, fee) in ProjectionGM.PAQ">
                                                <td class="center" ng-bind="fee.strFee"></td>
                                                <td class="center" ng-bind="fee.fltWeight | number"></td>
                                                <td class="center"><span class="circle" ng-class="{green: isGreen(fee.fltMaxDisc), yellow: isYellow(fee.fltMaxDisc), red  : isRed(fee.fltMaxDisc)}"></span></td>
                                                <td class="center" ng-bind="fee.fltMaxDisc | percentage:2"></td>
                                                <td class="center"><span class="circle" ng-class="{green: isGreen(fee.fltDisc), yellow: isYellow(fee.fltDisc), red  : isRed(fee.fltDisc)}"></span></td>
                                                <td class="center" ng-bind="fee.fltDisc | percentage:2"></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <!--right-->
                                <div class="col-sm-6 col-md-6">
                                    <table class="table table-striped table-bordered">
                                        <thead class="thead-light">
                                        <tr>
                                            <th colspan="6" class="center"> COBERTURA ZONA PLUS </th>
                                        </tr>
                                        <tr>
                                            <th class="center"></th>
                                            <th class="center"> Peso (kg)</th>
                                            <th class="center" colspan="2">Descuento máximo</th>
                                            <th class="center" colspan="2">Descuento promedio</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                            <tr ng-repeat="(keyFee, fee) in ProjectionGM.ZP">
                                                <td class="center" ng-bind="fee.strFee"></td>
                                                <td class="center" ng-bind="fee.fltWeight | number"></td>
                                                <td class="center"><span class="circle" ng-class="{green: isGreen(fee.fltMaxDisc), yellow: isYellow(fee.fltMaxDisc), red  : isRed(fee.fltMaxDisc)}"></span></td>
                                                <td class="center" ng-bind="fee.fltMaxDisc | percentage:2"></td>
                                                <td class="center"><span class="circle" ng-class="{green: isGreen(fee.fltDisc), yellow: isYellow(fee.fltDisc), red  : isRed(fee.fltDisc)}"></span></td>
                                                <td class="center" ng-bind="fee.fltDisc | percentage:2"></td>
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
        <div class="row" ng-show="GM.step2">
            <div class="col-md-6 col-sm-6">
                <div class="row" ng-repeat="(strKey, pro) in GM.mapProjGM" ng-if="pro.strFee !=  'T7'">
                    <h3>TARIFA {{ pro.strFee }} ZP - {{ pro.fltMaxW }} kg </h3>
                    <table class="table table-striped table-bordered" style="overflow-x: scroll">
                                <thead class="thead-light">
                                <tr>
                                    <th>KM</th>
                                    <th>Tarifa</th>
                                    <th>#</th>
                                    <th>RAD</th>
                                    <th>EAD</th>
                                    <th>ACK</th>
                                    <th>Seguro</th>
                                    <th>T.llena</th>
                                    <th>BaseQ</th>
                                    <th>ACKQ</th>
                                    <th>FullQ</th>
                                    <th>TNORMAL</th>
                                    <th>TPROP</th>
                                    <th>Disc</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr ng-repeat="(keyRange, range) in pro.ranges">
                                    <td ng-bind="keyRange"></td>
                                    <td ng-bind="GM.mapFrecc[pro.strFee].ranges[keyRange].fltBaseFee | currency"></td>
                                    <td ng-bind="GM.mapFrecc[pro.strFee].ranges[keyRange].intFrecuency | number"></td>
                                    <td ng-bind="GM.mapFrecc[pro.strFee].ranges[keyRange].fltRAD | currency"></td>
                                    <td ng-bind="GM.mapFrecc[pro.strFee].ranges[keyRange].fltEAD | currency"></td>
                                    <td ng-bind="GM.mapFrecc[pro.strFee].ranges[keyRange].fltACK | currency"></td>
                                    <td ng-bind="GM.mapFrecc[pro.strFee].ranges[keyRange].fltSEG | currency"></td>
                                    <td ng-bind="GM.mapFrecc[pro.strFee].ranges[keyRange].fltFullFee | currency"></td>
                                    <td ng-bind="range.fltQuoteFee | currency"></td>
                                    <td ng-bind="range.fltACK | currency"></td>
                                    <td ng-bind="range.fltQuoteFullFee | currency"></td>
                                    <td ng-bind="GM.mapFrecc[pro.strFee].ranges[keyRange].fltTotalNormal | currency"></td>
                                    <td ng-bind="range.fltTotalQuote | currency"></td>
                                    <td ng-bind="range.fltDisc | percentage:2"></td>
                                </tr>
                                <tr>
                                    <td>Total</td>
                                    <td colspan="10" />
                                    <td ng-bind="pro.fltTotalNormal | currency"></td>
                                    <td ng-bind="pro.fltTotalQuote | currency"></td>
                                    <td ng-bind="pro.fltDisc | percentage:2"></td>
                                </tr>
                                </tbody>
                            </table>
                </div>
            </div>
            <div class="col-md-6 col-sm-6">
                <div class="row" ng-repeat="(strKey, pro) in GM.mapProjGMZP" >
                    <h3>TARIFA {{ pro.strFee }} ZP - {{ pro.fltMaxW }} kg </h3>
                    <table class="table table-striped table-bordered" style="overflow-x: scroll">
                                <thead class="thead-light">
                                <tr>
                                    <th>KM</th>
                                    <th>Tarifa</th>
                                    <th>#</th>
                                    <th>RAD</th>
                                    <th>EAD</th>
                                    <th>ACK</th>
                                    <th>Seguro</th>
                                    <th>T.llena</th>
                                    <th>BaseQ</th>
                                    <th>ACKQ</th>
                                    <th>FullQ</th>
                                    <th>TNORMAL</th>
                                    <th>TPROP</th>
                                    <th>Disc</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr ng-repeat="(keyRange, range) in pro.ranges">
                                    <td ng-bind="keyRange"></td>
                                    <td ng-bind="GM.mapFreccZP[pro.strFee].ranges[keyRange].fltBaseFee | currency"></td>
                                    <td ng-bind="GM.mapFreccZP[pro.strFee].ranges[keyRange].intFrecuency | number"></td>
                                    <td ng-bind="GM.mapFreccZP[pro.strFee].ranges[keyRange].fltRAD | currency"></td>
                                    <td ng-bind="GM.mapFreccZP[pro.strFee].ranges[keyRange].fltEAD | currency"></td>
                                    <td ng-bind="GM.mapFreccZP[pro.strFee].ranges[keyRange].fltACK | currency"></td>
                                    <td ng-bind="GM.mapFreccZP[pro.strFee].ranges[keyRange].fltSEG | currency"></td>
                                    <td ng-bind="GM.mapFreccZP[pro.strFee].ranges[keyRange].fltFullFee | currency"></td>
                                    <td ng-bind="range.fltQuoteFee | currency"></td>
                                    <td ng-bind="range.fltACK | currency"></td>
                                    <td ng-bind="range.fltQuoteFullFee | currency"></td>
                                    <td ng-bind="GM.mapFreccZP[pro.strFee].ranges[keyRange].fltTotalNormal | currency"></td>
                                    <td ng-bind="range.fltTotalQuote | currency"></td>
                                    <td ng-bind="range.fltDisc | percentage:2"></td>
                                </tr>
                                <tr>
                                    <td>Total</td>
                                    <td colspan="10" />
                                    <td ng-bind="pro.fltTotalNormal | currency"></td>
                                    <td ng-bind="pro.fltTotalQuote | currency"></td>
                                    <td ng-bind="pro.fltDisc | percentage:2"></td>
                                </tr>
                                </tbody>
                            </table>
                </div>
            </div>
        </div>
        <div class="row" ng-show="GM.step2">
            <div class="row">
                <div class="row" ng-repeat="(keyOW, oWBlock) in GM.OWFrecc"  ng-show="oWBlock.strName != undefined">
                <!--<div class="row" ng-repeat="(strKey, pro) in GM.OWFrecc" ng-if="pro.strFee ==  'T7_' + {{ GM.mapProjGM['T7'].fltMaxW }}">-->
                    <!--<h3>TARIFA T7 - {{ GM.mapProjGM['T7'].fltMaxW }} kg </h3>-->
                    <h3> TARIFA T7 - V</h3>
                    <table class="table table-striped table-bordered" style="overflow-x: scroll">
                                <thead class="thead-light">
                                <tr>
                                    <th>KM</th>
                                    <th>Tarifa</th>
                                    <th>#</th>
                                    <th>RAD</th>
                                    <th>EAD</th>
                                    <th>ACK</th>
                                    <th>Seguro</th>
                                    <th>T.llena</th>
                                    <th>BaseQ</th>
                                    <th>ACKQ</th>
                                    <th>FullQ</th>
                                    <th>TNORMAL</th>
                                    <th>TPROP</th>
                                    <th>Disc</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr ng-repeat="(keyRange, range) in GM.mapProjGM['T7'].ranges">
                                    <td ng-bind="keyRange"></td>
                                    <td ng-bind="GM.mapFrecc[GM.mapProjGM['T7'].strFee].ranges[keyRange].fltBaseFee + GM.mapFrecc[GM.mapProjGM['T7'].strFee].ranges[keyRange].fltBaseFee | currency"></td>
                                    <td ng-bind="GM.mapFrecc[GM.mapProjGM['T7'].strFee].ranges[keyRange].intFrecuency | number"></td>
                                    <td ng-bind="GM.mapFrecc[GM.mapProjGM['T7'].strFee].ranges[keyRange].fltRAD | currency"></td>
                                    <td ng-bind="GM.mapFrecc[GM.mapProjGM['T7'].strFee].ranges[keyRange].fltEAD | currency"></td>
                                    <td ng-bind="GM.mapFrecc[GM.mapProjGM['T7'].strFee].ranges[keyRange].fltACK | currency"></td>
                                    <td ng-bind="GM.mapFrecc[GM.mapProjGM['T7'].strFee].ranges[keyRange].fltSEG | currency"></td>
                                    <td ng-bind="GM.mapFrecc[GM.mapProjGM['T7'].strFee].ranges[keyRange].fltFullFee | currency"></td>
                                    <td ng-bind="range.fltQuoteBaseFee | currency"></td>
                                    <td ng-bind="range.fltACK | currency"></td>
                                    <td ng-bind="range.fltQuoteFullFee | currency"></td>
                                    <td ng-bind="GM.mapFrecc[GM.mapProjGM['T7'].strFee].ranges[keyRange].fltTotalNormal | currency"></td>
                                    <td ng-bind="range.fltTotalQuote | currency"></td>
                                    <td ng-bind="range.fltDisc | percentage:2"></td>
                                </tr>
                                <tr>
                                    <td>Total</td>
                                    <td colspan="10" />
                                    <td ng-bind="GM.mapProjGM['T7'].fltTotalNormal | currency"></td>
                                    <td ng-bind="GM.mapProjGM['T7'].fltTotalQuote | currency"></td>
                                    <td ng-bind="GM.mapProjGM['T7'].fltDisc | percentage:2"></td>
                                </tr>
                                </tbody>
                            </table>
                </div>
            </div>
        </div>
        <!-- messages -->
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
        <!--modal servicios-->
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <div class="modal fade" id="ModalServicesGM" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                                                <a href="#" class="list-group-item active">Servicios Disponibles<input title="toggle all" type="checkbox" class="all pull-right" ng-model="GM.blnServiceAddAll" ng-click="addAll('add')"/></a>
                                                <a href="#" class="list-group-item" ng-repeat="(i, service) in GM.ServiceSelect.available" ng-click="clickFee(i, 'serviceAdd')">
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
                                                <a href="#" class="list-group-item active">Servicios Seleccionados <input title="toggle all" type="checkbox" class="all pull-right" ng-model="GM.blnServiceRemoveAll" ng-click="addAll('remove')"/></a>
                                                <a href="#" class="list-group-item" ng-repeat="(i, service) in GM.ServiceSelect.selected" ng-click="clickFee(i, 'serviceRemove')">
                                                    <span ng-bind="service.label"></span>
                                                    <span class="glyphicon glyphicon-remove" ng-show="service.blnSelected"/>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row custom-control custom-radio" ng-show="GM.blnSEG">
                                    <div class="col-sm-1 col-md-1" />
                                    <div class="col-sm-3 col-md-3"><label class="custom-control-label" >Monto asegurado</label></div>
                                    <div class="col-sm-3 col-md-3"><input type="number" class="custom-control-input rouded-med" ng-model="GM.fltSEG" ng-change="calculateGM();"/></div>
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
                <div class="modal fade" id="GMModalDestiny" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                                            <div class="col-sm-3 col-md-3"><input type="text" class="custom-control-input rouded" ng-model="GM.strOrigin" maxlength="3" ng-disabled="GM.OriginDisabled"/></div>

                                            <div class="col-sm-3 col-md-3"><label class="custom-control-label" > Destino </label></div>
                                            <div class="col-sm-3 col-md-3"><input type="text" class="custom-control-input rouded" ng-model="GM.strDestiny" maxlength="3"/></div>
                                        </div>
                                        <br/>
                                        <div class="row" ng-show="GM.OriginDisabled">
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
                                                    <tr ng-repeat="(strDestinyKey, destiny) in GM.listDestiny" >
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
        <!-- buttons -->
        <div class="row right">
            <div class="btn-group ">
                <button type="button" class="btn btn-default" ng-click="exit()">
                    <span class="glyphicon glyphicon-menu-left"></span> Salir
                </button>
                <button type="button" class="btn btn-primary" ng-click="redireccionar()">
                    Cotizar T7 zona plus
                </button>
                <button type="button" class="btn btn-primary" ng-click="sumbit()" ng-show="hasRecord()">
                    Enviar a Autorización <span class="glyphicon glyphicon-check"></span>
                </button>
                <button type="button" class="btn btn-primary" ng-click="createQuotesGM()">
                    Guardar <span class="glyphicon glyphicon-floppy-disk"></span>
                </button>
                <button type="button" class="btn btn-danger" ng-click="dataTest()">
                    DATA TEST
                </button>
                <button type="button" class="btn btn-default" ng-click="back()" ng-show="GM.step2 && isAdmin()">
                    <span class="glyphicon glyphicon-menu-left"></span> Atras
                </button>
                <button type="button" class="btn btn-primary" ng-click="next()" ng-show="GM.step1 && isAdmin()">
                    Siguiente <span class="glyphicon glyphicon-menu-right"></span>
                </button>
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
            app.controller('GMPController', ['$scope',function($scope) {

                /*
                * Controller variables
                */
                $scope.DeletedDestiny = [];
                $scope.DestinyErrorMessage = '';
                $scope.DestinySuccessMessage = '';
                $scope.GM = {
                    strACK : ''
                    , strOrigin : ''
                    , strDestiny : ''
                    , strOrigen : ''
                    , fltMaxG : 1
                    , step1 : true
                    , step2 : false
                    , blnServiceAddAll : false
                    , blnServiceRemoveAll : false
                    , blnRAD : false
                    , blnEAD : false
                    , blnACK : false
                    , blnSEG : false
                    , blnZP : false
                    , blnSameAddCost : false
                    , hasOverWBlocks : false
                    , hasBlocksT7 : false
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
                    , listFeeZP : {
                        'TS': 'TARIFA SOBRE'
                        , 'T0': 'TARIFA T0'
                        , 'T1': 'TARIFA T1'
                        , 'T2': 'TARIFA T2'
                        , 'T3': 'TARIFA T3'
                        , 'T4': 'TARIFA T4'
                        , 'T5': 'TARIFA T5'
                        , 'T6': 'TARIFA T6'
                    }
                    , listDestiny : {}
                    , listRange : {}
                    , OriginDisabled : false
                    , OriginalListRange : {
                        '0-400': '0-400'
                        , '401-800': '401-800'
                        , '801-1200': '801-1200'
                        , '1201-1600': '1201-1600'
                        , '1601-2000': '1601-2000'
                        , '2001-2400': '2001-2400'
                        , '+2400' :'Más de 2400'
                    }
                    , mapRanges : {
                        '0-400': {
                            'PAQ': {fltFrecc: 0, intQTotal:0}
                            , 'ZP' :{fltFrecc: 0, intQTotal:0}
                            , 'T7' :{fltFrecc: 0, intQTotal:0}
                            , 'POR' :{fltFrecc: 0, intQTotal:0}
                            , 'PORZP' :{fltFrecc: 0, intQTotal:0}
                        }
                        , '401-800': {
                            'PAQ': {fltFrecc: 0, intQTotal:0}
                            , 'ZP' :{fltFrecc: 0, intQTotal:0}
                            , 'T7' :{fltFrecc: 0, intQTotal:0}
                            , 'POR' :{fltFrecc: 0, intQTotal:0}
                            , 'PORZP' :{fltFrecc: 0, intQTotal:0}
                        }
                        , '801-1200': {
                            'PAQ': {fltFrecc: 0, intQTotal:0}
                            , 'ZP' :{fltFrecc: 0, intQTotal:0}
                            , 'T7' :{fltFrecc: 0, intQTotal:0}
                            , 'POR' :{fltFrecc: 0, intQTotal:0}
                            , 'PORZP' :{fltFrecc: 0, intQTotal:0}
                        }
                        , '1201-1600': {
                            'PAQ': {fltFrecc: 0, intQTotal:0}
                            , 'ZP' :{fltFrecc: 0, intQTotal:0}
                            , 'T7' :{fltFrecc: 0, intQTotal:0}
                            , 'POR' :{fltFrecc: 0, intQTotal:0}
                            , 'PORZP' :{fltFrecc: 0, intQTotal:0}
                        }
                        , '1601-2000': {
                            'PAQ': {fltFrecc: 0, intQTotal:0}
                            , 'ZP' :{fltFrecc: 0, intQTotal:0}
                            , 'T7' :{fltFrecc: 0, intQTotal:0}
                            , 'POR' :{fltFrecc: 0, intQTotal:0}
                            , 'PORZP' :{fltFrecc: 0, intQTotal:0}
                        }
                        , '2001-2400': {
                            'PAQ': {fltFrecc: 0, intQTotal:0}
                            , 'ZP' :{fltFrecc: 0, intQTotal:0}
                            , 'T7' :{fltFrecc: 0, intQTotal:0}
                            , 'POR' :{fltFrecc: 0, intQTotal:0}
                            , 'PORZP' :{fltFrecc: 0, intQTotal:0}
                        }
                        , '+2400': {
                            'PAQ': {fltFrecc: 0, intQTotal:0}
                            , 'ZP' :{fltFrecc: 0, intQTotal:0}
                            , 'T7' :{fltFrecc: 0, intQTotal:0}
                            , 'POR' :{fltFrecc: 0, intQTotal:0}
                            , 'PORZP' :{fltFrecc: 0, intQTotal:0}
                        }
                    }
                    /*, mapLimits:{
                        'TS': { max : 1, min : 0.49 }
                        , 'T0': { max : 5, min : 0.49}
                        , 'T1': { max : 10, min : 5}
                        , 'T2': { max : 20, min : 10}
                        , 'T3': { max : 30, min : 20}
                        , 'T4': { max : 40, min : 30}
                        , 'T5': { max : 50, min : 40}
                        , 'T6': { max : 60, min : 50}
                    }*/
                    , mapLimits:{
                        'TS': { max : 1, min : 0.49 }
                        , 'T0': { max : 5, min : 0.49}
                        , 'T1': { max : 10, min : 6}
                        , 'T2': { max : 20, min : 11}
                        , 'T3': { max : 30, min : 21}
                        , 'T4': { max : 40, min : 31}
                        , 'T5': { max : 50, min : 41}
                        , 'T6': { max : 60, min : 51}
                    }
                    , mapBlock : {

                    }
                    , OWFrecc : {
                         intQTotal : 0
                        , fltFTotal : 0
                        , fltFEETotal : 0
                    }
                    , mapService : {
                        'Add' : {
                            ranges : {}
                        }
                        , 'ZP' : {
                            blnSameCost : false
                            , ranges : {}
                        }
                        , 'ACK' : {
                            blnSameCost : false
                            , fltAVGDeliveryByACK : 0
                            , fltAVGPackByDay : 0
                            , optOption :{
                                model : undefined
                                , aviableOptions:[
                                    {id : 'Interno', label:'Acuse Interno'}
                                    , { id : 'Empresa', label:'Acuse Empresa'}
                                    , { id : 'XT', label:'Acuse XT'}
                                ]
                            }
                            , optForma :{
                                model : undefined
                                , aviableOptions:[
                                    {id : 'G', label:'Por Guía'}
                                    , { id : 'B', label:'Por Bulto'}
                                ]
                            }
                            , ranges : {}
                        }
                    }
                    , ServiceSelect : {
                        available : [
                            {id:'RAD' , label : 'Recolección a domicilio', blnSelected : false }
                            , {id:'EAD' , label : 'Entrega a domicilio', blnSelected : false }
                            //, {id:'SEG' , label : 'Seguro', blnSelected : false }
                            , {id:'ACK' , label : 'Acuse', blnSelected : false }
                        ]
                        , selected : []
                    }
                    , mapFrecc : {
                        'TS':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T0':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T1':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T2':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T3':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T4':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T5':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T6':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T7':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T7P':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T7V':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , intQTotal : 0
                        , fltFTotal : 0
                        , fltFEETotal : 0
                    }
                    , mapPropuesta : {}
                    , mapTarifas7 : {}
                    , mapFreccPorcT7ZP : {}
                    , mapFreccPorc : {
                        'TS':{ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false}
                        , 'T0':{ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false}
                        , 'T1':{ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false}
                        , 'T2':{ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false}
                        , 'T3':{ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false}
                        , 'T4':{ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false}
                        , 'T5':{ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false}
                        , 'T6':{ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false}
                        , 'T7':{ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false}
                        , intQTotal : 0
                        , fltFTotal : 0
                        , fltFEETotal : 0
                    }
                    , mapFreccPorcZP : {
                        'TS':{ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false}
                        , 'T0':{ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false}
                        , 'T1':{ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false}
                        , 'T2':{ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false}
                        , 'T3':{ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false}
                        , 'T4':{ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false}
                        , 'T5':{ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false}
                        , 'T6':{ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false}
                        , intQTotal : 0
                        , fltFTotal : 0
                        , fltFEETotal : 0
                    }
                    , mapFreccZP : {
                        'TS':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T0':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T1':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T2':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T3':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T4':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T5':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T6':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , intQTotal : 0
                        , fltFTotal : 0
                        , fltFEETotal : 0
                    }
                    , mapFreccZPPorc : {
                        'TS':{ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false}
                        , 'T0':{ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false}
                        , 'T1':{ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false}
                        , 'T2':{ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false}
                        , 'T3':{ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false}
                        , 'T4':{ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false}
                        , 'T5':{ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false}
                        , 'T6':{ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false}
                        , intQTotal : 0
                        , fltFTotal : 0
                        , fltFEETotal : 0
                    }
                    , mapProjGM : {
                        'TS': {}
                        , 'T0': {}
                        , 'T1': {}
                        , 'T2': {}
                        , 'T3': {}
                        , 'T4': {}
                        , 'T5': {}
                        , 'T6': {}
                        , 'T7': {}
                    }
                    , mapProjGMZP : {
                        'TS': {}
                        , 'T0': {}
                        , 'T1': {}
                        , 'T2': {}
                        , 'T3': {}
                        , 'T4': {}
                        , 'T5': {}
                        , 'T6': {}
                    }
                    , mapQuotes : {
                        'TS':{}
                        , 'T0':{}
                        , 'T1':{}
                        , 'T2':{}
                        , 'T3':{}
                        , 'T4':{}
                        , 'T5':{}
                        , 'T6':{}
                        , 'T7':{}}
                    , mapQuotesZP : {
                        'TS':{}
                        , 'T0':{}
                        , 'T1':{}
                        , 'T2':{}
                        , 'T3':{}
                        , 'T4':{}
                        , 'T5':{}
                        , 'T6':{}
                    }
                    , mapQuotesPorc : {
                        'TS':{}
                        , 'T0':{}
                        , 'T1':{}
                        , 'T2':{}
                        , 'T3':{}
                        , 'T4':{}
                        , 'T5':{}
                        , 'T6':{}
                        , 'T7':{}}
                    , mapQuotesPorcZP : {
                        'TS':{}
                        , 'T0':{}
                        , 'T1':{}
                        , 'T2':{}
                        , 'T3':{}
                        , 'T4':{}
                        , 'T5':{}
                        , 'T6':{}}
                    , TOTAL : {
                        'PAQUETES': 0
                        , 'NORMAL': 0
                        , 'PROPUESTA': 0
                        , 'SEGURO': 0
                        , 'DESCUENTO': 0
                        , 'GUIAS': 0
                    }
                    , mapTender : {}
                };
                $scope.listFee = {
                    'TS': 'TARIFA TS'
                    , 'T0': 'TARIFA T0'
                    , 'T1': 'TARIFA T1'
                    , 'T2': 'TARIFA T2'
                    , 'T3': 'TARIFA T3'
                    , 'T4': 'TARIFA T4'
                    , 'T5': 'TARIFA T5'
                    , 'T6': 'TARIFA T6'
                    , 'T7': 'TARIFA T7'
                };
                $scope.listBlocksByMaxW = [];
                $scope.ProjectionGM = {
                    'PAQ' : {}
                    , 'ZP' : {}
                    , fltTotalNormal : 0
                    , fltTotalQuote : 0
                    , fltTotalSEG : 0
                    , fltDisc : 0
                };
                $scope.GM.mapPropuesta['PROP'] = { //29/09/2020 Salvador: Mapa para almacenar la propuesta de T7 ZP
                    ranges : []
                    , intFeeTotalFrec : 0
                    , fltFeeTotalNormal : 0
                    , fltFeeTotalQuote : 0
                    , fltFeeTotalSEG : 0
                    , fltFeeTotalDesc : 0
                    , fltDisc : 0
                    , blnSameQuote : false
                };
                $scope.GM.mapQuotesT7ZP = {
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
                j$.each($scope.GM.listRange, function (key, str) {
                    $scope.GM.mapService['Add'].ranges[key] = { fltCostWeight : 0, fltCostVol : 0};
                    $scope.GM.mapService['ACK'].ranges[key] = { fltCost : 0 };
                    $scope.GM.mapService['ZP'].ranges[key] = { fltCost : 0 };
                    j$.each($scope.listFee, function (keyFee, strFee) {
                        $scope.GM.mapFrecc[keyFee].ranges[key] = {
                            intFrecuency : 0
                            , fltBaseFee : 0
                            , fltFullFee : 0
                            , fltRAD : 0
                            , fltEAD : 0
                            , fltACK : 0
                            , fltSEG : 0
                            , fltTotalNormal : 0
                        };
                        if(keyFee !== 'T7')
                            $scope.GM.mapFreccZP[keyFee].ranges[key] = {
                                intFrecuency : 0
                                , fltBaseFee : 0
                                , fltFullFee : 0
                                , fltRAD : 0
                                , fltEAD : 0
                                , fltACK : 0
                                , fltSEG : 0
                                , fltTotalNormal : 0
                            };
                        else {
                            $scope.GM.mapFrecc[keyFee].ranges[key].fltAVGWeight = 0;
                            $scope.GM.mapFrecc[keyFee].ranges[key].fltAVGVol = 0;
                        }
                        /*$scope.GM.mapQuotes[keyFee][key] = {};
                        if(keyFee !== 'T7')
                            $scope.GM.mapQuotesZP[keyFee][key] = {};*/
                    });
                    $scope.GM.mapFrecc['T7P'].ranges[key] = {
                        intFrecuency : 0
                        , fltBaseFee : 0
                        , fltFullFee : 0
                        , fltRAD : 0
                        , fltEAD : 0
                        , fltACK : 0
                        , fltSEG : 0
                        , fltTotalNormal : 0
                        , fltAVGWeight : 1
                        , fltAVGVol : 1
                    };
                    $scope.GM.mapFrecc['T7V'].ranges[key] = {
                        intFrecuency : 0
                        , fltBaseFee : 0
                        , fltFullFee : 0
                        , fltRAD : 0
                        , fltEAD : 0
                        , fltACK : 0
                        , fltSEG : 0
                        , fltTotalNormal : 0
                        , fltAVGWeight : 1
                        , fltAVGVol : 1
                    };

                });
                /*
                * Controller functions
                */
                $scope.addAll = function(strOpr){
                    if(strOpr === 'add')
                        j$.each($scope.GM.ServiceSelect.available, function (i, serv) {
                            serv.blnSelected = $scope.GM.blnServiceAddAll;
                        });
                    else if(strOpr === 'remove')
                        j$.each($scope.GM.ServiceSelect.selected, function (i, serv) {
                            serv.blnSelected = $scope.GM.blnServiceRemoveAll;;
                        });
                };

                $scope.addBlock = function(fltMaxW){
                    var key = '';
                    var strkey = '';
                    if(fltMaxW <= 60){
                        //if(fltMaxW === 1){
                        if(fltMaxW > 0.49 && fltMaxW <= 1 || fltMaxW === 0.49){
                            key = 'TS1';
                            $scope.GM.mapBlock['TS1'] = {
                                strLabel : 'TS'
                                , fltMaxW : fltMaxW
                                , fltVolW : 0
                                , fltVolWeight: 0
                                , blnSameCost : false
                                , ranges : {}
                            };
                            $scope.listBlocksByMaxW.push({key:key, value: fltMaxW});
                            j$.each($scope.GM.listRange, function (keyRange, strRange) {
                                $scope.GM.mapBlock[key].ranges[keyRange] = {
                                    fltCost : 0
                                };
                            });
                        } else {
                            j$.each($scope.GM.mapLimits, function (keyFee, limits) {
                                key = keyFee;
                                strKey = fltMaxW.toString();
                                key += strKey.replace('.', '_');
                                if(fltMaxW > limits.min && fltMaxW <= limits.max){
                                    $scope.GM.mapBlock[key] = {
                                        strLabel : keyFee
                                        , fltMaxW : fltMaxW
                                        , fltVolW : 0
                                        , fltVolWeight: 0
                                        , blnSameCost : false
                                        , ranges : {}
                                    };
                                    $scope.listBlocksByMaxW.push({key:key, value: fltMaxW});
                                    j$.each($scope.GM.listRange, function (keyRange, strRange) {
                                        $scope.GM.mapBlock[key].ranges[keyRange] = {
                                            fltCost : 0
                                        };
                                    });
                                }
                            });
                        }
                    }
                    else{
                        $scope.GM.hasBlocksT7 = true;
                        $scope.GM.hasOverWBlocks = true;
                        key = 'T7';
                        strKey = fltMaxW.toString();
                        key += strKey.replace('.', '_');
                        $scope.GM.mapBlock[key] = {
                            strLabel : 'T7'
                            , fltMaxW : fltMaxW
                            , fltVolW : 0
                            , fltVolWeight: 0
                            , blnSameCost : false
                            , blnT7ZP : false
                            , ranges : {}
                        };
                        $scope.listBlocksByMaxW.push({key:key, value: fltMaxW});
                        $scope.GM.mapFreccPorc['T7_' + fltMaxW] = {
                            fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false,
                            ranges : {}
                        };
                        j$.each($scope.GM.listRange, function (keyRange, strRange) {
                            $scope.GM.mapBlock[key].ranges[keyRange] = {
                                fltCost : 0
                            };
                            $scope.GM.mapFreccPorc['T7_' + fltMaxW].ranges[keyRange] = {
                                intFrecuency : 0
                                , fltBaseFee : 0
                                , fltFullFee : 0
                                , fltRAD : 0
                                , fltEAD : 0
                                , fltACK : 0
                                , fltSEG : 0
                                , fltTotalNormal : 0
                            };
                        });
                        $scope.addFrecc(fltMaxW);
                    }
                };

                $scope.addDestiny = function(){
                    $scope.GM.OriginDisabled = true;
                    $scope.DestinyErrorMessage = '';
                    $scope.DestinySuccessMessage = '';
                    if(notEmpty($scope.GM.strOrigin)
                            && notEmpty($scope.GM.strDestiny)
                            && $scope.GM.strDestiny.length == 3
                            && !isIn($scope.GM.strDestiny, $scope.GM.listDestiny)
                    )
                        callCheckDestiny($scope);
                    else if(!notEmpty($scope.GM.strOrigin))
                        $scope.DestinyErrorMessage = 'Debe agregar un origen';
                    else if(!notEmpty($scope.GM.strDestiny))
                        $scope.DestinyErrorMessage = 'Debe agregar un destino';
                    else if(notEmpty($scope.GM.strDestiny) && $scope.GM.strDestiny.length < 3)
                        $scope.DestinyErrorMessage = 'El destino tener una longitud de 3 letras';

                };

                $scope.addFrecc = function(fltWeigth){
                    var strFee = fltWeigth + ' kg';
                    var keyFee = 'T7_' + fltWeigth;
                    $scope.GM.OWFrecc[keyFee] = {
                        ranges:{}
                        , fltFrecc: 0
                        , intQTotal:0
                        , strName:strFee
                        , blnSameFrecc :false
                        , blnSameWeight :false
                        , blnSameVol :false
                    };
                    $scope.GM.OWFrecc[keyFee + 'ZP'] = { //21/09/2020 Salvador: Mapa para guardar las frecuencias T7 zona plus
                        ranges:{}
                        , fltFrecc: 0
                        , intQTotal:0
                        , strNombre:strFee
                        , blnMismaFrec :false
                        , blnMismoPeso :false
                        , blnMismoVol :false
                    };
                    $scope.GM.mapQuotes[keyFee] = {};
                    $scope.GM.mapQuotesPorc[keyFee] = {}
                    $scope.listFee[keyFee] = 'TARIFA '+ keyFee;
                    if ($scope.OnlineDocByRangeKM || (!$scope.OnlineDocByRangeKM && !$scope.OnlineDocByDestiny)){
                        j$.each($scope.GM.listRange, function (key, str) {
                            $scope.GM.OWFrecc[keyFee].ranges[key] = {
                                intFrecuency : 0
                                , fltAVGWeight : fltWeigth
                                , fltAVGVol : 0
                                , fltBaseFee : 0
                                , fltBaseFeeP : 0
                                , fltFullFee : 0
                                , fltFullFeeP : 0
                                , fltRAD : 0
                                , fltRADP : 0
                                , fltEAD : 0
                                , fltEADP : 0
                                , fltACK : 0
                                , fltSEG : 0
                                , fltTotalNormal : 0
                            };
                            //$scope.GM.mapQuotes[keyFee][key] = {};
                            $scope.GM.OWFrecc[keyFee+'ZP'].ranges[key] = {
                                intFrecuency : 0
                                , fltAVGWeight : fltWeigth
                                , fltAVGVol : 0
                                , fltBaseFee : 0
                                , fltFullFee : 0
                                , fltRAD : 0
                                , fltEAD : 0
                                , fltACK : 0
                                , fltSEG : 0
                                , fltTotalNormal : 0
                            };
                            
                        });

                        /*j$.each($scope.GM.listRange, function (key, str) {
                            $scope.GM.OWFrecc[keyFee+'ZP'].ranges[key] = {
                                intFrecuency : 0
                                , fltAVGWeight : fltWeigth
                                , fltAVGVol : 0 
                                , fltBaseFee : 0
                                , fltFullFee : 0
                                , fltRAD : 0
                                , fltEAD : 0
                                , fltACK : 0
                                , fltSEG : 0
                                , fltTotalNormal : 0
                            };
                            $scope.GM.mapQuotesPorc[keyFee][key] = {}
                        });*/
                    } else if ($scope.OnlineDocByDestiny && !$scope.OnlineDocByRangeKM){
                        j$.each($scope.GM.listDestiny, function (keyDestiny, strDestiny) {
                            $scope.GM.OWFrecc[keyFee].ranges[keyDestiny] = {
                                intFrecuency : 0
                                , fltAVGWeight : fltWeigth
                                , fltAVGVol : 0
                                , fltBaseFee : 0
                                , fltBaseFeeP : 0
                                , fltFullFee : 0
                                , fltFullFeeP : 0
                                , fltRAD : 0
                                , fltRADP : 0
                                , fltEAD : 0
                                , fltEADP : 0
                                , fltACK : 0
                                , fltSEG : 0
                                , fltTotalNormal : 0
                            };
                            //$scope.GM.mapQuotes[keyFee][key] = {};
                        });
                    }
                };

                $scope.addService = function(service){
                    var index =  j$.inArray(service, $scope.GM.ServiceSelect.available);
                    $scope.GM.ServiceSelect.available.splice(index, 1);
                    $scope.GM.ServiceSelect.selected.push(service);
                    switch (service.id) {
                        case 'EAD':
                            $scope.GM.blnEAD = true;
                            break;
                        case 'RAD':
                            $scope.GM.blnRAD = true;
                            break;
                        case 'SEG':
                            $scope.GM.blnSEG = true;
                            break;
                        case 'ACK':
                            $scope.GM.blnACK = true;
                            break;
                    }

                };

                $scope.back = function(){
                    $scope.GM.step1 = true;
                    $scope.GM.step2 = false;
                };

                $scope.calculateDiscProjection = function(){
                    $scope.ProjectionGM = {
                        'PAQ' : {}
                        , 'ZP' : {}
                        , fltTotalNormal : 0
                        , fltTotalQuote : 0
                        , fltTotalSEG : 0
                        , fltDisc : 0
                    };
                    //debugger;
                    j$.each($scope.GM.mapProjGM, function (strKey, pro){
                        $scope.ProjectionGM.PAQ[strKey] = { strFee : pro.strFee, fltWeight: pro.fltMaxW , fltDisc : pro.fltDisc, fltMaxDisc : 0 } ;
                        j$.each(pro.ranges, function (keyRange, range){
                            if($scope.ProjectionGM.PAQ[strKey].fltMaxDisc === 0)
                                $scope.ProjectionGM.PAQ[strKey].fltMaxDisc = range.fltDisc;
                            else if($scope.ProjectionGM.PAQ[strKey].fltMaxDisc > range.fltDisc)
                                $scope.ProjectionGM.PAQ[strKey].fltMaxDisc = range.fltDisc;
                        });
                    });
                    j$.each($scope.GM.mapProjGMZP, function (strKey, pro){
                        $scope.ProjectionGM.ZP[strKey] = { strFee : pro.strFee, fltWeight: pro.fltMaxW , fltDisc : pro.fltDisc, fltMaxDisc : 0 } ;
                        j$.each(pro.ranges, function (keyRange, range){
                            /*if($scope.ProjectionGM.ZP[strKey].fltMaxDisc === 0)
                                $scope.ProjectionGM.ZP[strKey].fltMaxDisc = range.fltDisc;
                            if($scope.ProjectionGM.ZP[strKey].fltMaxDisc > range.fltDisc)
                                $scope.ProjectionGM.ZP[strKey].fltMaxDisc = range.fltDisc;*/
                            if(range.strFee === 'T7'){
                                if($scope.ProjectionGM.ZP[strKey].fltMaxDisc === 0)
                                    $scope.ProjectionGM.ZP[strKey].fltMaxDisc = range.fltDesc;
                                if($scope.ProjectionGM.ZP[strKey].fltMaxDisc > range.fltDesc)
                                    $scope.ProjectionGM.ZP[strKey].fltMaxDisc = range.fltDesc;
                            } else {
                                if($scope.ProjectionGM.ZP[strKey].fltMaxDisc === 0)
                                    $scope.ProjectionGM.ZP[strKey].fltMaxDisc = range.fltDisc;
                                if($scope.ProjectionGM.ZP[strKey].fltMaxDisc > range.fltDisc)
                                    $scope.ProjectionGM.ZP[strKey].fltMaxDisc = range.fltDisc;
                            }
                        });
                    });
                };

                $scope.calculateGM = function(){
                    var key = '';
                    var destrange = '';
                    var rangeresp = '';
                    j$.each($scope.listFee, function (keyFee, strFee) {
                        if (keyFee.includes('T7_')){
                            $scope.GM.mapTarifas7[keyFee + 'P'] = {
                                ranges : {}
                            }
                            $scope.GM.mapTarifas7[keyFee + 'V'] = {
                                ranges : {}
                            }
                        }
                        j$.each($scope.GM.listRange, function (keyRange, strRange) {
                            rangeresp = strRange;
                            if(strRange.includes(' (')){
                                destrange = rangeresp.replace(keyRange + ' (', '');
                                destrange = destrange.replace(')', '');
                            } else destrange = strRange;
                            if(keyFee === 'TS' || keyFee === 'T0'|| keyFee === 'T1'|| keyFee === 'T2'|| keyFee === 'T3'|| keyFee === 'T4'|| keyFee === 'T5'|| keyFee === 'T6'|| keyFee === 'T7')
                                var item = $scope.GM.mapFrecc[keyFee].ranges[keyRange];
                            else var item = $scope.GM.OWFrecc[keyFee].ranges[keyRange];
                            item.fltRAD = 0;
                            item.fltEAD = 0;
                            item.fltACK = 0;
                            item.fltSEG = 0;
                            if(keyFee === 'TS' || keyFee === 'T0'|| keyFee === 'T1'|| keyFee === 'T2'|| keyFee === 'T3'|| keyFee === 'T4'|| keyFee === 'T5'|| keyFee === 'T6')
                                item.fltBaseFee = $scope.Wrapper.mapTarifarioT[strFee][destrange].Flete__c;
                            if (!$scope.exceptionAD(keyFee)) {
                                if ($scope.GM.blnRAD)
                                    item.fltRAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinRAD'], item.fltBaseFee);
                                if ($scope.GM.blnEAD)
                                    item.fltEAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinEAD'], item.fltBaseFee);
                            }
                            if($scope.GM.blnSEG)
                                item.fltSEG = ($scope.Wrapper.mapCS['SEG'] / 1000) * $scope.GM.fltSEG;
                            if($scope.GM.blnACK)
                                item.fltACK = $scope.Wrapper.mapACK[$scope.GM.strACK];
                            if (keyFee.includes('T7_')){
                                $scope.GM.mapTarifas7[keyFee + 'P'].ranges[keyRange] = {
                                    intFrecuency : 0
                                    , fltBaseFee : 0
                                    , fltFullFee : 0
                                    , fltRAD : 0
                                    , fltEAD : 0
                                    , fltACK : 0
                                    , fltSEG : 0
                                    , fltTarPropuesta : 0
                                    , fltTotalNormal : 0
                                    , fltAVGWeight : 1
                                    , fltAVGVol : 1
                                }
                                $scope.GM.mapTarifas7[keyFee + 'V'].ranges[keyRange] = {
                                    intFrecuency : 0
                                    , fltBaseFee : 0
                                    , fltFullFee : 0
                                    , fltRAD : 0
                                    , fltEAD : 0
                                    , fltACK : 0
                                    , fltSEG : 0
                                    , fltTarPropuesta : 0
                                    , fltTotalNormal : 0
                                    , fltAVGWeight : 1
                                    , fltAVGVol : 1
                                }
                                key = keyFee.replace('_', '');
                                var t7p = {
                                    intFrecuency : $scope.GM.OWFrecc[keyFee].ranges[keyRange].intFrecuency
                                    , fltBaseFee : 0
                                    , fltFullFee : 0
                                    , fltRAD : 0
                                    , fltEAD : 0
                                    , fltACK : 0
                                    , fltSEG : 0
                                    , fltTarPropuesta : 0
                                    , fltTotalNormal : 0
                                    , fltAVGWeight : $scope.GM.mapBlock[key].fltMaxW
                                };
                                var t7v = {
                                    intFrecuency : $scope.GM.OWFrecc[keyFee].ranges[keyRange].intFrecuency
                                    , fltBaseFee : 0
                                    , fltFullFee : 0
                                    , fltRAD : 0
                                    , fltEAD : 0
                                    , fltACK : 0
                                    , fltSEG : 0
                                    , fltTarPropuesta : 0
                                    , fltTotalNormal : 0
                                    , fltAVGVol : $scope.GM.OWFrecc[keyFee].ranges[keyRange].fltAVGVol
                                };
                                t7p.fltBaseFee = $scope.Wrapper.mapTarifarioT['TARIFA T7P'][destrange].Flete__c * $scope.GM.OWFrecc[keyFee].ranges[keyRange].fltAVGWeight;
                                t7p.fltTarPropuesta = $scope.GM.mapBlock[key].ranges[keyRange].fltCost;
                                t7v.fltTarPropuesta = $scope.GM.mapBlock[key].ranges[keyRange].fltCost;
                                t7v.fltBaseFee = $scope.Wrapper.mapTarifarioT['TARIFA T7V'][destrange].Flete__c * $scope.GM.OWFrecc[keyFee].ranges[keyRange].fltAVGVol;

                                if ($scope.GM.blnRAD) {
                                    t7p.fltRAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinRAD'], t7p.fltBaseFee);
                                    t7v.fltRAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinRAD'], t7v.fltBaseFee);
                                }
                                if ($scope.GM.blnEAD) {
                                    t7p.fltEAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinEAD'], t7p.fltBaseFee);
                                    t7v.fltEAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinEAD'], t7v.fltBaseFee);
                                }
                                if ($scope.GM.blnSEG) {
                                    t7p.fltSEG = ($scope.Wrapper.mapCS['SEG'] / 1000) * $scope.GM.fltSEG;
                                    t7v.fltSEG = ($scope.Wrapper.mapCS['SEG'] / 1000) * $scope.GM.fltSEG;
                                }
                                if ($scope.GM.blnACK) {
                                    t7p.fltACK = $scope.Wrapper.mapACK[$scope.GM.strACK];
                                    t7v.fltACK = $scope.Wrapper.mapACK[$scope.GM.strACK];
                                }

                                t7p.fltFullFee = t7p.fltBaseFee + t7p.fltRAD + t7p.fltEAD + t7p.fltACK + t7p.fltSEG;
                                t7p.fltTotalNormal = t7p.fltFullFee * $scope.GM.OWFrecc[keyFee].ranges[keyRange].intFrecuency;

                                t7v.fltFullFee = t7v.fltBaseFee + t7v.fltRAD + t7v.fltEAD + t7v.fltACK + t7v.fltSEG;
                                t7v.fltTotalNormal = t7v.fltFullFee * $scope.GM.OWFrecc[keyFee].ranges[keyRange].intFrecuency;
                                $scope.GM.mapTarifas7[keyFee + 'P'].ranges[keyRange] = t7p;
                                $scope.GM.mapTarifas7[keyFee + 'V'].ranges[keyRange] = t7v;
                            }
                            item.fltFullFee = item.fltBaseFee + item.fltRAD + item.fltEAD + item.fltACK + item.fltSEG;
                            if(keyFee === 'TS' || keyFee === 'T0'|| keyFee === 'T1'|| keyFee === 'T2'|| keyFee === 'T3'|| keyFee === 'T4'|| keyFee === 'T5'|| keyFee === 'T6'|| keyFee === 'T7')
                                $scope.GM.mapFrecc[keyFee].ranges[keyRange] = item;
                            else
                                $scope.GM.OWFrecc[keyFee].ranges[keyRange] = item;
                            if(keyFee === 'T0' || keyFee === 'T1')
                                item.fltTotalNormal = item.fltFullFee * (item.intFrecuency  / 5);
                            else if(keyFee !== 'TS' && keyFee !== 'T0'  && keyFee !== 'T1' && keyFee != 'T7' && !keyFee.includes('T7'))
                                item.fltTotalNormal = item.fltFullFee * (item.intFrecuency  / 10);
                            else
                                item.fltTotalNormal = item.fltFullFee * item.intFrecuency;

                            /* ZP */
                            if(keyFee !== 'T7' && !keyFee.includes('T7')){
                                var itemZP = $scope.GM.mapFreccZP[keyFee].ranges[keyRange];
                                itemZP.fltRAD = 0;
                                itemZP.fltACK = 0;
                                itemZP.fltSEG = 0;
                                itemZP.fltBaseFee = $scope.Wrapper.mapTarifarioT[strFee][destrange].Flete__c;
                                itemZP.fltEAD = $scope.Wrapper.mapCS['AEZP'];
                                if (!$scope.exceptionAD(keyFee)) {
                                    if ($scope.GM.blnRAD)
                                        itemZP.fltRAD = dominantFeeServiceDom($scope.Wrapper.mapCS['MinRAD'], item.fltBaseFee);
                                }
                                if($scope.GM.blnSEG)
                                    itemZP.fltSEG = ($scope.Wrapper.mapCS['SEG'] / 1000) * $scope.GM.fltSEG;
                                if($scope.GM.blnACK)
                                    itemZP.fltACK = $scope.Wrapper.mapACK[$scope.GM.strACK];
                                itemZP.fltFullFee = itemZP.fltBaseFee + itemZP.fltRAD + itemZP.fltEAD + itemZP.fltACK + itemZP.fltSEG;
                                if(keyFee === 'T0' || keyFee === 'T1')
                                    itemZP.fltTotalNormal = itemZP.fltFullFee * (itemZP.intFrecuency / 5);
                                else if(keyFee !== 'TS' && keyFee !== 'T0' && keyFee !== 'T1')
                                    itemZP.fltTotalNormal = itemZP.fltFullFee * (itemZP.intFrecuency / 10);
                                else
                                    itemZP.fltTotalNormal = itemZP.fltFullFee * itemZP.intFrecuency;

                            }
                        });
                    });
                    $scope.calculateProjGM();
                };

                $scope.calculateProjGM = function(){
                    debugger;
                    $scope.GM.mapProjGM = {};
                    $scope.GM.mapProjGMZP = {};
                    $scope.GM.TOTAL.PROPUESTA = 0;
                    $scope.GM.TOTAL.SEGURO = 0;
                    $scope.GM.TOTAL.NORMAL = 0;
                    $scope.GM.TOTAL.DESCUENTO = 0;
                    var firstBlock = null;
                    var lastBlock = null;
                    j$.each($scope.listBlocksByMaxW, function (j, block) {
                        lastBlock = block;
                        if(firstBlock === null)
                            firstBlock = block;
                        /*if(block.value > 60)
                            $scope.t7blocks[] = block;*/
                    });
                    j$.each($scope.GM.listFee, function(keyFee, strFee){
                        $scope.GM.mapQuotes[keyFee] = {
                            block : {}
                        };
                    });
                    j$.each($scope.GM.listFeeZP, function(keyFee, strFee){
                        $scope.GM.mapQuotesZP[keyFee] = {
                            block : {}
                        };
                    });
                    var listBlocksReverse = [];
                    Object.assign(listBlocksReverse, $scope.listBlocksByMaxW);
                    listBlocksReverse.reverse();
                    //TS - T6
                    for (let i = 0; i <= 60; i++) {
                        let key = i;
                        let w = i;
                        let block;
                        let listRanges = {};
                        let fltTotalNormal = 0;
                        let fltTotalQuote = 0 ;
                        let fltTotalSEG = 0;
                        let listRangesZP = {};
                        let fltTotalNormalZP = 0;
                        let fltTotalQuoteZP = 0 ;
                        let fltTotalSEGZP = 0;
                        let strFee = '';

                        if(i === 0)
                            strFee = 'TS';
                        else if(i === 1)
                            strFee = 'T0';
                        else
                            j$.each($scope.GM.mapLimits, function (keyF, limits) {
                                /*if(i > limits.min && i <= limits.max)
                                    strFee = keyF;*/
                                if(i > limits.min && i <= limits.max || i === limits.min)
                                    strFee = keyF;
                            });
                        if(i <= firstBlock.value){
                            key = firstBlock.key;
                        }else if(i >= lastBlock.value){
                            key = lastBlock.key;
                        }else{
                            /*j$.each(listBlocksReverse, function (index, b) {
                                if(i < b.value)
                                    key = b.key;
                            });
                            if(listBlocksReverse.length === 2){
                                if(i < lastBlock.value)
                                    key = firstBlock.key;
                                else key = lastBlock.value;
                            }else */
                                j$.each(listBlocksReverse, function (index, b) {
                                    if(i <= b.value)
                                        key = b.key;
                                    
                                });
                        }
                        block = $scope.GM.mapBlock[key];
                        //if(key.includes(strFee) || i === 0)
                            $scope.GM.mapQuotes[strFee].block[key] = {
                                strBlock : ''
                                , ranges : {}
                            };
                        $scope.GM.mapQuotesZP[strFee].block[key] = {
                            strBlock : ''
                            , ranges : {}
                        };
                        j$.each($scope.GM.listRange, function (keyRange, strRange) {
                            var item = {
                                 fltQuoteFee : block.ranges[keyRange].fltCost
                                , fltQuoteFullFee : 0
                                , fltQuoteAdKG : 0
                                , fltRAD : $scope.GM.mapFrecc[strFee].ranges[keyRange].fltRAD
                                , fltEAD : $scope.GM.mapFrecc[strFee].ranges[keyRange].fltEAD
                                , fltACK : 0
                                , fltSEG : 0
                                , fltTotalSEG : 0
                                , fltTotalQuote : 0
                                , fltDisc : 0
                                , strBlockKey : key
                                , strFee : strFee
                                , fltTotalPropuesta : 0
                            };
                            let fltTarifaPropuesta = 0;
                            let fltTarifaPropuestaZP = 0;
                            let fltAcuse = 0;
                            let fltTarifaPropuesta2 = 0;
                            let fltTarPropuestaZP = 0;

                            if(i > lastBlock.value)
                                item.fltQuoteAdKG = $scope.GM.mapService['Add'].ranges[keyRange].fltCostWeight * ( i - lastBlock.value);
                            if($scope.GM.blnACK){
                                item.fltACK = $scope.GM.mapService['ACK'].ranges[keyRange].fltCost;
                                fltAcuse = $scope.Wrapper.mapACK[$scope.GM.strACK];
                            }
                                
                            if($scope.GM.blnSEG)
                                item.fltSEG = ($scope.Wrapper.mapCS['SEG'] / 1000) * $scope.GM.fltSEG;

                            var itemZP = {};
                            Object.assign(itemZP, item);
                            itemZP.fltEAD = $scope.GM.mapService['ZP'].ranges[keyRange].fltCost;
                            //PAQ
                            item.fltQuoteFullFee = $scope.GM.mapFrecc[item.strFee].ranges[keyRange].fltBaseFee + item.fltRAD + item.fltEAD + fltAcuse + item.fltSEG;
                            fltTarifaPropuesta = item.fltQuoteFee + item.fltQuoteAdKG;
                            fltTarifaPropuesta2 = item.fltACK + item.fltQuoteFee + item.fltQuoteAdKG;

                            if(item.strFee === 'T0' || item.strFee === 'T1'){
                                item.fltTotalQuote = ($scope.GM.mapFrecc[item.strFee].ranges[keyRange].intFrecuency / 5) * item.fltQuoteFullFee;
                                item.fltTotalPropuesta = fltTarifaPropuesta2 * ($scope.GM.mapFreccPorc[item.strFee].ranges[keyRange].intFrecuency / 5);
                            }else if(item.strFee !== 'TS' && item.strFee !== 'T0'  && item.strFee !== 'T1'){
                                item.fltTotalQuote = ($scope.GM.mapFrecc[item.strFee].ranges[keyRange].intFrecuency / 10) * item.fltQuoteFullFee;
                                item.fltTotalPropuesta = fltTarifaPropuesta2 * ($scope.GM.mapFreccPorc[item.strFee].ranges[keyRange].intFrecuency / 10);
                            } else {
                                item.fltTotalQuote = ($scope.GM.mapFrecc[item.strFee].ranges[keyRange].intFrecuency) * item.fltQuoteFullFee;
                                item.fltTotalPropuesta = fltTarifaPropuesta2 * ($scope.GM.mapFreccPorc[item.strFee].ranges[keyRange].intFrecuency);
                            }
                            
                            if(item.fltTotalPropuesta !== 0 && item.fltTotalQuote !== 0)
                                item.fltDisc = item.fltTotalPropuesta / item.fltTotalQuote - 1;
                            else item.fltDisc = fltTarifaPropuesta2 / item.fltQuoteFullFee - 1;
                            $scope.GM.mapQuotes[item.strFee].block[key].strBlock = key;
                            $scope.GM.mapQuotes[item.strFee].block[key].ranges[keyRange] = item;
                            listRanges[keyRange] = item;
                            fltTotalNormal += item.fltTotalQuote;
                            fltTotalQuote += item.fltTotalPropuesta;
                            fltTotalSEG += item.fltTotalSEG;
                            // ZP
                            itemZP.fltQuoteFullFee = $scope.GM.mapFreccZP[item.strFee].ranges[keyRange].fltBaseFee + itemZP.fltRAD + 208.5 + fltAcuse + itemZP.fltSEG;
                            fltTarifaPropuestaZP += itemZP.fltQuoteFee +  itemZP.fltQuoteAdKG + $scope.GM.mapService['ZP'].ranges[keyRange].fltCost;
                            fltTarPropuestaZP = fltTarifaPropuesta2 + itemZP.fltQuoteAdKG + $scope.GM.mapService['ZP'].ranges[keyRange].fltCost;
                            if(itemZP.strFee === 'T0' || itemZP.strFee === 'T1'){
                                itemZP.fltTotalQuote = ($scope.GM.mapFreccZP[item.strFee].ranges[keyRange].intFrecuency / 5) * itemZP.fltQuoteFullFee;
                                itemZP.fltTotalSEG = itemZP.fltSEG * ($scope.GM.mapFreccZP[item.strFee].ranges[keyRange].intFrecuency / 5);
                                itemZP.fltTotalPropuesta = (fltTarifaPropuesta2 * ($scope.GM.mapFreccPorcZP[item.strFee].ranges[keyRange].intFrecuency / 5)) + (($scope.GM.mapFreccZP[item.strFee].ranges[keyRange].intFrecuency / 5) * $scope.GM.mapService['ZP'].ranges[keyRange].fltCost);
                            }
                            else if(itemZP.strFee !== 'TS' && itemZP.strFee !== 'T0' && itemZP.strFee !== 'T1'){
                                itemZP.fltTotalQuote = ($scope.GM.mapFreccZP[item.strFee].ranges[keyRange].intFrecuency / 10)  * itemZP.fltQuoteFullFee;
                                itemZP.fltTotalSEG = itemZP.fltSEG * ($scope.GM.mapFreccZP[item.strFee].ranges[keyRange].intFrecuency / 10);
                                itemZP.fltTotalPropuesta = (fltTarifaPropuesta2 * ($scope.GM.mapFreccPorcZP[item.strFee].ranges[keyRange].intFrecuency / 10)) + (($scope.GM.mapFreccZP[item.strFee].ranges[keyRange].intFrecuency / 10) * $scope.GM.mapService['ZP'].ranges[keyRange].fltCost);
                            }
                            else{
                                itemZP.fltTotalQuote = $scope.GM.mapFreccZP[item.strFee].ranges[keyRange].intFrecuency * itemZP.fltQuoteFullFee;
                                itemZP.fltTotalSEG = itemZP.fltSEG * $scope.GM.mapFreccZP[item.strFee].ranges[keyRange].intFrecuency;
                                itemZP.fltTotalPropuesta = (fltTarifaPropuesta2 * $scope.GM.mapFreccPorcZP[item.strFee].ranges[keyRange].intFrecuency) + ($scope.GM.mapFreccZP[item.strFee].ranges[keyRange].intFrecuency * $scope.GM.mapService['ZP'].ranges[keyRange].fltCost);
                            }
                            if(item.fltTotalPropuesta !== 0 && item.fltTotalQuote !== 0)
                                itemZP.fltDisc = itemZP.fltTotalPropuesta / itemZP.fltTotalQuote - 1;
                            else itemZP.fltDisc = fltTarPropuestaZP / itemZP.fltQuoteFullFee - 1;
                            listRangesZP[keyRange] = itemZP;
                            $scope.GM.mapQuotesZP[itemZP.strFee].block[key].strBlock = key;
                            $scope.GM.mapQuotesZP[itemZP.strFee].block[key].ranges[keyRange] = itemZP;
                            fltTotalNormalZP += itemZP.fltTotalQuote;
                            fltTotalQuoteZP += itemZP.fltTotalPropuesta;
                            fltTotalSEGZP += itemZP.fltTotalSEG;
                        });
                        if(i===0)
                            w=1;
                        
                        $scope.GM.mapProjGM[block.strLabel + i] = {
                            strFee : strFee
                            , fltMaxW: w
                            , fltTotalNormal : fltTotalNormal
                            , fltTotalQuote : fltTotalQuote
                            , fltDisc : (fltTotalQuote - fltTotalSEG) / ( fltTotalNormal - fltTotalSEG) -1
                            ,  ranges : listRanges
                        };
                        $scope.GM.TOTAL.PROPUESTA += fltTotalQuote;
                        $scope.GM.TOTAL.SEGURO += fltTotalSEG;
                        $scope.GM.TOTAL.NORMAL += fltTotalNormal;
                        $scope.GM.mapProjGMZP[block.strLabel + i] = {
                            strFee : strFee
                            , fltMaxW: w
                            , fltTotalNormal : fltTotalNormalZP
                            , fltTotalQuote : fltTotalQuoteZP
                            , fltDisc : (fltTotalQuoteZP - fltTotalSEGZP) / ( fltTotalNormalZP - fltTotalSEGZP) -1
                            ,  ranges : listRangesZP
                        };
                        $scope.GM.TOTAL.PROPUESTA += fltTotalQuoteZP;
                        $scope.GM.TOTAL.SEGURO += fltTotalSEGZP;
                        $scope.GM.TOTAL.NORMAL += fltTotalNormalZP;
                    }
                    //T7
                    var fltTotalNormal = 0;
                    var fltTotalQuote = 0 ;
                    var fltTotalSEG = 0;
                    var discV = 0;
                    var discP = 0;
                    var listRanges = {};
                    var t7W = 0;
                    var key = '';
                    var keypeso = '';
                    var decTarifaLlenaT7 = 0;
                    if(lastBlock.value > 60){
                        j$.each($scope.listFee, function (keyFee, strFee) {
                            fltTotalNormal = 0;
                            fltTotalQuote = 0 ;
                            fltTotalSEG = 0;
                            discV = 0;
                            discP = 0;
                            listRanges = {};
                            t7W = 0;
                            key = '';
                            keypeso = '';
                            key = keyFee.replace('_', '');
                            if (keyFee.includes('T7_'))
                                $scope.GM.mapQuotes[keyFee] = {
                                    ranges : {}
                                };
                            j$.each($scope.GM.listRange, function (keyRange, strRange) {
                                let rangeresp = '';
                                let destrange = '';
                                let fltTarPropV = 0;
                                let fltTarPropP = 0;
                                let fltTotPropV = 0;
                                let fltTotPropP = 0;
                                if(strRange.includes(' (')){
                                    destrange = rangeresp.replace(keyRange + ' (', '');
                                    destrange = destrange.replace(')', '');
                                } else destrange = strRange;
                                if (keyFee.includes('T7_')){
                                    decTarifaLlenaT7 = 0;
                                    let fltTotalTarifaLlena = 0;
                                    var item = {
                                        fltQuoteFee : $scope.GM.mapBlock[key].ranges[keyRange].fltCost
                                        , fltQuoteFullFeeP : $scope.GM.mapTarifas7[keyFee + 'P'].ranges[keyRange].fltFullFee
                                        , fltQuoteFullFeeV : $scope.GM.OWFrecc[keyFee].ranges[keyRange].fltFullFee
                                        , fltQuoteFullFee : $scope.GM.mapBlock[key].ranges[keyRange].fltCost
                                        , fltQuoteBaseFee : 0
                                        , fltQuoteAdKG : $scope.GM.mapService['Add'].ranges[keyRange].fltCostWeight  * ( $scope.GM.OWFrecc[keyFee].ranges[keyRange].fltAVGWeight - lastBlock.value )
                                        , fltQuoteAdM3 : $scope.GM.mapService['Add'].ranges[keyRange].fltCostVol  * ( $scope.GM.OWFrecc[keyFee].ranges[keyRange].fltAVGVol - lastBlock.vol  )
                                        , fltRAD : $scope.GM.OWFrecc[keyFee].ranges[keyRange].fltRAD
                                        , fltEAD : $scope.GM.OWFrecc[keyFee].ranges[keyRange].fltEAD
                                        , fltACK : $scope.GM.mapService['ACK'].ranges[keyRange].fltCost
                                        , fltSEG : $scope.GM.OWFrecc[keyFee].ranges[keyRange].fltSEG
                                        , fltTotalSEG : 0
                                        , fltTotalQuote : 0
                                        , fltDisc : 0
                                        , strBlockKey : lastBlock.key
                                        , strFee : keyFee
                                        , fltTotalNormal : 0
                                    };
                                    fltTarPropV = (($scope.GM.OWFrecc[keyFee].ranges[keyRange].fltAVGVol - $scope.GM.mapBlock[lastBlock.key].fltMaxV) * ($scope.GM.mapService['Add'].ranges[keyRange].fltCostWeight * 200)) + item.fltQuoteFee + item.fltACK;
                                    fltTarPropP = (($scope.GM.OWFrecc[keyFee].ranges[keyRange].fltAVGWeight - $scope.GM.mapBlock[lastBlock.key].fltMaxW) * $scope.GM.mapService['Add'].ranges[keyRange].fltCostWeight) + item.fltQuoteFee + item.fltACK;
                                    fltTotPropV = fltTarPropV * $scope.GM.mapFreccPorc[keyFee].ranges[keyRange].intFrecuency;
                                    fltTotPropP = fltTarPropP * $scope.GM.mapFreccPorc[keyFee].ranges[keyRange].intFrecuency;

                                    discP = fltTotPropP / $scope.GM.mapTarifas7[keyFee + 'P'].ranges[keyRange].fltTotalNormal - 1;
                                    discV = fltTotPropV / $scope.GM.mapTarifas7[keyFee + 'V'].ranges[keyRange].fltTotalNormal - 1;
                                    if(discP < discV ){
                                        item.fltQuoteFullFee = fltTotPropP;
                                        item.fltQuoteBaseFee = $scope.GM.mapTarifas7[keyFee + 'P'].ranges[keyRange].fltTotalNormal;
                                        item.strFee = 'T7P';
                                        item.fltEAD = $scope.GM.mapTarifas7[keyFee + 'P'].ranges[keyRange].fltEAD;
                                        item.fltRAD = $scope.GM.mapTarifas7[keyFee + 'P'].ranges[keyRange].fltRAD;
                                        item.fltTotalQuote = fltTotPropP;
                                        item.fltDisc = discP;
                                        item.fltTotalNormal = $scope.GM.mapTarifas7[keyFee + 'P'].ranges[keyRange].fltTotalNormal;
                                    }
                                    else{
                                        item.fltQuoteFullFee = fltTotPropV;
                                        item.fltQuoteBaseFee = $scope.GM.mapTarifas7[keyFee + 'V'].ranges[keyRange].fltTotalNormal;
                                        item.strFee = 'T7V';
                                        item.fltEAD = $scope.GM.mapTarifas7[keyFee + 'V'].ranges[keyRange].fltEAD;
                                        item.fltRAD = $scope.GM.mapTarifas7[keyFee + 'V'].ranges[keyRange].fltRAD;
                                        item.fltTotalQuote = fltTotPropV;
                                        item.fltDisc = discV;
                                        item.fltTotalNormal = $scope.GM.mapTarifas7[keyFee + 'V'].ranges[keyRange].fltTotalNormal;
                                    }

                                    $scope.GM.mapQuotes[keyFee].ranges[keyRange] = item;
                                    listRanges[keyRange] = item;
                                    fltTotalNormal += item.fltTotalNormal;
                                    fltTotalQuote += item.fltTotalQuote;
                                    fltTotalSEG += item.fltTotalSEG;
                                    /*fltTotalTarifaLlena = item.fltQuoteFee;
                                    if($scope.GM.blnACK)
                                        fltTotalTarifaLlena += item.fltACK;
                                    /*if($scope.GM.mapTarifas7[keyFee + 'P'].ranges[keyRange].fltFullFee > 0)
                                        discP = fltTotalTarifaLlena / $scope.GM.mapTarifas7[keyFee + 'P'].ranges[keyRange].fltFullFee -1;//$scope.GM.mapTarifas7[keyFee + 'P'].ranges[keyRange].fltTarPropuesta / $scope.GM.mapTarifas7[keyFee + 'P'].ranges[keyRange].fltFullFee -1;
                                    if($scope.GM.mapTarifas7[keyFee + 'V'].ranges[keyRange].fltFullFee > 0)
                                        discV = fltTotalTarifaLlena / $scope.GM.mapTarifas7[keyFee + 'V'].ranges[keyRange].fltFullFee -1;//$scope.GM.mapTarifas7[keyFee + 'V'].ranges[keyRange].fltTarPropuesta / $scope.GM.mapTarifas7[keyFee + 'V'].ranges[keyRange].fltFullFee -1;*/
                                    /*let strTarifa = '';
                                    let TarifaLlena = 0;
                                    let flete = 0;
                                    let fltTotalPropuestaV = 0;
                                    let fltTotalPropuestaP = 0;
                                    fltTotalPropuestaV = fltTotalTarifaLlena * $scope.GM.mapFreccPorc[keyFee].ranges[keyRange].intFrecuency;
                                    fltTotalPropuestaP = fltTotalTarifaLlena * $scope.GM.mapFreccPorc[keyFee].ranges[keyRange].intFrecuency;

                                    discP = fltTotalPropuestaP / item.fltTotalNormal - 1;
                                    if(discP < discV ){
                                        item.fltQuoteFullFee = $scope.GM.mapTarifas7[keyFee + 'P'].ranges[keyRange].fltFullFee;
                                        item.fltQuoteBaseFee = item.fltQuoteFee;// + item.fltQuoteAdKG;
                                        item.fltDisc         = discP;
                                        strTarifa = 'TARIFA T7P';
                                        decTarifaLlenaT7 = $scope.GM.mapTarifas7[keyFee + 'P'].ranges[keyRange].fltBaseFee + $scope.GM.mapTarifas7[keyFee + 'P'].ranges[keyRange].fltRAD + $scope.GM.mapTarifas7[keyFee + 'P'].ranges[keyRange].fltEAD;
                                    } else{
                                        item.fltQuoteFullFee = $scope.GM.mapTarifas7[keyFee + 'V'].ranges[keyRange].fltFullFee;
                                        item.fltQuoteBaseFee = item.fltQuoteFee; //+ item.fltQuoteAdKG;
                                        item.fltDisc         = discV;
                                        strTarifa = 'TARIFA T7V';
                                        decTarifaLlenaT7 = $scope.GM.mapTarifas7[keyFee + 'V'].ranges[keyRange].fltBaseFee + $scope.GM.mapTarifas7[keyFee + 'V'].ranges[keyRange].fltRAD + $scope.GM.mapTarifas7[keyFee + 'V'].ranges[keyRange].fltEAD;
                                    }
                                    if(item.fltACK !== 0)
                                        decTarifaLlenaT7 += $scope.Wrapper.mapACK[$scope.GM.strACK];
                                    item.fltTotalQuote = fltTotalTarifaLlena * $scope.GM.OWFrecc[keyFee].ranges[keyRange].intFrecuency;
                                    item.fltTotalSEG = item.fltSEG * $scope.GM.OWFrecc[keyFee].ranges[keyRange].intFrecuency;
                                    item.fltTotalNormal = $scope.GM.OWFrecc[keyFee].ranges[keyRange].intFrecuency * decTarifaLlenaT7;
                                    $scope.GM.mapQuotes[keyFee].ranges[keyRange] = item;
                                    listRanges[keyRange] = item;
                                    fltTotalNormal += item.fltTotalNormal;
                                    fltTotalQuote += item.fltTotalQuote;
                                    fltTotalSEG += item.fltTotalSEG;*/
                                }
                            });
                            $scope.GM.TOTAL.PROPUESTA += fltTotalQuote;
                            $scope.GM.TOTAL.SEGURO += fltTotalSEG;
                            $scope.GM.TOTAL.NORMAL += fltTotalNormal;
                            if (keyFee.includes('T7_')){
                                keypeso = keyFee.replace('T7_', '');
                                $scope.GM.mapProjGM['T7' + keypeso] = {
                                    strFee : 'T7'
                                    , fltMaxW: keypeso
                                    , fltTotalNormal : fltTotalNormal
                                    , fltTotalQuote : fltTotalQuote
                                    , fltDisc : (fltTotalQuote - fltTotalSEG) / ( fltTotalNormal - fltTotalSEG) -1
                                    ,  ranges : listRanges
                                };
                            }
                        });
                    }
                    else{
                        $scope.GM.mapQuotes['T7'] = {
                            strBlock : ''
                            , block : {}
                        };
                        $scope.GM.mapQuotes['T7'].block[lastBlock.key] = {
                            ranges : {}
                        };
                        j$.each($scope.GM.listRange, function (keyRange, strRange) {
                            let fltAcuseT7 = 0;
                            let fltTarifaLlenaV = 0;
                            let fltTarifaLlenaP = 0;
                            let fltEADV = 0;
                            let fltEADP = 0;
                            let fltRADP = 0;
                            let fltRADV = 0;
                            let fltSEV = 0;
                            let fltACK = 0;
                            let fltTarPropV = 0;
                            let fltTarPropP = 0;
                            let fltTotPropV = 0;
                            let fltTotPropP = 0;
                            let rangeresp = '';
                            let destrange = '';
                            let fltFleteV = 0;
                            let fltFleteW = 0;
                            rangeresp = strRange;
                            if(strRange.includes(' (')){
                                destrange = rangeresp.replace(keyRange + ' (', '');
                                destrange = destrange.replace(')', '');
                            } else destrange = strRange;
                            var item = {
                                fltQuoteFee : 0
                                , fltQuoteFullFeeP : 0
                                , fltQuoteFullFeeV : 0
                                , fltQuoteFullFee : 0
                                , fltQuoteBaseFee : 0
                                , fltQuoteAdKG : $scope.GM.mapService['Add'].ranges[keyRange].fltCostWeight  * ( $scope.GM.mapFrecc['T7'].ranges[keyRange].fltAVGWeight - lastBlock.value )
                                , fltQuoteAdM3 : $scope.GM.mapService['Add'].ranges[keyRange].fltCostVol  * ( $scope.GM.mapFrecc['T7'].ranges[keyRange].fltAVGVol - lastBlock.value  )
                                , fltRAD : 0
                                , fltEAD : 0
                                , fltACK : 0
                                , fltSEG : 0
                                , fltTotalSEG : 0
                                , fltTotalQuote : 0
                                , fltDisc : 0
                                , strBlockKey : lastBlock.key
                                , strFee : 'T7'
                                , fltTotalNormalV : 0
                                , fltTotalNormalP : 0
                            };
                            item.fltQuoteFee = $scope.GM.mapBlock[lastBlock.key].ranges[keyRange].fltCost;
                            if($scope.GM.blnACK){
                                item.fltACK = $scope.GM.mapService['ACK'].ranges[keyRange].fltCost;
                                fltAcuseT7 = $scope.Wrapper.mapACK[$scope.GM.strACK];
                            }
                            if($scope.GM.blnSEG)
                                item.fltSEG = ($scope.Wrapper.mapCS['SEG'] / 1000) * $scope.GM.fltSEG;
                            fltFleteV = $scope.Wrapper.mapTarifarioT['TARIFA T7V'][destrange].Flete__c * $scope.GM.mapFrecc['T7'].ranges[keyRange].fltAVGVol;
                            fltFleteW = $scope.GM.mapFrecc['T7'].ranges[keyRange].fltAVGWeight * $scope.Wrapper.mapTarifarioT['TARIFA T7P'][destrange].Flete__c;
                            if($scope.GM.blnEAD){
                                fltEADP = fltFleteW * 0.11;
                                fltEADV = fltFleteV * 0.11;
                            }
                            if ($scope.GM.blnRAD) {
                                fltRADP = fltFleteW * 0.11;
                                fltRADV = fltFleteV * 0.11;
                            }
                            fltTarifaLlenaV = fltFleteV + fltRADV + fltEADV + fltAcuseT7;
                            fltTarifaLlenaP = fltFleteW + fltRADP + fltEADP + fltAcuseT7;

                            fltTarPropV = (($scope.GM.mapFrecc['T7'].ranges[keyRange].fltAVGVol - $scope.GM.mapBlock[lastBlock.key].fltMaxV) * ($scope.GM.mapService['Add'].ranges[keyRange].fltCostWeight * 200)) + item.fltQuoteFee + item.fltACK;
                            fltTarPropP = (($scope.GM.mapFrecc['T7'].ranges[keyRange].fltAVGWeight - $scope.GM.mapBlock[lastBlock.key].fltMaxW) * $scope.GM.mapService['Add'].ranges[keyRange].fltCostWeight) + item.fltQuoteFee + item.fltACK;

                            item.fltTotalNormalV = $scope.GM.mapFrecc['T7'].ranges[keyRange].intFrecuency * fltTarifaLlenaV;
                            item.fltTotalNormalP = $scope.GM.mapFrecc['T7'].ranges[keyRange].intFrecuency * fltTarifaLlenaP;

                            fltTotPropV = fltTarPropV * $scope.GM.mapFreccPorc['T7'].ranges[keyRange].intFrecuency;
                            fltTotPropP = fltTarPropP * $scope.GM.mapFreccPorc['T7'].ranges[keyRange].intFrecuency;
                            discP = fltTotPropP / item.fltTotalNormalP - 1; 
                            discV = fltTotPropV / item.fltTotalNormalV - 1;

                            if(discP < discV ){
                                item.fltQuoteFullFee = fltTotPropP;
                                item.fltQuoteBaseFee = item.fltTotalNormalP;
                                item.strFee = 'T7P';
                                item.fltEAD = fltEADP;
                                item.fltRAD = fltRADP;
                                item.fltTotalQuote = fltTarPropP;
                                item.fltDisc = discP;
                                item.fltTotalNormal = item.fltTotalNormalP;
                            }
                            else{
                                item.fltQuoteFullFee = fltTotPropV;
                                item.fltQuoteBaseFee = item.fltTotalNormalV;
                                item.strFee = 'T7V';
                                item.fltEAD = fltEADV;
                                item.fltRAD = fltRADV;
                                item.fltTotalQuote = fltTarPropV;
                                item.fltDisc = discV;
                                item.fltTotalNormal = item.fltTotalNormalV;
                            }

                            $scope.GM.mapQuotes['T7'].block[lastBlock.key].strBlock = lastBlock.key;
                            $scope.GM.mapQuotes['T7'].block[lastBlock.key].ranges[keyRange] = item;
                            listRanges[keyRange] = item;
                            if(item.fltTotalNormal !== 0 && item.fltTotalNormal !== NaN)
                                fltTotalNormal += item.fltTotalNormal;
                            else fltTotalNormal += 0;
                            if(item.fltQuoteFullFee !== 0 && item.fltQuoteFullFee !== NaN)
                                fltTotalQuote += item.fltQuoteFullFee;
                            else fltTotalQuote += 0;
                            fltTotalSEG += item.fltTotalSEG;
                            if($scope.GM.mapFrecc['T7'].ranges[keyRange].fltAVGWeight > t7W)
                                t7W = $scope.GM.mapFrecc['T7'].ranges[keyRange].fltAVGWeight;
                        });

                        $scope.GM.mapProjGM['T7'] = {
                            strFee : 'T7'
                            , fltMaxW : t7W
                            , fltTotalNormal : fltTotalNormal
                            , fltTotalQuote : fltTotalQuote
                            , fltDisc : (fltTotalQuote - fltTotalSEG) / ( fltTotalNormal - fltTotalSEG) -1
                            ,  ranges : listRanges
                        };
                        $scope.GM.TOTAL.PROPUESTA += fltTotalQuote;
                        $scope.GM.TOTAL.SEGURO += fltTotalSEG;
                        $scope.GM.TOTAL.NORMAL += fltTotalNormal;
                    }
                    $scope.GM.TOTAL.DESCUENTO = ($scope.GM.TOTAL.PROPUESTA - $scope.GM.TOTAL.SEGURO) / ( $scope.GM.TOTAL.NORMAL - $scope.GM.TOTAL.SEGURO)-1;
                    $scope.calculateDiscProjection();
                };

                $scope.calculateQ = function(){
                    $scope.GM.TOTAL['PAQUETES'] = 0;
                    $scope.GM.TOTAL['GUIAS'] = 0;
                    $scope.GM.blnZP = false;
                    $scope.GM.mapFrecc.fltFTotal = 0;
                    $scope.GM.mapFrecc.fltFEETotal = 0;
                    $scope.GM.mapFreccZP.fltFTotal = 0;
                    $scope.GM.mapFreccZP.fltFEETotal = 0;
                    $scope.GM.mapFreccPorc.fltFTotal = 0;
                    $scope.GM.mapFreccPorcZP.fltFEETotal = 0;
                    j$.each($scope.GM.listRange, function (keyRange, strRange) {
                        $scope.GM.mapRanges[keyRange]['PAQ'].intQTotal = Math.round($scope.GM.mapFrecc.intQTotal *  $scope.GM.mapRanges[keyRange]['PAQ'].fltFrecc);
                        $scope.GM.mapRanges[keyRange]['ZP'].intQTotal = Math.round($scope.GM.mapFreccZP.intQTotal *  $scope.GM.mapRanges[keyRange]['ZP'].fltFrecc);
                        $scope.GM.mapFrecc.fltFTotal += $scope.GM.mapRanges[keyRange]['PAQ'].fltFrecc;
                        $scope.GM.mapFreccZP.fltFTotal += $scope.GM.mapRanges[keyRange]['ZP'].fltFrecc;
                        $scope.GM.mapFreccPorc.fltFTotal += $scope.GM.mapRanges[keyRange]['POR'].fltFrecc;
                        $scope.GM.mapFreccPorcZP.fltFTotal += $scope.GM.mapRanges[keyRange]['PORZP'].fltFrecc;
                    });
                    j$.each($scope.GM.listFee, function (keyFee, strFee) {
                        $scope.GM.mapFrecc[keyFee].intQTotal = Math.round($scope.GM.mapFrecc.intQTotal * $scope.GM.mapFrecc[keyFee].fltFrecc);
                        if(keyFee !== 'T7')
                            $scope.GM.mapFreccZP [keyFee].intQTotal = Math.round($scope.GM.mapFreccZP.intQTotal * $scope.GM.mapFreccZP[keyFee].fltFrecc);
                        j$.each($scope.GM.listRange, function (keyRange, strRange) {
                            $scope.GM.mapFrecc[keyFee].ranges[keyRange].intFrecuency = Math.round($scope.GM.mapFrecc[keyFee].fltFrecc * $scope.GM.mapRanges[keyRange]['PAQ'].intQTotal);
                            $scope.GM.TOTAL['PAQUETES'] += $scope.GM.mapFrecc[keyFee].ranges[keyRange].intFrecuency;
                            $scope.GM.TOTAL['GUIAS'] += $scope.GM.mapFreccPorc[keyFee].ranges[keyRange].intFrecuency;
                            if(keyFee !== 'T7'){
                                $scope.GM.mapFreccZP[keyFee].ranges[keyRange].intFrecuency = Math.round($scope.GM.mapFreccZP[keyFee].fltFrecc * $scope.GM.mapRanges[keyRange]['ZP'].intQTotal);
                                $scope.GM.TOTAL['PAQUETES'] += $scope.GM.mapFreccZP[keyFee].ranges[keyRange].intFrecuency;
                                $scope.GM.TOTAL['GUIAS'] += $scope.GM.mapFreccPorcZP[keyFee].ranges[keyRange].intFrecuency;
                            }
                        });
                        $scope.GM.mapFrecc.fltFEETotal += $scope.GM.mapFrecc[keyFee].fltFrecc;
                        if(keyFee !== 'T7')
                            $scope.GM.mapFreccZP.fltFEETotal += $scope.GM.mapFreccZP[keyFee].fltFrecc;
                    });
                    if($scope.GM.mapFreccZP.intQTotal > 0)
                        $scope.GM.blnZP = true;
                    $scope.calculateGM();
                };

                $scope.calculateXY = function(){
                    $scope.GM.blnZP = false;
                    $scope.GM.TOTAL['PAQUETES'] = 0;
                    $scope.GM.TOTAL['GUIAS'] = 0;
                    $scope.GM.mapFrecc.intQTotal = 0;
                    $scope.GM.mapFreccZP.intQTotal = 0;
                    $scope.GM.mapFrecc.fltFTotal = 1;
                    $scope.GM.mapFrecc.fltFEETotal = 1;
                    $scope.GM.mapFreccZP.fltFTotal = 1;
                    $scope.GM.mapFreccZP.fltFEETotal = 1;
                    $scope.GM.mapFreccPorc.intQTotal = 0;
                    $scope.GM.mapFreccPorcZP.intQTotal = 0;
                    $scope.GM.mapFreccPorc.fltFTotal = 1;
                    $scope.GM.mapFreccPorcZP.fltFEETotal = 1;
                    j$.each($scope.GM.listFee, function (keyFee, strFee) {
                        $scope.GM.mapFrecc[keyFee].intQTotal = 0;
                        $scope.GM.mapFreccPorc[keyFee].intQTotal = 0;
                        if(keyFee !== 'T7'){
                            $scope.GM.mapFreccZP[keyFee].intQTotal = 0;
                            $scope.GM.mapFreccPorcZP[keyFee].intQTotal = 0;
                        }
                        j$.each($scope.GM.listRange, function (keyRange, strRange) {
                            $scope.GM.TOTAL['PAQUETES'] += $scope.GM.mapFrecc[keyFee].ranges[keyRange].intFrecuency;
                            $scope.GM.TOTAL['GUIAS'] += $scope.GM.mapFreccPorc[keyFee].ranges[keyRange].intFrecuency;
                            if(keyFee !== 'T7'){
                                $scope.GM.TOTAL['PAQUETES'] += $scope.GM.mapFreccZP[keyFee].ranges[keyRange].intFrecuency;
                                $scope.GM.TOTAL['GUIAS'] += $scope.GM.mapFreccPorcZP[keyFee].ranges[keyRange].intFrecuency;
                            }
                            $scope.GM.mapFreccPorc.intQTotal += $scope.GM.mapFreccPorc[keyFee].ranges[keyRange].intFrecuency;
                            $scope.GM.mapFreccPorc[keyFee].intQTotal += $scope.GM.mapFreccPorc[keyFee].ranges[keyRange].intFrecuency;
                            $scope.GM.mapFrecc.intQTotal += $scope.GM.mapFrecc[keyFee].ranges[keyRange].intFrecuency;
                            $scope.GM.mapFrecc[keyFee].intQTotal += $scope.GM.mapFrecc[keyFee].ranges[keyRange].intFrecuency;
                            if(keyFee !== 'T7'){
                                $scope.GM.mapFreccZP.intQTotal += $scope.GM.mapFreccZP[keyFee].ranges[keyRange].intFrecuency;
                                $scope.GM.mapFreccZP[keyFee].intQTotal += $scope.GM.mapFreccZP[keyFee].ranges[keyRange].intFrecuency;
                                $scope.GM.mapFreccPorcZP.intQTotal += $scope.GM.mapFreccPorcZP[keyFee].ranges[keyRange].intFrecuency;
                                $scope.GM.mapFreccPorcZP[keyFee].intQTotal += $scope.GM.mapFreccPorcZP[keyFee].ranges[keyRange].intFrecuency;
                            }
                        });
                    });
                    j$.each($scope.GM.listRange, function (keyRange, strRange) { //Salvador: Se recorre la lista de rangos de KM para acceder a la segunda llave
                        j$.each($scope.GM.mapBlock, function(range, item){ //Salvador: Se recorren los bloques de arranque para poder aceder al peso de cada bloque
                            if (item.fltMaxW > 60){ //Salvador: Si el bloque es mayor de 69, es decir a partir de 70 que es cuando empiezan las tarifas T7
                                $scope.GM.TOTAL['PAQUETES'] += $scope.GM.OWFrecc['T7_'+item.fltMaxW].ranges[keyRange].intFrecuency; //Salvador: Se obtiene la frecuencia del bloque
                                $scope.GM.TOTAL['GUIAS'] += $scope.GM.mapFreccPorc['T7_'+item.fltMaxW].ranges[keyRange].intFrecuency;
                                //$scope.GM.TOTAL['PAQUETES'] += $scope.GM.OWFrecc['T7_'+item.fltMaxW + 'ZP'].ranges[keyRange].intFrecuency;
                                $scope.GM.mapFreccPorc.intQTotal += $scope.GM.mapFreccPorc['T7_'+item.fltMaxW].ranges[keyRange].intFrecuency;
                                $scope.GM.mapFrecc.intQTotal += $scope.GM.OWFrecc['T7_'+item.fltMaxW].ranges[keyRange].intFrecuency;
                                $scope.GM.mapFreccPorc['T7_'+item.fltMaxW].intQTotal += $scope.GM.OWFrecc['T7_'+item.fltMaxW].ranges[keyRange].intFrecuency
                                $scope.GM.OWFrecc['T7_'+item.fltMaxW].intQTotal += $scope.GM.OWFrecc['T7_'+item.fltMaxW].ranges[keyRange].intFrecuency;
                            }
                        });
                    });
                    j$.each($scope.listFee, function (keyFee, strFee) {
                        if(keyFee.includes('T7_')){
                            if($scope.GM.OWFrecc.intQTotal > 0)
                                $scope.GM.OWFrecc[keyFee].fltFrecc = $scope.GM.mapFrecc[keyFee].intQTotal / $scope.GM.mapFrecc.intQTotal;
                        } else {
                            if($scope.GM.mapFrecc.intQTotal > 0)
                                $scope.GM.mapFrecc[keyFee].fltFrecc = $scope.GM.mapFrecc[keyFee].intQTotal / $scope.GM.mapFrecc.intQTotal;
                            if((keyFee !== 'T7' && !keyFee.includes('T7_')) && $scope.GM.mapFreccZP.intQTotal > 0)
                                $scope.GM.mapFreccZP[keyFee].fltFrecc = $scope.GM.mapFreccZP[keyFee].intQTotal / $scope.GM.mapFreccZP.intQTotal;
                        }
                    });
                    j$.each($scope.GM.listRange, function (keyRange, strRange) {
                        $scope.GM.mapRanges[keyRange]['PAQ'].intQTotal = 0;
                        $scope.GM.mapRanges[keyRange]['ZP'].intQTotal = 0;
                        $scope.GM.mapRanges[keyRange]['POR'].intQTotal = 0;
                        $scope.GM.mapRanges[keyRange]['PORZP'].intQTotal = 0;
                        j$.each($scope.listFee, function (keyFee, strFee) {
                            if(!keyFee.includes('T7_'))
                                $scope.GM.mapRanges[keyRange]['PAQ'].intQTotal += $scope.GM.mapFrecc[keyFee].ranges[keyRange].intFrecuency;
                            /*if(keyFee.includes('T7_'))
                                $scope.GM.mapRanges[keyRange]['POR'].intQTotal += $scope.GM.OWFrecc[keyFee].ranges[keyRange].intFrecuency;
                            else*/ $scope.GM.mapRanges[keyRange]['POR'].intQTotal += $scope.GM.mapFreccPorc[keyFee].ranges[keyRange].intFrecuency;
                            if(keyFee !== 'T7' && !keyFee.includes('T7_')){
                                $scope.GM.mapRanges[keyRange]['ZP'].intQTotal += $scope.GM.mapFreccZP[keyFee].ranges[keyRange].intFrecuency;
                                $scope.GM.mapRanges[keyRange]['PORZP'].intQTotal += $scope.GM.mapFreccPorcZP[keyFee].ranges[keyRange].intFrecuency;
                            }
                        });
                        if($scope.GM.mapFrecc.intQTotal > 0) {
                            /*if(keyFee.includes('T7_')){
                                $scope.GM.mapRanges[keyRange]['PAQ'].fltFrecc = $scope.GM.mapRanges[keyRange]['PAQ'].intQTotal / $scope.GM.OWFrecc.intQTotal;
                                $scope.GM.mapRanges[keyRange]['ZP'].fltFrecc = $scope.GM.mapRanges[keyRange]['ZP'].intQTotal / $scope.GM.OWFrecc.intQTotal;
                            } else {*/
                            if($scope.GM.mapFrecc.intQTotal > 0){
                                $scope.GM.mapRanges[keyRange]['PAQ'].fltFrecc = $scope.GM.mapRanges[keyRange]['PAQ'].intQTotal / ($scope.GM.mapFrecc.intQTotal + $scope.GM.OWFrecc.intQTotal);
                                $scope.GM.mapRanges[keyRange]['ZP'].fltFrecc = $scope.GM.mapRanges[keyRange]['ZP'].intQTotal / ($scope.GM.mapFrecc.intQTotal + $scope.GM.OWFrecc.intQTotal);
                            } else {
                                $scope.GM.mapRanges[keyRange]['PAQ'].fltFrecc = $scope.GM.mapRanges[keyRange]['PAQ'].intQTotal / $scope.GM.mapFrecc.intQTotal;
                                $scope.GM.mapRanges[keyRange]['ZP'].fltFrecc = $scope.GM.mapRanges[keyRange]['ZP'].intQTotal / $scope.GM.mapFrecc.intQTotal;
                            }
                                
                            //}
                            
                        }
                        if($scope.GM.mapFreccPorc.intQTotal > 0) {
                            $scope.GM.mapRanges[keyRange]['POR'].fltFrecc = $scope.GM.mapRanges[keyRange]['POR'].intQTotal / $scope.GM.mapFreccPorc.intQTotal;
                            $scope.GM.mapRanges[keyRange]['PORZP'].fltFrecc = $scope.GM.mapRanges[keyRange]['PORZP'].intQTotal / $scope.GM.mapFreccPorcZP.intQTotal;
                        }
                    });
                    if($scope.GM.mapFreccZP.intQTotal > 0)
                        $scope.GM.blnZP = true;
                    $scope.calculateGM();
                };

                $scope.clickFee = function(index, strType){
                    switch (strType) {
                        case 'serviceAdd':
                            $scope.GM.ServiceSelect.available[index].blnSelected = !$scope.GM.ServiceSelect.available[index].blnSelected;
                            break;
                        case 'serviceRemove':
                            $scope.GM.ServiceSelect.selected[index].blnSelected = !$scope.GM.ServiceSelect.selected[index].blnSelected;
                            break;
                    }

                };

                $scope.createQuotesGM = function(){
                    var listDelete = [];
                    var strRange = '';
                    var listQuoteItem = [];
                    var Quote = {
                        Acuse__c: $scope.GM.strACK
                        , AcuseCosto__c : $scope.GM.strAckCost
                        , SBQQ__Primary__c : true
                        , PAQ_TipoServicio__c : 'Estándar terrestre (STD)'
                        , Modelo_de_tarifas__c : 'Guía multipieza: Por Destinos / Por Rangos de km'
                        , Descuento_Global__c : $scope.GM.TOTAL['DESCUENTO'] * - 100
                        , PAQ_DescuentoGlobal__c : $scope.GM.TOTAL['DESCUENTO'] * - 100
                        , Ingreso_Mensual__c : $scope.GM.TOTAL['PROPUESTA']
                        , TarifaLlenaMensual__c : $scope.GM.TOTAL['NORMAL']
                        , Paquetes_Mensuales__c : $scope.GM.TOTAL['PAQUETES']
                        , Gerente_de_sucursal_aprobacion__c : $scope.Managers['GSU']
                        , KAM_aprobacion__c : $scope.Managers['KAM']
                        , Gerente_desarrollo_aprobacion__c : $scope.Managers['GDS']
                        , Director_comercial_aprobacion__c : $scope.Managers['DCO']
                        , Tipo_de_documentacion__c : 'Documentación Remota'
                        , AVRDeliveryACK__c : $scope.GM.mapService['ACK'].fltAVGDeliveryByACK
                        , AVRPackByDelivery__c : $scope.GM.mapService['ACK'].fltAVGPackByDay
                        , Plaza__c: $scope.GM.strOrigin
                        , RangosKM__c: $scope.OnlineDocByRangeKM
                        , Destinos__c: $scope.OnlineDocByDestiny
                        , RecordTypeId : $scope.Wrapper.mapRecordType['GMP']
                        , OriginCity__c : $scope.GM.strOrigen
                    };
                    if($scope.Wrapper.objQuote && $scope.Wrapper.objQuote.Id){
                        Quote.Id = $scope.Wrapper.objQuote.Id;
                        Quote.SBQQ__Status__c = $scope.Wrapper.objQuote.SBQQ__Status__c;
                    }
                    if($scope.Wrapper.objLead && notEmpty($scope.Wrapper.objLead.Id))
                        Quote.Lead__c = $scope.Wrapper.objLead.Id;
                    if($scope.Wrapper.objAccountId)
                        Quote.SBQQ__Account__c = $scope.Wrapper.objAccountId;
                    if($scope.Wrapper.objOpp && notEmpty($scope.Wrapper.objOpp.Id))
                        Quote.SBQQ__Opportunity2__c = $scope.Wrapper.objOpp.Id;
                    Quote.Servicios_adicionales__c = "";
                    if($scope.GM.blnRAD)
                        Quote.Servicios_adicionales__c = "RAD;";
                    if($scope.GM.blnEAD)
                        Quote.Servicios_adicionales__c += "EAD;";
                    if($scope.GM.blnSEG)
                        Quote.Servicios_adicionales__c += "Seguro;";
                    if ($scope.GM.blnACK)
                        Quote.Servicios_adicionales__c += "Acuse " + $scope.GM.strACK;
                    var rangeDisc = 0;
                    //$scope.GM.blnZP = false;
                    j$.each($scope.listFee, function (keyFee, strFee) {
                        if(!keyFee.includes('T7_')){
                            j$.each($scope.GM.mapQuotes[keyFee].block, function(keyblock, block){
                                j$.each($scope.GM.listRange, function (keyRange, labelRange) {
                                    if(keyFee === 'TS'||keyFee === 'T0' ||keyFee === 'T1' ||keyFee === 'T2' ||keyFee === 'T3' ||keyFee === 'T4' ||keyFee === 'T5' ||keyFee === 'T6' ||keyFee === 'T7')
                                        var frecc = $scope.GM.mapFrecc[keyFee].ranges[keyRange];
                                    var quote = $scope.GM.mapQuotes[keyFee].block[block.strBlock].ranges[keyRange];
                                    if (getId(labelRange, $scope.GM.OriginalListRange))
                                        strRange = labelRange;
                                    else
                                        strRange = getRange(labelRange);
                                    var quoteItem = {
                                        SBQQ__Quantity__c : frecc.intFrecuency
                                        , SBQQ__Discount__c : quote.fltDisc
                                        , SBQQ__CustomerPrice__c : quote.fltQuoteFullFee
                                        , SBQQ__NetPrice__c : frecc.fltFullFee
                                        , SBQQ__SpecialPrice__c : frecc.fltFullFee
                                        , QuoteTotal__c :  quote.fltQuoteFullFee
                                        , PackVolAVG__c : $scope.GM.mapBlock[quote.strBlockKey].fltMaxV
                                        , PackWeightAVG__c : $scope.GM.mapBlock[quote.strBlockKey].fltMaxW
                                        , FLETE__c : quote.fltQuoteFee
                                        , ACK__c : $scope.GM.mapService['ACK'].ranges[keyRange].fltCost
                                        , EAD__c : quote.fltEAD
                                        , RAD__c : quote.fltRAD
                                        , SEG__c : quote.fltSEG
                                        , KG_ADICIONAL__c : $scope.GM.mapService['Add'].ranges[keyRange].fltCostWeight
                                        , GUIA__c : quote.fltQuoteFee
                                        , Tarifa__c : strFee
                                        , Rango_KM__c : strRange
                                        , Pack_Seg__c : $scope.GM.fltSEG
                                        , Id : frecc.Id
                                        , SBQQ__Quote__c : Quote.Id
                                        , PaqPorGuia__c : $scope.GM.mapFreccPorc[keyFee].ranges[keyRange].intFrecuency
                                        , PaqPromPorGuia__c : $scope.GM.mapFreccPorc[keyFee].fltCantidad
                                    };
                                    if(labelRange.includes(' (')){
                                        quoteItem.Destiny__c = labelRange;
                                    }
                                    if (strFee === 'TARIFA T7') {
                                        quoteItem.Weight__c = $scope.GM.mapFrecc[keyFee].ranges[keyRange].fltAVGWeight;
                                        quoteItem.Width__c = $scope.GM.mapFrecc[keyFee].ranges[keyRange].fltAVGVol;
                                        quoteItem.Large__c = 1;
                                        quoteItem.High__c = 1;
                                    }
                                    if(strFee === 'TARIFA TS')
                                        quoteItem.Tarifa__c = 'TARIFA SOBRE';
                                    if(keyFee !== 'T7'){
                                        if ((quoteItem.SBQQ__Discount__c * -1) > rangeDisc)
                                            rangeDisc = quoteItem.SBQQ__Discount__c * -1;
                                    }
                                    listQuoteItem.push(quoteItem);
                                    if(keyFee !== 'T7'){
                                        var freccZP = $scope.GM.mapFreccZP[keyFee].ranges[keyRange];
                                        var quoteZP = $scope.GM.mapQuotesZP[keyFee].block[block.strBlock].ranges[keyRange];;
                                            if (getId(labelRange, $scope.GM.OriginalListRange))
                                                strRange = labelRange;
                                            else
                                                strRange = getRange(labelRange);
                                            var quoteItemZP = {
                                                SBQQ__Quantity__c: freccZP.intFrecuency
                                                , SBQQ__Discount__c: quoteZP.fltDisc
                                                , SBQQ__CustomerPrice__c: quoteZP.fltQuoteFullFee
                                                , SBQQ__NetPrice__c: freccZP.fltFullFee
                                                , SBQQ__SpecialPrice__c: quoteZP.fltFullFee
                                                , QuoteTotal__c: quoteZP.fltQuoteFullFee
                                                , PackVolAVG__c: $scope.GM.mapBlock[quoteZP.strBlockKey].fltMaxV
                                                , PackWeightAVG__c: $scope.GM.mapBlock[quoteZP.strBlockKey].fltMaxW
                                                , FLETE__c: quoteZP.fltQuoteFee
                                                , ACK__c: $scope.GM.mapService['ACK'].ranges[keyRange].fltCost
                                                , EAD__c: quoteZP.fltEAD
                                                , RAD__c: quoteZP.fltRAD
                                                , SEG__c: quoteZP.fltSEG
                                                , KG_ADICIONAL__c: $scope.GM.mapService['Add'].ranges[keyRange].fltCostWeight
                                                , GUIA__c: quoteZP.fltQuoteFee
                                                , Tarifa__c: strFee
                                                , Rango_KM__c: strRange
                                                , Pack_Seg__c: $scope.GM.fltSEG
                                                , Id: freccZP.Id
                                                , SBQQ__Quote__c: Quote.Id
                                                , ZonaPlus__c: true
                                                , PaqPorGuia__c : $scope.GM.mapFreccPorcZP[keyFee].ranges[keyRange].intFrecuency
                                                , PaqPromPorGuia__c : $scope.GM.mapFreccPorcZP[keyFee].fltCantidad
                                            };
                                            if (!getId(labelRange, $scope.GM.OriginalListRange))
                                                quoteItemZP.Destiny__c = labelRange;
                                            if (strFee === 'TARIFA TS')
                                                quoteItemZP.Tarifa__c = 'TARIFA SOBRE';
                                            if ((quoteItemZP.SBQQ__Discount__c * -1) > rangeDisc)
                                                rangeDisc = quoteItemZP.SBQQ__Discount__c * -1;
                                            listQuoteItem.push(quoteItemZP);
                                    }
                                });
                            });
                        } else {
                            var frecc = null;
                            var quote = null;
                            var key = '';
                            key = keyFee.replace('_', '');
                            j$.each($scope.GM.listRange, function (keyRange, labelRange) {
                                if (getId(labelRange, $scope.GM.OriginalListRange))
                                    strRange = labelRange;
                                else
                                    strRange = getRange(labelRange);
                                quote = $scope.GM.mapQuotes[keyFee].ranges[keyRange];
                                frecc = $scope.GM.OWFrecc[keyFee].ranges[keyRange]
                                var quoteItem = {
                                    SBQQ__Quantity__c : frecc.intFrecuency
                                    , SBQQ__Discount__c : quote.fltDisc
                                    , SBQQ__CustomerPrice__c : quote.fltQuoteFullFee
                                    , SBQQ__NetPrice__c : frecc.fltFullFee
                                    , SBQQ__SpecialPrice__c : frecc.fltFullFee
                                    , QuoteTotal__c :  quote.fltQuoteFullFee
                                    , PackVolAVG__c : $scope.GM.mapBlock[key].fltMaxV
                                    , PackWeightAVG__c : $scope.GM.mapBlock[key].fltMaxW
                                    , FLETE__c : quote.fltQuoteFee
                                    , ACK__c : $scope.GM.mapService['ACK'].ranges[keyRange].fltCost
                                    , EAD__c : quote.fltEAD
                                    , RAD__c : quote.fltRAD
                                    , SEG__c : quote.fltSEG
                                    , KG_ADICIONAL__c : $scope.GM.mapService['Add'].ranges[keyRange].fltCostWeight
                                    , GUIA__c : quote.fltQuoteFee
                                    , Tarifa__c : strFee
                                    , Rango_KM__c : strRange
                                    , Pack_Seg__c : $scope.GM.fltSEG
                                    , Id : frecc.Id
                                    , PaqPorGuia__c : $scope.GM.mapFreccPorc[keyFee].ranges[keyRange].intFrecuency
                                    , PaqPromPorGuia__c : $scope.GM.mapFreccPorc[keyFee].fltCantidad
                                    //, SBQQ__Quote__c : Quote.Id

                                };
                                if(labelRange.includes(' ('))
                                    quoteItem.Destiny__c = labelRange;
                                quoteItem.Weight__c = $scope.GM.OWFrecc[keyFee].ranges[keyRange].fltAVGWeight;
                                quoteItem.Width__c = $scope.GM.OWFrecc[keyFee].ranges[keyRange].fltAVGVol;
                                quoteItem.Large__c = 1;
                                quoteItem.High__c = 1;
                                listQuoteItem.push(quoteItem);
                            });
                            j$.each($scope.GM.mapTender, function(strTender, map){
                                if($scope.GM.mapQuotesT7ZP.Tender[strTender].intFrecuency > 0){
                                    $scope.GM.blnZP = true;
                                    var QuoteItemT7ZP = {
                                        SBQQ__Quantity__c: $scope.GM.mapQuotesT7ZP.Tender[strTender].intFrecuency
                                        , SBQQ__Discount__c: $scope.GM.mapQuotesT7ZP.Tender[strTender].fltDiscount * 100
                                        , SBQQ__CustomerPrice__c: $scope.GM.mapQuotesT7ZP.Tender[strTender].flttarifaProp
                                        , SBQQ__NetPrice__c: $scope.GM.mapQuotesT7ZP.Tender[strTender].fltTotalQuote
                                        , SBQQ__SpecialPrice__c: 0
                                        , QuoteTotal__c: $scope.GM.mapQuotesT7ZP.Tender[strTender].fltQuoteFee
                                        , PackWeightAVG__c: $scope.GM.mapBlock[key].fltMaxW
                                        , PackVolAVG__c: $scope.GM.mapBlock[key].fltMaxV
                                        , ACK__c: 0
                                        , EAD__c: 0
                                        , RAD__c: 0
                                        , SEG__c: 0
                                        , Tarifa__c: 'TARIFA T7'
                                        , Rango_KM__c: $scope.GM.mapQuotesT7ZP.Tender[strTender].strRange
                                        , ZonaPlus__c: true
                                        , Pack_Seg__c: 0
                                        , Id: $scope.GM.mapQuotesT7ZP.Tender[strTender].Id
                                        , SBQQ__VolumeDiscount__c: 0
                                        , SBQQ__Quote__c: Quote.Id
                                        , Destiny__c : strTender
                                        , Large__c : $scope.GM.mapQuotesT7ZP.Tender[strTender].fltLargo
                                        , Width__c : $scope.GM.mapQuotesT7ZP.Tender[strTender].fltAncho
                                        , High__c : $scope.GM.mapQuotesT7ZP.Tender[strTender].fltAlto
                                        , Weight__c : $scope.GM.mapQuotesT7ZP.Tender[strTender].fltPeso
                                        , Flete__c : quote.fltQuoteFee
                                        , GUIA__c : quote.fltQuoteFee
                                        , SBQQ__SpecialPrice__c : 0
                                    };
                                    if(map.blnDestino){
                                        QuoteItemT7ZP.SBQQ__Description__c = 'Destino';
                                        QuoteItemT7ZP.SBQQ__SpecialPrice__c = $scope.GM.mapPropuesta['PROP'].ranges[strTender].fltCost;
                                        if($scope.GM.strACK)
                                            QuoteItemT7ZP.ACK__c = $scope.GM.mapService['ACK'].ranges[strTender].fltCost;
                                    } else {
                                        let rango = '';
                                        if($scope.GM.mapQuotesT7ZP.Tender[strTender].strRange === 'Más de 2400')
                                            rango = '+2400';
                                        else rango = $scope.GM.mapQuotesT7ZP.Tender[strTender].strRange;
                                        if($scope.GM.strACK)
                                            QuoteItemT7ZP.ACK__c = $scope.GM.mapService['ACK'].ranges[rango].fltCost;
                                        QuoteItemT7ZP.SBQQ__SpecialPrice__c = $scope.GM.mapPropuesta['PROP'].ranges[rango].fltCost;
                                    }
                                     
                                        
                                    listQuoteItem.push(QuoteItemT7ZP);
                                    Quote.Es_T7_Zona_plus__c = true;
                                    $scope.GM.blnCotizaT7ZP = true;
                                }
                            });
                            if($scope.GM.blnCotizaT7ZP){
                                j$.each($scope.GM.listRange, function(keyRange, labelRange){
                                    quote = $scope.GM.mapQuotes[keyFee].ranges[keyRange];
                                    if (getId(labelRange, $scope.GM.OriginalListRange))
                                        strRange = labelRange;
                                    else
                                        strRange = getRange(labelRange);
                                    if($scope.GM.mapBlock[keyFee.replace('_','')].blnT7ZP){
                                        var QuoteItemT7ZPTotales = {
                                            SBQQ__Quantity__c: 0
                                            , SBQQ__Discount__c: $scope.GM.mapPropuesta['PROP'].ranges[keyRange].fltDescuento * 100
                                            , SBQQ__CustomerPrice__c: $scope.GM.mapPropuesta['PROP'].ranges[keyRange].fltTotalPropuesta
                                            , SBQQ__NetPrice__c: $scope.GM.mapPropuesta['PROP'].ranges[keyRange].fltTotalTarifaLlena
                                            , SBQQ__SpecialPrice__c: $scope.GM.mapPropuesta['PROP'].ranges[keyRange].fltCost
                                            , QuoteTotal__c: 0
                                            , PackWeightAVG__c: $scope.GM.mapBlock[key].fltMaxW
                                            , PackVolAVG__c: $scope.GM.mapBlock[key].fltMaxV
                                            , ACK__c: $scope.GM.mapService['ACK'].ranges[keyRange].fltCost
                                            , EAD__c: $scope.GM.mapPropuesta['PROP'].ranges[keyRange].fltZP
                                            , RAD__c: $scope.GM.mapPropuesta['PROP'].ranges[keyRange].fltRAD
                                            , SEG__c: 0
                                            , Tarifa__c: 'TARIFA T7'
                                            //, Rango_KM__c: strRange
                                            , ZonaPlus__c: true
                                            , Pack_Seg__c: 0
                                            , SBQQ__VolumeDiscount__c: 0
                                            , SBQQ__Quote__c: Quote.Id
                                            , Destiny__c : ''
                                            , SBQQ__Description__c : 'Propuesta'
                                            , Id : $scope.GM.mapPropuesta['PROP'].ranges[keyRange].Id
                                            , Flete__c : quote.fltQuoteFee
                                            , Guia__c : quote.fltQuoteFee
                                            , PaqPorGuia__c : $scope.GM.mapFreccPorcT7ZP[keyFee].ranges[keyRange].intFrecuency
                                            , PaqPromPorGuia__c : $scope.GM.mapFreccPorcT7ZP[keyFee].fltCantidad
                                        };
                                        if($scope.OnlineDocByDestiny){
                                            /*let rango = '';
                                            rango = strRange.replace(keyRange + ' (');
                                            rango = rango.replace(')');*/
                                            QuoteItemT7ZPTotales.Rango_KM__c = $scope.GM.mapPropuesta['PROP'].ranges[keyRange].strRango;
                                            QuoteItemT7ZPTotales.Destiny__c = keyRange;
                                        } else {
                                            let rango = '';
                                            /*if(strRange.includes('(')){
                                                rango = strRange.replace(keyRange + ' (', '');
                                                rango = rango.replace(')', '');
                                                //QuoteItemT7ZPTotales.Destiny__c = keyRange;
                                                QuoteItemT7ZPTotales.Destiny__c = keyRange;
                                            } else {
                                                rango = strRange;
                                            }*/
                                            if(labelRange.includes('(')){
                                                QuoteItemT7ZPTotales.Rango_KM__c = $scope.GM.mapPropuesta['PROP'].ranges[keyRange].strRango;
                                                QuoteItemT7ZPTotales.Destiny__c = keyRange;
                                            } else{
                                                rango = strRange;
                                                QuoteItemT7ZPTotales.Rango_KM__c = rango;
                                            } 
                                            
                                        } 
                                        listQuoteItem.push(QuoteItemT7ZPTotales);
                                    }
                                });
                            }
                        }
                    });
                    j$.each($scope.DeletedDestiny, function (key, value) {
                        j$.each($scope.GM.listFee, function (keyFee, strFee) {
                            var frecc = $scope.GM.mapFrecc[keyFee].ranges[keyRange];
                            if (frecc.Id)
                                listDelete.push(frecc.Id);
                            var freccZP = $scope.GM.mapFreccZP[keyFee].ranges[keyRange];
                            if (freccZP.Id)
                                listDelete.push(freccZP.Id);
                        });
                    });
                    if($scope.GM.blnZP)
                        Quote.Servicios_adicionales__c += ";EAD Zona plus";
                    Quote.Descuento_por_linea_o_rangokm__c = rangeDisc;
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

                        if(blnHasQuotePending)
                            $scope.DML.listErrors.push('Esta oportunidad ya tiene una cotización pendiente de autorización, no es posible crear una nueva en este momento');
                        else if(Quote.Id)
                            if(Quote.SBQQ__Status__c === 'Draft' || Quote.SBQQ__Status__c === 'Rejected')
                                callUpdateQuoteConv($scope, Quote,listQuoteItem,  $scope.Wrapper.objLead, $scope.Wrapper.objOpp, listDelete, null, null);
                            else
                                $scope.DML.listErrors.push('El Estatus actual de la cotización no permite modificaciones');
                        else
                            callCreateQuoteConv($scope, Quote,listQuoteItem,  $scope.Wrapper.objLead, $scope.Wrapper.objOpp, null);

                    }
                    else{
                        if(Quote.Id)
                            if(Quote.SBQQ__Status__c === 'Draft' || Quote.SBQQ__Status__c === 'Rejected')
                                callUpdateQuoteConv($scope, Quote,listQuoteItem,  $scope.Wrapper.objLead, null, listDelete, null, null);
                            else
                                $scope.DML.listErrors.push('El Estatus actual de la cotización no permite modificaciones');
                        else
                            callCreateQuoteConv($scope, Quote,listQuoteItem,  $scope.Wrapper.objLead, null, null);
                    }
                };

                $scope.exceptionAD = function(strFeeKey){
                    return strFeeKey === 'TS';
                };

                $scope.editOrigin = function(){
                    $scope.GM.OriginDisabled = false;
                    $scope.GM.listDestiny = {};
                    $scope.fillRanges();
                };
                $scope.fillRangesByDestiny = function(){
                    $scope.GM.mapFrecc = {};
                    $scope.GM.mapFrecc = {
                        'TS':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T0':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T1':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T2':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T3':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T4':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T5':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T6':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T7':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T7P':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , 'T7V':{ranges:{}, fltFrecc: 0, intQTotal:0}
                        , intQTotal : 0
                        , fltFTotal : 0
                        , fltFEETotal : 0
                    };
                    $scope.GM.mapRanges = {};
                    $scope.GM.mapRanges = {ranges : {}};
                    j$.each($scope.GM.listRange, function (key, str) {
                        $scope.GM.mapRanges[key] = {
                            'PAQ': {fltFrecc: 0, intQTotal:0}
                            , 'ZP' :{fltFrecc: 0, intQTotal:0}
                            , 'T7' :{fltFrecc: 0, intQTotal:0}
                            , 'POR' :{fltFrecc: 0, intQTotal:0}
                            , 'PORZP' :{fltFrecc: 0, intQTotal:0}
                        };
                        /*$scope.GM.mapService['Add'].ranges[key] = { fltCostWeight : 0, fltCostVol : 0};
                        $scope.GM.mapService['ACK'].ranges[key] = { fltCost : 0 };
                        $scope.GM.mapService['ZP'].ranges[key] = { fltCost : 0 };*/
                        $scope.GM.mapRanges[key] = {
                            'PAQ': {fltFrecc: 0, intQTotal:0}
                            , 'ZP' :{fltFrecc: 0, intQTotal:0}
                            , 'T7' :{fltFrecc: 0, intQTotal:0}
                            , 'POR' :{fltFrecc: 0, intQTotal:0}
                            , 'PORZP' :{fltFrecc: 0, intQTotal:0}
                        };
                        j$.each($scope.listFee, function (keyFee, strFee) {
                            //$scope.GM.mapFrecc[keyFee] = {ranges:{}, fltFrecc: 0, intQTotal:0}
                            if(!keyFee.includes('T7_')){
                                $scope.GM.mapFrecc[keyFee].ranges[key] = {
                                    intFrecuency : 0
                                    , fltBaseFee : 0
                                    , fltFullFee : 0
                                    , fltRAD : 0
                                    , fltEAD : 0
                                    , fltACK : 0
                                    , fltSEG : 0
                                    , fltTotalNormal : 0
                                };
                                $scope.GM.mapFreccPorc[keyFee].ranges[key] = {
                                    intFrecuency : 0
                                    , fltBaseFee : 0
                                    , fltFullFee : 0
                                    , fltRAD : 0
                                    , fltEAD : 0
                                    , fltACK : 0
                                    , fltSEG : 0
                                    , fltTotalNormal : 0
                                };
                                if(keyFee != 'T7' && keyFee != 'T7V' && keyFee != 'T7P'){
                                    $scope.GM.mapFreccZP[keyFee].ranges[key] = {
                                        intFrecuency : 0
                                        , fltBaseFee : 0
                                        , fltFullFee : 0
                                        , fltRAD : 0
                                        , fltEAD : 0
                                        , fltACK : 0
                                        , fltSEG : 0
                                        , fltTotalNormal : 0
                                    };
                                    $scope.GM.mapFreccPorcZP[keyFee].ranges[key] = {
                                        intFrecuency : 0
                                        , fltBaseFee : 0
                                        , fltFullFee : 0
                                        , fltRAD : 0
                                        , fltEAD : 0
                                        , fltACK : 0
                                        , fltSEG : 0
                                        , fltTotalNormal : 0
                                    };
                                }else {
                                    $scope.GM.mapFrecc[keyFee].ranges[key].fltAVGWeight = 0;
                                    $scope.GM.mapFrecc[keyFee].ranges[key].fltAVGVol = 0;
                                    $scope.GM.mapFrecc[keyFee].ranges[key].blnSameWeight = false;
                                    $scope.GM.mapFrecc[keyFee].ranges[key].fltSameVol = false;
                                    /*$scope.GM.mapFrecc['T7V'].ranges[key] = $scope.GM.mapFrecc[keyFee].ranges[key];
                                    $scope.GM.mapFrecc['T7P'].ranges[key] = $scope.GM.mapFrecc[keyFee].ranges[key];*/
                                }
                                //$scope.GM.mapQuotes[keyFee][key] = {};
                                //if(keyFee != 'T7')
                                    //$scope.GM.mapQuotesZP[keyFee][key] = {};
                            }
                        });
                    });
                };
                $scope.fillRanges = function(){
                    if ($scope.OnlineDocByRangeKM || (!$scope.OnlineDocByRangeKM && !$scope.OnlineDocByDestiny)){
                        $scope.GM.listRange = {
                            '0-400': '0-400'
                            , '401-800': '401-800'
                            , '801-1200': '801-1200'
                            , '1201-1600': '1201-1600'
                            , '1601-2000': '1601-2000'
                            , '2001-2400': '2001-2400'
                            , '+2400' :'Más de 2400'
                        };
                        j$.each($scope.GM.listRange, function (key, str) {
                            $scope.GM.mapService['Add'].ranges[key] = { fltCostWeight : 0, fltCostVol : 0};
                            $scope.GM.mapService['ACK'].ranges[key] = { fltCost : 0 };
                            $scope.GM.mapService['ZP'].ranges[key] = { fltCost : 0 };
                            j$.each($scope.listFee, function (keyFee, strFee) {
                                $scope.GM.mapFrecc[keyFee].ranges[key] = {
                                    intFrecuency : 0
                                    , fltBaseFee : 0
                                    , fltFullFee : 0
                                    , fltRAD : 0
                                    , fltEAD : 0
                                    , fltACK : 0
                                    , fltSEG : 0
                                    , fltTotalNormal : 0
                                };
                                $scope.GM.mapFreccPorc[keyFee].ranges[key] = {
                                    intFrecuency : 0
                                    , fltBaseFee : 0
                                    , fltFullFee : 0
                                    , fltRAD : 0
                                    , fltEAD : 0
                                    , fltACK : 0
                                    , fltSEG : 0
                                    , fltTotalNormal : 0
                                };
                                if(keyFee != 'T7'){
                                    $scope.GM.mapFreccZPPorc[keyFee].ranges[key] = {
                                        intFrecuency : 0
                                        , fltBaseFee : 0
                                        , fltFullFee : 0
                                        , fltRAD : 0
                                        , fltEAD : 0
                                        , fltACK : 0
                                        , fltSEG : 0
                                        , fltTotalNormal : 0
                                    };
                                    $scope.GM.mapFreccZP[keyFee].ranges[key] = {
                                        intFrecuency : 0
                                        , fltBaseFee : 0
                                        , fltFullFee : 0
                                        , fltRAD : 0
                                        , fltEAD : 0
                                        , fltACK : 0
                                        , fltSEG : 0
                                        , fltTotalNormal : 0
                                    };
                                    $scope.GM.mapFreccPorcZP[keyFee].ranges[key] = {
                                        intFrecuency : 0
                                        , fltBaseFee : 0
                                        , fltFullFee : 0
                                        , fltRAD : 0
                                        , fltEAD : 0
                                        , fltACK : 0
                                        , fltSEG : 0
                                        , fltTotalNormal : 0
                                    };
                                }else {
                                    $scope.GM.mapPropuesta['PROP'].ranges[key] = {
                                        fltCost : 0
                                        , fltTotalPropuesta : 0
                                        , fltTotalTarifaLlena : 0
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
                                        , fltTarima : 0
                                    };
                                    $scope.GM.mapFrecc[keyFee].ranges[key].fltAVGWeight = 0;
                                    $scope.GM.mapFrecc[keyFee].ranges[key].fltAVGVol = 0;
                                    $scope.GM.mapFrecc[keyFee].ranges[key].blnSameWeight = false;
                                    $scope.GM.mapFrecc[keyFee].ranges[key].fltSameVol = false;
                                    $scope.GM.mapFrecc['T7V'].ranges[key] = $scope.GM.mapFrecc[keyFee].ranges[key];
                                    $scope.GM.mapFrecc['T7P'].ranges[key] = $scope.GM.mapFrecc[keyFee].ranges[key];
                                }
                                /*$scope.GM.mapQuotes[keyFee][key] = {};
                                if(keyFee != 'T7')
                                    $scope.GM.mapQuotesZP[keyFee][key] = {};*/
                            });
                        });
                    } else{
                        $scope.GM.listRange = {};
                    }
                };

                $scope.getKey = function(fltMaxW){
                    var key = null;
                    j$.each($scope.GM.mapLimits, function (keyFee, limits) {
                        if(fltMaxW > limits.min && fltMaxW <= limits.max){
                            key = keyFee;
                            var strKey = fltMaxW.toString();
                            key += strKey.replace('.', '_');
                        }
                    });
                    return key;
                };

                $scope.getMaxKM = function(strKey){
                    var max = 0;
                    var strRange = '';
                    if(getLabel(strKey, $scope.GM.listDestiny))
                        strRange = $scope.GM.listDestiny[strKey].range;
                    else
                        strRange = getLabel(strKey, $scope.GM.listRange);
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

                $scope.insertRange = function(strDestiny, strKM){
                    let newList = {};
                    if(isArrayEmpy($scope.GM.listRange))
                        newList[strDestiny] = strDestiny +' ('+ strKM +')';
                    else {
                        let sortable = [];
                        sortable.push([strDestiny, $scope.getMaxKM(strDestiny)]);
                        j$.each($scope.GM.listRange, function (range, key) {
                            sortable.push([range, $scope.getMaxKM(range)]);
                        });
                        sortable.sort();
                        sortable.sort(function (a, b) {
                            return a[1] - b[1];
                        });
                        j$.each(sortable, function (range, key) {
                            if(getLabel(key[0], $scope.GM.listRange))
                                newList[key[0]] = getLabel(key[0], $scope.GM.listRange);
                            else if(getLabel(key[0], $scope.GM.listDestiny))
                                newList[key[0]] = $scope.GM.listDestiny[key[0]].name;
                        });
                    }
                    let listDestiny = {};
                    Object.assign(listDestiny, $scope.GM.listDestiny);
                    $scope.GM.listRange = newList;

                    $scope.GM.listDestiny = {};
                    if(!isArrayEmpy(listDestiny))
                        j$.each(newList, function (range, key) {
                            if(getLabel(range, listDestiny))
                                $scope.GM.listDestiny[range] = {
                                    range: listDestiny[range].range
                                    , name: listDestiny[range].name
                                };
                        });

                };

                $scope.isACK = function(strMode){
                    return $scope.GM.mapService['ACK'].optForma.model.id === strMode;
                };

                $scope.isException = function(objQuote, strProfile){
                    var exception = false;
                    if(objQuote.PAQ_TipoServicio__c.includes('Estándar terrestre (STD)')) {
                        if (strProfile === 'Ejecutivo de venta') {
                            if (objQuote.Descuento_por_linea_o_rangokm__c <= 60
                                    && objQuote.Descuento_Global__c < 10.01)
                                exception = true;
                        } else if (strProfile === 'Gerente de sucursal') {
                            if (objQuote.Descuento_por_linea_o_rangokm__c <= 60
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
                        if (strProfile === 'Ejecutivo de venta') {
                            if (objQuote.Descuento_por_linea_o_rango_km_Express__c <= 25
                                    && objQuote.Descuento_Global_Express__c <= 10)
                                exception = true;
                        } else if (strProfile === 'Gerente de sucursal') {
                            if (objQuote.Descuento_por_linea_o_rango_km_Express__c <= 25
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

                $scope.isFrecc = function(keyFee){
                    return keyFee !== 'intQTotal'
                            && keyFee !== 'fltFTotal'
                            &&  keyFee !== 'fltFEETotal'
                            && keyFee !== 'T7P'
                            && keyFee !== 'T7V'
                            && (keyFee !== 'T7' || !$scope.GM.hasOverWBlocks);
                };

                $scope.isGreen = function(numDisc){
                    return numDisc < 0 && numDisc > -0.401;
                };

                $scope.isYellow = function(numDisc){
                    return numDisc < -0.40 && numDisc > -0.601;
                };

                $scope.isRed = function(numDisc){
                    return numDisc < -0.60;
                };

                $scope.next = function(){
                    $scope.GM.step2 = true;
                    $scope.GM.step1 = false;
                };

                $scope.removeBlock = function(strKey){
                    var clave = '';
                    if(strKey.includes('T7'))
                        clave = strKey.replace('T7', 'T7_');
                    delete $scope.GM.mapBlock[strKey];
                    var index = j$.inArray(strKey, $scope.listBlocksByMaxW);
                    $scope.listBlocksByMaxW.splice(index, 1);
                    delete $scope.GM.OWFrecc[strKey];
                    $scope.calculateGM();
                };

                $scope.removeService = function(service){
                    var index =  j$.inArray(service, $scope.GM.ServiceSelect.selected);
                    $scope.GM.ServiceSelect.selected.splice(index, 1);
                    $scope.GM.ServiceSelect.available.push(service);
                    switch (service.id) {
                        case 'EAD':
                            $scope.GM.blnEAD = false;
                            break;
                        case 'RAD':
                            $scope.GM.blnRAD = false;
                            break;
                        case 'SEG':
                            $scope.GM.blnSEG = false;
                            break;
                        case 'ACK':
                            $scope.GM.blnACK = false;
                            $scope.GM.strAck = '';
                            break;

                    }
                };

                $scope.replicate = function(strName, blnCheck, key){
                    debugger;
                    var fltCost = 0;
                    switch (strName){
                        case 'ZP':
                        case 'ACK':
                            if(blnCheck)
                                j$.each($scope.GM.mapService[strName].ranges, function (range, item) {
                                    if(fltCost === 0)
                                        fltCost = item.fltCost;
                                    else
                                        item.fltCost = fltCost;

                                });
                            break;
                        case 'Add':
                            if(blnCheck)
                                j$.each($scope.GM.mapService[strName].ranges, function (range, item) {
                                    if(fltCost === 0)
                                        fltCost = item.fltCostWeight;
                                    else
                                        item.fltCostWeight = fltCost;

                                    item.fltCostVol = item.fltCostWeight * 200;
                                });
                            break;
                        case 'base':
                            if(blnCheck)
                                j$.each($scope.GM.mapBlock[key].ranges, function (range, item) {
                                    if(fltCost === 0)
                                        fltCost = item.fltCost;
                                    else
                                        item.fltCost = fltCost;
                                });
                            break;
                        case 'OWFrecc':
                            debugger;
                            if(blnCheck )
                                j$.each($scope.GM.OWFrecc[key].ranges, function (range, item) {
                                    if(fltCost === 0)
                                        fltCost = item.intFrecuency;
                                    else
                                        item.intFrecuency = fltCost;
                                });
                            break;
                        case 'AVGWeightOW':
                            if(blnCheck )
                                j$.each($scope.GM.OWFrecc[key].ranges, function (range, item) {
                                    if(fltCost === 0)
                                        fltCost = item.fltAVGWeight;
                                    else
                                        item.fltAVGWeight = fltCost;
                                });
                            break;
                        case 'AVGVolOW':
                            if(blnCheck )
                                j$.each($scope.GM.OWFrecc[key].ranges, function (range, item) {
                                    if(fltCost === 0)
                                        fltCost = item.fltAVGVol;
                                    else
                                        item.fltAVGVol = fltCost;
                                });
                            break;
                        case 'AVGVol':
                            if(blnCheck )
                                j$.each($scope.GM.mapFrecc[key].ranges, function (range, item) {
                                    if(fltCost === 0)
                                        fltCost = item.fltAVGVol;
                                    else
                                        item.fltAVGVol = fltCost;
                                });
                            break;
                        case 'AVGWeight':
                            if(blnCheck)
                                j$.each($scope.GM.mapFrecc[key].ranges, function (range, item) {
                                    if(fltCost === 0)
                                        fltCost = item.fltAVGWeight;
                                    else
                                        item.fltAVGWeight = fltCost;
                                });
                            break;
                        case 'frecPaqGuias':
                            if(blnCheck){
                                j$.each($scope.GM.listRange, function (keyRange, strRange){
                                    if(!key.includes('T7_')){
                                        if($scope.GM.mapFrecc[key].ranges[keyRange].intFrecuency !== 0 && $scope.GM.mapFreccPorc[key].fltCantidad !== 0)
                                            $scope.GM.mapFreccPorc[key].ranges[keyRange].intFrecuency = $scope.GM.mapFrecc[key].ranges[keyRange].intFrecuency / $scope.GM.mapFreccPorc[key].fltCantidad;
                                        else $scope.GM.mapFreccPorc[key].ranges[keyRange].intFrecuency = 0;
                                    } else {
                                        if($scope.GM.OWFrecc[key].ranges[keyRange].intFrecuency !== 0 && $scope.GM.mapFreccPorc[key].fltCantidad !== 0)
                                            $scope.GM.mapFreccPorc[key].ranges[keyRange].intFrecuency = $scope.GM.OWFrecc[key].ranges[keyRange].intFrecuency / $scope.GM.mapFreccPorc[key].fltCantidad;
                                        else $scope.GM.mapFreccPorc[key].ranges[keyRange].intFrecuency = 0;
                                    }
                                    
                                });
                            }
                            $scope.calculateXY();
                        break;
                        case 'frecPaqGuiasZP':
                            if(blnCheck){
                                j$.each($scope.GM.listRange, function (keyRange, strRange){
                                    if($scope.GM.mapFreccZP[key].ranges[keyRange].intFrecuency !== 0 && $scope.GM.mapFreccPorcZP[key].fltCantidad !== 0)
                                        $scope.GM.mapFreccPorcZP[key].ranges[keyRange].intFrecuency = $scope.GM.mapFreccZP[key].ranges[keyRange].intFrecuency / $scope.GM.mapFreccPorcZP[key].fltCantidad;
                                    else $scope.GM.mapFreccPorcZP[key].ranges[keyRange].intFrecuency = 0;
                                });
                            }
                            $scope.calculateXY();
                        break;
                    }
                };

                $scope.setACK = function(model){
                    $scope.GM.strACK = model.id;
                };

                $scope.setACKmode = function(model){
                    if(model.id === 'G')
                        $scope.GM.strAckCost = 'Guía';
                    if(model.id === 'B')
                        $scope.GM.strAckCost = 'Paquete';
                };

                $scope.setValue = function(name, key, cmp, keyX){
                    if (notEmpty(cmp.target.textContent))
                        switch (name) {
                            case 'fltCost':
                                $scope.GM.mapBlock[keyX].ranges[key].fltCost = getNumFromCurrency(cmp.target.textContent);
                                $scope.calculateGM();
                                break;
                            case 'fltMaxW':
                                $scope.GM.mapBlock[keyX].fltMaxW = getNum(cmp.target.textContent);
                                $scope.calculateGM();
                                break;
                            case 'fltMaxV':
                                $scope.GM.mapBlock[keyX].fltMaxV = getNum(cmp.target.textContent);
                                $scope.GM.mapBlock[keyX].fltVolWeight = $scope.GM.mapBlock[keyX].fltMaxV * 200;
                                var strKeyRango = '';
                                j$.each($scope.listBlocksByMaxW, function (k, val) {
                                    if(val.value === $scope.GM.mapBlock[keyX].fltMaxW)
                                        val.vol = $scope.GM.mapBlock[keyX].fltMaxV;
                                    if (keyX.includes('T7'))
                                        strKeyRango = 'T7_' + $scope.GM.mapBlock[keyX].fltMaxW;
                                    j$.each($scope.GM.listRange, function (keyRange, strRange) {
                                        $scope.GM.OWFrecc[strKeyRango].ranges[keyRange].fltAVGVol = $scope.GM.mapBlock[keyX].fltMaxV;
                                    });
                                });
                                $scope.calculateGM();
                                break;
                            case 'fltCostWeight':
                                $scope.GM.mapService[keyX].ranges[key].fltCostWeight = getNumFromCurrency(cmp.target.textContent);
                                $scope.GM.mapService[keyX].ranges[key].fltCostVol = $scope.GM.mapService[keyX].ranges[key].fltCostWeight * 200;
                                $scope.calculateGM();
                                break;
                            case 'fltCostService':
                                $scope.GM.mapService[keyX].fltCost = getNumFromCurrency(cmp.target.textContent);
                                $scope.calculateGM();
                                break;
                            case 'fltCostRange':
                                $scope.GM.mapService[keyX].ranges[key].fltCost = getNumFromCurrency(cmp.target.textContent);
                                $scope.calculateGM();
                                break;
                            case 'AVGDeliveryACK':
                                $scope.GM.mapService[keyX].fltAVGDeliveryByACK = getNumFromPercent(cmp.target.textContent);
                                $scope.calculateGM();
                                break;
                            case 'AVGPack':
                                $scope.GM.mapService[keyX].fltAVGPackByDay = getNum(cmp.target.textContent);
                                $scope.calculateGM();
                                break;
                            case 'intFrecuency':
                                $scope.GM.mapFrecc[keyX].ranges[key].intFrecuency = getNum(cmp.target.textContent);
                                $scope.calculateXY();
                                break;
                            case 'intFrecuencyZP':
                                $scope.GM.mapFreccZP[keyX].ranges[key].intFrecuency = getNum(cmp.target.textContent);
                                $scope.calculateXY();
                                break;
                            case 'fltFreccFee':
                                $scope.GM.mapFrecc[keyX].fltFrecc = getNumFromPercent(cmp.target.textContent);
                                $scope.calculateQ();
                                break;
                            case 'fltFreccRange':
                                $scope.GM.mapRanges[key]['PAQ'].fltFrecc = getNumFromPercent(cmp.target.textContent);
                                $scope.calculateQ();
                                break;
                            case 'intQTotal':
                                $scope.GM.mapFrecc.intQTotal = getNum(cmp.target.textContent);
                                $scope.calculateQ();
                                break;
                            case 'fltFreccFeeZP':
                                $scope.GM.mapFreccZP[keyX].fltFrecc = getNumFromPercent(cmp.target.textContent);
                                $scope.calculateQ();
                                break;
                            case 'fltFreccRangeZP':
                                $scope.GM.mapRanges[key]['ZP'].fltFrecc = getNumFromPercent(cmp.target.textContent);
                                $scope.calculateQ();
                                break;
                            case 'intQTotalZP':
                                $scope.GM.mapFreccZP.intQTotal = getNum(cmp.target.textContent);
                                $scope.calculateQ();
                                break;
                            case 'AVGWeightOW':
                                $scope.GM.OWFrecc[keyX].ranges[key].fltAVGWeight = getNum(cmp.target.textContent);
                                $scope.calculateQ();
                                break;
                            case 'AVGVolOW':
                                $scope.GM.OWFrecc[keyX].ranges[key].fltAVGVol = getNum(cmp.target.textContent);
                                $scope.calculateQ();
                                break;
                            case 'intFrecuencyOW':
                                $scope.GM.OWFrecc[keyX].ranges[key].intFrecuency = getNum(cmp.target.textContent);
                                $scope.calculateXY();
                                break;
                            case 'fltAVGWeight':
                                $scope.GM.mapFrecc[keyX].ranges[key].fltAVGWeight = getNumFromCurrency(cmp.target.textContent);
                                $scope.calculateGM();
                                break;
                            case 'fltAVGVol':
                                $scope.GM.mapFrecc[keyX].ranges[key].fltAVGVol = getNumFromCurrency(cmp.target.textContent);
                                $scope.calculateXY();
                                break;
                            case 'intFrecuencyPorc':
                                $scope.GM.mapFreccPorc[keyX].fltCantidad = getNum(cmp.target.textContent);
                                $scope.calculateXY();
                            break;
                            case 'intFrecuencyPorcZP':
                                $scope.GM.mapFreccPorcZP[keyX].fltCantidad = getNum(cmp.target.textContent);
                                $scope.calculateXY();
                            break;
                            case 'intPaqGuias':
                                $scope.GM.mapFreccPorc[keyX].ranges[key].intFrecuency = getNum(cmp.target.textContent);
                                $scope.calculateXY();
                            break;
                            case 'intPaqGuias':
                                $scope.GM.mapFreccPorcZP[keyX].ranges[key].intFrecuency = getNum(cmp.target.textContent);
                                $scope.calculateXY();
                            break;
                        }
                        if(name === 'blnT7ZP'){
                            j$.each($scope.GM.mapBlock, function(key, map){
                                if(keyX !== key)
                                    map.blnT7ZP = false;
                            });
                        }

                };

                $scope.updateFees = function(strOpp, strList){
                    switch (strOpp) {
                        case 'add':
                            if(strList=== 'service')
                                for (var index = 0; index <= $scope.GM.ServiceSelect.available.length; index++){
                                    var service = $scope.GM.ServiceSelect.available[index];
                                    if(service && service.blnSelected){
                                        service.blnSelected = false;
                                        $scope.addService(service);
                                        index--;
                                    }
                                }
                            $scope.calculateGM();
                            break;
                        case 'remove':
                             if(strList=== 'service')
                                for (var index = 0; index <= $scope.GM.ServiceSelect.selected.length; index++){
                                    var service = $scope.GM.ServiceSelect.selected[index];
                                    if(service && service.blnSelected){
                                        service.blnSelected = false;
                                        $scope.removeService(service);
                                        index--;
                                    }
                                }
                            $scope.calculateGM();
                            break;
                    }
                    $scope.GM.blnFeeAddAll = false;
                    $scope.GM.blnFeeRemoveAll = false;
                    $scope.GM.blnServiceAddAll = false;
                    $scope.GM.blnServiceRemoveAll = false;
                };

                $scope.validateKG = function(fltMaxW){
                    return isNaN(fltMaxW) || fltMaxW < 1 ;
                };

                $scope.dataTest = function(){
                    $scope.GM.mapRanges['0-400']['PAQ'].fltFrecc = .15;
                    $scope.GM.mapRanges['0-400']['ZP'].fltFrecc = .15;
                    $scope.GM.mapRanges['401-800']['PAQ'].fltFrecc = .20;
                    $scope.GM.mapRanges['401-800']['ZP'].fltFrecc = .20;
                    $scope.GM.mapRanges['801-1200']['PAQ'].fltFrecc = .20;
                    $scope.GM.mapRanges['801-1200']['ZP'].fltFrecc = .20;
                    $scope.GM.mapRanges['1201-1600']['PAQ'].fltFrecc = .10;
                    $scope.GM.mapRanges['1201-1600']['ZP'].fltFrecc = .10;
                    $scope.GM.mapRanges['1601-2000']['PAQ'].fltFrecc = .20;
                    $scope.GM.mapRanges['1601-2000']['ZP'].fltFrecc = .20;
                    $scope.GM.mapRanges['2001-2400']['PAQ'].fltFrecc = .10;
                    $scope.GM.mapRanges['2001-2400']['ZP'].fltFrecc = .10;
                    $scope.GM.mapRanges['+2400']['PAQ'].fltFrecc = .05;
                    $scope.GM.mapRanges['+2400']['ZP'].fltFrecc = .05;
                    $scope.GM.mapFrecc['TS'].fltFrecc = .30;
                    $scope.GM.mapFreccZP['TS'].fltFrecc = .30;
                    $scope.GM.mapFrecc['T0'].fltFrecc = .35;
                    $scope.GM.mapFreccZP['T0'].fltFrecc = .35;
                    $scope.GM.mapFrecc['T1'].fltFrecc = .10;
                    $scope.GM.mapFreccZP['T1'].fltFrecc = .10;
                    $scope.GM.mapFrecc['T2'].fltFrecc = .07;
                    $scope.GM.mapFreccZP['T2'].fltFrecc = .07;
                    $scope.GM.mapFrecc['T3'].fltFrecc = .06;
                    $scope.GM.mapFreccZP['T3'].fltFrecc = .06;
                    $scope.GM.mapFrecc['T4'].fltFrecc = .05;
                    $scope.GM.mapFreccZP['T4'].fltFrecc = .05;
                    $scope.GM.mapFrecc['T5'].fltFrecc = .03;
                    $scope.GM.mapFreccZP['T5'].fltFrecc = .04;
                    $scope.GM.mapFrecc['T6'].fltFrecc = .03;
                    $scope.GM.mapFreccZP['T6'].fltFrecc = .03;
                    $scope.GM.mapFrecc['T7'].fltFrecc = .01;
                    j$.each($scope.GM.listRange, function (keyRange, range) {
                        $scope.GM.mapFrecc['T7'].ranges[keyRange].fltAVGWeight =  155.3;
                        $scope.GM.mapFrecc['T7'].ranges[keyRange].fltAVGVol =  1.3;
                        $scope.GM.mapService['ZP'].ranges[keyRange].fltCost = 150;
                        $scope.GM.mapService['ACK'].ranges[keyRange].fltCost = 25;
                    });
                    $scope.GM.mapFrecc.intQTotal = 23040;
                    $scope.GM.mapFreccZP.intQTotal = 15000;
                    $scope.addBlock(4);
                    $scope.GM.mapBlock['T04'].fltVolW = .009;
                    $scope.GM.mapBlock['T04'].fltVolWeight = 1.8;
                    $scope.addBlock(9);
                    $scope.GM.mapBlock['T19'].fltVolW = .015;
                    $scope.GM.mapBlock['T19'].fltVolWeight = 3;
                    $scope.GM.mapBlock['T04'].ranges['0-400'].fltCost = 85;
                    $scope.GM.mapBlock['T04'].ranges['401-800'].fltCost = 85;
                    $scope.GM.mapBlock['T04'].ranges['801-1200'].fltCost = 85;
                    $scope.GM.mapBlock['T04'].ranges['1201-1600'].fltCost = 95;
                    $scope.GM.mapBlock['T04'].ranges['1601-2000'].fltCost = 95;
                    $scope.GM.mapBlock['T04'].ranges['2001-2400'].fltCost = 95;
                    $scope.GM.mapBlock['T04'].ranges['+2400'].fltCost = 95;
                    $scope.GM.mapBlock['T19'].ranges['0-400'].fltCost = 95;
                    $scope.GM.mapBlock['T19'].ranges['401-800'].fltCost = 95;
                    $scope.GM.mapBlock['T19'].ranges['801-1200'].fltCost = 95;
                    $scope.GM.mapBlock['T19'].ranges['1201-1600'].fltCost = 105;
                    $scope.GM.mapBlock['T19'].ranges['1601-2000'].fltCost = 105;
                    $scope.GM.mapBlock['T19'].ranges['2001-2400'].fltCost = 105;
                    $scope.GM.mapBlock['T19'].ranges['+2400'].fltCost = 105;
                    $scope.GM.mapService['Add'].ranges['0-400'].fltCostWeight = 4.75;
                    $scope.GM.mapService['Add'].ranges['401-800'].fltCostWeight = 4.75;
                    $scope.GM.mapService['Add'].ranges['801-1200'].fltCostWeight = 4.75;
                    $scope.GM.mapService['Add'].ranges['1201-1600'].fltCostWeight = 6;
                    $scope.GM.mapService['Add'].ranges['1601-2000'].fltCostWeight = 6;
                    $scope.GM.mapService['Add'].ranges['2001-2400'].fltCostWeight = 6;
                    $scope.GM.mapService['Add'].ranges['+2400'].fltCostWeight = 6;
                    $scope.GM.mapService['Add'].ranges['0-400'].fltCostVol = 4.75 * 200;
                    $scope.GM.mapService['Add'].ranges['401-800'].fltCostVol = 4.75 * 200;
                    $scope.GM.mapService['Add'].ranges['801-1200'].fltCostVol = 4.75 * 200;
                    $scope.GM.mapService['Add'].ranges['1201-1600'].fltCostVol = 6 * 200;
                    $scope.GM.mapService['Add'].ranges['1601-2000'].fltCostVol =  6 * 200;
                    $scope.GM.mapService['Add'].ranges['2001-2400'].fltCostVol =  6 * 200;
                    $scope.GM.mapService['Add'].ranges['+2400'].fltCostVol =  6 * 200;
                    $scope.calculateQ();
                };
                $scope.redireccionar = function(){
                    debugger;
                    var blnRedirec = false;
                    $scope.DocLineaTZP = true;
                    j$('.tabPill').removeClass('active');
                    j$('.tab-pane').removeClass('in active');
                    $scope.$parent.$parent.DocLineaTZP = true;
                    $scope.$parent.$parent.blnT7GuiaMult = true;
                    $scope.$parent.$parent.Quotes = 
                    j$('#OZP').addClass('in active');
                    j$('#OZP').addClass('active');
                    j$.each($scope.GM.mapBlock, function(key, map){
                        if(map.blnT7ZP)
                            blnRedirec = true;
                    });
                    if(!blnRedirec){
                        alert('No puede cotizar en zona plus si no ha seleccionado un bloque para ello.');
                        xhrInstance.abort();
                    } else
                        $scope.start();
                };

                /*
                * initial Call
                */
                console.log('END LOAD Angular Controller GMP');
                $scope.fillRanges();
                debugger;
                if($scope.Wrapper.mapTender && !$scope.OnlineDocByDestiny)
                    LlenaMapaTenders($scope, true);
                if($scope.hasRecord()){
                    $scope.GM.strAck = $scope.Wrapper.objQuote.Acuse__c;
                    $scope.OnlineDocByRangeKM = $scope.Wrapper.objQuote.RangosKM__c;
                    $scope.OnlineDocByDestiny = $scope.Wrapper.objQuote.Destinos__c;
                    $scope.GM.strOrigen = $scope.Wrapper.objQuote.OriginCity__c;
                    $scope.GM.blnCotizaT7ZP = $scope.Wrapper.objQuote.Es_T7_Zona_plus__c;
                    $scope.fillRanges();
                    if ($scope.Wrapper.objQuote.Destinos__c)
                        $scope.GM.listRange = {};
                    if($scope.Wrapper.objQuote.Servicios_adicionales__c)
                        j$.each( $scope.Wrapper.objQuote.Servicios_adicionales__c.split(';'),function (key, service) {
                            switch (service) {
                                case 'RAD':
                                    $scope.GM.blnRAD = true;
                                    break;
                                case 'EAD':
                                    $scope.GM.blnEAD = true;
                                    break;
                                case 'Seguro':
                                    $scope.GM.blnSEG = true;
                                    break;
                                case 'Acuse Empresa':
                                    $scope.GM.blnACK = true;
                                    break;
                                case 'Acuse Interno':
                                    $scope.GM.blnACK = true;
                                    break;
                                case 'Acuse XT':
                                    $scope.GM.blnACK = true;
                                    break;
                            }
                        });
                    j$.each($scope.GM.ServiceSelect.available, function(key, value){
                        switch (value.id) {
                            case 'RAD':
                                value.blnSelected = $scope.GM.blnRAD;
                                break;
                            case 'EAD':
                                value.blnSelected = $scope.GM.blnEAD;
                                break;
                            case 'SEG':
                                value.blnSelected = $scope.GM.blnSEG;
                                break;
                            case 'ACK':
                                value.blnSelected = notEmpty($scope.Wrapper.objQuote.Acuse__c);
                                break;
                        }
                    });
                    $scope.GM.strACK = $scope.Wrapper.objQuote.Acuse__c;
                    $scope.GM.mapService['ACK'].optOption.model = getModel($scope.GM.strACK, $scope.GM.mapService['ACK'].optOption.aviableOptions);
                    $scope.GM.strAckCost = $scope.Wrapper.objQuote.AcuseCosto__c;
                    $scope.GM.mapService['ACK'].fltAVGDeliveryByACK = $scope.Wrapper.objQuote.AVRDeliveryACK__c;
                    $scope.GM.mapService['ACK'].fltAVGPackByDay = $scope.Wrapper.objQuote.AVRPackByDelivery__c;
                    if($scope.GM.strAckCost === 'P')
                        $scope.GM.mapService['ACK'].optForma.model = getModel('B', $scope.GM.mapService['ACK'].optForma.aviableOptions);
                    else
                        $scope.GM.mapService['ACK'].optForma.model = getModel('G', $scope.GM.mapService['ACK'].optForma.aviableOptions);
                    if($scope.OnlineDocByDestiny){
                        $scope.GM.mapQuotesT7ZP.Tender = {};
                        $scope.GM.mapTender = {};
                    }else {
                        j$.each($scope.GM.mapTender, function(keyTender, strTender){
                            $scope.GM.mapQuotesT7ZP.Tender[keyTender].strOrigen = $scope.GM.strOrigen;
                            ObtieneRangoKMT7ZP($scope, $scope.GM.strOrigen, keyTender.replace('70',''));
                        });
                    }
                    j$.each($scope.Wrapper.listQuoteItem, function (index, quoteItem) {
                        if (quoteItem.PackWeightAVG__c > 60){
                            var key = 'T7' + quoteItem.PackWeightAVG__c;
                            var keyFee = '';
                            if(quoteItem.Tarifa__c.includes('TARIFA T7_'))
                                keyFee = quoteItem.Tarifa__c
                            else keyFee = getId(quoteItem.Tarifa__c, $scope.GM.listFee);
                            $scope.GM.hasOverWBlocks = true;
                            if(!getLabel('T7_'+ quoteItem.PackWeightAVG__c, $scope.GM.mapFreccPorcT7ZP))
                                $scope.GM.mapFreccPorcT7ZP['T7_' + quoteItem.PackWeightAVG__c] = {
                                    ranges : {} 
                                    , fltFrecc: 0
                                    , intQTotal:0
                                    , fltCantidad : quoteItem.PaqPromPorGuia__c 
                                    , blnCalcular : false
                                };
                        } else {

                            var key = '';
                            if(quoteItem.PackWeightAVG__c <= 1)
                                key = 'TS1'
                            else key = $scope.getKey(quoteItem.PackWeightAVG__c);
                            
                            var keyFee = getId(quoteItem.Tarifa__c, $scope.GM.listFee);
                        }
                        if(quoteItem.Tarifa__c === 'TARIFA T7' && quoteItem.ZonaPlus__c){
                            let rango = '';
                            if($scope.OnlineDocByDestiny){
                                rango = quoteItem.Destiny__c.replace(' (' + quoteItem.Rango_KM__c+')', '');
                                if(quoteItem.SBQQ__Description__c === 'Destino'){
                                        $scope.GM.mapTender[quoteItem.Destiny__c] = {
                                        strName : quoteItem.Destiny__c
                                        , keyName : quoteItem.Destiny__c
                                        , fltLarge : 0//Tender.Largo__c
                                        , fltWidth : 0//Tender.Peso__c
                                        , fltHigh : 0//Tender.Alto__c
                                        , fltWeight : 0//Tender.Peso__c
                                        , fltVol : 0//Tender.Alto__c * Tender.Peso__c * Tender.Largo__c
                                        , fltCost : 0//Tender.Costo__c
                                        , fltExc : 0//Tender.Costo__c
                                        , id : ''
                                    };
                                    LlenaMapaTenders($scope, false);
                                }
                            } else {
                                if(quoteItem.SBQQ__Description__c === 'Destino')
                                    rango = quoteItem.Destiny__c.replace(' (' + quoteItem.Rango_KM__c+')', '');
                                else if (quoteItem.SBQQ__Description__c === 'Propuesta' && quoteItem.Destiny__c)
                                    rango = quoteItem.Destiny__c.replace(' (' + quoteItem.Rango_KM__c+')', '');
                                else {
                                    if(quoteItem.Rango_KM__c === 'Más de 2400')
                                        rango = '+2400';
                                    else rango = quoteItem.Rango_KM__c;
                                }
                            }
                            if(!quoteItem.SBQQ__Description__c)
                                $scope.GM.mapQuotesT7ZP.Tender[quoteItem.Destiny__c] = {
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
                                    , strOrigen : $scope.GM.strOrigen
                                    , fltFullFee : quoteItem.Flete__c
                                }
                            else{
                                if(quoteItem.SBQQ__Description__c === 'Destino'){
                                    $scope.GM.mapQuotesT7ZP.Tender[quoteItem.Destiny__c] = {
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
                                        , strOrigen : $scope.GM.strOrigen
                                        , fltFullFee : quoteItem.Flete__c
                                        , strTenderDestino : quoteItem.Destiny__c
                                    };
                                    $scope.GM.mapTender[quoteItem.Destiny__c] = {
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
                                } else if(quoteItem.SBQQ__Description__c === 'Propuesta'){
                                    $scope.GM.mapPropuesta['PROP'].ranges[rango] = {
                                        fltDescuento : quoteItem.SBQQ__Discount__c
                                        , fltTotalPropuesta : quoteItem.SBQQ__CustomerPrice__c
                                        , fltTotalTarifaLlena : quoteItem.SBQQ__NetPrice__c
                                        , fltCost : quoteItem.SBQQ__SpecialPrice__c
                                        , intFrecuency : 0
                                        , Id : quoteItem.Id
                                    };
                                    if(!getLabel(rango, $scope.GM.mapFreccPorcT7ZP['T7_' + quoteItem.PackWeightAVG__c].ranges))
                                        $scope.GM.mapFreccPorcT7ZP['T7_' + quoteItem.PackWeightAVG__c].ranges[rango] = {
                                            intFrecuency : quoteItem.PaqPorGuia__c
                                            , fltBaseFee : 0
                                            , fltFullFee : 0
                                            , fltRAD : 0
                                            , fltEAD : 0
                                            , fltACK : 0
                                            , fltSEG : 0
                                            , fltTotalNormal : 0
                                        };
                                }
                                if(!getLabel('T7'+ quoteItem.PackWeightAVG__c, $scope.GM.mapBlock))
                                    $scope.GM.mapBlock['T7' + quoteItem.PackWeightAVG__c] = {
                                        strLabel : 'T7'
                                        , fltMaxW : quoteItem.PackWeightAVG__c
                                        , fltVolW : quoteItem.PackVolAVG__c
                                        , fltVolWeight: 0
                                        , blnSameCost : false
                                        , blnT7ZP : true
                                        , ranges : {}
                                    };
                                $scope.listBlocksByMaxW.push({key:key, value: quoteItem.PackWeightAVG__c});
                                if(!getLabel(rango, $scope.GM.mapBlock['T7' + quoteItem.PackWeightAVG__c].ranges[rango]))
                                    $scope.GM.mapBlock['T7' + quoteItem.PackWeightAVG__c].ranges[rango] = {
                                        fltCost : 0
                                    };
                                $scope.GM.mapBlock['T7' + quoteItem.PackWeightAVG__c].ranges[rango].fltCost = quoteItem.GUIA__c;
                                $scope.GM.mapBlock['T7' + quoteItem.PackWeightAVG__c].blnT7ZP = true;
                            }
                        } else {
                            if ($scope.Wrapper.objQuote.Destinos__c){
                                var keyr = '';
                                var destino = '';
                                var destinyok = '';
                                if(quoteItem.Destiny__c.includes('Más'))
                                    destinyok = quoteItem.Destiny__c.replace('Más de ', '+')
                                else destinyok = quoteItem.Destiny__c;
                                if (quoteItem.Rango_KM__c === 'Más de 2400')
                                    keyr = '+2400';
                                else keyr = quoteItem.Rango_KM__c;
                                destino = quoteItem.Destiny__c.replace(' (' + quoteItem.Rango_KM__c+')', '');
                                var keyRange = destino;
                                if(!getLabel(destino, $scope.GM.listDestiny))
                                    $scope.GM.listDestiny[destino] = {
                                        range: keyr
                                        , name: quoteItem.Destiny__c
                                    };
                                if(!getLabel(destino, $scope.GM.mapService['Add'].ranges) && !getLabel(destino, $scope.GM.mapService['ACK'].ranges) && !getLabel(destino, $scope.GM.mapService['ZP'].ranges)){
                                    $scope.GM.mapService['Add'].ranges[destino] = { fltCostWeight : 0, fltCostVol : 0};
                                    $scope.GM.mapService['ACK'].ranges[destino] = { fltCost : 0 };
                                    $scope.GM.mapService['ZP'].ranges[destino] = { fltCost : 0 };
                                }
                                $scope.insertRange(destino, quoteItem.Rango_KM__c);
                                if (quoteItem.PackWeightAVG__c > 60){
                                    $scope.listFee['T7_'+ quoteItem.PackWeightAVG__c] = 'TARIFA T7_'+ quoteItem.PackWeightAVG__c;
                                    if(!getLabel('T7_'+ quoteItem.PackWeightAVG__c, $scope.GM.mapQuotes))
                                        $scope.GM.mapQuotes['T7_' + quoteItem.PackWeightAVG__c] = {};
                                    $scope.GM.listDestiny[destino] = {
                                        range: keyr
                                        , name: quoteItem.Destiny__c
                                    };
                                    if(!getLabel('T7'+ quoteItem.PackWeightAVG__c, $scope.GM.mapBlock))
                                        $scope.GM.mapBlock['T7' + quoteItem.PackWeightAVG__c] = {
                                            strLabel : 'T7'
                                            , fltMaxW : quoteItem.PackWeightAVG__c
                                            , fltVolW : quoteItem.PackVolAVG__c
                                            , fltVolWeight: 0
                                            , blnSameCost : false
                                            , ranges : {}
                                        };
                                    $scope.listBlocksByMaxW.push({key:key, value: quoteItem.PackWeightAVG__c});
                                    if(!getLabel(destino, $scope.GM.mapBlock['T7' + quoteItem.PackWeightAVG__c].ranges[destino]))
                                        $scope.GM.mapBlock['T7' + quoteItem.PackWeightAVG__c].ranges[destino] = {
                                            fltCost : 0
                                        };
                                    if(!getLabel('T7_'+ quoteItem.PackWeightAVG__c, $scope.GM.OWFrecc))
                                        $scope.GM.OWFrecc['T7_'+ quoteItem.PackWeightAVG__c] = {
                                            ranges:{}
                                            , fltFrecc: 0
                                            , intQTotal:0
                                            , strName: quoteItem.PackWeightAVG__c + 'kg'
                                            , blnSameFrecc :false
                                            , blnSameWeight :false
                                            , blnSameVol :false
                                        };
                                    if(!getLabel('T7_'+ quoteItem.PackWeightAVG__c, $scope.GM.mapFreccPorc))
                                        $scope.GM.mapFreccPorc['T7_' + quoteItem.PackWeightAVG__c] = {ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false};
                                    if(!getLabel(destino, $scope.GM.mapFreccPorc['T7_' + quoteItem.PackWeightAVG__c].ranges))
                                        $scope.GM.mapFreccPorc['T7_' + quoteItem.PackWeightAVG__c].ranges[destino] = {
                                            intFrecuency : 0
                                            , fltBaseFee : 0
                                            , fltFullFee : 0
                                            , fltRAD : 0
                                            , fltEAD : 0
                                            , fltACK : 0
                                            , fltSEG : 0
                                            , fltTotalNormal : 0
                                        };
                                    if(!getLabel('T7', $scope.GM.mapFreccPorc))
                                        $scope.GM.mapFreccPorc['T7'] = {ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false};
                                    if(!getLabel(destino, $scope.GM.mapFreccPorc['T7'].ranges))
                                        $scope.GM.mapFreccPorc['T7'].ranges[destino] = {
                                            intFrecuency : 0
                                            , fltBaseFee : 0
                                            , fltFullFee : 0
                                            , fltRAD : 0
                                            , fltEAD : 0
                                            , fltACK : 0
                                            , fltSEG : 0
                                            , fltTotalNormal : 0
                                        };
                                    if(!getLabel('T7', $scope.GM.mapFrecc))
                                        $scope.GM.mapFrecc['T7'] = {ranges:{},fltFrecc: 0, intQTotal:0};
                                    if(!getLabel(destino, $scope.GM.mapFrecc['T7'].ranges))
                                        $scope.GM.mapFrecc['T7'].ranges[destino] = {
                                            intFrecuency : 0
                                            , fltBaseFee : 0
                                            , fltFullFee : 0
                                            , fltRAD : 0
                                            , fltEAD : 0
                                            , fltACK : 0
                                            , fltSEG : 0
                                            , fltTotalNormal : 0
                                        };
                                    if(!getLabel(destino, $scope.GM.OWFrecc['T7_'+ quoteItem.PackWeightAVG__c].ranges[destino])){
                                        $scope.GM.OWFrecc['T7_'+ quoteItem.PackWeightAVG__c].ranges[destino] = {
                                            intFrecuency : 0
                                            , fltAVGWeight : quoteItem.PackWeightAVG__c
                                            , fltAVGVol : quoteItem.PackVolAVG__c
                                            , fltBaseFee : 0
                                            , fltFullFee : 0
                                            , fltRAD : 0
                                            , fltEAD : 0
                                            , fltACK : 0
                                            , fltSEG : 0
                                            , fltTotalNormal : 0
                                        };
                                        $scope.GM.mapQuotes['T7_'+ quoteItem.PackWeightAVG__c][destino] = {};
                                    }

                                    if(!keyFee.includes('TARIFA T7_')){
                                        if(!getLabel(destino, $scope.GM.mapFrecc[keyFee].ranges))
                                            $scope.GM.mapFrecc[keyFee].ranges[destino] = {
                                                intFrecuency : 0
                                                , fltBaseFee : 0
                                                , fltBaseFeeP : 0
                                                , fltFullFee : 0
                                                , fltFullFeeP : 0
                                                , fltRAD : 0
                                                , fltRADP : 0
                                                , fltEAD : 0
                                                , fltEADP : 0
                                                , fltACK : 0
                                                , fltACKP : 0
                                                , fltSEG : 0
                                                , fltTotalNormal : 0
                                                , fltTotalNormalP : 0
                                                , fltAVGVol : $scope.GM.mapBlock[key].fltMaxV
                                                , fltAVGWeight : $scope.GM.mapBlock[key].fltMaxW
                                            };
                                        if(keyFee !== 'T7'){
                                            if(!getLabel(destino, $scope.GM.mapFreccZP[keyFee].ranges))
                                                $scope.GM.mapFreccZP[keyFee].ranges[destino] = {
                                                    intFrecuency : 0
                                                    , fltBaseFee : 0
                                                    , fltFullFee : 0
                                                    , fltRAD : 0
                                                    , fltEAD : 0
                                                    , fltACK : 0
                                                    , fltSEG : 0
                                                    , fltTotalNormal : 0
                                                };
                                        }
                                        $scope.GM.mapFrecc['T7V'].ranges[destino] = $scope.GM.mapFrecc[keyFee].ranges[destino];
                                        $scope.GM.mapFrecc['T7P'].ranges[destino] = $scope.GM.mapFrecc[keyFee].ranges[destino];
                                        if(!getLabel(destino, $scope.GM.mapFreccPorc[keyFee].ranges))
                                            $scope.GM.mapFreccPorc[keyFee].ranges[destino] = {
                                                intFrecuency : 0
                                                , fltBaseFee : 0
                                                , fltFullFee : 0
                                                , fltRAD : 0
                                                , fltEAD : 0
                                                , fltACK : 0
                                                , fltSEG : 0
                                                , fltTotalNormal : 0
                                            };
                                        if((keyFee != 'T7' && keyFee != 'T7V' && keyFee != 'T7P') && (!getLabel(destino, $scope.GM.mapFreccPorcZP[keyFee].ranges)))
                                            $scope.GM.mapFreccPorcZP[keyFee].ranges[destino] = {
                                                intFrecuency : 0
                                                , fltBaseFee : 0
                                                , fltFullFee : 0
                                                , fltRAD : 0
                                                , fltEAD : 0
                                                , fltACK : 0
                                                , fltSEG : 0
                                                , fltTotalNormal : 0
                                            };
                                        $scope.GM.mapRanges[destino] = {
                                            'PAQ': {fltFrecc: 0, intQTotal:0}
                                            , 'ZP' :{fltFrecc: 0, intQTotal:0}
                                            , 'T7' :{fltFrecc: 0, intQTotal:0}
                                            , 'POR' :{fltFrecc: 0, intQTotal:0}
                                            , 'PORZP' :{fltFrecc: 0, intQTotal:0}
                                        }
                                        //$scope.GM.mapQuotes[keyFee][destino] = {};
                                        if(keyFee !== 'T7' && !keyFee.includes('T7_'))
                                            $scope.GM.mapQuotesZP[keyFee][destino] = {};
                                    }
                                } else {
                                    if(!getLabel(key, $scope.GM.mapBlock))
                                        $scope.GM.mapBlock[key] = {
                                            strLabel : key
                                            , fltMaxW : quoteItem.PackWeightAVG__c
                                            , fltMaxV : quoteItem.PackVolAVG__c
                                            , fltVolW : quoteItem.PackVolAVG__c
                                            , fltVolWeight: 0
                                            , blnSameCost : false
                                            , ranges : {}
                                        };
                                    $scope.listBlocksByMaxW.push({key:key, value: quoteItem.PackWeightAVG__c});
                                    j$.each($scope.GM.listFee, function(keyFee, strFee){
                                        $scope.GM.mapBlock[key].ranges[destino] = {
                                            fltCost : 0
                                        }
                                        if(!getLabel(destino, $scope.GM.mapFrecc[keyFee].ranges))
                                            $scope.GM.mapFrecc[keyFee].ranges[destino] = {
                                                intFrecuency : 0
                                                , fltBaseFee : 0
                                                , fltBaseFeeP : 0
                                                , fltFullFee : 0
                                                , fltFullFeeP : 0
                                                , fltRAD : 0
                                                , fltRADP : 0
                                                , fltEAD : 0
                                                , fltEADP : 0
                                                , fltACK : 0
                                                , fltACKP : 0
                                                , fltSEG : 0
                                                , fltTotalNormal : 0
                                                , fltTotalNormalP : 0
                                                , fltAVGVol : $scope.GM.mapBlock[key].fltMaxV
                                                , fltAVGWeight : $scope.GM.mapBlock[key].fltMaxW
                                            };
                                            if(!getLabel(destino, $scope.GM.mapFreccPorc[keyFee].ranges))
                                                $scope.GM.mapFreccPorc[keyFee].ranges[destino] = {
                                                    intFrecuency : 0
                                                    , fltBaseFee : 0
                                                    , fltFullFee : 0
                                                    , fltRAD : 0
                                                    , fltEAD : 0
                                                    , fltACK : 0
                                                    , fltSEG : 0
                                                    , fltTotalNormal : 0
                                                };
                                            if((keyFee != 'T7' && keyFee != 'T7V' && keyFee != 'T7P') && (!getLabel(destino, $scope.GM.mapFreccPorcZP[keyFee].ranges)))
                                                $scope.GM.mapFreccPorcZP[keyFee].ranges[destino] = {
                                                    intFrecuency : 0
                                                    , fltBaseFee : 0
                                                    , fltFullFee : 0
                                                    , fltRAD : 0
                                                    , fltEAD : 0
                                                    , fltACK : 0
                                                    , fltSEG : 0
                                                    , fltTotalNormal : 0
                                                };
                                        if(keyFee !== 'T7'){
                                            if(!getLabel(destino, $scope.GM.mapFreccZP[keyFee].ranges))
                                                $scope.GM.mapFreccZP[keyFee].ranges[destino] = {
                                                    intFrecuency : 0
                                                    , fltBaseFee : 0
                                                    , fltFullFee : 0
                                                    , fltRAD : 0
                                                    , fltEAD : 0
                                                    , fltACK : 0
                                                    , fltSEG : 0
                                                    , fltTotalNormal : 0
                                                };
                                        }
                                        $scope.GM.mapFrecc['T7V'].ranges[destino] = $scope.GM.mapFrecc[keyFee].ranges[destino];
                                        $scope.GM.mapFrecc['T7P'].ranges[destino] = $scope.GM.mapFrecc[keyFee].ranges[destino];
                                        $scope.GM.mapRanges[destino] = {
                                            'PAQ': {fltFrecc: 0, intQTotal:0}
                                            , 'ZP' :{fltFrecc: 0, intQTotal:0}
                                            , 'T7' :{fltFrecc: 0, intQTotal:0}
                                            , 'POR' :{fltFrecc: 0, intQTotal:0}
                                            , 'PORZP' :{fltFrecc: 0, intQTotal:0}
                                        }
                                        //$scope.GM.mapQuotes[keyFee][destino] = {};
                                        if(keyFee !== 'T7' && !keyFee.includes('T7_'))
                                            $scope.GM.mapQuotesZP[keyFee][destino] = {};
                                    });
                                }
                            } else {

                                if(quoteItem.Destiny__c){
                                    var keyr = '';
                                    var destino = '';
                                    var destinyok = '';
                                    if(quoteItem.Destiny__c.includes('Más'))
                                        destinyok = quoteItem.Destiny__c.replace('Más de ', '+')
                                    else destinyok = quoteItem.Destiny__c;
                                    if (quoteItem.Rango_KM__c === 'Más de 2400')
                                        keyr = '+2400';
                                    else keyr = quoteItem.Rango_KM__c;
                                    destino = quoteItem.Destiny__c.replace(' (' + quoteItem.Rango_KM__c+')', '');
                                    var keyRange = destino;
                                    if(!getLabel(destino, $scope.GM.listDestiny))
                                        $scope.GM.listDestiny[destino] = {
                                            range: keyr
                                            , name: quoteItem.Destiny__c
                                        };
                                    if(!getLabel(destino, $scope.GM.mapService['Add'].ranges)&& !getLabel(destino, $scope.GM.mapService['ACK'].ranges) && !getLabel(destino, $scope.GM.mapService['ZP'].ranges)){
                                        $scope.GM.mapService['Add'].ranges[destino] = { fltCostWeight : 0, fltCostVol : 0};
                                        $scope.GM.mapService['ACK'].ranges[destino] = { fltCost : 0 };
                                        $scope.GM.mapService['ZP'].ranges[destino] = { fltCost : 0 };
                                    }
                                    $scope.insertRange(destino, quoteItem.Rango_KM__c);
                                    if (quoteItem.PackWeightAVG__c > 60){
                                        $scope.listFee['T7_'+ quoteItem.PackWeightAVG__c] = 'TARIFA T7_'+ quoteItem.PackWeightAVG__c;
                                        if(!getLabel('T7_'+ quoteItem.PackWeightAVG__c, $scope.GM.mapQuotes))
                                            $scope.GM.mapQuotes['T7_' + quoteItem.PackWeightAVG__c] = {};
                                        $scope.GM.listDestiny[destino] = {
                                            range: keyr
                                            , name: quoteItem.Destiny__c
                                        };
                                        if(!getLabel('T7'+ quoteItem.PackWeightAVG__c, $scope.GM.mapBlock))
                                            $scope.GM.mapBlock['T7' + quoteItem.PackWeightAVG__c] = {
                                                strLabel : 'T7'
                                                , fltMaxW : quoteItem.PackWeightAVG__c
                                                , fltVolW : quoteItem.PackVolAVG__c
                                                , fltVolWeight: 0
                                                , blnSameCost : false
                                                , ranges : {}
                                            };
                                        $scope.listBlocksByMaxW.push({key:key, value: quoteItem.PackWeightAVG__c});
                                        if(!getLabel(destino, $scope.GM.mapBlock['T7' + quoteItem.PackWeightAVG__c].ranges[destino]))
                                            $scope.GM.mapBlock['T7' + quoteItem.PackWeightAVG__c].ranges[destino] = {
                                                fltCost : 0
                                            };
                                        if(!getLabel('T7_'+ quoteItem.PackWeightAVG__c, $scope.GM.OWFrecc))
                                            $scope.GM.OWFrecc['T7_'+ quoteItem.PackWeightAVG__c] = {
                                                ranges:{}
                                                , fltFrecc: 0
                                                , intQTotal:0
                                                , strName: quoteItem.PackWeightAVG__c + 'kg'
                                                , blnSameFrecc :false
                                                , blnSameWeight :false
                                                , blnSameVol :false
                                            };
                                        if(!getLabel('T7', $scope.GM.mapFreccPorc))
                                            $scope.GM.mapFreccPorc['T7'] = {ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false};
                                        if(!getLabel(destino, $scope.GM.mapFreccPorc['T7'].ranges))
                                            $scope.GM.mapFreccPorc['T7'].ranges[destino] = {
                                                intFrecuency : 0
                                                , fltBaseFee : 0
                                                , fltFullFee : 0
                                                , fltRAD : 0
                                                , fltEAD : 0
                                                , fltACK : 0
                                                , fltSEG : 0
                                                , fltTotalNormal : 0
                                            };
                                        if(!getLabel('T7', $scope.GM.mapFrecc))
                                            $scope.GM.mapFrecc['T7'] = {ranges:{},fltFrecc: 0, intQTotal:0};
                                        if(!getLabel(destino, $scope.GM.mapFrecc['T7'].ranges))
                                            $scope.GM.mapFrecc['T7'].ranges[destino] = {
                                                intFrecuency : 0
                                                , fltBaseFee : 0
                                                , fltFullFee : 0
                                                , fltRAD : 0
                                                , fltEAD : 0
                                                , fltACK : 0
                                                , fltSEG : 0
                                                , fltTotalNormal : 0
                                            };
                                        if(!getLabel('T7_'+ quoteItem.PackWeightAVG__c, $scope.GM.mapFreccPorc))
                                            $scope.GM.mapFreccPorc['T7_' + quoteItem.PackWeightAVG__c] = {ranges:{}, fltFrecc: 0, intQTotal:0, fltCantidad : 0, blnCalcular : false};
                                        if(!getLabel(destino, $scope.GM.mapFreccPorc['T7_' + quoteItem.PackWeightAVG__c].ranges))
                                            $scope.GM.mapFreccPorc['T7_' + quoteItem.PackWeightAVG__c].ranges[destino] = {
                                                intFrecuency : 0
                                                , fltBaseFee : 0
                                                , fltFullFee : 0
                                                , fltRAD : 0
                                                , fltEAD : 0
                                                , fltACK : 0
                                                , fltSEG : 0
                                                , fltTotalNormal : 0
                                            };
                                        if(!getLabel(destino, $scope.GM.OWFrecc['T7_'+ quoteItem.PackWeightAVG__c].ranges[destino])){
                                            $scope.GM.OWFrecc['T7_'+ quoteItem.PackWeightAVG__c].ranges[destino] = {
                                                intFrecuency : 0
                                                , fltAVGWeight : quoteItem.PackWeightAVG__c
                                                , fltAVGVol : quoteItem.PackVolAVG__c
                                                , fltBaseFee : 0
                                                , fltFullFee : 0
                                                , fltRAD : 0
                                                , fltEAD : 0
                                                , fltACK : 0
                                                , fltSEG : 0
                                                , fltTotalNormal : 0
                                            };
                                            $scope.GM.mapQuotes['T7_'+ quoteItem.PackWeightAVG__c][destino] = {};
                                        }
                                        if(!keyFee.includes('T7_')){
                                            if(!getLabel(keyFee, $scope.GM.mapFrecc))
                                                $scope.GM.mapFrecc[keyFee] = {
                                                    ranges : {}
                                                };
                                            if(!getLabel(destino, $scope.GM.mapFrecc[keyFee].ranges))
                                                $scope.GM.mapFrecc[keyFee].ranges[destino] = {
                                                    intFrecuency : 0
                                                    , fltBaseFee : 0
                                                    , fltBaseFeeP : 0
                                                    , fltFullFee : 0
                                                    , fltFullFeeP : 0
                                                    , fltRAD : 0
                                                    , fltRADP : 0
                                                    , fltEAD : 0
                                                    , fltEADP : 0
                                                    , fltACK : 0
                                                    , fltACKP : 0
                                                    , fltSEG : 0
                                                    , fltTotalNormal : 0
                                                    , fltTotalNormalP : 0
                                                    , fltAVGVol : $scope.GM.mapBlock[key].fltMaxV
                                                    , fltAVGWeight : $scope.GM.mapBlock[key].fltMaxW
                                                };
                                            if(keyFee !== 'T7'){
                                                if(!getLabel(destino, $scope.GM.mapFreccZP[keyFee].ranges))
                                                    $scope.GM.mapFreccZP[keyFee].ranges[destino] = {
                                                        intFrecuency : 0
                                                        , fltBaseFee : 0
                                                        , fltFullFee : 0
                                                        , fltRAD : 0
                                                        , fltEAD : 0
                                                        , fltACK : 0
                                                        , fltSEG : 0
                                                        , fltTotalNormal : 0
                                                    };
                                            }
                                            $scope.GM.mapFrecc['T7V'].ranges[destino] = $scope.GM.mapFrecc[keyFee].ranges[destino];
                                            $scope.GM.mapFrecc['T7P'].ranges[destino] = $scope.GM.mapFrecc[keyFee].ranges[destino];
                                        }
                                        if(!getLabel(destino, $scope.GM.mapFreccPorc[keyFee].ranges))
                                            $scope.GM.mapFreccPorc[keyFee].ranges[destino] = {
                                                intFrecuency : 0
                                                , fltBaseFee : 0
                                                , fltFullFee : 0
                                                , fltRAD : 0
                                                , fltEAD : 0
                                                , fltACK : 0
                                                , fltSEG : 0
                                                , fltTotalNormal : 0
                                            };
                                        if((keyFee != 'T7' && keyFee != 'T7V' && keyFee != 'T7P') && (!getLabel(destino, $scope.GM.mapFreccPorcZP[keyFee].ranges)))
                                            $scope.GM.mapFreccPorcZP[keyFee].ranges[destino] = {
                                                intFrecuency : 0
                                                , fltBaseFee : 0
                                                , fltFullFee : 0
                                                , fltRAD : 0
                                                , fltEAD : 0
                                                , fltACK : 0
                                                , fltSEG : 0
                                                , fltTotalNormal : 0
                                            };
                                        
                                        $scope.GM.mapRanges[destino] = {
                                            'PAQ': {fltFrecc: 0, intQTotal:0}
                                            , 'ZP' :{fltFrecc: 0, intQTotal:0}
                                            , 'T7' :{fltFrecc: 0, intQTotal:0}
                                            , 'POR' :{fltFrecc: 0, intQTotal:0}
                                            , 'PORZP' :{fltFrecc: 0, intQTotal:0}
                                        }
                                        //$scope.GM.mapQuotes[keyFee][destino] = {};
                                        if(keyFee !== 'T7' && !keyFee.includes('T7_'))
                                            $scope.GM.mapQuotesZP[keyFee][destino] = {};
                                    } else {
                                        if(!getLabel(key, $scope.GM.mapBlock))
                                            $scope.GM.mapBlock[key] = {
                                                strLabel : key
                                                , fltMaxW : quoteItem.PackWeightAVG__c
                                                , fltMaxV : quoteItem.PackVolAVG__c
                                                , fltVolW : quoteItem.PackVolAVG__c
                                                , fltVolWeight: 0
                                                , blnSameCost : false
                                                , ranges : {}
                                            };
                                        $scope.listBlocksByMaxW.push({key:key, value: quoteItem.PackWeightAVG__c});
                                        j$.each($scope.GM.listFee, function(keyFee, strFee){
                                            $scope.GM.mapBlock[key].ranges[destino] = {
                                                fltCost : 0
                                            }
                                            if(!getLabel(destino, $scope.GM.mapFrecc[keyFee].ranges))
                                                $scope.GM.mapFrecc[keyFee].ranges[destino] = {
                                                    intFrecuency : 0
                                                    , fltBaseFee : 0
                                                    , fltBaseFeeP : 0
                                                    , fltFullFee : 0
                                                    , fltFullFeeP : 0
                                                    , fltRAD : 0
                                                    , fltRADP : 0
                                                    , fltEAD : 0
                                                    , fltEADP : 0
                                                    , fltACK : 0
                                                    , fltACKP : 0
                                                    , fltSEG : 0
                                                    , fltTotalNormal : 0
                                                    , fltTotalNormalP : 0
                                                    , fltAVGVol : $scope.GM.mapBlock[key].fltMaxV
                                                    , fltAVGWeight : $scope.GM.mapBlock[key].fltMaxW
                                                };
                                            if(keyFee !== 'T7'){
                                                if(!getLabel(destino, $scope.GM.mapFreccZP[keyFee].ranges))
                                                    $scope.GM.mapFreccZP[keyFee].ranges[destino] = {
                                                        intFrecuency : 0
                                                        , fltBaseFee : 0
                                                        , fltFullFee : 0
                                                        , fltRAD : 0
                                                        , fltEAD : 0
                                                        , fltACK : 0
                                                        , fltSEG : 0
                                                        , fltTotalNormal : 0
                                                    };
                                            }
                                            $scope.GM.mapFrecc['T7V'].ranges[destino] = $scope.GM.mapFrecc[keyFee].ranges[destino];
                                            $scope.GM.mapFrecc['T7P'].ranges[destino] = $scope.GM.mapFrecc[keyFee].ranges[destino];
                                            if(!getLabel(destino, $scope.GM.mapFreccPorc[keyFee].ranges))
                                                $scope.GM.mapFreccPorc[keyFee].ranges[destino] = {
                                                    intFrecuency : 0
                                                    , fltBaseFee : 0
                                                    , fltFullFee : 0
                                                    , fltRAD : 0
                                                    , fltEAD : 0
                                                    , fltACK : 0
                                                    , fltSEG : 0
                                                    , fltTotalNormal : 0
                                                };
                                            if((keyFee != 'T7' && keyFee != 'T7V' && keyFee != 'T7P') && (!getLabel(destino, $scope.GM.mapFreccPorcZP[keyFee].ranges)))
                                                $scope.GM.mapFreccPorcZP[keyFee].ranges[destino] = {
                                                    intFrecuency : 0
                                                    , fltBaseFee : 0
                                                    , fltFullFee : 0
                                                    , fltRAD : 0
                                                    , fltEAD : 0
                                                    , fltACK : 0
                                                    , fltSEG : 0
                                                    , fltTotalNormal : 0
                                                };
                                            $scope.GM.mapRanges[destino] = {
                                                'PAQ': {fltFrecc: 0, intQTotal:0}
                                                , 'ZP' :{fltFrecc: 0, intQTotal:0}
                                                , 'T7' :{fltFrecc: 0, intQTotal:0}
                                                , 'POR' :{fltFrecc: 0, intQTotal:0}
                                                , 'PORZP' :{fltFrecc: 0, intQTotal:0}
                                            }
                                            //$scope.GM.mapQuotes[keyFee][destino] = {};
                                            if(keyFee !== 'T7' && !keyFee.includes('T7_'))
                                                $scope.GM.mapQuotesZP[keyFee][destino] = {};
                                        });
                                    }
                                }

                                var keyRange = getId(quoteItem.Rango_KM__c, $scope.GM.listRange);
                                if(!getLabel(key, $scope.GM.mapBlock)){
                                    $scope.addBlock(quoteItem.PackWeightAVG__c);
                                    j$.each($scope.listBlocksByMaxW, function (k, val) {
                                        if(val.value === $scope.GM.mapBlock[key].fltMaxW)
                                            val.vol = quoteItem.PackVolAVG__c;
                                    });
                                }
                            }
                            if(getLabel(key, $scope.GM.mapBlock) && quoteItem.PackVolAVG__c && quoteItem.GUIA__c ){
                                $scope.GM.mapBlock[key].fltVolW = quoteItem.PackVolAVG__c;
                                $scope.GM.mapBlock[key].fltMaxV = quoteItem.PackVolAVG__c;
                                $scope.GM.mapBlock[key].fltVolWeight = quoteItem.PackVolAVG__c * 200;
                                if (notEmpty(quoteItem.Destiny__c))
                                    $scope.GM.mapBlock[key].ranges[destino].fltCost = quoteItem.GUIA__c;
                                else $scope.GM.mapBlock[key].ranges[keyRange].fltCost = quoteItem.GUIA__c;
                            }
                            if(getLabel('T7'+ quoteItem.PackWeightAVG__c, $scope.GM.mapBlock) && quoteItem.PackVolAVG__c && quoteItem.GUIA__c ){
                                $scope.GM.mapBlock['T7'+ quoteItem.PackWeightAVG__c].fltVolW = quoteItem.PackVolAVG__c;
                                $scope.GM.mapBlock['T7'+ quoteItem.PackWeightAVG__c].fltVolWeight = quoteItem.PackVolAVG__c * 200;
                                if (notEmpty(quoteItem.Destiny__c))
                                    $scope.GM.mapBlock['T7'+ quoteItem.PackWeightAVG__c].ranges[destino].fltCost = quoteItem.GUIA__c;
                                else $scope.GM.mapBlock['T7'+ quoteItem.PackWeightAVG__c].ranges[keyRange].fltCost = quoteItem.GUIA__c;
                            }
                            if (notEmpty(quoteItem.Destiny__c)){
                                $scope.GM.mapService['Add'].ranges[destino].fltCostWeight = quoteItem.KG_ADICIONAL__c;
                                $scope.GM.mapService['Add'].ranges[destino].fltCostVol = quoteItem.KG_ADICIONAL__c * 200;
                            } else {
                                $scope.GM.mapService['Add'].ranges[keyRange].fltCostWeight = quoteItem.KG_ADICIONAL__c;
                                $scope.GM.mapService['Add'].ranges[keyRange].fltCostVol = quoteItem.KG_ADICIONAL__c * 200;
                            }
                            
                            if (quoteItem.ZonaPlus__c) {
                                if (notEmpty(quoteItem.Destiny__c)){
                                    $scope.GM.mapService['ZP'].ranges[destino].fltCost = quoteItem.EAD__c;
                                    $scope.GM.mapFreccZP[keyFee].ranges[destino].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                    $scope.GM.mapFreccZP[keyFee].ranges[destino].Id = quoteItem.Id;
                                    $scope.GM.mapFreccZP[keyFee].ranges[destino].SBQQ__Quote__c = quoteItem.SBQQ__Quote__c;
                                    $scope.GM.mapFreccPorcZP[keyFee].ranges[destino].intFrecuency = quoteItem.PaqPorGuia__c;
                                } else {
                                    $scope.GM.mapService['ZP'].ranges[keyRange].fltCost = quoteItem.EAD__c;
                                    $scope.GM.mapFreccZP[keyFee].ranges[keyRange].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                    $scope.GM.mapFreccZP[keyFee].ranges[keyRange].Id = quoteItem.Id;
                                    $scope.GM.mapFreccZP[keyFee].ranges[keyRange].SBQQ__Quote__c = quoteItem.SBQQ__Quote__c;
                                    $scope.GM.mapFreccPorcZP[keyFee].ranges[keyRange].intFrecuency = quoteItem.PaqPorGuia__c;
                                }
                                $scope.GM.mapFreccPorcZP[keyFee].fltCantidad = quoteItem.PaqPromPorGuia__c;
                            } else {
                                if (keyFee.includes('T7_')) {
                                    if (notEmpty(quoteItem.Destiny__c)){
                                        $scope.GM.OWFrecc['T7_' + quoteItem.PackWeightAVG__c].ranges[destino].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                        $scope.GM.OWFrecc['T7_' + quoteItem.PackWeightAVG__c].ranges[destino].Id = quoteItem.Id;
                                        $scope.GM.OWFrecc['T7_' + quoteItem.PackWeightAVG__c].ranges[destino].SBQQ__Quote__c = quoteItem.SBQQ__Quote__c;
                                        $scope.GM.mapFreccPorc['T7_' + quoteItem.PackWeightAVG__c].ranges[destino].intFrecuency = quoteItem.PaqPorGuia__c;
                                        //$scope.fillRangesByDestiny();
                                    } else {
                                        $scope.GM.OWFrecc['T7_' + quoteItem.PackWeightAVG__c].ranges[keyRange].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                        $scope.GM.OWFrecc['T7_' + quoteItem.PackWeightAVG__c].ranges[keyRange].Id = quoteItem.Id;
                                        $scope.GM.OWFrecc['T7_' + quoteItem.PackWeightAVG__c].ranges[keyRange].SBQQ__Quote__c = quoteItem.SBQQ__Quote__c;
                                        $scope.GM.OWFrecc['T7_' + quoteItem.PackWeightAVG__c].ranges[keyRange].fltAVGVol = quoteItem.PackVolAVG__c;
                                        $scope.GM.mapFreccPorc['T7_' + quoteItem.PackWeightAVG__c].ranges[keyRange].intFrecuency = quoteItem.PaqPorGuia__c;
                                    }
                                } else {
                                    if(quoteItem.Destiny__c){
                                        $scope.GM.mapFrecc[keyFee].ranges[destino].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                        $scope.GM.mapFrecc[keyFee].ranges[destino].Id = quoteItem.Id;
                                        $scope.GM.mapFrecc[keyFee].ranges[destino].SBQQ__Quote__c = quoteItem.SBQQ__Quote__c;
                                        $scope.GM.mapFreccPorc[keyFee].ranges[destino].intFrecuency = quoteItem.PaqPorGuia__c;
                                        if(keyFee === 'T7'){
                                            $scope.GM.mapFrecc['T7'].ranges[destino].fltAVGWeight = quoteItem.Weight__c;
                                            $scope.GM.mapFrecc['T7'].ranges[destino].fltAVGVol = quoteItem.Width__c;
                                        }
                                    }else {
                                        $scope.GM.mapFrecc[keyFee].ranges[keyRange].intFrecuency = quoteItem.SBQQ__Quantity__c;
                                        $scope.GM.mapFrecc[keyFee].ranges[keyRange].Id = quoteItem.Id;
                                        $scope.GM.mapFrecc[keyFee].ranges[keyRange].SBQQ__Quote__c = quoteItem.SBQQ__Quote__c;
                                        $scope.GM.mapFreccPorc[keyFee].ranges[keyRange].intFrecuency = quoteItem.PaqPorGuia__c;
                                        if(keyFee === 'T7'){
                                            $scope.GM.mapFrecc['T7'].ranges[keyRange].fltAVGWeight = quoteItem.Weight__c;
                                            $scope.GM.mapFrecc['T7'].ranges[keyRange].fltAVGVol = quoteItem.Width__c;
                                        }
                                        $scope.GM.mapFreccPorc[keyFee].fltCantidad = quoteItem.PaqPromPorGuia__c;
                                    }
                                }
                            }
                            if(notEmpty($scope.GM.strACK)){
                                if(quoteItem.Destiny__c)
                                    $scope.GM.mapService['ACK'].ranges[destino].fltCost = quoteItem.ACK__c;
                                else $scope.GM.mapService['ACK'].ranges[keyRange].fltCost = quoteItem.ACK__c;
                            }
                                
                        }
                    });
                    if($scope.GM.blnCotizaT7ZP)
                        $scope.redireccionar();
                    $scope.calculateXY();
                    $scope.updateFees('add', 'service');
                    $scope.calculateGM();
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
                //$scope.sent = true;
                Visualforce.remoting.Manager.invokeAction(
                        '{!$RemoteAction.PAQ_CotizadorNacional_CTR.getHierarchyUser}'
                        , function (result, event) {
                            //  debugger;
                            if (event.status) {
                                $scope.Wrapper.mapHierarchy = result.mapHierarchy;
                                j$.each(result.mapHierarchy,
                                        function(key, userId){
                                            if(key.toUpperCase().includes('GERENTE SUCURSAL'))
                                                $scope.Managers['GSU'] = userId;
                                            else if(key.toUpperCase().includes('KAM'))
                                                $scope.Managers['KAM'] = userId;
                                            else if(key.toUpperCase().includes('GERENCIA DESARROLLO'))
                                                $scope.Managers['GDS'] = userId;
                                            else if(key.toUpperCase().includes('DIRECTOR COMERCIAL'))
                                                $scope.Managers['DCO'] = userId;
                                        }
                                );
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
                $scope.sent = true;
                $scope.Wrapper.objQuote = {};//Se inicializa el objeto antes de llamar a la función de grabado.
                Visualforce.remoting.Manager.invokeAction(
                        '{!$RemoteAction.PAQ_CotizadorNacional_CTR.saveQuoteConv}'
                        , objQuote
                        , listQuoteItem
                        , leadObj
                        , oppObj
                        , listSS
                        , function (result, event) {
                            //debugger;
                            if (event.status) {
                                $scope.DML.blnSuccess = true;
                                $scope.DML.listErrors = [];
                                    if($scope.DML.blnSuccess
                                            && (!$scope.Wrapper.objQuote || !$scope.Wrapper.objQuote.Id)
                                            && result.objQuote && result.objQuote.Name
                                    ){
                                        $scope.Wrapper.objQuote.Id  =  result.objQuote.Id;
                                        $scope.Wrapper.objQuote.Name =  result.objQuote.Name;
                                        $scope.DML.objQuote = result.objQuote;
                                    }
                                    if(!$scope.DML.blnSuccess){
                                        $scope.DML.blnSuccess = false;
                                        j$.each(result.listErrors, function (i, error) {
                                            if($scope.DML.listErrors.indexOf(error) === -1)
                                                $scope.DML.listErrors.push(error);
                                        });
                                    }
                                if($scope.DML.blnSuccess)
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
                            //debugger;
                            if (event.status) {
                                $scope.DML.blnSuccess = true;
                                $scope.DML.listErrors = [];
                                if($scope.DML.blnSuccess
                                        && (!$scope.Wrapper.objQuote || !$scope.Wrapper.objQuote.Id)
                                        && result.objQuote && result.objQuote.Name
                                ){
                                    $scope.Wrapper.objQuote.Id  =  result.objQuote.Id;
                                    $scope.Wrapper.objQuote.Name =  result.objQuote.Name;
                                    $scope.DML.objQuote = result.objQuote;
                                }
                                if(!$scope.DML.blnSuccess){
                                    $scope.DML.blnSuccess = false;
                                    j$.each(result.listErrors, function (i, error) {
                                        if($scope.DML.listErrors.indexOf(error) === -1)
                                            $scope.DML.listErrors.push(error);
                                    });
                                }
                                if($scope.DML.blnSuccess)
                                    $scope.SuccessMessage = 'Se han guardado los cambios con exito.';
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

            function callSent($scope, strIdQuote, strNameAP) {
                j$.blockUI({ message: '<h3><span class="glyphicon glyphicon-time"></span> Por favor espere... </h3>' });
                $scope.SuccessMessage = '';
                $scope.sent = true;
                Visualforce.remoting.Manager.invokeAction(
                        '{!$RemoteAction.PAQ_CotizadorNacional_CTR.sumbitAPP}'
                        , strIdQuote
                        , strNameAP
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
                        , $scope.GM.strOrigin
                        , $scope.GM.strDestiny
                        , function (result, event) {
                            //debugger;
                            if (event.status) {
                                $scope.DML = result;
                                if(result.blnSuccess){
                                    var strDestiny = $scope.GM.strDestiny;
                                    $scope.DestinySuccessMessage = 'Se ha agregado el destino!';
                                    $scope.GM.listDestiny[strDestiny] = {
                                        range: result.strDestinyKM
                                        , name: strDestiny +' ('+ result.strDestinyKM +')'
                                    } ;
                                    $scope.insertRange(strDestiny, result.strDestinyKM);
                                    $scope.GM.mapService['Add'].ranges[strDestiny] = { fltCostWeight : 0, fltCostVol : 0};
                                    $scope.GM.mapService['ACK'].ranges[strDestiny] = { fltCost : 0 };
                                    $scope.GM.mapService['ZP'].ranges[strDestiny] = { fltCost : 0 };
                                    j$.each($scope.listFee, function (keyFee, strFee) {
                                        if(!keyFee.includes('T7_')){
                                            $scope.GM.mapFrecc[keyFee].ranges[strDestiny] = {
                                                intFrecuency : 0
                                                , fltBaseFee : 0
                                                , fltFullFee : 0
                                                , fltRAD : 0
                                                , fltEAD : 0
                                                , fltACK : 0
                                                , fltSEG : 0
                                                , fltTotalNormal : 0
                                            };
                                            if(keyFee != 'T7' && keyFee != 'T7V' && keyFee != 'T7P')
                                                $scope.GM.mapFreccZP[keyFee].ranges[strDestiny] = {
                                                    intFrecuency : 0
                                                    , fltBaseFee : 0
                                                    , fltFullFee : 0
                                                    , fltRAD : 0
                                                    , fltEAD : 0
                                                    , fltACK : 0
                                                    , fltSEG : 0
                                                    , fltTotalNormal : 0
                                                };
                                            else {
                                                $scope.GM.mapFrecc[keyFee].ranges[strDestiny].fltAVGWeight = 0;
                                                $scope.GM.mapFrecc[keyFee].ranges[strDestiny].fltAVGVol = 0;
                                                $scope.GM.mapFrecc[keyFee].ranges[strDestiny].blnSameWeight = false;
                                                $scope.GM.mapFrecc[keyFee].ranges[strDestiny].fltSameVol = false;
                                                $scope.GM.mapFrecc['T7V'].ranges[strDestiny] = $scope.GM.mapFrecc[keyFee].ranges[strDestiny];
                                                $scope.GM.mapFrecc['T7P'].ranges[strDestiny] = $scope.GM.mapFrecc[keyFee].ranges[strDestiny];
                                            }
                                            j$.each($scope.GM.mapLimits, function (keyFee, limits) {
                                                j$.each($scope.GM.mapBlock, function (range, item) {
                                                    if(item.fltMaxW === 1){
                                                        if(!getLabel('TS1', $scope.GM.mapBlock)){
                                                            $scope.GM.mapBlock['TS1'] = {
                                                                strLabel : 'TS'
                                                                , fltMaxW : item.fltMaxW
                                                                , fltVolW : 0
                                                                , fltVolWeight: 0
                                                                , blnSameCost : false
                                                                , ranges : {}
                                                            };
                                                        }
                                                        $scope.listBlocksByMaxW.push({key:'TS1', value: item.fltMaxW});
                                                        j$.each($scope.GM.listRange, function (keyRange, strRange) {  
                                                            if(!getLabel(keyRange, $scope.GM.mapBlock['TS1'].ranges)){
                                                                $scope.GM.mapBlock['TS1'].ranges[keyRange] = {
                                                                    fltCost : 0
                                                                };
                                                            }
                                                        });
                                                    }else {
                                                        var key = keyFee;
                                                        var strKey = item.fltMaxW.toString();
                                                        key += strKey.replace('.', '_');
                                                        if(item.fltMaxW > limits.min && item.fltMaxW <= limits.max || item.fltMaxW === limits.min){
                                                            debugger;
                                                            if(!getLabel(key, $scope.GM.mapBlock)){
                                                                $scope.GM.mapBlock[key] = {
                                                                    strLabel : keyFee
                                                                    , fltMaxW : item.fltMaxW
                                                                    , fltVolW : 0
                                                                    , fltVolWeight: 0
                                                                    , blnSameCost : false
                                                                    , ranges : {}
                                                                };
                                                            }
                                                                $scope.listBlocksByMaxW.push({key:key, value: item.fltMaxW});
                                                                j$.each($scope.GM.listRange, function (keyRange, strRange) {  
                                                                    if(!getLabel(keyRange, $scope.GM.mapBlock[key].ranges)){
                                                                        $scope.GM.mapBlock[key].ranges[keyRange] = {
                                                                            fltCost : 0
                                                                        };
                                                                    }
                                                                });
                                                            
                                                            
                                                        }
                                                    }
                                                    
                                                });
                                            });
                                        } else {
                                            var key = '';
                                            key = keyFee.replace('_', '');
                                            $scope.GM.mapBlock[key].ranges[strDestiny] = {
                                                fltCost : 0
                                            }
                                            $scope.GM.OWFrecc[keyFee].ranges[strDestiny] = {
                                                intFrecuency : 0
                                                , fltBaseFee : 0
                                                , fltBaseFeeP : 0
                                                , fltFullFee : 0
                                                , fltFullFeeP : 0
                                                , fltRAD : 0
                                                , fltRADP : 0
                                                , fltEAD : 0
                                                , fltEADP : 0
                                                , fltACK : 0
                                                , fltACKP : 0
                                                , fltSEG : 0
                                                , fltTotalNormal : 0
                                                , fltTotalNormalP : 0
                                                , fltAVGVol : $scope.GM.mapBlock[key].fltMaxV
                                                , fltAVGWeight : $scope.GM.mapBlock[key].fltMaxW
                                            };
                                        }
                                        $scope.GM.mapFreccPorc[keyFee].ranges[strDestiny] = {
                                            intFrecuency : 0
                                            , fltBaseFee : 0
                                            , fltFullFee : 0
                                            , fltRAD : 0
                                            , fltEAD : 0
                                            , fltACK : 0
                                            , fltSEG : 0
                                            , fltTotalNormal : 0
                                        };
                                        if(keyFee != 'T7' && keyFee != 'T7V' && keyFee != 'T7P')
                                            $scope.GM.mapFreccPorcZP[keyFee].ranges[strDestiny] = {
                                                intFrecuency : 0
                                                , fltBaseFee : 0
                                                , fltFullFee : 0
                                                , fltRAD : 0
                                                , fltEAD : 0
                                                , fltACK : 0
                                                , fltSEG : 0
                                                , fltTotalNormal : 0
                                            };
                                        $scope.GM.mapRanges[strDestiny] = {
                                            'PAQ': {fltFrecc: 0, intQTotal:0}
                                            , 'ZP' :{fltFrecc: 0, intQTotal:0}
                                            , 'T7' :{fltFrecc: 0, intQTotal:0}
                                            , 'POR' :{fltFrecc: 0, intQTotal:0}
                                            , 'PORZP' :{fltFrecc: 0, intQTotal:0}
                                        }
                                        $scope.GM.mapQuotes[keyFee][strDestiny] = {};
                                        if(keyFee !== 'T7' && !keyFee.includes('T7_'))
                                            $scope.GM.mapQuotesZP[keyFee][strDestiny] = {};
                                    });
                                    $scope.GM.strOrigen = $scope.GM.strOrigin;
                                    $scope.GM.mapTender[strDestiny] = {
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
                                    $scope.GM.mapQuotesT7ZP.Tender[strDestiny] = {
                                        fltSeg : 0
                                        , strOrigen : $scope.GM.strOrigin
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
                                    $scope.GM.mapPropuesta['PROP'].ranges[strDestiny] = {
                                        fltCost : 0
                                        , fltTotalPropuesta : 0
                                        , fltTotalTarifaLlena : 0
                                        , fltDescuento : 0
                                        , fltQuoteFee : 0
                                        , strRango : result.strDestinyKM
                                        , fltACK : 0
                                        , fltTarima : 0
                                    }
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

            function getNum(strNum) {
                if(notEmpty(strNum))
                    if(strNum.length > 3 && strNum.indexOf(',') !== -1)
                        strNum = strNum.replace(',', '');
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

            function getNumFromPercent(str) {
                var strNum = '';
                var index = str.indexOf("%");
                strNum = str.slice(0, index);
                if (getNum(strNum) > 0)
                    return  getNum(strNum) / 100;
                else
                    return 0;
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
                            $scope.GM.mapTender[Name.replace('70', '')] = {
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
                        j$.each($scope.GM.listDestiny, function(keyDest, strDest){
                            if(Name.replace('70', '') === keyDest)
                                $scope.GM.mapTender[Name.replace('70', '')].blnDestino = true;
                        })
                        
                    });
                    if(blnNuevoTender)
                        j$.each($scope.GM.mapTender, function(keyName, strName){
                            $scope.GM.mapQuotesT7ZP.Tender[keyName] = {
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
                        j$.each($scope.GM.mapTender, function(strTender, map){
                            if(Name === strTender + '70'){
                                $scope.GM.mapTender[strTender].strName      = Name.replace('70', '');
                                $scope.GM.mapTender[strTender].keyName      = Name;
                                $scope.GM.mapTender[strTender].fltLarge     = Tender.Largo__c;
                                $scope.GM.mapTender[strTender].fltWidth     = Tender.Peso__c;
                                $scope.GM.mapTender[strTender].fltHigh      = Tender.Alto__c;
                                $scope.GM.mapTender[strTender].fltWeight    = Tender.Peso__c;
                                $scope.GM.mapTender[strTender].fltVol       = Tender.Alto__c * Tender.Peso__c * Tender.Largo__c;
                                $scope.GM.mapTender[strTender].fltCost      = Tender.Costo__c;
                                $scope.GM.mapTender[strTender].fltExc       = Tender.Costo__c;
                                $scope.GM.mapTender[strTender].id           = ''
                                $scope.GM.mapTender[strTender].blnDestino   = true;
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
                                    $scope.GM.mapQuotesT7ZP.Tender[strTenderDestino].strRange = result.strDestinyKM;
                                    //return result.strDestinyKM;
                                } else $scope.GM.mapQuotesT7ZP.Tender[strTenderDestino].strRange = '0';
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
        })();
    </script>
</apex:component>
