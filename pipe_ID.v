`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:33:53 04/16/2016 
// Design Name: 
// Module Name:    pipe_ID 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module pipe_ID(inst,clrn,clk,WBwreg,WBwn,WBdata,
					EXwreg,EXm2reg,EXwmem,EXaluc,EXshift,EXaluimm,EXwn,EXqa,EXqb,EXimmeOrSa
    );
	input [31:0] inst;
	input clrn,clk;
	input WBwreg;
	input [4:0] WBwn;
	input [31:0] WBdata;
	
	output EXwreg,EXm2reg,EXwmem,EXshift,EXaluimm;
	output [3:0] EXaluc;
	output [4:0] EXwn;
	output [31:0] EXqa,EXqb;
	output [31:0] EXimmeOrSa;
	
	wire [11:0] op = inst[31:20];
	wire [4:0] rs = inst[9:5];//rs1
	wire [4:0] rt = inst[4:0];//rs2
	wire [4:0] rd = inst[14:10];//rd
	wire [31:0] sa = {27'b0,inst[19:15]};
	wire [15:0] imme = inst[25:10];

	wire wreg,m2reg,wmem,shift,aluimm,sst,sext;
	wire [3:0] aluc;
	wire [1:0] pcsource;
	
	sccu pipe_cu(.op(op),.z(0),
					.wreg(wreg),.sst(sst),.m2reg(m2reg),.shlft(shift),.aluimm(aluimm),.sext(sext),.aluc(aluc),.wmem(wmem),.pcsource(pcsource));

	wire [4:0] wn;
	wn_select mux2x5(rt,rd,sst,wn);
	
	rf regfile();
	
endmodule
