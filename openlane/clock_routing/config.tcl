# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0


set ::env(DESIGN_NAME) clock_routing
set ::env(DESIGN_IS_CORE) 0

set ::env(VERILOG_FILES) "\
	$::env(DESIGN_DIR)/../../verilog/rtl/clock_routing.v"

set ::env(CLOCK_PORT) "ext_clk"
set ::env(CLOCK_NET) "ext_clk core_clk pll_clk pll_clk90"

set ::env(ROUTING_CORES) "16"
set ::env(RUN_KLAYOUT) 0

## Synthesis
set ::env(SYNTH_STRATEGY) "DELAY 0"
set ::env(RUN_CTS) 1
set ::env(SYNTH_SIZING) 0
set ::env(SYNTH_BUFFERING) 0

set ::env(BASE_SDC_FILE) $::env(DESIGN_DIR)/base.sdc 

set ::env(FP_PIN_ORDER_CFG) $::env(DESIGN_DIR)/pin_order.cfg

## Floorplan
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 200 200"

## PDN
set ::env(FP_PDN_HPITCH) 16.9
set ::env(FP_PDN_VPITCH) 15.5
set ::env(FP_PDN_HSPACING) 6.85
set ::env(FP_PDN_VSPACING) 6.15
set ::env(FP_PDN_HOFFSET) 5.73
set ::env(FP_PDN_VOFFSET) 7.63
# vertical 21.29 15.61

## Placement
set ::env(PL_TARGET_DENSITY) 0.60

set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 1
# set ::env(PL_RESIZER_BUFFER_OUTPUT_PORTS) 0
set ::env(GLB_RESIZER_HOLD_SLACK_MARGIN) 0.25

## CTS
set ::env(CTS_MAX_CAP) 0.15
set ::env(CTS_CLK_MAX_WIRE_LENGTH) 200

## Routing
set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 1

## Diode Insertion
set ::env(GRT_REPAIR_ANTENNAS) 1
set ::env(RUN_HEURISTIC_DIODE_INSERTION) 1

set ::env(SYNTH_EXTRA_MAPPING_FILE) $::env(SYNTH_MUX_MAP)
set ::env(RSZ_DONT_TOUCH_RX) "core_clk|user_clk"
set ::env(RSZ_USE_OLD_REMOVER) 1
set ::env(FP_PDN_SKIP_TRIM) 1

set ::env(SYNTH_EXTRA_MAPPING_FILE) $::env(DESIGN_DIR)/mux2_map.v
set ::env(MAX_FANOUT_CONSTRAINT) 12
set ::env(MAX_TRANSITION_CONSTRAINT) 0.50