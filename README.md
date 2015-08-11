#Overview
Toolbox for discrete water-quality data review and exploration. This is an initial beta version for testing purposes with limited documentation or support. Users are encouraged to post any bugs or comments for additional functionality on the issues page at:

[WQ-Review Issues](https://github.com/USGS-R/WQ-Review/issues).

This package facilitates data review and exploration of discrete water-quality data through rapid and easy-to-use plotting functions and tabular data summaries. Data is imported with user-specified options for single or multiple sites and parameter codes using an ODBC connection to the user's local NWIS server. A graphical user interface allows the user to easily explore their data through a variety of graphical and tabular outputs. 

#Requirements
* This application requires a functioning ODBC connection to an NWIS server. Guidance for setting up ODBC access is provided at the bottom of this page.
* A system default internet browser, preferably Google Chrome. The application will launch in your PC's default browser.

#Bug reporting and enhancements
Please report any issues with the application or R package on the issues page at:

[WQ-Review Issues](https://github.com/USGS-R/WQ-Review/issues). 

Additionaly, please feel free to post any suggestions or enhancement requests.

**Your participation will make this a better tool for everyone!**

#Installation for stand alone application (non-R users)

1. Download the application at

https://github.com/tmills-usgs/WQ-Review_application/blob/master/Output/wqReviewSetup.exe?raw=true

2. Run wqReviewSetup.exe and follow the installation instructions.

**DO NOT INSTALL WQ-REVIEW INTO YOUR PROGRAM FILES DIRECTORY OR THE APPLICATION WILL NOT RUN. INSTALL TO C DRIVE OR YOUR DOCUMENTS FOLDER.**

3. Update WQ-Review to the latest version either by clicking the checkbox at the end of the setup, or by going to Startmenu->Programs->WQ-Review->Update. A command prompt window will appear and stay open until the update is complete. When the update is complete it will close with no other prompts.


#Installation for R users
```
library(devtools)
install_github("USGS-R/WQ-Review")
```

###Run the app
The shiny app is launched by loading the WQ-Review package and running the function 
```
library(WQReview)
WQReviewGUI()
```
#Guidance for setting up ODBC connection to NWIS
If you have SiteVisit, GRSAT, or Maps installed and running you already have the required ODBC drivers installed and you do not need to do that again. You can skip down to the User DSN section at the end of the instructions linked below and create a User DSN yourself, without any admin rights. Otherwise, your database administrator or IT specialist will need to assist for this step.

Guidance for setting up ODBC connection to NWIS at: http://nwis.usgs.gov/IT/INSTRUCT/HOWTO/DB_oracle_odbc.html

The ODBC connection must be setup for Oracle and in 32-bit mode. Alternatively, if you are using 32-bit Microsoft Access you can follow the Access instructions (Link Access to Oracle via ODBC Steps) to create a DSN.
