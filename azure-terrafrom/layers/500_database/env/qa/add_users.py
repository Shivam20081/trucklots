####################################################################################
# Code description :-> This pytohn code used to create 2 user's in a azure
#                      sql database
# Python Requirements :-> pyodbc
# Arguments Required :-> Resource_group_name, SQL_Server_name, Database_name, 
#                       sql_root_username, password, username1,  password1, 
#                       username2, password2
#     NOTE :- ENTER THE REQUIRED ARGUMENT IN SAME SEQUENCE                  
####################################################################################


import os
import pyodbc
import sys

resource_group_name = sys.argv[1]
server_name = sys.argv[2]
server_url = f'{server_name}.database.windows.net'
server_username = sys.argv[3]
server_password = sys.argv[4]
database_name = sys.argv[5]
user1 = sys.argv[6]
password1 = sys.argv[7]
user2 = sys.argv[8]
password2 =sys.argv[9]

# Updating SQL server as public 
cmd = f"az sql server firewall-rule create -g {resource_group_name} -s {server_name} -n updating_users --start-ip-address 0.0.0.0 --end-ip-address 255.255.255.255"
output = os.popen(cmd).read()

print("SQL Server converted to Public !!!!!!\n", output) 

# Connecting to SQL server and creating 2 Users 
def connect_to_azure_sql_database(server_url, database_name, server_username, server_password, user1, password1, user2, password2):
    try:
        # Define the connection string
        connection_string = f"Driver={{ODBC Driver 17 for SQL Server}};Server={server_url};Database={database_name};UID={server_username};PWD={server_password};"
        
        # Establish the database connection
        connection = pyodbc.connect(connection_string)
        print("I am connected")

        # Create a cursor object to interact with the database
        cursor = connection.cursor()

        sql_command_app_user = f'''
                            CREATE USER {user1} WITH PASSWORD = '{password1}';
                            GRANT INSERT, UPDATE, SELECT TO {user1};
                            '''
        cursor.execute (sql_command_app_user)
        
        
        sql_command_team_user = f'''
                            CREATE USER {user2} WITH PASSWORD = '{password2}';
                            GRANT SELECT TO {user2};
                    '''
        cursor.execute(sql_command_team_user)

        connection.commit()
        # Close the cursor and connection
        cursor.close()
        connection.close()

        # Updating SQL server as Private
        cmd = f"az sql server firewall-rule delete -g {resource_group_name} -s {server_name} -n updating_users"
        output = os.popen(cmd).read()

        print("SQL Server converted to Private !!!!!!", output)

    except Exception as e:
        # Log the error to a file
        with open("error.log", "a") as error_file:
            error_file.write(f"Error: {str(e)}\n")
        sys.exit(1)
    sys.exit(0)  

if __name__ == "__main__":

    connect_to_azure_sql_database(server_url, database_name, server_username, server_password, user1, password1, user2, password2)



