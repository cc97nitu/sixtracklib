################################################################################
#
# SixTrackLib: Settings.cmake.default: default settings file
#
# Usage: if you want to deviate from the provided default values, create a copy
#        of this file named Settings.cmake in the same directory and perform the
#        modifications therein.
#
################################################################################

# ==============================================================================
# ====  Top Level Settings and Options:

# ------------------------------------------------------------------------------
# ---- Backends and computing architectures:

option( SIXTRACKL_ENABLE_AUTOVECTORIZATION "Enable Autovectorization"     OFF )
option( SIXTRACKL_ENABLE_MANUAL_SIMD       "Enable manual SIMD backend"   OFF )
option( SIXTRACKL_ENABLE_OPENMP            "Enable OpenMP backend"        OFF )
option( SIXTRACKL_ENABLE_OPENCL            "Enable OpenCL 1.x backend"    ON )
option( SIXTRACKL_ENABLE_CUDA              "Enable CUDA backend"          OFF )
option( SIXTRACKL_ENABLE_MPFR4             "Enable GMP/MPFR4 backend"     OFF )

option( SIXTRACKL_ENABLE_CXX               "Enable C++ bindings"          ON  )
option( SIXTRACKL_ENABLE_PYTHON            "Enable Python bindings"       ON  )

# ------------------------------------------------------------------------------
# ---- Program logistic options:

option( SIXTRACKL_BUILD_TOOLS            "Build sixtracklib tools"        OFF )
option( SIXTRACKL_BUILD_EXAMPLES         "Build sixtracklib examples"     OFF )
option( SIXTRACKL_ENABLE_PROGRAMM_TESTS  "Enable programmatic unit-tests" OFF )
option( SIXTRACKL_ENABLE_BENCHMARK_TESTS "Enable benchmark tests"         OFF )

# ------------------------------------------------------------------------------
# ---- SixTrackLib Features:

# Track features: allowed values are enabled, disabled, or skip:

set( SIXTRACKL_TRACK_BEAMBEAM4D             "enabled"  CACHE STRING "" )
set( SIXTRACKL_TRACK_BEAMBEAM6D             "enabled"  CACHE STRING "" )
set( SIXTRACKL_TRACK_SPACECHARGE            "enabled"  CACHE STRING "" )
set( SIXTRACKL_TRACK_TRICUB                 "disabled" CACHE STRING "" )

# Aperture check features: allowed values are always, never, conditional

set( SIXTRACKL_APERTURE_CHECK_AT_DRIFT      "always"  CACHE STRING "" )

# ------------------------------------------------------------------------------
# CPU/System architecture settings:

set( SIXTRACKL_CPU_ARCH "sse2" CACHE STRING "CPU/System architecture" )
set_property( CACHE SIXTRACKL_CPU_ARCH PROPERTY STRINGS sse2 avx avx2 native )

# ------------------------------------------------------------------------------
# Default compiler flags:

set( SIXTRACKL_DEFAULT_C99_FLAGS
     "-Wall -Werror -pedantic -ansi -fno-fast-math" )

set( SIXTRACKL_DEFAULT_CXX_FLAGS
     "-Wall -Werror -pedantic -ansi -fno-fast-math" )

# ==============================================================================
# ====  Detailed settings:

# ------------------------------------------------------------------------------
# ---- SixTrackLib detailed features settings:

set( SIXTRACKL_APERTURE_X_LIMIT_VALUE "1.0" CACHE STRING "" )
set( SIXTRACKL_APERTURE_Y_LIMIT_VALUE "1.0" CACHE STRING "" )
set( SIXTRACKL_APERTURE_CHECK_MIN_DRIFT_LENGTH "0.0" CACHE STRING "" )

# ------------------------------------------------------------------------------
# Installation detailed setings

option( SIXTRACKL_REQUIRE_OFFLINE_BUILD "Require offline building" OFF )

if( SIXTRACKL_ENABLE_PYTHON )
    option( SIXTRACKL_INSTALL_PYSIXTRACKLIB
            "Handle Python wrapper during make install step" OFF )

    option( SIXTRACKL_INTALL_PYSIXTRACKLIB_TEST
            "Handle Python sixtracklib_test during make install step" OFF )
endif()

if( SIXTRACKL_BUILD_EXAMPLES )
    option( SIXTRACKL_INSTALL_EXAMPLES
            "Handle examples during make install" ON  )
endif()

if( SIXTRACKL_ENABLE_PROGRAMM_TESTS )
    option( SIXTRACKL_INSTALL_PROGRAM_TESTS
            "Handle programmatic unit-tests during make install" ON  )
endif()

if( SIXTRACKL_ENABLE_BENCHMARK_TESTS )
    option( SIXTRACKL_INSTALL_BENCHMARK_TESTS
            "Handle benchmark tests during make install" ON  )
endif()

if( SIXTRACKL_ENABLE_PROGRAMM_TESTS OR SIXTRACKL_ENABLE_BENCHMARK_TESTS )
    option( SIXTRACKL_GENERATE_TESTDATA_AFTER_INSTALL
            "Generate testdata after the make install step" ON  )
endif()

# ------------------------------------------------------------------------------
# Cuda related detailed settings

if( SIXTRACKL_ENABLE_CUDA )
    option( SIXTRACKL_ENABLE_CUDA_RTC
            "Enable CUDA Runtime Compilation (nvrtc)" OFF )
endif()

set(  SIXTRACKL_CUDA_COMPUTE_ARCH_LIST )

if( SIXTRACKL_ENABLE_CUDA )
    list( APPEND SIXTRACKL_CUDA_COMPUTE_ARCH_LIST "30" )
endif()

# ------------------------------------------------------------------------------
# OpenCL 1.x related detailed settings

if( SIXTRACKL_ENABLE_OPENCL )
    set( SIXTRACKL_OPENCL_DEFAULT_COMPILER_FLAGS "-w -Werror" CACHE STRING
         "Default run-time compiler options for OpenCL" )

    set( SIXTRACKL_MIN_OPENCL_VERSION "110" CACHE STRING
        "Minimal expected OpenCL 1.x version" )

    set( SIXTRACKL_TARGET_OPENCL_VERSION "120" CACHE STRING
        "Target OpenCL 1.x version" )

    option( SIXTRACKL_USE_LEGACY_CL_HPP "Use legacy cl.hpp header" OFF )

    option( SIXTRACKL_OPENCL_CXX_ENABLE_EXCEPTIONS
            "Enable OpenCL 1.x Host-side C++ Exceptions" ON )
endif()

# ------------------------------------------------------------------------------
# Unit-testing related settings:

if( SIXTRACKL_ENABLE_PROGRAMM_TESTS )

    option( SIXTRACKL_ENABLE_PROGRAM_MEMTESTS "Enable memleak tests" OFF )
    option( SIXTRACKL_ENABLE_TIMING_TESTS "Enable benchmarking tests" OFF )
    option( SIXTRACKL_ENABLE_ACCURACY_TESTS "Enable full accuracy tests" OFF )

    set( SIXTRACKL_GOOGLETEST_ROOT "" CACHE PATH
         "Path to include/gtest/gtest.h (for non-standard installations)" )

    set( SIXTRACKL_MEMCHECK_COMMAND "valgrind" CACHE STRING
         "name of the memory check tool (i.e. valgrind)" )

    set( SIXTRACKL_MEMCHECK_COMMAND_OPTIONS
         "--trace-children=yes --leak-check=full"
         CACHE STRING "Command line options for the memcheck tool" )

    set( SIXTRACKL_MEMCHECK_SUPPRESSIONS_FILE "" CACHE PATH
         "Path to the memcheck tool suppression file (optional, leave empty)" )

endif()

# ------------------------------------------------------------------------------
# ----  Namespace:

set( SIXTRACKL_CXX_NAMESPACE "sixtrack" CACHE STRING
     "SixTrackLib C++ namespace (default: sixtrack)" )

set( SIXTRACKL_C_NAMESPACE_PREFIX "st_" CACHE STRING
     "SixTrackLib C-Namespace prefix (default: st_)" )

# ==============================================================================
# end: Settings.cmake.default | Settings.cmake
