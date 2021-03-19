import time
import psycopg2

def pgsql_select(request, user, password, port, host, database):
    """selecte data in the pgsql table"""
    with psycopg2.connect(
            user=user,
            host=host,
            port=port,
            password=password,
            database=database,
    ) as connect:
        cursor = connect.cursor()
        if request.startswith('SELECT'):
            cursor.execute(request)
            response = cursor.fetchall()
            time.sleep(1)
            return response

def pgsql_del(request, user, password, port, host, database):
    """delete data in the pgsql table"""
    with psycopg2.connect(
            user=user,
            host=host,
            port=port,
            password=password,
            database=database,
    ) as connect:
        cursor = connect.cursor()
        if request.startswith('DELETE'):
          cursor.execute(request)
          connect.commit()
          time.sleep(1)
          return True
        else:
            return False

def pgsql_update(request, user, password, port, host, database):
    """update data in the pgsql table"""
    with psycopg2.connect(
            user=user,
            host=host,
            port=port,
            password=password,
            database=database,
    ) as connect:
        cursor = connect.cursor()
        if request.startswith('UPDATE'):
            cursor.execute(request)
            connect.commit()
            time.sleep(0.2)
            return cursor.rowcount
        else:
            return False
