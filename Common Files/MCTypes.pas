{ This unit contains constants and types used by the programs of the Act Paid
  module.
  May, 2001 : First version.
           The Act Paid module have four programs : SAQ301 to SAQ304
  October, 2001 : Second version.
           The Act Paid module have five programs : SAQ301 to SAQ305 }
unit MCTypes;

interface
uses dbctrls;
{ Enumerated types }

Type
    TKindLine = (klNormal,klElement,klSubHeader,klHeader);
    TKindReport = (kr02,kr04);
    TComparation = (cUndefined,cLess,cLessEqual,cGreat,cGreatEqual);
    TSearchingCode = (scByAct,scByContractAct,scByContract,scByContractStatus,
                      scBySupplierAct,scBySupplier,scBySupplierStatus,
                      scBySupplierActStatus,scByStatus,scAll);
    TSQLLinesForSearch = (slsSelection,slsCondition);
    TDocument = (tdNone,tdWorkOrder,tdProject,tdThirdPartyInv);
    TUserRights = (urNone,urReview,urFullAccess);
    TCCListKind = (cclkPositive,cclkNegative);
    TDetailOrder = (doCategoryNo,doCategoryDescription);
    { asNone is a ficticious status for search by all }
    TActStatus = (asNone,asPendent,asSent,asNull,
                  asApproved,asCounted,asInvoiced,asClosed);
    { Types for SAQ304 Search form }
    TInvoiceStatus = (ssAll,ssPendent,ssGenerated);
    TInvKindDate = (skdNone,skdAuthorized,skdInvoice,skdReceived);
    { Types for user preferences }
    TCCTypeDstrb    = (cctdPercent,cctdValue);
    TCCDefaultDstrb = (ccddContract,ccddCurrent);
    TTypeComments   = (tcNone,tcNoPrinted,tcFull);
    TTypeCntrctExt  = (tceNone,tcePrintExt);
    TLoadInvType    = (litCategory,litElement,litEditCategory,litEditElement);
    TActValidation  = (avNone,avElement,avPortion,avContract);
    TInvValidation  = (ivNone,ivTyping);
    TTypeCntLimit   = (tclNone,tclPortion,tclContract);
    TAPInfoAtax     = (apiaNot,apiaYes);
    TAPRight        = (aprPortion,aprContract);
    TAPSecuence     = (apsContract,apsPortion);
{ User preferences definitions }
Type TArrPrf01 = Array[TCCTypeDstrb]    Of String;
     TArrPrf02 = Array[TCCDefaultDstrb] Of String;
     TArrPrf03 = Array[TTypeComments]   Of String;
     TArrPrf04 = Array[TTypeCntrctExt]  Of String;
     TArrPrf05 = Array[TLoadInvType]    Of String;
     TArrPrf06 = Array[TActValidation]  Of String;
     TArrPrf07 = Array[TInvValidation]  Of String;
     TArrPrf08 = Array[TTypeCntLimit]   Of String;
     TArrPrf09 = Array[TAPInfoAtax]     Of String;
     TArrPrf10 = Array[TAPRight]        Of String;
     TArrPrf11 = Array[TAPSecuence]     Of String;
Const
     Prf01Names:TArrPrf01 = ('Por Porcentaje','Por Valor');
     Prf02Names:TArrPrf02 = ('Desde el Contrato','Almacenada globalmente');
     Prf03Names:TArrPrf03 = ('No permitidos','Sin imprimir','Uso total');
     Prf04Names:TArrPrf04 = ('No','Sí');
     Prf05Names:TArrPrf05 = ('Por Categoría (Sin Edición)',
                             'Por Elemento (Sin Edición)',
                             'Por Categoría (Editable)',
                             'Por Elemento (Editable)');
     Prf06Names:TArrPrf06 = ('Ninguna','Por Elemento','Por Porción','Por Contrato');
     Prf07Names:TArrPrf07 = ('Ninguna','Por Digitación');
     Prf08Names:TArrPrf08 = ('Ninguna','Por Porción','Por Contrato');
     Prf09Names:TArrPrf09 = ('No exigible','Obligatoria');
     Prf10Names:TArrPrf10 = ('Por Porción','Por Contrato');
     Prf11Names:TArrPrf11 = ('Unica por Contrato','Unica por Porción');

{ Section names for Act Paid Summary report }
Type
    TArrSctNms = Array[0..2] Of String;
Const
     SectionsValueNames:TArrSctNms=('Total Costos Directos',
                                    'Total Costos Indirectos/Otros',
                                    'Total Descuentos');
     SectionsTitles:TArrSctNms=('','INDIRECTOS/OTROS','DESCUENTOS');
{ Error Messages }

Const
     ME_001 = 'AE001: No pudo recuperar las categorías.Error técnico : %s';
     ME_002 = 'AE002: Falló la operación SQL.Error técnico : %s';
     ME_003 = 'AE003: Contratista no existe';
     ME_004 = 'AE004: No pudo hallar datos del contratista %s.Error técnico : %s';
     ME_005 = 'AE005: El Estado es inválido';
     ME_006 = 'AE006: No pudo cargar la lista de Contratista.Error técnico : %s';
     ME_007 = 'AE007: La lista de contratistas esta vacía.';
     ME_008 = 'AE008: Inhabilitado para escoger un Contratista.Error técnico : %s';
     ME_009 = 'AE009: No pudo determinar si existe la porción %s en el '+
              'contrato %s, o esta es inválida.Error técnico : %s';
     ME_010 = 'AE010: Contrato no existe';
     ME_011 = 'AE011: No pudo recuperar los datos del contrato %s.Error '+
              'técnico : %s';
     ME_012 = 'AE012: No pudo %s los datos de la pareja elemento %s - '+
              'categoría %s.Error técnico : %s';
     ME_013 = 'AE013: No está autorizado a administrar el contrato %s';
     ME_014 = 'AE014: Los códigos de las actas no son numéricos. El sistema '+
              'no puede generar automáticamente un nuevo código. Debe digitarlo';
     ME_015 = 'AE015: Error Crítico. No pudo cargar la lista general de '+
              'elementos. La aplicación se cerrará.Error técnico : %s';
     ME_016 = 'AE016: No pudo cargar la lista de elementos definidos para la '+
              'porción %s del contrato %s.Error técnico : %s';
     ME_017 = 'AE017: No encuentra la definición del elemento con código %s, '+
              'elemento %s dentro de la pareja Contrato-Porción';
     ME_018 = 'AE018: No se encontraron elementos en el contrato';
     ME_019 = 'AE019: No pudo desplegar totalmente el Acta.No se permitirán '+
              'modificaciones.Error técnico : %s';
     ME_020 = 'AE020: Error buscando Actas.Error técnico : %s';
     ME_021 = 'AE021: No pudo actualizar el estado del acta %s del contrato '+
              '%s.Error técnico : %s';
     ME_022 = 'AE022: No pudo calcular el total ejecutado del contrato %s. '+
              'Se asume como $0.00.Error técnico : %s';
     ME_023 = 'AE023: No pudo efectuar la consulta para el Reporte %s. '+
              'Error técnico : %s';
     ME_024 = 'AE024: No pudo obtener los datos asociados con el usuario %s. '+
              'La aplicación se cerrará.Error técnico : %s';
     ME_025 = 'AE025: No pudo crear el Acta para el contrato %s porción %s. '+
              'Error técnico : %s';
     ME_026 = 'AE026: No se ha definido un logotipo para los reportes';
     ME_027 = 'AE027: No pudo cargar el logotipo de reporte.Error técnico : %s';
     ME_028 = 'AE028: No pudo conectarse a la base de datos. La aplicación '+
              'se cerrará. Número del último paso exitoso : %d. Error '+
              'técnico : %s';
     ME_029 = 'AE029: Esta aplicación solo puede ejecutarse desde MIMS Explorer';
     ME_030 = 'AE030: No existe en MSF810 la identificación dada';
     ME_031 = 'AE031: No pudo determinar el nombre del empleado con '+
              'identificación %s. Lo asume en blanco. Error técnico : %s';
     ME_032 = 'AE032: Usuario no existe en MSF020';
     ME_033 = 'AE033: No pudo recuperar la información de administración y '+
              'aprobación del Acta %s en el contrato %s. Error técnico : %s';
     ME_034 = 'AE034: Porción no existe';
     ME_035 = 'AE035: Inesperado error interno. No coinciden los categorías '+
              'desplegadas con las existentes en la lista interna. Informe '+
              'a soporte técnico.';
     ME_036 = 'AE036: No pudo grabar los datos. Puede haber un centro de ' +
              'costo duplicado. Error técnico : %s ';
     ME_037 = 'AE037: Nuevo valor de los pagos a la porción (%m) excede el '+
              'tope %s permitido (%m)';
     ME_038 = 'AE038: No pudo determinar el nuevo valor de los pagos hechos '+
              'a la porcion %s del contrato %s. Error técnico : %s';
     ME_039 = 'AE039: No pudo determinar el valor actual del acta %s en el '+
              'contrato %s. Error técnico : %s';
     ME_040 = 'AE040: Inesperado error interno. El contrato no contiene a la '+
              'categoría Nro %s dentro del elemento Nro %s; a pesar de que sí '+
              'existe en el Acta. Informe a soporte técnico.';
     ME_041 = 'AE041: La categoría %s debe ser pagada globalmente.';
     ME_042 = 'AE042: La categoría %s debe ser pagada como Cantidad por '+
              'precio unitario.';
     ME_043 = 'AE043: No pudo determinar el valor de los pagos hechos a : '+
              'Contrato %s, Porción %s, Elemento %s, Categoría %s. Error '+
              'técnico : %s';
     ME_044 = 'AE044: %s no es un valor numérico';
     ME_045 = 'AE045: %s no está en el rango permitido. Debe ser un valor '+
              'entre 0.00 y 100.00';
     ME_046 = 'AE046: Se debe asignar exactamente el 100 por ciento. Los '+
              'porcentajes asignados suman %d.%2.2d';
     ME_047 = 'AE047: %s no corresponde a un Centro de Costos, o Cuenta válida.'+
              'Verifique que exista en MSF966, que esté activa y sea costeable';
     ME_048 = 'AE048: No pudo validar el Centro de Costos (o Cuenta) %s en el '+
              'distrito %s. Error técnico : %s';
     ME_049 = 'AE049: Inesperado error interno. Los datos fueron grabados; '+
              'pero posteriormente se produjo el error %s. La ventana se '+
              'cerrará.';
     ME_050 = 'AE050: No pudo determinar si al usuario %s se le han enviado '+
              'Actas para su aprobación.Error técnico : %s';
     ME_051 = 'AE051: %s no es nombre de estado válido.';
     ME_052 = 'AE052: No pudo llenar la tabla temporal de las Actas pendientes '+
              'de aprobación. Error técnico : %s';
     ME_053 = 'AE053: El registro actual está siendo editado. Grabelo o cancele '+
              'antes de proceder.';
     ME_054 = 'AE054: No pudo salvar los cambios a la Base de Datos.Error '+
              'técnico : %s';
     ME_055 = 'AE055: No pudo desplegar correctamente la lista de actas '+
              'pendientes de aprobación.Error técnico : %s';
     ME_056 = 'AE056: No pudo grabar los datos de facturación del acta %s del '+
              'contrato %s.Error técnico : %s';
     ME_057 = 'AE057: Inesperado error interno. Campo STATUS tiene un valor '+
              'inválido. Informe a soporte técnico';
     ME_058 = 'AE058: No pudo recuperar las categorías del Acta %s del '+
              'Contrato %s.Error técnico : %s';
     ME_059 = 'AE059: No pudo recuperar los centros de costos de los elementos'+
              ' del Acta %s del Contrato %s.Error técnico : %s';
     ME_060 = 'AE060: Posible error de integridad en la Base de datos. El '+
              'Elemento %s no tiene centros de costos asociados.';
     ME_061 = 'AE061: El archivo no pudo ser generado. Se produjo el error %s '+
              'cuando se procesaba el Acta %s del Contrato %s';
     ME_062 = 'AE062: Fecha Inicial mayor que Fecha Final';
     ME_063 = 'AE063: No pudo encontrar Actas.Error técnico : %s';
     ME_064 = 'AE064: No ha seleccionado el nombre del archivo a crear';
     ME_065 = 'AE065: No se han seleccionado Actas a generarse';
     ME_066 = 'AE066: No pudo actualizar el estado de la factura correspondiente'+
              ' al acta %s del contrato %s.Error técnico : %s';
     ME_067 = 'AE067: MIMS no está instalado';
     ME_068 = 'AE068: No puede determinar que versión de MIMS está instalada.';
     ME_069 = 'AE069: La llave de las aplicaciones MIMS no se encuentra en el '+
              'registro de Windows. Llave faltante : HKEY_LOCAL_MACHINE%s';
     ME_070 = 'AE070: Falla al cargar información de los archivos de ayuda. '+
              'Algunos archivos de ayuda podrían no estar disponibles. Error '+
              'técnico : %s.';
     ME_071 = 'AE071: No pudo calcular el nuevo valor del Acta. Cálculos '+
              'posteriores podrían estar errados. Se sugiere salir del Acta '+
              'volver a editarla. Error técnico :%s';
     ME_072 = 'AE072: No encuentra al elemento %s categoría %s en la lista '+
              'interna de categorías.';
     ME_073 = 'AE073: El contrato %s no está aprobado';
     ME_074 = 'AE074: El acta a procesar (Acta %s del contrato %s) no tiene '+
              'valores asignados (valor actual del acta está en 0.00)';
     ME_075 = 'AE075: Se presentó el error %s. Es probable que la operación '+
              'no se realizó. Refresque la pantalla de busqueda';
     ME_076 = 'AE076: No encuentra la identificación del contratista con '+
              'código %s en el distrito %s. Lo asume vacío.Error técnico :%s';
     ME_077 = 'AE077: Las monedas no tienen una tasa de cambio definida en la '+
              'tabla MSF912';
     ME_078 = 'AE078: No pudo determinar la tasa de cambio para las monedas ' +
              '%s (de la factura) y %s (del contrato). Error técnico :%s';
     ME_079 = 'AE079: La tasa de cambio debe ser 1 porque las monedas de la ' +
              'factura y del contrato son iguales';
     ME_080 = 'AE080: La fecha de la factura es inválida.';
     ME_081 = 'AE081: No pudo determinar los contratos asignados al usuario. '+
              'Error técnico :%s';
     ME_082 = 'AE082: No ha seleccionado ningún contrato.';
     ME_083 = 'AE083: El Nombre de la empresa no está definido (campo COY_NAME '+
              'en la tabla MSF000_SC0001, definible en MSM001B)';
     ME_084 = 'AE084: No pudo determinar el nombre de la empresa. Lo asume en '+
              'blanco. Error técnico :%s';
     ME_085 = 'AE085: Fecha de la factura mayor que la fecha de recepción';
     ME_086 = 'AE086: Moneda de la factura es inválida.';
     ME_087 = 'AE087: La fecha de recibo de la factura es inválida.';
     ME_088 = 'AE088: La fecha de recibo de la factura es mayor que la fecha actual';
     ME_089 = 'AE089: Tasa de cambio inválida';
     ME_090 = 'AE090: Llave %s en la tabla +CE de MSF010 no es una llave '+
              'válida. Debería tener 14 caracteres';
     ME_091 = 'AE091: No pudo cargar los nombres personalizados de las '+
              'categorías del contrato. Error técnico : %s';
     ME_092 = 'AE092: Se produjo el error %s cuando intentaba desaprobar el '+
              'Acta %s del Contrato %s. Es posible que la operación fallara '+
              'o que la ventana de busqueda no esté mostrando valores reales.';
     ME_093 = 'AE093: Nuevo valor de los pagos al Contrato (%m) excede el tope '+
              '%s permitido (%m)';
     ME_094 = 'AE094: Valores asignados a los Centros de Costos suman %m; '+
              'este valor no es igual al total del elemento (%m)';
     ME_095 = 'AE095: No pudo determinar el Centro de Costos asociado al '+
              'equipo %s. Error técnico : %s';
     ME_096 = 'AE096: No pudo determinar el Centro de Costos asociado a la '+
              'orden de trabajo %s. Error técnico : %s';
     ME_097 = 'AE097: No pudo determinar el Centro de Costos asociado al '+
              'proyecto %s. Error técnico : %s';
     ME_098 = 'AE098: Excedido valor tope para el elemento nro %s. Tope en '+
              'el contrato : %m. Ejecutado actual : %m. Nuevo Valor '+
              'ejecutado : %m';
     ME_099 = 'AE099: No pudo cargar la Configuración de Preferencias de '+
              'para el distrito actual (Distrito %s). El sistema usará '+
              'como default los valores más conservadores; pero estos pueden '+
              'no ser adecuados para su caso. Se recomienda que cierre el '+
              'programa e informe a soporte técnico. Error técnico : %s';
     ME_100 = 'AE100: No pudo recuperar los comentarios asociados al acta %s '+
              'del Contrato %s. Error técnico : %s';
     ME_101 = 'AE101: No pudo guardar los comentarios asociados al acta %s '+
              'del Contrato %s. Error técnico : %s';
     ME_102 = 'AE102: No pudo leer la definición de los centros de costos '+
              'actuales para el contrato %s porción %s. Error técnico : %s';
     ME_103 = 'AE103: No pudo inicializar el sistema. La aplicación se '+
              'cerrará. Error técnico : %s';
     ME_104 = 'AE104: No pudo guardar en SAF3A6 un nuevo centro de costos '+
              'a ser considerado como actual para el Contrato %s, Porción %s '+
              'Elemento %s. El Centro de Costos era el %s. Error técnico : %s';
     ME_105 = 'AE105: No pudo actualizar en SAF3A6 los datos del centro de '+
              'costos %s el cual es de los considerados actuales en el '+
              'Contrato %s, Porción %s Elemento %s. Error técnico : %s';
     ME_106 = 'AE106: No pudo borrar en SAF3A6 los datos del centro de '+
              'costos %s el cual era de los considerados actuales en el '+
              'Contrato %s, Porción %s Elemento %s. Error técnico : %s';
     ME_107 = 'AE107: No pudo conectarse a MIMS con MSQMUI. Error técnico : %s';
     ME_108 = 'AE108: Inesperado error interno. Tipo de documento inválido '+
              'en el Contrato %s Acta %s Elemento %s Centro de Costos %s. '+
              'El tipo tiene un valor de %s el cual no está definido';
     ME_109 = 'AE109: MSQMUI reportó el error %s cuando se intentó enviár a '+
              'MIMS datos del elemento %s';
     ME_110 = 'AE110: MSQMUI reportó el error %s después de procesar los '+
              'datos de todos los elementos';
     ME_111 = 'AE111: Inesperado error interno. MSQMUI reportó como pantalla '+
              'actual la %s cuando se esperaba la MSM26DA después de procesar '+
              'todos los elementos. Status de error MSQMUI = %s';
     ME_112 = 'AE112: MSQMUI reportó el error %s cuando se intentó enviár a '+
              'MIMS datos del elemento %s centro de costos %s';
     ME_113 = 'AE113: MSQMUI reportó el error %s después de procesar los '+
              'datos de toda la factura';
     ME_114 = 'AE114: Se produjo el error %s al tratar de crear el archivo de '+
              'log de errores (%s). Verifique que %s exista y que usted tenga '+
              'permiso de escritura sobre el; luego reintente';
     ME_115 = 'AE115: El comando %s no existe en MSQMUI';
     ME_116 = 'AE116: No pudo actualizar el Acta %s del contrato %s. Error '+
              'técnico : %s';
     ME_117 = 'AE117: No pudo obtener la fecha del otrosí al contrato %s. Error '+
              'técnico : %s';
     ME_118 = 'AE118: Posición del usuario (%s en el distrito %s) no hallada '+
              'en MSF872';
     ME_119 = 'AE119: No pudo determinar el máximo valor de un acta que el '+
              'usuario está autorizado a aprobar. La opción de aprobar no '+
              'estará disponible. Error técnico : %s';
     ME_120 = 'AE120: El acta a procesar (Acta %s del contrato %s) excede '+
              'el máximo valor que usted puede aprobar en un Acta. Está '+
              'autorizado a aprobar como máximo %m y el acta vale %m, valores '+
              'dados en la moneda local %s. El máximo dado corresponde a la '+
              'posición %s del distrito %s';
     ME_121 = 'AE121: El valor de la factura no concuerda con el valor del '+
              'Acta.';
     ME_122 = 'AE122: Inesperado error interno. Columna interna %s no '+
              'existe en el grid (Malla)';
     ME_123 = 'AE123: No pudo obtener los valores de los pagos hechos a cada '+
              'elemento de la porcion %s del contrato %s. Error técnico : %s';
     ME_124 = 'AE124: No pudo obtener los valores de cada elemento del Acta '+
              '%s del contrato %s. Error técnico : %s';
     ME_125 = 'AE125: No pudo aprobar el Acta %s del Contrato %s. Error '+
              'técnico : %s';
     ME_126 = 'AE126: Inesperado error interno. Método de validación del tope '+
              '%s no está definido, o tiene datos corruptos';
     ME_127 = 'AE127: Inesperado error interno. Categorías actuales no están '+
              'sincronizadas con el elemento actual';
     ME_128 = 'AE128: No hay centros de Costos asignados al Acta.';
     ME_129 = 'AE129: Distribución de Costos inconsistente para el elemeto %s.'+
              'Valor del Elemento : %m . Valor de los Centrs de Costos : %m';
     ME_130 = 'AE130: No pudo recuperar la lista de códigos de impuestos. La '+
              'aplicación se cerrará. Error técnico : %s';
     ME_131 = 'AE131: No pudo crear las lista desplegables de códigos de ' +
              'impuestos para los campos de impuestos. Error técnico : %s';
     ME_132 = 'AE132: Inesperado error interno. El elemento %s aparece en el '+
              'Acta; pero no existe en el contrato';
     ME_133 = 'AE133: Inesperado error interno. El elemento %s tiene el '+
              'código %s; pero tal código no existe en la tabla EN de MSF010';
     ME_134 = 'AE134: No pudo crear la factura en MIMS. Error técnico : %s';
     ME_135 = 'AE135: MSQMUI no está actualmente sincronizado con el módulo de '+
              'facturas de MIMS. Pantalla Actual %s. Salga del sistema y '+
              'reintente';
     ME_136 = 'AE136: Nu pudo cargar la lista de categorias por elemento de la '+
              'porción %s del Contrato %s. Error técnico : %s';
     ME_137 = 'AE137: La identificación existe en MSF810; pero el empleado '+
              'no tiene ningún nombre asociado';
     ME_138 = 'AE138: No tiene permiso para ejecutar este programa';
     ME_139 = 'AE139: Se produjo el error %s cuando estaba validando el '+
              'acceso al programa. La aplicación se cerrará';
     ME_140 = 'AE140: No pudo agregar la pareja %s,%s al requerimiento %s '+
              'del bloque %s (sistema de seguridad MIMS)';
     ME_141 = 'AE141: No pudo agregar la pareja %s,%s a la instancia %s del '+
              'requerimiento %s del bloque %s (sistema de seguridad MIMS)';
     ME_142 = 'AE142: No pudo ejecutar correctamente una consulta interna al '+
              'programa MIMS %s. Probablemente no tiene acceso a este '+
              'programa.';
     ME_143 = 'AE143: Dato no existe en la tabla MSF000_DC0001';
     ME_144 = 'AE144: No pudo determinar la moneda local para el distrito %s. '+
              'Error técnico : %s';
     ME_145 = 'AE145: No pudo determinar la tasa de cambio para pasar valores '+
              'en la monedas %s a la moneda %s . Error técnico :%s';
     ME_146 = 'AE146: No pudo cargar los códigos de manejo. Error técnico :%s';
     ME_147 = 'AE147: Error %s inicializando programa MIMS %s';
     ME_148 = 'AE148: Tasa de cambio negativa';
     ME_149 = 'AE149: No pudo recuperar información de impuestos para el Acta '+
              '%s del Contrato %s. Error técnico %s';
     ME_150 = 'AE150: No pudo cargar la lista de unidades monetarias '+
              'definidas en MIMS. Error técnico %s';
     ME_151 = 'AE151: Se produjo el error %s al tratar de insertar la '+
              'información para el impuesto con código %s';
     ME_152 = 'AE152: No se ha definido la información de impuestos.';
     ME_153 = 'AE153: Error "%s" cuando intentaba preparar la grabación '+
              'de la información de impuestos';
     ME_154 = 'AE154: %s no es una moneda válida';
     ME_155 = 'AE155: No hay un Acta anterior';
     ME_156 = 'AE156: Error "%s" hallando el Acta anterior al acta actual '+
              'del contrato %s. El Acta actual tiene %s como fecha MIMS ';
     ME_157 = 'AE157: Inesperado Error Interno. No encuentra el elemento %s '+
              'en la lista interna de elementos';
     ME_158 = 'AE158: Voucher no definido en MSF001_DC0031';
     ME_159 = 'AE159: No pudo leer la definición del estilo de voucher para '+
              'el distrito %s. Error técnico %s';
     ME_160 = 'AE160: Error MIMS %s';
     ME_161 = 'AE161: No pudo inicializar MIMSX Server';
     ME_162 = 'AE162: Falla al asignar %s a %s. Error técnico : %s';
     ME_163 = 'AE163: Falla al leer el valor del campo %s. Error técnico : %s';
     ME_164 = 'AE164: No pudo cerrar la tabla %s. Error técnico : %s';
     ME_165 = 'AE165: No pudo terminar adecuadamente la sesión en MIMS. '+
              'Error técnico : %s';
     ME_166 = 'AE166: Se produjo el error "%s" cuando estaba intentando procesar '+
              'un error previo. El error original fué : %s';
     ME_167 = 'AE167: Se produjo el error critico "%s". El sistema intentará '+
              'sincronizarse de nuevo con MIMS; pero es probable que deba '+
              'salir del sistema';
     ME_168 = 'AE168: No pudo localizar el directorio de MIMS Pop up';
     ME_169 = 'AE169: No pudo crear el directorio de trabajo de la sesión (%s).'+
              ' Verifique sus derechos de creación de ese directorio';
     ME_170 = 'AE170: No pudo borrar el directorio de trabajo de la sesión (%s).'+
              'Deberá borrarlo manualmente. El error reportado fué : %s.';
     ME_171 = 'AE171: %s no es un valor entero';
     ME_172 = 'AE172: No está correctamente definido el origen del permiso '+
              'que el usuario pueda tener para procesar actas del contrato. '+
              'Verifique esta configuración en SA305';
     ME_173 = 'AE173: No pudo determinar el valor actual deducible del '+
              'presupuesto del acta %s en el contrato %s. Error técnico : %s';
     ME_174 = 'AE174: Falla al validar el equipo %s. Error técnico : %s';
     ME_175 = 'AE175: Falla al validar la Orden de Trabajo %s.  Error técnico : %s';
     ME_176 = 'AE176: Falla al validar el Proyecto %s.  Error técnico : %s';
     ME_177 = 'AE177: Registro no existe o no tiene permitido costeo o no está vigente en la tabla %s';
     ME_178 = 'AE178: El comando "%s" usado para recuperar la fecha y hora '+
              'actual no devolvió ninguna información';
     ME_179 = 'AE179: Inhabilitado para determinar la fecha y hora actual en ' +
              'el servidor. Error técnico : %s';
     ME_180 = 'AE180: Se produjo el código de error %d cuando el sistema '+
              'estaba efectuando el control de multiples instancias. La '+
              'aplicación se cerrará';
     ME_181 = 'AE181: Instancia y Puerto MIMS registrado en %s; pero no '+
              'se indica el Alias BDE. Formato debe ser InstanciaPuerto = '+
              'Alias BDE';
     ME_182 = 'AE182: Instancia y Puerto MIMS registrado en %s; pero no '+
              'hay un signo igual (=) separandolos dels Alias BDE. Formato '+
              'debe ser InstanciaPuerto = Alias BDE';
     ME_183 = 'AE183: No pudo cargar la lista de características de los '+
              'Elements No (tabla +DES de MSF010). Error técnico : %s. La '+
              'aplicación se cerrará';
     ME_184 = 'AE184: El elemento actual es para ser usado en facturas a '+
              'terceros; por tanto, cada centro de costos debe estar marcado '+
              'con un Indicador de OP';
     ME_185 = 'AE185: El elemento actual NO es para ser usado en facturas a '+
              'terceros; por tanto, un centro de costos no puede estar marcado '+
              'con un Indicador de OP';
     ME_186 = 'AE186: Falla al validar la OP %s.  Error técnico : %s';
     ME_187 = 'AE187: Los valores del campo %s en SAF3A1 para el Elemento %s '+
              'Acta %s en el contrato %s no concuerdan con el valor actual '+
              'de esta bandera en la tabla +DES de MSF010. El sistema usará '+
              'los valores definidos en SAF3A1; pero usted debería informar '+
              'a soporte técnico de esta inconsistencia ya que pueden '+
              'generarse valores erroneos del Acta.';
     ME_188 = 'AE188: Fecha %s del Período cubierto por el Acta es inválida. '+
              'Probablemente aún no ha especificado el período. El sistema le '+
              'muestra por default la fecha del día; pero solo como referencia. '+
              'Es obligatorio que usted asigne una fecha.';
     ME_189 = 'AE189: Fecha Inicial del Período cubierto por el Acta es mayor '+
              'que la Fecha Final';
     ME_190 = 'ME190: Fecha de la tasa de cambio es inválida. Error técnico: %s';
     ME_191 = 'ME191: Fecha indefinida';
     ME_192 = 'ME192: No pudo recuperar el código original del contrato. Lo '+
              'asume vacío. Error Técnico : %s';
     ME_193 = 'ME193: Falla al validar la distribución de Centros de Costos '+
              'del Acta %s del Contrato %s. Error Técnico : %s';
     ME_194 = 'ME194: La Distribución de Centros de Costos no está asignada.';
     ME_195 = 'ME195: Número de %s para el elemento %s, Centro de Costos %s '+
              'no está asignado.';
     ME_196 = 'ME196: Tipo de documento para el elemento %s, Centro de Costos '+
              '%s es inválido';
     ME_197 = 'ME197: El nombre de la categoría contiene la clave %s a partir '+
              'del caracter %d ; pero no está seguída de un valor válido. '+
              'revise la sintaxis para categorías que representan porcentajes '+
              'a ser aplicados a otros elementos';
     ME_198 = 'ME198: El nombre de la categoría define un límite %s más de '+
              'una vez';
     ME_199 = 'ME199: No hay elementos disponibles para cálculo';
     ME_200 = 'ME200: Base gravable %m excede valor bruto editado del Acta';
     ME_201 = 'ME201: Centro de Costos no tiene un Costo asignado';
     ME_202 = 'ME202: No pudo determinar si el usuario puede o no escoger el '+
              'tipo de distribución de Centros de Costos para la posición %s '+
              'del distrito %s. Error Técnico : %s';
     ME_203 = 'ME203: Elemento %s es un %s. No puede digitar valores '+
              'negativos.';
     ME_204 = 'ME_204: Falla validando contratista %s. Error Técnico : %s';
     ME_205 = 'ME_205: Contratista no está activo';
     ME_206 = 'ME_206: Centro de Costos %s no tiene Elemento de Gasto';
     ME_207 = 'ME_207: El Centro de Costos %s es inválido. Error ' +
              'técnico : %s';
     ME_208 = 'ME_208: Centro de Costos no está activo';
     ME_209 = 'ME_209: Centro de Costos no existe en MSF920';
     ME_210 = 'ME_210: Las actas de este contrato no tienen el valor previo consistente';
     ME_211 = 'ME_211: Atención:';
     ME_212 = 'ME_212: El elemento AI ya fue utilizado en este contrato %s'+ chr(10) +
              'Atención: %s';
     ME_213 = 'ME_213: El contrato debe ser aprobado por un usuario'+ chr(10) +
              'diferente al que lo aprobó';
     ME_214 = 'ME_214: Centro de costo %s no está asociado al proyecto';
     ME_215 = 'AE215: Al enviar el Acta %s del contrato %s excede el ' +
              'valor disponible en %m'        + chr(10)+
              'Valor del contrato: %m '       + chr(10)+
              'Valor máximo de esta acta: %m' + chr(10);
     ME_216 = 'AE_216: Error la posición que envía el acta no tiene superior';
     ME_217 = 'AE_217: El acta no se puede enviar porque no existe posición superior';
     ME_218 = 'AE_218: Error se intenta escribir la fecha de envío en blanco';
     ME_219 = 'AE_219: Error no puede crear acta para contrato cerrado';
     ME_220 = 'AE_220: Error al duplicar el centro de costos %s';
     ME_221 = 'AE221: Período cubierto por el Acta es mayor '+
              'que la Fecha Final';
{ Confirmation Messages }

Const
     MC_001 = 'AC001: Recuperar todas las Actas del Usuario (Si/No)?';
     MC_002 = 'AC002: Registro actual está siendo editado. Salvarlo (Si/No)?';
     MC_003 = 'AC003: Usar la distribución de centros de costos de esta '+
              'Acta como distribución actual en el contrato (Si/No)?';
     MC_004 = 'AC004: Tasa de cambio calculada por el sistema (%f) '+
              'difiere de la dada en el campo Tasa de cambio (%s). '+
              'Continuar (Si/No)?';
     MC_005 = 'AC005: Desea continuar viendo esta advertencia para otros '+
              'Centros de Costos que puedan estar inactivos (S/N) ? ';
     MC_006 = 'AC006: Desea aprobar el acta (S/N) ';

{ Types of Contract Administrators }

Const
     ADC_Generator = 'AG';
     ADC_Approver  = 'AA';
     ADC_Reader    = 'AC';
     ADC_Owner     = 'AO';

{ Search definitions for SAQ304 Search form }

Type
     TArrInvSt = Array[TInvoiceStatus] Of String;
     TArrInvKindDate = Array[TInvKindDate] Of String;
Const
     InvStatusNames:TArrInvSt = ('Cualquiera', 'Pendiente', 'Generado');
     InvKindDateNames:TArrInvKindDate = ('Ninguna', 'Autorización',
                                         'Factura', 'Recibo');
     InvFieldDateNames:TArrInvKindDate = ('',
                                          'AUTH_DATE',
                                          'INVOICE_DATE',
                                          'INVOICE_RCV_DT');
     SQLInvSearch01 = 'Select * From SAF3A4';
     SQLInvSearch02 = 'Where';
     SQLInvSearch03 = '(''%s''<=%s) And (%s<=''%s'')';
     SQLInvSearch04 = 'And';
     SQLInvSearch05 = '(STATUS=''%d'')';

{ Status definitions }

Type
     TArrayOfStatus = Array[TActStatus] Of String;
     TSetOfStatus   = Set Of TActStatus;
Const
     StatusNames:TArrayOfStatus = ('Cualquiera', 'Pendiente', 'Enviado',
                                   'Anulado', 'Aprobado','Contabilizado',
                                   'Facturado','Cerrado');
     StatusReadOnly:TSetOfStatus = [asNull,asApproved,asCounted,asInvoiced,asClosed];

{ Buttons in TDBNavigators }
Const
     BtnReadOnly:TButtonSet    = [nbFirst, nbPrior, nbNext, nbLast];
     BtnOnlyEdition:TButtonSet = [nbFirst, nbPrior, nbNext, nbLast, nbEdit,
                                  nbPost, nbCancel, nbRefresh];
     BtnFullAccess:TButtonSet  = [nbFirst, nbPrior, nbNext, nbLast, nbEdit,
                                  nbPost, nbCancel, nbRefresh,nbInsert, nbDelete];
{ Document definitions }

Type
     TDocuments = Array[TDocument] Of String;

Const
     DocumentNames:TDocuments = ('Ninguno','Orden', 'Proyecto','OP');
     WPIndicators:TDocuments = (' ','W','P','O');

{ SQL statements for search Acts }

Type
     TSQLSearch = Array[TSearchingCode,TSQLLinesForSearch] Of String;
Const
     {SQLCommonSelection01 = 'Select A.PORTION_NO,A.ACT_PAID_DATE,A.APPROVED_BY,%s '+
                            'FROM ELLIPSE.SAF3A0 A,ELLIPSE.MSF384 C';
     SQLCommonSelection02 = ',ELLIPSE.MSF385 D';
     SQLCommonCondition01 = 'Where (A.CONTRACT_NO=C.CONTRACT_NO) ';
     SQLCommonCondition02 = 'And (A.CONTRACT_NO=D.CONTRACT_NO) ' +
                            'And (A.PORTION_NO=D.PORTION_NO) ';
     SQLCommonUserOwner01 = 'And ((C.RESPONS_CODE_1=''%s'') Or '+
                                 '(C.RESPONS_CODE_2=''%s'') Or '+
                                 '(C.RESPONS_CODE_3=''%s'') Or '+
                                 '(C.RESPONS_CODE_4=''%s'')) ';
     SQLCommonUserOwner02 = 'And ((D.RESPONS_CODE_1=''%s'') Or '+
                                 '(D.RESPONS_CODE_2=''%s'') Or '+
                                 '(D.RESPONS_CODE_3=''%s'') Or '+
                                 '(D.RESPONS_CODE_4=''%s'')) ';}
     SQLCommonSelection01 = 'Select A.PORTION_NO,A.ACT_PAID_DATE,A.APPROVED_BY,%s '+
                            'FROM ELLIPSE.SAF3A0 A INNER JOIN ELLIPSE.MSF384 C ON (A.CONTRACT_NO=C.CONTRACT_NO) ';
     //SQLCommonSelection01 = 'Select SUBSTR(E.ENTITY_VALUE,9,4) AS VALN_NO , A.PORTION_NO,A.ACT_PAID_DATE,A.APPROVED_BY,%s '+
     //                       'FROM ELLIPSE.SAF3A0 A INNER JOIN ELLIPSE.MSF384 C ON (A.CONTRACT_NO=C.CONTRACT_NO) ';

     SQLCommonSelection02 = 'INNER JOIN ELLIPSE.MSF385 D ON (A.CONTRACT_NO=D.CONTRACT_NO) ' +
                            'And (A.PORTION_NO=D.PORTION_NO) ';

     //SQLCommonSelection03 = 'LEFT OUTER JOIN ELLIPSE.MSF071 E ON (E.ENTITY_TYPE = ''EV2'' AND E.REF_NO = ''001'' AND ' +
     //                       'E.SEQ_NUM = ''001'' AND E.REF_CODE = RPAD(A.ACT_PAID_NO,40,'' '') ) ';

     SQLCommonCondition01 = 'Where 1 = 1 ';

     //SQLCommonCondition02 = 'And (A.CONTRACT_NO=D.CONTRACT_NO) ' +
     //                       'And (A.PORTION_NO=D.PORTION_NO) ';
     SQLCommonUserOwner01 = 'And ((C.RESPONS_CODE_1=''%s'') Or '+
                                 '(C.RESPONS_CODE_2=''%s'') Or '+
                                 '(C.RESPONS_CODE_3=''%s'') Or '+
                                 '(C.RESPONS_CODE_4=''%s'')) ';
     SQLCommonUserOwner02 = 'And ((D.RESPONS_CODE_1=''%s'') Or '+
                                 '(D.RESPONS_CODE_2=''%s'') Or '+
                                 '(D.RESPONS_CODE_3=''%s'') Or '+
                                 '(D.RESPONS_CODE_4=''%s'')) ';
     { In the selection line only include the neccesary fields for each case }
     SQLSearch:TSQLSearch=
     ({ Lines for scByAct }
      ('C.SUPPLIER_NO,A.CONTRACT_NO,A.STATUS',
       'AND (A.ACT_PAID_NO=''%s'')'),
      { Lines for scByContractAct }
      ('C.SUPPLIER_NO,A.STATUS',
       'AND (A.CONTRACT_NO=''%s'') AND (A.ACT_PAID_NO=''%s'')'),
      { Lines for scByContract }
      ('C.SUPPLIER_NO,A.ACT_PAID_NO,A.STATUS',
       'AND (A.CONTRACT_NO=''%s'')'),
      { Lines for scByContractStatus }
      ('C.SUPPLIER_NO,A.ACT_PAID_NO',
       'AND (A.CONTRACT_NO=''%s'') AND (A.STATUS=''%s'')'),
      { Lines for scBySupplierAct }
      ('A.CONTRACT_NO,A.STATUS',
       'AND (C.SUPPLIER_NO=''%s'') AND (A.ACT_PAID_NO=''%s'')'),
      { Lines for scBySupplier }
      ('A.CONTRACT_NO,A.ACT_PAID_NO,A.STATUS',
       'AND (C.SUPPLIER_NO=''%s'')'),
      { Lines for scBySupplierStatus }
      ('A.CONTRACT_NO,A.ACT_PAID_NO',
       'AND (C.SUPPLIER_NO=''%s'') AND (A.STATUS=''%s'')'),
      { Lines for scBySupplierActStatus }
      ('A.CONTRACT_NO',
       'AND (C.SUPPLIER_NO=''%s'') '+
       'AND (A.ACT_PAID_NO=''%s'') AND (A.STATUS=''%s'')'),
      { Lines for scByStatus }
      ('C.SUPPLIER_NO,A.CONTRACT_NO,A.ACT_PAID_NO',
       'AND (A.STATUS=''%s'')'),
      { Lines for scAll }
      ('C.SUPPLIER_NO,A.CONTRACT_NO,A.ACT_PAID_NO,A.STATUS',
       '') );

{ SQL statements to search suppliers }

Const
     SQLSuppliers01 = 'Select SUPPLIER_NO,SUPPLIER_NAME From ELLIPSE.MSF200';
     SQLSuppliers02 = 'Where SUPPLIER_NAME LIKE ''%s''';
     SQLSuppliers03 = 'Where SUPPLIER_NO = ''%s''';
     SQLSuppliers04 = 'Order By SUPPLIER_NAME';

Const
     SQL_Pendents01 = 'Select A.CONTRACT_NO,A.PORTION_NO,A.ACT_PAID_NO,';
     SQL_Pendents02 = 'A.ACT_PAID_DATE,B.SUPPLIER_NO,B.CONTRACT_VAL,';
     SQL_Pendents03 = 'B.CURRENCY_TYPE';
     SQL_Pendents04 = 'From ELLIPSE.SAF3A0 A,ELLIPSE.MSF384 B';
     SQL_Pendents05 = 'Where (A.CONTRACT_NO in (Select CONTRACT_NO From ELLIPSE.MSF385';
     SQL_Pendents06 = '       Where (RESPONS_CODE_1=:AnApprover1) Or';
     SQL_Pendents07 = '             (RESPONS_CODE_2=:AnApprover2) Or';
     SQL_Pendents08 = '             (RESPONS_CODE_3=:AnApprover3) Or';
     SQL_Pendents09 = '             (RESPONS_CODE_4=:AnApprover4)';
     SQL_Pendents10 = '        )) And';
     SQL_Pendents11 = '       (STATUS=''2'') And';
     SQL_Pendents12 = '       (A.CONTRACT_NO=B.CONTRACT_NO)';

{ SQL statements for the report 02 }

Const
     SQLRep0201 = 'Select A.CONTRACT_NO,A.PORTION_NO,A.ELEMENT_NO,';
     SQLRep0202 = 'A.CATEGORY_NO,A.CATEG_CODE,A.CATEG_BASE_QTY,';
     SQLRep0203 = 'A.CATEG_BASE_VAL, B.TABLE_DESC';
     SQLRep0204 = 'From ELLIPSE.MSF387 A, ELLIPSE.MSF010 B';
     SQLRep0205 = 'Where (%s) And ';
     SQLRep0206 = '(B.TABLE_TYPE=''CE'') And (A.CATEG_CODE=B.TABLE_CODE)';
     SQLRep0207 = 'Order By 1,2,3,4';

{ SQL statements for the report 04 }

Const
     SQLRep0401 = 'Select A.CONTRACT_NO,A.PORTION_NO,A.ACT_PAID_NO, ';
     SQLRep0402 = '       A.ACT_PAID_DATE,A.STATUS,A.PRV_EXEC_VALUE';
     SQLRep0403 = 'From ELLIPSE.SAF3A0 A';
     SQLRep0404 = 'Where %s';
     SQLRep0405 = 'Order By A.CONTRACT_NO,A.PORTION_NO,A.ACT_PAID_NO';

{ Version Info }

Const
     MIMSActPaidProject    = 'Act Paid';
     MIMSActPaidVersionNo  = '2.2';
     MIMSActPaidRevisionNo = '1.0';
     MIMSActPaidModuleNo   = '3380';

{ Other literal messages }

Const
     MI_001 = '%d Registros encontrados';
     MI_002 = 'Buscando ...';
     MI_003 = '%d Actas seleccionadas';
     MI_004 = 'Aprobando %m';
     MI_005 = 'insertar';
     MI_006 = 'actualizar';
     MI_007 = 'Datos grabados satisfactoriamente.';
     MI_008 = 'Registro está siendo editado. Grabe o cancele antes de cerrar '+
              'la ventana.';
     MI_009 = 'No hay Actas aprobadas pendientes';
     MI_010 = 'Archivo %s generado satisfactoriamente';
     MI_011 = 'Valor editado del Acta : %m';
     MI_012 = 'No pudo grabar en MIMS la factura %s del Acta %s del Contrato %s';
     MI_013 = 'Error reportado :';
     MI_014 = 'La factura %s del Acta %s del Contrato %s fué grabada en MIMS; '+
              'pero el sistema no pudo actualizar los cambios en las Actas.';
     MI_015 = 'WAS LOADED APPROVED';
     MI_016 = 'Grupo';
     MI_017 = 'Presupuestal';
     MI_018 = 'Contractual';
     MI_019 = 'Valor ';
     MI_020 = 'Item';
     MI_021 = 'Global';
     MI_022 = 'Impuesto Calculado : %s';
     MI_023 = 'Impuesto calculado para el Item %s : %s';
     MI_024 = 'Valores editados: Elemento %m / Bruto del Acta %m';
     MI_025 = 'WAS LOADED UNAPPROVED';
     MI_026 = 'ACTA DE PAGO RESUMIDA';
     MI_027 = 'Operación interrumpida por el usuario.';
     MI_028 = 'Valor bruto editado del Acta : %m';
     MI_029 = 'Costo';
     MI_030 = 'Descuento';
     MI_031 = '%s no hallado';
{ Context identification for windows help called by using Application.HelpContext
  Check SAQ301.hpj, SAQ302.hpj and SAQ303.hpj for the interpretation of these codes}

Const
     SAH3011320 = 1320;
     SAH3011325 = 1325;
     SAH3011328 = 1328;
     SAH3011330 = 1330;
     SAH3011335 = 1335;
     SAH3021000 = 1000;
     SAH3031000 = 1000;
     SAH3031100 = 1100;
     SAH3031200 = 1200;
     SAH3031300 = 1300;

{ Text lines for SAQ303 }

Const
     SAQ303Creating   = 'Creando MIMSX';
     SAQ303Starting   = 'Iniciando MIMSX';
     SAQ303Connecting = 'Conectando a MIMSX';
     SAQ303Loading389 = 'Cargando MSO389';
     SAQ303Processing = 'Procesando';
     SAQ303SendHeader = 'Factura';
     SAQ303CurrentRec = '%s %d Max %d';
     SAQ303Finish     = 'Procesado Terminado. %d Facturas grabadas. %d '+
                        'mensajes de error generados';
{ Text lines for SAQ305 }
Const
     SAQ305DstrctTitle = 'Aplicables al Distrito %s';
     SAQ305LoadFailure = 'Error %s al inicializar el sistema. La aplicación se '+
                         'cerrará. ';
     SAQ305SaveFailure = 'Error %s al intentar grabar los datos. Reintente, si '+
                         'el problema persiste informe a soporte técnico. ';

{ Key field names for the locate function on DataSet }

Const
     KNL_001 = 'ELEMENT_NO;CATEGORY_NO';
     KNL_002 = 'DSTRCT_CODE';
     KNL_003 = 'ELEMENT_NO;CATEGORY_DESC';
     KNL_004 = 'ELEMENT_NO;GL_ACCOUNT;DOCUMENT_TYPE;DOCUMENT_NO;EQUIP_NO';

{ Constant miscellaneous }

Const
     Delta          = 0.00009; { Because currency values use four decimal digits }
     MIMSRegPath    = '\SOFTWARE\MINCOM\MIMS';
     MIMSTopInvDate = 99999999; { Used to calculate MIMS date in inverse format }
     LogFile303     = '%s\SAQ303%s%2.2d.Log';
     AtaxFmt        = '%-4s %7s ';
     ItemDescFmt    = '%-2s %s';
     MSM26JALines   = 12;

Const
     DI_Category_NO   = 'ELEMENT_NO;CATEGORY_NO';
     DI_Category_DESC = 'ELEMENT_NO;CATEGORY_DESC';
     
implementation

end.






