// ==============================================================
// Generated by Vitis HLS v2024.1
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
module ChannelwiseOp_hls_0_threshs_34_ROM_2P_LUTRAM_1R (
    address0, ce0, q0, 
    reset, clk);

parameter DataWidth = 4;
parameter AddressWidth = 5;
parameter AddressRange = 27;
 
input[AddressWidth-1:0] address0;
input ce0;
output reg[DataWidth-1:0] q0;

input reset;
input clk;

 
(* rom_style = "distributed" *)reg [DataWidth-1:0] rom0[0:AddressRange-1];


initial begin
     
    $readmemh("/home/phu/repos/PytorchModClassNew/radio-finn/notebooks/Radio_27ML/tmp//code_gen_ipgen_ChannelwiseOp_hls_0_0b019d6v/project_ChannelwiseOp_hls_0/sol1/impl/ip/hdl/verilog/ChannelwiseOp_hls_0_threshs_34_ROM_2P_LUTRAM_1R.dat", rom0);
end

  
always @(posedge clk) 
begin 
    if (ce0) 
    begin
        q0 <= rom0[address0];
    end
end


endmodule
