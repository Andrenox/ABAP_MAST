CLASS zcl_fabap_jul2025_exer17_mast DEFINITION
                                    PUBLIC
                                    FINAL
                                    CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_fabap_jul2025_exer17_mast IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF ty_voo,
             carrier_id    TYPE /dmo/flight-carrier_id,
             connection_id TYPE /dmo/flight-connection_id,
           END OF ty_voo.

    TYPES: BEGIN OF ty_reserva,
             carrier_id    TYPE /dmo/booking-carrier_id,
             connection_id TYPE /dmo/booking-connection_id,
             flight_date   TYPE /dmo/booking-flight_date,
           END OF ty_reserva.

    DATA: t_voos     TYPE SORTED TABLE OF ty_voo
                     WITH NON-UNIQUE KEY carrier_id connection_id,
          t_reservas TYPE SORTED TABLE OF ty_reserva
                     WITH NON-UNIQUE KEY carrier_id connection_id.

    SELECT carrier_id, connection_id
      FROM /dmo/flight
      WHERE ( carrier_id = 'AA' AND connection_id = '0322' )
         OR ( carrier_id = 'UA' AND connection_id = '1537' )
      INTO TABLE @t_voos.

    IF sy-subrc = 0.
      SELECT carrier_id, connection_id, flight_date
        FROM /dmo/booking
        FOR ALL ENTRIES IN @t_voos
        WHERE carrier_id    = @t_voos-carrier_id
          AND connection_id = @t_voos-connection_id
        INTO TABLE @t_reservas.
    ENDIF.

    LOOP AT t_voos INTO DATA(voo).
      READ TABLE t_reservas WITH KEY carrier_id    = voo-carrier_id
                                     connection_id = voo-connection_id
           TRANSPORTING NO FIELDS
           BINARY SEARCH.

      IF sy-subrc = 0.
        DATA(lv_tabix) = sy-tabix.

        LOOP AT t_reservas FROM lv_tabix INTO DATA(reserva).
          IF reserva-carrier_id <> voo-carrier_id
             OR reserva-connection_id <> voo-connection_id.
            EXIT.
          ENDIF.

          out->write( |Voo { reserva-carrier_id } { reserva-connection_id }: { reserva-flight_date }| ).
        ENDLOOP.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.

