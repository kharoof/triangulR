#'@export
TriR.Windows.ImportData.ctlImportDataTab.cboSourceTypeChange <- function(a,b) {
  tmpSourceType <- TriR.Windows.ImportData.Widget("Import_Import_cboSourceType")$GetActiveText()

  #Check if ODBC options are required
  if (tmpSourceType == "ODBC") {
    TriR.Windows.ImportData.Widget("data_odbc_dsn_label")$show()
    TriR.Windows.ImportData.Widget("data_odbc_dsn_entry")$show()
    TriR.Windows.ImportData.Widget("data_odbc_dsn_entry")$show()
    TriR.Windows.ImportData.Widget("data_odbc_table_label")$show()
    TriR.Windows.ImportData.Widget("data_odbc_table_combobox")$show()
  } else {
    TriR.Windows.ImportData.Widget("data_odbc_dsn_label")$hide()
    TriR.Windows.ImportData.Widget("data_odbc_dsn_entry")$hide()
    TriR.Windows.ImportData.Widget("data_odbc_dsn_entry")$hide()
    TriR.Windows.ImportData.Widget("data_odbc_table_label")$hide()
    TriR.Windows.ImportData.Widget("data_odbc_table_combobox")$hide()
  }

  #Check if RData
  if (tmpSourceType == "RData") {
    TriR.Windows.ImportData.Widget("data_name_label")$show()
    TriR.Windows.ImportData.Widget("data_name_combobox")$show()

    #Clear combo list
    TriR.Windows.ImportData.Widget("data_name_combobox")$getModel()$clear()

    #populate combo with available data frames
    tmpAvailableDataFrames <- names(which(unlist(eapply(.GlobalEnv, is.data.frame))))

    #Ensure that the combo box is enabled
    TriR.Windows.ImportData.Widget("data_name_combobox")$SetButtonSensitivity(1)

    #Populate combo box
    for (iRow in 1:length(tmpAvailableDataFrames)) {
      TriR.Windows.ImportData.Widget("data_name_combobox")$appendText(tmpAvailableDataFrames[[iRow]])
    }
  } else {
    TriR.Windows.ImportData.Widget("data_name_label")$hide()
    TriR.Windows.ImportData.Widget("data_name_combobox")$hide()
  }

  #Check if Text File
  if (tmpSourceType %in% c("Text File","Excel")) {
    TriR.Windows.ImportData.Widget("data_filename_label")$show()
    TriR.Windows.ImportData.Widget("data_filechooserbutton")$show()
  } else {
    TriR.Windows.ImportData.Widget("data_filename_label")$hide()
    TriR.Windows.ImportData.Widget("data_filechooserbutton")$hide()
  }
}

##############
#TriR.Windows.ImportData.DisplayWindow()

#TriR.Windows.ImportData.Widget("data_name_combobox")$show()
#'@export
TriR.Windows.ImportData.DisplayWindow <- function() {
  TriR.ImportData <<- gtkBuilder()
  filename <- paste0(TriR.Settings.GladeFileLocation, "\\MainWindow.glade")

  res <- TriR.ImportData$addFromFile(filename)
  if (!is.null(res$error))
    stop("ERROR: ", res$error$message)
  TriR.ImportData$connectSignals(NULL)
  window <- TriR.ImportData$getObject("winImport")

  window$showAll()
}
#'@export
TriR.Windows.ImportData.Widget <- function(widget) {
  return(TriR.ImportData$getObject(widget))
}
