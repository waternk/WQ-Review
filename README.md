#Overview
Toolbox for discrete water-quality data review and exploration. This is an initial beta version for testing purposes with limited documentation or support. Users are encouraged to post any bugs or comments for additional functionality on the issues page at:

[WQ-Review Issues](https://github.com/USGS-R/WQ-Review/issues).

This package facilitates data review and exploration of discrete water-quality data through rapid and easy-to-use plotting functions and tabular data summaries. Data is imported with user-specified options for single or multiple sites and parameter codes using an ODBC connection to the user's local NWIS server. A graphical user interface allows the user to easily explore their data through a variety of graphical and tabular outputs. 

#Requirements
* This application requires a functioning 32 bit ODBC connection to an NWIS server. Guidance for setting up ODBC access is provided at the bottom of this page.
* A system default internet browser, preferably Google Chrome. The application will launch in your PC's default browser.

#Bug reporting and enhancements
Please report any issues with the application or R package on the issues page at:

[WQ-Review Issues](https://github.com/USGS-R/WQ-Review/issues). 

Additionaly, please feel free to post any suggestions or enhancement requests.

**Your participation will make this a better tool for everyone!**

#Installation for stand alone application (non-R users)

1. Download the application at

ftp://ftpint.usgs.gov/private/cr/co/lakewood/tmills/wqReviewSetup.exe

2. Run wqReviewSetup.exe and follow the installation instructions.

**DO NOT INSTALL WQ-REVIEW INTO YOUR PROGRAM FILES DIRECTORY OR THE APPLICATION WILL NOT RUN. INSTALL TO C DRIVE OR YOUR DOCUMENTS FOLDER.**

3. Update WQ-Review to the latest version either by clicking the checkbox at the end of the setup, or by going to Startmenu->Programs->WQ-Review->Update. A command prompt window will appear and stay open until the update is complete. When the update is complete it will close with no other prompts.


#Installation for R users
##Step 1. Switch over to 32-bit R.

R must be run in 32-bit mode to use the ODBC driver. Open R-studio and click Tools-Global Options on the top toolbar. Under "General" in the global options dialog, you will see "R version:" at the top. Click "Change" next to the R version and select "Use your machine's default version of R (32 bit)" to change to 32-bit R. R-studio will need to restart after doing this.

##Step 2. Install the "devtools" package for installing WQ-Review directly from Github.

Open R-studio in 32-bit mode if it is not already open and type the following command in the console:
```R
install.packages(c("curl","devtools"))
```
This will install the devtools package on your machine. 

If an error appears about "Rtools not installed", ignore this message, Rtools is not required for the devtools functions you will use.

##Step 3. Install the WQ-Review package from Github.

Open R-studio in 32-bit mode if it is not already open and type the following commands in the console:

```R
library(devtools)
install_github("USGS-R/WQ-Review",build_vignettes = TRUE)
```

This will install the WQ-Review package as well as all other packages that WQ-Review relies on. It may take a minute to download and install the supporting packages during the first installation.


##Run the app
The shiny app is launched by loading the WQ-Review package and running the function 
```
library(WQReview)
WQReviewGUI()
```
#Guidance for setting up ODBC connection to NWIS
Your database administrator or IT specialist will need to assist for these steps.

##Step 1
You need to setup a user Data Source Name (User DSN).
On Windows 7 and 8, run "C:/Windows/SysWOW64/odbcad32.exe".

In the User DSN tab, if you do not see a connection with the same name as your NWIS server of interest, you must add a new connection. Click "Add" on the right.

<img src="vignettes/ODBC_UserDSN.png" alt="Drawing" style="width: 400px;"/>

##Step 2
Scroll down until you see a driver named "Oracle in OraClient11g_home1" and click "Finish". **IF YOU DO NOT SEE THE ABOVE DRIVER LISTED, IT IS NOT INSTALLED AND YOU WILL NEED ASSISTANCE FROM AN IT SPECIALIST TO INSTALL IT, THE LINK TO GUIDANCE IS PROVIDED BELOW**

<img src="vignettes/ODBC_CreateUserDSN.png" alt="Drawing" style="width: 400px;"/>

##Step 3
A new dialogue will appear. Click the dropdown box next to "TNS Service Name" and select the NWIS server you would like to connect to. After selecting the server, type in the server name into the "Data Source Name" text box at the top. **DO NOT ENTER A USER ID, LEAVE THIS FIELD BLANK**. You are finished, click OK to close the dialogue and then click OK in the main ODBC Data Source Administrator application to close the application.

<img src="vignettes/ODBC_SelectDSN.png" alt="Drawing" style="width: 400px;"/>

##If you do not have the driver installed
Install the Oracle client by following the instructions here:

http://nwis.usgs.gov/IT/ORACLE/Oracle.client.installation.htm

Then follow the instructions to setup the system DSN

http://nwis.usgs.gov/IT/INSTRUCT/HOWTO/DB_oracle_odbc.html

The ODBC connection must be setup for Oracle and in 32-bit mode. 
