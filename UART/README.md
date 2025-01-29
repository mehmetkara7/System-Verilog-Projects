# UART SystemVerilog Implementation

This repository contains a simple UART (Universal Asynchronous Receiver Transmitter) implementation in SystemVerilog, including both transmission (TX) and reception (RX) modules, along with a testbench for simulation.

## Features

### UART Transmitter (uart_tx)
- Sends 8-bit data with start and stop bits.
- Configurable baud rate through `clk_div`.
- Outputs a `tx` signal for serial communication.

### UART Receiver (uart_rx)
- Receives 8-bit data, detecting start and stop bits.
- Configurable baud rate for synchronization.
- Provides `rx_dout` and `rx_done` signals.

## File Overview
- `uart_tx.sv`: UART Transmitter module.
- `uart_rx.sv`: UART Receiver module.
- `tb_uart.sv`: Testbench for verifying the TX and RX functionality.
