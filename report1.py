import pandas as pd
import altair as alt
import psycopg2
import datapane as dp 

def conectar():
     
    lleno='n'
    while lleno=='n':
     try:    
       with psycopg2.connect("host=db dbname=db_itba user=tp_itba password=itba") as conn:
        conn.autocommit=True
        cur = conn.cursor()
        cur.execute("set schema 'TP_ITBA'")
        cur.execute('select count(*) from banderas where bandera_id=2')
        result=cur.fetchone()
        number_of_rows=result[0]
        if number_of_rows>0:
                lleno='s'
                print("bandera es 2")
                return(conn)
     except psycopg2.DatabaseError as error:
              lleno='n'
   
def corre():
    conn=conectar()
    cur = conn.cursor()
    cur.execute("set schema 'TP_ITBA'")
    
    top_10_tracks_query = '''
    select i.Indicador_nombre as indicador, extract(year from c.indice_tiempo) as anio ,sum(c.valor) as valor
     from productos as c, sectores as s, variables as v, tipos_indicadores as i, unidades_medida as u,
     tipos_fuentes as f, tipos_frecuencias as tf, tipos_cobertura tc,tipos_alcances as ta, alcances as a
     where  c.sector_id = s.sector_id 
     and  c.variable_id = v.variable_id
     and c.indicador_id = i.indicador_id
     and c.Medida_id = u.Medida_id
     and c.fuente_id = f.fuente_id
     and c.frecuencia_id = tf.frecuencia_id
     and c.Tipo_cobertura_id = tc.tipos_cobertura_id
     and c.alcance_tipo_id = ta.alcance_tipo_id
     and c.alcance_id = a.alcance_id
     and c.sector_id=29 and c.variable_id=17 and i.indicador_id in(10,1)
     group by  i.Indicador_nombre, extract(year from c.indice_tiempo)
     '''
    
    top2 ='''
    select  cast(se.anio as int) as anio,  se.indicador ,se.valor,  co.Indicador, co.valor from (
      select i.Indicador_nombre as indicador, extract(year from c.indice_tiempo) as anio ,sum(c.valor) as valor
        from productos as c, sectores as s, variables as v, tipos_indicadores as i, unidades_medida as u,
        tipos_fuentes as f, tipos_frecuencias as tf, tipos_cobertura tc,tipos_alcances as ta, alcances as a
        where  c.sector_id = s.sector_id 
        and  c.variable_id = v.variable_id
        and c.indicador_id = i.indicador_id
        and c.Medida_id = u.Medida_id
        and c.fuente_id = f.fuente_id
        and c.frecuencia_id = tf.frecuencia_id
        and c.Tipo_cobertura_id = tc.tipos_cobertura_id
        and c.alcance_tipo_id = ta.alcance_tipo_id
        and c.alcance_id = a.alcance_id
        and c.sector_id=29 and c.variable_id=17 and i.indicador_id =10
        group by  i.Indicador_nombre, extract(year from c.indice_tiempo)) as se,
        (select  i.Indicador_nombre as indicador, extract(year from c.indice_tiempo) as anio ,sum(c.valor) as valor
        from productos as c, sectores as s, variables as v, tipos_indicadores as i, unidades_medida as u,
        tipos_fuentes as f, tipos_frecuencias as tf, tipos_cobertura tc,tipos_alcances as ta, alcances as a
        where  c.sector_id = s.sector_id 
        and  c.variable_id = v.variable_id
        and c.indicador_id = i.indicador_id
        and c.Medida_id = u.Medida_id
        and c.fuente_id = f.fuente_id
        and c.frecuencia_id = tf.frecuencia_id
        and c.Tipo_cobertura_id = tc.tipos_cobertura_id
        and c.alcance_tipo_id = ta.alcance_tipo_id
        and c.alcance_id = a.alcance_id
        and c.sector_id=29 and c.variable_id=17 and i.indicador_id=1
        group by i.indicador_id, i.Indicador_nombre, extract(year from c.indice_tiempo)
        ) as co where co.anio=se.anio order by se.anio
     '''

    df = pd.read_sql(top_10_tracks_query,conn)
    df2 =pd.read_sql(top2,conn)
   
    df_plot=alt.Chart(df).mark_line().encode(
      x='anio:N',
      y='valor:Q',
      color='indicador:N',
      tooltip='valor:Q' )

    report = dp.Report(
    "## Soja Sembrada vs Cosechada",
        dp.Plot(df_plot, caption="Areas cosechadas vs Areas Sembradas (Ha)"),
        dp.Table(df2, caption="Valores")
    )
    report.save("/code/report1.html", open=True)

corre()
