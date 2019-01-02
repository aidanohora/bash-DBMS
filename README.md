# BashDBMS
A rudimentary Database Management System server built from bash scripts that can be accessed by multiple clients simultaneously.

To use:
1. Download the files to a folder somewhere on your computer.
2. Open multiple bash command terminals (at least 2) and navigate to the folder containing the files in each.
3. On one terminal, enter "./server.sh" to run the server (or "./server.sh &" to run the server in the background.
4. On another terminal (or the same one if you ran the server in the background), start a client and connect it to the server by
entering the command "./client.sh id" where id is a unique identifier of your choosing for that client.
5. After starting a client, enter the "req command commandarguements" where command and commandarguments can be:
	a) create_database db_name
		-->Used to create database/folder in the same folder as the create_database.sh script, where "db_name" is the database name
	b) create_table db_name table_name column1_header,column2_header,...,columnN_header
		-->Create a table in an existing database, where "db_name" is the name of the database and "table_name" is the table name the third arguement
			contains headers for the table's columns seperated by ","
	c) insert db_name table_name tuple_cell_1,tuple_cell_2,...,tuplecell_N
		--> Inserts a tuple containing N cells to an existing table, where "table_name" is the table name, "db_name" is it's directory and the third arguement
			contains cells seperated by "," to be inserted
	d) select name_of_database name_of_table name_of_column_to_show,a_second_column_name_to_show,...name_of_column_N_to_show
		--> Shows any number of columns from a table, where "table_name" is the table name, "db_name" is it's directory and the third arugment contains the
			headers of the columns to show seperated by "," (case-insensitive). If no third arguement is included, it defaults to showing all columns
		-->If you'd prefer to select by column number rather than name, enter 'selectbynumber' instead of 'select' and use numbers interspaced by "," as the last arguement, e.g. 3,1.
6. To safetly exit from the client or shutdown the server, you can use CTRL+C or enter "exit" into the client. If you ran the server in the background, enter "fg".
to bring it to the foreground before shutting it down with CTRL+C. A client can remotely shut down the server with the command "shutdown" and the single arguement "a37hf".

Made on a Windows PC using the Ubuntu 18.04 app downloaded from the microsoft store.
