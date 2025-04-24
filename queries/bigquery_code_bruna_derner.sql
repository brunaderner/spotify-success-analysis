#verificar os valores nulos da tabela track_techinical_info
SELECT 
 COUNT(*) AS total_linhas,
 COUNTIF(track_id IS NULL) AS nulos_track_id,
 COUNTIF(bpm IS NULL) AS nulos_bpm,
 COUNTIF('key'IS NULL) AS nulos_key,
 COUNTIF(mode IS NULL) AS nulos_mode,
 COUNTIF(`danceability_%` IS NULL) AS nulos_danceability,
 COUNTIF(`valence_%` IS NULL) AS nulos_valence,
 COUNTIF(`energy_%` IS NULL) AS nulos_energy,
 COUNTIF(`acousticness_%` IS NULL) AS nulos_acousticness,
 COUNTIF(`instrumentalness_%` IS NULL) AS nulos_instrumentalness,
 COUNTIF(`liveness_%` IS NULL) AS nulos_liveness,
 COUNTIF(`speechiness_%` IS NULL) AS nulos_speechiness,
FROM `projeto2-lab-456316.proj02.track_technical_info`

#verificar os valores nulos da tabela track_in_spotify

SELECT
  COUNT(*) AS total_linhas,
  COUNTIF(track_id IS NULL) AS nulos_track_id,
  COUNTIF(track_name IS NULL) AS nulos_track_name,
  COUNTIF(artist_s__name IS NULL) AS nulos_artist_s_name,
  COUNTIF(artist_count IS NULL) AS nulos_artist_count,
  COUNTIF(released_year IS NULL) AS nulos_released_year,
  COUNTIF(released_month IS NULL) AS nulos_released_month,
  COUNTIF(released_day IS NULL) AS nulos_released_day,
  COUNTIF(in_spotify_playlists IS NULL) AS nulos_playlists,
  COUNTIF(in_spotify_charts IS NULL) AS nulos_charts,
  COUNTIF(streams IS NULL) AS nulos_streams
FROM `projeto2-lab-456316.proj02.track_in_spotify`


#verificar os valores nulos da tabela track_in_competition

SELECT
COUNT(*) AS total_linhas,
  COUNTIF(track_id IS NULL) AS nulos_track_id,
  COUNTIF(in_apple_playlists IS NULL) AS nulos_in_apple_playlists,
  COUNTIF(in_apple_charts IS NULL) AS nulos_in_apple_charts,
  COUNTIF(in_deezer_playlists IS NULL) AS nulos_in_deezer_playlists,
  COUNTIF(in_deezer_charts IS NULL) AS nulos_in_deezer_charts,
  COUNTIF(in_shazam_charts IS NULL) AS nulos_in_shazam_charts
FROM `projeto2-lab-456316.proj02.track_in_competition1`

#identificar valores duplicados por id
SELECT 
  track_id,
  COUNT(*) AS ocorrencias
FROM `projeto2-lab-456316.proj02.track_in_spotify`
GROUP BY track_id
HAVING COUNT(*) > 1
ORDER BY ocorrencias DESC

SELECT 
  track_id,
  COUNT(*) AS ocorrencias
FROM `projeto2-lab-456316.proj02.track_in_competition1`
GROUP BY track_id
HAVING COUNT(*) > 1
ORDER BY ocorrencias DESC

SELECT 
  track_id,
  COUNT(*) AS ocorrencias
FROM `projeto2-lab-456316.proj02.track_technical_info`
GROUP BY track_id
HAVING COUNT(*) > 1
ORDER BY ocorrencias DESC

#musicas duplicadas 

SELECT 
  track_name,
  artist_s__name,
  COUNT(*) AS ocorrencias
FROM `projeto2-lab-456316.proj02.track_in_spotify`
GROUP BY 
  track_name,
  artist_s__name
HAVING COUNT(*) > 1
ORDER BY ocorrencias DESC

#buscando as duplicatas para visualização
SELECT s.*
FROM `projeto2-lab-456316.proj02.track_in_spotify` s
JOIN (
  SELECT track_name, artist_s__name
  FROM `projeto2-lab-456316.proj02.track_in_spotify`
  GROUP BY track_name, artist_s__name
  HAVING COUNT(*) > 1
) dup
ON s.track_name = dup.track_name
AND s.artist_s__name = dup.artist_s__name
ORDER BY s.track_name, s.artist_s__name

#selecionando as variaveis 
SELECT *
 EXCEPT (released_year, released_month, released_day)
FROM `projeto2-lab-456316.proj02.track_in_spotify`


SELECT *
 EXCEPT (in_shazam_charts)
FROM `projeto2-lab-456316.proj02.track_in_competition1`

#limpando os caracteres especiais
SELECT 
  track_name,
  REGEXP_REPLACE(track_name, r'[ï¿½]', '') AS track_name_limpo,
  artist_s__name,
  REGEXP_REPLACE(artist_s__name, r'[ï¿½]', '') AS artist_name_limpo
FROM `projeto2-lab-456316.proj02.track_in_spotify`

#substituindo esses valores na tabela track_in_spotify_limpa
CREATE OR REPLACE TABLE `projeto2-lab-456316.proj02.track_in_spotify_limpa` AS
SELECT 
  track_id,
IF(
  TRIM(REGEXP_REPLACE(artist_s__name, r'[ï¿½]', '')) = '',
  'Artista Desconhecido',
  REGEXP_REPLACE(artist_s__name, r'[ï¿½]', '')
) AS artist_name_limpo,
  IF(
  TRIM(REGEXP_REPLACE(track_name, r'[ï¿½]', '')) = '',
  'Musica Desconhecida',
  REGEXP_REPLACE(track_name, r'[ï¿½]', '')
) AS track_name_limpo,
 artist_count,
  in_spotify_playlists,
  in_spotify_charts,
  streams
FROM `projeto2-lab-456316.proj02.track_in_spotify`

#tirando o string da streams
CREATE OR REPLACE TABLE `projeto2-lab-456316.proj02.track_in_spotify_limpa` AS
SELECT 
  track_id,
  track_name,
  artist_s__name,
  artist_count,
  in_spotify_playlists,
  in_spotify_charts,
  IFNULL(SAFE_CAST(streams AS INT64), 0) AS streams
FROM `projeto2-lab-456316.proj02.track_in_spotify_limpa`

#criando a variavel de data
CREATE OR REPLACE TABLE `projeto2-lab-456316.proj02.track_in_spotify_limpa` AS
SELECT 
  limpa.track_id,
  limpa.track_name,            
  limpa.artist_s__name,       
  limpa.artist_count,
  limpa.in_spotify_playlists,
  limpa.in_spotify_charts,
  limpa.streams,
  CONCAT(
    CAST(orig.released_year AS STRING), '-',
    LPAD(CAST(orig.released_month AS STRING), 2, '0'), '-',
    LPAD(CAST(orig.released_day AS STRING), 2, '0')
  ) AS data_lancamento
FROM `projeto2-lab-456316.proj02.track_in_spotify_limpa` AS limpa
JOIN `projeto2-lab-456316.proj02.track_in_spotify` AS orig
ON limpa.track_id = orig.track_id

#criando variavel total_playlists
CREATE OR REPLACE TABLE `projeto2-lab-456316.proj02.track_in_spotify_limpa` AS
SELECT 
  s.track_id,
  s.track_name,
  s.artist_s__name,
  s.artist_count,
  s.in_spotify_playlists,
  s.in_spotify_charts,
  s.streams,
  s.data_lancamento,
  (s.in_spotify_playlists + c.in_apple_playlists + c.in_deezer_playlists) AS total_playlists
FROM `projeto2-lab-456316.proj02.track_in_spotify_limpa` AS s
JOIN `projeto2-lab-456316.proj02.track_in_competition1` AS c
ON s.track_id = c.track_id


#união das tabelas
##apenas informando os dados que quero manter
CREATE OR REPLACE TABLE `projeto2-lab-456316.proj02.track_spotify` AS
SELECT 
  s.track_id, 
  s.track_name_limpo AS `track_name`,
  s.artist_name_limpo AS `artist_name`,
  s.artist_count,
  s.in_spotify_playlists,
  s.in_spotify_charts,
  s.streams,
  CAST (s.data_lancamento AS DATE) AS `data_lancamento`,
  s.total_playlists,
  s.total_charts,

 #Dados competition
  c.in_apple_playlists,
  c.in_apple_charts,
  c.in_deezer_playlists,
  c.in_deezer_charts,

  #Dados tec
  t.bpm,
  IFNULL(t.key, 'Ausente') AS `key`,
  t.mode,
  t.`danceability_%` AS `danceability`, 
  t.`valence_%` AS `valence`, 
  t.`energy_%` AS `energy`, 
  t.`acousticness_%` AS `acousticness`, 
  t.`instrumentalness_%` AS `instrumentalness`, 
  t.`liveness_%` AS `liveness`, 
  t.`speechiness_%` AS `speechiness`,

FROM `projeto2-lab-456316.proj02.track_in_spotify_limpa` AS s
LEFT JOIN `projeto2-lab-456316.proj02.track_in_competition1` AS c
  ON s.track_id = c.track_id
LEFT JOIN `projeto2-lab-456316.proj02.track_technical_info` AS t
  ON s.track_id = t.track_id
  
  #testando correlação
  SELECT CORR(total_playlists, streams) AS correlacao FROM `projeto2-lab-456316`.`proj02`.`track_spotify` AS track_spotify;
WITH Quartiles AS (
  SELECT
  streams,
  ntile(4) over(order by streams) AS quartil_streams
  FROM `projeto2-lab-456316.proj02.track_spotify`
)
SELECT
a.*,
q.quartil_streams,
IF(q.quartil_streams=4, "alto", "baixo") AS classificacao
from `projeto2-lab-456316.proj02.track_spotify` a 

LEFT JOIN Quartiles q
ON a.streams = q.streams

#adicionando as colunas
ALTER TABLE `projeto2-lab-456316.proj02.track_spotify`
ADD COLUMN IF NOT EXISTS quartil_streams INT64;

ALTER TABLE `projeto2-lab-456316.proj02.track_spotify`
ADD COLUMN IF NOT EXISTS classificacao STRING;

#adicionando quartis as colunas 
CREATE OR REPLACE TABLE `projeto2-lab-456316.proj02.track_spotify` AS
SELECT
  a.track_id,
  a.track_name,
  a.artist_name,
  a.artist_count,
  a.in_spotify_playlists,
  a.in_spotify_charts,
  a.streams,
  a.data_lancamento,
  a.total_playlists,
  a.in_apple_playlists,
  a.in_apple_charts,
  a.in_deezer_playlists,
  a.in_deezer_charts,
  a.bpm,
  a.`key`,
  a.mode,
  a.danceability,
  a.valence,
  a.energy,
  a.acousticness,
  a.instrumentalness,
  a.liveness,
  a.speechiness,
  a.quartil_streams,
  a.classificacao_streams,
  a.quartil_bpm,
  a.classificacao_bpm,
  a.quartil_danceability,
  a.classificacao_danceability,
  a.quartil_valence,
  a.classificacao_valence,
  a.quartil_energy,
  a.classificacao_energy,
  a.quartil_acousticness,
  a.classificacao_acousticness,
  a.quartil_instrumentalness,
  a.classificacao_instrumentalness,
  a.quartil_liveness,
  a.classificacao_liveness,
  q_speechiness.quartil_speechiness,
  q_total_playlists.quartil_total_playlists,
 
  CASE 
    WHEN q_speechiness.quartil_speechiness = 4 THEN "alto"
    WHEN q_speechiness.quartil_speechiness = 3 THEN "medio"
    WHEN q_speechiness.quartil_speechiness = 2 THEN "medio"
    WHEN q_speechiness.quartil_speechiness = 1 THEN "baixo"
    ELSE NULL
  END AS classificacao_speechiness,

  CASE 
    WHEN q_total_playlists.quartil_total_playlists = 4 THEN "alto"
    WHEN q_total_playlists.quartil_total_playlists = 3 THEN "medio"
    WHEN q_total_playlists.quartil_total_playlists = 2 THEN "medio"
    WHEN q_total_playlists.quartil_total_playlists = 1 THEN "baixo"
    ELSE NULL
  END AS classificacao_total_playlists


FROM `projeto2-lab-456316.proj02.track_spotify` a
LEFT JOIN (
  SELECT track_id, ntile(4) OVER (ORDER BY speechiness) AS quartil_speechiness
  FROM `projeto2-lab-456316.proj02.track_spotify`
) q_speechiness ON a.track_id = q_speechiness.track_id
LEFT JOIN (
  SELECT track_id, ntile(4) OVER (ORDER BY total_playlists) AS quartil_total_playlists
  FROM `projeto2-lab-456316.proj02.track_spotify`
) q_total_playlists ON a.track_id = q_total_playlists.track_id;
  
  #fiz esse processo de 2 em 2 até terminar todas as variaveis que eu queria
  ttrabalhar estivessem listadas. essas são as duas ultimas.
 

#salvando arquivo em csv
select
*
from `projeto2-lab-456316.proj02.track_spotify`

