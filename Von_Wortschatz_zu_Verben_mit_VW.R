################################################################################
##  This program receives an xls file 
##   annotate their pharmacological targets according to rDGIdb
##  Author: Raúl Alejandro Mejía Pedroza github: https://github.com/raulmejia
##
#
# Note: pwdefinitions your PtwDf_defintions and your PtwDf_defintions tables should be in the same Pathway database (KEGG , GO , etc )
#       In DEGpvalue use the adj.P.Val
#
# Input description: 
#    -f file (the xls file with more the following structure):
#         NomenA      Artikel   Verhältniswort   Definition (Englisch)/[ES] Auf Spanisch/[FR] Französisch... 
#         Infinitiv/Vergangenheit/Patizip Verb   Zusätsliche Information    Verhältniswort    Definition (Englisch)/[ES] Auf Spanisch/[FR] Französisch...
#         NomenB      Artikel   Verhältniswort   Definition (Englisch)/[ES] Auf Spanisch/[FR] Französisch... 
#
#    -s sheet ( Specify a worksheet by name or number) 
#
#   -l  label (the character string without spaces that you want to label the name of your results)
#   
#   -o  outputfolder ( the path where you want to store your results)
#
# Example: 
#
#  Rscript /path/to/Drugtarget_annotation_over_a_Dataframe_with_genesymbols.R \
#  -f /path/to/your/df/wortschatz.xls \
#  -s Sheet1 \
#  -l label_for_your_results \
#  -o /path/to/save/your/results 
#
# to do: improve -h option
#
################################################################################
##   Installing and loading the required libraries              ################
################################################################################
if (!require("BiocManager")) {
  install.packages("BiocManager")
  library(BiocManager)}
if (!require("rJava")) {
  BiocManager::install("rJava")
  library(rJava)}
if (!require("xlsx")) {
  BiocManager::install("xlsx")
  library(xlsx)}
if (!require("tidyverse")) {
  BiocManager::install("tidyverse")
  library(tidyverse)}
if (!require("readxl")) {
  BiocManager::install("readxl")
  library(readxl)}
if (!require("argparse")) {
  install.packages("argparse", ask =FALSE)
  library("argparse")}
if (!require("plyr")) {
  BiocManager::install("plyr", ask =FALSE)
  library(plyr)}

##########################################################
## Functions that will be used 
##########################################################

###########################################
# Data given by the user          #########
###########################################
# create parser object
parser <- ArgumentParser()
# specify our desired options 
# by default ArgumentParser will add an help option 
parser$add_argument("-v", "--verbose", action="store_true", default=TRUE,
                    help="Print extra output [default]")
parser$add_argument("-q", "--quietly", action="store_false", 
                    dest="verbose", help="Print little output")
parser$add_argument("-f", "--file", type="character", 
                    help="Your xls file")
parser$add_argument("-s", "--sheet", type="character", 
                    help="-s Name of your worksheet")
parser$add_argument("-l", "--label", type="character", 
                    help="label to your results")
parser$add_argument("-o", "--outputfolder", type="character", 
                    help="output file where you want to store your correlation plots")
args <- parser$parse_args( )

##########################################################
### Reading the data #####################################
##########################################################
Path_to_xls <-args$file
# Path_to_xls <-"manually select your .xls" 

myworksheet <- args$sheet
# myworksheet <- "mannualy"

yourxls <- read_excel( path=Path_to_xls , sheet=myworksheet)

dir.create( args$outputfolder, recursive = TRUE)

Path_of_Results <- normalizePath( args$outputfolder )
# Path_of_Results <- "select/it/manually"

Label_for_Results <- args$label
# Label_for_Results  <- "some_label"

##########################################################
### Sading the data #####################################
##########################################################
path_2_save= args$outputfolder
write.table(file = path_2_save, quote =TRUE, row.names =TRUE, col.names = TRUE, sep="\t")

yourxls[1:100,]
View(yourxls[1:100,] )
