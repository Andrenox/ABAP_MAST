CLASS zcl_fabap_jul2025_exer01_mast DEFINITION
                                    PUBLIC
                                    FINAL
                                    CREATE PUBLIC .

  PUBLIC SECTION.


    METHODS CONSTRUCTOR

    IMPORTING

        i_cod_produto     TYPE    string        DEFAULT ''
        i_nome_produto    TYPE    string        DEFAULT ''
        i_preco           TYPE    decfloat16    DEFAULT '0.00'.

    METHODS adicionar_stock
        IMPORTING i_qtd_adicionar               TYPE i.
*        EXCEPTIONS ex_qtd_adicionada_error.

    METHODS remover_stock
        IMPORTING i_qtd_remover                     TYPE i
        EXCEPTIONS ex_qtd_removida_error.

    METHODS calculo_stock
        RETURNING VALUE(r_valor_total_atual)         TYPE decfloat16.

* Getters

    METHODS GET_CODIGO_PRODUTO
        RETURNING VALUE(r_cod_produto)              TYPE string.

    METHODS GET_NOME_PRODUTO
        RETURNING VALUE(r_nome_produto)             TYPE string.

    METHODS GET_PRECO
        RETURNING VALUE(r_preco)                    TYPE decfloat16.

    METHODS GET_QTD_STOCK
        RETURNING VALUE(r_qtd_stock)                TYPE i.


  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA  gv_cod_produto        TYPE string.
    DATA  gv_nome_produto       TYPE string.
    DATA  gv_preco              TYPE decfloat16.
    DATA  gv_qtd_stock          TYPE i.


ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER01_MAST IMPLEMENTATION.


  METHOD adicionar_stock.

    gv_qtd_stock += i_qtd_adicionar.

  ENDMETHOD.


  METHOD calculo_stock.
    r_valor_total_atual = gv_preco * gv_qtd_stock.

  ENDMETHOD.


  METHOD constructor.

    gv_cod_produto      = i_cod_produto.
    gv_nome_produto     = i_nome_produto.
    gv_preco            = i_preco.
    gv_qtd_stock        = 0.

  ENDMETHOD.


  METHOD GET_codigo_produto.
    r_cod_produto = gv_cod_produto.
  ENDMETHOD.


  METHOD GET_nome_produto.
    r_nome_produto = gv_nome_produto.
  ENDMETHOD.


  METHOD GET_preco.
    r_preco = gv_preco.
  ENDMETHOD.


  METHOD GET_qtd_stock.
    r_qtd_stock = gv_qtd_stock.
  ENDMETHOD.


  METHOD remover_stock.

    IF i_qtd_remover <= gv_qtd_stock.

          gv_qtd_stock -= i_qtd_remover.

        ELSE.

          "O valor & é maior que o stock & disponivel
          MESSAGE s002(ZFABAP_JUL2025_MAST) WITH i_qtd_remover
                                                 gv_qtd_stock
          DISPLAY LIKE 'E'
            RAISING ex_qtd_removida_error.

        ENDIF.

  ENDMETHOD.
ENDCLASS.
