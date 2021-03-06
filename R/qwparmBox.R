#' Parameter boxplot
#' 
#' Takes output list from readNWISodbc and prints a boxplot of parameters
#' @param qw.data A qw.data object generated from readNWISodbc
#' @param facet Character string of either "multisite" for plotting all sites on one plot or "Facet" for plotting sites on individual plots
#' @param scales Character string to define y axis on faceted plots. Options are "free","fixed","free_x", or "free_y"
#' @param new.threshold The threshold value in seconds from current system time for "new" data.
#' @param site.selection A character vector of site IDs to plot
#' @param plotparm A character vector of pcodes to plot
#' @param show.points Show samples points
#' @param log.scale Plot y axis on a log scale
#' @param highlightrecords A character vector of record numbers to highlight in plot
#' @param wySymbol Make current water-year highlighted.
#' @param labelDQI Logical. Should points be labeled with DQI code.
#' @param printPlot Logical. Prints plot to graphics device if TRUE
#' @examples 
#' data("exampleData",package="WQReview")
#' qwparmBoxPlot(qw.data = qw.data,
#'               site.selection = "06733000",
#'               plotparm = c("00915","00095","00400"),
#'               facet = "multisite",
#'               scales="fixed",
#'               new.threshold = 60*60*24*30,
#'               show.points = FALSE,
#'               log.scale = TRUE,
#'               highlightrecords = NULL,
#'               wySymbol = FALSE,
#'               labelDQI = FALSE,
#'               printPlot = TRUE)
#' @import ggplot2
#' @importFrom stringr str_wrap
#' @export

qwparmBoxPlot <- function(qw.data,
                     site.selection,
                     plotparm,
                     facet = "multisite",
                     scales="fixed",
                     new.threshold = 60*60*24*30,
                     show.points = FALSE,
                     log.scale = FALSE,
                     highlightrecords = NULL,
                     wySymbol = FALSE,
                     labelDQI = FALSE,
                     printPlot = TRUE){
  
  medium.colors <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#D55E00")
  names(medium.colors) <- c("WS ","WG ","WSQ","WGQ","OAQ")
  ## Sets color to medium code name, not factor level, so its consistant between all plots regardles of number of medium codes in data
  qual.shapes <- c(19,0,2,5,4,3,6,7,8,9,11)
  names(qual.shapes) <- c("Sample","<",">","E","A","M","N","R","S","U","V")
  
  plotdata <- subset(qw.data$PlotTable,SITE_NO %in% (site.selection) & PARM_CD%in%(plotparm) & MEDIUM_CD %in%(c("WG ","WS ","OAQ")))
  
  if(length(site.selection) == 1)
  {
    maintitle <- str_wrap(unique(plotdata$STATION_NM[which(plotdata$SITE_NO == (site.selection))]), width = 25)
  } else if (length(site.selection) > 1)
  {
    maintitle <- "Multisite boxplot"
  } else (maintitle <- "No site selected")
  
  ylabel <- "Concentration"
  p1 <- ggplot(data=plotdata,aes(x=PARM_NM,y=RESULT_VA, color=MEDIUM_CD))
  p1 <- p1 + geom_boxplot()
  p1 <- p1 + scale_colour_manual("Medium code",values = medium.colors)
  p1 <- p1 + scale_shape_manual("Remark code",values = qual.shapes)
  p1 <- p1 + ylab(paste(ylabel,"\n"))
  p1 <- p1 + ggtitle(maintitle)
  p1 <- p1 + theme(axis.text.x = element_text(angle = 90))
  p1 <- p1 + theme_bw() + theme(panel.grid.minor = element_line())
  p1 <- p1 + scale_x_discrete("Analyte")
  if ( facet == "Facet")
  {
  p1 <- p1 + facet_wrap(~ STATION_NM, nrow = 1, scales=scales) 
  } else{}
  if(log.scale == TRUE)
  {
    p1 <- p1 + scale_y_log10()
  }
  if((show.points)==TRUE){
    p2 <- p1 + geom_point(aes(color = MEDIUM_CD,shape=REMARK_CD),size=3)
    if(nrow(subset(plotdata, RECORD_NO %in% highlightrecords)) > 0)
    {
    p2 <- p2 + geom_point(data=subset(plotdata, RECORD_NO %in% highlightrecords),aes(x=PARM_NM,y=RESULT_VA),size=7,alpha=0.5, color ="#D55E00" ,shape=19)
    }else{}
    
    
    if(nrow(subset(plotdata,RESULT_MD >= (Sys.time()-new.threshold))) > 0)
    {
      p2 <- p2 + geom_text(data=subset(plotdata, RESULT_MD >= (Sys.time()-new.threshold)),
                           aes(x=PARM_NM,y=RESULT_VA,color = MEDIUM_CD,label="New",hjust=1.1),show_guide=F)      
    }else{}
    
    ##highlight this water year's data
    if(wySymbol == TRUE) 
    {
            p2 <- p2 + geom_point(data=subset(plotdata, as.character(waterYear(SAMPLE_START_DT)) == as.character(waterYear(Sys.time()))),
                                  aes(x=PARM_NM,y=RESULT_VA),size=7,alpha = 0.5, color = "#F0E442",shape=19)
    }
    
    if(labelDQI == TRUE)
    {
            p2 <- p2 + geom_text(aes(color = MEDIUM_CD,shape=REMARK_CD,label=DQI_CD),size=5,vjust="bottom",hjust="right")
    }
    
    if(printPlot)
    {
    print(p2)
    }else{}
    return(p2)
  } else{
    if(printPlot)
      {
      print(p1)
      } else{}
      return(p1)
    }
  
}