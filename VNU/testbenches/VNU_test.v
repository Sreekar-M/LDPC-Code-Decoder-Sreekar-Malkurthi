`include "VNU/VNU.v"
module VNUTest;
  //ports to instantiate in the module
  reg  [3-1 : 0][5-1 : 0] X;
  reg  [5-1 : 0]          Z;
  reg                     clk;
  reg                     en;
  wire [3-1 : 0][6-1 : 0] Y;
  wire                    hard_decision;

  VNU VNUTestModule
  (
    .X(X),
    .Z(Z),
    .clk(clk),
    .en(en),
    .Y(Y),
    .hard_decision(hard_decision)
  );

  //creating clock
  initial begin
    clk = 1'b1;
  end
  always #5 clk = ~clk;

  //testbench starts here
  initial begin
    $dumpvars(0, VNUTest);
    #2; // for the input to receive correctly

    //inputs
    X[0] = 5'b01010;
    X[1] = 5'b11001;
    X[2] = 5'b11100;
    Z    = 5'b10101;
    en = 1'b1;
    #20;
    $display("%b %b %b %b", hard_decision, Y[0], Y[1], Y[2]);

    X[0] = 5'b10101;
    X[1] = 5'b00011;
    X[2] = 5'b10001;
    Z    = 5'b11100;
    #20;
    $display("%b %b %b %b", hard_decision, Y[0], Y[1], Y[2]);
    $finish;
  end
endmodule
