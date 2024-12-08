# Start of Opus ------------------------------------------
if(NOT CMAKE_CROSSCOMPILING)
    find_library(OPUS_LIBRARY opus)
else()
    CPMAddPackage(
        NAME opus
        GIT_REPOSITORY https://github.com/xiph/opus.git
        GIT_TAG v1.4
        DOWNLOAD_ONLY YES
    )

    if(opus_ADDED)
        set(OPUS_SOURCE_DIR ${opus_SOURCE_DIR})
        set(OPUS_BUILD_DIR ${opus_BINARY_DIR})
        set(OPUS_INSTALL_DIR ${CMAKE_BINARY_DIR}/_deps/opus-install)

        file(MAKE_DIRECTORY ${OPUS_BUILD_DIR})

        # removed # -DCMAKE_POSITION_INDEPENDENT_CODE=ON
        add_custom_target(
            build_opus ALL
            COMMAND
            ${CMAKE_COMMAND} -S ${OPUS_SOURCE_DIR} -B ${OPUS_BUILD_DIR}
            -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
            -DCMAKE_INSTALL_PREFIX=${OPUS_INSTALL_DIR} -DCMAKE_BUILD_TYPE=Debug
            COMMAND ${CMAKE_COMMAND} --build ${OPUS_BUILD_DIR}
        )

        add_custom_command(
            TARGET build_opus
            POST_BUILD
            COMMAND ${CMAKE_COMMAND} --install ${OPUS_BUILD_DIR} --prefix ${OPUS_INSTALL_DIR}
        )

        include_directories(${OPUS_INSTALL_DIR}/include)
        link_directories(${OPUS_INSTALL_DIR}/lib)
    endif()

    set(OPUS_INCLUDE_DIRS ${OPUS_INSTALL_DIR}/include)
    set(OPUS_LIBRARY ${OPUS_INSTALL_DIR}/lib/libopus.a)
    set(OPUS_SHARED_LIBRARY ${OPUS_INSTALL_DIR}/lib/libopus.so)
    set(HAVE_OPUS_OPUS_H ${OPUS_INCLUDE_DIRS}/opus/opus.h)

    endif()

# end of Opus --------------------------------------------