find_package(PkgConfig)
pkg_check_modules(ALSA REQUIRED alsa)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(CAIRO DEFAULT_MSG ALSA_FOUND)
