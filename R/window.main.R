#'@export
TriR.Windows.Main.AnalysisFields_treeview_refresh <- function() {
  ################### PREPARE TREEVIEW ################
  #TriR.Windows.Main.Widget("select_treeview_analysisfields")$getModel()$clear()

  #Field Types
  tmpListOfFieldTypes <- list();

  tmpListOfFieldTypes[[1]] = "gchararray" #ReservingClass
  tmpListOfFieldTypes[[2]] = "gchararray" #Level

  model <- RGtk2::gtkListStoreNew(tmpListOfFieldTypes)

  treeview <- TriR.Windows.Main.Widget("select_treeview_analysisfields")
  treeview$setModel(model)

  #Clean Up Treeview (in case columns were already added)
  tmpExistingColumns <- gtkTreeViewGetColumns(treeview)
  if (length(tmpExistingColumns) > 0) {
    for (iRow in 1:length(tmpExistingColumns)) {
      RGtk2::gtkTreeViewRemoveColumn(treeview, tmpExistingColumns[[iRow]])
    }
  }

  renderer <- RGtk2::gtkCellRendererTextNew()
  renderer$set(xalign = 0.0)
  col.offset <-
    treeview$insertColumnWithAttributes(-1,
                                        "Reserving Class",
                                        renderer,
                                        text = 0)

  renderer <- RGtk2::gtkCellRendererTextNew()
  renderer$set(xalign = 0.0)
  col.offset <-
    treeview$insertColumnWithAttributes(-1,
                                        "Level",
                                        renderer,
                                        text = 1)

  #Get field values
  tmpAnalysisFields <- readRDS(paste0(SettingsProjectPath, "/Settings/AnalysisFields.TriRs"))

  #Add Individual Field Levels
  iRow = 1
  if (nrow(tmpAnalysisFields) > 0) {
    for (iRow in 1:nrow(tmpAnalysisFields)) {
      iter <- model$append()$iter
      tmpColumnValues <- paste0(0, ",\"", tmpAnalysisFields[iRow, AnalysisField], "\",1,\"", tmpAnalysisFields[iRow, FieldType], "\"")
      tmpColumnValues = paste0("model$set(iter,", tmpColumnValues, ")")
      eval(parse(text = tmpColumnValues))
    }
  }
}

#'@export
btn_Imports_AddImport_clicked <- function(action, window) {
  TriR.Windows.ImportData.DisplayWindow()
}

#'@export
btn_Toolbar_NewProject_clicked <- function(action, window) {
  TriR.Windows.AddNewProject.DisplayWindow()
}

#'@export
btn_Toolbar_OpenProject_clicked <- function(action, window) {
  TriR.Windows.Main.FindAndLoadProject()
}

###################################################################################################################

# Main Display Window----
#'@export
TriR.Windows.Main.DisplayWindow <- function() {
  print("OK1")
  TriR$TriR.MainWindow <- gtkBuilder()
  filename <- paste0(TriR$gladefile.path, "MainWindow.glade")
  print("OK2")
  res <- TriR$TriR.MainWindow$addFromFile(filename)
  print("OK3")
  if (!is.null(res$error))
    stop("ERROR: ", res$error$message)
  print("OK3b")
  #TriR$TriR.MainWindow$connectSignals(NULL)
  TriR$TriR.MainWindow$connectSignals()
  print("OK3c")
  window <- TriR$TriR.MainWindow$getObject("winMain")
  print("OK4")
  window$showAll()
  print("OK5")
  window$maximize()
  print("OK6")

}

#'@export
TriR.Windows.Main.imports_treeview_refresh <- function() {
  ################### PREPARE TREEVIEW ################
  #TriR.Windows.Main.Widget("select_treeview_imports")$getModel()$clear()

  #Field Types
  tmpListOfFieldTypes <- list();

  tmpListOfFieldTypes[[1]] = "gchararray" #ReservingClass
  tmpListOfFieldTypes[[2]] = "gchararray" #Level

  model <- RGtk2::gtkListStoreNew(tmpListOfFieldTypes)

  treeview <- TriR.Windows.Main.Widget("select_treeview_imports")
  treeview$setModel(model)

  #Clean Up Treeview (in case columns were already added)
  tmpExistingColumns <- gtkTreeViewGetColumns(treeview)
  if (length(tmpExistingColumns) > 0) {
    for (iRow in 1:length(tmpExistingColumns)) {
      RGtk2::gtkTreeViewRemoveColumn(treeview, tmpExistingColumns[[iRow]])
    }
  }

  renderer <- RGtk2::gtkCellRendererTextNew()
  renderer$set(xalign = 0.0)
  col.offset <-
    treeview$insertColumnWithAttributes(-1,
                                        "Import ID",
                                        renderer,
                                        text = 0)

  renderer <- RGtk2::gtkCellRendererTextNew()
  renderer$set(xalign = 0.0)
  col.offset <-
    treeview$insertColumnWithAttributes(-1,
                                        "Import Name",
                                        renderer,
                                        text = 1)

  #Get field values
  tmpimports <- readRDS(paste0(SettingsProjectPath, "/Settings/imports.TriRs"))

  #Add Individual Field Levels
  iRow = 1
  if (nrow(tmpimports) > 0) {
    for (iRow in 1:nrow(tmpimports)) {
      iter <- model$append()$iter
      tmpColumnValues <- paste0(0, ",\"", tmpimports[iRow, ImportID], "\",1,\"", tmpimports[iRow, ImportName], "\"")
      tmpColumnValues = paste0("model$set(iter,", tmpColumnValues, ")")
      eval(parse(text = tmpColumnValues))
    }
  }
}

#'@export
TriR.Windows.Main.ReservingClasses_treeview_refresh <- function() {
  ################### PREPARE TREEVIEW ################
  #TriR.Windows.Main.Widget("select_treeview_reservingclasses")$getModel()$clear()

  #Field Types
  tmpListOfFieldTypes <- list();

  tmpListOfFieldTypes[[1]] = "gchararray" #Analysis Field
  tmpListOfFieldTypes[[2]] = "gchararray"  #Field Type

  model <- RGtk2::gtkListStoreNew(tmpListOfFieldTypes)

  treeview <- TriR.Windows.Main.Widget("select_treeview_reservingclasses")
  treeview$setModel(model)

  #Clean Up Treeview (in case columns were already added)
  tmpExistingColumns <- gtkTreeViewGetColumns(treeview)
  if (length(tmpExistingColumns) > 0) {
    for (iRow in 1:length(tmpExistingColumns)) {
      RGtk2::gtkTreeViewRemoveColumn(treeview, tmpExistingColumns[[iRow]])
    }
  }

  renderer <- RGtk2::gtkCellRendererTextNew()
  renderer$set(xalign = 0.0)
  col.offset <-
    treeview$insertColumnWithAttributes(-1,
                                        "Analysis Field",
                                        renderer,
                                        text = 0)

  renderer <- RGtk2::gtkCellRendererTextNew()
  renderer$set(xalign = 0.0)
  col.offset <-
    treeview$insertColumnWithAttributes(-1,
                                        "Field Type",
                                        renderer,
                                        text = 1)

  #Get field values
  tmpAnalysisFields <- readRDS(paste0(SettingsProjectPath, "/Settings/ReservingClasses.TriRs"))

  #Add Individual Field Levels
  iRow = 1
  if (nrow(tmpAnalysisFields) > 0) {
    for (iRow in 1:nrow(tmpAnalysisFields)) {
      iter <- model$append()$iter
      tmpColumnValues <- paste0(0, ",\"", tmpAnalysisFields[iRow, ReservingClass], "\",1,\"", tmpAnalysisFields[iRow, Level], "\"")
      tmpColumnValues = paste0("model$set(iter,", tmpColumnValues, ")")
      eval(parse(text = tmpColumnValues))
    }
  }
}

#'@export
TriR.Windows.Main.Widget <- function(widget) {
  return(TriR$TriR.MainWindow$getObject(widget))
}
