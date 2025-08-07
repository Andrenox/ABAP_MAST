*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
TYPES: BEGIN OF ty_voo_info,

             id_companhia TYPE /dmo/carrier_id,
             id_conexao   TYPE /dmo/connection_id,
             preco        TYPE /dmo/flight_price,
             distancia    TYPE /dmo/flight_distance,
           END OF ty_voo_info.
