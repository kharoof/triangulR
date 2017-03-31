#'@export
TriR.Windows.Main.FindAndLoadProject <- function() {
  dialog <- RGtk2::gtkFileChooserDialog("Open Project",
                                        NULL, "load",
                                        "gtk-cancel", RGtk2::GtkResponseType["cancel"],
                                        "gtk-open", RGtk2::GtkResponseType["accept"])
  if (!is.null(TriR$TriR.Settings.PWD))
    dialog$setCurrentFolder(TriR$TriR.Settings.PWD)

  #Set filter
  ff <- RGtk2::gtkFileFilterNew()
  ff$setName("ProjectsEOB")
  lapply(paste("*.", c("trir"), sep = ""), ff$addPattern)
  dialog$addFilter(ff)


  if (dialog$run() == RGtk2::GtkResponseType["accept"]) {
    load.name <<- dialog$getFilename()
    dialog$destroy()
    TriR.Windows.Main.LoadProject(inpProjectPath = load.name)
  } else {
    dialog$destroy()
    return()
  }
}

#'@export
TriR.Windows.Main.LoadProject <- function(inpProjectPath) {

  inpProjectPath <- normalizePath(inpProjectPath)

  if (toupper(substring(inpProjectPath, nchar(inpProjectPath) - 4)) == ".TRIR") {
    inpProjectPath = dirname(inpProjectPath)
  }

  SettingsProjectPath <<- inpProjectPath

  #Populate Project Settings
  tmpProjectSettings <- readRDS(paste0(inpProjectPath, "/ProjectSettings.TriR"))

  TriR.Windows.Main.Widget("lblProjectNameValue")$SetText(tmpProjectSettings[1, ProjectName])
  TriR.Windows.Main.Widget("lblProjectLocationValue")$SetText(inpProjectPath)
  TriR.Windows.Main.Widget("lblProjectStartDateValue")$SetText(tmpProjectSettings[1, ProjectStartDate])
  TriR.Windows.Main.Widget("lblProjectEndDateValue")$SetText(tmpProjectSettings[1, ProjectEndDate])

  #Update treeviews
  TriR.Windows.Main.AnalysisFields_treeview_refresh()
  TriR.Windows.Main.ReservingClasses_treeview_refresh()




}
