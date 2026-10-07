load("@rules_cc//cc:defs.bzl", "cc_library")

licenses(["notice"])  # MIT

# Header-only spdlog with its bundled fmt.
cc_library(
    name = "spdlog",
    hdrs = glob(["include/spdlog/**/*.h"]),
    includes = ["include"],
    visibility = ["//visibility:public"],
)
