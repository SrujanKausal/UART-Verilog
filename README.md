# UART-Verilog

An 8-bit UART (Universal Asynchronous Receiver/Transmitter) implemented using Verilog HDL, featuring a configurable baud-rate generator, transmitter, receiver, top-level integration, and simulation-based verification.

## Overview
This project implements an 8-bit full-duplex UART communication system using Verilog HDL.
The design consists of separate RTL modules for baud-rate generation, UART transmission, UART reception, and top-level integration.
The design was developed and verified using AMD Vivado behavioral simulation.
A self-checking testbench is used to generate multiple 8-bit test values and automatically compare the received data with the expected transmitted data.

## Features
* **8-Bit Data Frame**: Standard 8-N-1 UART frame configuration (1 Start bit, 8 Data bits, 1 Stop bit).
* **FSM Architecture**: Robust Finite State Machine implementations for both TX and RX modules.
* **Mid-Bit Oversampling**: Receiver samples incoming serial data at the center of each bit period to maximize noise immunity.
* **Self-Checking Testbench**: Automated verification using randomized 8-bit vectors (`$random`) with automated `PASS`/`FAIL` reporting.
* **Vivado Integration**: Fully simulated and validated using AMD Vivado Behavioral Simulator.

---

## Design Architecture

```text
                         +------------------+
                         |  Baud Generator  |
                         +--------+---------+
                                  |
                              baud_tick
                                  |
                    +-------------+-------------+
                    |                           |
                    v                           v
              +-----------+               +-----------+
              |  UART TX  |      TX       |  UART RX  |
              |           +-------------->|           |
              +-----------+               +-----------+
                    |                           |
                    +-------------+-------------+
                                  |
                                  v
                           +-------------+
                           |  UART Top   |
                           +-------------+

```

---

## RTL Modules

* **`baud_gen.v`**: Generates the sampling tick pulse (`baud_tick`) used by the UART transmitter and receiver based on the input clock frequency.
* **`uart_tx.v`**: Implements the transmitter state machine (`IDLE` $\longrightarrow$ `START` $\longrightarrow$ `DATA` $\longrightarrow$ `STOP` $\longrightarrow$ `IDLE`). Handles start bit assertion, LSB-first data serialization, stop bit timing, and driving the `busy` signal.
* **`uart_rx.v`**: Implements the receiver state machine. Detects start bits, mid-samples incoming serial data, and reconstructs the byte. Asserts `data_valid` when a byte is ready.
* **`uart_top.v`**: Top-level module connecting `baud_gen`, `uart_tx`, and `uart_rx` in a loopback setup.

---

## Verification & Testbench Flow

```text
   Expected Data
         ↓
      UART TX
         ↓
    Serial Line
         ↓
      UART RX
         ↓
    Received Data
         ↓
    PASS / FAIL

```

The top-level testbench (`uart_top_tb.v`) executes 20 randomized data transmissions. Handshaking with `busy` ensures clean transmission cycles without timing collisions.

### Sample Console Output

```text
TEST 1 PASS --- sent=24 received=24
TEST 2 PASS --- sent=81 received=81
...
TEST 20 PASS --- sent=77 received=77
$finish called at time : 10390035 ns

```

---

## Tools Used

* **HDL Language**: Verilog-2001
* **EDA Tool**: AMD / Xilinx Vivado (2025.2)
* **Simulator**: Vivado Simulator (XSim)
* **Version Control**: Git / GitHub

---
