module VivadoTest(
  input        clock,
  input        reset,
  output [3:0] io_led,
  input  [3:0] io_sw
);
  wire  _T_9;
  wire  _GEN_0;
  assign _T_9 = io_sw[0];
  assign _GEN_0 = _T_9 ? 1'h0 : 1'h1;
  assign io_led = {{3'd0}, _GEN_0};
endmodule
