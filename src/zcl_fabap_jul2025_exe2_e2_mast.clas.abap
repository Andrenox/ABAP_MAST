CLASS zcl_fabap_jul2025_exe2_e2_mast DEFINITION
                                     INHERITING FROM ZCL_FABAP_JUL2025_EXER02_MAST
                                     PUBLIC
                                     FINAL
                                     CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor

        IMPORTING i_nome                   TYPE string         DEFAULT ''
                  i_id                     TYPE string         DEFAULT ''
                  i_sal_base               TYPE decfloat16     DEFAULT ''
                  i_horas                  TYPE i              DEFAULT ''.

    METHODS calcular_salario REDEFINITION.

  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA: gv_horas                         TYPE i.

ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXE2_E2_MAST IMPLEMENTATION.


  METHOD calcular_salario.

    r_salario = gv_sal_base * gv_horas.

  ENDMETHOD.


  METHOD constructor.

    super->constructor(
            i_nome = i_nome
            i_id = i_id
            i_sal_base = i_sal_base ).

    gv_horas = i_horas.

  ENDMETHOD.
ENDCLASS.
