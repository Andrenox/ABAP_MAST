CLASS zcl_fabap_jul2025_exer2_i_mast DEFINITION
                                     PUBLIC
                                     FINAL
                                     CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER2_I_MAST IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA t_funcionarios TYPE TABLE OF REF TO zcl_fabap_jul2025_exer02_mast.

    DATA(o_integral) = NEW zcl_fabap_jul2025_exer2_e_mast(
        i_nome        = 'Manuel Teixeira'
        i_id          = 'AL01'
        i_sal_base    = '9999.00'
        i_bonus       = '999.00' ).

    DATA(o_horista) = NEW zcl_fabap_jul2025_exe2_e2_mast(
        i_nome = 'Manuel Maria'
        i_id = 'AL02'
        i_sal_base = '99.99'
        i_horas = 40 * 4 ).


    APPEND o_integral TO t_funcionarios.
    APPEND o_horista TO t_funcionarios.


    LOOP AT t_funcionarios INTO DATA(o_funcionario).
      out->write( o_funcionario->exibir_dados( ) ).

      out->write( |Salário calculado: { o_funcionario->calcular_salario( ) }| ).

      out->write( '######################' ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
