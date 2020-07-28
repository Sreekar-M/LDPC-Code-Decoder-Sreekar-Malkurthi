`include "Utilities/LUT.v"
`include "Utilities/S_to_T.v"
`include "Utilities/T_to_S.v"
`include "Utilities/bit_inc.v"
`include "Utilities/ripple_adder.v"
// Variable Node Unit module

module VNU
(
  // 3 input 5-bit data of messages from CNU, with leftmost bit for each input is the sign bit
  input [3-1 : 0][5-1 : 0] X,
  // 5-bit input from Intrinsic RAM
  input [5-1 : 0] Z,
  // Input clock signal
  input clk,
  // Enable port
  input en,
  // 3 output 6-bit data to send back to CNU's
  output reg [3-1 : 0][6-1 : 0] Y,
  // Hard Decision
  output reg hard_decision
);

  // Intermediate registers for pipelining, starting from top in the diagram
  reg [7-1 : 0] sum_regs [0 : 5-1];

  // intermediate wires for stage 1
  //S_to_T output wires
  wire [5-1 : 0] wire1, wire2, wire3;
  //bit increasing wires
  wire [7-1 : 0] wire1_7, wire2_7, wire3_7;
  //adders output wires
  wire [7-1 : 0] wire4, wire5, wire6, wire7, wire8;

  // intermediate wires for stage 2
  //output of the second stage adders
  wire [7-1 : 0] wire_hd, wire1_2, wire2_2, wire3_2;
  //output wires of T_to_S
  wire [8-1 : 0] wire4_2, wire5_2, wire6_2;
  //output wires of LUT
  wire [4-1 : 0] wire7_2, wire8_2, wire9_2;

  // S to T conversion of all X inputs
  S_to_T s_to_t_1 (.inp(X[0]), .out(wire1));
  S_to_T s_to_t_2 (.inp(X[1]), .out(wire2));
  S_to_T s_to_t_3 (.inp(X[2]), .out(wire3));

  //convert the wire  into seven bit form
  bit_inc bit_inc_1 (.inp(wire1), .out(wire1_7));
  bit_inc bit_inc_2 (.inp(wire2), .out(wire2_7));
  bit_inc bit_inc_3 (.inp(wire3), .out(wire3_7));
  bit_inc bit_inc_4 (.inp(Z)    , .out(wire4));
  // Create modules for first level of adders in first stage from bottom of the diagram
  ripple_adder add1_1(.X(wire1_7), .Y(wire2_7), .S(wire5), .C_out());
  ripple_adder add2_1(.X(wire3_7), .Y(wire1_7), .S(wire6), .C_out());
  ripple_adder add3_1(.X(wire2_7), .Y(wire3_7), .S(wire7), .C_out());
  ripple_adder add4_1(.X(wire1_7), .Y(wire7),   .S(wire8), .C_out());

  // Create modules for adders in second stage
  ripple_adder add1_2(.X(sum_regs[0]), .Y(sum_regs[1]), .S(wire1_2), .C_out());
  ripple_adder add2_2(.X(sum_regs[0]), .Y(sum_regs[2]), .S(wire2_2), .C_out());
  ripple_adder add3_2(.X(sum_regs[0]), .Y(sum_regs[3]), .S(wire3_2), .C_out());
  ripple_adder add4_2(.X(sum_regs[0]), .Y(sum_regs[4]), .S(wire_hd), .C_out());

  // T to S conversion
  T_to_S t_to_s_1 (.inp(wire1_2), .out(wire4_2));
  T_to_S t_to_s_2 (.inp(wire2_2), .out(wire5_2));
  T_to_S t_to_s_3 (.inp(wire3_2), .out(wire6_2));

  // Create modules for LUT
  LUT lut_1(.X(wire4_2[7-1:0]), .Y(wire7_2));
  LUT lut_2(.X(wire5_2[7-1:0]), .Y(wire8_2));
  LUT lut_3(.X(wire6_2[7-1:0]), .Y(wire9_2));

  always @(posedge clk) begin
    if(en == 1'b1) begin
      // First stage from top in the diagram
      sum_regs[0] <= wire4;
      sum_regs[1] <= wire5;
      sum_regs[2] <= wire6;
      sum_regs[3] <= wire7;
      sum_regs[4] <= wire8;
      // Second stage
      if(wire_hd[7-1] == 1'b1) begin
        hard_decision = 1'b0;
      end
      else if(wire_hd == 7'b0000000) begin
        hard_decision = 1'b0;
      end
      else begin
        hard_decision = 1'b1;
      end
      Y[0] <= {hard_decision, wire6_2[8-1], wire9_2};
      Y[1] <= {hard_decision, wire5_2[8-1], wire8_2};
      Y[2] <= {hard_decision, wire4_2[8-1], wire7_2};
    end
  end
endmodule
