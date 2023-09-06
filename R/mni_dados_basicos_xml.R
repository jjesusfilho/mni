#' Lê dados do xml
#'
#' @param xml Objeto xml lido com xml2::read_xml.
#'
#' @return tibble
#' @export
#'
mni_dados_basicos_xml <- function(xml){

  dados_basicos <- xml |>
    xml2::xml_find_first("//ns2:dadosBasicos")

  processo <-   dados_basicos |>
    xml2::xml_attr("numero")

  competencia <- dados_basicos |>
    xml2::xml_attr("competencia")

  classe_processual <- dados_basicos  |>
    xml2::xml_attr("classeProcessual")

  assunto <- dados_basicos  |>
    xml2::xml_attr("assunto")

  codigo_localidade <-  dados_basicos  |>
    xml2::xml_attr("codigoLocalidade")

  intervencao_mp <-  dados_basicos |>
    xml2::xml_attr("intervencaoMP")

  nivel_sigilo <- dados_basicos |>
    xml2::xml_attr("nivelSigilo")

  dt_ajuizamento <-  dados_basicos |>
    xml2::xml_attr("dataAjuizamento") |>
    lubridate::ymd_hms(tz = "America/Sao_Paulo")

  valor_da_causa <- dados_basicos |>
        xml2::xml_find_first(".//ns2:valorCausa") |>
        xml2::xml_text() |>
        as.numeric()

  orgao_julgador <- dados_basicos |>
                xml2::xml_find_first(".//ns2:orgaoJulgador")

  orgao_julgador_codigo <- orgao_julgador |>
              xml2::xml_attr("codigoOrgao")

  orgao_julgador_nome <- orgao_julgador |>
    xml2::xml_attr("nomeOrgao")

  orgao_julgador_instancia <- orgao_julgador |>
    xml2::xml_attr("instancia")

  orgao_julgador_municipio <- orgao_julgador |>
    xml2::xml_attr("codigoMunicipioIBGE")


  tibble::tibble(processo,
                 competencia,
                 classe_processual,
                 codigo_localidade,
                 intervencao_mp,
                 dt_ajuizamento,
                 valor_da_causa,
                 orgao_julgador_codigo,
                 orgao_julgador_nome,
                 orgao_julgador_instancia,
                 orgao_julgador_municipio
                 )
}
