#' Lê os dados das partes com base no xml
#'
#' @param xml Objecto xml_document, lido com xml2::read_xml.
#' @param polo "AT" para ativo, "PA" para passivo.
#'
#' @return tibble
#' @export
#'
mni_ler_partes_xml <- function(xml, polo = c("AT", "PA")){


  # if (!polo %in% c("AT","PA")){
  #
  #   stop("Você tem de informar um dos polos AT ou PA")
  # }

  purrr::map_dfr(polo, purrr::possibly(~{


  processo <-   xml |>
      xml2::xml_find_first("//ns2:dadosBasicos") |>
      xml2::xml_attr("numero")

  xpolo <- glue::glue('//ns2:polo[@polo="{.x}"]')

  y <-  xml |>
    xml2::xml_find_all(xpolo)


  ## Dados gerais das partes
  parte <- y |>
    xml2::xml_find_all(".//ns2:parte")

  assistencia_judiciaria <- crianca1(parte, "./@assistenciaJudiciaria")

  intimacao_pendente <- crianca1(parte, ".//ns2:parte/@intimacaoPendente")

  relacionamento_processual <-  crianca1(parte, ".//ns2:parte/@intimacaoPendente")

  ## Dados específicos das pessoas
  pessoa <- y |>
    xml2::xml_find_all(".//ns2:pessoa")


  nome <- pessoa |>
    crianca1(".//@nome")

  sexo <- pessoa |>
    crianca1(".//@sexo")

  numero_documento_principal <- pessoa |>
      crianca1(".//@numeroDocumentoPrincipal")

  tipo_pessoa <- pessoa |>
      crianca1(".//@tipoPessoa")

  ### Documentos das pessoas

  documento <- pessoa |>
       purrr::map(~{.x |>
       xml2::xml_find_all(".//ns2:documento")
       })

   if (length(documento)==0){

   codigo_documento <-  NA_character_
   emissor_documento <- NA_character_
   tipo_documento <-  NA_character_

   } else {

  codigo_documento <- documento |>
          crianca1(".//@codigoDocumento", F)

  emissor_documento <- documento |>
    crianca1(".//@emissorDocumento", F)

  tipo_documento <- documento |>
    crianca1(".//@tipoDocumento", F)

   }

  ## Endereço das pessoas
  endereco <- pessoa |>
    purrr::map(~{.x |>
        xml2::xml_find_all(".//ns2:endereco")
    })


  if (length(endereco)==0){

    endereco_cep <-  NA_character_
    endereco_logradouro <- NA_character_
    endereco_numero <-  NA_character_
    endereco_bairro <-  NA_character_
    endereco_cidade <-  NA_character_
    endereco_pais <-   NA_character_

  } else {

    endereco_cep  <- endereco |>
      crianca2(".//@cep", F)

    endereco_logradouro <- endereco |>
      crianca2(".//ns2:logradouro", F)

    endereco_numero <- endereco |>
      crianca2(".//ns2:numero", F)

    endereco_bairro <- endereco |>
      crianca2(".//ns2:bairro", F)

    endereco_cidade <- endereco |>
      crianca2(".//ns2:cidade", F)

    endereco_pais <- endereco |>
      crianca2(".//ns2:pais", F)

  }

 tibble::tibble(
         processo,
         polo = .x,
         assistencia_judiciaria,
         intimacao_pendente,
         relacionamento_processual,
         nome,
         sexo,
         numero_documento_principal,
         tipo_pessoa,
         codigo_documento,
         emissor_documento,
         tipo_documento,
         endereco_cep,
         endereco_logradouro,
         endereco_numero,
         endereco_bairro,
         endereco_cidade,
         endereco_pais
         )

  }, NULL))
}


crianca1 <- function(x, xchild, unlist = T){
z <- purrr::map(x, ~{
.x <- .x |>
xml2::xml_find_all(xchild) |>
xml2::xml_text()
.x[length(.x) == 0 ] <- NA_character_
.x
})
if (unlist){
z <- unlist(z)
}
z
}


crianca2 <- function(x, xchild, unlist = T){

  z <- purrr::map(x, ~{

    xx <- .x

    xxx <- xx |>
      purrr::map_chr(~{ ## Tem de dar duas voltas por conta do endereco
      .x <-  .x |>
      xml2::xml_find_all(xchild) |>
      xml2::xml_text()

      .x[length(.x) == 0 ] <- NA_character_
      .x
    })

    xxx[length(xxx) == 0 ] <- NA_character_

    xxx

  })

  if (unlist){
    z <- unlist(z)
  }
  z
}
