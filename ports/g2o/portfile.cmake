
if(VCPKG_USE_HEAD_VERSION)
    vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/g2o)
endif()
file(RENAME ${CURRENT_PACKAGES_DIR}/share/g2o/license-bsd.txt ${CURRENT_PACKAGES_DIR}/share/g2o/copyright)
