# Análise de Sucesso no Spotify (2023)

O objetivo deste trabalho é validar hipóteses sobre o que contribui para o sucesso de uma música em termos de número de streams no Spotify. A partir de um banco de dados com informações sobre as músicas mais ouvidas em 2023, busca-se identificar quais características estão associadas a um maior número de streams, como BPM, presença em playlists, comportamento em outras plataformas e características técnicas das músicas. A análise visa fornecer insights, permitindo que a gravadora tome decisões estratégicas no lançamento de um novo artista.


## Objetivo

Investigar cinco hipóteses sobre os fatores que influenciam a popularidade musical, considerando métricas como BPM, presença em playlists, desempenho em rankings das principais plataformas, volume de produção dos artistas e características sonoras das faixas.

## Tecnologias e Ambiente de Desenvolvimento

- **Linguagens**: Python, SQL (BigQuery), DAX (Power BI)
- **Bibliotecas Python**:  Pandas, NumPy, Matplotlib, Seaborn, SciPy, Statsmodels, Scikit-learn, Scikit-posthocs
- **Banco de Dados**: Plataforma em nuvem Google BigQuery, utilizada para armazenar, consultar e transformar os dados com SQL.
- **Visualização de Dados**: Power BI para construção de dashboards interativos, com uso complementar de Power Query e visualizações em Python integradas.
- **Ambiente de Desenvolvimento**: Google Colab, utilizado para análises estatísticas, testes de hipóteses e modelagem preditiva com bibliotecas Python.

## Estrutura
- `dados-primarios/`: Dados brutos fornecidos inicialmente para a análise
- `dataset/`: Arquivos processados e prontos para exploração
- `notebooks/`: Análises em Python no Google Colab
- `dashboards/`: Dashboard desenvolvido no Power BI com visualizações interativas (.pbix)
- `presentation/`: Apresentação final com os principais resultados (.pdf)
- `queries/`: Consultas SQL aplicadas no Google BigQuery

## Arquivos do Projeto

- [Notebook com testes estatísticos e modelo preditivo (Google Colab)](notebook/bruna_derner_colab_02.ipynb)
- [Dashboard Interativo (Power BI)](dashboard/bruna-derner-pbi.02.pbix)
- [Apresentação Final (PowerPoint)](presentation/bruna-derner-apres.02.pdf)
- [Códigos SQL usados no BigQuery](queries/bigquery_code_bruna_derner.sql)
- [Ficha Técnica](bruna-derner-fichatec.02.pdf)

## Metodologia

- **Integração:** Os dados foram carregados diretamente no BigQuery, onde foram unidos por comandos SQL.
- **Limpeza e Tratamento:** Valores nulos foram avaliados, alguns tratados (key: ausente) e outros foram removidos por não estar dentro do escopo da análise (coluna shazam). Foram removidas as duplicatas e os caracteres especiais dos nomes também.
- **Criação de Variáveis:** Foram criadas variáveis de data de lançamento, total de playlists (soma entre plataformas) e  streams, caracteristicas musicais e total de playlists foram categorizadas em quartis para analise segmentada.
- **Análise Exploratória:** Visualizações no Power BI permitiram identificar padrões, outliers e comportamentos anômalos. Foram geradas distribuições, estatísticas descritivas e histogramas para variáveis-chave.
- **Análise de Correlação:** Relações entre variáveis foram medidas com correlações de Pearson no BigQuery e Colab (Python).
- **Testes Estatísticos:** Aplicados testes estatísticos de Mann-Whitney U, Shapiro-Wilk, Kruskal-Wallis no Python.
- **Testes de Hipotéses:** Realizada utilizando regressão linear simples e múltiplas utilizando principalmente as bibliotecas statsmodels e sklearn.linear_model no Python.
- **Modelagem Preditiva:** Utilizei um modelo de regressão linear múltipla para avaliar simultaneamente o impacto das variáveis sobre os streams.
  
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
  
  ## 🎥 Vídeo Explicativo (Loom)

Assista à apresentação completa:

[![Assista ao vídeo no Loom](https://img.shields.io/badge/Ver%20Apresenta%C3%A7%C3%A3o-Loom-%23F9C646?style=for-the-badge&logo=loom)](https://www.loom.com/share/42758b82a01542b9b8e90f406d83ae2d?sid=5f74b90f-db71-4fb9-b8ee-781a95f8efd5)


## Autora

Bruna Derner  
Economista e Analista de Dados  
[LinkedIn](https://www.linkedin.com/in/bruna-derner/)  
