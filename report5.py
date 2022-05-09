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
     select  i.indicador_nombre as indicador,
            concat(extract(year from indice_tiempo),'/',lpad(cast (extract(MONTH from indice_tiempo) as varchar),2,'0'))as periodo,
            c.valor as valor,  
             concat(i.indicador_nombre, ' ', extract(year from indice_tiempo),'/',lpad(cast (extract(MONTH from indice_tiempo) as varchar),2,'0'),' U$S/tn ', valor) as tooltip
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
        and c.sector_id=29 and c.variable_id=18 and c.indicador_id in(13,11,20) and indice_tiempo>'2000/01/01'
     '''
    
    top2 ='''
    select  pr.periodo, pr.indicador_nombre as indicador, pr.valor, ac.indicador_nombre as indicador, ac.valor,ab.indicador_nombre as indicador, ab.valor,pr.Unidad
        from (select i.indicador_nombre,indice_tiempo as periodo,   u.medida_nombre as Unidad, c.valor
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
        and c.sector_id=29 and c.variable_id=18 and c.indicador_id =13) as pr,
        (select  i.indicador_nombre,indice_tiempo as periodo,   u.medida_nombre as Unidad, c.valor
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
        and c.sector_id=29 and c.variable_id=18 and c.indicador_id =11) as ac,
        (select  i.indicador_nombre,indice_tiempo as periodo,   u.medida_nombre as Unidad, c.valor
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
        and c.sector_id=29 and c.variable_id=18 and c.indicador_id =20) as ab
        where ac.periodo=pr.periodo  and ac.periodo=ab.periodo 
        order by ac.periodo desc
     '''

    df = pd.read_sql(top_10_tracks_query,conn)
    df2 =pd.read_sql(top2,conn)
    
    df_plot=alt.Chart(df).mark_line().encode(
      x='periodo:N',
      y='valor:Q',
      color='indicador:N',
      tooltip='tooltip:N' )

    report = dp.Report(
    "## Precios Aceite Soja ",
        dp.Plot(df_plot, caption="Precio Aceite de Soja"),
        dp.Table(df2, caption="Valores")
    )
    report.save("report5.html", open=True)

corre()