# Automatically generated by boost-vcpkg-helpers/generate-ports.ps1

include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/vmd
    REF boost-1.71.0
    SHA512 dc1065ce7be32b8aa2b73dc41fb33d60136d77b76a86bc6f236d7a46b7cde2c6245eddc98c6c49ec90a8d9bfafb518138fdb470f636ee5a1f720a94c14a6d3bb
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
