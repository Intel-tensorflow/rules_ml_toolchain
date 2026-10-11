# Intel(R) Profiling Tools Interface (PTI) built from source.
# Mirrors https://github.com/intel/pti-gpu/blob/pti-1.1.0/sdk/CMakeLists.txt
# (Linux, no XPTI/SYCL tracing). Two libraries:
#   libpti_view.so.1 - interface library; programs link against it.
#   pti/libpti.so    - core library; libpti_view.so.1 dlopen()s it from the "pti"
#                      folder next to itself (src/pti_lib_handler.h).

load("@bazel_skylib//rules:expand_template.bzl", "expand_template")
load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")
load("@rules_python//python:defs.bzl", "py_binary")
load("@rules_ml_toolchain//gpu/sycl/pti:pti_repositories.bzl", "PTI_COMMIT_HASH", "PTI_VERSION")

_PTI_VERSION_PARTS = PTI_VERSION.split(".")

expand_template(
    name = "pti_version_h",
    out = "include/pti/pti_version.h",
    substitutions = {
        "@PTI_VERSION@": PTI_VERSION,
        "@PROJECT_VERSION_MAJOR@": _PTI_VERSION_PARTS[0],
        "@PROJECT_VERSION_MINOR@": _PTI_VERSION_PARTS[1],
        "@PROJECT_VERSION_PATCH@": _PTI_VERSION_PARTS[2],
        "@PTI_COMMIT_HASH@": PTI_COMMIT_HASH,
    },
    template = "include/pti/pti_version.h.in",
)

expand_template(
    name = "platform_config_h",
    out = "gen/platform_config.h",
    substitutions = {
        "#cmakedefine PTI_EXPERIMENTAL_FILESYSTEM": "/* #undef PTI_EXPERIMENTAL_FILESYSTEM */",
        "@PTI_MODULE_SUBDIR@": "pti",
    },
    template = "src/utils/platform_config.h.in",
)

# Equivalent of CMake's generate_export_header(pti) on Linux.
genrule(
    name = "pti_export_h",
    outs = ["include/pti/pti_export.h"],
    cmd = """cat > $@ <<'EOF'
#ifndef PTI_EXPORT_H
#define PTI_EXPORT_H
#define PTI_EXPORT __attribute__((visibility("default")))
#endif
EOF""",
)

py_binary(
    name = "gen_tracing_callbacks",
    srcs = ["src/gen_tracing_callbacks.py"],
    # Read from next to the script to decide which callbacks to forward.
    data = ["src/levelzero/ze_collector.h"],
    main = "src/gen_tracing_callbacks.py",
)

# Level Zero tracing callbacks and API id tables (FindHeadersPath() in
# sdk/cmake/Modules/macros.cmake). API ids are not regenerated, so no UR header
# is needed.
genrule(
    name = "gen_tracing",
    srcs = ["@level_zero//:all"] + glob(["include/pti/*.h"]),
    outs = [
        "gen/pti_api_ids_state_maps.h",
        "gen/tracing.gen",
        "gen/tracing_api_dlsym_private.gen",
        "gen/tracing_api_dlsym_public.gen",
        "gen/tracing_cb_api.gen",
    ],
    cmd = " ".join([
        "$(execpath :gen_tracing_callbacks)",
        "$(RULEDIR)/gen",
        # Directory of ze_api.h (the script finds layers/ next to it).
        "$$(dirname $$(echo $(locations @level_zero//:all) | tr ' ' '\\n' | grep '/include/ze_api.h$$'))",
        "$(RULEDIR)/gen",
        "$$(dirname $(execpath include/pti/pti_view.h))",
        "unused",
        "OFF",
        "'commit: d3b3efbdaa27a0aef9a9812cc8fa4260557c1e7c - v1.32.0'",
        "> /dev/null",
    ]),
    tools = [":gen_tracing_callbacks"],
)

cc_library(
    name = "pti_headers",
    hdrs = glob(["include/pti/*.h"]) + [
        ":pti_export_h",
        ":pti_version_h",
    ],
    includes = ["include"],
    visibility = ["//visibility:public"],
)

cc_library(
    name = "pti_private_headers",
    hdrs = glob([
        "src/**/*.h",
        "src/**/*.inc",
    ]) + [
        ":gen_tracing",
        ":platform_config_h",
    ],
    includes = [
        "gen",
        "src",
        "src/itt",
        "src/levelzero",
        "src/sycl",
        "src/utils",
    ],
    deps = [
        ":pti_headers",
        "@pti_ittapi//:headers",
        "@pti_spdlog//:spdlog",
    ],
)

cc_library(
    name = "level_zero_ext_headers",
    hdrs = glob(["third-party/compute-runtime/level_zero/include/**/*.h"]),
    includes = ["third-party/compute-runtime/level_zero/include"],
)

_PTI_COPTS = [
    "-fvisibility=hidden",
    "-fvisibility-inlines-hidden",
]

_PTI_LOCAL_DEFINES = [
    "PTI_CCL_ITT_COMPILE",
    "SPDLOG_ACTIVE_LEVEL=SPDLOG_LEVEL_INFO",
    "pti_EXPORTS",
]

cc_binary(
    name = "pti/libpti.so",
    srcs = [
        "src/itt/itt_collector.cc",
        "src/levelzero/ze_command_visitor.cc",
        "src/levelzero/ze_driver_init.cc",
        "src/metrics/pti_metrics.cc",
        "src/metrics/pti_metrics_scope.cc",
        "src/overhead_kinds.cc",
        "src/pc_sampling/pti_pc_sampling.cc",
        "src/pc_sampling/pti_pc_sampling_aggregator.cc",
        "src/pc_sampling/pti_pc_sampling_collector.cc",
        "src/pti.cc",
        "src/pti_callbacks.cc",
        "src/pti_version.cc",
        "src/pti_view.cc",
    ],
    copts = _PTI_COPTS,
    linkopts = [
        "-ldl",
        "-lpthread",
    ],
    linkshared = True,
    local_defines = _PTI_LOCAL_DEFINES + [
        "PTI_LEVEL_ZERO=1",
        "PTI_OVERHEAD_TRACKING_ENABLED",
    ],
    deps = [
        ":level_zero_ext_headers",
        ":pti_private_headers",
        "@level_zero//:headers",
        "@zero_loader//:libze_loader",
    ],
)

cc_binary(
    name = "libpti_view.so.1",
    srcs = [
        "src/itt/itt_adapter.cc",
        "src/itt/itt_stubs.cc",
        "src/pti.cc",
        "src/pti_version.cc",
        "src/pti_view_load.cc",
        "src/xpti_adapter.cc",
    ],
    copts = _PTI_COPTS,
    linkopts = [
        "-ldl",
        "-lpthread",
        "-Wl,-soname,libpti_view.so.1",
    ],
    linkshared = True,
    local_defines = _PTI_LOCAL_DEFINES + [
        "PTI_VIEW_CORE_LIB_NAME=libpti.so",
    ],
    deps = [":pti_private_headers"],
)

# What users depend on: headers plus libpti_view.so.1, with the Core library as
# runtime data next to it.
cc_library(
    name = "pti_view",
    srcs = [":libpti_view.so.1"],
    data = [":pti/libpti.so"],
    visibility = ["//visibility:public"],
    deps = [":pti_headers"],
)
