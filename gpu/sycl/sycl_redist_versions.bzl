# Copyright 2025 Google LLC
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

REDIST_DICT = {
    "oneapi": {
        "ubuntu_24.10_2025.1": [
            "https://d3q76yfpnzmnjx.cloudfront.net/intel-oneapi-base-toolkit-2025.1.3.7.tar.gz",
            "2213104bd122336551aa144512e7ab99e4a84220e77980b5f346edc14ebd458a",
            "oneapi",
        ],
        "ubuntu_24.04_2025.1": [
            "https://d3q76yfpnzmnjx.cloudfront.net/intel-oneapi-base-toolkit-2025.1.3.7.tar.gz",
            "2213104bd122336551aa144512e7ab99e4a84220e77980b5f346edc14ebd458a",
            "oneapi",
        ],
        "ubuntu_22.04_2025.1": [
            "https://d3q76yfpnzmnjx.cloudfront.net/intel-oneapi-base-toolkit-2025.1.3.7.tar.gz",
            "2213104bd122336551aa144512e7ab99e4a84220e77980b5f346edc14ebd458a",
            "oneapi",
        ],
        "ubuntu_24.10_2026.0": [
            "https://d3q76yfpnzmnjx.cloudfront.net/intel-oneapi-base-toolkit-2026.0.0.tar.gz",
            "1d8633ef69020ecb8f495979c56c6a9db0a3d1343a0697863dcf7fba097a369b",
            "oneapi",
        ],
        "ubuntu_24.04_2026.0": [
            "https://d3q76yfpnzmnjx.cloudfront.net/intel-oneapi-base-toolkit-2026.0.0.tar.gz",
            "1d8633ef69020ecb8f495979c56c6a9db0a3d1343a0697863dcf7fba097a369b",
            "oneapi",
        ],
        "ubuntu_24.04_2026.1": [
            "https://d3q76yfpnzmnjx.cloudfront.net/intel-oneapi-base-toolkit-2026.1.0.tar.gz",
            "0e37f30390d9ae168b0777fa469122af1ebafd04b82cd7301983eeaad7f5848b",
            "oneapi",
        ],
    },
    "level_zero": {
        "ubuntu_24.10_2025.1": [
            "https://d3q76yfpnzmnjx.cloudfront.net/level-zero-1.21.10.tar.gz",
            "e0ff1c6cb9b551019579a2dd35c3a611240c1b60918c75345faf9514142b9c34",
            "level-zero-1.21.10",
        ],
        "ubuntu_24.10_2026.0": [
            "https://d3q76yfpnzmnjx.cloudfront.net/level-zero-1.21.10.tar.gz",
            "e0ff1c6cb9b551019579a2dd35c3a611240c1b60918c75345faf9514142b9c34",
            "level-zero-1.21.10",
        ],
        "ubuntu_24.04_2026.0": [
            "https://d3q76yfpnzmnjx.cloudfront.net/level-zero-1.28.6.tar.gz",
            "61658892532486018206f74c8839152dfba27b863e5f4edfcba6d8478ac71ad3",
            "level-zero-1.28.6",
        ],
        "ubuntu_24.04_2026.1": [
            "https://d3q76yfpnzmnjx.cloudfront.net/level-zero-1.28.6.tar.gz",
            "61658892532486018206f74c8839152dfba27b863e5f4edfcba6d8478ac71ad3",
            "level-zero-1.28.6",
        ],
    },
    "zero_loader": {
        "ubuntu_24.10_2025.1": [
            "https://d3q76yfpnzmnjx.cloudfront.net/ze_loader_libs.tar.gz",
            "71cbfd8ac59e1231f013e827ea8efe6cf5da36fad771da2e75e202423bd6b82e",
            "",
        ],
        "ubuntu_24.10_2026.0": [
            "https://d3q76yfpnzmnjx.cloudfront.net/ze_loader_libs.tar.gz",
            "71cbfd8ac59e1231f013e827ea8efe6cf5da36fad771da2e75e202423bd6b82e",
            "",
        ],
        "ubuntu_24.04_2026.0": [
            "https://d3q76yfpnzmnjx.cloudfront.net/ze_loader_libs_1.28.tar.gz",
            "18c53a79a3aad7264410806f8277459f21485351870495996e3d7b2bf1f188fd",
            "",
        ],
        "ubuntu_24.04_2026.1": [
            "https://d3q76yfpnzmnjx.cloudfront.net/ze_loader_libs_1.28.tar.gz",
            "18c53a79a3aad7264410806f8277459f21485351870495996e3d7b2bf1f188fd",
            "",
        ],
    },
}

PTI_DIST = {
    "library_url": "https://files.pythonhosted.org/packages/f1/ba/6493abfca000eb64cc5e115da02418a1adc1e2dd1c979f6cd22e37322d62/intel_pti-1.2.0-py2.py3-none-manylinux_2_28_x86_64.whl",
    "library_sha256": "4cba1d71816f6b3f4283d55c5bc45f09532647e9c5ca8b3a4f136092fa8e3c94",
    "source_url": "https://github.com/intel/pti-gpu/archive/refs/tags/pti-1.2.0.tar.gz",
    "source_sha256": "b2fe5853d2f68efbc2da9a402a72e2d3ae53dd350e4604f0e4e904ff60b68394",
    "source_strip_prefix": "pti-gpu-pti-1.2.0/sdk",
}

BUILD_TEMPLATES = {
    "oneapi": {
        "repo_name": "oneapi",
        "version_to_template": {
            "ubuntu_24.10_2025.1": "//gpu/sycl:oneapi.BUILD.tpl",
            "ubuntu_24.04_2025.1": "//gpu/sycl:oneapi.BUILD.tpl",
            "ubuntu_22.04_2025.1": "//gpu/sycl:oneapi.BUILD.tpl",
            "ubuntu_24.10_2026.0": "//gpu/sycl:oneapi.BUILD.tpl",
            "ubuntu_24.04_2026.0": "//gpu/sycl:oneapi.BUILD.tpl",
            "ubuntu_24.04_2026.1": "//gpu/sycl:oneapi.BUILD.tpl",
        },
    },
    "level_zero": {
        "repo_name": "level_zero",
        "version_to_template": {
            "ubuntu_24.10_2025.1": "//gpu/sycl:level_zero.BUILD",
            "ubuntu_24.10_2026.0": "//gpu/sycl:level_zero.BUILD",
            "ubuntu_24.04_2026.0": "//gpu/sycl:level_zero.BUILD",
            "ubuntu_24.04_2026.1": "//gpu/sycl:level_zero.BUILD",
        },
    },
    "zero_loader": {
        "repo_name": "zero_loader",
        "version_to_template": {
            "ubuntu_24.10_2025.1": "//gpu/sycl:zero_loader.BUILD",
            "ubuntu_24.10_2026.0": "//gpu/sycl:zero_loader.BUILD",
            "ubuntu_24.04_2026.0": "//gpu/sycl:zero_loader.BUILD",
            "ubuntu_24.04_2026.1": "//gpu/sycl:zero_loader.BUILD",
        },
    },
}
