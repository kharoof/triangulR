#'@export
TriR.Windows.Main.NewProject.Add <- function(inpProjectName, inpRootPath, inpProjectStartDate, inpProjectEndDate) {
  inpRootPath <- gsub("%20", " ", inpRootPath)
  inpRootPath <- normalizePath(inpRootPath)

  inpProjectPath <- paste0(inpRootPath, "/", inpProjectName)

  #============= Check if already exists  =============
  if (dir.exists(file.path(inpProjectPath))) {
    stop(paste0('Path already exists: ', inpProjectPath))
  }


  #============= Create folders if necessary =============
  #ER Need to change these to link to variables in load file
  dir.create(inpProjectPath)
  dir.create(paste0(inpProjectPath, "\\Data"))
  dir.create(paste0(inpProjectPath, "\\Imports"))
  dir.create(paste0(inpProjectPath, "\\Settings"))
  dir.create(paste0(inpProjectPath, "\\Models"))
  dir.create(paste0(inpProjectPath, "\\Audit"))

  #============= Create necessary files =============
  #Project Settings
  tmp <- data.table(ProjectName = inpProjectName,
                    ProjectStartDate = inpProjectStartDate,
                    ProjectEndDate = inpProjectEndDate)
  saveRDS(tmp, paste0(inpProjectPath, "/ProjectSettings.TriR"))

  #Analysis Fields
  tmp <- data.table(AnalysisField = c("Paid","Outstanding","Incurred","Number Reported","Number Settled"),
                    FieldType = c("Monetary", "Monetary", "Monetary", "ClaimCount", "ClaimCount"))
  saveRDS(tmp, paste0(inpProjectPath, "/Settings/AnalysisFields.TriRs"))

  #Reserving Classes
  tmp <- data.table(ReservingClass = "Total",
                    Level = 0)
  saveRDS(tmp, paste0(inpProjectPath, "/Settings/ReservingClasses.TriRs"))

  #Imports
  tmp <- data.table(ImportID = 0, ImportName = "ZZZZ")
  tmp <- tmp[0]
  saveRDS(tmp, paste0(inpProjectPath, "/Settings/Imports.TriRs"))
}
