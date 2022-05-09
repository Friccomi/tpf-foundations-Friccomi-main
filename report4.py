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
     select v.actividad_producto_nombre,u.medida_nombre, 
            extract(year from indice_tiempo) as periodo,sum(c.valor) as valor
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
        and c.indicador_id=16
           and ((c.sector_id=41 and c.variable_id=13 ) or (c.sector_id=29 and c.variable_id=17 )
                or (c.sector_id=37 and c.variable_id=11) or (c.sector_id=29 and c.variable_id=4 ))
        group by   v.actividad_producto_nombre, u.medida_nombre, extract(year from indice_tiempo)
     '''
    
    top2 ='''
    select cast(ac.periodo as int) as periodo,   ac.valor as soja,  pr.valor as maiz,
          ab.valor as trigo,  ad.valor as girasol, ac.medida_nombre as Unidad
        from (select v.actividad_producto_nombre,u.medida_nombre, 
            extract(year from indice_tiempo) as periodo,sum(c.valor) as valor
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
        and c.indicador_id=16 and c.sector_id=41 and c.variable_id=13
        group by   v.actividad_producto_nombre, u.medida_nombre, extract(year from indice_tiempo)) as pr,
        (select v.actividad_producto_nombre,u.medida_nombre, 
            extract(year from indice_tiempo) as periodo,sum(c.valor) as valor
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
        and c.indicador_id=16 and c.sector_id=29 and c.variable_id=17 
        group by   v.actividad_producto_nombre, u.medida_nombre, extract(year from indice_tiempo)) as ac,
        (select v.actividad_producto_nombre,u.medida_nombre, 
            extract(year from indice_tiempo) as periodo,sum(c.valor) as valor
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
        and c.indicador_id=16  and c.sector_id=37 and c.variable_id=11
           group by   v.actividad_producto_nombre, u.medida_nombre, extract(year from indice_tiempo)) as ab,
        (select v.actividad_producto_nombre,u.medida_nombre, 
            extract(year from indice_tiempo) as periodo,sum(c.valor) as valor
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
        and c.indicador_id=16 and c.sector_id=29 and c.variable_id=4 
        group by   v.actividad_producto_nombre, u.medida_nombre, extract(year from indice_tiempo))  as  ad
        where ac.periodo=pr.periodo  and ac.periodo=ab.periodo and ac.periodo=ad.periodo
        order by ac.periodo desc
     '''

    df = pd.read_sql(top_10_tracks_query,conn)
    df2 =pd.read_sql(top2,conn)
    df_plot=alt.Chart(df).mark_area().encode(
      x='periodo:N',
      y='valor:Q',
      color='actividad_producto_nombre:N',
      tooltip='valor:Q' )

    report = dp.Report(
    "## Toneladas de Soja, Maiz, Trigo y Girasol (tn)",
        dp.Plot(df_plot, caption="Toneladas Soja, Maiz, Trigo y Girasol (tn)"),
        dp.Table(df2, caption="Hectareas")
    )    
    report.save("report4.html", open=True)

corre()