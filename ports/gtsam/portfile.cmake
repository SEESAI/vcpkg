vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO borglab/gtsam
    REF 4.1.1
    SHA512 24ce84b9dbfc6a4bcbe4754a9b5d9abe4c4d5905133f5a66f489915c99fe3960f94f830d3b2ab84366c9983f454dbfa5e6a79018f362726c13f434620370d06e
    HEAD_REF develop
    PATCHES
        fix-win-release-build-stuck.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DGTSAM_USE_QUATERNIONS=OFF
        -DGTSAM_POSE3_EXPMAP=OFF
        -DGTSAM_ROT3_EXPMAP=OFF
        -DGTSAM_ENABLE_CONSISTENCY_CHECKS=OFF
        -DGTSAM_WITH_TBB=OFF
        -DGTSAM_WITH_EIGEN_MKL=OFF
        -DGTSAM_WITH_EIGEN_MKL_OPENMP=OFF
        -DGTSAM_THROW_CHEIRALITY_EXCEPTION=OFF
        -DGTSAM_INSTALL_MATLAB_TOOLBOX=OFF
        -DGTSAM_BUILD_WRAP=OFF
        -DGTSAM_USE_SYSTEM_EIGEN=ON
        -DGTSAM_USE_SYSTEM_METIS=ON
        -DGTSAM_BUILD_EXAMPLES_ALWAYS=OFF
        -DGTSAM_BUILD_UNSTABLE=OFF
)

vcpkg_install_cmake()

if(VCPKG_TARGET_IS_WINDOWS)
    vcpkg_fixup_cmake_targets(CONFIG_PATH CMake)
else()
    vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake)
endif()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

vcpkg_copy_pdbs()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
