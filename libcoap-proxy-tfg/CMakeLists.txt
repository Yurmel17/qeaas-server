cmake_minimum_required(VERSION 3.10)

# TODO: put here proper project name
project(coap_proxy VERSION 1.0.0 LANGUAGES CXX C)

if(NOT CMAKE_C_STANDARD)
    set(CMAKE_C_STANDARD 11)
endif()

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()

set(LIBCOAP_PATH "" CACHE PATH "Path to libcoap installation directory")

if(LIBCOAP_PATH)
    message(STATUS "Using libcoap from ${LIBCOAP_PATH}")
    list(APPEND CMAKE_PREFIX_PATH ${LIBCOAP_PATH})
else()
    message(STATUS "Using libcoap from system")
endif()

#! adding libcoap as a dependency
find_package(libcoap REQUIRED)
find_package(CURL REQUIRED)
find_package(OpenSSL REQUIRED)

message(STATUS "libcoap found: ${libcoap_FOUND}")
message(STATUS "CURL libraries: ${CURL_LIBRARIES}")

add_executable(coap2HttpServer ${CMAKE_CURRENT_LIST_DIR}/src/coap2HttpServer.c)
target_link_libraries(coap2HttpServer PUBLIC libcoap::coap-3)
target_link_libraries(coap2HttpServer PUBLIC ${CURL_LIBRARIES})

# compiler options
add_compile_options(
        $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:-pedantic>
        $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:-Wall>
        $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:-Wcast-qual>
        $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:-Wextra>
        $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:-Wformat-security>
        $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:-Winline>
        $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:-Wmissing-declarations>
        $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:-Wmissing-prototypes>
        $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:-Wnested-externs>
        $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:-Wpointer-arith>
        $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:-Wshadow>
        $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:-Wstrict-prototypes>
        $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:-Wswitch-default>
        $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:-Wswitch-enum>
        $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:-Wunused>
        $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:-Wwrite-strings>)