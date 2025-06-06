# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/config
    REF boost-${VERSION}
    SHA512 8958ac0f764ab83481f38931a860c0b7cdad8ced4882d1fa57f570d6ebcb0ef000f33ca896faca392c85336406cbb791bf5114c38a15e0a5dcba5bb69ee5526f
    HEAD_REF master
)

set(FEATURE_OPTIONS "")
boost_configure_and_install(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS ${FEATURE_OPTIONS}
)
file(APPEND "${CURRENT_PACKAGES_DIR}/include/boost/config/user.hpp" "\n#ifndef BOOST_ALL_NO_LIB\n#define BOOST_ALL_NO_LIB\n#endif\n")
file(APPEND "${CURRENT_PACKAGES_DIR}/include/boost/config/user.hpp" "\n#undef BOOST_ALL_DYN_LINK\n")

if (VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    file(APPEND "${CURRENT_PACKAGES_DIR}/include/boost/config/user.hpp" "\n#define BOOST_ALL_DYN_LINK\n")
endif()
file(COPY "${SOURCE_PATH}/libs/config/checks" DESTINATION "${CURRENT_PACKAGES_DIR}/share/boost-config")
