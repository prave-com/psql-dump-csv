# psql-dump-csv

A simple script to dump all tables from a PostgreSQL database into CSV files
using `psql`. This repository contains a batch script for Windows that
automates the process of exporting each table to a separate CSV file.

## Prerequisites

- PostgreSQL client tools (including `psql`) installed on your system.
- Access to a PostgreSQL database.
- Basic understanding of command-line operations.

## Script Overview

The provided script is a Windows batch file (`.bat`) that:

1. Prompts for PostgreSQL database connection details.
2. Fetches a list of tables from the `public` schema.
3. Exports each table to a CSV file in the current directory.

## Getting Started

### Clone the Repository

```bash
git clone https://github.com/prave-com/psql-dump-csv
cd psql-dump-csv
```

### Usage

1. Open Command Prompt: Navigate to the directory where the script is located.
2. Run the Script: Execute the script by typing:
   ```bash
   dump.bat
   ```
3. Provide Connection Details: You will be prompted to enter the following
   database connection details:
   - Database Name: The name of the database you want to dump.
   - Username: Your PostgreSQL username.
   - Password: Your PostgreSQL password.
   - Host: The hostname of your PostgreSQL server (default is `localhost`).
   - Port: The port on which PostgreSQL is listening (default is `5432`).
   - SSL Mode: SSL mode for the connection. Options are `disable`, `require`,
     `verify-ca`, `verify-full` (default is `prefer`).
4. Check Output: The script will export each table to a CSV file in the current
   directory. The CSV files will be named in the format:
   `database_name_table_name.csv`.

## Example

```
Enter database name: mydatabase
Enter username: myuser
Enter password: mypassword
Enter host (default is localhost): localhost
Enter port (default is 5432): 5432
Enter SSL mode (default is prefer) [options: disable, require, verify-ca, verify-full]: require
```

After running the script, you will find CSV files for each table in the current
directory, e.g., `mydatabase_table1.csv`, `mydatabase_table2.csv`, etc.

## Script Details

### Script File

The script file is named `dump.bat`. It uses the following environment
variables:

- `DB_NAME`: Database name.
- `DB_USER`: Username.
- `DB_PASS`: Password.
- `DB_HOST`: Hostname (default: localhost).
- `DB_PORT`: Port (default: 5432).
- `SSL_MODE`: SSL mode for connection (default: prefer).
- `OUTPUT_DIR`: Directory where CSV files will be saved which is current
  directory.

### Key Operations

- Fetching Table List: Retrieves a list of tables from the `public` schema.
- Exporting Tables: Uses the `\COPY` command to export each table to a CSV
  file.

## Contributing

Feel free to open issues or submit pull requests if you have improvements or
bug fixes.
