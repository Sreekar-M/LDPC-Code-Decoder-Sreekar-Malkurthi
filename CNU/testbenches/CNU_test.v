`include "CNU/CNU.v"
module CNUTest;
  //ports to instantiate in the module
  reg  [6-1 : 0][6-1 : 0] X;
  reg                     clk;
  reg                     en;
  wire [6-1 : 0][5-1 : 0] Y;
  wire                    p_bit;

  CNU CNUTestModule
  (
    .X(X),
    .clk(clk),
    .en(en),
    .Y(Y),
    .p_bit(p_bit)
  );

  //creating clock
  initial begin
    clk = 1'b1;
  end
  always #5 clk = ~clk;

  //testbench starts here
  initial begin
    $dumpvars(0, CNUTest);
    #2; // for the input to receive correctly

    //inputs
    X[0] = 6'b110101;
    X[1] = 6'b001010;
    X[2] = 6'b111001;
    X[3] = 6'b111100;
    X[4] = 6'b000011;
    X[5] = 6'b111111;
    en = 1'b1;
    #10;
    if(p_bit != 1'b0 || Y[0] != 5'b10000 || Y[1] != 5'b00000 || Y[2] != 5'b10000  || Y[3] != 5'b10000 || Y[4] != 5'b00000 || Y[5] != 5'b10000) begin
      $display("1st error exp: 0 10000 00000 10000 10000 00000 10000 %b %b %b %b %b %b %b", p_bit, Y[0], Y[1], Y[2], Y[3], Y[4], Y[5]);
      $finish;
    end

    X[0] = 6'b110001;
    X[1] = 6'b100001;
    X[2] = 6'b000001;
    X[3] = 6'b000001;
    X[4] = 6'b100010;
    X[5] = 6'b000010;
    #10;
    if(p_bit != 1'b1 || Y[0] != 5'b00001 || Y[1] != 5'b10001 || Y[2] != 5'b10001 || Y[3] != 5'b10001 || Y[4] != 5'b10010 || Y[5] != 5'b10010) begin
      $display("2nd error exp: 1 00001 10001 10001 10001 10010 10010 act %b %b %b %b %b %b %b", p_bit, Y[0], Y[1], Y[2], Y[3], Y[4], Y[5]);
      $finish;
    end

    X[0] = 6'b101010;
    X[1] = 6'b011010;
    X[2] = 6'b000100;
    X[3] = 6'b100001;
    X[4] = 6'b110010;
    X[5] = 6'b010101;
    #10;
    if(p_bit != 1'b1 || Y[0] != 10000 || Y[1] != 00000 || Y[2] != 10000 || Y[3] != 10000 || Y[4] != 00000 || Y[5] != 00000)
    $display("PASSED!!!");
    $finish;
  end
endmodule
