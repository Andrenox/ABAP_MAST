CLASS zcl_fabap_jul2025_exe1_e_mast DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXE1_E_MAST IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Variáveis
    DATA o_prod TYPE REF TO zcl_fabap_jul2025_exer01_mast.
    DATA v_valor TYPE decfloat16.

* Instanciar produto
    o_prod = NEW zcl_fabap_jul2025_exer01_mast(
                i_cod_produto  = '001'
                i_nome_produto = 'Pão'
                i_preco        = '0.20' ).

* Mostrar dados iniciais
    out->write( 'Código do produto: ' ).
    out->write( o_prod->get_codigo_produto( ) ).
    out->write( 'Nome do produto: ' ).
    out->write( o_prod->get_nome_produto( ) ).
    out->write( 'Preço do produto: ' ).
    out->write( o_prod->get_preco( ) ).
    out->write( 'Stock atual: ' ).
    out->write( o_prod->get_qtd_stock( ) ).

* Adicionar stock
    o_prod->adicionar_stock( EXPORTING i_qtd_adicionar = 300 ).

    out->write( 'Stock após adicionar: ' ).
    out->write( o_prod->get_qtd_stock( ) ).

* Calcular valor total em stock
    v_valor = o_prod->calculo_stock( ).
    out->write( 'Valor total em stock: ' ).
    out->write( v_valor ).

* Remover stock válido
    CALL METHOD o_prod->remover_stock
        EXPORTING
            i_qtd_remover = 50.

    out->write( 'Remoção de 50 unidades realizada.' ).
    out->write( 'Stock atual: ' ).
    out->write( o_prod->get_qtd_stock( ) ).

* Tentar remover stock inválido (maior que o disponível)
    CALL METHOD o_prod->remover_stock
      EXPORTING
        i_qtd_remover = 500
      EXCEPTIONS
        ex_qtd_removida_error = 1
        OTHERS                = 2.

    IF sy-subrc = 0.
      out->write( 'Quantidade removida com sucesso!' ).
    ELSE.
      out->write( 'Erro a remover, quantidade inválida' ).
      RETURN.
    ENDIF.

    out->write( 'Tentativa de remover 500 unidades.' ).
    out->write( 'Stock atual: ' ).
    out->write( o_prod->get_qtd_stock( ) ).

  ENDMETHOD.
ENDCLASS.
