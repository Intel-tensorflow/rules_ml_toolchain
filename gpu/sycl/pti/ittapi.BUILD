load("@rules_cc//cc:defs.bzl", "cc_library")

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
