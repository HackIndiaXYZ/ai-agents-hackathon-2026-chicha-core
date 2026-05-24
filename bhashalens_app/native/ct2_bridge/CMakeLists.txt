cmake_minimum_required(VERSION 3.10)

project(ct2_bridge VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Source files
set(SOURCES
    src/ct2_bridge.cpp
    src/sentencepiece_tokenizer.cpp
)

# Header files
set(HEADERS
    src/ct2_bridge.h
)

# Define native FFI library target
add_library(ct2_bridge SHARED ${SOURCES} ${HEADERS})

# Additional library linking config if needed in production builds
# e.g., linking libctranslate2 and libsentencepiece
# target_link_libraries(ct2_bridge PRIVATE ctranslate2 sentencepiece)

# Target properties
set_target_properties(ct2_bridge PROPERTIES
    PUBLIC_HEADER "${HEADERS}"
    VERSION ${PROJECT_VERSION}
    SOVERSION 1
)

# Target include directories
target_include_directories(ct2_bridge PRIVATE src)
