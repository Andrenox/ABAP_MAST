CLASS zcl_fabap_jul2025_exer15_mast DEFINITION
                                    PUBLIC
                                    FINAL
                                    CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_fabap_jul2025_exer15_mast IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA tabela_voos TYPE SORTED TABLE OF ty_voo_info
    WITH NON-UNIQUE KEY id_companhia id_conexao.

    SELECT voo~carrier_id     AS id_companhia,
           voo~connection_id  AS id_conexao,
           voo~price          AS preco,
           carrier~distance       AS distancia
      FROM /dmo/flight AS voo
        INNER JOIN /dmo/connection AS carrier
            ON voo~carrier_id = carrier~carrier_id
            AND voo~connection_id = carrier~connection_id
                WHERE carrier~distance > 1000
                        AND voo~carrier_id = 'UA'
                        AND voo~connection_id IN ('0058', '0059', '1537')
                    INTO TABLE @tabela_voos.

    LOOP AT tabela_voos ASSIGNING FIELD-SYMBOL(<voo>).

      <voo>-preco *= '1.10'.

      out->write( |Preço atualizado para voo { <voo>-id_companhia }-{ <voo>-id_conexao }| ).

    ENDLOOP.



  ENDMETHOD.
ENDCLASS.

