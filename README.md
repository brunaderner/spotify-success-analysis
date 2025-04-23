# Análise de Sucesso no Spotify (2023)

O objetivo deste trabalho é validar hipóteses sobre o que contribui para o sucesso de uma música em termos de número de streams no Spotify. A partir de um banco de dados com informações sobre as músicas mais ouvidas em 2023, busca-se identificar quais características estão associadas a um maior número de streams, como BPM, presença em playlists, comportamento em outras plataformas e características técnicas das músicas. A análise visa fornecer insights, permitindo que a gravadora tome decisões estratégicas no lançamento de um novo artista.


## Objetivo

Investigar cinco hipóteses sobre os fatores que influenciam a popularidade musical, considerando métricas como BPM, presença em playlists, desempenho em rankings das principais plataformas, volume de produção dos artistas e características sonoras das faixas.

## Tecnologias Utilizadas

- **BigQuery**: manipulação e limpeza de dados SQL
- **Google Colab (Python)**: análises estatísticas e modelagem preditiva
- **Power BI**: visualizações interativas
- 

## Estrutura

- `notebooks/`: análises em Python no Google Colab
- `dashboards/`: dashboard do Power BI (.pbix)
- `presentation/`: slides de apresentação final (.pptx)
- `queries/`: código SQL usado no BigQuery

## 📂 Arquivos do Projeto

- 📓 [Notebook com testes estatísticos e modelo preditivo (Google Colab)](notebooks/bruna_derner_colab_02.ipynb)
- 📊 [Dashboard Interativo (Power BI)](dashboards/bruna-derner-pbi.02.pbix)
- 🖥️ [Apresentação Final (PowerPoint)](presentation/bruna-derner-apres.02.pptx)
- 🧾 [Códigos SQL usados no BigQuery](queries/bigquery_code_bruna_derner.sql)

## Principais Resultados

- **Playlists são o principal impulsionador de streams:** A variável total_playlists apresentou a correlação mais alta com o número de streams (0.7842) e foi o preditor mais significativo no modelo de regressão, adicionando em média +47 mil streams por playlist em que a música aparece.

- **O sucesso se estende entre plataformas:** Músicas bem colocadas nos rankings da Deezer e Apple Music também tendem a se destacar no Spotify. A regressão múltipla com essas variáveis obteve R² = 0.4855, confirmando a influência positiva do desempenho multiplataforma.

- **O volume de produção impacta a audiência:** Artistas com mais músicas lançadas no Spotify tendem a acumular mais streams. A hipótese foi confirmada com R² = 0.6067.

- **Características técnicas da faixa têm influência limitada:** A maioria das métricas sonoras (como BPM, valence e energy) apresentou correlações fracas ou negativas. No modelo geral, apenas danceability e speechiness foram significativas (ambas negativamente), mas o modelo teve baixo poder explicativo (R² = 0.029).

- **BPM não tem relação com popularidade:** A hipótese de que músicas com BPM mais alto fariam mais sucesso foi refutada. A regressão retornou R² ≈ 0, indicando ausência de associação significativa.

 - **Modelo Preditivo final:** Com todas as variáveis combinadas, o modelo de regressão múltipla alcançou R² = 0.644.
   As variáveis com maior impacto positivo foram:
   - total_playlists (+47 mil streams)
   - in_apple_charts (+836 mil streams)
   - in_deezer_charts (+6.9 milhões de streams)
   - A variável energy, por outro lado, teve impacto negativo no desempenho.

## Autora

Bruna Derner  
Economista e Analista de Dados  
[LinkedIn](https://www.linkedin.com/in/bruna-derner/)  
