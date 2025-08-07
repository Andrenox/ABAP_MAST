@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Exercício 01 - MAST'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_FABAP_EXER01_MAST as select from /dmo/flight  as Flight
    inner join   /dmo/carrier as Carrier 
                              on Carrier.carrier_id = Flight.carrier_id
{

  key Flight.carrier_id                                 as CarrierId,
  key Flight.connection_id                              as ConnectionId,
  key Flight.flight_date                                as FlightDate,
      Carrier.name                                      as CarrierName,
      Flight.seats_max                                  as SeatsMax,
      Flight.seats_occupied                             as SeatsOccupied,
      
      concat( cast ( cast( ( Flight.seats_occupied / Flight.seats_max ) * 100 
               as abap.dec( 8, 2 ) ) 
               as abap.char( 20 ) ), '%' ) 
               as OccupancyRate
}


//Exercício 1 – CDS Views
//
//Crie uma CDS View que combine dados de voos (/DMO/FLIGHT) com nomes de companhias aéreas (/DMO/CARRIER) usando um INNER JOIN. Utilize os campos:
//
//carrier_id,
//connection_id,
//flight_date (campos chave),
//seats_max,
//seats_occupied da tabela /DMO/FLIGHT
//e o campo name da tabela /DMO/CARRIER.
//Adicione um campo que calcule a porcentagem de assentos ocupados, utilizando CAST() para conversão de tipo para DEC 8,2. Se conseguir, concatene o sinal de % no final.
//
//Dica: Utilize as funções CONCAT e CAST.
