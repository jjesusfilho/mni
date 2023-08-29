
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mni

<!-- badges: start -->

[![R-CMD-check](https://github.com/jjesusfilho/mni/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jjesusfilho/mni/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

Implementa o Modelo Nacional de Interoperabilidade (MNI) no R.

## Instalação

Para instalar o pacote em desenvolvimento:

``` r
remotes::install_github("jjesusfilho/tjsp")
```

## Quem pode usar o MNI:

Para usar o MNI, você deve estar devidamente autorizado pelo respectivo
tribunal, com senha e usuário. Esta solução não usa tokens.

## Exemplo

Para baixar o xml dos dados básicos de São Paulo:

``` r
library(mni)
dir.create("mni")
mni_consultar_processo(processo = "10057833820228260663", diretorio = "mni")
```
