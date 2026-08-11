# UART-Verilog

An 8-bit UART (Universal Asynchronous Receiver/Transmitter) implemented using Verilog HDL, featuring a baud-rate generator, transmitter, receiver, top-level integration, and simulation-based verification.

## Overview

This project implements an 8-bit UART communication system using Verilog HDL.

The design consists of separate RTL modules for baud-rate generation, UART transmission, UART reception, and top-level integration.

The design was developed and verified using AMD Vivado behavioral simulation.

A self-checking testbench is used to generate multiple 8-bit test values and automatically compare the received data with the expected transmitted data.

## Features

- **8-Bit Data Frame:** Standard 8-N-1 UART frame configuration consisting of 1 start bit, 8 data bits, and 1 stop bit.
- **FSM-Based Architecture:** Finite State Machine implementations for UART TX and RX.
- **LSB-First Transmission:** Data bits are transmitted starting with the least significant bit.
- **Mid-Bit Sampling:** The receiver validates the start bit near its center and samples subsequent data bits at their bit intervals.
- **Self-Checking Testbench:** Automated verification using randomized 8-bit vectors with `$random`.
- **PASS/FAIL Reporting:** Automatically compares transmitted and received data.
- **Loopback Verification:** UART TX output is internally connected to UART RX for end-to-end verification.
- **Vivado Simulation:** Verified using AMD Vivado behavioral simulation.

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
         |  UART TX  |     TX        |  UART RX  |
         |           +-------------->|           |
         +-----------+   loopback    +-----------+
               |                           |
               +-------------+-------------+
                             |
                             v
                      +-------------+
                      |   UART Top  |
                      +-------------+
UART Frame Format
      Start        8 Data Bits          Stop
        |       LSB              MSB      |
        v        v                 v       v
       +---+----+----+----+----+----+----+----+----+---+
       | 0 | D0 | D1 | D2 | D3 | D4 | D5 | D6 | D7 | 1 |
       +---+----+----+----+----+----+----+----+----+---+
RTL Modules
baud_gen.v

Generates the baud-rate timing tick (baud_tick) used by the UART transmitter and receiver.

The baud generator uses a counter driven by the system clock and generates a single-cycle tick when the configured count is reached.

uart_tx.v

Implements the UART transmitter using a finite state machine:

IDLE → START → DATA → STOP → IDLE

The transmitter handles:

Idle state
Start-bit transmission
8-bit data transmission
Stop-bit transmission
Busy status indication
LSB-first serialization
uart_rx.v

Implements the UART receiver using a finite state machine.

The receiver:

Detects the start bit
Validates the start bit near its center
Samples the incoming data bits
Reconstructs the 8-bit parallel data
Validates the stop bit
Generates data_valid when a complete byte is received
uart_top.v

The top-level module integrates:

Baud-rate generator
UART transmitter
UART receiver

The transmitter output is internally connected to the receiver input to create a loopback path for end-to-end verification.

Verification & Testbench

The project includes individual testbenches for the RTL modules and a top-level self-checking testbench.

Top-Level Verification Flow
Generate Random 8-bit Data
          ↓
       UART TX
          ↓
   Serial Loopback
          ↓
       UART RX
          ↓
   Received Data
          ↓
Compare with Expected Data
          ↓
      PASS / FAIL

The top-level testbench (uart_top_tb.v) performs multiple randomized 8-bit data transmissions.

For each test:

Generate a random 8-bit value.
Apply the value to the UART transmitter.
Wait for the transmitter to be ready.
Start the transmission.
Wait for the receiver to indicate valid data.
Compare the received value with the expected value.
Display the test result automatically.
Example Console Output
TEST 1 PASS---sent=24 received=24
TEST 2 PASS---sent=81 received=81
TEST 3 PASS---sent=A5 received=A5
...
TEST 20 PASS---sent=77 received=77

The testbench uses the transmitter's busy signal to ensure that a new transmission is started only after the previous transmission has completed.

Repository Structure
UART-Verilog/
│
├── RTL/
│   ├── baud_gen.v
│   ├── uart_rx.v
│   ├── uart_top.v
│   └── uart_tx.v
│
├── TB/
│   ├── baud_gen_tb.v
│   ├── uart_rx_tb.v
│   ├── uart_top_tb.v
│   └── uart_tx_tb.v
│
├── .gitignore
├── UART.xpr
└── README.md
Tools Used
HDL: Verilog
EDA Tool: AMD Vivado
Simulator: Vivado Simulator (XSim)
Version Control: Git
Repository: GitHub
How to Run
1. Clone the Repository
git clone https://github.com/SrujanKausal/UART-Verilog.git
2. Open the Vivado Project

Open UART.xpr using AMD Vivado.

3. Select the Testbench

In the Vivado Sources pane, select uart_top_tb as the simulation top module.

4. Run Behavioral Simulation

Select:

Run Simulation → Run Behavioral Simulation

5. Observe the Results

Observe the UART waveforms in the simulation window and check the simulation console for the automated PASS/FAIL results.

Project Status

Completed

UART RTL implementation
Baud-rate generator
UART transmitter
UART receiver
Top-level integration
Individual module testbenches
Randomized self-checking top-level testbench
End-to-end UART loopback verification
GitHub project organization
