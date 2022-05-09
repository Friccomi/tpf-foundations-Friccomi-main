FROM python:3.8-slim-buster
WORKDIR /code
CMD pip install python3-pandas
#CMD pip install psycopg2-binary
#CMD pip3 install datapane
CMD [ "python3"]
