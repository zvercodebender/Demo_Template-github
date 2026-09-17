# 👋 Welcome to Liquibase!
Liquibase Secure is database change management made easy. This repository contains configuration files used during an evaluation of Liquibase Secure.

# 🔧 Pre-POC Steps
1. Create a database for the POC.

**Note!** A dedicated database is recommended to avoid interference with ongoing development.

2. Create a Liquibase service account in the database with suitable privileges to perform CRUD operations on all objects.
3. Download & Install Liquibase Secure on a Windows, Mac, or Linux workstation: https://www.liquibase.com/download-secure
4. Unzip the file provided by your Liquibase Sales Engineer into a folder on the workstation (e.g., C:\Liquibase\POC). 

**Note!** Do NOT use spaces in the path.

5. Rename liquibase.properties.template to liquibase.properties

6. Edit the liquibase.properties file and modify these key/value pairs:<br>

|Key|Value
|----------|------------|
| url | JDBC url for database created in step 1
| username | Service account name from step 2
| password | Service account password from step 2
| liquibase.searchPath | The folder where the zip file was extracted (step 4). Use forward slashes ("/") on all platforms, including Windows.
| licenseKey | Liquibase trial key

**Note!** The liquibase.properties file is only used for testing connectivity and should not be included in a repository.

7. From the POC folder execute `liquibase connect`. If successful, you should see something similar to this:
```
Starting Liquibase Secure at 07:58:45 using Java 21.0.10 (version 5.1.1 #59 built at 2026-03-26 15:14:01 UTC)
Liquibase Secure Version: 5.1.1
Liquibase Secure license issued to Liquibase_SA, valid until Wed Dec 30 17:00:00 MST 2026
Success: The database '(Microsoft SQL Server 12.00.9114)' at url 'jdbc:sqlserver://jbdemo.database.windows.net:1433;database=AdventureWorks2019;encrypt=true;trustServerCertificate=true;loginTimeout=30;' is accessible with the supplied credentials.
Liquibase command 'connect' was executed successfully.
```

**Note!** The above output will vary depending on the specific database used.

# ✋ Stop Here
Once these steps are complete your Liquibase Sales Engineer will assist you in validating all your specific use cases.

# 📚 Additional Resources
The following is provided for reference. No action required.

### 📒 Liquibase Documentation
* [Documentation Home](https://docs.liquibase.com/home.html)
* [Liquibase University](https://learn.liquibase.com/)

### ❓ Helpful Commands
|Command |Description|Documentation
|----------|------------|------------|
| connect | Test database connection | [Link](https://docs.liquibase.com/reference-guide/database-inspection-change-tracking-and-utility-commands/connect)
| flow | Execute a Liquibase workflow (sample included) | [Link](https://docs.liquibase.com/secure/user-guide-5-0/what-is-a-flow-file)
| status | Show undeployed changes | [Link](https://docs.liquibase.com/reference-guide/database-inspection-change-tracking-and-utility-commands/status)
| update | Run changes against target database | [Link](https://docs.liquibase.com/reference-guide/init-update-and-rollback-commands/update)
| history | Show deployed changes | [Link](https://docs.liquibase.com/reference-guide/database-inspection-change-tracking-and-utility-commands/history)
| rollback-one-update | Rollback the last or a specified update | [Link](https://docs.liquibase.com/secure/reference-guide-5-1/init-update-and-rollback-commands/rollback-one-update)
| checks show |  Display available policy checks and their configuration | [Link](https://docs.liquibase.com/secure/reference-guide-5-1/policy-check-and-flow-commands-and-parameter/checks-show)
| checks run |  Execute policy checks against your database or changesets | [Link](https://docs.liquibase.com/secure/reference-guide-5-1/policy-check-and-flow-commands-and-parameter/checks-run)

### 🔦 Troubleshooting
* [Installation issues](https://docs.liquibase.com/pro/get-started-5-0/installation-troubleshooting)
* [Common issues](https://support.liquibase.com/hc/en-us/sections/27504481958555-Troubleshooting)
* [Liquibase University](https://learn.liquibase.com/catalog/info/id:127)

# ☎️ Contact Liquibase
Liquibase sales: https://www.liquibase.com/contact-us<br>

# ⭐ Thank you!
Thank you for evaluating Liquibase Secure! We hope to be a part of your DevOps journey.