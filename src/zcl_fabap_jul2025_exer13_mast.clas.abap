CLASS zcl_fabap_jul2025_exer13_mast DEFINITION
                                    PUBLIC
                                    FINAL
                                    CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_fabap_jul2025_exer13_mast IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " ----------------------------------------------------------------------
    " Tópico: Inline Declarations
    " Descrição: Declaração de variáveis antes do ABAP 7.40.
    " ----------------------------------------------------------------------

    DATA(lv_carrid) = 'AA'.
    out->write( |New Version - Carrier ID: { lv_carrid }| ).

    TYPES: BEGIN OF ty_flight,

             carrid      TYPE /dmo/carrier_id,
             connid      TYPE /dmo/connection_id,
             flight_date TYPE /dmo/flight_date,

           END OF ty_flight.

    DATA: lt_flights TYPE STANDARD TABLE OF ty_flight
                     WITH EMPTY KEY.

    DATA: lv_version TYPE string.

    lt_flights = VALUE #( (
                            carrid = 'LH'
                            connid = '0400'
                            flight_date = '20250725' ) ).

    LOOP AT lt_flights INTO DATA(ls_flight).

      lv_version = |{ lv_version } { ls_flight-carrid }-{ ls_flight-connid }|.
      out->write( |New Version - Flight:{ lv_version }| ).

    ENDLOOP.

    SELECT *
        FROM /dmo/flight
          INTO TABLE @DATA(lt_flights_select) UP TO 2 ROWS.

    out->write( |New Version - Flights found (SELECT): { lines( lt_flights_select ) }| ).

    " ----------------------------------------------------------------------
    " Tópico: Table Expressions
    " Descrição: Acesso a linhas de tabelas internas antes do ABAP 7.40.
    " ----------------------------------------------------------------------

    TRY.

        DATA(ls_flight_expr) = lt_flights[ 1 ].
        out->write( |New Version - First Flight: { ls_flight_expr-carrid }-{ ls_flight_expr-connid }-{ ls_flight_expr-flight_date }| ).

      CATCH cx_sy_itab_line_not_found.
        out->write( |New Version - No first flight found.| ).

    ENDTRY.

    TRY.
        DATA(ls_flight_key) = lt_flights[ carrid = 'LH' connid = '0400' ].
        out->write( |New Version - Flight LH-0400: { ls_flight_key-carrid }-{ ls_flight_key-connid }| ).

      CATCH cx_sy_itab_line_not_found.
        out->write( |New Version - Flight LH-0400 not found.| ).

    ENDTRY.

     " ----------------------------------------------------------------------
    " Tópico: Conversion Operator CONV
    " Descrição: Conversão de tipos de dados antes do ABAP 7.40.
    " ----------------------------------------------------------------------

    DATA(lv_char) = '12345'.
    DATA(lv_int) = CONV i( lv_char ).
*   DATA(lv_char_conv) = CONV char7( lv_int ).

    out->write( |New Version - Converted to INT: { lv_int }| ).


   " ----------------------------------------------------------------------
    " Tópico: Value Operator VALUE
    " Descrição: Inicialização de estruturas e tabelas internas antes do ABAP 7.40.
    " ----------------------------------------------------------------------\

    TYPES ty_flight_novo_tt TYPE STANDARD TABLE OF ty_flight
                            WITH EMPTY KEY.

    DATA(ls_connection) = VALUE /dmo/connection(
                                airport_from_id = 'FRA'
                                airport_to_id   = 'JFK'
    ).

    DATA(lv_conn) = |New Version - Connection: { ls_connection-airport_from_id }-{ ls_connection-airport_to_id }|.
    out->write( lv_conn ).

   DATA(lt_flights_value_novo) = VALUE ty_flight_novo_tt(

      ( carrid = 'UA' connid = '0001' flight_date = '20250725' )
      ( carrid = 'DL' connid = '0002' flight_date = '20250726' )

    ).

    out->write( |New Version - Flights count (VALUE): { lines( lt_flights_value_novo ) }| ).

    " ----------------------------------------------------------------------
    " Tópico: LOOP X FOR operator
    " Descrição: Criação de tabelas internas com loops explícitos antes do ABAP 7.50.
    " ----------------------------------------------------------------------
    DATA(lt_flights_for_novo) =
     VALUE ty_flight_novo_tt( FOR ls_flight_novo_2
                                IN lt_flights_value_novo
                                 WHERE ( carrid = 'UA' )

                             ( carrid = ls_flight_novo_2-carrid connid = ls_flight_novo_2-connid ) ).

    out->write( |New Version - Flights for UA (FOR): { lines( lt_flights_for_novo ) }| ).

    " ----------------------------------------------------------------------
    " Tópico: Reduction operator REDUCE
    " Descrição: Redução de tabelas internas com loops explícitos antes do ABAP 7.50.
    " ----------------------------------------------------------------------

    TYPES: ty_number TYPE STANDARD TABLE OF i WITH EMPTY KEY.

    DATA(lt_numbers_reduce) = VALUE ty_number( ( 1 ) ( 2 ) ( 3 ) ).

    DATA(lv_sum_novo) = REDUCE i(
      INIT sum = 0
      FOR number IN lt_numbers_reduce
      NEXT sum = CONV i( sum + number )
    ).

    out->write( |Versão Alternativa - Soma: { lv_sum_novo }| ).

    " ----------------------------------------------------------------------
    " Tópico: Conditional operators COND and SWITCH
    " Descrição: Expressões condicionais com IF/ELSEIF/ELSE e CASE antes do ABAP 7.40.
    " ----------------------------------------------------------------------
    DATA(lv_code) = 1.
    DATA(lv_status) = COND string(
      WHEN lv_code = 1 THEN 'Success'
      WHEN lv_code = 2 THEN 'Warning'
      ELSE 'Error'
    ).

    DATA(lv_code_conv) = |New Version - Status (COND): { lv_status }|.
    out->write( lv_code_conv ).

    DATA(lv_code_case) = 2.
    DATA(lv_status_case) = SWITCH string(
      lv_code_case
      WHEN 1 THEN 'Success'
      WHEN 2 THEN 'Warning'
      ELSE 'Error'
    ).

    DATA(lv_code_conv2) = |New Version - Status (SWITCH): { lv_status_case }|.
    out->write( lv_code_conv2 ).

    " ----------------------------------------------------------------------
    " Tópico: Strings
    " Descrição: Manipulação de strings antes do ABAP 7.40.
    " ----------------------------------------------------------------------
    DATA(lv_var1_str) = 'Hello'.
    DATA(lv_var2_str) = 'World'.
    CONSTANTS lc_str TYPE string VALUE 'New Version - Concatenation (Strings)'.

    DATA(lv_result_str) = |{ lc_str } { lv_var1_str } { lv_var2_str }|.
    out->write( lv_result_str ).

    DATA(lv_string_sub) = 'ABCDEFG'.
    DATA(lv_sub) = substring( val = lv_string_sub off = 0 len = 3 ).

    DATA(lv_sub_conv) = |New Version - Substring (Strings): { lv_sub }|.
    out->write( lv_sub_conv ).

    DATA(lv_delivery_number) = '0080003371'.
    DATA(lv_formatted_delivery) = |{ lv_delivery_number ALPHA = OUT }|.
    out->write( |New Version - Embedded Expression (ALPHA) (Strings): { lv_formatted_delivery }| ).

    " ----------------------------------------------------------------------
    " Tópico: Loop at Group By
    " Descrição: Agrupamento de dados em loops de tabelas internas antes do ABAP 7.50.
    " ----------------------------------------------------------------------
    TYPES: BEGIN OF ty_flight_group_novo,
             carrid TYPE /dmo/carrier_id,
             connid TYPE /dmo/connection_id,
             price  TYPE /dmo/flight_price,
           END OF ty_flight_group_novo.

    DATA: lt_flights_group_novo TYPE STANDARD TABLE OF ty_flight_group_novo WITH EMPTY KEY.

    lt_flights_group_novo = VALUE #( ( carrid = 'LH' connid = '0400' price = '100' )
                                    ( carrid = 'LH' connid = '0401' price = '150' )
                                    ( carrid = 'UA' connid = '0001' price = '200' ) ).

    LOOP AT lt_flights_group_novo
        INTO DATA(ls_flight_group_novo)
            GROUP BY ls_flight_group_novo-carrid.

      DATA(lv_total_price_group) = REDUCE /dmo/flight_price( INIT s = 0 FOR member IN GROUP ls_flight_group_novo NEXT s = s + member-price ).
      out->write( |New Version - Carrier { ls_flight_group_novo-carrid } Total Price (Group By): { lv_total_price_group }| ).

    ENDLOOP.

* ----------------------------------------------------------------------
* Tópico: Filter
* Descrição: Filtragem de tabelas internas com loops explícitos antes do ABAP 7.40.
* ----------------------------------------------------------------------
    DATA lt_flights_novo2 TYPE SORTED TABLE OF ty_flight WITH UNIQUE KEY carrid connid.

    DATA(lt_flights_filter_novo) = FILTER #( lt_flights_novo2 WHERE carrid = CONV #( 'AA' ) ).

    out->write( |New Version - Filtered flights (LH): { lines( lt_flights_filter_novo ) }| ).

  ENDMETHOD.
ENDCLASS.
