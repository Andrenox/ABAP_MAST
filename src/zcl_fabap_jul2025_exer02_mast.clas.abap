CLASS zcl_fabap_jul2025_exer02_mast DEFINITION
                                    PUBLIC
                                    CREATE PUBLIC .

  PUBLIC SECTION.

      METHODS CONSTRUCTOR

        IMPORTING

            i_nome          TYPE    string        DEFAULT ''
            i_id            TYPE    STRING        DEFAULT ''
            i_sal_base      TYPE    decfloat16    DEFAULT '0.00'.

      METHODS CALCULAR_SALARIO
        RETURNING VALUE(r_salario)          TYPE decfloat16.


      METHODS exibir_dados
        RETURNING VALUE(r_dados) TYPE string.


  PROTECTED SECTION.

    DATA gv_nome        TYPE string.
    DATA gv_id          TYPE STRING.
    DATA gv_sal_base    TYPE decfloat16.

  PRIVATE SECTION.

ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER02_MAST IMPLEMENTATION.


  METHOD calcular_salario.
    r_salario = gv_sal_base.
  ENDMETHOD.


  METHOD constructor.

    gv_nome     = i_nome.
    gv_id       = i_id.
    gv_sal_base = i_sal_base.

  ENDMETHOD.


METHOD exibir_dados.

  DATA(lv_dados) = |Nome: { gv_nome } \n | &&
                   |ID: { gv_id } \n | &&
                   |Salário Base: { gv_sal_base } \n |.

  RETURN lv_dados.

ENDMETHOD.
ENDCLASS.
