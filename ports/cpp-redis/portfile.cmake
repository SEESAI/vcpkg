include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cpp-redis/cpp_redis
    REF 4.4.0-beta.1
    SHA512 28815c7cccbb9ba32d3d02877257af0c68fef20b7e0ea5e095891f3284a1127344a3712f640403dd342855d3cb1f20d650016c8bafffd2cb356f9b8279deb26d
    HEAD_REF master
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/tacopie/CMakeLists.txt DESTINATION ${SOURCE_PATH}/tacopie)

if(VCPKG_CRT_LINKAGE STREQUAL "dynamic")
    set(MSVC_RUNTIME_LIBRARY_CONFIG "/MD")
else()
    set(MSVC_RUNTIME_LIBRARY_CONFIG "/MT")
endif()

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore" OR NOT VCPKG_CMAKE_SYSTEM_NAME)
    # cpp-redis forcibly removes "/RTC1" in its cmake file. Because this is an ABI-sensitive flag, we need to re-add it in a form that won't be detected.
    set(VCPKG_CXX_FLAGS_DEBUG "${VCPKG_CXX_FLAGS_DEBUG} -RTC1")
    set(VCPKG_C_FLAGS_DEBUG "${VCPKG_C_FLAGS_DEBUG} -RTC1")
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DMSVC_RUNTIME_LIBRARY_CONFIG=${MSVC_RUNTIME_LIBRARY_CONFIG}
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(GLOB_RECURSE FILES "${CURRENT_PACKAGES_DIR}/include/*")
foreach(file ${FILES})
    file(READ ${file} _contents)
    string(REPLACE "ifndef __CPP_REDIS_USE_CUSTOM_TCP_CLIENT" "if 1" _contents "${_contents}")
    if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
        string(REPLACE
            "extern std::unique_ptr<logger_iface> active_logger;"
            "extern __declspec(dllimport) std::unique_ptr<logger_iface> active_logger;"
            _contents "${_contents}")
    endif()
    file(WRITE ${file} "${_contents}")
endforeach()

file(GLOB FILES_TO_REMOVE "${CURRENT_PACKAGES_DIR}/debug/bin/cpp_redis.ilk" "${CURRENT_PACKAGES_DIR}/bin/cpp_redis.dll.manifest")
if(FILES_TO_REMOVE)
    file(REMOVE_RECURSE ${FILES_TO_REMOVE})
endif()

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin)
endif()

vcpkg_copy_pdbs()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)