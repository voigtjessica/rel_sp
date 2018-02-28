#Obras que faltam em SP
#Pedidos - IDs recebidos

library(dplyr)
library(googlesheets)

`%notin%` = function(x,y) !(x %in% y)

obras <- read.csv(url("http://simec.mec.gov.br/painelObras/download.php"), sep=";")


filtro_google_tipodeprojeto <- c("Espaço Educativo - 12 Salas",
                                 "Espaço Educativo - 01 Sala",
                                 "Espaço Educativo - 02 Salas",
                                 "Espaço Educativo - 04 Salas",
                                 "Espaço Educativo - 06 Salas",
                                 "Projeto 1 Convencional",
                                 "Projeto 2 Convencional")  


filtro_google_situacao <- c("Inacabada",
                            "Planejamento pelo proponente",
                            "Execução",
                            "Paralisada",
                            "Contratação",
                            "Licitação",
                            "Em Reformulação")

filtro_not_work <- c("Ampliação",
                     "Espaço Educativo Ensino Médio Profissionalizante",
                     "Reforma",
                     "QUADRA ESCOLAR COBERTA COM PALCO- PROJETO FNDE",
                     "QUADRA ESCOLAR COBERTA COM VESTIÁRIO- PROJETO FNDE",
                     "QUADRA ESCOLAR COBERTA - PROJETO PRÓPRIO",
                     "COBERTURA DE QUADRA ESCOLAR PEQUENA - PROJETO FNDE",
                     "COBERTURA DE QUADRA ESCOLAR GRANDE - PROJETO FNDE",
                     "COBERTURA DE QUADRA ESCOLAR - PROJETO PRÓPRIO")

#substituir X e Y por Município e UF desejados:

obras_pedido <- obras %>%
  filter(Tipo.do.Projeto %notin% filtro_google_tipodeprojeto,
         Situação %in% filtro_google_situacao,
         Tipo.do.Projeto %notin% filtro_not_work,
         Rede.de.Ensino.Público == "Municipal",
         Município == "São Paulo", UF == "SP")


url_pedidos <- "https://docs.google.com/spreadsheets/d/1Nf4-sGbDE71jcnpGgcJCwkg1hj4PlENeryAycDFlCec/edit?usp=sharing"

#Autenticação:
gs_ls() 

#Importando:
pedidos_sheet <- gs_title("sp")

#Atribuindo o df a um objeto:
pedidos_situation <- pedidos_sheet %>%
  gs_read()

sp_situation <- obras %>%
  inner_join(pedidos_situation, by = "ID") %>%
  select(ID)
, 
         Nome, 
         Situação, 
         Termo.Convênio, Fim.da.Vigência.Termo.Convênio,
         Situação.do.Termo.Convênio, Percentual.de.Execução,
         Data.Prevista.de.Conclusão.da.Obra, Data.de.Assinatura.do.Contrato,
         Prazo.de.Vigência, Data.de.Término.do.Contrato, Valor.do.Contrato,
         Data.da.Última.Vistoria.do.Estado.ou.Município, Resposta prefeitura,
         status_segundo_pedido)

