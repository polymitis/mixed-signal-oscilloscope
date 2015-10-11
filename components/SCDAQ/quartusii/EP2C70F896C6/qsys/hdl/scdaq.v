//% @file scdaq.v
//% @author Petros Fountas
//% @brief SCDAQ Qsys component top file.

`timescale 1 ps / 1 ps
module scdaq (
  csi_clock,
  rsi_reset_n,
  avs_cfg_address,
  avs_cfg_read,
  avs_cfg_write,
  avs_cfg_waitrequest,
  avs_cfg_readdatavalid,
  avs_cfg_readdata,
  avs_cfg_response,
  avs_cfg_writedata,
  avs_rdo_address,
  avs_rdo_read,
  avs_rdo_write,
  avs_rdo_waitrequest,
  avs_rdo_readdatavalid,
  avs_rdo_readdata,
  avs_rdo_response,
  avs_rdo_writedata,
  ins_irq
);
  
  // Parameters
  parameter NSAMPLES     = 256; // No. samples
  parameter PRECISION    = 14;  // Sample precision 
  parameter NCTPSAMPLES  = 8;   // No. trigger samples
  parameter RDO_ADD_BLEN = 8;   // Readout Addr bin length
  parameter CFG_ADD_BLEN = 5;   // Configuration Addr bin length
  
  // Clock and Reset interfaces
  input                    csi_clock;             //          clock_sink.clk
	input                    rsi_reset_n;           //          reset_sink.reset_n
  
  // Trigger Configuration interface
  input   [CFG_ADD_BLEN:0] avs_cfg_address;       // avalon_mm_slave.cfg.address
  input                    avs_cfg_read;          //                    .read
  input                    avs_cfg_write;         //                    .write
  output                   avs_cfg_waitrequest;   //                    .waitrequest
  output                   avs_cfg_readdatavalid; //                    .readdatavalid
  output  [15:0]           avs_cfg_readdata;      //                    .readdata
  output  [1:0]            avs_cfg_response;      //                    .response
  input   [15:0]           avs_cfg_writedata;     //                    .writedata
  
  // Samples Readout interface
  input   [RDO_ADD_BLEN:0] avs_rdo_address;       // avalon_mm_slave.rdo.address
  input                    avs_rdo_read;          //                    .read
  input                    avs_rdo_write;         //                    .write
  output                   avs_rdo_waitrequest;   //                    .waitrequest
  output                   avs_rdo_readdatavalid; //                    .readdatavalid
  output  [15:0]           avs_rdo_readdata;      //                    .readdata
  output  [1:0]            avs_rdo_response;      //                    .response
  input   [15:0]           avs_rdo_writedata;     //                    .writedata
  
  // New capture notification interface
  output                   ins_irq;               // interrupt_sender.irq

	// TODO: Auto-generated HDL template

endmodule
