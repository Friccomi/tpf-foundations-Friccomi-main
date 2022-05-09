import csv
import psycopg2
import os

def conectar():
    
    conn = psycopg2.connect("host=db dbname=db_itba user=tp_itba password=itba")
    conn.autocommit=True
  
    return(conn)

def escribe(lst_archivos):
  armado='n'
  print("Conectando armado de tablas")
  while armado=='n':
    try:
      conn=conectar()

      cur = conn.cursor()
      cur.execute("set schema 'TP_ITBA'")

    #Me asuguro que se termino de crear las tablas 
      cur.execute('select * from banderas where bandera_id=1')
      result=cur.fetchone()
      number_of_rows=result[0]
      if number_of_rows>0:
                armado='s'
                print("bandera es 1")
    except psycopg2.DatabaseError as error:
              armado='n'        

  cur.execute("truncate table datos_csv_cereales_oil")
  
  print("Levantando csv")
  for archivo in lst_archivos:
      print("Levantando " + archivo) 
      with open(archivo, encoding='windows-1252') as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=',')
        line_count = 0  
        l=[]
        try:
            for row in csv_reader:
              if line_count != 0:   
                  l=row 
                  
                  cur.execute("insert into datos_csv_cereales_oil(sector_id ,sector_nombre, variable_id, actividad_producto_nombre, " +
                    "indicador, unidad_de_medida, fuente ,frecuencia_nombre, cobertura_nombre, alcance_tipo, alcance_id, alcance_nombre, " +
                  " indice_tiempo,valor) values(" +l[0] + ",'"+ l[1] + "',"+ l[2] + ",'"+ l[3] + "','"+ l[4] + "','"+ l[5] + "','"+ l[6] + 
                  "','"+ l[7] + "','"+ l[8] + "','"  + l[9] + "','"+ l[10] + "','"+ l[11] + "','" + l[12]  + "','"+ l[13] +  "')")          
              line_count += 1
            print(line_count) 
        except psycopg2.DatabaseError as error:
                print(error)   
                   
  print("Armando tablas")
  try:
        cur.execute('delete from productos')
        cur.execute('delete from sectores')
        cur.execute('insert into sectores select distinct  sector_id, upper(sector_nombre) from datos_csv_cereales_oil')

        cur.execute('delete from variables')
        cur.execute('insert into variables(actividad_producto_nombre) select distinct upper(actividad_producto_nombre) from datos_csv_cereales_oil')

        cur.execute('delete from tipos_indicadores')
        cur.execute('insert into tipos_indicadores (indicador_nombre) select distinct upper(indicador) from datos_csv_cereales_oil')

        cur.execute('delete from unidades_medida')
        cur.execute('insert into unidades_medida(medida_nombre) select distinct upper(unidad_de_medida) from datos_csv_cereales_oil')

        cur.execute('delete from tipos_fuentes')
        cur.execute('insert into tipos_fuentes(fuente_nombre) select distinct upper(fuente) from datos_csv_cereales_oil')

        cur.execute('delete from tipos_frecuencias')
        cur.execute('insert into tipos_frecuencias (frecuencia_nombre) select distinct upper(frecuencia_nombre) from  datos_csv_cereales_oil')

        cur.execute('delete from tipos_cobertura')
        cur.execute('insert into tipos_cobertura(cobertura_nombre) select distinct upper(cobertura_nombre) from datos_csv_cereales_oil')

        cur.execute('delete from tipos_alcances')
        cur.execute('insert into tipos_alcances(alcance_tipo_nombre) select distinct upper(alcance_tipo) from datos_csv_cereales_oil')

        cur.execute('delete from alcances')
        cur.execute('insert into alcances select distinct alcance_id, upper(alcance_nombre) from datos_csv_cereales_oil')    
   
        cur.execute("insert into productos "
              "select s.sector_id ,v.variable_id ,i.indicador_id,u.Medida_id, f.fuente_id, tf.frecuencia_id, tc.tipos_cobertura_id,"
              "ta.alcance_tipo_id, a.alcance_id,c.indice_tiempo,  "
              "CASE "
              "	WHEN c.valor = 'NA' THEN null "
              "	else to_number(c.valor,'99999999.99')"
              "	END "
              "  AS valor"
              " from datos_csv_cereales_oil as c , sectores as  s , variables as v , tipos_indicadores as i , unidades_medida as u ,"
              " tipos_fuentes as f, tipos_frecuencias as tf , tipos_cobertura as tc ,tipos_alcances as ta , alcances as a"
              " where  c.sector_id = s.sector_id "
              " and upper(c.actividad_producto_nombre) = v.actividad_producto_nombre"
              " and upper(c.indicador)= i.indicador_nombre"
              " and  upper(c.unidad_de_medida) = u.medida_nombre"
              " and upper(c.fuente)=f.fuente_nombre"
              " and upper(c.frecuencia_nombre)=  tf.frecuencia_nombre "
              " and upper(c.cobertura_nombre) = tc.cobertura_nombre"
              " and upper(c.alcance_tipo)=upper(ta.alcance_tipo_nombre)"
              " and c.alcance_id = a.alcance_id")
       
  except psycopg2.DatabaseError as error:
            print(error)   
  cur.execute("set schema 'TP_ITBA'")
  cur.execute("SELECT count(*) from productos")
  print(cur.fetchall())
  cur.execute("insert into banderas values(2,'Llenado de tablas')")
  cur.close
  conn.close

escribe(['oleaginosa.csv','maiz.csv','trigo.csv'])

