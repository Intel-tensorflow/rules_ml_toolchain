load("@rules_cc//cc:defs.bzl", "cc_library")

licenses(["notice"])  # BSD-3-Clause

# Equivalent of the ittapi::headers target PTI links against.
cc_library(
    name = "headers",
    hdrs = glob([
        "include/**/*.h",
        "src/ittnotify/*.h",
    ]),
    includes = [
        "include",
        "src/ittnotify",
    ],
    visibility = ["//visibility:public"],
)
