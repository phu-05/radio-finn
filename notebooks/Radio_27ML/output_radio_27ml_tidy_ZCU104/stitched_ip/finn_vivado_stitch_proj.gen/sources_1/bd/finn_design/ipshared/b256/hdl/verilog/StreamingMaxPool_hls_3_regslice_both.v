// ==============================================================
// Generated by Vitis HLS v2024.1
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// ==============================================================
// 67d7842dbbe25473c3c32b93c0da8047785f30d78e8a024de1b57352245f9689
`timescale 1ns/1ps

module StreamingMaxPool_hls_3_regslice_both
#(parameter
    DataWidth = 8
) (
    // system signals
    input  wire                  ap_clk,
    input  wire                  ap_rst,
    // slave side
    input  wire [DataWidth-1:0]  data_in,
    input  wire                  vld_in,
    output wire                  ack_in,
    // master side
    output wire [DataWidth-1:0]  data_out,
    output wire                  vld_out,
    input  wire                  ack_out,
    output wire                  apdone_blk);
    //------------------------Parameter----------------------
    // state
    localparam [1:0]
        ZERO = 2'b10,
        ONE  = 2'b11,
        TWO  = 2'b01;
    //------------------------Local signal-------------------
    reg  [DataWidth-1:0] data_p1;
    reg  [DataWidth-1:0] data_p2;
    wire         load_p1;
    wire         load_p2;
    wire         load_p1_from_p2;
    reg          ack_in_t;
    reg  [1:0]   state;
    reg  [1:0]   next;
    //------------------------Body---------------------------
    assign ack_in = ack_in_t;
    assign data_out = data_p1;
    assign vld_out = state[0];
    assign apdone_blk = (state == ONE && ~ack_out) || (state == TWO);

    assign load_p1 = (state == ZERO && vld_in) ||
                    (state == ONE && vld_in && ack_out) ||
                    (state == TWO && ack_out);
    assign load_p2 = vld_in & ack_in;
    assign load_p1_from_p2 = (state == TWO);

    // data_p1
    always @(posedge ap_clk) begin
        if (load_p1) begin
            if (load_p1_from_p2)
                data_p1 <= data_p2;
            else
                data_p1 <= data_in;
        end
    end

    // data_p2
    always @(posedge ap_clk) begin
        if (load_p2) data_p2 <= data_in;
    end

    // ack_in_t
    always @(posedge ap_clk) begin
        if (ap_rst)
            ack_in_t <= 1'b0;
        else if (state == ZERO)
            ack_in_t <= 1'b1;
        else if (state == ONE && next == TWO)
            ack_in_t <= 1'b0;
        else if (state == TWO && next == ONE)
            ack_in_t <= 1'b1;
    end

    // state
    always @(posedge ap_clk) begin
        if (ap_rst)
            state <= ZERO;
        else
            state <= next;
    end

    // next
    always @(*) begin
        case (state)
            ZERO:
                if (vld_in & ack_in)
                    next = ONE;
                else
                    next = ZERO;
            ONE:
                if (~vld_in & ack_out)
                    next = ZERO;
                else if (vld_in & ~ack_out)
                    next = TWO;
                else
                    next = ONE;
            TWO:
                if (ack_out)
                    next = ONE;
                else
                    next = TWO;
            default:
                next = ZERO;
        endcase
    end
endmodule
