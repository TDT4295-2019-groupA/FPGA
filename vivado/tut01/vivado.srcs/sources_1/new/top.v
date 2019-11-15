module DACInterface(
  input         clock,
  input         io_BCLK,
  input         io_enable,
  input  [31:0] io_sample,
  output        io_bit
);
  reg [32:0] sample_reg;
  reg [63:0] _RAND_0;
  reg  prev_bit;
  reg [31:0] _RAND_1;
  wire  _T_20;
  wire  _T_21;
  wire [33:0] _GEN_6;
  wire [33:0] _T_24;
  wire  _T_26;
  wire [32:0] _GEN_7;
  wire [32:0] _T_27;
  wire  _GEN_1;
  wire [31:0] _T_23;
  wire [32:0] _GEN_2;
  assign _T_20 = io_BCLK == 1'h0;
  assign _T_21 = sample_reg[31];
  assign _GEN_6 = {{1'd0}, sample_reg};
  assign _T_24 = _GEN_6 << 1;
  assign _T_26 = io_sample[31];
  assign _GEN_7 = {{1'd0}, io_sample};
  assign _T_27 = _GEN_7 << 1;
  assign _GEN_1 = io_enable ? _T_26 : _T_21;
  assign _T_23 = _T_24[31:0];
  assign _GEN_2 = io_enable ? _T_27 : {{1'd0}, _T_23};
  assign io_bit = _T_20 ? _GEN_1 : prev_bit;
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  sample_reg = _RAND_0[32:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  prev_bit = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (_T_20) begin
      if (io_enable) begin
        sample_reg <= _T_27;
      end else begin
        sample_reg <= {{1'd0}, _T_23};
      end
    end
    prev_bit <= io_bit;
  end
endmodule
module Codec(
  input         clock,
  input  [31:0] io_dac_in,
  output        io_BCLK,
  output        io_LRCLK,
  output        io_dac_out
);
  wire  DACInterface_clock;
  wire  DACInterface_io_BCLK;
  wire  DACInterface_io_enable;
  wire [31:0] DACInterface_io_sample;
  wire  DACInterface_io_bit;
  reg  BCLK;
  reg [31:0] _RAND_0;
  reg  LRCLK;
  reg [31:0] _RAND_1;
  reg [5:0] bit_count;
  reg [31:0] _RAND_2;
  wire [6:0] _T_22;
  wire [5:0] _T_23;
  wire  _T_25;
  wire  _T_27;
  wire  _GEN_0;
  wire [5:0] _GEN_1;
  DACInterface DACInterface (
    .clock(DACInterface_clock),
    .io_BCLK(DACInterface_io_BCLK),
    .io_enable(DACInterface_io_enable),
    .io_sample(DACInterface_io_sample),
    .io_bit(DACInterface_io_bit)
  );
  assign _T_22 = bit_count + 6'h1;
  assign _T_23 = bit_count + 6'h1;
  assign _T_25 = bit_count == 6'h1f;
  assign _T_27 = LRCLK == 1'h0;
  assign _GEN_0 = _T_25 ? _T_27 : LRCLK;
  assign _GEN_1 = _T_25 ? 6'h0 : _T_23;
  assign io_BCLK = BCLK;
  assign io_LRCLK = LRCLK;
  assign io_dac_out = DACInterface_io_bit;
  assign DACInterface_clock = clock;
  assign DACInterface_io_BCLK = BCLK;
  assign DACInterface_io_enable = bit_count == 6'h0;
  assign DACInterface_io_sample = io_dac_in;
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  BCLK = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  LRCLK = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  bit_count = _RAND_2[5:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    BCLK <= BCLK == 1'h0;
    if (BCLK) begin
      if (_T_25) begin
        LRCLK <= _T_27;
      end
    end
    if (BCLK) begin
      if (_T_25) begin
        bit_count <= 6'h0;
      end else begin
        bit_count <= _T_23;
      end
    end
  end
endmodule
module Top(
  input   clock,
  input   reset,
  output  io_SystemClock,
  output  io_BitClock,
  output  io_BitClockDebug,
  output  io_LeftRightWordClock,
  output  io_LeftRightWordClockDebug,
  output  io_DataBit,
  output  io_DataBitDebug,
  output  io_gpio
);
  wire  mmcm_CLKIN1;
  wire  mmcm_RST;
  wire  mmcm_PWRDWN;
  wire  mmcm_CLKFBIN;
  wire  mmcm_CLKFBOUT;
  wire  mmcm_CLKFBOUTB;
  wire  mmcm_LOCKED;
  wire  mmcm_CLKOUT0;
  wire  mmcm_CLKOUT0B;
  wire  mmcm_CLKOUT1;
  wire  mmcm_CLKOUT1B;
  wire  mmcm_CLKOUT2;
  wire  mmcm_CLKOUT2B;
  wire  mmcm_CLKOUT3;
  wire  mmcm_CLKOUT3B;
  wire  mmcm_CLKOUT4;
  wire  mmcm_CLKOUT5;
  wire  mmcm_CLKOUT6;
  wire  Codec_clock;
  wire [31:0] Codec_io_dac_in;
  wire  Codec_io_BCLK;
  wire  Codec_io_LRCLK;
  wire  Codec_io_dac_out;
  reg [23:0] value;
  reg [31:0] _RAND_0;
  wire  _T_27;
  wire [24:0] _T_29;
  wire [23:0] _T_30;
  wire [23:0] _GEN_0;
  wire  _T_35;
  reg [31:0] _T_45;
  reg [31:0] _RAND_1;
  reg [31:0] _T_51;
  reg [31:0] _RAND_2;
  wire [32:0] _T_53;
  wire [31:0] _T_54;
  wire  _T_56;
  wire [32:0] _T_59;
  wire [31:0] _T_60;
  wire [31:0] _T_61;
  wire [31:0] _GEN_5;
  MMCME2_BASE #(.CLKOUT5_PHASE(0.0), .CLKOUT5_DIVIDE(1), .CLKOUT3_DIVIDE(1), .CLKIN1_PERIOD(62.5), .CLKOUT2_DIVIDE(1), .CLKOUT0_PHASE(0.0), .CLKFBOUT_MULT_F(42.336), .CLKOUT4_DIVIDE(2), .CLKOUT6_DIVIDE(60), .CLKOUT6_DUTY_CYCLE(0.5), .CLKOUT1_PHASE(0.0), .CLKOUT4_PHASE(0.0), .CLKOUT5_DUTY_CYCLE(0.5), .CLKOUT6_PHASE(0.0), .CLKOUT1_DIVIDE(1), .CLKOUT3_DUTY_CYCLE(0.5), .CLKOUT4_CASCADE("TRUE"), .CLKOUT2_DUTY_CYCLE(0.5), .CLKOUT0_DIVIDE_F(1.0), .CLKOUT1_DUTY_CYCLE(0.5), .CLKOUT3_PHASE(0.0), .CLKOUT0_DUTY_CYCLE(0.5), .CLKOUT2_PHASE(0.0), .DIVCLK_DIVIDE(1), .CLKOUT4_DUTY_CYCLE(0.5)) mmcm (
    .CLKIN1(mmcm_CLKIN1),
    .RST(mmcm_RST),
    .PWRDWN(mmcm_PWRDWN),
    .CLKFBIN(mmcm_CLKFBIN),
    .CLKFBOUT(mmcm_CLKFBOUT),
    .CLKFBOUTB(mmcm_CLKFBOUTB),
    .LOCKED(mmcm_LOCKED),
    .CLKOUT0(mmcm_CLKOUT0),
    .CLKOUT0B(mmcm_CLKOUT0B),
    .CLKOUT1(mmcm_CLKOUT1),
    .CLKOUT1B(mmcm_CLKOUT1B),
    .CLKOUT2(mmcm_CLKOUT2),
    .CLKOUT2B(mmcm_CLKOUT2B),
    .CLKOUT3(mmcm_CLKOUT3),
    .CLKOUT3B(mmcm_CLKOUT3B),
    .CLKOUT4(mmcm_CLKOUT4),
    .CLKOUT5(mmcm_CLKOUT5),
    .CLKOUT6(mmcm_CLKOUT6)
  );
  Codec Codec (
    .clock(Codec_clock),
    .io_dac_in(Codec_io_dac_in),
    .io_BCLK(Codec_io_BCLK),
    .io_LRCLK(Codec_io_LRCLK),
    .io_dac_out(Codec_io_dac_out)
  );
  assign _T_27 = value == 24'hf423ff;
  assign _T_29 = value + 24'h1;
  assign _T_30 = value + 24'h1;
  assign _GEN_0 = _T_27 ? 24'h0 : _T_30;
  assign _T_35 = value >= 24'h7a1200;
  assign _T_53 = _T_51 + 32'h1;
  assign _T_54 = _T_51 + 32'h1;
  assign _T_56 = _T_51 >= 32'hc87;
  assign _T_59 = $signed(32'sh0) - $signed(_T_45);
  assign _T_60 = $signed(32'sh0) - $signed(_T_45);
  assign _T_61 = $signed(_T_60);
  assign _GEN_5 = _T_56 ? $signed(_T_61) : $signed(_T_45);
  assign io_SystemClock = mmcm_CLKOUT6;
  assign io_BitClock = Codec_io_BCLK;
  assign io_BitClockDebug = Codec_io_BCLK;
  assign io_LeftRightWordClock = Codec_io_LRCLK;
  assign io_LeftRightWordClockDebug = Codec_io_LRCLK;
  assign io_DataBit = Codec_io_dac_out;
  assign io_DataBitDebug = Codec_io_dac_out;
  assign io_gpio = _T_35 ? 1'h0 : 1'h1;
  assign mmcm_CLKIN1 = clock;
  assign mmcm_RST = 1'h0;
  assign mmcm_PWRDWN = 1'h0;
  assign mmcm_CLKFBIN = mmcm_CLKFBOUT;
  assign Codec_clock = mmcm_CLKOUT4;
  assign Codec_io_dac_in = $unsigned(_T_45);
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  value = _RAND_0[23:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  _T_45 = _RAND_1[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_51 = _RAND_2[31:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      value <= 24'h0;
    end else begin
      if (_T_27) begin
        value <= 24'h0;
      end else begin
        value <= _T_30;
      end
    end
  end
  always @(posedge mmcm_CLKOUT4) begin
    if (reset) begin
      _T_45 <= 32'sh33333333;
    end else begin
      if (_T_56) begin
        _T_45 <= _T_61;
      end
    end
    if (_T_56) begin
      _T_51 <= 32'h0;
    end else begin
      _T_51 <= _T_54;
    end
  end
endmodule
module TopModule(
  input   clock,
  input   reset,
  output  io_SystemClock,
  output  io_BitClock,
  output  io_BitClockDebug,
  output  io_LeftRightWordClock,
  output  io_LeftRightWordClockDebug,
  output  io_DataBit,
  output  io_DataBitDebug,
  output  io_gpio
);
  wire  Top_clock;
  wire  Top_reset;
  wire  Top_io_SystemClock;
  wire  Top_io_BitClock;
  wire  Top_io_BitClockDebug;
  wire  Top_io_LeftRightWordClock;
  wire  Top_io_LeftRightWordClockDebug;
  wire  Top_io_DataBit;
  wire  Top_io_DataBitDebug;
  wire  Top_io_gpio;
  Top Top (
    .clock(Top_clock),
    .reset(Top_reset),
    .io_SystemClock(Top_io_SystemClock),
    .io_BitClock(Top_io_BitClock),
    .io_BitClockDebug(Top_io_BitClockDebug),
    .io_LeftRightWordClock(Top_io_LeftRightWordClock),
    .io_LeftRightWordClockDebug(Top_io_LeftRightWordClockDebug),
    .io_DataBit(Top_io_DataBit),
    .io_DataBitDebug(Top_io_DataBitDebug),
    .io_gpio(Top_io_gpio)
  );
  assign io_SystemClock = Top_io_SystemClock;
  assign io_BitClock = Top_io_BitClock;
  assign io_BitClockDebug = Top_io_BitClockDebug;
  assign io_LeftRightWordClock = Top_io_LeftRightWordClock;
  assign io_LeftRightWordClockDebug = Top_io_LeftRightWordClockDebug;
  assign io_DataBit = Top_io_DataBit;
  assign io_DataBitDebug = Top_io_DataBitDebug;
  assign io_gpio = Top_io_gpio;
  assign Top_clock = clock;
  assign Top_reset = reset;
endmodule
////////////////////////////////////////////////////////////////////////////////
////                                                                        ////
//// Project Name: SPI (Verilog)                                            ////
////                                                                        ////
//// Module Name: spi_slave                                                 ////
////                                                                        ////
////                                                                        ////
////  This file is part of the Ethernet IP core project                     ////
////  https://opencores.org/projects/spi_verilog_master_slave               ////
////                                                                        ////
////  Author(s):                                                            ////
////      Santhosh G (santhg@opencores.org)                                 ////
////                                                                        ////
////  Refer to Readme.txt for more information                              ////
////                                                                        ////
////////////////////////////////////////////////////////////////////////////////
////                                                                        ////
//// Copyright (C) 2014, 2015 Authors                                       ////
////                                                                        ////
//// This source file may be used and distributed without                   ////
//// restriction provided that this copyright statement is not              ////
//// removed from the file and that any derivative work contains            ////
//// the original copyright notice and the associated disclaimer.           ////
////                                                                        ////
//// This source file is free software; you can redistribute it             ////
//// and/or modify it under the terms of the GNU Lesser General             ////
//// Public License as published by the Free Software Foundation;           ////
//// either version 2.1 of the License, or (at your option) any             ////
//// later version.                                                         ////
////                                                                        ////
//// This source is distributed in the hope that it will be                 ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied             ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR                ////
//// PURPOSE.  See the GNU Lesser General Public License for more           ////
//// details.                                                               ////
////                                                                        ////
//// You should have received a copy of the GNU Lesser General              ////
//// Public License along with this source; if not, download it             ////
//// from http://www.opencores.org/lgpl.shtml                               ////
////                                                                        ////
////////////////////////////////////////////////////////////////////////////////
/* SPI MODE 3
		CHANGE DATA (sdout) @ NEGEDGE SCK
		read data (sdin) @posedge SCK
*/		
module spi_slave (rstb,ten,tdata,mlb,ss,sck,sdin, sdout,done,rdata);
  input rstb,ss,sck,sdin,ten,mlb;
  input [7:0] tdata;
  output sdout;           //slave out   master in 
  output reg done;
  output reg [7:0] rdata;
 
  reg [7:0] treg,rreg;
  reg [3:0] nb;
  wire sout;
 
  assign sout=mlb?treg[7]:treg[0];
  assign sdout=( (!ss)&&ten )?sout:1'bz; //if 1=> send data  else TRI-STATE sdout
 
 
//read from  sdout
always @(posedge sck or negedge rstb)
  begin
    if (rstb==0)
		begin rreg = 8'h00;  rdata = 8'h00; done = 0; nb = 0; end   //
	else if (!ss) begin 
			if(mlb==0)  //LSB first, in@msb -> right shift
				begin rreg ={sdin,rreg[7:1]}; end
			else     //MSB first, in@lsb -> left shift
				begin rreg ={rreg[6:0],sdin}; end  
		//increment bit count
			nb=nb+1;
			if(nb!=8) done=0;
			else  begin rdata=rreg; done=1; nb=0; end
		end	 //if(!ss)_END  if(nb==8)
  end
 
//send to  sdout
always @(negedge sck or negedge rstb)
  begin
	if (rstb==0)
		begin treg = 8'hFF; end
	else begin
		if(!ss) begin			
			if(nb==0) treg=tdata;
			else begin
			   if(mlb==0)  //LSB first, out=lsb -> right shift
					begin treg = {1'b1,treg[7:1]}; end
			   else     //MSB first, out=msb -> left shift
					begin treg = {treg[6:0],1'b1}; end			
			end
		end //!ss
	 end //rstb	
  end //always
 
endmodule
 
/*
			if(mlb==0)  //LSB first, out=lsb -> right shift
					begin treg = {treg[7],treg[7:1]}; end
			else     //MSB first, out=msb -> left shift
					begin treg = {treg[6:0],treg[0]}; end	
*/
 
 
/*
force -freeze sim:/SPI_slave/sck 0 0, 1 {25 ns} -r 50 -can 410
run 405ns
noforce sim:/SPI_slave/sck
force -freeze sim:/SPI_slave/sck 1 0
*/
////////////////////////////////////////////////////////////////////////////////
////                                                                        ////
//// Project Name: SPI (Verilog)                                            ////
////                                                                        ////
//// Module Name: spi_master                                                ////
////                                                                        ////
////                                                                        ////
////  This file is part of the Ethernet IP core project                     ////
////  http://opencores.com/project,spi_verilog_master_slave                 ////
////                                                                        ////
////  Author(s):                                                            ////
////      Santhosh G (santhg@opencores.org)                                 ////
////                                                                        ////
////  Refer to Readme.txt for more information                              ////
////                                                                        ////
////////////////////////////////////////////////////////////////////////////////
////                                                                        ////
//// Copyright (C) 2014, 2015 Authors                                       ////
////                                                                        ////
//// This source file may be used and distributed without                   ////
//// restriction provided that this copyright statement is not              ////
//// removed from the file and that any derivative work contains            ////
//// the original copyright notice and the associated disclaimer.           ////
////                                                                        ////
//// This source file is free software; you can redistribute it             ////
//// and/or modify it under the terms of the GNU Lesser General             ////
//// Public License as published by the Free Software Foundation;           ////
//// either version 2.1 of the License, or (at your option) any             ////
//// later version.                                                         ////
////                                                                        ////
//// This source is distributed in the hope that it will be                 ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied             ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR                ////
//// PURPOSE.  See the GNU Lesser General Public License for more           ////
//// details.                                                               ////
////                                                                        ////
//// You should have received a copy of the GNU Lesser General              ////
//// Public License along with this source; if not, download it             ////
//// from http://www.opencores.org/lgpl.shtml                               ////
////                                                                        ////
////////////////////////////////////////////////////////////////////////////////
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  SPI MODE 3
		CHANGE DATA @ NEGEDGE
		read data @posedge
 
 RSTB-active low asyn reset, CLK-clock, T_RB=0-rx  1-TX, mlb=0-LSB 1st 1-msb 1st
 START=1- starts data transmission cdiv 0=clk/4 1=/8   2=/16  3=/32
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
module spi_master(rstb,clk,mlb,start,tdat,cdiv,din, ss,sck,dout,done,rdata);
    input rstb,clk,mlb,start;
    input [7:0] tdat;  //transmit data
    input [1:0] cdiv;  //clock divider
	input din;
	output reg ss; 
	output reg sck; 
	output reg dout; 
    output reg done;
	output reg [7:0] rdata; //received data
 
parameter idle=2'b00;		
parameter send=2'b10; 
parameter finish=2'b11; 
reg [1:0] cur,nxt;
 
	reg [7:0] treg,rreg;
	reg [3:0] nbit;
	reg [4:0] mid,cnt;
	reg shift,clr;
 
//FSM i/o
always @(start or cur or nbit or cdiv or rreg) begin
		 nxt=cur;
		 clr=0;  
		 shift=0;//ss=0;
		 case(cur)
			idle:begin
				if(start==1)
		               begin 
							 case (cdiv)
								2'b00: mid=2;
								2'b01: mid=4;
								2'b10: mid=8;
								2'b11: mid=16;
 							 endcase
						shift=1;
						done=1'b0;
						nxt=send;	 
						end
		        end //idle
			send:begin
				ss=0;
				if(nbit!=8)
					begin shift=1; end
				else begin
						rdata=rreg;done=1'b1;
						nxt=finish;
					end
				end//send
			finish:begin
					shift=0;
					ss=1;
					clr=1;
					nxt=idle;
				 end
			default: nxt=finish;
      endcase
    end//always
 
//state transistion
always@(negedge clk or negedge rstb) begin
 if(rstb==0) 
   cur<=finish;
 else 
   cur<=nxt;
 end
 
//setup falling edge (shift dout) sample rising edge (read din)
always@(negedge clk or posedge clr) begin
  if(clr==1) 
		begin cnt=0; sck=1; end
  else begin
	if(shift==1) begin
		cnt=cnt+1; 
	  if(cnt==mid) begin
	  	sck=~sck;
		cnt=0;
		end //mid
	end //shift
 end //rst
end //always
 
//sample @ rising edge (read din)
always@(posedge sck or posedge clr ) begin // or negedge rstb
 if(clr==1)  begin
			nbit=0;  rreg=8'hFF;  end
    else begin 
		  if(mlb==0) //LSB first, din@msb -> right shift
			begin  rreg={din,rreg[7:1]};  end 
		  else  //MSB first, din@lsb -> left shift
			begin  rreg={rreg[6:0],din};  end
		  nbit=nbit+1;
 end //rst
end //always
 
always@(negedge sck or posedge clr) begin
 if(clr==1) begin
	  treg=8'hFF;  dout=1;  
  end  
 else begin
		if(nbit==0) begin //load data into TREG
			treg=tdat; dout=mlb?treg[7]:treg[0];
		end //nbit_if
		else begin
			if(mlb==0) //LSB first, shift right
				begin treg={1'b1,treg[7:1]}; dout=treg[0]; end
			else//MSB first shift LEFT
				begin treg={treg[6:0],1'b1}; dout=treg[7]; end
		end
 end //rst
end //always
 
 
endmodule

// file: MMCM.v
// 
// (c) Copyright 2008 - 2013 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
//----------------------------------------------------------------------------
// User entered comments
//----------------------------------------------------------------------------
// None
//
//----------------------------------------------------------------------------
//  Output     Output      Phase    Duty Cycle   Pk-to-Pk     Phase
//   Clock     Freq (MHz)  (degrees)    (%)     Jitter (ps)  Error (ps)
//----------------------------------------------------------------------------
// clk_out1___200.000______0.000______50.0______276.741____432.554
//
//----------------------------------------------------------------------------
// Input Clock   Freq (MHz)    Input Jitter (UI)
//----------------------------------------------------------------------------
// __primary__________16.000____________0.010

`timescale 1ps/1ps

module MMCM_clk_wiz 

 (// Clock in ports
  // Clock out ports
  output        clk_out1,
  input         clk_in
 );
  // Input buffering
  //------------------------------------
wire clk_in_MMCM;
wire clk_in2_MMCM;
  IBUF clkin1_ibufg
   (.O (clk_in_MMCM),
    .I (clk_in));




  // Clocking PRIMITIVE
  //------------------------------------

  // Instantiation of the MMCM PRIMITIVE
  //    * Unused inputs are tied off
  //    * Unused outputs are labeled unused

  wire        clk_out1_MMCM;
  wire        clk_out2_MMCM;
  wire        clk_out3_MMCM;
  wire        clk_out4_MMCM;
  wire        clk_out5_MMCM;
  wire        clk_out6_MMCM;
  wire        clk_out7_MMCM;

  wire [15:0] do_unused;
  wire        drdy_unused;
  wire        psdone_unused;
  wire        locked_int;
  wire        clkfbout_MMCM;
  wire        clkfbout_buf_MMCM;
  wire        clkfboutb_unused;
    wire clkout0b_unused;
   wire clkout1_unused;
   wire clkout1b_unused;
   wire clkout2_unused;
   wire clkout2b_unused;
   wire clkout3_unused;
   wire clkout3b_unused;
   wire clkout4_unused;
  wire        clkout5_unused;
  wire        clkout6_unused;
  wire        clkfbstopped_unused;
  wire        clkinstopped_unused;

  MMCME2_ADV
  #(.BANDWIDTH            ("OPTIMIZED"),
    .CLKOUT4_CASCADE      ("FALSE"),
    .COMPENSATION         ("ZHOLD"),
    .STARTUP_WAIT         ("FALSE"),
    .DIVCLK_DIVIDE        (1),
    .CLKFBOUT_MULT_F      (62.500),
    .CLKFBOUT_PHASE       (0.000),
    .CLKFBOUT_USE_FINE_PS ("FALSE"),
    .CLKOUT0_DIVIDE_F     (5.000),
    .CLKOUT0_PHASE        (0.000),
    .CLKOUT0_DUTY_CYCLE   (0.500),
    .CLKOUT0_USE_FINE_PS  ("FALSE"),
    .CLKIN1_PERIOD        (62.500))
  mmcm_adv_inst
    // Output clocks
   (
    .CLKFBOUT            (clkfbout_MMCM),
    .CLKFBOUTB           (clkfboutb_unused),
    .CLKOUT0             (clk_out1_MMCM),
    .CLKOUT0B            (clkout0b_unused),
    .CLKOUT1             (clkout1_unused),
    .CLKOUT1B            (clkout1b_unused),
    .CLKOUT2             (clkout2_unused),
    .CLKOUT2B            (clkout2b_unused),
    .CLKOUT3             (clkout3_unused),
    .CLKOUT3B            (clkout3b_unused),
    .CLKOUT4             (clkout4_unused),
    .CLKOUT5             (clkout5_unused),
    .CLKOUT6             (clkout6_unused),
     // Input clock control
    .CLKFBIN             (clkfbout_buf_MMCM),
    .CLKIN1              (clk_in_MMCM),
    .CLKIN2              (1'b0),
     // Tied to always select the primary input clock
    .CLKINSEL            (1'b1),
    // Ports for dynamic reconfiguration
    .DADDR               (7'h0),
    .DCLK                (1'b0),
    .DEN                 (1'b0),
    .DI                  (16'h0),
    .DO                  (do_unused),
    .DRDY                (drdy_unused),
    .DWE                 (1'b0),
    // Ports for dynamic phase shift
    .PSCLK               (1'b0),
    .PSEN                (1'b0),
    .PSINCDEC            (1'b0),
    .PSDONE              (psdone_unused),
    // Other control and status signals
    .LOCKED              (locked_int),
    .CLKINSTOPPED        (clkinstopped_unused),
    .CLKFBSTOPPED        (clkfbstopped_unused),
    .PWRDWN              (1'b0),
    .RST                 (1'b0));

// Clock Monitor clock assigning
//--------------------------------------
 // Output buffering
  //-----------------------------------

  BUFG clkf_buf
   (.O (clkfbout_buf_MMCM),
    .I (clkfbout_MMCM));






  BUFG clkout1_buf
   (.O   (clk_out1),
    .I   (clk_out1_MMCM));




endmodule
// Copied from https://raw.githubusercontent.com/nandland/spi-slave/master/Verilog/source/SPI_Slave.v
// with modifications by pbsds
///////////////////////////////////////////////////////////////////////////////
// Description: SPI (Serial Peripheral Interface) Slave
//              Creates slave based on input configuration.
//              Receives a byte one bit at a time on MOSI
//              Will also push out byte data one bit at a time on MISO.
//              Any data on input byte will be shipped out on MISO.
//              Supports multiple bytes per transaction when CS_n is kept
//              low during the transaction.
//
// Note:        i_Clk must be at least 4x faster than i_SPI_Clk
//              MISO is tri-stated when not communicating.  Allows for multiple
//              SPI Slaves on the same interface.
//
// Parameters:  SPI_MODE, can be 0, 1, 2, or 3.  See above.
//              Can be configured in one of 4 modes:
//              Mode | Clock Polarity (CPOL/CKP) | Clock Phase (CPHA)
//               0   |             0             |        0
//               1   |             0             |        1
//               2   |             1             |        0
//               3   |             1             |        1
//              More info: https://en.wikipedia.org/wiki/Serial_Peripheral_Interface_Bus#Mode_numbers
///////////////////////////////////////////////////////////////////////////////

module SPI_Slave_nandland
  #(parameter SPI_MODE = 0)
  (
   // Control/Data Signals,
   input            i_Rst_L,    // FPGA Reset
   input            i_Clk,      // FPGA Clock
   output reg       o_RX_DV,    // Data Valid pulse (1 clock cycle)
   output reg [7:0] o_RX_Byte,  // Byte received on MOSI
   input            i_TX_DV,    // Data Valid pulse to register i_TX_Byte
   input  [7:0]     i_TX_Byte,  // Byte to serialize to MISO.

   // SPI Interface
   input      i_SPI_Clk,
   output reg o_SPI_MISO,
   input      i_SPI_MOSI,
   input      i_SPI_CS_n
   );


  // SPI Interface (All Runs at SPI Clock Domain)
  wire w_CPOL;     // Clock polarity
  wire w_CPHA;     // Clock phase
  wire w_SPI_Clk;  // Inverted/non-inverted depending on settings
  wire w_SPI_MISO_Mux;

  reg [2:0] r_RX_Bit_Count;
  reg [2:0] r_TX_Bit_Count;
  reg [7:0] r_Temp_RX_Byte;
  reg [7:0] r_RX_Byte;
  reg r_RX_Done, r2_RX_Done, r3_RX_Done;
  reg [7:0] r_TX_Byte;
  reg r_SPI_MISO_Bit, r_Preload_MISO;

  // CPOL: Clock Polarity
  // CPOL=0 means clock idles at 0, leading edge is rising edge.
  // CPOL=1 means clock idles at 1, leading edge is falling edge.
  assign w_CPOL  = (SPI_MODE == 2) | (SPI_MODE == 3);

  // CPHA: Clock Phase
  // CPHA=0 means the "out" side changes the data on trailing edge of clock
  //              the "in" side captures data on leading edge of clock
  // CPHA=1 means the "out" side changes the data on leading edge of clock
  //              the "in" side captures data on the trailing edge of clock
  assign w_CPHA  = (SPI_MODE == 1) | (SPI_MODE == 3);

  assign w_SPI_Clk = w_CPHA ? ~i_SPI_Clk : i_SPI_Clk;



  // Purpose: Recover SPI Byte in SPI Clock Domain
  // Samples line on correct edge of SPI Clock
  always @(posedge w_SPI_Clk or posedge i_SPI_CS_n)
  begin
    if (i_SPI_CS_n)
    begin
      r_RX_Bit_Count <= 0;
      r_RX_Done      <= 1'b0;
    end
    else
    begin
      r_RX_Bit_Count <= r_RX_Bit_Count + 1;

      // Receive in LSB, shift up to MSB
      r_Temp_RX_Byte <= {r_Temp_RX_Byte[6:0], i_SPI_MOSI};

      if (r_RX_Bit_Count == 3'b111)
      begin
        r_RX_Done <= 1'b1;
        r_RX_Byte <= {r_Temp_RX_Byte[6:0], i_SPI_MOSI};
      end
      else if (r_RX_Bit_Count == 3'b010)
      begin
        r_RX_Done <= 1'b0;
      end

    end // else: !if(i_SPI_CS_n)
  end // always @ (posedge w_SPI_Clk or posedge i_SPI_CS_n)



  // Purpose: Cross from SPI Clock Domain to main FPGA clock domain
  // Assert o_RX_DV for 1 clock cycle when o_RX_Byte has valid data.
  always @(posedge i_Clk or negedge i_Rst_L)
  begin
    if (~i_Rst_L)
    begin
      r2_RX_Done <= 1'b0;
      r3_RX_Done <= 1'b0;
      o_RX_DV    <= 1'b0;
      o_RX_Byte  <= 8'h00;
    end
    else
    begin
      // Here is where clock domains are crossed.
      // This will require timing constraint created, can set up long path.
      r2_RX_Done <= r_RX_Done;

      r3_RX_Done <= r2_RX_Done;

      if (r3_RX_Done == 1'b0 && r2_RX_Done == 1'b1) // rising edge
      begin
        o_RX_DV   <= 1'b1;  // Pulse Data Valid 1 clock cycle
        o_RX_Byte <= r_RX_Byte;
      end
      else
      begin
        o_RX_DV <= 1'b0;
      end
    end // else: !if(~i_Rst_L)
  end // always @ (posedge i_Bus_Clk)


  // Control preload signal.  Should be 1 when CS is high, but as soon as
  // first clock edge is seen it goes low.
  always @(posedge w_SPI_Clk or posedge i_SPI_CS_n)
  begin
    if (i_SPI_CS_n)
    begin
      r_Preload_MISO <= 1'b1;
    end
    else
    begin
      r_Preload_MISO <= 1'b0;
    end
  end


  // Purpose: Transmits 1 SPI Byte whenever SPI clock is toggling
  // Will transmit read data back to SW over MISO line.
  // Want to put data on the line immediately when CS goes low.
  always @(posedge w_SPI_Clk or posedge i_SPI_CS_n)
  begin
    if (i_SPI_CS_n)
    begin
      r_TX_Bit_Count <= 3'b111;  // Send MSb first
      r_SPI_MISO_Bit <= r_TX_Byte[3'b111];  // Reset to MSb
    end
    else
    begin
      r_TX_Bit_Count <= r_TX_Bit_Count - 1;

      // Here is where data crosses clock domains from i_Clk to w_SPI_Clk
      // Can set up a timing constraint with wide margin for data path.
      r_SPI_MISO_Bit <= r_TX_Byte[r_TX_Bit_Count];

    end // else: !if(i_SPI_CS_n)
  end // always @ (negedge w_SPI_Clk or posedge i_SPI_CS_n_SW)


  // Purpose: Register TX Byte when DV pulse comes.  Keeps registed byte in
  // this module to get serialized and sent back to master.
  always @(posedge i_Clk or negedge i_Rst_L)
  begin
    if (~i_Rst_L)
    begin
      r_TX_Byte <= 8'h00;
    end
    else
    begin
      if (i_TX_DV)
      begin
        r_TX_Byte <= i_TX_Byte;
      end
    end // else: !if(~i_Rst_L)
  end // always @ (posedge i_Clk or negedge i_Rst_L)

  // Preload MISO with top bit of send data when preload selector is high.
  // Otherwise just send the normal MISO data
  assign w_SPI_MISO_Mux = r_Preload_MISO ? r_TX_Byte[3'b111] : r_SPI_MISO_Bit;

  // Tri-statae MISO when CS is high.  Allows for multiple slaves to talk.
  //assign o_SPI_MISO = i_SPI_CS_n ? 1'bZ : w_SPI_MISO_Mux;

  // fix?
  always @(posedge i_Clk)
  begin
    o_SPI_MISO <= i_SPI_CS_n ? 1'b1 : w_SPI_MISO_Mux;
  end

endmodule // SPI_Slave
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (lin64) Build 2552052 Fri May 24 14:47:09 MDT 2019
// Date        : Thu Nov  7 14:57:02 2019
// Host        : sadie-pc running 64-bit Manjaro Linux
// Command     : write_verilog -force ../synthesize/include/i2s_sender.v
// Design      : i2s_sender
// Purpose     : This is a Verilog netlist of the current design or from a specific cell of the design. The output is an
//               IEEE 1364-2001 compliant Verilog HDL file that contains netlist information obtained from the input
//               design files.
// Device      : xc7k70tfbv676-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* DEBUG = "FALSE" *) 
(* STRUCTURAL_NETLIST = "yes" *)
module i2s_sender
   (resetn,
    MCLK_in,
    LRCK_out,
    SCLK_out,
    SDIN_out,
    wave_left_in,
    wave_right_in);
  input resetn;
  input MCLK_in;
  inout LRCK_out;
  inout SCLK_out;
  inout SDIN_out;
  input [23:0]wave_left_in;
  input [23:0]wave_right_in;

  wire \<const1> ;
  wire [7:0]LRCK_cnt;
  wire \LRCK_cnt[7]_i_2_n_0 ;
  wire \LRCK_cnt_reg_n_0_[0] ;
  wire \LRCK_cnt_reg_n_0_[1] ;
  wire \LRCK_cnt_reg_n_0_[2] ;
  wire \LRCK_cnt_reg_n_0_[3] ;
  wire \LRCK_cnt_reg_n_0_[4] ;
  wire \LRCK_cnt_reg_n_0_[5] ;
  wire \LRCK_cnt_reg_n_0_[6] ;
  wire \LRCK_cnt_reg_n_0_[7] ;
  wire LRCK_out;
  wire LRCK_out_OBUF;
  wire LRCK_out_i_1_n_0;
  wire MCLK_in;
  wire MCLK_in_IBUF;
  wire MCLK_in_IBUF_BUFG;
  wire [1:0]SCLK_cnt;
  wire \SCLK_cnt[0]_i_1_n_0 ;
  wire \SCLK_cnt[1]_i_1_n_0 ;
  wire \SCLK_cnt[1]_i_2_n_0 ;
  wire SCLK_out;
  wire SCLK_out_OBUF;
  wire SCLK_out_i_1_n_0;
  wire SDIN_out;
  wire SDIN_out_OBUF;
  wire p_0_in;
  wire resetn;
  wire resetn_IBUF;
  wire shift_reg;
  wire \shift_reg[0]_i_1_n_0 ;
  wire \shift_reg[10]_i_1_n_0 ;
  wire \shift_reg[10]_i_2_n_0 ;
  wire \shift_reg[11]_i_1_n_0 ;
  wire \shift_reg[11]_i_2_n_0 ;
  wire \shift_reg[12]_i_1_n_0 ;
  wire \shift_reg[12]_i_2_n_0 ;
  wire \shift_reg[13]_i_1_n_0 ;
  wire \shift_reg[13]_i_2_n_0 ;
  wire \shift_reg[14]_i_1_n_0 ;
  wire \shift_reg[14]_i_2_n_0 ;
  wire \shift_reg[15]_i_1_n_0 ;
  wire \shift_reg[15]_i_2_n_0 ;
  wire \shift_reg[16]_i_1_n_0 ;
  wire \shift_reg[16]_i_2_n_0 ;
  wire \shift_reg[17]_i_1_n_0 ;
  wire \shift_reg[17]_i_2_n_0 ;
  wire \shift_reg[18]_i_1_n_0 ;
  wire \shift_reg[18]_i_2_n_0 ;
  wire \shift_reg[19]_i_1_n_0 ;
  wire \shift_reg[19]_i_2_n_0 ;
  wire \shift_reg[1]_i_1_n_0 ;
  wire \shift_reg[1]_i_2_n_0 ;
  wire \shift_reg[20]_i_1_n_0 ;
  wire \shift_reg[20]_i_2_n_0 ;
  wire \shift_reg[21]_i_1_n_0 ;
  wire \shift_reg[21]_i_2_n_0 ;
  wire \shift_reg[22]_i_1_n_0 ;
  wire \shift_reg[22]_i_2_n_0 ;
  wire \shift_reg[23]_i_1_n_0 ;
  wire \shift_reg[23]_i_2_n_0 ;
  wire \shift_reg[23]_i_3_n_0 ;
  wire \shift_reg[24]_i_2_n_0 ;
  wire \shift_reg[24]_i_3_n_0 ;
  wire \shift_reg[2]_i_1_n_0 ;
  wire \shift_reg[2]_i_2_n_0 ;
  wire \shift_reg[3]_i_1_n_0 ;
  wire \shift_reg[3]_i_2_n_0 ;
  wire \shift_reg[4]_i_1_n_0 ;
  wire \shift_reg[4]_i_2_n_0 ;
  wire \shift_reg[5]_i_1_n_0 ;
  wire \shift_reg[5]_i_2_n_0 ;
  wire \shift_reg[6]_i_1_n_0 ;
  wire \shift_reg[6]_i_2_n_0 ;
  wire \shift_reg[7]_i_1_n_0 ;
  wire \shift_reg[7]_i_2_n_0 ;
  wire \shift_reg[8]_i_1_n_0 ;
  wire \shift_reg[8]_i_2_n_0 ;
  wire \shift_reg[9]_i_1_n_0 ;
  wire \shift_reg[9]_i_2_n_0 ;
  wire \shift_reg_reg_n_0_[0] ;
  wire \shift_reg_reg_n_0_[10] ;
  wire \shift_reg_reg_n_0_[11] ;
  wire \shift_reg_reg_n_0_[12] ;
  wire \shift_reg_reg_n_0_[13] ;
  wire \shift_reg_reg_n_0_[14] ;
  wire \shift_reg_reg_n_0_[15] ;
  wire \shift_reg_reg_n_0_[16] ;
  wire \shift_reg_reg_n_0_[17] ;
  wire \shift_reg_reg_n_0_[18] ;
  wire \shift_reg_reg_n_0_[19] ;
  wire \shift_reg_reg_n_0_[1] ;
  wire \shift_reg_reg_n_0_[20] ;
  wire \shift_reg_reg_n_0_[21] ;
  wire \shift_reg_reg_n_0_[22] ;
  wire \shift_reg_reg_n_0_[2] ;
  wire \shift_reg_reg_n_0_[3] ;
  wire \shift_reg_reg_n_0_[4] ;
  wire \shift_reg_reg_n_0_[5] ;
  wire \shift_reg_reg_n_0_[6] ;
  wire \shift_reg_reg_n_0_[7] ;
  wire \shift_reg_reg_n_0_[8] ;
  wire \shift_reg_reg_n_0_[9] ;
  wire [23:0]wave_left;
  wire [23:0]wave_left_in;
  wire [23:0]wave_left_in_IBUF;
  wire [23:0]wave_right;
  wire [23:0]wave_right_in;
  wire [23:0]wave_right_in_IBUF;

  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \LRCK_cnt[0]_i_1 
       (.I0(\LRCK_cnt_reg_n_0_[0] ),
        .O(LRCK_cnt[0]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \LRCK_cnt[1]_i_1 
       (.I0(\LRCK_cnt_reg_n_0_[0] ),
        .I1(\LRCK_cnt_reg_n_0_[1] ),
        .O(LRCK_cnt[1]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \LRCK_cnt[2]_i_1 
       (.I0(\LRCK_cnt_reg_n_0_[0] ),
        .I1(\LRCK_cnt_reg_n_0_[1] ),
        .I2(\LRCK_cnt_reg_n_0_[2] ),
        .O(LRCK_cnt[2]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \LRCK_cnt[3]_i_1 
       (.I0(\LRCK_cnt_reg_n_0_[3] ),
        .I1(\LRCK_cnt_reg_n_0_[0] ),
        .I2(\LRCK_cnt_reg_n_0_[1] ),
        .I3(\LRCK_cnt_reg_n_0_[2] ),
        .O(LRCK_cnt[3]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \LRCK_cnt[4]_i_1 
       (.I0(\LRCK_cnt_reg_n_0_[4] ),
        .I1(\LRCK_cnt_reg_n_0_[2] ),
        .I2(\LRCK_cnt_reg_n_0_[3] ),
        .I3(\LRCK_cnt_reg_n_0_[0] ),
        .I4(\LRCK_cnt_reg_n_0_[1] ),
        .O(LRCK_cnt[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \LRCK_cnt[5]_i_1 
       (.I0(\LRCK_cnt_reg_n_0_[5] ),
        .I1(\LRCK_cnt_reg_n_0_[1] ),
        .I2(\LRCK_cnt_reg_n_0_[0] ),
        .I3(\LRCK_cnt_reg_n_0_[3] ),
        .I4(\LRCK_cnt_reg_n_0_[2] ),
        .I5(\LRCK_cnt_reg_n_0_[4] ),
        .O(LRCK_cnt[5]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hA1)) 
    \LRCK_cnt[6]_i_1 
       (.I0(\LRCK_cnt_reg_n_0_[6] ),
        .I1(\LRCK_cnt_reg_n_0_[7] ),
        .I2(\LRCK_cnt[7]_i_2_n_0 ),
        .O(LRCK_cnt[6]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hA4)) 
    \LRCK_cnt[7]_i_1 
       (.I0(\LRCK_cnt_reg_n_0_[7] ),
        .I1(\LRCK_cnt_reg_n_0_[6] ),
        .I2(\LRCK_cnt[7]_i_2_n_0 ),
        .O(LRCK_cnt[7]));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \LRCK_cnt[7]_i_2 
       (.I0(\LRCK_cnt_reg_n_0_[5] ),
        .I1(\LRCK_cnt_reg_n_0_[1] ),
        .I2(\LRCK_cnt_reg_n_0_[0] ),
        .I3(\LRCK_cnt_reg_n_0_[3] ),
        .I4(\LRCK_cnt_reg_n_0_[2] ),
        .I5(\LRCK_cnt_reg_n_0_[4] ),
        .O(\LRCK_cnt[7]_i_2_n_0 ));
  FDCE \LRCK_cnt_reg[0] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(LRCK_cnt[0]),
        .Q(\LRCK_cnt_reg_n_0_[0] ));
  FDCE \LRCK_cnt_reg[1] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(LRCK_cnt[1]),
        .Q(\LRCK_cnt_reg_n_0_[1] ));
  FDCE \LRCK_cnt_reg[2] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(LRCK_cnt[2]),
        .Q(\LRCK_cnt_reg_n_0_[2] ));
  FDCE \LRCK_cnt_reg[3] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(LRCK_cnt[3]),
        .Q(\LRCK_cnt_reg_n_0_[3] ));
  FDCE \LRCK_cnt_reg[4] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(LRCK_cnt[4]),
        .Q(\LRCK_cnt_reg_n_0_[4] ));
  FDCE \LRCK_cnt_reg[5] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(LRCK_cnt[5]),
        .Q(\LRCK_cnt_reg_n_0_[5] ));
  FDCE \LRCK_cnt_reg[6] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(LRCK_cnt[6]),
        .Q(\LRCK_cnt_reg_n_0_[6] ));
  FDCE \LRCK_cnt_reg[7] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(LRCK_cnt[7]),
        .Q(\LRCK_cnt_reg_n_0_[7] ));
  OBUF LRCK_out_OBUF_inst
       (.I(LRCK_out_OBUF),
        .O(LRCK_out));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hFB04)) 
    LRCK_out_i_1
       (.I0(\LRCK_cnt[7]_i_2_n_0 ),
        .I1(\LRCK_cnt_reg_n_0_[7] ),
        .I2(\LRCK_cnt_reg_n_0_[6] ),
        .I3(LRCK_out_OBUF),
        .O(LRCK_out_i_1_n_0));
  FDCE LRCK_out_reg
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(LRCK_out_i_1_n_0),
        .Q(LRCK_out_OBUF));
  BUFG MCLK_in_IBUF_BUFG_inst
       (.I(MCLK_in_IBUF),
        .O(MCLK_in_IBUF_BUFG));
  IBUF MCLK_in_IBUF_inst
       (.I(MCLK_in),
        .O(MCLK_in_IBUF));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \SCLK_cnt[0]_i_1 
       (.I0(SCLK_cnt[0]),
        .O(\SCLK_cnt[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \SCLK_cnt[1]_i_1 
       (.I0(SCLK_cnt[1]),
        .I1(SCLK_cnt[0]),
        .O(\SCLK_cnt[1]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \SCLK_cnt[1]_i_2 
       (.I0(resetn_IBUF),
        .O(\SCLK_cnt[1]_i_2_n_0 ));
  FDCE \SCLK_cnt_reg[0] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\SCLK_cnt[0]_i_1_n_0 ),
        .Q(SCLK_cnt[0]));
  FDCE \SCLK_cnt_reg[1] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\SCLK_cnt[1]_i_1_n_0 ),
        .Q(SCLK_cnt[1]));
  OBUF SCLK_out_OBUF_inst
       (.I(SCLK_out_OBUF),
        .O(SCLK_out));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h78)) 
    SCLK_out_i_1
       (.I0(SCLK_cnt[1]),
        .I1(SCLK_cnt[0]),
        .I2(SCLK_out_OBUF),
        .O(SCLK_out_i_1_n_0));
  FDCE SCLK_out_reg
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(SCLK_out_i_1_n_0),
        .Q(SCLK_out_OBUF));
  OBUF SDIN_out_OBUF_inst
       (.I(SDIN_out_OBUF),
        .O(SDIN_out));
  VCC VCC
       (.P(\<const1> ));
  IBUF resetn_IBUF_inst
       (.I(resetn),
        .O(resetn_IBUF));
  LUT6 #(
    .INIT(64'h0000000000E40000)) 
    \shift_reg[0]_i_1 
       (.I0(LRCK_out_OBUF),
        .I1(wave_right[0]),
        .I2(wave_left[0]),
        .I3(\LRCK_cnt_reg_n_0_[6] ),
        .I4(\LRCK_cnt_reg_n_0_[7] ),
        .I5(\LRCK_cnt[7]_i_2_n_0 ),
        .O(\shift_reg[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAEAAAAAAA2AAAAA)) 
    \shift_reg[10]_i_1 
       (.I0(\shift_reg_reg_n_0_[9] ),
        .I1(\LRCK_cnt_reg_n_0_[4] ),
        .I2(\LRCK_cnt_reg_n_0_[5] ),
        .I3(\shift_reg[23]_i_2_n_0 ),
        .I4(\shift_reg[24]_i_3_n_0 ),
        .I5(\shift_reg[10]_i_2_n_0 ),
        .O(\shift_reg[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hE4)) 
    \shift_reg[10]_i_2 
       (.I0(LRCK_out_OBUF),
        .I1(wave_right[10]),
        .I2(wave_left[10]),
        .O(\shift_reg[10]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAEAAAAAAA2AAAAA)) 
    \shift_reg[11]_i_1 
       (.I0(\shift_reg_reg_n_0_[10] ),
        .I1(\LRCK_cnt_reg_n_0_[4] ),
        .I2(\LRCK_cnt_reg_n_0_[5] ),
        .I3(\shift_reg[23]_i_2_n_0 ),
        .I4(\shift_reg[24]_i_3_n_0 ),
        .I5(\shift_reg[11]_i_2_n_0 ),
        .O(\shift_reg[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hE4)) 
    \shift_reg[11]_i_2 
       (.I0(LRCK_out_OBUF),
        .I1(wave_right[11]),
        .I2(wave_left[11]),
        .O(\shift_reg[11]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAEAAAAAAA2AAAAA)) 
    \shift_reg[12]_i_1 
       (.I0(\shift_reg_reg_n_0_[11] ),
        .I1(\LRCK_cnt_reg_n_0_[4] ),
        .I2(\LRCK_cnt_reg_n_0_[5] ),
        .I3(\shift_reg[23]_i_2_n_0 ),
        .I4(\shift_reg[24]_i_3_n_0 ),
        .I5(\shift_reg[12]_i_2_n_0 ),
        .O(\shift_reg[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hE4)) 
    \shift_reg[12]_i_2 
       (.I0(LRCK_out_OBUF),
        .I1(wave_right[12]),
        .I2(wave_left[12]),
        .O(\shift_reg[12]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAEAAAAAAA2AAAAA)) 
    \shift_reg[13]_i_1 
       (.I0(\shift_reg_reg_n_0_[12] ),
        .I1(\LRCK_cnt_reg_n_0_[4] ),
        .I2(\LRCK_cnt_reg_n_0_[5] ),
        .I3(\shift_reg[23]_i_2_n_0 ),
        .I4(\shift_reg[24]_i_3_n_0 ),
        .I5(\shift_reg[13]_i_2_n_0 ),
        .O(\shift_reg[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hE4)) 
    \shift_reg[13]_i_2 
       (.I0(LRCK_out_OBUF),
        .I1(wave_right[13]),
        .I2(wave_left[13]),
        .O(\shift_reg[13]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAEAAAAAAA2AAAAA)) 
    \shift_reg[14]_i_1 
       (.I0(\shift_reg_reg_n_0_[13] ),
        .I1(\LRCK_cnt_reg_n_0_[4] ),
        .I2(\LRCK_cnt_reg_n_0_[5] ),
        .I3(\shift_reg[23]_i_2_n_0 ),
        .I4(\shift_reg[24]_i_3_n_0 ),
        .I5(\shift_reg[14]_i_2_n_0 ),
        .O(\shift_reg[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hE4)) 
    \shift_reg[14]_i_2 
       (.I0(LRCK_out_OBUF),
        .I1(wave_right[14]),
        .I2(wave_left[14]),
        .O(\shift_reg[14]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAEAAAAAAA2AAAAA)) 
    \shift_reg[15]_i_1 
       (.I0(\shift_reg_reg_n_0_[14] ),
        .I1(\LRCK_cnt_reg_n_0_[4] ),
        .I2(\LRCK_cnt_reg_n_0_[5] ),
        .I3(\shift_reg[23]_i_2_n_0 ),
        .I4(\shift_reg[24]_i_3_n_0 ),
        .I5(\shift_reg[15]_i_2_n_0 ),
        .O(\shift_reg[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hE4)) 
    \shift_reg[15]_i_2 
       (.I0(LRCK_out_OBUF),
        .I1(wave_right[15]),
        .I2(wave_left[15]),
        .O(\shift_reg[15]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAEAAAAAAA2AAAAA)) 
    \shift_reg[16]_i_1 
       (.I0(\shift_reg_reg_n_0_[15] ),
        .I1(\LRCK_cnt_reg_n_0_[4] ),
        .I2(\LRCK_cnt_reg_n_0_[5] ),
        .I3(\shift_reg[23]_i_2_n_0 ),
        .I4(\shift_reg[24]_i_3_n_0 ),
        .I5(\shift_reg[16]_i_2_n_0 ),
        .O(\shift_reg[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hE4)) 
    \shift_reg[16]_i_2 
       (.I0(LRCK_out_OBUF),
        .I1(wave_right[16]),
        .I2(wave_left[16]),
        .O(\shift_reg[16]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAEAAAAAAA2AAAAA)) 
    \shift_reg[17]_i_1 
       (.I0(\shift_reg_reg_n_0_[16] ),
        .I1(\LRCK_cnt_reg_n_0_[4] ),
        .I2(\LRCK_cnt_reg_n_0_[5] ),
        .I3(\shift_reg[23]_i_2_n_0 ),
        .I4(\shift_reg[24]_i_3_n_0 ),
        .I5(\shift_reg[17]_i_2_n_0 ),
        .O(\shift_reg[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hE4)) 
    \shift_reg[17]_i_2 
       (.I0(LRCK_out_OBUF),
        .I1(wave_right[17]),
        .I2(wave_left[17]),
        .O(\shift_reg[17]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAEAAAAAAA2AAAAA)) 
    \shift_reg[18]_i_1 
       (.I0(\shift_reg_reg_n_0_[17] ),
        .I1(\LRCK_cnt_reg_n_0_[4] ),
        .I2(\LRCK_cnt_reg_n_0_[5] ),
        .I3(\shift_reg[23]_i_2_n_0 ),
        .I4(\shift_reg[24]_i_3_n_0 ),
        .I5(\shift_reg[18]_i_2_n_0 ),
        .O(\shift_reg[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hE4)) 
    \shift_reg[18]_i_2 
       (.I0(LRCK_out_OBUF),
        .I1(wave_right[18]),
        .I2(wave_left[18]),
        .O(\shift_reg[18]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAEAAAAAAA2AAAAA)) 
    \shift_reg[19]_i_1 
       (.I0(\shift_reg_reg_n_0_[18] ),
        .I1(\LRCK_cnt_reg_n_0_[4] ),
        .I2(\LRCK_cnt_reg_n_0_[5] ),
        .I3(\shift_reg[23]_i_2_n_0 ),
        .I4(\shift_reg[24]_i_3_n_0 ),
        .I5(\shift_reg[19]_i_2_n_0 ),
        .O(\shift_reg[19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hE4)) 
    \shift_reg[19]_i_2 
       (.I0(LRCK_out_OBUF),
        .I1(wave_right[19]),
        .I2(wave_left[19]),
        .O(\shift_reg[19]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAEAAAAAAA2AAAAA)) 
    \shift_reg[1]_i_1 
       (.I0(\shift_reg_reg_n_0_[0] ),
        .I1(\LRCK_cnt_reg_n_0_[4] ),
        .I2(\LRCK_cnt_reg_n_0_[5] ),
        .I3(\shift_reg[23]_i_2_n_0 ),
        .I4(\shift_reg[24]_i_3_n_0 ),
        .I5(\shift_reg[1]_i_2_n_0 ),
        .O(\shift_reg[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hE4)) 
    \shift_reg[1]_i_2 
       (.I0(LRCK_out_OBUF),
        .I1(wave_right[1]),
        .I2(wave_left[1]),
        .O(\shift_reg[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAEAAAAAAA2AAAAA)) 
    \shift_reg[20]_i_1 
       (.I0(\shift_reg_reg_n_0_[19] ),
        .I1(\LRCK_cnt_reg_n_0_[4] ),
        .I2(\LRCK_cnt_reg_n_0_[5] ),
        .I3(\shift_reg[23]_i_2_n_0 ),
        .I4(\shift_reg[24]_i_3_n_0 ),
        .I5(\shift_reg[20]_i_2_n_0 ),
        .O(\shift_reg[20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hE4)) 
    \shift_reg[20]_i_2 
       (.I0(LRCK_out_OBUF),
        .I1(wave_right[20]),
        .I2(wave_left[20]),
        .O(\shift_reg[20]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAEAAAAAAA2AAAAA)) 
    \shift_reg[21]_i_1 
       (.I0(\shift_reg_reg_n_0_[20] ),
        .I1(\LRCK_cnt_reg_n_0_[4] ),
        .I2(\LRCK_cnt_reg_n_0_[5] ),
        .I3(\shift_reg[23]_i_2_n_0 ),
        .I4(\shift_reg[24]_i_3_n_0 ),
        .I5(\shift_reg[21]_i_2_n_0 ),
        .O(\shift_reg[21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hE4)) 
    \shift_reg[21]_i_2 
       (.I0(LRCK_out_OBUF),
        .I1(wave_right[21]),
        .I2(wave_left[21]),
        .O(\shift_reg[21]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAEAAAAAAA2AAAAA)) 
    \shift_reg[22]_i_1 
       (.I0(\shift_reg_reg_n_0_[21] ),
        .I1(\LRCK_cnt_reg_n_0_[4] ),
        .I2(\LRCK_cnt_reg_n_0_[5] ),
        .I3(\shift_reg[23]_i_2_n_0 ),
        .I4(\shift_reg[24]_i_3_n_0 ),
        .I5(\shift_reg[22]_i_2_n_0 ),
        .O(\shift_reg[22]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hE4)) 
    \shift_reg[22]_i_2 
       (.I0(LRCK_out_OBUF),
        .I1(wave_right[22]),
        .I2(wave_left[22]),
        .O(\shift_reg[22]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAEAAAAAAA2AAAAA)) 
    \shift_reg[23]_i_1 
       (.I0(\shift_reg_reg_n_0_[22] ),
        .I1(\LRCK_cnt_reg_n_0_[4] ),
        .I2(\LRCK_cnt_reg_n_0_[5] ),
        .I3(\shift_reg[23]_i_2_n_0 ),
        .I4(\shift_reg[24]_i_3_n_0 ),
        .I5(\shift_reg[23]_i_3_n_0 ),
        .O(\shift_reg[23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \shift_reg[23]_i_2 
       (.I0(\LRCK_cnt_reg_n_0_[6] ),
        .I1(\LRCK_cnt_reg_n_0_[7] ),
        .O(\shift_reg[23]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hE4)) 
    \shift_reg[23]_i_3 
       (.I0(LRCK_out_OBUF),
        .I1(wave_right[23]),
        .I2(wave_left[23]),
        .O(\shift_reg[23]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h55D5555555555555)) 
    \shift_reg[24]_i_1 
       (.I0(\shift_reg[24]_i_2_n_0 ),
        .I1(\shift_reg[24]_i_3_n_0 ),
        .I2(\LRCK_cnt_reg_n_0_[7] ),
        .I3(\LRCK_cnt_reg_n_0_[6] ),
        .I4(\LRCK_cnt_reg_n_0_[5] ),
        .I5(\LRCK_cnt_reg_n_0_[4] ),
        .O(shift_reg));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    \shift_reg[24]_i_2 
       (.I0(SCLK_cnt[1]),
        .I1(SCLK_cnt[0]),
        .I2(SCLK_out_OBUF),
        .O(\shift_reg[24]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \shift_reg[24]_i_3 
       (.I0(\LRCK_cnt_reg_n_0_[1] ),
        .I1(\LRCK_cnt_reg_n_0_[0] ),
        .I2(\LRCK_cnt_reg_n_0_[3] ),
        .I3(\LRCK_cnt_reg_n_0_[2] ),
        .O(\shift_reg[24]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAAEAAAAAAA2AAAAA)) 
    \shift_reg[2]_i_1 
       (.I0(\shift_reg_reg_n_0_[1] ),
        .I1(\LRCK_cnt_reg_n_0_[4] ),
        .I2(\LRCK_cnt_reg_n_0_[5] ),
        .I3(\shift_reg[23]_i_2_n_0 ),
        .I4(\shift_reg[24]_i_3_n_0 ),
        .I5(\shift_reg[2]_i_2_n_0 ),
        .O(\shift_reg[2]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hE4)) 
    \shift_reg[2]_i_2 
       (.I0(LRCK_out_OBUF),
        .I1(wave_right[2]),
        .I2(wave_left[2]),
        .O(\shift_reg[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAEAAAAAAA2AAAAA)) 
    \shift_reg[3]_i_1 
       (.I0(\shift_reg_reg_n_0_[2] ),
        .I1(\LRCK_cnt_reg_n_0_[4] ),
        .I2(\LRCK_cnt_reg_n_0_[5] ),
        .I3(\shift_reg[23]_i_2_n_0 ),
        .I4(\shift_reg[24]_i_3_n_0 ),
        .I5(\shift_reg[3]_i_2_n_0 ),
        .O(\shift_reg[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hE4)) 
    \shift_reg[3]_i_2 
       (.I0(LRCK_out_OBUF),
        .I1(wave_right[3]),
        .I2(wave_left[3]),
        .O(\shift_reg[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAEAAAAAAA2AAAAA)) 
    \shift_reg[4]_i_1 
       (.I0(\shift_reg_reg_n_0_[3] ),
        .I1(\LRCK_cnt_reg_n_0_[4] ),
        .I2(\LRCK_cnt_reg_n_0_[5] ),
        .I3(\shift_reg[23]_i_2_n_0 ),
        .I4(\shift_reg[24]_i_3_n_0 ),
        .I5(\shift_reg[4]_i_2_n_0 ),
        .O(\shift_reg[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hE4)) 
    \shift_reg[4]_i_2 
       (.I0(LRCK_out_OBUF),
        .I1(wave_right[4]),
        .I2(wave_left[4]),
        .O(\shift_reg[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAEAAAAAAA2AAAAA)) 
    \shift_reg[5]_i_1 
       (.I0(\shift_reg_reg_n_0_[4] ),
        .I1(\LRCK_cnt_reg_n_0_[4] ),
        .I2(\LRCK_cnt_reg_n_0_[5] ),
        .I3(\shift_reg[23]_i_2_n_0 ),
        .I4(\shift_reg[24]_i_3_n_0 ),
        .I5(\shift_reg[5]_i_2_n_0 ),
        .O(\shift_reg[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hE4)) 
    \shift_reg[5]_i_2 
       (.I0(LRCK_out_OBUF),
        .I1(wave_right[5]),
        .I2(wave_left[5]),
        .O(\shift_reg[5]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAEAAAAAAA2AAAAA)) 
    \shift_reg[6]_i_1 
       (.I0(\shift_reg_reg_n_0_[5] ),
        .I1(\LRCK_cnt_reg_n_0_[4] ),
        .I2(\LRCK_cnt_reg_n_0_[5] ),
        .I3(\shift_reg[23]_i_2_n_0 ),
        .I4(\shift_reg[24]_i_3_n_0 ),
        .I5(\shift_reg[6]_i_2_n_0 ),
        .O(\shift_reg[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hE4)) 
    \shift_reg[6]_i_2 
       (.I0(LRCK_out_OBUF),
        .I1(wave_right[6]),
        .I2(wave_left[6]),
        .O(\shift_reg[6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAEAAAAAAA2AAAAA)) 
    \shift_reg[7]_i_1 
       (.I0(\shift_reg_reg_n_0_[6] ),
        .I1(\LRCK_cnt_reg_n_0_[4] ),
        .I2(\LRCK_cnt_reg_n_0_[5] ),
        .I3(\shift_reg[23]_i_2_n_0 ),
        .I4(\shift_reg[24]_i_3_n_0 ),
        .I5(\shift_reg[7]_i_2_n_0 ),
        .O(\shift_reg[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hE4)) 
    \shift_reg[7]_i_2 
       (.I0(LRCK_out_OBUF),
        .I1(wave_right[7]),
        .I2(wave_left[7]),
        .O(\shift_reg[7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAEAAAAAAA2AAAAA)) 
    \shift_reg[8]_i_1 
       (.I0(\shift_reg_reg_n_0_[7] ),
        .I1(\LRCK_cnt_reg_n_0_[4] ),
        .I2(\LRCK_cnt_reg_n_0_[5] ),
        .I3(\shift_reg[23]_i_2_n_0 ),
        .I4(\shift_reg[24]_i_3_n_0 ),
        .I5(\shift_reg[8]_i_2_n_0 ),
        .O(\shift_reg[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hE4)) 
    \shift_reg[8]_i_2 
       (.I0(LRCK_out_OBUF),
        .I1(wave_right[8]),
        .I2(wave_left[8]),
        .O(\shift_reg[8]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAEAAAAAAA2AAAAA)) 
    \shift_reg[9]_i_1 
       (.I0(\shift_reg_reg_n_0_[8] ),
        .I1(\LRCK_cnt_reg_n_0_[4] ),
        .I2(\LRCK_cnt_reg_n_0_[5] ),
        .I3(\shift_reg[23]_i_2_n_0 ),
        .I4(\shift_reg[24]_i_3_n_0 ),
        .I5(\shift_reg[9]_i_2_n_0 ),
        .O(\shift_reg[9]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hE4)) 
    \shift_reg[9]_i_2 
       (.I0(LRCK_out_OBUF),
        .I1(wave_right[9]),
        .I2(wave_left[9]),
        .O(\shift_reg[9]_i_2_n_0 ));
  (* KEEP = "false" *) 
  (* mark_debug = "false" *) 
  FDCE \shift_reg_reg[0] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(shift_reg),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\shift_reg[0]_i_1_n_0 ),
        .Q(\shift_reg_reg_n_0_[0] ));
  (* KEEP = "false" *) 
  (* mark_debug = "false" *) 
  FDCE \shift_reg_reg[10] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(shift_reg),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\shift_reg[10]_i_1_n_0 ),
        .Q(\shift_reg_reg_n_0_[10] ));
  (* KEEP = "false" *) 
  (* mark_debug = "false" *) 
  FDCE \shift_reg_reg[11] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(shift_reg),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\shift_reg[11]_i_1_n_0 ),
        .Q(\shift_reg_reg_n_0_[11] ));
  (* KEEP = "false" *) 
  (* mark_debug = "false" *) 
  FDCE \shift_reg_reg[12] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(shift_reg),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\shift_reg[12]_i_1_n_0 ),
        .Q(\shift_reg_reg_n_0_[12] ));
  (* KEEP = "false" *) 
  (* mark_debug = "false" *) 
  FDCE \shift_reg_reg[13] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(shift_reg),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\shift_reg[13]_i_1_n_0 ),
        .Q(\shift_reg_reg_n_0_[13] ));
  (* KEEP = "false" *) 
  (* mark_debug = "false" *) 
  FDCE \shift_reg_reg[14] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(shift_reg),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\shift_reg[14]_i_1_n_0 ),
        .Q(\shift_reg_reg_n_0_[14] ));
  (* KEEP = "false" *) 
  (* mark_debug = "false" *) 
  FDCE \shift_reg_reg[15] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(shift_reg),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\shift_reg[15]_i_1_n_0 ),
        .Q(\shift_reg_reg_n_0_[15] ));
  (* KEEP = "false" *) 
  (* mark_debug = "false" *) 
  FDCE \shift_reg_reg[16] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(shift_reg),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\shift_reg[16]_i_1_n_0 ),
        .Q(\shift_reg_reg_n_0_[16] ));
  (* KEEP = "false" *) 
  (* mark_debug = "false" *) 
  FDCE \shift_reg_reg[17] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(shift_reg),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\shift_reg[17]_i_1_n_0 ),
        .Q(\shift_reg_reg_n_0_[17] ));
  (* KEEP = "false" *) 
  (* mark_debug = "false" *) 
  FDCE \shift_reg_reg[18] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(shift_reg),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\shift_reg[18]_i_1_n_0 ),
        .Q(\shift_reg_reg_n_0_[18] ));
  (* KEEP = "false" *) 
  (* mark_debug = "false" *) 
  FDCE \shift_reg_reg[19] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(shift_reg),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\shift_reg[19]_i_1_n_0 ),
        .Q(\shift_reg_reg_n_0_[19] ));
  (* KEEP = "false" *) 
  (* mark_debug = "false" *) 
  FDCE \shift_reg_reg[1] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(shift_reg),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\shift_reg[1]_i_1_n_0 ),
        .Q(\shift_reg_reg_n_0_[1] ));
  (* KEEP = "false" *) 
  (* mark_debug = "false" *) 
  FDCE \shift_reg_reg[20] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(shift_reg),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\shift_reg[20]_i_1_n_0 ),
        .Q(\shift_reg_reg_n_0_[20] ));
  (* KEEP = "false" *) 
  (* mark_debug = "false" *) 
  FDCE \shift_reg_reg[21] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(shift_reg),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\shift_reg[21]_i_1_n_0 ),
        .Q(\shift_reg_reg_n_0_[21] ));
  (* KEEP = "false" *) 
  (* mark_debug = "false" *) 
  FDCE \shift_reg_reg[22] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(shift_reg),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\shift_reg[22]_i_1_n_0 ),
        .Q(\shift_reg_reg_n_0_[22] ));
  (* KEEP = "false" *) 
  (* mark_debug = "false" *) 
  FDCE \shift_reg_reg[23] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(shift_reg),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\shift_reg[23]_i_1_n_0 ),
        .Q(p_0_in));
  (* KEEP = "false" *) 
  (* mark_debug = "false" *) 
  FDCE \shift_reg_reg[24] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(shift_reg),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(p_0_in),
        .Q(SDIN_out_OBUF));
  (* KEEP = "false" *) 
  (* mark_debug = "false" *) 
  FDCE \shift_reg_reg[2] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(shift_reg),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\shift_reg[2]_i_1_n_0 ),
        .Q(\shift_reg_reg_n_0_[2] ));
  (* KEEP = "false" *) 
  (* mark_debug = "false" *) 
  FDCE \shift_reg_reg[3] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(shift_reg),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\shift_reg[3]_i_1_n_0 ),
        .Q(\shift_reg_reg_n_0_[3] ));
  (* KEEP = "false" *) 
  (* mark_debug = "false" *) 
  FDCE \shift_reg_reg[4] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(shift_reg),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\shift_reg[4]_i_1_n_0 ),
        .Q(\shift_reg_reg_n_0_[4] ));
  (* KEEP = "false" *) 
  (* mark_debug = "false" *) 
  FDCE \shift_reg_reg[5] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(shift_reg),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\shift_reg[5]_i_1_n_0 ),
        .Q(\shift_reg_reg_n_0_[5] ));
  (* KEEP = "false" *) 
  (* mark_debug = "false" *) 
  FDCE \shift_reg_reg[6] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(shift_reg),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\shift_reg[6]_i_1_n_0 ),
        .Q(\shift_reg_reg_n_0_[6] ));
  (* KEEP = "false" *) 
  (* mark_debug = "false" *) 
  FDCE \shift_reg_reg[7] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(shift_reg),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\shift_reg[7]_i_1_n_0 ),
        .Q(\shift_reg_reg_n_0_[7] ));
  (* KEEP = "false" *) 
  (* mark_debug = "false" *) 
  FDCE \shift_reg_reg[8] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(shift_reg),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\shift_reg[8]_i_1_n_0 ),
        .Q(\shift_reg_reg_n_0_[8] ));
  (* KEEP = "false" *) 
  (* mark_debug = "false" *) 
  FDCE \shift_reg_reg[9] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(shift_reg),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(\shift_reg[9]_i_1_n_0 ),
        .Q(\shift_reg_reg_n_0_[9] ));
  IBUF \wave_left_in_IBUF[0]_inst 
       (.I(wave_left_in[0]),
        .O(wave_left_in_IBUF[0]));
  IBUF \wave_left_in_IBUF[10]_inst 
       (.I(wave_left_in[10]),
        .O(wave_left_in_IBUF[10]));
  IBUF \wave_left_in_IBUF[11]_inst 
       (.I(wave_left_in[11]),
        .O(wave_left_in_IBUF[11]));
  IBUF \wave_left_in_IBUF[12]_inst 
       (.I(wave_left_in[12]),
        .O(wave_left_in_IBUF[12]));
  IBUF \wave_left_in_IBUF[13]_inst 
       (.I(wave_left_in[13]),
        .O(wave_left_in_IBUF[13]));
  IBUF \wave_left_in_IBUF[14]_inst 
       (.I(wave_left_in[14]),
        .O(wave_left_in_IBUF[14]));
  IBUF \wave_left_in_IBUF[15]_inst 
       (.I(wave_left_in[15]),
        .O(wave_left_in_IBUF[15]));
  IBUF \wave_left_in_IBUF[16]_inst 
       (.I(wave_left_in[16]),
        .O(wave_left_in_IBUF[16]));
  IBUF \wave_left_in_IBUF[17]_inst 
       (.I(wave_left_in[17]),
        .O(wave_left_in_IBUF[17]));
  IBUF \wave_left_in_IBUF[18]_inst 
       (.I(wave_left_in[18]),
        .O(wave_left_in_IBUF[18]));
  IBUF \wave_left_in_IBUF[19]_inst 
       (.I(wave_left_in[19]),
        .O(wave_left_in_IBUF[19]));
  IBUF \wave_left_in_IBUF[1]_inst 
       (.I(wave_left_in[1]),
        .O(wave_left_in_IBUF[1]));
  IBUF \wave_left_in_IBUF[20]_inst 
       (.I(wave_left_in[20]),
        .O(wave_left_in_IBUF[20]));
  IBUF \wave_left_in_IBUF[21]_inst 
       (.I(wave_left_in[21]),
        .O(wave_left_in_IBUF[21]));
  IBUF \wave_left_in_IBUF[22]_inst 
       (.I(wave_left_in[22]),
        .O(wave_left_in_IBUF[22]));
  IBUF \wave_left_in_IBUF[23]_inst 
       (.I(wave_left_in[23]),
        .O(wave_left_in_IBUF[23]));
  IBUF \wave_left_in_IBUF[2]_inst 
       (.I(wave_left_in[2]),
        .O(wave_left_in_IBUF[2]));
  IBUF \wave_left_in_IBUF[3]_inst 
       (.I(wave_left_in[3]),
        .O(wave_left_in_IBUF[3]));
  IBUF \wave_left_in_IBUF[4]_inst 
       (.I(wave_left_in[4]),
        .O(wave_left_in_IBUF[4]));
  IBUF \wave_left_in_IBUF[5]_inst 
       (.I(wave_left_in[5]),
        .O(wave_left_in_IBUF[5]));
  IBUF \wave_left_in_IBUF[6]_inst 
       (.I(wave_left_in[6]),
        .O(wave_left_in_IBUF[6]));
  IBUF \wave_left_in_IBUF[7]_inst 
       (.I(wave_left_in[7]),
        .O(wave_left_in_IBUF[7]));
  IBUF \wave_left_in_IBUF[8]_inst 
       (.I(wave_left_in[8]),
        .O(wave_left_in_IBUF[8]));
  IBUF \wave_left_in_IBUF[9]_inst 
       (.I(wave_left_in[9]),
        .O(wave_left_in_IBUF[9]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_left_reg[0] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_left_in_IBUF[0]),
        .Q(wave_left[0]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_left_reg[10] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_left_in_IBUF[10]),
        .Q(wave_left[10]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_left_reg[11] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_left_in_IBUF[11]),
        .Q(wave_left[11]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_left_reg[12] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_left_in_IBUF[12]),
        .Q(wave_left[12]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_left_reg[13] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_left_in_IBUF[13]),
        .Q(wave_left[13]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_left_reg[14] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_left_in_IBUF[14]),
        .Q(wave_left[14]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_left_reg[15] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_left_in_IBUF[15]),
        .Q(wave_left[15]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_left_reg[16] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_left_in_IBUF[16]),
        .Q(wave_left[16]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_left_reg[17] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_left_in_IBUF[17]),
        .Q(wave_left[17]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_left_reg[18] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_left_in_IBUF[18]),
        .Q(wave_left[18]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_left_reg[19] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_left_in_IBUF[19]),
        .Q(wave_left[19]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_left_reg[1] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_left_in_IBUF[1]),
        .Q(wave_left[1]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_left_reg[20] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_left_in_IBUF[20]),
        .Q(wave_left[20]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_left_reg[21] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_left_in_IBUF[21]),
        .Q(wave_left[21]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_left_reg[22] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_left_in_IBUF[22]),
        .Q(wave_left[22]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_left_reg[23] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_left_in_IBUF[23]),
        .Q(wave_left[23]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_left_reg[2] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_left_in_IBUF[2]),
        .Q(wave_left[2]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_left_reg[3] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_left_in_IBUF[3]),
        .Q(wave_left[3]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_left_reg[4] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_left_in_IBUF[4]),
        .Q(wave_left[4]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_left_reg[5] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_left_in_IBUF[5]),
        .Q(wave_left[5]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_left_reg[6] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_left_in_IBUF[6]),
        .Q(wave_left[6]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_left_reg[7] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_left_in_IBUF[7]),
        .Q(wave_left[7]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_left_reg[8] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_left_in_IBUF[8]),
        .Q(wave_left[8]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_left_reg[9] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_left_in_IBUF[9]),
        .Q(wave_left[9]));
  IBUF \wave_right_in_IBUF[0]_inst 
       (.I(wave_right_in[0]),
        .O(wave_right_in_IBUF[0]));
  IBUF \wave_right_in_IBUF[10]_inst 
       (.I(wave_right_in[10]),
        .O(wave_right_in_IBUF[10]));
  IBUF \wave_right_in_IBUF[11]_inst 
       (.I(wave_right_in[11]),
        .O(wave_right_in_IBUF[11]));
  IBUF \wave_right_in_IBUF[12]_inst 
       (.I(wave_right_in[12]),
        .O(wave_right_in_IBUF[12]));
  IBUF \wave_right_in_IBUF[13]_inst 
       (.I(wave_right_in[13]),
        .O(wave_right_in_IBUF[13]));
  IBUF \wave_right_in_IBUF[14]_inst 
       (.I(wave_right_in[14]),
        .O(wave_right_in_IBUF[14]));
  IBUF \wave_right_in_IBUF[15]_inst 
       (.I(wave_right_in[15]),
        .O(wave_right_in_IBUF[15]));
  IBUF \wave_right_in_IBUF[16]_inst 
       (.I(wave_right_in[16]),
        .O(wave_right_in_IBUF[16]));
  IBUF \wave_right_in_IBUF[17]_inst 
       (.I(wave_right_in[17]),
        .O(wave_right_in_IBUF[17]));
  IBUF \wave_right_in_IBUF[18]_inst 
       (.I(wave_right_in[18]),
        .O(wave_right_in_IBUF[18]));
  IBUF \wave_right_in_IBUF[19]_inst 
       (.I(wave_right_in[19]),
        .O(wave_right_in_IBUF[19]));
  IBUF \wave_right_in_IBUF[1]_inst 
       (.I(wave_right_in[1]),
        .O(wave_right_in_IBUF[1]));
  IBUF \wave_right_in_IBUF[20]_inst 
       (.I(wave_right_in[20]),
        .O(wave_right_in_IBUF[20]));
  IBUF \wave_right_in_IBUF[21]_inst 
       (.I(wave_right_in[21]),
        .O(wave_right_in_IBUF[21]));
  IBUF \wave_right_in_IBUF[22]_inst 
       (.I(wave_right_in[22]),
        .O(wave_right_in_IBUF[22]));
  IBUF \wave_right_in_IBUF[23]_inst 
       (.I(wave_right_in[23]),
        .O(wave_right_in_IBUF[23]));
  IBUF \wave_right_in_IBUF[2]_inst 
       (.I(wave_right_in[2]),
        .O(wave_right_in_IBUF[2]));
  IBUF \wave_right_in_IBUF[3]_inst 
       (.I(wave_right_in[3]),
        .O(wave_right_in_IBUF[3]));
  IBUF \wave_right_in_IBUF[4]_inst 
       (.I(wave_right_in[4]),
        .O(wave_right_in_IBUF[4]));
  IBUF \wave_right_in_IBUF[5]_inst 
       (.I(wave_right_in[5]),
        .O(wave_right_in_IBUF[5]));
  IBUF \wave_right_in_IBUF[6]_inst 
       (.I(wave_right_in[6]),
        .O(wave_right_in_IBUF[6]));
  IBUF \wave_right_in_IBUF[7]_inst 
       (.I(wave_right_in[7]),
        .O(wave_right_in_IBUF[7]));
  IBUF \wave_right_in_IBUF[8]_inst 
       (.I(wave_right_in[8]),
        .O(wave_right_in_IBUF[8]));
  IBUF \wave_right_in_IBUF[9]_inst 
       (.I(wave_right_in[9]),
        .O(wave_right_in_IBUF[9]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_right_reg[0] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_right_in_IBUF[0]),
        .Q(wave_right[0]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_right_reg[10] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_right_in_IBUF[10]),
        .Q(wave_right[10]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_right_reg[11] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_right_in_IBUF[11]),
        .Q(wave_right[11]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_right_reg[12] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_right_in_IBUF[12]),
        .Q(wave_right[12]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_right_reg[13] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_right_in_IBUF[13]),
        .Q(wave_right[13]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_right_reg[14] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_right_in_IBUF[14]),
        .Q(wave_right[14]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_right_reg[15] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_right_in_IBUF[15]),
        .Q(wave_right[15]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_right_reg[16] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_right_in_IBUF[16]),
        .Q(wave_right[16]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_right_reg[17] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_right_in_IBUF[17]),
        .Q(wave_right[17]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_right_reg[18] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_right_in_IBUF[18]),
        .Q(wave_right[18]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_right_reg[19] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_right_in_IBUF[19]),
        .Q(wave_right[19]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_right_reg[1] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_right_in_IBUF[1]),
        .Q(wave_right[1]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_right_reg[20] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_right_in_IBUF[20]),
        .Q(wave_right[20]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_right_reg[21] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_right_in_IBUF[21]),
        .Q(wave_right[21]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_right_reg[22] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_right_in_IBUF[22]),
        .Q(wave_right[22]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_right_reg[23] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_right_in_IBUF[23]),
        .Q(wave_right[23]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_right_reg[2] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_right_in_IBUF[2]),
        .Q(wave_right[2]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_right_reg[3] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_right_in_IBUF[3]),
        .Q(wave_right[3]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_right_reg[4] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_right_in_IBUF[4]),
        .Q(wave_right[4]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_right_reg[5] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_right_in_IBUF[5]),
        .Q(wave_right[5]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_right_reg[6] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_right_in_IBUF[6]),
        .Q(wave_right[6]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_right_reg[7] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_right_in_IBUF[7]),
        .Q(wave_right[7]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_right_reg[8] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_right_in_IBUF[8]),
        .Q(wave_right[8]));
  FDCE #(
    .INIT(1'b0)) 
    \wave_right_reg[9] 
       (.C(MCLK_in_IBUF_BUFG),
        .CE(\<const1> ),
        .CLR(\SCLK_cnt[1]_i_2_n_0 ),
        .D(wave_right_in_IBUF[9]),
        .Q(wave_right[9]));
endmodule
