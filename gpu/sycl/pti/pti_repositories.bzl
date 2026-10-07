# Copyright 2026 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==============================================================================

"""Repositories for building Intel PTI (pti_view) from source."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

PTI_VERSION = "1.1.0"

# Commit of the pti-1.1.0 tag, reported by ptiVersionString().
PTI_COMMIT_HASH = "875cdcde8d0a7ab9efb0c671a6e4f85f0b7384f6"

def pti_repositories():
    """Declares the pti-gpu source repository and its header-only dependencies.

    Dependency versions match the ones pinned by pti-gpu's sdk/CMakeLists.txt
    and sdk/cmake/Modules/macros.cmake for the selected PTI release.
    """

    http_archive(
        name = "pti_gpu",
        build_file = Label("//gpu/sycl/pti:pti_gpu.BUILD"),
        patch_args = ["-p1"],
        patches = [Label("//gpu/sycl/pti:pti_gpu_realpath.patch")],
        sha256 = "d604473e70485043347591868cfc038f4b853cece5ec14554bd5a0eec7288891",
        strip_prefix = "pti-gpu-pti-{}/sdk".format(PTI_VERSION),
        urls = ["https://github.com/intel/pti-gpu/archive/refs/tags/pti-{}.tar.gz".format(PTI_VERSION)],
    )

    # PTI_L0_LOADER in sdk/CMakeLists.txt. Headers only: at runtime PTI uses
    # the driver's libze_loader.so.1.
    http_archive(
        name = "pti_level_zero",
        build_file = Label("//gpu/sycl/pti:level_zero_headers.BUILD"),
        sha256 = "b658d3be89b2ea3c5e6b3214592acb58a4875e738184b1a4cc7e9cf878b5f7b9",
        strip_prefix = "level-zero-1.32.0",
        urls = ["https://github.com/oneapi-src/level-zero/archive/refs/tags/v1.32.0.tar.gz"],
    )

    http_archive(
        name = "pti_spdlog",
        build_file = Label("//gpu/sycl/pti:spdlog.BUILD"),
        sha256 = "d8862955c6d74e5846b3f580b1605d2428b11d97a410d86e2fb13e857cd3a744",
        strip_prefix = "spdlog-1.17.0",
        urls = ["https://github.com/gabime/spdlog/archive/refs/tags/v1.17.0.tar.gz"],
    )

    http_archive(
        name = "pti_ittapi",
        build_file = Label("//gpu/sycl/pti:ittapi.BUILD"),
        sha256 = "0b8b387b02b3ea1111ecb6dcb2295558dccb18dcbb0192d401c9db6a6715b28c",
        strip_prefix = "ittapi-3.26.8",
        urls = ["https://github.com/intel/ittapi/archive/refs/tags/v3.26.8.tar.gz"],
    )
