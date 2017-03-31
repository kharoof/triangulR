TriR <- new.env()



.onLoad <- function(libname, pkgname)
{

}

.onAttach <- function(libname, pkgname)
{

  #Load paths and settings
  #if (isPackageLoaded(package="triangulR")) {
  #    TriR$default.path <- path.package(package="triangulR")[1]
  #} else {
  #  TriR$default.path <- getwd()
  #}
  TriR$default.path <- path.package(package="triangulR")[1]
  TriR$gladefile.path <- paste0(TriR$default.path,"/etc/")



  msg <- paste("TriangulR",
                    "Reserving in R.  ",
               "Type 'TriangulR()' to begin.",
               sep="")

  if ("TriangulR" %in% getOption("defaultPackages"))
    TriangulR()
  else
    packageStartupMessage(msg, appendLF=FALSE)
}
