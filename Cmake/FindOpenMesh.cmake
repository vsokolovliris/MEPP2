# - Try to find OPENMESH
# Once done this will define
#
# OPENMESH_FOUND			- system has OPENMESH
# OPENMESH_INCLUDE_DIR		- the OPENMESH include directory
# OPENMESH_LIBRARIES		- the OPENMESH libraries
# OPENMESH_LIBRARY_DIR		- the OPENMESH libraries directory
#

IF (OPENMESH_INCLUDE_DIR)
  # Already in cache, be silent
  SET(OPENMESH_FIND_QUIETLY TRUE)
ENDIF (OPENMESH_INCLUDE_DIR)

FIND_PATH(OPENMESH_DIR
          NAMES "include/OpenMesh/Core/Mesh/PolyMeshT.hh"
          PATHS $ENV{OPENMESH_DIR}
          DOC   "Path to OpenMesh directory"
          )

FIND_PATH(OPENMESH_INCLUDE_DIR OpenMesh/Core/Mesh/PolyMeshT.hh
          PATHS /usr/local/include
                /usr/include
                /opt/local/include
                /opt/include
                ${OPENMESH_DIR}/src
                ${OPENMESH_DIR}/include
          )

IF (OPENMESH_INCLUDE_DIR)
	SET(OPENMESH_LIBRARY_DIR "${OPENMESH_INCLUDE_DIR}/../lib")

	FIND_LIBRARY(OPENMESH_CORE_LIBRARY_RELEASE NAMES OpenMeshCore libOpenMeshCore PATHS ${OPENMESH_LIBRARY_DIR})
	FIND_LIBRARY(OPENMESH_TOOLS_LIBRARY_RELEASE NAMES OpenMeshTools libOpenMeshTools PATHS ${OPENMESH_LIBRARY_DIR})
	SET(OPENMESH_LIBRARY_RELEASE
		${OPENMESH_CORE_LIBRARY_RELEASE}
		${OPENMESH_TOOLS_LIBRARY_RELEASE})

	FIND_LIBRARY(OPENMESH_CORE_LIBRARY_DEBUG NAMES OpenMeshCored libOpenMeshCored PATHS ${OPENMESH_LIBRARY_DIR})
	FIND_LIBRARY(OPENMESH_TOOLS_LIBRARY_DEBUG NAMES OpenMeshToolsd libOpenMeshToolsd PATHS ${OPENMESH_LIBRARY_DIR})
	SET(OPENMESH_LIBRARY_DEBUG
		${OPENMESH_CORE_LIBRARY_DEBUG}
		${OPENMESH_TOOLS_LIBRARY_DEBUG})
ENDIF (OPENMESH_INCLUDE_DIR)

if(OPENMESH_LIBRARY_RELEASE)
  if(OPENMESH_LIBRARY_DEBUG)
    set(OPENMESH_LIBRARIES_ optimized ${OPENMESH_LIBRARY_RELEASE} debug ${OPENMESH_LIBRARY_DEBUG})
  else()
    set(OPENMESH_LIBRARIES_ ${OPENMESH_LIBRARY_RELEASE})
  endif()

  set(OPENMESH_LIBRARIES ${OPENMESH_LIBRARIES_} CACHE FILEPATH "The OpenMesh library")
endif()

IF(OPENMESH_INCLUDE_DIR AND OPENMESH_LIBRARIES)
	SET(OPENMESH_FOUND TRUE)
	MESSAGE(STATUS "Found OpenMesh: ${OPENMESH_LIBRARIES}")
ELSE()
	SET(OPENMESH_FOUND FALSE)
	MESSAGE(FATAL_ERROR "OpenMesh not found. Set OPENMESH_DIR to a correct value.")
ENDIF(OPENMESH_INCLUDE_DIR AND OPENMESH_LIBRARIES)
