#' Lê dados do xml
#'
#' @param xml Objeto xml lido com xml2::read_xml.
#'
#' @return tibble
#' @export
#'
mni_dados_basicos_xml <- function(xml){

  processo <-   xml |>
    xml2::xml_find_first("//ns2:dadosBasicos") |>
    xml2::xml_attr("numero")

  competencia <- xml |>
    xml2::xml_find_first("//ns2:dadosBasicos") |>
    xml2::xml_attr("competencia")

  classe_processual <- xml |>
    xml2::xml_find_first("//ns2:dadosBasicos") |>
    xml2::xml_attr("classeProcessual")

  codigo_localidade <-  xml |>
    xml2::xml_find_first("//ns2:dadosBasicos") |>
    xml2::xml_attr("codigoLocalidade")

  intervencao_mp <-  xml |>
    xml2::xml_find_first("//ns2:dadosBasicos") |>
    xml2::xml_attr("intervencaoMP")

  dt_ajuizamento <-  xml |>
    xml2::xml_find_first("//ns2:dadosBasicos") |>
    xml2::xml_attr("dataAjuizamento") |>
    lubridate::ymd_hms(tz = "America/Sao_Paulo")

  tibble::tibble(processo, competencia, classe_processual, codigo_localidade, intervencao_mp, dt_ajuizamento)
}
