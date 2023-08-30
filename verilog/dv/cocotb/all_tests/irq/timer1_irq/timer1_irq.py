from caravel_cocotb.caravel_interfaces import test_configure
from caravel_cocotb.caravel_interfaces import report_test
import cocotb
from openframe import OpenFrame
from cocotb.triggers import Edge, Combine, First, NextTimeStep

counter_start_time = 0
counter_finish_time = 0
trigger_time = 0

@cocotb.test()
@report_test
async def timer1_irq(dut):
    caravelEnv = await test_configure(dut, timeout_cycles=153546)
    openframe = OpenFrame(caravelEnv)
    wait_interrupt = await cocotb.start(wait_for_interrupt(openframe))
    watch_counter = await cocotb.start(watch_counter_val(dut))
    await Combine(wait_interrupt, watch_counter)
    if counter_start_time < counter_finish_time and counter_finish_time < trigger_time:
        cocotb.log.info(f"[TEST] counter starts at {counter_start_time} and finishes at {counter_finish_time} and interrupt happened at {trigger_time}")
    else:
        cocotb.log.error(f"[TEST] something went wrong, counter starts at {counter_start_time} and finishes at {counter_finish_time} and interrupt happened at {trigger_time}")


async def watch_counter_val(dut):
    if "GL" not in cocotb.plusargs:
        counter_val_hdl = dut.uut.user_project.openframe_example.counter_timer_1.counter_timer_high_inst.value_cur
    else:
        example_hdl = dut.uut.user_project.openframe_example
        counter_val_hdl = [example_hdl._id(f"\counter_timer_1.counter_timer_high_inst.reg_dat_do[{i}] ", False) for i in range(32)]
    counter_started = False
    while True:
        if "GL" not in cocotb.plusargs:
            await Edge(counter_val_hdl)
            counter_val = counter_val_hdl.value
        else:
            await First(*[Edge(counter_val_hdl[i]) for i in range(32)])
            await NextTimeStep()
            counter_val = int("".join([counter_val_hdl[i].value.binstr for i in range(32)])[::-1], 2)
        cocotb.log.debug(f"[watch_counter_val] counter_val = {hex(counter_val)}")
        if not counter_started:
            if counter_val == 0x5F:
                counter_started = True
                global counter_start_time
                counter_start_time = cocotb.utils.get_sim_time("ns")
                cocotb.log.info("[watch_counter_val] counter_started")
        else:
            if counter_val == 0x00:
                global counter_finish_time
                counter_finish_time = cocotb.utils.get_sim_time("ns")
                cocotb.log.info("[watch_counter_val] counter_finished")
                break


async def wait_for_interrupt(openframe):
    await openframe.wait_reg1(0xbC)
    cocotb.log.info("[wait_for_interrupt] trigger interrupt")
    global trigger_time
    trigger_time = cocotb.utils.get_sim_time("ns")
