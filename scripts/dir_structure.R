ROOT
-data
--raw
--processed
--metadata
-docs
-R
-scripts
-rmd
-output
-imgs
-figs

getwd()
#ifelse(!dir.exists("new_project"), dir.create("new_project"), "Folder already exists")
if (!dir.exists("./data")) dir.create("./data")  # create output directory
if (!dir.exists("./data/raw")) dir.create("./data/raw") 
if (!dir.exists("./data/processed")) dir.create("./data/processed") 
if (!dir.exists("./data/metadata")) dir.create("./data/metadata") 
if (!dir.exists("./docs")) dir.create("./docs") 
if (!dir.exists("./R")) dir.create("./R") 
if (!dir.exists("./scripts")) dir.create("./scripts") 
if (!dir.exists("./rmd")) dir.create("./rmd") 
if (!dir.exists("./output")) dir.create("./output") 
if (!dir.exists("./imgs")) dir.create("./imgs") 
if (!dir.exists("./figs")) dir.create("./figs") 
