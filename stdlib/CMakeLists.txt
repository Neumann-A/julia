set(stdlib_ver 1.10)
file(CREATE_LINK "${CMAKE_CURRENT_SOURCE_DIR}" "${CMAKE_BINARY_DIR}/share/julia/stdlib/v${stdlib_ver}" COPY_ON_ERROR)

install(DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}" DESTINATION "share/julia/stdlib/v${stdlib_ver}")

# TODO: compile stdlib