load("@rules_cc//cc:defs.bzl", "cc_library")

licenses(["notice"])  # MIT

exports_files([
    "include/layers/zel_tracing_register_cb.h",
    "include/ze_api.h",
])

# Exposed as <level_zero/...> like an installed Level Zero.
cc_library(
    name = "headers",
    hdrs = glob(["include/**/*.h"]),
    include_prefix = "level_zero",
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
