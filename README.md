nlmd
====

## National Lake Morphometry Database

This repository serves as the intial codebase as I develop the tools to validate, access and share the National Lake Morphometry Database.  The current plan is build this as an R Package and serve the data via OpenCPU with both API level access and a web App built on top of those functions.

Plans are:
- include final, NLA 2007 validated lake morphometry as a csv
- if possible include lake spatial data 
 - not sure how to do this with open cpu as data seems to be what is accepted for [R Packages](http://cran.r-project.org/doc/manuals/R-exts.html#Data-in-packages).  Perhaps .rda is best bet...
- write functions that return data
  - getLakes - would return a specific lake or lakes, specified by COMID(s)
  - getExtent - return all lakes that fall within a specified extent
  - getHUC - return all all lakes within a specified HUC ID.  Should be able to get this to work for any HUC spefication (2-digit up to 12-digit HUCs).  Although time may be an issue with the larger HUCs.
  - getAttr - return all lakes that match a specific morphometric attribute.  For instance, all lakes that are greater than 50ha or have Max Depth greater than 15m, etc.
  - develop www apps that expose these functions via a GUI
  - include download as (csv, geojson, tab, etc) option on web apps
  - include interactive mapping component to select download (maybe implement in later version) 
