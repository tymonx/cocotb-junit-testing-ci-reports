# SPDX-FileCopyrightText: 2026 Tymoteusz Blazejczyk <tymoteusz.blazejczyk@tymonx.com>
# SPDX-License-Identifier: Apache-2.0

.POSIX:
.SILENT:

WORKDIR = $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

COCOTB_RESULTS_RELATIVE_TO ?= $(WORKDIR)
HDL_TOPLEVEL_LANG ?= vhdl
TOPLEVEL_LANG ?= $(HDL_TOPLEVEL_LANG)
WAVES ?= 1
SIM ?= ghdl
SIM_ARGS ?= --wave=wave.ghw

export COCOTB_RESULTS_RELATIVE_TO
export HDL_TOPLEVEL_LANG
export TOPLEVEL_LANG
export WAVES
export SIM
export SIM_ARGS

.PHONY: all
all: test-with-pytest-plugin

$(WORKDIR)/.venv/bin/activate:
	uv venv
	. "$@"; uv pip install git+https://github.com/tymonx/cocotb.git@chore/xunit-reporter pytest

.PHONY: test-with-makefile
test-with-makefile: $(WORKDIR)/.venv/bin/activate
	. "$^"; COCOTB_RESULTS_ATTACHMENTS=examples/simple_dff/wave.ghw make -C examples/simple_dff

.PHONY: test-with-runner
test-with-runner: $(WORKDIR)/.venv/bin/activate
	. "$^"; pytest -p no:cocotb_tools.pytest.plugin --junit-xml=junit.result.xml

.PHONY: test-with-pytest-runner
test-with-pytest-plugin: $(WORKDIR)/.venv/bin/activate
	. "$^"; pytest -p cocotb_tools.pytest.plugin --junit-xml=junit.xml --override-ini=junit_logging=all
