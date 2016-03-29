set(CTEST_SITE "smic.lbl.gov")
set(CTEST_BUILD_NAME "Fedora-23-gcc-5.3.1")
set(CTEST_DASHBOARD_ROOT "/work/dashboards/teca")
set(CTEST_MEMORYCHECK_COMMAND "/bin/valgrind")
set(CTEST_MEMORYCHECK_COMMAND_OPTIONS "--leak-check=full --track-origins=yes --num-callers=500")
set(INITIAL_CACHE
"BUILD_TESTING=ON
TECA_DATA_ROOT=${CTEST_DASHBOARD_ROOT}/TECA_data
CMAKE_CXX_FLAGS=-Wall -Wextra
CMAKE_C_FLAGS=-Wall -Wextra")
set(CTEST_BUILD_CONFIGURATION Debug)
set(CTEST_SVN_COMMAND "/usr/bin/svn")
set(CTEST_GIT_COMMAND "/usr/bin/git")
set(CTEST_TEST_ARGS PARALLEL_LEVEL 1)
set(CTEST_BUILD_FLAGS -j20)
set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
#set(ALWAYS_UPDATE ON)
#set(INCREMENTAL_BUILD OFF)
set(DASHBOARD_RELIABLE TRUE)
include("${CTEST_DASHBOARD_ROOT}/TECA_dashboard.cmake")
