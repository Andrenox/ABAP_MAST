CLASS zcl_fabap_jul2025_exer4c_mast DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER4C_MAST IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    out->write( '===== zi_fabap_exer01_mast - Voos =====' ).
    SELECT * FROM zi_fabap_exer01_mast INTO TABLE @DATA(t_voos).
    LOOP AT t_voos INTO DATA(voo).
      out->write( |Companhia: { voo-CarrierName } ({ voo-CarrierId })| ).
      out->write( |Conexão: { voo-ConnectionId }| ).
      out->write( |Data do Voo: { voo-FlightDate }| ).
      out->write( |Assentos: { voo-SeatsOccupied } / { voo-SeatsMax }| ).
      out->write( |Taxa de Ocupação: { voo-OccupancyRate }| ).
      out->write( '-----------------------------' ).
    ENDLOOP.

    out->write( '===== zi_fabap_exer02_mast - Conexões por Companhia =====' ).
    SELECT * FROM zi_fabap_exer02_mast INTO TABLE @DATA(t_conexoes).
    LOOP AT t_conexoes INTO DATA(conexao).
      out->write( |Companhia: { conexao-CarrierName } ({ conexao-CarrierId })| ).
      out->write( |Número de Conexões: { conexao-ConnectionCount }| ).
      out->write( |Maior Distância: { conexao-MaxDistance } km| ).
      out->write( '-----------------------------' ).
    ENDLOOP.

    out->write( '===== zi_fabap_exer03_mast - Clientes =====' ).
    SELECT * FROM zi_fabap_exer03_mast INTO TABLE @DATA(t_clientes).
    LOOP AT t_clientes INTO DATA(cliente).
      out->write( |Cliente: { cliente-FirstName } { cliente-LastName } (ID: { cliente-CustomerId })| ).
      out->write( |Endereço Completo: { cliente-FullAddress }| ).
      out->write( '-----------------------------' ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
