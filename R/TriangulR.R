#'Load the main GUI
#'
#'Call this function to load the main GUI
#'@export
TriangulR <- function() {

  if (! exists("TriR"))
  {
    .onLoad()
    .onAttach()
  }


  if (exists("NP_btnAddNewProject_clicked",envir=TriR)) {
    print("there")
  } else {
    print("Not there")
  }
  X <- lsf.str(envir=TriR)
  as.vector(X) # just for printing purposes, you can use the vector in rm()
  print(X)

  #Hardcoded paths
  #Unix
  TriR$project.path <- TriR$default.path
  TriR$project.audit <- paste0(TriR$default.path ,"/audit/")
  TriR$project.data <- paste0(TriR$default.path ,"/data/")
  TriR$project.imports <- paste0(TriR$default.path ,"/imports/")
  TriR$project.models <- paste0(TriR$default.path ,"/models/")
  TriR$SettingsProjectPath <- paste0(TriR$default.path ,"/Settings/")

  print(TriR$default.path)

  options(guiToolkit = "RGtk2")

  TriR.Windows.Main.DisplayWindow()
}

