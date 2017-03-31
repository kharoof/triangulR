#'@export
NP_btnAddNewProject_clicked <- function(action, window) {
  #Read values from window
  NewProjectName <- TriR.Windows.AddNewProject.Widget("NP_txtNewProjectName")$GetText()
  NewProjectRootPath <- TriR.Windows.AddNewProject.Widget("NP_data_filechooserbutton")$getUri()

  if (substr(NewProjectRootPath, 1, 8) == "file:///") {
    NewProjectRootPath = substr(NewProjectRootPath, 9, nchar(NewProjectRootPath))
  }


  NewProjectStartDate <- TriR.Windows.AddNewProject.Widget("NP_calendarProjectStartDate")$getDate()
  NewProjectEndDate <- TriR.Windows.AddNewProject.Widget("NP_calendarProjectEndDate")$getDate()

  NewProjectStartDate <- ISOdate(NewProjectStartDate$year,
                                 NewProjectStartDate$month + 1,
                                 NewProjectStartDate$day)

  NewProjectEndDate <- ISOdate(NewProjectEndDate$year,
                               NewProjectEndDate$month + 1,
                               NewProjectEndDate$day)

  #Some error checking
  if (NewProjectName == "") {
    TriR.Windows.AddNewProject.Widget("NP_lblAddStatus")$SetText("Blank project name!")
  } else if (NewProjectEndDate <= NewProjectStartDate) {
    TriR.Windows.AddNewProject.Widget("NP_lblAddStatus")$SetText("End date must be after start date!")
  } else if (is.null(NewProjectRootPath) || NewProjectRootPath == "") {
    TriR.Windows.AddNewProject.Widget("NP_lblAddStatus")$SetText("Invalid project location!")
  } else {
    #Everything looks OK - Create new project
    TriR.Windows.Main.NewProject.Add(inpProjectName = NewProjectName,
                                     inpRootPath = NewProjectRootPath,
                                     inpProjectStartDate = NewProjectStartDate,
                                     inpProjectEndDate = NewProjectEndDate)

    #Hide New Project window
    TriR.Windows.AddNewProject.Widget("winNewProject")$hide()

    #Load Project
    TriR.Windows.Main.LoadProject(inpProjectPath = paste0(NewProjectRootPath, "/", NewProjectName))
  }



}

#'@export
TriR.Windows.AddNewProject.DisplayWindow <- function() {
  TriR$TriR.AddNewProjectWindow <- gtkBuilder()
  filename <- paste0(TriR$gladefile.path, "MainWindow.glade")

  res <- TriR$TriR.AddNewProjectWindow$addFromFile(filename)
  if (!is.null(res$error))
    stop("ERROR: ", res$error$message)
  TriR$TriR.AddNewProjectWindow$connectSignals(NULL)
  window <- TriR$TriR.AddNewProjectWindow$getObject("winNewProject")

  window$showAll()
}

#'@export
TriR.Windows.AddNewProject.Widget <- function(widget) {
  return(TriR$TriR.AddNewProjectWindow$getObject(widget))
}
