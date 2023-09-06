#' Lê os arquivos como xml
#'
#' @param arquivos Vetor de arquivos
#' @param diretorio Alternativamente, informar o diretório.
#'
#' @return xml
#' @export
#'
mni_ler_xml <- function(arquivos = NULL, diretorio = "."){

  if (is.null(arquivos)){

    arquivos <- list.files(diretorio , full.names = T, pattern = "xml$")

  }

  purrr::map(arquivos, read_xml)

}
