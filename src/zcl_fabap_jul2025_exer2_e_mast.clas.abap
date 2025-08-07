CLASS zcl_fabap_jul2025_exer2_e_mast DEFINITION
                                     INHERITING FROM ZCL_FABAP_JUL2025_EXER02_MAST
                                     PUBLIC
                                     FINAL
                                     CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor

        IMPORTING i_nome                   TYPE string      DEFAULT ''
                  i_id                     TYPE string      DEFAULT ''
                  i_sal_base               TYPE decfloat16  DEFAULT ''
                  i_bonus                  TYPE decfloat16  DEFAULT ''.

    METHODS calcular_salario REDEFINITION.

  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA: gv_bonus                         TYPE decfloat16.

ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER2_E_MAST IMPLEMENTATION.


  METHOD calcular_salario.

    r_salario = gv_sal_base + gv_bonus.

  ENDMETHOD.


  METHOD constructor.

    super->constructor(
            i_nome = i_nome
            i_id = i_id
            i_sal_base = i_sal_base ).

    gv_bonus = i_bonus.

  ENDMETHOD.
ENDCLASS.
