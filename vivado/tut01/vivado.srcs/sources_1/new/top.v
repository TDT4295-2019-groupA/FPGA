module Square(
  input  [31:0] io_wavelength,
  input  [31:0] io_wavelength_pos,
  output [15:0] io_sample_out
);
  wire [32:0] _T_14;
  wire [32:0] _GEN_1;
  wire  _T_15;
  assign _T_14 = {io_wavelength_pos, 1'h0};
  assign _GEN_1 = {{1'd0}, io_wavelength};
  assign _T_15 = _T_14 > _GEN_1;
  assign io_sample_out = _T_15 ? $signed(-16'sh7fff) : $signed(16'sh7fff);
endmodule
module Triangle(
  input  [31:0] io_wavelength_pos,
  output [15:0] io_sample_out
);
  wire [30:0] half;
  wire [29:0] quarter;
  wire [30:0] _GEN_1;
  wire [30:0] _T_19;
  wire [31:0] _GEN_2;
  wire  _T_20;
  wire [32:0] _T_23;
  wire [32:0] _T_24;
  wire [31:0] _T_25;
  wire [31:0] _GEN_5;
  wire [31:0] _T_27;
  wire [31:0] pos;
  wire [31:0] _GEN_6;
  wire [32:0] _T_28;
  wire [32:0] _T_29;
  wire [31:0] _T_30;
  wire [32:0] _T_31;
  wire [32:0] _T_32;
  wire [31:0] _T_33;
  wire [31:0] _T_34;
  wire [47:0] _T_36;
  wire [29:0] _T_37;
  wire [47:0] _GEN_8;
  wire [48:0] _T_38;
  wire [15:0] _GEN_9;
  assign half = io_wavelength_pos[31:1];
  assign quarter = io_wavelength_pos[31:2];
  assign _GEN_1 = {{1'd0}, quarter};
  assign _T_19 = half + _GEN_1;
  assign _GEN_2 = {{1'd0}, _T_19};
  assign _T_20 = io_wavelength_pos > _GEN_2;
  assign _T_23 = io_wavelength_pos - _GEN_2;
  assign _T_24 = $unsigned(_T_23);
  assign _T_25 = _T_24[31:0];
  assign _GEN_5 = {{2'd0}, quarter};
  assign _T_27 = io_wavelength_pos + _GEN_5;
  assign pos = _T_20 ? _T_25 : _T_27;
  assign _GEN_6 = {{1'd0}, half};
  assign _T_28 = pos - _GEN_6;
  assign _T_29 = $unsigned(_T_28);
  assign _T_30 = _T_29[31:0];
  assign _T_31 = _T_30 - _GEN_5;
  assign _T_32 = $unsigned(_T_31);
  assign _T_33 = _T_32[31:0];
  assign _T_34 = $signed(_T_33);
  assign _T_36 = $signed(_T_34) * $signed(32'sh7fff);
  assign _T_37 = $signed(quarter);
  assign _GEN_8 = {{18{_T_37[29]}},_T_37};
  assign _T_38 = $signed(_T_36) / $signed(_GEN_8);
  assign _GEN_9 = _T_38[15:0];
  assign io_sample_out = $signed(_GEN_9);
endmodule
module Sawtooth(
  input  [31:0] io_wavelength,
  input  [31:0] io_wavelength_pos,
  output [15:0] io_sample_out
);
  wire [32:0] _T_13;
  wire [32:0] _GEN_0;
  wire [33:0] _T_14;
  wire [33:0] _T_15;
  wire [32:0] _T_16;
  wire [33:0] _T_18;
  wire [49:0] _T_19;
  wire [48:0] _T_20;
  wire [48:0] _T_21;
  wire [31:0] _T_22;
  wire [48:0] _GEN_1;
  wire [49:0] _T_23;
  wire [15:0] _GEN_2;
  assign _T_13 = {io_wavelength_pos, 1'h0};
  assign _GEN_0 = {{1'd0}, io_wavelength};
  assign _T_14 = _T_13 - _GEN_0;
  assign _T_15 = $unsigned(_T_14);
  assign _T_16 = _T_15[32:0];
  assign _T_18 = {1'b0,$signed(_T_16)};
  assign _T_19 = $signed(34'sh7fff) * $signed(_T_18);
  assign _T_20 = _T_19[48:0];
  assign _T_21 = $signed(_T_20);
  assign _T_22 = $signed(io_wavelength);
  assign _GEN_1 = {{17{_T_22[31]}},_T_22};
  assign _T_23 = $signed(_T_21) / $signed(_GEN_1);
  assign _GEN_2 = _T_23[15:0];
  assign io_sample_out = $signed(_GEN_2);
endmodule
module Sine(
  input  [31:0] io_wavelength,
  input  [31:0] io_wavelength_pos,
  output [15:0] io_sample_out
);
  wire [41:0] _T_15;
  wire [41:0] _GEN_0;
  wire [41:0] _T_16;
  wire [41:0] _T_17;
  wire [15:0] _GEN_1;
  wire [15:0] angleValue;
  wire [15:0] _T_21;
  wire [15:0] _T_22;
  wire [31:0] part1;
  wire [35:0] _T_26;
  wire [31:0] _T_29;
  wire [31:0] _T_30;
  wire [35:0] _GEN_2;
  wire [36:0] _T_31;
  wire [52:0] _T_32;
  wire [15:0] _GEN_3;
  assign _T_15 = 32'h274 * io_wavelength_pos;
  assign _GEN_0 = {{10'd0}, io_wavelength};
  assign _T_16 = _T_15 / _GEN_0;
  assign _T_17 = $signed(_T_16);
  assign _GEN_1 = _T_17[15:0];
  assign angleValue = $signed(_GEN_1);
  assign _T_21 = $signed(16'shb4) - $signed(angleValue);
  assign _T_22 = $signed(_T_21);
  assign part1 = $signed(angleValue) * $signed(_T_22);
  assign _T_26 = $signed(32'sh4) * $signed(part1);
  assign _T_29 = $signed(32'sh9e34) - $signed(part1);
  assign _T_30 = $signed(_T_29);
  assign _GEN_2 = {{4{_T_30[31]}},_T_30};
  assign _T_31 = $signed(_T_26) / $signed(_GEN_2);
  assign _T_32 = $signed(37'sh7fff) * $signed(_T_31);
  assign _GEN_3 = _T_32[15:0];
  assign io_sample_out = $signed(_GEN_3);
endmodule
module EnvelopeImpl(
  input  [31:0] io_note_life,
  input  [15:0] io_envelope_attack,
  input  [15:0] io_envelope_decay,
  input  [7:0]  io_envelope_sustain,
  input  [15:0] io_envelope_release,
  input  [15:0] io_last_active_envelope_effect,
  input         io_enabled,
  output [15:0] io_envelope_effect
);
  wire [31:0] life;
  wire [15:0] _T_19;
  wire [15:0] _GEN_4;
  wire [15:0] scaled_sustain;
  wire  _T_22;
  wire [31:0] _GEN_5;
  wire  _T_23;
  wire [32:0] _T_24;
  wire [32:0] _T_25;
  wire [31:0] _T_26;
  wire [31:0] _GEN_7;
  wire [47:0] _T_27;
  wire [47:0] _GEN_8;
  wire [47:0] _T_28;
  wire [47:0] _GEN_0;
  wire [31:0] _GEN_9;
  wire  _T_30;
  wire [47:0] _T_32;
  wire [47:0] _GEN_10;
  wire [47:0] _T_33;
  wire [15:0] _T_35;
  wire [31:0] _GEN_11;
  wire  _T_36;
  wire [32:0] _T_37;
  wire [32:0] _T_38;
  wire [31:0] _T_39;
  wire [31:0] _GEN_13;
  wire [32:0] _T_40;
  wire [32:0] _T_41;
  wire [31:0] _T_42;
  wire [16:0] _T_44;
  wire [16:0] _T_45;
  wire [15:0] _T_46;
  wire [31:0] _GEN_14;
  wire [47:0] _T_47;
  wire [47:0] _GEN_15;
  wire [47:0] _T_48;
  wire [47:0] _GEN_16;
  wire [47:0] _T_50;
  wire [47:0] _GEN_1;
  wire [47:0] _GEN_2;
  wire [47:0] _GEN_3;
  assign life = io_note_life / 32'ha;
  assign _T_19 = {io_envelope_sustain, 8'h0};
  assign _GEN_4 = {{8'd0}, io_envelope_sustain};
  assign scaled_sustain = _T_19 | _GEN_4;
  assign _T_22 = io_enabled == 1'h0;
  assign _GEN_5 = {{16'd0}, io_envelope_release};
  assign _T_23 = life < _GEN_5;
  assign _T_24 = _GEN_5 - life;
  assign _T_25 = $unsigned(_T_24);
  assign _T_26 = _T_25[31:0];
  assign _GEN_7 = {{16'd0}, io_last_active_envelope_effect};
  assign _T_27 = _GEN_7 * _T_26;
  assign _GEN_8 = {{32'd0}, io_envelope_release};
  assign _T_28 = _T_27 / _GEN_8;
  assign _GEN_0 = _T_23 ? _T_28 : 48'h0;
  assign _GEN_9 = {{16'd0}, io_envelope_attack};
  assign _T_30 = life < _GEN_9;
  assign _T_32 = 32'hffff * life;
  assign _GEN_10 = {{32'd0}, io_envelope_attack};
  assign _T_33 = _T_32 / _GEN_10;
  assign _T_35 = io_envelope_attack + io_envelope_decay;
  assign _GEN_11 = {{16'd0}, _T_35};
  assign _T_36 = life < _GEN_11;
  assign _T_37 = life - _GEN_9;
  assign _T_38 = $unsigned(_T_37);
  assign _T_39 = _T_38[31:0];
  assign _GEN_13 = {{16'd0}, io_envelope_decay};
  assign _T_40 = _GEN_13 - _T_39;
  assign _T_41 = $unsigned(_T_40);
  assign _T_42 = _T_41[31:0];
  assign _T_44 = 16'hffff - scaled_sustain;
  assign _T_45 = $unsigned(_T_44);
  assign _T_46 = _T_45[15:0];
  assign _GEN_14 = {{16'd0}, _T_46};
  assign _T_47 = _T_42 * _GEN_14;
  assign _GEN_15 = {{32'd0}, io_envelope_decay};
  assign _T_48 = _T_47 / _GEN_15;
  assign _GEN_16 = {{32'd0}, scaled_sustain};
  assign _T_50 = _T_48 + _GEN_16;
  assign _GEN_1 = _T_36 ? _T_50 : {{32'd0}, scaled_sustain};
  assign _GEN_2 = _T_30 ? _T_33 : _GEN_1;
  assign _GEN_3 = _T_22 ? _GEN_0 : _GEN_2;
  assign io_envelope_effect = _GEN_3[15:0];
endmodule
module GeneratorSampleComputer(
  input         io_state_generator_config_enabled,
  input  [7:0]  io_state_generator_config_instrument,
  input  [7:0]  io_state_generator_config_velocity,
  input  [31:0] io_state_note_life,
  input  [31:0] io_state_wavelength,
  input  [31:0] io_state_wavelength_pos,
  input  [15:0] io_state_last_active_envelope_effect,
  input  [15:0] io_global_config_envelope_attack,
  input  [15:0] io_global_config_envelope_decay,
  input  [7:0]  io_global_config_envelope_sustain,
  input  [15:0] io_global_config_envelope_release,
  output [31:0] io_sample_out,
  output [15:0] io_envelope_effect
);
  wire [31:0] Square_io_wavelength;
  wire [31:0] Square_io_wavelength_pos;
  wire [15:0] Square_io_sample_out;
  wire [31:0] Triangle_io_wavelength_pos;
  wire [15:0] Triangle_io_sample_out;
  wire [31:0] Sawtooth_io_wavelength;
  wire [31:0] Sawtooth_io_wavelength_pos;
  wire [15:0] Sawtooth_io_sample_out;
  wire [31:0] Sine_io_wavelength;
  wire [31:0] Sine_io_wavelength_pos;
  wire [15:0] Sine_io_sample_out;
  wire [31:0] EnvelopeImpl_io_note_life;
  wire [15:0] EnvelopeImpl_io_envelope_attack;
  wire [15:0] EnvelopeImpl_io_envelope_decay;
  wire [7:0] EnvelopeImpl_io_envelope_sustain;
  wire [15:0] EnvelopeImpl_io_envelope_release;
  wire [15:0] EnvelopeImpl_io_last_active_envelope_effect;
  wire  EnvelopeImpl_io_enabled;
  wire [15:0] EnvelopeImpl_io_envelope_effect;
  wire  _T_29;
  wire  _T_30;
  wire  _T_31;
  wire  _T_32;
  wire [15:0] _GEN_0;
  wire [15:0] _GEN_1;
  wire [15:0] _GEN_2;
  wire [15:0] _GEN_3;
  wire [16:0] _T_33;
  wire [31:0] _T_23;
  wire [31:0] _GEN_5;
  wire [48:0] _T_34;
  wire [47:0] _T_35;
  wire [47:0] _T_36;
  wire [31:0] _GEN_6;
  wire [47:0] _T_38;
  wire [7:0] _T_39;
  wire [47:0] _GEN_7;
  wire [55:0] _T_40;
  wire [55:0] _GEN_4;
  wire [31:0] _GEN_8;
  Square Square (
    .io_wavelength(Square_io_wavelength),
    .io_wavelength_pos(Square_io_wavelength_pos),
    .io_sample_out(Square_io_sample_out)
  );
  Triangle Triangle (
    .io_wavelength_pos(Triangle_io_wavelength_pos),
    .io_sample_out(Triangle_io_sample_out)
  );
  Sawtooth Sawtooth (
    .io_wavelength(Sawtooth_io_wavelength),
    .io_wavelength_pos(Sawtooth_io_wavelength_pos),
    .io_sample_out(Sawtooth_io_sample_out)
  );
  Sine Sine (
    .io_wavelength(Sine_io_wavelength),
    .io_wavelength_pos(Sine_io_wavelength_pos),
    .io_sample_out(Sine_io_sample_out)
  );
  EnvelopeImpl EnvelopeImpl (
    .io_note_life(EnvelopeImpl_io_note_life),
    .io_envelope_attack(EnvelopeImpl_io_envelope_attack),
    .io_envelope_decay(EnvelopeImpl_io_envelope_decay),
    .io_envelope_sustain(EnvelopeImpl_io_envelope_sustain),
    .io_envelope_release(EnvelopeImpl_io_envelope_release),
    .io_last_active_envelope_effect(EnvelopeImpl_io_last_active_envelope_effect),
    .io_enabled(EnvelopeImpl_io_enabled),
    .io_envelope_effect(EnvelopeImpl_io_envelope_effect)
  );
  assign _T_29 = 8'h0 == io_state_generator_config_instrument;
  assign _T_30 = 8'h1 == io_state_generator_config_instrument;
  assign _T_31 = 8'h2 == io_state_generator_config_instrument;
  assign _T_32 = 8'h3 == io_state_generator_config_instrument;
  assign _GEN_0 = _T_32 ? $signed(Sine_io_sample_out) : $signed(16'sh0);
  assign _GEN_1 = _T_31 ? $signed(Sawtooth_io_sample_out) : $signed(_GEN_0);
  assign _GEN_2 = _T_30 ? $signed(Triangle_io_sample_out) : $signed(_GEN_1);
  assign _GEN_3 = _T_29 ? $signed(Square_io_sample_out) : $signed(_GEN_2);
  assign _T_33 = {1'b0,$signed(EnvelopeImpl_io_envelope_effect)};
  assign _T_23 = {{16{_GEN_3[15]}},_GEN_3};
  assign _GEN_5 = {{15{_T_33[16]}},_T_33};
  assign _T_34 = $signed(_T_23) * $signed(_GEN_5);
  assign _T_35 = _T_34[47:0];
  assign _T_36 = $signed(_T_35);
  assign _GEN_6 = _T_36[47:16];
  assign _T_38 = {{16{_GEN_6[31]}},_GEN_6};
  assign _T_39 = $signed(io_state_generator_config_velocity);
  assign _GEN_7 = {{40{_T_39[7]}},_T_39};
  assign _T_40 = $signed(_T_38) * $signed(_GEN_7);
  assign _GEN_4 = io_state_generator_config_enabled ? $signed(_T_40) : $signed(56'sh0);
  assign _GEN_8 = _GEN_4[31:0];
  assign io_sample_out = $signed(_GEN_8);
  assign io_envelope_effect = EnvelopeImpl_io_envelope_effect;
  assign Square_io_wavelength = io_state_wavelength;
  assign Square_io_wavelength_pos = io_state_wavelength_pos;
  assign Triangle_io_wavelength_pos = io_state_wavelength_pos;
  assign Sawtooth_io_wavelength = io_state_wavelength;
  assign Sawtooth_io_wavelength_pos = io_state_wavelength_pos;
  assign Sine_io_wavelength = io_state_wavelength;
  assign Sine_io_wavelength_pos = io_state_wavelength_pos;
  assign EnvelopeImpl_io_note_life = io_state_note_life;
  assign EnvelopeImpl_io_envelope_attack = io_global_config_envelope_attack;
  assign EnvelopeImpl_io_envelope_decay = io_global_config_envelope_decay;
  assign EnvelopeImpl_io_envelope_sustain = io_global_config_envelope_sustain;
  assign EnvelopeImpl_io_envelope_release = io_global_config_envelope_release;
  assign EnvelopeImpl_io_last_active_envelope_effect = io_state_last_active_envelope_effect;
  assign EnvelopeImpl_io_enabled = io_state_generator_config_enabled;
endmodule
module GeneratorStateHandler(
  input         clock,
  input         reset,
  input         io_generator_update_valid,
  input         io_generator_update_reset_note,
  input         io_generator_update_enabled,
  input  [7:0]  io_generator_update_instrument,
  input  [7:0]  io_generator_update_note_index,
  input  [7:0]  io_generator_update_channel_index,
  input  [7:0]  io_generator_update_velocity,
  input  [7:0]  io_global_config_pitchwheels_0,
  input  [7:0]  io_global_config_pitchwheels_1,
  input  [7:0]  io_global_config_pitchwheels_2,
  input  [7:0]  io_global_config_pitchwheels_3,
  input  [7:0]  io_global_config_pitchwheels_4,
  input  [7:0]  io_global_config_pitchwheels_5,
  input  [7:0]  io_global_config_pitchwheels_6,
  input  [7:0]  io_global_config_pitchwheels_7,
  input  [7:0]  io_global_config_pitchwheels_8,
  input  [7:0]  io_global_config_pitchwheels_9,
  input  [7:0]  io_global_config_pitchwheels_10,
  input  [7:0]  io_global_config_pitchwheels_11,
  input  [7:0]  io_global_config_pitchwheels_12,
  input  [7:0]  io_global_config_pitchwheels_13,
  input  [7:0]  io_global_config_pitchwheels_14,
  input  [7:0]  io_global_config_pitchwheels_15,
  input         io_step_sample,
  input         io_envelope_effect_valid,
  input  [15:0] io_envelope_effect,
  output        io_state_generator_config_enabled,
  output [7:0]  io_state_generator_config_instrument,
  output [7:0]  io_state_generator_config_velocity,
  output [31:0] io_state_note_life,
  output [31:0] io_state_wavelength,
  output [31:0] io_state_wavelength_pos,
  output [15:0] io_state_last_active_envelope_effect
);
  reg  state_generator_config_enabled;
  reg [31:0] _RAND_0;
  reg [7:0] state_generator_config_instrument;
  reg [31:0] _RAND_1;
  reg [7:0] state_generator_config_note_index;
  reg [31:0] _RAND_2;
  reg [7:0] state_generator_config_channel_index;
  reg [31:0] _RAND_3;
  reg [7:0] state_generator_config_velocity;
  reg [31:0] _RAND_4;
  reg [31:0] state_note_life;
  reg [31:0] _RAND_5;
  reg [31:0] state_wavelength;
  reg [31:0] _RAND_6;
  reg [31:0] state_wavelength_pos;
  reg [31:0] _RAND_7;
  reg [15:0] state_last_active_envelope_effect;
  reg [31:0] _RAND_8;
  wire  _T_46;
  wire [7:0] _GEN_0;
  wire [3:0] note_remainder;
  wire [7:0] _T_55;
  wire [7:0] _T_56;
  wire [7:0] _T_57;
  wire [7:0] _T_58;
  wire [7:0] _T_59;
  wire [7:0] _T_60;
  wire [7:0] _T_61;
  wire [7:0] _T_62;
  wire [7:0] _T_63;
  wire [7:0] _T_64;
  wire [7:0] _T_65;
  wire [7:0] _T_66;
  wire [7:0] _T_67;
  wire [7:0] _T_68;
  wire [7:0] _T_69;
  wire [7:0] _T_70;
  wire [7:0] _T_71;
  wire [63:0] _T_78;
  wire [127:0] _T_86;
  wire [11:0] _T_88;
  wire [127:0] _T_89;
  wire [7:0] _T_90;
  wire [7:0] pitchwheel;
  wire  _T_94;
  wire [33:0] _GEN_1;
  wire  _T_97;
  wire [33:0] _GEN_2;
  wire  _T_100;
  wire [33:0] _GEN_3;
  wire  _T_103;
  wire [33:0] _GEN_4;
  wire  _T_106;
  wire [33:0] _GEN_5;
  wire  _T_109;
  wire [33:0] _GEN_6;
  wire  _T_112;
  wire [33:0] _GEN_7;
  wire  _T_115;
  wire [33:0] _GEN_8;
  wire  _T_118;
  wire [33:0] _GEN_9;
  wire  _T_121;
  wire [33:0] _GEN_10;
  wire  _T_124;
  wire [33:0] _GEN_11;
  wire  _T_127;
  wire [33:0] freq_base_lut;
  wire [3:0] note_divide;
  wire [48:0] _GEN_28;
  wire [48:0] _T_129;
  wire [32:0] _GEN_29;
  wire [48:0] _T_131;
  wire [14:0] _T_132;
  wire [17:0] _GEN_30;
  wire [17:0] _T_134;
  wire [17:0] _T_135;
  wire [17:0] _T_136;
  wire [31:0] freq_base;
  wire [31:0] freq_coeff;
  wire [63:0] _T_137;
  wire [47:0] _GEN_31;
  wire [63:0] _T_139;
  wire [31:0] freq;
  wire [30:0] _T_141;
  wire [31:0] _T_146;
  wire [31:0] _T_149;
  wire  _T_150;
  wire [32:0] _T_154;
  wire [32:0] _T_155;
  wire [31:0] _T_156;
  assign _T_46 = io_envelope_effect_valid & state_generator_config_enabled;
  assign _GEN_0 = state_generator_config_note_index % 8'hc;
  assign note_remainder = _GEN_0[3:0];
  assign _T_55 = state_generator_config_note_index / 8'hc;
  assign _T_56 = $unsigned(io_global_config_pitchwheels_0);
  assign _T_57 = $unsigned(io_global_config_pitchwheels_1);
  assign _T_58 = $unsigned(io_global_config_pitchwheels_2);
  assign _T_59 = $unsigned(io_global_config_pitchwheels_3);
  assign _T_60 = $unsigned(io_global_config_pitchwheels_4);
  assign _T_61 = $unsigned(io_global_config_pitchwheels_5);
  assign _T_62 = $unsigned(io_global_config_pitchwheels_6);
  assign _T_63 = $unsigned(io_global_config_pitchwheels_7);
  assign _T_64 = $unsigned(io_global_config_pitchwheels_8);
  assign _T_65 = $unsigned(io_global_config_pitchwheels_9);
  assign _T_66 = $unsigned(io_global_config_pitchwheels_10);
  assign _T_67 = $unsigned(io_global_config_pitchwheels_11);
  assign _T_68 = $unsigned(io_global_config_pitchwheels_12);
  assign _T_69 = $unsigned(io_global_config_pitchwheels_13);
  assign _T_70 = $unsigned(io_global_config_pitchwheels_14);
  assign _T_71 = $unsigned(io_global_config_pitchwheels_15);
  assign _T_78 = {_T_63,_T_62,_T_61,_T_60,_T_59,_T_58,_T_57,_T_56};
  assign _T_86 = {_T_71,_T_70,_T_69,_T_68,_T_67,_T_66,_T_65,_T_64,_T_78};
  assign _T_88 = state_generator_config_channel_index * 8'h8;
  assign _T_89 = _T_86 >> _T_88;
  assign _T_90 = _T_89[7:0];
  assign pitchwheel = $signed(_T_90);
  assign _T_94 = note_remainder == 4'h0;
  assign _GEN_1 = _T_94 ? 34'hf6f11004 : 34'h0;
  assign _T_97 = note_remainder == 4'h1;
  assign _GEN_2 = _T_97 ? 34'h105a0250c : _GEN_1;
  assign _T_100 = note_remainder == 4'h2;
  assign _GEN_3 = _T_100 ? 34'h1152ec0e7 : _GEN_2;
  assign _T_103 = note_remainder == 4'h3;
  assign _GEN_4 = _T_103 ? 34'h125aa2e3b : _GEN_3;
  assign _T_106 = note_remainder == 4'h4;
  assign _GEN_5 = _T_106 ? 34'h137208201 : _GEN_4;
  assign _T_109 = note_remainder == 4'h5;
  assign _GEN_6 = _T_109 ? 34'h149a0a792 : _GEN_5;
  assign _T_112 = note_remainder == 4'h6;
  assign _GEN_7 = _T_112 ? 34'h15d3a6d60 : _GEN_6;
  assign _T_115 = note_remainder == 4'h7;
  assign _GEN_8 = _T_115 ? 34'h171fe927d : _GEN_7;
  assign _T_118 = note_remainder == 4'h8;
  assign _GEN_9 = _T_118 ? 34'h187fed4e4 : _GEN_8;
  assign _T_121 = note_remainder == 4'h9;
  assign _GEN_10 = _T_121 ? 34'h19f4e00a9 : _GEN_9;
  assign _T_124 = note_remainder == 4'ha;
  assign _GEN_11 = _T_124 ? 34'h1b8000000 : _GEN_10;
  assign _T_127 = note_remainder == 4'hb;
  assign freq_base_lut = _T_127 ? 34'h1d229ec46 : _GEN_11;
  assign note_divide = _T_55[3:0];
  assign _GEN_28 = {{15'd0}, freq_base_lut};
  assign _T_129 = _GEN_28 << note_divide;
  assign _GEN_29 = _T_129[48:16];
  assign _T_131 = {{16'd0}, _GEN_29};
  assign _T_132 = $signed(pitchwheel) * $signed(8'sh3b);
  assign _GEN_30 = {{3{_T_132[14]}},_T_132};
  assign _T_134 = $signed(_GEN_30) + $signed(18'sh10000);
  assign _T_135 = $signed(_T_134);
  assign _T_136 = $unsigned(_T_135);
  assign freq_base = _T_131[31:0];
  assign freq_coeff = {{14'd0}, _T_136};
  assign _T_137 = freq_base * freq_coeff;
  assign _GEN_31 = _T_137[63:16];
  assign _T_139 = {{16'd0}, _GEN_31};
  assign freq = _T_139[31:0];
  assign _T_141 = 32'h6baa8000 / freq;
  assign _T_146 = state_note_life + 32'ha;
  assign _T_149 = state_wavelength_pos + 32'ha;
  assign _T_150 = _T_149 >= state_wavelength;
  assign _T_154 = _T_149 - state_wavelength;
  assign _T_155 = $unsigned(_T_154);
  assign _T_156 = _T_155[31:0];
  assign io_state_generator_config_enabled = state_generator_config_enabled;
  assign io_state_generator_config_instrument = state_generator_config_instrument;
  assign io_state_generator_config_velocity = state_generator_config_velocity;
  assign io_state_note_life = state_note_life;
  assign io_state_wavelength = state_wavelength;
  assign io_state_wavelength_pos = state_wavelength_pos;
  assign io_state_last_active_envelope_effect = state_last_active_envelope_effect;
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
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state_generator_config_enabled = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  state_generator_config_instrument = _RAND_1[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  state_generator_config_note_index = _RAND_2[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  state_generator_config_channel_index = _RAND_3[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  state_generator_config_velocity = _RAND_4[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  state_note_life = _RAND_5[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  state_wavelength = _RAND_6[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  state_wavelength_pos = _RAND_7[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  state_last_active_envelope_effect = _RAND_8[15:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    if (reset) begin
      state_generator_config_enabled <= 1'h0;
    end else begin
      if (io_generator_update_valid) begin
        state_generator_config_enabled <= io_generator_update_enabled;
      end
    end
    if (reset) begin
      state_generator_config_instrument <= 8'h0;
    end else begin
      if (io_generator_update_valid) begin
        state_generator_config_instrument <= io_generator_update_instrument;
      end
    end
    if (reset) begin
      state_generator_config_note_index <= 8'h0;
    end else begin
      if (io_generator_update_valid) begin
        state_generator_config_note_index <= io_generator_update_note_index;
      end
    end
    if (reset) begin
      state_generator_config_channel_index <= 8'h0;
    end else begin
      if (io_generator_update_valid) begin
        state_generator_config_channel_index <= io_generator_update_channel_index;
      end
    end
    if (reset) begin
      state_generator_config_velocity <= 8'h0;
    end else begin
      if (io_generator_update_valid) begin
        state_generator_config_velocity <= io_generator_update_velocity;
      end
    end
    if (reset) begin
      state_note_life <= 32'h0;
    end else begin
      if (io_step_sample) begin
        state_note_life <= _T_146;
      end else begin
        if (io_generator_update_valid) begin
          if (io_generator_update_reset_note) begin
            state_note_life <= 32'h0;
          end
        end
      end
    end
    if (reset) begin
      state_wavelength <= 32'h0;
    end else begin
      state_wavelength <= {{1'd0}, _T_141};
    end
    if (reset) begin
      state_wavelength_pos <= 32'h0;
    end else begin
      if (io_step_sample) begin
        if (_T_150) begin
          state_wavelength_pos <= _T_156;
        end else begin
          state_wavelength_pos <= _T_149;
        end
      end else begin
        if (io_generator_update_valid) begin
          if (io_generator_update_reset_note) begin
            state_wavelength_pos <= 32'h0;
          end
        end
      end
    end
    if (reset) begin
      state_last_active_envelope_effect <= 16'h0;
    end else begin
      if (_T_46) begin
        state_last_active_envelope_effect <= io_envelope_effect;
      end
    end
  end
endmodule
module SoundTopLevel(
  input         clock,
  input         reset,
  input         io_generator_update_packet_valid,
  input  [15:0] io_generator_update_packet_generator_index,
  input         io_generator_update_packet_data_reset_note,
  input         io_generator_update_packet_data_enabled,
  input  [7:0]  io_generator_update_packet_data_instrument,
  input  [7:0]  io_generator_update_packet_data_note_index,
  input  [7:0]  io_generator_update_packet_data_channel_index,
  input  [7:0]  io_generator_update_packet_data_velocity,
  input         io_global_update_packet_valid,
  input  [7:0]  io_global_update_packet_data_volume,
  input  [15:0] io_global_update_packet_data_envelope_attack,
  input  [15:0] io_global_update_packet_data_envelope_decay,
  input  [7:0]  io_global_update_packet_data_envelope_sustain,
  input  [15:0] io_global_update_packet_data_envelope_release,
  input  [7:0]  io_global_update_packet_data_pitchwheels_0,
  input  [7:0]  io_global_update_packet_data_pitchwheels_1,
  input  [7:0]  io_global_update_packet_data_pitchwheels_2,
  input  [7:0]  io_global_update_packet_data_pitchwheels_3,
  input  [7:0]  io_global_update_packet_data_pitchwheels_4,
  input  [7:0]  io_global_update_packet_data_pitchwheels_5,
  input  [7:0]  io_global_update_packet_data_pitchwheels_6,
  input  [7:0]  io_global_update_packet_data_pitchwheels_7,
  input  [7:0]  io_global_update_packet_data_pitchwheels_8,
  input  [7:0]  io_global_update_packet_data_pitchwheels_9,
  input  [7:0]  io_global_update_packet_data_pitchwheels_10,
  input  [7:0]  io_global_update_packet_data_pitchwheels_11,
  input  [7:0]  io_global_update_packet_data_pitchwheels_12,
  input  [7:0]  io_global_update_packet_data_pitchwheels_13,
  input  [7:0]  io_global_update_packet_data_pitchwheels_14,
  input  [7:0]  io_global_update_packet_data_pitchwheels_15,
  input         io_step_sample,
  output [31:0] io_sample_out,
  output        io_sample_out_valid
);
  wire  GeneratorSampleComputer_io_state_generator_config_enabled;
  wire [7:0] GeneratorSampleComputer_io_state_generator_config_instrument;
  wire [7:0] GeneratorSampleComputer_io_state_generator_config_velocity;
  wire [31:0] GeneratorSampleComputer_io_state_note_life;
  wire [31:0] GeneratorSampleComputer_io_state_wavelength;
  wire [31:0] GeneratorSampleComputer_io_state_wavelength_pos;
  wire [15:0] GeneratorSampleComputer_io_state_last_active_envelope_effect;
  wire [15:0] GeneratorSampleComputer_io_global_config_envelope_attack;
  wire [15:0] GeneratorSampleComputer_io_global_config_envelope_decay;
  wire [7:0] GeneratorSampleComputer_io_global_config_envelope_sustain;
  wire [15:0] GeneratorSampleComputer_io_global_config_envelope_release;
  wire [31:0] GeneratorSampleComputer_io_sample_out;
  wire [15:0] GeneratorSampleComputer_io_envelope_effect;
  wire  GeneratorStateHandler_clock;
  wire  GeneratorStateHandler_reset;
  wire  GeneratorStateHandler_io_generator_update_valid;
  wire  GeneratorStateHandler_io_generator_update_reset_note;
  wire  GeneratorStateHandler_io_generator_update_enabled;
  wire [7:0] GeneratorStateHandler_io_generator_update_instrument;
  wire [7:0] GeneratorStateHandler_io_generator_update_note_index;
  wire [7:0] GeneratorStateHandler_io_generator_update_channel_index;
  wire [7:0] GeneratorStateHandler_io_generator_update_velocity;
  wire [7:0] GeneratorStateHandler_io_global_config_pitchwheels_0;
  wire [7:0] GeneratorStateHandler_io_global_config_pitchwheels_1;
  wire [7:0] GeneratorStateHandler_io_global_config_pitchwheels_2;
  wire [7:0] GeneratorStateHandler_io_global_config_pitchwheels_3;
  wire [7:0] GeneratorStateHandler_io_global_config_pitchwheels_4;
  wire [7:0] GeneratorStateHandler_io_global_config_pitchwheels_5;
  wire [7:0] GeneratorStateHandler_io_global_config_pitchwheels_6;
  wire [7:0] GeneratorStateHandler_io_global_config_pitchwheels_7;
  wire [7:0] GeneratorStateHandler_io_global_config_pitchwheels_8;
  wire [7:0] GeneratorStateHandler_io_global_config_pitchwheels_9;
  wire [7:0] GeneratorStateHandler_io_global_config_pitchwheels_10;
  wire [7:0] GeneratorStateHandler_io_global_config_pitchwheels_11;
  wire [7:0] GeneratorStateHandler_io_global_config_pitchwheels_12;
  wire [7:0] GeneratorStateHandler_io_global_config_pitchwheels_13;
  wire [7:0] GeneratorStateHandler_io_global_config_pitchwheels_14;
  wire [7:0] GeneratorStateHandler_io_global_config_pitchwheels_15;
  wire  GeneratorStateHandler_io_step_sample;
  wire  GeneratorStateHandler_io_envelope_effect_valid;
  wire [15:0] GeneratorStateHandler_io_envelope_effect;
  wire  GeneratorStateHandler_io_state_generator_config_enabled;
  wire [7:0] GeneratorStateHandler_io_state_generator_config_instrument;
  wire [7:0] GeneratorStateHandler_io_state_generator_config_velocity;
  wire [31:0] GeneratorStateHandler_io_state_note_life;
  wire [31:0] GeneratorStateHandler_io_state_wavelength;
  wire [31:0] GeneratorStateHandler_io_state_wavelength_pos;
  wire [15:0] GeneratorStateHandler_io_state_last_active_envelope_effect;
  wire  GeneratorStateHandler_1_clock;
  wire  GeneratorStateHandler_1_reset;
  wire  GeneratorStateHandler_1_io_generator_update_valid;
  wire  GeneratorStateHandler_1_io_generator_update_reset_note;
  wire  GeneratorStateHandler_1_io_generator_update_enabled;
  wire [7:0] GeneratorStateHandler_1_io_generator_update_instrument;
  wire [7:0] GeneratorStateHandler_1_io_generator_update_note_index;
  wire [7:0] GeneratorStateHandler_1_io_generator_update_channel_index;
  wire [7:0] GeneratorStateHandler_1_io_generator_update_velocity;
  wire [7:0] GeneratorStateHandler_1_io_global_config_pitchwheels_0;
  wire [7:0] GeneratorStateHandler_1_io_global_config_pitchwheels_1;
  wire [7:0] GeneratorStateHandler_1_io_global_config_pitchwheels_2;
  wire [7:0] GeneratorStateHandler_1_io_global_config_pitchwheels_3;
  wire [7:0] GeneratorStateHandler_1_io_global_config_pitchwheels_4;
  wire [7:0] GeneratorStateHandler_1_io_global_config_pitchwheels_5;
  wire [7:0] GeneratorStateHandler_1_io_global_config_pitchwheels_6;
  wire [7:0] GeneratorStateHandler_1_io_global_config_pitchwheels_7;
  wire [7:0] GeneratorStateHandler_1_io_global_config_pitchwheels_8;
  wire [7:0] GeneratorStateHandler_1_io_global_config_pitchwheels_9;
  wire [7:0] GeneratorStateHandler_1_io_global_config_pitchwheels_10;
  wire [7:0] GeneratorStateHandler_1_io_global_config_pitchwheels_11;
  wire [7:0] GeneratorStateHandler_1_io_global_config_pitchwheels_12;
  wire [7:0] GeneratorStateHandler_1_io_global_config_pitchwheels_13;
  wire [7:0] GeneratorStateHandler_1_io_global_config_pitchwheels_14;
  wire [7:0] GeneratorStateHandler_1_io_global_config_pitchwheels_15;
  wire  GeneratorStateHandler_1_io_step_sample;
  wire  GeneratorStateHandler_1_io_envelope_effect_valid;
  wire [15:0] GeneratorStateHandler_1_io_envelope_effect;
  wire  GeneratorStateHandler_1_io_state_generator_config_enabled;
  wire [7:0] GeneratorStateHandler_1_io_state_generator_config_instrument;
  wire [7:0] GeneratorStateHandler_1_io_state_generator_config_velocity;
  wire [31:0] GeneratorStateHandler_1_io_state_note_life;
  wire [31:0] GeneratorStateHandler_1_io_state_wavelength;
  wire [31:0] GeneratorStateHandler_1_io_state_wavelength_pos;
  wire [15:0] GeneratorStateHandler_1_io_state_last_active_envelope_effect;
  wire  GeneratorStateHandler_2_clock;
  wire  GeneratorStateHandler_2_reset;
  wire  GeneratorStateHandler_2_io_generator_update_valid;
  wire  GeneratorStateHandler_2_io_generator_update_reset_note;
  wire  GeneratorStateHandler_2_io_generator_update_enabled;
  wire [7:0] GeneratorStateHandler_2_io_generator_update_instrument;
  wire [7:0] GeneratorStateHandler_2_io_generator_update_note_index;
  wire [7:0] GeneratorStateHandler_2_io_generator_update_channel_index;
  wire [7:0] GeneratorStateHandler_2_io_generator_update_velocity;
  wire [7:0] GeneratorStateHandler_2_io_global_config_pitchwheels_0;
  wire [7:0] GeneratorStateHandler_2_io_global_config_pitchwheels_1;
  wire [7:0] GeneratorStateHandler_2_io_global_config_pitchwheels_2;
  wire [7:0] GeneratorStateHandler_2_io_global_config_pitchwheels_3;
  wire [7:0] GeneratorStateHandler_2_io_global_config_pitchwheels_4;
  wire [7:0] GeneratorStateHandler_2_io_global_config_pitchwheels_5;
  wire [7:0] GeneratorStateHandler_2_io_global_config_pitchwheels_6;
  wire [7:0] GeneratorStateHandler_2_io_global_config_pitchwheels_7;
  wire [7:0] GeneratorStateHandler_2_io_global_config_pitchwheels_8;
  wire [7:0] GeneratorStateHandler_2_io_global_config_pitchwheels_9;
  wire [7:0] GeneratorStateHandler_2_io_global_config_pitchwheels_10;
  wire [7:0] GeneratorStateHandler_2_io_global_config_pitchwheels_11;
  wire [7:0] GeneratorStateHandler_2_io_global_config_pitchwheels_12;
  wire [7:0] GeneratorStateHandler_2_io_global_config_pitchwheels_13;
  wire [7:0] GeneratorStateHandler_2_io_global_config_pitchwheels_14;
  wire [7:0] GeneratorStateHandler_2_io_global_config_pitchwheels_15;
  wire  GeneratorStateHandler_2_io_step_sample;
  wire  GeneratorStateHandler_2_io_envelope_effect_valid;
  wire [15:0] GeneratorStateHandler_2_io_envelope_effect;
  wire  GeneratorStateHandler_2_io_state_generator_config_enabled;
  wire [7:0] GeneratorStateHandler_2_io_state_generator_config_instrument;
  wire [7:0] GeneratorStateHandler_2_io_state_generator_config_velocity;
  wire [31:0] GeneratorStateHandler_2_io_state_note_life;
  wire [31:0] GeneratorStateHandler_2_io_state_wavelength;
  wire [31:0] GeneratorStateHandler_2_io_state_wavelength_pos;
  wire [15:0] GeneratorStateHandler_2_io_state_last_active_envelope_effect;
  wire  GeneratorStateHandler_3_clock;
  wire  GeneratorStateHandler_3_reset;
  wire  GeneratorStateHandler_3_io_generator_update_valid;
  wire  GeneratorStateHandler_3_io_generator_update_reset_note;
  wire  GeneratorStateHandler_3_io_generator_update_enabled;
  wire [7:0] GeneratorStateHandler_3_io_generator_update_instrument;
  wire [7:0] GeneratorStateHandler_3_io_generator_update_note_index;
  wire [7:0] GeneratorStateHandler_3_io_generator_update_channel_index;
  wire [7:0] GeneratorStateHandler_3_io_generator_update_velocity;
  wire [7:0] GeneratorStateHandler_3_io_global_config_pitchwheels_0;
  wire [7:0] GeneratorStateHandler_3_io_global_config_pitchwheels_1;
  wire [7:0] GeneratorStateHandler_3_io_global_config_pitchwheels_2;
  wire [7:0] GeneratorStateHandler_3_io_global_config_pitchwheels_3;
  wire [7:0] GeneratorStateHandler_3_io_global_config_pitchwheels_4;
  wire [7:0] GeneratorStateHandler_3_io_global_config_pitchwheels_5;
  wire [7:0] GeneratorStateHandler_3_io_global_config_pitchwheels_6;
  wire [7:0] GeneratorStateHandler_3_io_global_config_pitchwheels_7;
  wire [7:0] GeneratorStateHandler_3_io_global_config_pitchwheels_8;
  wire [7:0] GeneratorStateHandler_3_io_global_config_pitchwheels_9;
  wire [7:0] GeneratorStateHandler_3_io_global_config_pitchwheels_10;
  wire [7:0] GeneratorStateHandler_3_io_global_config_pitchwheels_11;
  wire [7:0] GeneratorStateHandler_3_io_global_config_pitchwheels_12;
  wire [7:0] GeneratorStateHandler_3_io_global_config_pitchwheels_13;
  wire [7:0] GeneratorStateHandler_3_io_global_config_pitchwheels_14;
  wire [7:0] GeneratorStateHandler_3_io_global_config_pitchwheels_15;
  wire  GeneratorStateHandler_3_io_step_sample;
  wire  GeneratorStateHandler_3_io_envelope_effect_valid;
  wire [15:0] GeneratorStateHandler_3_io_envelope_effect;
  wire  GeneratorStateHandler_3_io_state_generator_config_enabled;
  wire [7:0] GeneratorStateHandler_3_io_state_generator_config_instrument;
  wire [7:0] GeneratorStateHandler_3_io_state_generator_config_velocity;
  wire [31:0] GeneratorStateHandler_3_io_state_note_life;
  wire [31:0] GeneratorStateHandler_3_io_state_wavelength;
  wire [31:0] GeneratorStateHandler_3_io_state_wavelength_pos;
  wire [15:0] GeneratorStateHandler_3_io_state_last_active_envelope_effect;
  wire  GeneratorStateHandler_4_clock;
  wire  GeneratorStateHandler_4_reset;
  wire  GeneratorStateHandler_4_io_generator_update_valid;
  wire  GeneratorStateHandler_4_io_generator_update_reset_note;
  wire  GeneratorStateHandler_4_io_generator_update_enabled;
  wire [7:0] GeneratorStateHandler_4_io_generator_update_instrument;
  wire [7:0] GeneratorStateHandler_4_io_generator_update_note_index;
  wire [7:0] GeneratorStateHandler_4_io_generator_update_channel_index;
  wire [7:0] GeneratorStateHandler_4_io_generator_update_velocity;
  wire [7:0] GeneratorStateHandler_4_io_global_config_pitchwheels_0;
  wire [7:0] GeneratorStateHandler_4_io_global_config_pitchwheels_1;
  wire [7:0] GeneratorStateHandler_4_io_global_config_pitchwheels_2;
  wire [7:0] GeneratorStateHandler_4_io_global_config_pitchwheels_3;
  wire [7:0] GeneratorStateHandler_4_io_global_config_pitchwheels_4;
  wire [7:0] GeneratorStateHandler_4_io_global_config_pitchwheels_5;
  wire [7:0] GeneratorStateHandler_4_io_global_config_pitchwheels_6;
  wire [7:0] GeneratorStateHandler_4_io_global_config_pitchwheels_7;
  wire [7:0] GeneratorStateHandler_4_io_global_config_pitchwheels_8;
  wire [7:0] GeneratorStateHandler_4_io_global_config_pitchwheels_9;
  wire [7:0] GeneratorStateHandler_4_io_global_config_pitchwheels_10;
  wire [7:0] GeneratorStateHandler_4_io_global_config_pitchwheels_11;
  wire [7:0] GeneratorStateHandler_4_io_global_config_pitchwheels_12;
  wire [7:0] GeneratorStateHandler_4_io_global_config_pitchwheels_13;
  wire [7:0] GeneratorStateHandler_4_io_global_config_pitchwheels_14;
  wire [7:0] GeneratorStateHandler_4_io_global_config_pitchwheels_15;
  wire  GeneratorStateHandler_4_io_step_sample;
  wire  GeneratorStateHandler_4_io_envelope_effect_valid;
  wire [15:0] GeneratorStateHandler_4_io_envelope_effect;
  wire  GeneratorStateHandler_4_io_state_generator_config_enabled;
  wire [7:0] GeneratorStateHandler_4_io_state_generator_config_instrument;
  wire [7:0] GeneratorStateHandler_4_io_state_generator_config_velocity;
  wire [31:0] GeneratorStateHandler_4_io_state_note_life;
  wire [31:0] GeneratorStateHandler_4_io_state_wavelength;
  wire [31:0] GeneratorStateHandler_4_io_state_wavelength_pos;
  wire [15:0] GeneratorStateHandler_4_io_state_last_active_envelope_effect;
  wire  GeneratorStateHandler_5_clock;
  wire  GeneratorStateHandler_5_reset;
  wire  GeneratorStateHandler_5_io_generator_update_valid;
  wire  GeneratorStateHandler_5_io_generator_update_reset_note;
  wire  GeneratorStateHandler_5_io_generator_update_enabled;
  wire [7:0] GeneratorStateHandler_5_io_generator_update_instrument;
  wire [7:0] GeneratorStateHandler_5_io_generator_update_note_index;
  wire [7:0] GeneratorStateHandler_5_io_generator_update_channel_index;
  wire [7:0] GeneratorStateHandler_5_io_generator_update_velocity;
  wire [7:0] GeneratorStateHandler_5_io_global_config_pitchwheels_0;
  wire [7:0] GeneratorStateHandler_5_io_global_config_pitchwheels_1;
  wire [7:0] GeneratorStateHandler_5_io_global_config_pitchwheels_2;
  wire [7:0] GeneratorStateHandler_5_io_global_config_pitchwheels_3;
  wire [7:0] GeneratorStateHandler_5_io_global_config_pitchwheels_4;
  wire [7:0] GeneratorStateHandler_5_io_global_config_pitchwheels_5;
  wire [7:0] GeneratorStateHandler_5_io_global_config_pitchwheels_6;
  wire [7:0] GeneratorStateHandler_5_io_global_config_pitchwheels_7;
  wire [7:0] GeneratorStateHandler_5_io_global_config_pitchwheels_8;
  wire [7:0] GeneratorStateHandler_5_io_global_config_pitchwheels_9;
  wire [7:0] GeneratorStateHandler_5_io_global_config_pitchwheels_10;
  wire [7:0] GeneratorStateHandler_5_io_global_config_pitchwheels_11;
  wire [7:0] GeneratorStateHandler_5_io_global_config_pitchwheels_12;
  wire [7:0] GeneratorStateHandler_5_io_global_config_pitchwheels_13;
  wire [7:0] GeneratorStateHandler_5_io_global_config_pitchwheels_14;
  wire [7:0] GeneratorStateHandler_5_io_global_config_pitchwheels_15;
  wire  GeneratorStateHandler_5_io_step_sample;
  wire  GeneratorStateHandler_5_io_envelope_effect_valid;
  wire [15:0] GeneratorStateHandler_5_io_envelope_effect;
  wire  GeneratorStateHandler_5_io_state_generator_config_enabled;
  wire [7:0] GeneratorStateHandler_5_io_state_generator_config_instrument;
  wire [7:0] GeneratorStateHandler_5_io_state_generator_config_velocity;
  wire [31:0] GeneratorStateHandler_5_io_state_note_life;
  wire [31:0] GeneratorStateHandler_5_io_state_wavelength;
  wire [31:0] GeneratorStateHandler_5_io_state_wavelength_pos;
  wire [15:0] GeneratorStateHandler_5_io_state_last_active_envelope_effect;
  wire  GeneratorStateHandler_6_clock;
  wire  GeneratorStateHandler_6_reset;
  wire  GeneratorStateHandler_6_io_generator_update_valid;
  wire  GeneratorStateHandler_6_io_generator_update_reset_note;
  wire  GeneratorStateHandler_6_io_generator_update_enabled;
  wire [7:0] GeneratorStateHandler_6_io_generator_update_instrument;
  wire [7:0] GeneratorStateHandler_6_io_generator_update_note_index;
  wire [7:0] GeneratorStateHandler_6_io_generator_update_channel_index;
  wire [7:0] GeneratorStateHandler_6_io_generator_update_velocity;
  wire [7:0] GeneratorStateHandler_6_io_global_config_pitchwheels_0;
  wire [7:0] GeneratorStateHandler_6_io_global_config_pitchwheels_1;
  wire [7:0] GeneratorStateHandler_6_io_global_config_pitchwheels_2;
  wire [7:0] GeneratorStateHandler_6_io_global_config_pitchwheels_3;
  wire [7:0] GeneratorStateHandler_6_io_global_config_pitchwheels_4;
  wire [7:0] GeneratorStateHandler_6_io_global_config_pitchwheels_5;
  wire [7:0] GeneratorStateHandler_6_io_global_config_pitchwheels_6;
  wire [7:0] GeneratorStateHandler_6_io_global_config_pitchwheels_7;
  wire [7:0] GeneratorStateHandler_6_io_global_config_pitchwheels_8;
  wire [7:0] GeneratorStateHandler_6_io_global_config_pitchwheels_9;
  wire [7:0] GeneratorStateHandler_6_io_global_config_pitchwheels_10;
  wire [7:0] GeneratorStateHandler_6_io_global_config_pitchwheels_11;
  wire [7:0] GeneratorStateHandler_6_io_global_config_pitchwheels_12;
  wire [7:0] GeneratorStateHandler_6_io_global_config_pitchwheels_13;
  wire [7:0] GeneratorStateHandler_6_io_global_config_pitchwheels_14;
  wire [7:0] GeneratorStateHandler_6_io_global_config_pitchwheels_15;
  wire  GeneratorStateHandler_6_io_step_sample;
  wire  GeneratorStateHandler_6_io_envelope_effect_valid;
  wire [15:0] GeneratorStateHandler_6_io_envelope_effect;
  wire  GeneratorStateHandler_6_io_state_generator_config_enabled;
  wire [7:0] GeneratorStateHandler_6_io_state_generator_config_instrument;
  wire [7:0] GeneratorStateHandler_6_io_state_generator_config_velocity;
  wire [31:0] GeneratorStateHandler_6_io_state_note_life;
  wire [31:0] GeneratorStateHandler_6_io_state_wavelength;
  wire [31:0] GeneratorStateHandler_6_io_state_wavelength_pos;
  wire [15:0] GeneratorStateHandler_6_io_state_last_active_envelope_effect;
  wire  GeneratorStateHandler_7_clock;
  wire  GeneratorStateHandler_7_reset;
  wire  GeneratorStateHandler_7_io_generator_update_valid;
  wire  GeneratorStateHandler_7_io_generator_update_reset_note;
  wire  GeneratorStateHandler_7_io_generator_update_enabled;
  wire [7:0] GeneratorStateHandler_7_io_generator_update_instrument;
  wire [7:0] GeneratorStateHandler_7_io_generator_update_note_index;
  wire [7:0] GeneratorStateHandler_7_io_generator_update_channel_index;
  wire [7:0] GeneratorStateHandler_7_io_generator_update_velocity;
  wire [7:0] GeneratorStateHandler_7_io_global_config_pitchwheels_0;
  wire [7:0] GeneratorStateHandler_7_io_global_config_pitchwheels_1;
  wire [7:0] GeneratorStateHandler_7_io_global_config_pitchwheels_2;
  wire [7:0] GeneratorStateHandler_7_io_global_config_pitchwheels_3;
  wire [7:0] GeneratorStateHandler_7_io_global_config_pitchwheels_4;
  wire [7:0] GeneratorStateHandler_7_io_global_config_pitchwheels_5;
  wire [7:0] GeneratorStateHandler_7_io_global_config_pitchwheels_6;
  wire [7:0] GeneratorStateHandler_7_io_global_config_pitchwheels_7;
  wire [7:0] GeneratorStateHandler_7_io_global_config_pitchwheels_8;
  wire [7:0] GeneratorStateHandler_7_io_global_config_pitchwheels_9;
  wire [7:0] GeneratorStateHandler_7_io_global_config_pitchwheels_10;
  wire [7:0] GeneratorStateHandler_7_io_global_config_pitchwheels_11;
  wire [7:0] GeneratorStateHandler_7_io_global_config_pitchwheels_12;
  wire [7:0] GeneratorStateHandler_7_io_global_config_pitchwheels_13;
  wire [7:0] GeneratorStateHandler_7_io_global_config_pitchwheels_14;
  wire [7:0] GeneratorStateHandler_7_io_global_config_pitchwheels_15;
  wire  GeneratorStateHandler_7_io_step_sample;
  wire  GeneratorStateHandler_7_io_envelope_effect_valid;
  wire [15:0] GeneratorStateHandler_7_io_envelope_effect;
  wire  GeneratorStateHandler_7_io_state_generator_config_enabled;
  wire [7:0] GeneratorStateHandler_7_io_state_generator_config_instrument;
  wire [7:0] GeneratorStateHandler_7_io_state_generator_config_velocity;
  wire [31:0] GeneratorStateHandler_7_io_state_note_life;
  wire [31:0] GeneratorStateHandler_7_io_state_wavelength;
  wire [31:0] GeneratorStateHandler_7_io_state_wavelength_pos;
  wire [15:0] GeneratorStateHandler_7_io_state_last_active_envelope_effect;
  reg [7:0] global_config_volume;
  reg [31:0] _RAND_0;
  reg [15:0] global_config_envelope_attack;
  reg [31:0] _RAND_1;
  reg [15:0] global_config_envelope_decay;
  reg [31:0] _RAND_2;
  reg [7:0] global_config_envelope_sustain;
  reg [31:0] _RAND_3;
  reg [15:0] global_config_envelope_release;
  reg [31:0] _RAND_4;
  reg [7:0] global_config_pitchwheels_0;
  reg [31:0] _RAND_5;
  reg [7:0] global_config_pitchwheels_1;
  reg [31:0] _RAND_6;
  reg [7:0] global_config_pitchwheels_2;
  reg [31:0] _RAND_7;
  reg [7:0] global_config_pitchwheels_3;
  reg [31:0] _RAND_8;
  reg [7:0] global_config_pitchwheels_4;
  reg [31:0] _RAND_9;
  reg [7:0] global_config_pitchwheels_5;
  reg [31:0] _RAND_10;
  reg [7:0] global_config_pitchwheels_6;
  reg [31:0] _RAND_11;
  reg [7:0] global_config_pitchwheels_7;
  reg [31:0] _RAND_12;
  reg [7:0] global_config_pitchwheels_8;
  reg [31:0] _RAND_13;
  reg [7:0] global_config_pitchwheels_9;
  reg [31:0] _RAND_14;
  reg [7:0] global_config_pitchwheels_10;
  reg [31:0] _RAND_15;
  reg [7:0] global_config_pitchwheels_11;
  reg [31:0] _RAND_16;
  reg [7:0] global_config_pitchwheels_12;
  reg [31:0] _RAND_17;
  reg [7:0] global_config_pitchwheels_13;
  reg [31:0] _RAND_18;
  reg [7:0] global_config_pitchwheels_14;
  reg [31:0] _RAND_19;
  reg [7:0] global_config_pitchwheels_15;
  reg [31:0] _RAND_20;
  reg [31:0] sample_out;
  reg [31:0] _RAND_21;
  wire [32:0] _T_35;
  wire [8:0] _T_36;
  wire [32:0] _GEN_142;
  wire [41:0] _T_37;
  wire [40:0] _T_38;
  wire [40:0] _T_39;
  wire [44:0] _GEN_143;
  wire [47:0] _T_41;
  reg [3:0] value;
  reg [31:0] _RAND_22;
  wire  _T_46;
  wire  _T_50;
  wire [3:0] _T_53;
  wire  _T_76;
  wire  _T_78;
  wire [15:0] _GEN_28;
  wire [31:0] _GEN_29;
  wire [31:0] _GEN_30;
  wire [31:0] _GEN_31;
  wire [7:0] _GEN_32;
  wire [7:0] _GEN_35;
  wire  _GEN_36;
  wire  _T_83;
  wire  _T_85;
  wire [15:0] _GEN_42;
  wire [31:0] _GEN_43;
  wire [31:0] _GEN_44;
  wire [31:0] _GEN_45;
  wire [7:0] _GEN_46;
  wire [7:0] _GEN_49;
  wire  _GEN_50;
  wire  _T_90;
  wire  _T_92;
  wire [15:0] _GEN_56;
  wire [31:0] _GEN_57;
  wire [31:0] _GEN_58;
  wire [31:0] _GEN_59;
  wire [7:0] _GEN_60;
  wire [7:0] _GEN_63;
  wire  _GEN_64;
  wire  _T_97;
  wire  _T_99;
  wire [15:0] _GEN_70;
  wire [31:0] _GEN_71;
  wire [31:0] _GEN_72;
  wire [31:0] _GEN_73;
  wire [7:0] _GEN_74;
  wire [7:0] _GEN_77;
  wire  _GEN_78;
  wire  _T_104;
  wire  _T_106;
  wire [15:0] _GEN_84;
  wire [31:0] _GEN_85;
  wire [31:0] _GEN_86;
  wire [31:0] _GEN_87;
  wire [7:0] _GEN_88;
  wire [7:0] _GEN_91;
  wire  _GEN_92;
  wire  _T_111;
  wire  _T_113;
  wire [15:0] _GEN_98;
  wire [31:0] _GEN_99;
  wire [31:0] _GEN_100;
  wire [31:0] _GEN_101;
  wire [7:0] _GEN_102;
  wire [7:0] _GEN_105;
  wire  _GEN_106;
  wire  _T_118;
  wire  _T_120;
  wire [15:0] _GEN_112;
  wire [31:0] _GEN_113;
  wire [31:0] _GEN_114;
  wire [31:0] _GEN_115;
  wire [7:0] _GEN_116;
  wire [7:0] _GEN_119;
  wire  _GEN_120;
  wire  _T_125;
  wire  _T_130;
  wire [31:0] _T_132;
  wire [31:0] _T_133;
  wire [31:0] _GEN_144;
  GeneratorSampleComputer GeneratorSampleComputer (
    .io_state_generator_config_enabled(GeneratorSampleComputer_io_state_generator_config_enabled),
    .io_state_generator_config_instrument(GeneratorSampleComputer_io_state_generator_config_instrument),
    .io_state_generator_config_velocity(GeneratorSampleComputer_io_state_generator_config_velocity),
    .io_state_note_life(GeneratorSampleComputer_io_state_note_life),
    .io_state_wavelength(GeneratorSampleComputer_io_state_wavelength),
    .io_state_wavelength_pos(GeneratorSampleComputer_io_state_wavelength_pos),
    .io_state_last_active_envelope_effect(GeneratorSampleComputer_io_state_last_active_envelope_effect),
    .io_global_config_envelope_attack(GeneratorSampleComputer_io_global_config_envelope_attack),
    .io_global_config_envelope_decay(GeneratorSampleComputer_io_global_config_envelope_decay),
    .io_global_config_envelope_sustain(GeneratorSampleComputer_io_global_config_envelope_sustain),
    .io_global_config_envelope_release(GeneratorSampleComputer_io_global_config_envelope_release),
    .io_sample_out(GeneratorSampleComputer_io_sample_out),
    .io_envelope_effect(GeneratorSampleComputer_io_envelope_effect)
  );
  GeneratorStateHandler GeneratorStateHandler (
    .clock(GeneratorStateHandler_clock),
    .reset(GeneratorStateHandler_reset),
    .io_generator_update_valid(GeneratorStateHandler_io_generator_update_valid),
    .io_generator_update_reset_note(GeneratorStateHandler_io_generator_update_reset_note),
    .io_generator_update_enabled(GeneratorStateHandler_io_generator_update_enabled),
    .io_generator_update_instrument(GeneratorStateHandler_io_generator_update_instrument),
    .io_generator_update_note_index(GeneratorStateHandler_io_generator_update_note_index),
    .io_generator_update_channel_index(GeneratorStateHandler_io_generator_update_channel_index),
    .io_generator_update_velocity(GeneratorStateHandler_io_generator_update_velocity),
    .io_global_config_pitchwheels_0(GeneratorStateHandler_io_global_config_pitchwheels_0),
    .io_global_config_pitchwheels_1(GeneratorStateHandler_io_global_config_pitchwheels_1),
    .io_global_config_pitchwheels_2(GeneratorStateHandler_io_global_config_pitchwheels_2),
    .io_global_config_pitchwheels_3(GeneratorStateHandler_io_global_config_pitchwheels_3),
    .io_global_config_pitchwheels_4(GeneratorStateHandler_io_global_config_pitchwheels_4),
    .io_global_config_pitchwheels_5(GeneratorStateHandler_io_global_config_pitchwheels_5),
    .io_global_config_pitchwheels_6(GeneratorStateHandler_io_global_config_pitchwheels_6),
    .io_global_config_pitchwheels_7(GeneratorStateHandler_io_global_config_pitchwheels_7),
    .io_global_config_pitchwheels_8(GeneratorStateHandler_io_global_config_pitchwheels_8),
    .io_global_config_pitchwheels_9(GeneratorStateHandler_io_global_config_pitchwheels_9),
    .io_global_config_pitchwheels_10(GeneratorStateHandler_io_global_config_pitchwheels_10),
    .io_global_config_pitchwheels_11(GeneratorStateHandler_io_global_config_pitchwheels_11),
    .io_global_config_pitchwheels_12(GeneratorStateHandler_io_global_config_pitchwheels_12),
    .io_global_config_pitchwheels_13(GeneratorStateHandler_io_global_config_pitchwheels_13),
    .io_global_config_pitchwheels_14(GeneratorStateHandler_io_global_config_pitchwheels_14),
    .io_global_config_pitchwheels_15(GeneratorStateHandler_io_global_config_pitchwheels_15),
    .io_step_sample(GeneratorStateHandler_io_step_sample),
    .io_envelope_effect_valid(GeneratorStateHandler_io_envelope_effect_valid),
    .io_envelope_effect(GeneratorStateHandler_io_envelope_effect),
    .io_state_generator_config_enabled(GeneratorStateHandler_io_state_generator_config_enabled),
    .io_state_generator_config_instrument(GeneratorStateHandler_io_state_generator_config_instrument),
    .io_state_generator_config_velocity(GeneratorStateHandler_io_state_generator_config_velocity),
    .io_state_note_life(GeneratorStateHandler_io_state_note_life),
    .io_state_wavelength(GeneratorStateHandler_io_state_wavelength),
    .io_state_wavelength_pos(GeneratorStateHandler_io_state_wavelength_pos),
    .io_state_last_active_envelope_effect(GeneratorStateHandler_io_state_last_active_envelope_effect)
  );
  GeneratorStateHandler GeneratorStateHandler_1 (
    .clock(GeneratorStateHandler_1_clock),
    .reset(GeneratorStateHandler_1_reset),
    .io_generator_update_valid(GeneratorStateHandler_1_io_generator_update_valid),
    .io_generator_update_reset_note(GeneratorStateHandler_1_io_generator_update_reset_note),
    .io_generator_update_enabled(GeneratorStateHandler_1_io_generator_update_enabled),
    .io_generator_update_instrument(GeneratorStateHandler_1_io_generator_update_instrument),
    .io_generator_update_note_index(GeneratorStateHandler_1_io_generator_update_note_index),
    .io_generator_update_channel_index(GeneratorStateHandler_1_io_generator_update_channel_index),
    .io_generator_update_velocity(GeneratorStateHandler_1_io_generator_update_velocity),
    .io_global_config_pitchwheels_0(GeneratorStateHandler_1_io_global_config_pitchwheels_0),
    .io_global_config_pitchwheels_1(GeneratorStateHandler_1_io_global_config_pitchwheels_1),
    .io_global_config_pitchwheels_2(GeneratorStateHandler_1_io_global_config_pitchwheels_2),
    .io_global_config_pitchwheels_3(GeneratorStateHandler_1_io_global_config_pitchwheels_3),
    .io_global_config_pitchwheels_4(GeneratorStateHandler_1_io_global_config_pitchwheels_4),
    .io_global_config_pitchwheels_5(GeneratorStateHandler_1_io_global_config_pitchwheels_5),
    .io_global_config_pitchwheels_6(GeneratorStateHandler_1_io_global_config_pitchwheels_6),
    .io_global_config_pitchwheels_7(GeneratorStateHandler_1_io_global_config_pitchwheels_7),
    .io_global_config_pitchwheels_8(GeneratorStateHandler_1_io_global_config_pitchwheels_8),
    .io_global_config_pitchwheels_9(GeneratorStateHandler_1_io_global_config_pitchwheels_9),
    .io_global_config_pitchwheels_10(GeneratorStateHandler_1_io_global_config_pitchwheels_10),
    .io_global_config_pitchwheels_11(GeneratorStateHandler_1_io_global_config_pitchwheels_11),
    .io_global_config_pitchwheels_12(GeneratorStateHandler_1_io_global_config_pitchwheels_12),
    .io_global_config_pitchwheels_13(GeneratorStateHandler_1_io_global_config_pitchwheels_13),
    .io_global_config_pitchwheels_14(GeneratorStateHandler_1_io_global_config_pitchwheels_14),
    .io_global_config_pitchwheels_15(GeneratorStateHandler_1_io_global_config_pitchwheels_15),
    .io_step_sample(GeneratorStateHandler_1_io_step_sample),
    .io_envelope_effect_valid(GeneratorStateHandler_1_io_envelope_effect_valid),
    .io_envelope_effect(GeneratorStateHandler_1_io_envelope_effect),
    .io_state_generator_config_enabled(GeneratorStateHandler_1_io_state_generator_config_enabled),
    .io_state_generator_config_instrument(GeneratorStateHandler_1_io_state_generator_config_instrument),
    .io_state_generator_config_velocity(GeneratorStateHandler_1_io_state_generator_config_velocity),
    .io_state_note_life(GeneratorStateHandler_1_io_state_note_life),
    .io_state_wavelength(GeneratorStateHandler_1_io_state_wavelength),
    .io_state_wavelength_pos(GeneratorStateHandler_1_io_state_wavelength_pos),
    .io_state_last_active_envelope_effect(GeneratorStateHandler_1_io_state_last_active_envelope_effect)
  );
  GeneratorStateHandler GeneratorStateHandler_2 (
    .clock(GeneratorStateHandler_2_clock),
    .reset(GeneratorStateHandler_2_reset),
    .io_generator_update_valid(GeneratorStateHandler_2_io_generator_update_valid),
    .io_generator_update_reset_note(GeneratorStateHandler_2_io_generator_update_reset_note),
    .io_generator_update_enabled(GeneratorStateHandler_2_io_generator_update_enabled),
    .io_generator_update_instrument(GeneratorStateHandler_2_io_generator_update_instrument),
    .io_generator_update_note_index(GeneratorStateHandler_2_io_generator_update_note_index),
    .io_generator_update_channel_index(GeneratorStateHandler_2_io_generator_update_channel_index),
    .io_generator_update_velocity(GeneratorStateHandler_2_io_generator_update_velocity),
    .io_global_config_pitchwheels_0(GeneratorStateHandler_2_io_global_config_pitchwheels_0),
    .io_global_config_pitchwheels_1(GeneratorStateHandler_2_io_global_config_pitchwheels_1),
    .io_global_config_pitchwheels_2(GeneratorStateHandler_2_io_global_config_pitchwheels_2),
    .io_global_config_pitchwheels_3(GeneratorStateHandler_2_io_global_config_pitchwheels_3),
    .io_global_config_pitchwheels_4(GeneratorStateHandler_2_io_global_config_pitchwheels_4),
    .io_global_config_pitchwheels_5(GeneratorStateHandler_2_io_global_config_pitchwheels_5),
    .io_global_config_pitchwheels_6(GeneratorStateHandler_2_io_global_config_pitchwheels_6),
    .io_global_config_pitchwheels_7(GeneratorStateHandler_2_io_global_config_pitchwheels_7),
    .io_global_config_pitchwheels_8(GeneratorStateHandler_2_io_global_config_pitchwheels_8),
    .io_global_config_pitchwheels_9(GeneratorStateHandler_2_io_global_config_pitchwheels_9),
    .io_global_config_pitchwheels_10(GeneratorStateHandler_2_io_global_config_pitchwheels_10),
    .io_global_config_pitchwheels_11(GeneratorStateHandler_2_io_global_config_pitchwheels_11),
    .io_global_config_pitchwheels_12(GeneratorStateHandler_2_io_global_config_pitchwheels_12),
    .io_global_config_pitchwheels_13(GeneratorStateHandler_2_io_global_config_pitchwheels_13),
    .io_global_config_pitchwheels_14(GeneratorStateHandler_2_io_global_config_pitchwheels_14),
    .io_global_config_pitchwheels_15(GeneratorStateHandler_2_io_global_config_pitchwheels_15),
    .io_step_sample(GeneratorStateHandler_2_io_step_sample),
    .io_envelope_effect_valid(GeneratorStateHandler_2_io_envelope_effect_valid),
    .io_envelope_effect(GeneratorStateHandler_2_io_envelope_effect),
    .io_state_generator_config_enabled(GeneratorStateHandler_2_io_state_generator_config_enabled),
    .io_state_generator_config_instrument(GeneratorStateHandler_2_io_state_generator_config_instrument),
    .io_state_generator_config_velocity(GeneratorStateHandler_2_io_state_generator_config_velocity),
    .io_state_note_life(GeneratorStateHandler_2_io_state_note_life),
    .io_state_wavelength(GeneratorStateHandler_2_io_state_wavelength),
    .io_state_wavelength_pos(GeneratorStateHandler_2_io_state_wavelength_pos),
    .io_state_last_active_envelope_effect(GeneratorStateHandler_2_io_state_last_active_envelope_effect)
  );
  GeneratorStateHandler GeneratorStateHandler_3 (
    .clock(GeneratorStateHandler_3_clock),
    .reset(GeneratorStateHandler_3_reset),
    .io_generator_update_valid(GeneratorStateHandler_3_io_generator_update_valid),
    .io_generator_update_reset_note(GeneratorStateHandler_3_io_generator_update_reset_note),
    .io_generator_update_enabled(GeneratorStateHandler_3_io_generator_update_enabled),
    .io_generator_update_instrument(GeneratorStateHandler_3_io_generator_update_instrument),
    .io_generator_update_note_index(GeneratorStateHandler_3_io_generator_update_note_index),
    .io_generator_update_channel_index(GeneratorStateHandler_3_io_generator_update_channel_index),
    .io_generator_update_velocity(GeneratorStateHandler_3_io_generator_update_velocity),
    .io_global_config_pitchwheels_0(GeneratorStateHandler_3_io_global_config_pitchwheels_0),
    .io_global_config_pitchwheels_1(GeneratorStateHandler_3_io_global_config_pitchwheels_1),
    .io_global_config_pitchwheels_2(GeneratorStateHandler_3_io_global_config_pitchwheels_2),
    .io_global_config_pitchwheels_3(GeneratorStateHandler_3_io_global_config_pitchwheels_3),
    .io_global_config_pitchwheels_4(GeneratorStateHandler_3_io_global_config_pitchwheels_4),
    .io_global_config_pitchwheels_5(GeneratorStateHandler_3_io_global_config_pitchwheels_5),
    .io_global_config_pitchwheels_6(GeneratorStateHandler_3_io_global_config_pitchwheels_6),
    .io_global_config_pitchwheels_7(GeneratorStateHandler_3_io_global_config_pitchwheels_7),
    .io_global_config_pitchwheels_8(GeneratorStateHandler_3_io_global_config_pitchwheels_8),
    .io_global_config_pitchwheels_9(GeneratorStateHandler_3_io_global_config_pitchwheels_9),
    .io_global_config_pitchwheels_10(GeneratorStateHandler_3_io_global_config_pitchwheels_10),
    .io_global_config_pitchwheels_11(GeneratorStateHandler_3_io_global_config_pitchwheels_11),
    .io_global_config_pitchwheels_12(GeneratorStateHandler_3_io_global_config_pitchwheels_12),
    .io_global_config_pitchwheels_13(GeneratorStateHandler_3_io_global_config_pitchwheels_13),
    .io_global_config_pitchwheels_14(GeneratorStateHandler_3_io_global_config_pitchwheels_14),
    .io_global_config_pitchwheels_15(GeneratorStateHandler_3_io_global_config_pitchwheels_15),
    .io_step_sample(GeneratorStateHandler_3_io_step_sample),
    .io_envelope_effect_valid(GeneratorStateHandler_3_io_envelope_effect_valid),
    .io_envelope_effect(GeneratorStateHandler_3_io_envelope_effect),
    .io_state_generator_config_enabled(GeneratorStateHandler_3_io_state_generator_config_enabled),
    .io_state_generator_config_instrument(GeneratorStateHandler_3_io_state_generator_config_instrument),
    .io_state_generator_config_velocity(GeneratorStateHandler_3_io_state_generator_config_velocity),
    .io_state_note_life(GeneratorStateHandler_3_io_state_note_life),
    .io_state_wavelength(GeneratorStateHandler_3_io_state_wavelength),
    .io_state_wavelength_pos(GeneratorStateHandler_3_io_state_wavelength_pos),
    .io_state_last_active_envelope_effect(GeneratorStateHandler_3_io_state_last_active_envelope_effect)
  );
  GeneratorStateHandler GeneratorStateHandler_4 (
    .clock(GeneratorStateHandler_4_clock),
    .reset(GeneratorStateHandler_4_reset),
    .io_generator_update_valid(GeneratorStateHandler_4_io_generator_update_valid),
    .io_generator_update_reset_note(GeneratorStateHandler_4_io_generator_update_reset_note),
    .io_generator_update_enabled(GeneratorStateHandler_4_io_generator_update_enabled),
    .io_generator_update_instrument(GeneratorStateHandler_4_io_generator_update_instrument),
    .io_generator_update_note_index(GeneratorStateHandler_4_io_generator_update_note_index),
    .io_generator_update_channel_index(GeneratorStateHandler_4_io_generator_update_channel_index),
    .io_generator_update_velocity(GeneratorStateHandler_4_io_generator_update_velocity),
    .io_global_config_pitchwheels_0(GeneratorStateHandler_4_io_global_config_pitchwheels_0),
    .io_global_config_pitchwheels_1(GeneratorStateHandler_4_io_global_config_pitchwheels_1),
    .io_global_config_pitchwheels_2(GeneratorStateHandler_4_io_global_config_pitchwheels_2),
    .io_global_config_pitchwheels_3(GeneratorStateHandler_4_io_global_config_pitchwheels_3),
    .io_global_config_pitchwheels_4(GeneratorStateHandler_4_io_global_config_pitchwheels_4),
    .io_global_config_pitchwheels_5(GeneratorStateHandler_4_io_global_config_pitchwheels_5),
    .io_global_config_pitchwheels_6(GeneratorStateHandler_4_io_global_config_pitchwheels_6),
    .io_global_config_pitchwheels_7(GeneratorStateHandler_4_io_global_config_pitchwheels_7),
    .io_global_config_pitchwheels_8(GeneratorStateHandler_4_io_global_config_pitchwheels_8),
    .io_global_config_pitchwheels_9(GeneratorStateHandler_4_io_global_config_pitchwheels_9),
    .io_global_config_pitchwheels_10(GeneratorStateHandler_4_io_global_config_pitchwheels_10),
    .io_global_config_pitchwheels_11(GeneratorStateHandler_4_io_global_config_pitchwheels_11),
    .io_global_config_pitchwheels_12(GeneratorStateHandler_4_io_global_config_pitchwheels_12),
    .io_global_config_pitchwheels_13(GeneratorStateHandler_4_io_global_config_pitchwheels_13),
    .io_global_config_pitchwheels_14(GeneratorStateHandler_4_io_global_config_pitchwheels_14),
    .io_global_config_pitchwheels_15(GeneratorStateHandler_4_io_global_config_pitchwheels_15),
    .io_step_sample(GeneratorStateHandler_4_io_step_sample),
    .io_envelope_effect_valid(GeneratorStateHandler_4_io_envelope_effect_valid),
    .io_envelope_effect(GeneratorStateHandler_4_io_envelope_effect),
    .io_state_generator_config_enabled(GeneratorStateHandler_4_io_state_generator_config_enabled),
    .io_state_generator_config_instrument(GeneratorStateHandler_4_io_state_generator_config_instrument),
    .io_state_generator_config_velocity(GeneratorStateHandler_4_io_state_generator_config_velocity),
    .io_state_note_life(GeneratorStateHandler_4_io_state_note_life),
    .io_state_wavelength(GeneratorStateHandler_4_io_state_wavelength),
    .io_state_wavelength_pos(GeneratorStateHandler_4_io_state_wavelength_pos),
    .io_state_last_active_envelope_effect(GeneratorStateHandler_4_io_state_last_active_envelope_effect)
  );
  GeneratorStateHandler GeneratorStateHandler_5 (
    .clock(GeneratorStateHandler_5_clock),
    .reset(GeneratorStateHandler_5_reset),
    .io_generator_update_valid(GeneratorStateHandler_5_io_generator_update_valid),
    .io_generator_update_reset_note(GeneratorStateHandler_5_io_generator_update_reset_note),
    .io_generator_update_enabled(GeneratorStateHandler_5_io_generator_update_enabled),
    .io_generator_update_instrument(GeneratorStateHandler_5_io_generator_update_instrument),
    .io_generator_update_note_index(GeneratorStateHandler_5_io_generator_update_note_index),
    .io_generator_update_channel_index(GeneratorStateHandler_5_io_generator_update_channel_index),
    .io_generator_update_velocity(GeneratorStateHandler_5_io_generator_update_velocity),
    .io_global_config_pitchwheels_0(GeneratorStateHandler_5_io_global_config_pitchwheels_0),
    .io_global_config_pitchwheels_1(GeneratorStateHandler_5_io_global_config_pitchwheels_1),
    .io_global_config_pitchwheels_2(GeneratorStateHandler_5_io_global_config_pitchwheels_2),
    .io_global_config_pitchwheels_3(GeneratorStateHandler_5_io_global_config_pitchwheels_3),
    .io_global_config_pitchwheels_4(GeneratorStateHandler_5_io_global_config_pitchwheels_4),
    .io_global_config_pitchwheels_5(GeneratorStateHandler_5_io_global_config_pitchwheels_5),
    .io_global_config_pitchwheels_6(GeneratorStateHandler_5_io_global_config_pitchwheels_6),
    .io_global_config_pitchwheels_7(GeneratorStateHandler_5_io_global_config_pitchwheels_7),
    .io_global_config_pitchwheels_8(GeneratorStateHandler_5_io_global_config_pitchwheels_8),
    .io_global_config_pitchwheels_9(GeneratorStateHandler_5_io_global_config_pitchwheels_9),
    .io_global_config_pitchwheels_10(GeneratorStateHandler_5_io_global_config_pitchwheels_10),
    .io_global_config_pitchwheels_11(GeneratorStateHandler_5_io_global_config_pitchwheels_11),
    .io_global_config_pitchwheels_12(GeneratorStateHandler_5_io_global_config_pitchwheels_12),
    .io_global_config_pitchwheels_13(GeneratorStateHandler_5_io_global_config_pitchwheels_13),
    .io_global_config_pitchwheels_14(GeneratorStateHandler_5_io_global_config_pitchwheels_14),
    .io_global_config_pitchwheels_15(GeneratorStateHandler_5_io_global_config_pitchwheels_15),
    .io_step_sample(GeneratorStateHandler_5_io_step_sample),
    .io_envelope_effect_valid(GeneratorStateHandler_5_io_envelope_effect_valid),
    .io_envelope_effect(GeneratorStateHandler_5_io_envelope_effect),
    .io_state_generator_config_enabled(GeneratorStateHandler_5_io_state_generator_config_enabled),
    .io_state_generator_config_instrument(GeneratorStateHandler_5_io_state_generator_config_instrument),
    .io_state_generator_config_velocity(GeneratorStateHandler_5_io_state_generator_config_velocity),
    .io_state_note_life(GeneratorStateHandler_5_io_state_note_life),
    .io_state_wavelength(GeneratorStateHandler_5_io_state_wavelength),
    .io_state_wavelength_pos(GeneratorStateHandler_5_io_state_wavelength_pos),
    .io_state_last_active_envelope_effect(GeneratorStateHandler_5_io_state_last_active_envelope_effect)
  );
  GeneratorStateHandler GeneratorStateHandler_6 (
    .clock(GeneratorStateHandler_6_clock),
    .reset(GeneratorStateHandler_6_reset),
    .io_generator_update_valid(GeneratorStateHandler_6_io_generator_update_valid),
    .io_generator_update_reset_note(GeneratorStateHandler_6_io_generator_update_reset_note),
    .io_generator_update_enabled(GeneratorStateHandler_6_io_generator_update_enabled),
    .io_generator_update_instrument(GeneratorStateHandler_6_io_generator_update_instrument),
    .io_generator_update_note_index(GeneratorStateHandler_6_io_generator_update_note_index),
    .io_generator_update_channel_index(GeneratorStateHandler_6_io_generator_update_channel_index),
    .io_generator_update_velocity(GeneratorStateHandler_6_io_generator_update_velocity),
    .io_global_config_pitchwheels_0(GeneratorStateHandler_6_io_global_config_pitchwheels_0),
    .io_global_config_pitchwheels_1(GeneratorStateHandler_6_io_global_config_pitchwheels_1),
    .io_global_config_pitchwheels_2(GeneratorStateHandler_6_io_global_config_pitchwheels_2),
    .io_global_config_pitchwheels_3(GeneratorStateHandler_6_io_global_config_pitchwheels_3),
    .io_global_config_pitchwheels_4(GeneratorStateHandler_6_io_global_config_pitchwheels_4),
    .io_global_config_pitchwheels_5(GeneratorStateHandler_6_io_global_config_pitchwheels_5),
    .io_global_config_pitchwheels_6(GeneratorStateHandler_6_io_global_config_pitchwheels_6),
    .io_global_config_pitchwheels_7(GeneratorStateHandler_6_io_global_config_pitchwheels_7),
    .io_global_config_pitchwheels_8(GeneratorStateHandler_6_io_global_config_pitchwheels_8),
    .io_global_config_pitchwheels_9(GeneratorStateHandler_6_io_global_config_pitchwheels_9),
    .io_global_config_pitchwheels_10(GeneratorStateHandler_6_io_global_config_pitchwheels_10),
    .io_global_config_pitchwheels_11(GeneratorStateHandler_6_io_global_config_pitchwheels_11),
    .io_global_config_pitchwheels_12(GeneratorStateHandler_6_io_global_config_pitchwheels_12),
    .io_global_config_pitchwheels_13(GeneratorStateHandler_6_io_global_config_pitchwheels_13),
    .io_global_config_pitchwheels_14(GeneratorStateHandler_6_io_global_config_pitchwheels_14),
    .io_global_config_pitchwheels_15(GeneratorStateHandler_6_io_global_config_pitchwheels_15),
    .io_step_sample(GeneratorStateHandler_6_io_step_sample),
    .io_envelope_effect_valid(GeneratorStateHandler_6_io_envelope_effect_valid),
    .io_envelope_effect(GeneratorStateHandler_6_io_envelope_effect),
    .io_state_generator_config_enabled(GeneratorStateHandler_6_io_state_generator_config_enabled),
    .io_state_generator_config_instrument(GeneratorStateHandler_6_io_state_generator_config_instrument),
    .io_state_generator_config_velocity(GeneratorStateHandler_6_io_state_generator_config_velocity),
    .io_state_note_life(GeneratorStateHandler_6_io_state_note_life),
    .io_state_wavelength(GeneratorStateHandler_6_io_state_wavelength),
    .io_state_wavelength_pos(GeneratorStateHandler_6_io_state_wavelength_pos),
    .io_state_last_active_envelope_effect(GeneratorStateHandler_6_io_state_last_active_envelope_effect)
  );
  GeneratorStateHandler GeneratorStateHandler_7 (
    .clock(GeneratorStateHandler_7_clock),
    .reset(GeneratorStateHandler_7_reset),
    .io_generator_update_valid(GeneratorStateHandler_7_io_generator_update_valid),
    .io_generator_update_reset_note(GeneratorStateHandler_7_io_generator_update_reset_note),
    .io_generator_update_enabled(GeneratorStateHandler_7_io_generator_update_enabled),
    .io_generator_update_instrument(GeneratorStateHandler_7_io_generator_update_instrument),
    .io_generator_update_note_index(GeneratorStateHandler_7_io_generator_update_note_index),
    .io_generator_update_channel_index(GeneratorStateHandler_7_io_generator_update_channel_index),
    .io_generator_update_velocity(GeneratorStateHandler_7_io_generator_update_velocity),
    .io_global_config_pitchwheels_0(GeneratorStateHandler_7_io_global_config_pitchwheels_0),
    .io_global_config_pitchwheels_1(GeneratorStateHandler_7_io_global_config_pitchwheels_1),
    .io_global_config_pitchwheels_2(GeneratorStateHandler_7_io_global_config_pitchwheels_2),
    .io_global_config_pitchwheels_3(GeneratorStateHandler_7_io_global_config_pitchwheels_3),
    .io_global_config_pitchwheels_4(GeneratorStateHandler_7_io_global_config_pitchwheels_4),
    .io_global_config_pitchwheels_5(GeneratorStateHandler_7_io_global_config_pitchwheels_5),
    .io_global_config_pitchwheels_6(GeneratorStateHandler_7_io_global_config_pitchwheels_6),
    .io_global_config_pitchwheels_7(GeneratorStateHandler_7_io_global_config_pitchwheels_7),
    .io_global_config_pitchwheels_8(GeneratorStateHandler_7_io_global_config_pitchwheels_8),
    .io_global_config_pitchwheels_9(GeneratorStateHandler_7_io_global_config_pitchwheels_9),
    .io_global_config_pitchwheels_10(GeneratorStateHandler_7_io_global_config_pitchwheels_10),
    .io_global_config_pitchwheels_11(GeneratorStateHandler_7_io_global_config_pitchwheels_11),
    .io_global_config_pitchwheels_12(GeneratorStateHandler_7_io_global_config_pitchwheels_12),
    .io_global_config_pitchwheels_13(GeneratorStateHandler_7_io_global_config_pitchwheels_13),
    .io_global_config_pitchwheels_14(GeneratorStateHandler_7_io_global_config_pitchwheels_14),
    .io_global_config_pitchwheels_15(GeneratorStateHandler_7_io_global_config_pitchwheels_15),
    .io_step_sample(GeneratorStateHandler_7_io_step_sample),
    .io_envelope_effect_valid(GeneratorStateHandler_7_io_envelope_effect_valid),
    .io_envelope_effect(GeneratorStateHandler_7_io_envelope_effect),
    .io_state_generator_config_enabled(GeneratorStateHandler_7_io_state_generator_config_enabled),
    .io_state_generator_config_instrument(GeneratorStateHandler_7_io_state_generator_config_instrument),
    .io_state_generator_config_velocity(GeneratorStateHandler_7_io_state_generator_config_velocity),
    .io_state_note_life(GeneratorStateHandler_7_io_state_note_life),
    .io_state_wavelength(GeneratorStateHandler_7_io_state_wavelength),
    .io_state_wavelength_pos(GeneratorStateHandler_7_io_state_wavelength_pos),
    .io_state_last_active_envelope_effect(GeneratorStateHandler_7_io_state_last_active_envelope_effect)
  );
  assign _T_35 = $signed(sample_out) / $signed(32'sh7f);
  assign _T_36 = {1'b0,$signed(global_config_volume)};
  assign _GEN_142 = {{24{_T_36[8]}},_T_36};
  assign _T_37 = $signed(_T_35) * $signed(_GEN_142);
  assign _T_38 = _T_37[40:0];
  assign _T_39 = $signed(_T_38);
  assign _GEN_143 = {$signed(_T_39), 4'h0};
  assign _T_41 = {{3{_GEN_143[44]}},_GEN_143};
  assign _T_46 = value == 4'h0;
  assign _T_50 = value == 4'h8;
  assign _T_53 = value + 4'h1;
  assign _T_76 = io_generator_update_packet_generator_index == 16'h0;
  assign _T_78 = value == 4'h1;
  assign _GEN_28 = _T_78 ? GeneratorStateHandler_io_state_last_active_envelope_effect : 16'h0;
  assign _GEN_29 = _T_78 ? GeneratorStateHandler_io_state_wavelength_pos : 32'h0;
  assign _GEN_30 = _T_78 ? GeneratorStateHandler_io_state_wavelength : 32'h0;
  assign _GEN_31 = _T_78 ? GeneratorStateHandler_io_state_note_life : 32'h0;
  assign _GEN_32 = _T_78 ? GeneratorStateHandler_io_state_generator_config_velocity : 8'h0;
  assign _GEN_35 = _T_78 ? GeneratorStateHandler_io_state_generator_config_instrument : 8'h0;
  assign _GEN_36 = _T_78 & GeneratorStateHandler_io_state_generator_config_enabled;
  assign _T_83 = io_generator_update_packet_generator_index == 16'h1;
  assign _T_85 = value == 4'h2;
  assign _GEN_42 = _T_85 ? GeneratorStateHandler_1_io_state_last_active_envelope_effect : _GEN_28;
  assign _GEN_43 = _T_85 ? GeneratorStateHandler_1_io_state_wavelength_pos : _GEN_29;
  assign _GEN_44 = _T_85 ? GeneratorStateHandler_1_io_state_wavelength : _GEN_30;
  assign _GEN_45 = _T_85 ? GeneratorStateHandler_1_io_state_note_life : _GEN_31;
  assign _GEN_46 = _T_85 ? GeneratorStateHandler_1_io_state_generator_config_velocity : _GEN_32;
  assign _GEN_49 = _T_85 ? GeneratorStateHandler_1_io_state_generator_config_instrument : _GEN_35;
  assign _GEN_50 = _T_85 ? GeneratorStateHandler_1_io_state_generator_config_enabled : _GEN_36;
  assign _T_90 = io_generator_update_packet_generator_index == 16'h2;
  assign _T_92 = value == 4'h3;
  assign _GEN_56 = _T_92 ? GeneratorStateHandler_2_io_state_last_active_envelope_effect : _GEN_42;
  assign _GEN_57 = _T_92 ? GeneratorStateHandler_2_io_state_wavelength_pos : _GEN_43;
  assign _GEN_58 = _T_92 ? GeneratorStateHandler_2_io_state_wavelength : _GEN_44;
  assign _GEN_59 = _T_92 ? GeneratorStateHandler_2_io_state_note_life : _GEN_45;
  assign _GEN_60 = _T_92 ? GeneratorStateHandler_2_io_state_generator_config_velocity : _GEN_46;
  assign _GEN_63 = _T_92 ? GeneratorStateHandler_2_io_state_generator_config_instrument : _GEN_49;
  assign _GEN_64 = _T_92 ? GeneratorStateHandler_2_io_state_generator_config_enabled : _GEN_50;
  assign _T_97 = io_generator_update_packet_generator_index == 16'h3;
  assign _T_99 = value == 4'h4;
  assign _GEN_70 = _T_99 ? GeneratorStateHandler_3_io_state_last_active_envelope_effect : _GEN_56;
  assign _GEN_71 = _T_99 ? GeneratorStateHandler_3_io_state_wavelength_pos : _GEN_57;
  assign _GEN_72 = _T_99 ? GeneratorStateHandler_3_io_state_wavelength : _GEN_58;
  assign _GEN_73 = _T_99 ? GeneratorStateHandler_3_io_state_note_life : _GEN_59;
  assign _GEN_74 = _T_99 ? GeneratorStateHandler_3_io_state_generator_config_velocity : _GEN_60;
  assign _GEN_77 = _T_99 ? GeneratorStateHandler_3_io_state_generator_config_instrument : _GEN_63;
  assign _GEN_78 = _T_99 ? GeneratorStateHandler_3_io_state_generator_config_enabled : _GEN_64;
  assign _T_104 = io_generator_update_packet_generator_index == 16'h4;
  assign _T_106 = value == 4'h5;
  assign _GEN_84 = _T_106 ? GeneratorStateHandler_4_io_state_last_active_envelope_effect : _GEN_70;
  assign _GEN_85 = _T_106 ? GeneratorStateHandler_4_io_state_wavelength_pos : _GEN_71;
  assign _GEN_86 = _T_106 ? GeneratorStateHandler_4_io_state_wavelength : _GEN_72;
  assign _GEN_87 = _T_106 ? GeneratorStateHandler_4_io_state_note_life : _GEN_73;
  assign _GEN_88 = _T_106 ? GeneratorStateHandler_4_io_state_generator_config_velocity : _GEN_74;
  assign _GEN_91 = _T_106 ? GeneratorStateHandler_4_io_state_generator_config_instrument : _GEN_77;
  assign _GEN_92 = _T_106 ? GeneratorStateHandler_4_io_state_generator_config_enabled : _GEN_78;
  assign _T_111 = io_generator_update_packet_generator_index == 16'h5;
  assign _T_113 = value == 4'h6;
  assign _GEN_98 = _T_113 ? GeneratorStateHandler_5_io_state_last_active_envelope_effect : _GEN_84;
  assign _GEN_99 = _T_113 ? GeneratorStateHandler_5_io_state_wavelength_pos : _GEN_85;
  assign _GEN_100 = _T_113 ? GeneratorStateHandler_5_io_state_wavelength : _GEN_86;
  assign _GEN_101 = _T_113 ? GeneratorStateHandler_5_io_state_note_life : _GEN_87;
  assign _GEN_102 = _T_113 ? GeneratorStateHandler_5_io_state_generator_config_velocity : _GEN_88;
  assign _GEN_105 = _T_113 ? GeneratorStateHandler_5_io_state_generator_config_instrument : _GEN_91;
  assign _GEN_106 = _T_113 ? GeneratorStateHandler_5_io_state_generator_config_enabled : _GEN_92;
  assign _T_118 = io_generator_update_packet_generator_index == 16'h6;
  assign _T_120 = value == 4'h7;
  assign _GEN_112 = _T_120 ? GeneratorStateHandler_6_io_state_last_active_envelope_effect : _GEN_98;
  assign _GEN_113 = _T_120 ? GeneratorStateHandler_6_io_state_wavelength_pos : _GEN_99;
  assign _GEN_114 = _T_120 ? GeneratorStateHandler_6_io_state_wavelength : _GEN_100;
  assign _GEN_115 = _T_120 ? GeneratorStateHandler_6_io_state_note_life : _GEN_101;
  assign _GEN_116 = _T_120 ? GeneratorStateHandler_6_io_state_generator_config_velocity : _GEN_102;
  assign _GEN_119 = _T_120 ? GeneratorStateHandler_6_io_state_generator_config_instrument : _GEN_105;
  assign _GEN_120 = _T_120 ? GeneratorStateHandler_6_io_state_generator_config_enabled : _GEN_106;
  assign _T_125 = io_generator_update_packet_generator_index == 16'h7;
  assign _T_130 = value != 4'h0;
  assign _T_132 = $signed(sample_out) + $signed(GeneratorSampleComputer_io_sample_out);
  assign _T_133 = $signed(_T_132);
  assign _GEN_144 = _T_41[31:0];
  assign io_sample_out = $signed(_GEN_144);
  assign io_sample_out_valid = value == 4'h0;
  assign GeneratorSampleComputer_io_state_generator_config_enabled = _T_50 ? GeneratorStateHandler_7_io_state_generator_config_enabled : _GEN_120;
  assign GeneratorSampleComputer_io_state_generator_config_instrument = _T_50 ? GeneratorStateHandler_7_io_state_generator_config_instrument : _GEN_119;
  assign GeneratorSampleComputer_io_state_generator_config_velocity = _T_50 ? GeneratorStateHandler_7_io_state_generator_config_velocity : _GEN_116;
  assign GeneratorSampleComputer_io_state_note_life = _T_50 ? GeneratorStateHandler_7_io_state_note_life : _GEN_115;
  assign GeneratorSampleComputer_io_state_wavelength = _T_50 ? GeneratorStateHandler_7_io_state_wavelength : _GEN_114;
  assign GeneratorSampleComputer_io_state_wavelength_pos = _T_50 ? GeneratorStateHandler_7_io_state_wavelength_pos : _GEN_113;
  assign GeneratorSampleComputer_io_state_last_active_envelope_effect = _T_50 ? GeneratorStateHandler_7_io_state_last_active_envelope_effect : _GEN_112;
  assign GeneratorSampleComputer_io_global_config_envelope_attack = global_config_envelope_attack;
  assign GeneratorSampleComputer_io_global_config_envelope_decay = global_config_envelope_decay;
  assign GeneratorSampleComputer_io_global_config_envelope_sustain = global_config_envelope_sustain;
  assign GeneratorSampleComputer_io_global_config_envelope_release = global_config_envelope_release;
  assign GeneratorStateHandler_clock = clock;
  assign GeneratorStateHandler_reset = reset;
  assign GeneratorStateHandler_io_generator_update_valid = _T_76 & io_generator_update_packet_valid;
  assign GeneratorStateHandler_io_generator_update_reset_note = io_generator_update_packet_data_reset_note;
  assign GeneratorStateHandler_io_generator_update_enabled = io_generator_update_packet_data_enabled;
  assign GeneratorStateHandler_io_generator_update_instrument = io_generator_update_packet_data_instrument;
  assign GeneratorStateHandler_io_generator_update_note_index = io_generator_update_packet_data_note_index;
  assign GeneratorStateHandler_io_generator_update_channel_index = io_generator_update_packet_data_channel_index;
  assign GeneratorStateHandler_io_generator_update_velocity = io_generator_update_packet_data_velocity;
  assign GeneratorStateHandler_io_global_config_pitchwheels_0 = global_config_pitchwheels_0;
  assign GeneratorStateHandler_io_global_config_pitchwheels_1 = global_config_pitchwheels_1;
  assign GeneratorStateHandler_io_global_config_pitchwheels_2 = global_config_pitchwheels_2;
  assign GeneratorStateHandler_io_global_config_pitchwheels_3 = global_config_pitchwheels_3;
  assign GeneratorStateHandler_io_global_config_pitchwheels_4 = global_config_pitchwheels_4;
  assign GeneratorStateHandler_io_global_config_pitchwheels_5 = global_config_pitchwheels_5;
  assign GeneratorStateHandler_io_global_config_pitchwheels_6 = global_config_pitchwheels_6;
  assign GeneratorStateHandler_io_global_config_pitchwheels_7 = global_config_pitchwheels_7;
  assign GeneratorStateHandler_io_global_config_pitchwheels_8 = global_config_pitchwheels_8;
  assign GeneratorStateHandler_io_global_config_pitchwheels_9 = global_config_pitchwheels_9;
  assign GeneratorStateHandler_io_global_config_pitchwheels_10 = global_config_pitchwheels_10;
  assign GeneratorStateHandler_io_global_config_pitchwheels_11 = global_config_pitchwheels_11;
  assign GeneratorStateHandler_io_global_config_pitchwheels_12 = global_config_pitchwheels_12;
  assign GeneratorStateHandler_io_global_config_pitchwheels_13 = global_config_pitchwheels_13;
  assign GeneratorStateHandler_io_global_config_pitchwheels_14 = global_config_pitchwheels_14;
  assign GeneratorStateHandler_io_global_config_pitchwheels_15 = global_config_pitchwheels_15;
  assign GeneratorStateHandler_io_step_sample = io_step_sample;
  assign GeneratorStateHandler_io_envelope_effect_valid = value == 4'h1;
  assign GeneratorStateHandler_io_envelope_effect = GeneratorSampleComputer_io_envelope_effect;
  assign GeneratorStateHandler_1_clock = clock;
  assign GeneratorStateHandler_1_reset = reset;
  assign GeneratorStateHandler_1_io_generator_update_valid = _T_83 & io_generator_update_packet_valid;
  assign GeneratorStateHandler_1_io_generator_update_reset_note = io_generator_update_packet_data_reset_note;
  assign GeneratorStateHandler_1_io_generator_update_enabled = io_generator_update_packet_data_enabled;
  assign GeneratorStateHandler_1_io_generator_update_instrument = io_generator_update_packet_data_instrument;
  assign GeneratorStateHandler_1_io_generator_update_note_index = io_generator_update_packet_data_note_index;
  assign GeneratorStateHandler_1_io_generator_update_channel_index = io_generator_update_packet_data_channel_index;
  assign GeneratorStateHandler_1_io_generator_update_velocity = io_generator_update_packet_data_velocity;
  assign GeneratorStateHandler_1_io_global_config_pitchwheels_0 = global_config_pitchwheels_0;
  assign GeneratorStateHandler_1_io_global_config_pitchwheels_1 = global_config_pitchwheels_1;
  assign GeneratorStateHandler_1_io_global_config_pitchwheels_2 = global_config_pitchwheels_2;
  assign GeneratorStateHandler_1_io_global_config_pitchwheels_3 = global_config_pitchwheels_3;
  assign GeneratorStateHandler_1_io_global_config_pitchwheels_4 = global_config_pitchwheels_4;
  assign GeneratorStateHandler_1_io_global_config_pitchwheels_5 = global_config_pitchwheels_5;
  assign GeneratorStateHandler_1_io_global_config_pitchwheels_6 = global_config_pitchwheels_6;
  assign GeneratorStateHandler_1_io_global_config_pitchwheels_7 = global_config_pitchwheels_7;
  assign GeneratorStateHandler_1_io_global_config_pitchwheels_8 = global_config_pitchwheels_8;
  assign GeneratorStateHandler_1_io_global_config_pitchwheels_9 = global_config_pitchwheels_9;
  assign GeneratorStateHandler_1_io_global_config_pitchwheels_10 = global_config_pitchwheels_10;
  assign GeneratorStateHandler_1_io_global_config_pitchwheels_11 = global_config_pitchwheels_11;
  assign GeneratorStateHandler_1_io_global_config_pitchwheels_12 = global_config_pitchwheels_12;
  assign GeneratorStateHandler_1_io_global_config_pitchwheels_13 = global_config_pitchwheels_13;
  assign GeneratorStateHandler_1_io_global_config_pitchwheels_14 = global_config_pitchwheels_14;
  assign GeneratorStateHandler_1_io_global_config_pitchwheels_15 = global_config_pitchwheels_15;
  assign GeneratorStateHandler_1_io_step_sample = io_step_sample;
  assign GeneratorStateHandler_1_io_envelope_effect_valid = value == 4'h2;
  assign GeneratorStateHandler_1_io_envelope_effect = GeneratorSampleComputer_io_envelope_effect;
  assign GeneratorStateHandler_2_clock = clock;
  assign GeneratorStateHandler_2_reset = reset;
  assign GeneratorStateHandler_2_io_generator_update_valid = _T_90 & io_generator_update_packet_valid;
  assign GeneratorStateHandler_2_io_generator_update_reset_note = io_generator_update_packet_data_reset_note;
  assign GeneratorStateHandler_2_io_generator_update_enabled = io_generator_update_packet_data_enabled;
  assign GeneratorStateHandler_2_io_generator_update_instrument = io_generator_update_packet_data_instrument;
  assign GeneratorStateHandler_2_io_generator_update_note_index = io_generator_update_packet_data_note_index;
  assign GeneratorStateHandler_2_io_generator_update_channel_index = io_generator_update_packet_data_channel_index;
  assign GeneratorStateHandler_2_io_generator_update_velocity = io_generator_update_packet_data_velocity;
  assign GeneratorStateHandler_2_io_global_config_pitchwheels_0 = global_config_pitchwheels_0;
  assign GeneratorStateHandler_2_io_global_config_pitchwheels_1 = global_config_pitchwheels_1;
  assign GeneratorStateHandler_2_io_global_config_pitchwheels_2 = global_config_pitchwheels_2;
  assign GeneratorStateHandler_2_io_global_config_pitchwheels_3 = global_config_pitchwheels_3;
  assign GeneratorStateHandler_2_io_global_config_pitchwheels_4 = global_config_pitchwheels_4;
  assign GeneratorStateHandler_2_io_global_config_pitchwheels_5 = global_config_pitchwheels_5;
  assign GeneratorStateHandler_2_io_global_config_pitchwheels_6 = global_config_pitchwheels_6;
  assign GeneratorStateHandler_2_io_global_config_pitchwheels_7 = global_config_pitchwheels_7;
  assign GeneratorStateHandler_2_io_global_config_pitchwheels_8 = global_config_pitchwheels_8;
  assign GeneratorStateHandler_2_io_global_config_pitchwheels_9 = global_config_pitchwheels_9;
  assign GeneratorStateHandler_2_io_global_config_pitchwheels_10 = global_config_pitchwheels_10;
  assign GeneratorStateHandler_2_io_global_config_pitchwheels_11 = global_config_pitchwheels_11;
  assign GeneratorStateHandler_2_io_global_config_pitchwheels_12 = global_config_pitchwheels_12;
  assign GeneratorStateHandler_2_io_global_config_pitchwheels_13 = global_config_pitchwheels_13;
  assign GeneratorStateHandler_2_io_global_config_pitchwheels_14 = global_config_pitchwheels_14;
  assign GeneratorStateHandler_2_io_global_config_pitchwheels_15 = global_config_pitchwheels_15;
  assign GeneratorStateHandler_2_io_step_sample = io_step_sample;
  assign GeneratorStateHandler_2_io_envelope_effect_valid = value == 4'h3;
  assign GeneratorStateHandler_2_io_envelope_effect = GeneratorSampleComputer_io_envelope_effect;
  assign GeneratorStateHandler_3_clock = clock;
  assign GeneratorStateHandler_3_reset = reset;
  assign GeneratorStateHandler_3_io_generator_update_valid = _T_97 & io_generator_update_packet_valid;
  assign GeneratorStateHandler_3_io_generator_update_reset_note = io_generator_update_packet_data_reset_note;
  assign GeneratorStateHandler_3_io_generator_update_enabled = io_generator_update_packet_data_enabled;
  assign GeneratorStateHandler_3_io_generator_update_instrument = io_generator_update_packet_data_instrument;
  assign GeneratorStateHandler_3_io_generator_update_note_index = io_generator_update_packet_data_note_index;
  assign GeneratorStateHandler_3_io_generator_update_channel_index = io_generator_update_packet_data_channel_index;
  assign GeneratorStateHandler_3_io_generator_update_velocity = io_generator_update_packet_data_velocity;
  assign GeneratorStateHandler_3_io_global_config_pitchwheels_0 = global_config_pitchwheels_0;
  assign GeneratorStateHandler_3_io_global_config_pitchwheels_1 = global_config_pitchwheels_1;
  assign GeneratorStateHandler_3_io_global_config_pitchwheels_2 = global_config_pitchwheels_2;
  assign GeneratorStateHandler_3_io_global_config_pitchwheels_3 = global_config_pitchwheels_3;
  assign GeneratorStateHandler_3_io_global_config_pitchwheels_4 = global_config_pitchwheels_4;
  assign GeneratorStateHandler_3_io_global_config_pitchwheels_5 = global_config_pitchwheels_5;
  assign GeneratorStateHandler_3_io_global_config_pitchwheels_6 = global_config_pitchwheels_6;
  assign GeneratorStateHandler_3_io_global_config_pitchwheels_7 = global_config_pitchwheels_7;
  assign GeneratorStateHandler_3_io_global_config_pitchwheels_8 = global_config_pitchwheels_8;
  assign GeneratorStateHandler_3_io_global_config_pitchwheels_9 = global_config_pitchwheels_9;
  assign GeneratorStateHandler_3_io_global_config_pitchwheels_10 = global_config_pitchwheels_10;
  assign GeneratorStateHandler_3_io_global_config_pitchwheels_11 = global_config_pitchwheels_11;
  assign GeneratorStateHandler_3_io_global_config_pitchwheels_12 = global_config_pitchwheels_12;
  assign GeneratorStateHandler_3_io_global_config_pitchwheels_13 = global_config_pitchwheels_13;
  assign GeneratorStateHandler_3_io_global_config_pitchwheels_14 = global_config_pitchwheels_14;
  assign GeneratorStateHandler_3_io_global_config_pitchwheels_15 = global_config_pitchwheels_15;
  assign GeneratorStateHandler_3_io_step_sample = io_step_sample;
  assign GeneratorStateHandler_3_io_envelope_effect_valid = value == 4'h4;
  assign GeneratorStateHandler_3_io_envelope_effect = GeneratorSampleComputer_io_envelope_effect;
  assign GeneratorStateHandler_4_clock = clock;
  assign GeneratorStateHandler_4_reset = reset;
  assign GeneratorStateHandler_4_io_generator_update_valid = _T_104 & io_generator_update_packet_valid;
  assign GeneratorStateHandler_4_io_generator_update_reset_note = io_generator_update_packet_data_reset_note;
  assign GeneratorStateHandler_4_io_generator_update_enabled = io_generator_update_packet_data_enabled;
  assign GeneratorStateHandler_4_io_generator_update_instrument = io_generator_update_packet_data_instrument;
  assign GeneratorStateHandler_4_io_generator_update_note_index = io_generator_update_packet_data_note_index;
  assign GeneratorStateHandler_4_io_generator_update_channel_index = io_generator_update_packet_data_channel_index;
  assign GeneratorStateHandler_4_io_generator_update_velocity = io_generator_update_packet_data_velocity;
  assign GeneratorStateHandler_4_io_global_config_pitchwheels_0 = global_config_pitchwheels_0;
  assign GeneratorStateHandler_4_io_global_config_pitchwheels_1 = global_config_pitchwheels_1;
  assign GeneratorStateHandler_4_io_global_config_pitchwheels_2 = global_config_pitchwheels_2;
  assign GeneratorStateHandler_4_io_global_config_pitchwheels_3 = global_config_pitchwheels_3;
  assign GeneratorStateHandler_4_io_global_config_pitchwheels_4 = global_config_pitchwheels_4;
  assign GeneratorStateHandler_4_io_global_config_pitchwheels_5 = global_config_pitchwheels_5;
  assign GeneratorStateHandler_4_io_global_config_pitchwheels_6 = global_config_pitchwheels_6;
  assign GeneratorStateHandler_4_io_global_config_pitchwheels_7 = global_config_pitchwheels_7;
  assign GeneratorStateHandler_4_io_global_config_pitchwheels_8 = global_config_pitchwheels_8;
  assign GeneratorStateHandler_4_io_global_config_pitchwheels_9 = global_config_pitchwheels_9;
  assign GeneratorStateHandler_4_io_global_config_pitchwheels_10 = global_config_pitchwheels_10;
  assign GeneratorStateHandler_4_io_global_config_pitchwheels_11 = global_config_pitchwheels_11;
  assign GeneratorStateHandler_4_io_global_config_pitchwheels_12 = global_config_pitchwheels_12;
  assign GeneratorStateHandler_4_io_global_config_pitchwheels_13 = global_config_pitchwheels_13;
  assign GeneratorStateHandler_4_io_global_config_pitchwheels_14 = global_config_pitchwheels_14;
  assign GeneratorStateHandler_4_io_global_config_pitchwheels_15 = global_config_pitchwheels_15;
  assign GeneratorStateHandler_4_io_step_sample = io_step_sample;
  assign GeneratorStateHandler_4_io_envelope_effect_valid = value == 4'h5;
  assign GeneratorStateHandler_4_io_envelope_effect = GeneratorSampleComputer_io_envelope_effect;
  assign GeneratorStateHandler_5_clock = clock;
  assign GeneratorStateHandler_5_reset = reset;
  assign GeneratorStateHandler_5_io_generator_update_valid = _T_111 & io_generator_update_packet_valid;
  assign GeneratorStateHandler_5_io_generator_update_reset_note = io_generator_update_packet_data_reset_note;
  assign GeneratorStateHandler_5_io_generator_update_enabled = io_generator_update_packet_data_enabled;
  assign GeneratorStateHandler_5_io_generator_update_instrument = io_generator_update_packet_data_instrument;
  assign GeneratorStateHandler_5_io_generator_update_note_index = io_generator_update_packet_data_note_index;
  assign GeneratorStateHandler_5_io_generator_update_channel_index = io_generator_update_packet_data_channel_index;
  assign GeneratorStateHandler_5_io_generator_update_velocity = io_generator_update_packet_data_velocity;
  assign GeneratorStateHandler_5_io_global_config_pitchwheels_0 = global_config_pitchwheels_0;
  assign GeneratorStateHandler_5_io_global_config_pitchwheels_1 = global_config_pitchwheels_1;
  assign GeneratorStateHandler_5_io_global_config_pitchwheels_2 = global_config_pitchwheels_2;
  assign GeneratorStateHandler_5_io_global_config_pitchwheels_3 = global_config_pitchwheels_3;
  assign GeneratorStateHandler_5_io_global_config_pitchwheels_4 = global_config_pitchwheels_4;
  assign GeneratorStateHandler_5_io_global_config_pitchwheels_5 = global_config_pitchwheels_5;
  assign GeneratorStateHandler_5_io_global_config_pitchwheels_6 = global_config_pitchwheels_6;
  assign GeneratorStateHandler_5_io_global_config_pitchwheels_7 = global_config_pitchwheels_7;
  assign GeneratorStateHandler_5_io_global_config_pitchwheels_8 = global_config_pitchwheels_8;
  assign GeneratorStateHandler_5_io_global_config_pitchwheels_9 = global_config_pitchwheels_9;
  assign GeneratorStateHandler_5_io_global_config_pitchwheels_10 = global_config_pitchwheels_10;
  assign GeneratorStateHandler_5_io_global_config_pitchwheels_11 = global_config_pitchwheels_11;
  assign GeneratorStateHandler_5_io_global_config_pitchwheels_12 = global_config_pitchwheels_12;
  assign GeneratorStateHandler_5_io_global_config_pitchwheels_13 = global_config_pitchwheels_13;
  assign GeneratorStateHandler_5_io_global_config_pitchwheels_14 = global_config_pitchwheels_14;
  assign GeneratorStateHandler_5_io_global_config_pitchwheels_15 = global_config_pitchwheels_15;
  assign GeneratorStateHandler_5_io_step_sample = io_step_sample;
  assign GeneratorStateHandler_5_io_envelope_effect_valid = value == 4'h6;
  assign GeneratorStateHandler_5_io_envelope_effect = GeneratorSampleComputer_io_envelope_effect;
  assign GeneratorStateHandler_6_clock = clock;
  assign GeneratorStateHandler_6_reset = reset;
  assign GeneratorStateHandler_6_io_generator_update_valid = _T_118 & io_generator_update_packet_valid;
  assign GeneratorStateHandler_6_io_generator_update_reset_note = io_generator_update_packet_data_reset_note;
  assign GeneratorStateHandler_6_io_generator_update_enabled = io_generator_update_packet_data_enabled;
  assign GeneratorStateHandler_6_io_generator_update_instrument = io_generator_update_packet_data_instrument;
  assign GeneratorStateHandler_6_io_generator_update_note_index = io_generator_update_packet_data_note_index;
  assign GeneratorStateHandler_6_io_generator_update_channel_index = io_generator_update_packet_data_channel_index;
  assign GeneratorStateHandler_6_io_generator_update_velocity = io_generator_update_packet_data_velocity;
  assign GeneratorStateHandler_6_io_global_config_pitchwheels_0 = global_config_pitchwheels_0;
  assign GeneratorStateHandler_6_io_global_config_pitchwheels_1 = global_config_pitchwheels_1;
  assign GeneratorStateHandler_6_io_global_config_pitchwheels_2 = global_config_pitchwheels_2;
  assign GeneratorStateHandler_6_io_global_config_pitchwheels_3 = global_config_pitchwheels_3;
  assign GeneratorStateHandler_6_io_global_config_pitchwheels_4 = global_config_pitchwheels_4;
  assign GeneratorStateHandler_6_io_global_config_pitchwheels_5 = global_config_pitchwheels_5;
  assign GeneratorStateHandler_6_io_global_config_pitchwheels_6 = global_config_pitchwheels_6;
  assign GeneratorStateHandler_6_io_global_config_pitchwheels_7 = global_config_pitchwheels_7;
  assign GeneratorStateHandler_6_io_global_config_pitchwheels_8 = global_config_pitchwheels_8;
  assign GeneratorStateHandler_6_io_global_config_pitchwheels_9 = global_config_pitchwheels_9;
  assign GeneratorStateHandler_6_io_global_config_pitchwheels_10 = global_config_pitchwheels_10;
  assign GeneratorStateHandler_6_io_global_config_pitchwheels_11 = global_config_pitchwheels_11;
  assign GeneratorStateHandler_6_io_global_config_pitchwheels_12 = global_config_pitchwheels_12;
  assign GeneratorStateHandler_6_io_global_config_pitchwheels_13 = global_config_pitchwheels_13;
  assign GeneratorStateHandler_6_io_global_config_pitchwheels_14 = global_config_pitchwheels_14;
  assign GeneratorStateHandler_6_io_global_config_pitchwheels_15 = global_config_pitchwheels_15;
  assign GeneratorStateHandler_6_io_step_sample = io_step_sample;
  assign GeneratorStateHandler_6_io_envelope_effect_valid = value == 4'h7;
  assign GeneratorStateHandler_6_io_envelope_effect = GeneratorSampleComputer_io_envelope_effect;
  assign GeneratorStateHandler_7_clock = clock;
  assign GeneratorStateHandler_7_reset = reset;
  assign GeneratorStateHandler_7_io_generator_update_valid = _T_125 & io_generator_update_packet_valid;
  assign GeneratorStateHandler_7_io_generator_update_reset_note = io_generator_update_packet_data_reset_note;
  assign GeneratorStateHandler_7_io_generator_update_enabled = io_generator_update_packet_data_enabled;
  assign GeneratorStateHandler_7_io_generator_update_instrument = io_generator_update_packet_data_instrument;
  assign GeneratorStateHandler_7_io_generator_update_note_index = io_generator_update_packet_data_note_index;
  assign GeneratorStateHandler_7_io_generator_update_channel_index = io_generator_update_packet_data_channel_index;
  assign GeneratorStateHandler_7_io_generator_update_velocity = io_generator_update_packet_data_velocity;
  assign GeneratorStateHandler_7_io_global_config_pitchwheels_0 = global_config_pitchwheels_0;
  assign GeneratorStateHandler_7_io_global_config_pitchwheels_1 = global_config_pitchwheels_1;
  assign GeneratorStateHandler_7_io_global_config_pitchwheels_2 = global_config_pitchwheels_2;
  assign GeneratorStateHandler_7_io_global_config_pitchwheels_3 = global_config_pitchwheels_3;
  assign GeneratorStateHandler_7_io_global_config_pitchwheels_4 = global_config_pitchwheels_4;
  assign GeneratorStateHandler_7_io_global_config_pitchwheels_5 = global_config_pitchwheels_5;
  assign GeneratorStateHandler_7_io_global_config_pitchwheels_6 = global_config_pitchwheels_6;
  assign GeneratorStateHandler_7_io_global_config_pitchwheels_7 = global_config_pitchwheels_7;
  assign GeneratorStateHandler_7_io_global_config_pitchwheels_8 = global_config_pitchwheels_8;
  assign GeneratorStateHandler_7_io_global_config_pitchwheels_9 = global_config_pitchwheels_9;
  assign GeneratorStateHandler_7_io_global_config_pitchwheels_10 = global_config_pitchwheels_10;
  assign GeneratorStateHandler_7_io_global_config_pitchwheels_11 = global_config_pitchwheels_11;
  assign GeneratorStateHandler_7_io_global_config_pitchwheels_12 = global_config_pitchwheels_12;
  assign GeneratorStateHandler_7_io_global_config_pitchwheels_13 = global_config_pitchwheels_13;
  assign GeneratorStateHandler_7_io_global_config_pitchwheels_14 = global_config_pitchwheels_14;
  assign GeneratorStateHandler_7_io_global_config_pitchwheels_15 = global_config_pitchwheels_15;
  assign GeneratorStateHandler_7_io_step_sample = io_step_sample;
  assign GeneratorStateHandler_7_io_envelope_effect_valid = value == 4'h8;
  assign GeneratorStateHandler_7_io_envelope_effect = GeneratorSampleComputer_io_envelope_effect;
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
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  global_config_volume = _RAND_0[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  global_config_envelope_attack = _RAND_1[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  global_config_envelope_decay = _RAND_2[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  global_config_envelope_sustain = _RAND_3[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  global_config_envelope_release = _RAND_4[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  global_config_pitchwheels_0 = _RAND_5[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  global_config_pitchwheels_1 = _RAND_6[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  global_config_pitchwheels_2 = _RAND_7[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  global_config_pitchwheels_3 = _RAND_8[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  global_config_pitchwheels_4 = _RAND_9[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {1{`RANDOM}};
  global_config_pitchwheels_5 = _RAND_10[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {1{`RANDOM}};
  global_config_pitchwheels_6 = _RAND_11[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_12 = {1{`RANDOM}};
  global_config_pitchwheels_7 = _RAND_12[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_13 = {1{`RANDOM}};
  global_config_pitchwheels_8 = _RAND_13[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_14 = {1{`RANDOM}};
  global_config_pitchwheels_9 = _RAND_14[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_15 = {1{`RANDOM}};
  global_config_pitchwheels_10 = _RAND_15[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_16 = {1{`RANDOM}};
  global_config_pitchwheels_11 = _RAND_16[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_17 = {1{`RANDOM}};
  global_config_pitchwheels_12 = _RAND_17[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_18 = {1{`RANDOM}};
  global_config_pitchwheels_13 = _RAND_18[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_19 = {1{`RANDOM}};
  global_config_pitchwheels_14 = _RAND_19[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_20 = {1{`RANDOM}};
  global_config_pitchwheels_15 = _RAND_20[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_21 = {1{`RANDOM}};
  sample_out = _RAND_21[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_22 = {1{`RANDOM}};
  value = _RAND_22[3:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    if (io_global_update_packet_valid) begin
      global_config_volume <= io_global_update_packet_data_volume;
    end
    if (io_global_update_packet_valid) begin
      global_config_envelope_attack <= io_global_update_packet_data_envelope_attack;
    end
    if (io_global_update_packet_valid) begin
      global_config_envelope_decay <= io_global_update_packet_data_envelope_decay;
    end
    if (io_global_update_packet_valid) begin
      global_config_envelope_sustain <= io_global_update_packet_data_envelope_sustain;
    end
    if (io_global_update_packet_valid) begin
      global_config_envelope_release <= io_global_update_packet_data_envelope_release;
    end
    if (io_global_update_packet_valid) begin
      global_config_pitchwheels_0 <= io_global_update_packet_data_pitchwheels_0;
    end
    if (io_global_update_packet_valid) begin
      global_config_pitchwheels_1 <= io_global_update_packet_data_pitchwheels_1;
    end
    if (io_global_update_packet_valid) begin
      global_config_pitchwheels_2 <= io_global_update_packet_data_pitchwheels_2;
    end
    if (io_global_update_packet_valid) begin
      global_config_pitchwheels_3 <= io_global_update_packet_data_pitchwheels_3;
    end
    if (io_global_update_packet_valid) begin
      global_config_pitchwheels_4 <= io_global_update_packet_data_pitchwheels_4;
    end
    if (io_global_update_packet_valid) begin
      global_config_pitchwheels_5 <= io_global_update_packet_data_pitchwheels_5;
    end
    if (io_global_update_packet_valid) begin
      global_config_pitchwheels_6 <= io_global_update_packet_data_pitchwheels_6;
    end
    if (io_global_update_packet_valid) begin
      global_config_pitchwheels_7 <= io_global_update_packet_data_pitchwheels_7;
    end
    if (io_global_update_packet_valid) begin
      global_config_pitchwheels_8 <= io_global_update_packet_data_pitchwheels_8;
    end
    if (io_global_update_packet_valid) begin
      global_config_pitchwheels_9 <= io_global_update_packet_data_pitchwheels_9;
    end
    if (io_global_update_packet_valid) begin
      global_config_pitchwheels_10 <= io_global_update_packet_data_pitchwheels_10;
    end
    if (io_global_update_packet_valid) begin
      global_config_pitchwheels_11 <= io_global_update_packet_data_pitchwheels_11;
    end
    if (io_global_update_packet_valid) begin
      global_config_pitchwheels_12 <= io_global_update_packet_data_pitchwheels_12;
    end
    if (io_global_update_packet_valid) begin
      global_config_pitchwheels_13 <= io_global_update_packet_data_pitchwheels_13;
    end
    if (io_global_update_packet_valid) begin
      global_config_pitchwheels_14 <= io_global_update_packet_data_pitchwheels_14;
    end
    if (io_global_update_packet_valid) begin
      global_config_pitchwheels_15 <= io_global_update_packet_data_pitchwheels_15;
    end
    if (reset) begin
      sample_out <= 32'sh0;
    end else begin
      if (_T_130) begin
        sample_out <= _T_133;
      end else begin
        if (_T_46) begin
          if (io_step_sample) begin
            sample_out <= 32'sh0;
          end
        end
      end
    end
    if (reset) begin
      value <= 4'h0;
    end else begin
      if (_T_130) begin
        if (_T_50) begin
          value <= 4'h0;
        end else begin
          value <= _T_53;
        end
      end else begin
        if (_T_46) begin
          if (io_step_sample) begin
            if (_T_50) begin
              value <= 4'h0;
            end else begin
              value <= _T_53;
            end
          end
        end
      end
    end
  end
endmodule
module SPISlave(
  input        clock,
  input        reset,
  output       io_RX_data_valid,
  output [7:0] io_RX_data,
  input        io_spi_mosi,
  output       io_spi_miso,
  input        io_spi_clk,
  input        io_spi_cs_n
);
  wire  spi_i_Clk;
  wire  spi_i_Rst_L;
  wire  spi_o_RX_DV;
  wire [7:0] spi_o_RX_Byte;
  wire  spi_i_TX_DV;
  wire [7:0] spi_i_TX_Byte;
  wire  spi_i_SPI_Clk;
  wire  spi_o_SPI_MISO;
  wire  spi_i_SPI_MOSI;
  wire  spi_i_SPI_CS_n;
  SPI_Slave_nandland #(.SPI_MODE(0)) spi (
    .i_Clk(spi_i_Clk),
    .i_Rst_L(spi_i_Rst_L),
    .o_RX_DV(spi_o_RX_DV),
    .o_RX_Byte(spi_o_RX_Byte),
    .i_TX_DV(spi_i_TX_DV),
    .i_TX_Byte(spi_i_TX_Byte),
    .i_SPI_Clk(spi_i_SPI_Clk),
    .o_SPI_MISO(spi_o_SPI_MISO),
    .i_SPI_MOSI(spi_i_SPI_MOSI),
    .i_SPI_CS_n(spi_i_SPI_CS_n)
  );
  assign io_RX_data_valid = spi_o_RX_DV;
  assign io_RX_data = spi_o_RX_Byte;
  assign io_spi_miso = spi_o_SPI_MISO;
  assign spi_i_Clk = clock;
  assign spi_i_Rst_L = reset == 1'h0;
  assign spi_i_TX_DV = 1'h0;
  assign spi_i_TX_Byte = 8'h0;
  assign spi_i_SPI_Clk = io_spi_clk;
  assign spi_i_SPI_MOSI = io_spi_mosi;
  assign spi_i_SPI_CS_n = io_spi_cs_n == 1'h0;
endmodule
module SPIInputHandler(
  input          clock,
  input          reset,
  output         io_packet_valid,
  output [7:0]   io_packet_magic,
  output [255:0] io_packet_data,
  input  [7:0]   io_RX_data,
  input          io_RX_data_valid
);
  reg [255:0] data;
  reg [255:0] _RAND_0;
  reg [7:0] data_len;
  reg [31:0] _RAND_1;
  wire [7:0] _T_47;
  wire [7:0] data_len_set;
  wire [8:0] _T_35;
  wire [8:0] _T_36;
  wire [7:0] _T_37;
  wire [263:0] _GEN_20;
  wire [270:0] _T_43;
  wire [270:0] _GEN_21;
  wire [270:0] _T_44;
  wire [270:0] _GEN_15;
  wire [255:0] data_set;
  wire [255:0] _T_38;
  wire [7:0] magic;
  wire  _T_49;
  wire  _T_53;
  wire  _T_55;
  wire  _T_60;
  wire  _T_62;
  wire  _GEN_6;
  wire  _GEN_9;
  wire  _GEN_14;
  assign _T_47 = data_len + 8'h8;
  assign data_len_set = io_RX_data_valid ? _T_47 : data_len;
  assign _T_35 = data_len_set - 8'h8;
  assign _T_36 = $unsigned(_T_35);
  assign _T_37 = _T_36[7:0];
  assign _GEN_20 = {data, 8'h0};
  assign _T_43 = {{7'd0}, _GEN_20};
  assign _GEN_21 = {{263'd0}, io_RX_data};
  assign _T_44 = _T_43 | _GEN_21;
  assign _GEN_15 = io_RX_data_valid ? _T_44 : {{15'd0}, data};
  assign data_set = _GEN_15[255:0];
  assign _T_38 = data_set >> _T_37;
  assign magic = _T_38[7:0];
  assign _T_49 = 8'h0 == magic;
  assign _T_53 = 8'h1 == magic;
  assign _T_55 = data_len_set == 8'hc8;
  assign _T_60 = 8'h2 == magic;
  assign _T_62 = data_len_set == 8'h48;
  assign _GEN_6 = _T_60 & _T_62;
  assign _GEN_9 = _T_53 ? _T_55 : _GEN_6;
  assign _GEN_14 = _T_49 ? 1'h0 : _GEN_9;
  assign io_packet_valid = io_RX_data_valid & _GEN_14;
  assign io_packet_magic = _T_38[7:0];
  assign io_packet_data = _GEN_15[255:0];
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
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {8{`RANDOM}};
  data = _RAND_0[255:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  data_len = _RAND_1[7:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    if (reset) begin
      data <= 256'h0;
    end else begin
      if (io_RX_data_valid) begin
        if (_T_49) begin
          data <= 256'h0;
        end else begin
          if (_T_53) begin
            if (_T_55) begin
              data <= 256'h0;
            end else begin
              data <= data_set;
            end
          end else begin
            if (_T_60) begin
              if (_T_62) begin
                data <= 256'h0;
              end else begin
                data <= data_set;
              end
            end else begin
              data <= data_set;
            end
          end
        end
      end else begin
        data <= data_set;
      end
    end
    if (reset) begin
      data_len <= 8'h0;
    end else begin
      if (io_RX_data_valid) begin
        if (_T_49) begin
          data_len <= 8'h0;
        end else begin
          if (_T_53) begin
            if (_T_55) begin
              data_len <= 8'h0;
            end else begin
              if (io_RX_data_valid) begin
                data_len <= _T_47;
              end
            end
          end else begin
            if (_T_60) begin
              if (_T_62) begin
                data_len <= 8'h0;
              end else begin
                if (io_RX_data_valid) begin
                  data_len <= _T_47;
                end
              end
            end else begin
              if (io_RX_data_valid) begin
                data_len <= _T_47;
              end
            end
          end
        end
      end else begin
        if (io_RX_data_valid) begin
          data_len <= _T_47;
        end
      end
    end
  end
endmodule
module PWM(
  input         clock,
  input         reset,
  output        io_high,
  input  [31:0] io_target
);
  reg [31:0] counter;
  reg [31:0] _RAND_0;
  wire [31:0] _T_13;
  wire  _T_14;
  assign _T_13 = counter + 32'h30303030;
  assign _T_14 = counter > io_target;
  assign io_high = _T_14 ? 1'h0 : 1'h1;
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
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  counter = _RAND_0[31:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    if (reset) begin
      counter <= 32'h0;
    end else begin
      counter <= _T_13;
    end
  end
endmodule
module Top(
  input   clock,
  input   reset,
  input   io_spi_mosi,
  output  io_spi_miso,
  input   io_spi_clk,
  input   io_spi_cs_n,
  output  io_pwm_out_l,
  output  io_pwm_out_r
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
  wire  SoundTopLevel_clock;
  wire  SoundTopLevel_reset;
  wire  SoundTopLevel_io_generator_update_packet_valid;
  wire [15:0] SoundTopLevel_io_generator_update_packet_generator_index;
  wire  SoundTopLevel_io_generator_update_packet_data_reset_note;
  wire  SoundTopLevel_io_generator_update_packet_data_enabled;
  wire [7:0] SoundTopLevel_io_generator_update_packet_data_instrument;
  wire [7:0] SoundTopLevel_io_generator_update_packet_data_note_index;
  wire [7:0] SoundTopLevel_io_generator_update_packet_data_channel_index;
  wire [7:0] SoundTopLevel_io_generator_update_packet_data_velocity;
  wire  SoundTopLevel_io_global_update_packet_valid;
  wire [7:0] SoundTopLevel_io_global_update_packet_data_volume;
  wire [15:0] SoundTopLevel_io_global_update_packet_data_envelope_attack;
  wire [15:0] SoundTopLevel_io_global_update_packet_data_envelope_decay;
  wire [7:0] SoundTopLevel_io_global_update_packet_data_envelope_sustain;
  wire [15:0] SoundTopLevel_io_global_update_packet_data_envelope_release;
  wire [7:0] SoundTopLevel_io_global_update_packet_data_pitchwheels_0;
  wire [7:0] SoundTopLevel_io_global_update_packet_data_pitchwheels_1;
  wire [7:0] SoundTopLevel_io_global_update_packet_data_pitchwheels_2;
  wire [7:0] SoundTopLevel_io_global_update_packet_data_pitchwheels_3;
  wire [7:0] SoundTopLevel_io_global_update_packet_data_pitchwheels_4;
  wire [7:0] SoundTopLevel_io_global_update_packet_data_pitchwheels_5;
  wire [7:0] SoundTopLevel_io_global_update_packet_data_pitchwheels_6;
  wire [7:0] SoundTopLevel_io_global_update_packet_data_pitchwheels_7;
  wire [7:0] SoundTopLevel_io_global_update_packet_data_pitchwheels_8;
  wire [7:0] SoundTopLevel_io_global_update_packet_data_pitchwheels_9;
  wire [7:0] SoundTopLevel_io_global_update_packet_data_pitchwheels_10;
  wire [7:0] SoundTopLevel_io_global_update_packet_data_pitchwheels_11;
  wire [7:0] SoundTopLevel_io_global_update_packet_data_pitchwheels_12;
  wire [7:0] SoundTopLevel_io_global_update_packet_data_pitchwheels_13;
  wire [7:0] SoundTopLevel_io_global_update_packet_data_pitchwheels_14;
  wire [7:0] SoundTopLevel_io_global_update_packet_data_pitchwheels_15;
  wire  SoundTopLevel_io_step_sample;
  wire [31:0] SoundTopLevel_io_sample_out;
  wire  SoundTopLevel_io_sample_out_valid;
  wire  SPISlave_clock;
  wire  SPISlave_reset;
  wire  SPISlave_io_RX_data_valid;
  wire [7:0] SPISlave_io_RX_data;
  wire  SPISlave_io_spi_mosi;
  wire  SPISlave_io_spi_miso;
  wire  SPISlave_io_spi_clk;
  wire  SPISlave_io_spi_cs_n;
  wire  SPIInputHandler_clock;
  wire  SPIInputHandler_reset;
  wire  SPIInputHandler_io_packet_valid;
  wire [7:0] SPIInputHandler_io_packet_magic;
  wire [255:0] SPIInputHandler_io_packet_data;
  wire [7:0] SPIInputHandler_io_RX_data;
  wire  SPIInputHandler_io_RX_data_valid;
  wire  PWM_clock;
  wire  PWM_reset;
  wire  PWM_io_high;
  wire [31:0] PWM_io_target;
  wire [199:0] _T_29;
  wire [7:0] _T_30;
  wire [7:0] _T_32;
  wire [7:0] _T_34;
  wire [7:0] _T_36;
  wire [7:0] _T_38;
  wire [7:0] _T_40;
  wire [7:0] _T_42;
  wire [7:0] _T_44;
  wire [7:0] _T_46;
  wire [7:0] _T_48;
  wire [7:0] _T_50;
  wire [7:0] _T_52;
  wire [7:0] _T_54;
  wire [7:0] _T_56;
  wire [7:0] _T_58;
  wire [7:0] _T_60;
  wire [15:0] _T_62;
  wire [15:0] _T_64;
  wire [15:0] _T_65;
  wire [7:0] _T_82;
  wire [15:0] _GEN_11;
  wire [22:0] _T_84;
  wire [7:0] _T_85;
  wire [22:0] _GEN_12;
  wire [22:0] _T_86;
  wire [7:0] _T_87;
  wire [15:0] _GEN_13;
  wire [22:0] _T_89;
  wire [7:0] _T_90;
  wire [22:0] _GEN_14;
  wire [22:0] _T_91;
  wire [7:0] _T_92;
  wire [15:0] _GEN_15;
  wire [22:0] _T_94;
  wire [7:0] _T_95;
  wire [22:0] _GEN_16;
  wire [22:0] _T_96;
  wire [71:0] _T_123;
  wire [15:0] _T_132;
  wire [7:0] _T_136;
  wire [15:0] _GEN_17;
  wire [22:0] _T_138;
  wire [7:0] _T_139;
  wire [22:0] _GEN_18;
  wire [22:0] _T_140;
  reg [31:0] _T_148;
  reg [31:0] _RAND_0;
  reg [10:0] value;
  reg [31:0] _RAND_1;
  wire  _T_153;
  wire [10:0] _T_156;
  wire [44:0] _GEN_19;
  wire [46:0] _T_163;
  wire [46:0] _T_166;
  wire [46:0] _T_167;
  wire [46:0] _T_168;
  wire  _T_172;
  wire  _T_174;
  wire  _T_177;
  wire  _GEN_6;
  wire  _GEN_7;
  wire  _GEN_8;
  MMCME2_BASE #(.CLKOUT5_PHASE(0.0), .CLKOUT5_DIVIDE(1), .CLKOUT3_DIVIDE(1), .CLKIN1_PERIOD(62.5), .CLKOUT2_DIVIDE(1), .CLKOUT0_PHASE(0.0), .CLKFBOUT_MULT_F(37.5), .CLKOUT4_DIVIDE(4), .CLKOUT6_DIVIDE(12), .CLKOUT6_DUTY_CYCLE(0.5), .CLKOUT1_PHASE(0.0), .CLKOUT4_PHASE(0.0), .CLKOUT5_DUTY_CYCLE(0.5), .CLKOUT6_PHASE(0.0), .CLKOUT1_DIVIDE(1), .CLKOUT3_DUTY_CYCLE(0.5), .CLKOUT4_CASCADE("TRUE"), .CLKOUT2_DUTY_CYCLE(0.5), .CLKOUT0_DIVIDE_F(1.0), .CLKOUT1_DUTY_CYCLE(0.5), .CLKOUT3_PHASE(0.0), .CLKOUT0_DUTY_CYCLE(0.5), .CLKOUT2_PHASE(0.0), .DIVCLK_DIVIDE(1), .CLKOUT4_DUTY_CYCLE(0.5)) mmcm (
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
  SoundTopLevel SoundTopLevel (
    .clock(SoundTopLevel_clock),
    .reset(SoundTopLevel_reset),
    .io_generator_update_packet_valid(SoundTopLevel_io_generator_update_packet_valid),
    .io_generator_update_packet_generator_index(SoundTopLevel_io_generator_update_packet_generator_index),
    .io_generator_update_packet_data_reset_note(SoundTopLevel_io_generator_update_packet_data_reset_note),
    .io_generator_update_packet_data_enabled(SoundTopLevel_io_generator_update_packet_data_enabled),
    .io_generator_update_packet_data_instrument(SoundTopLevel_io_generator_update_packet_data_instrument),
    .io_generator_update_packet_data_note_index(SoundTopLevel_io_generator_update_packet_data_note_index),
    .io_generator_update_packet_data_channel_index(SoundTopLevel_io_generator_update_packet_data_channel_index),
    .io_generator_update_packet_data_velocity(SoundTopLevel_io_generator_update_packet_data_velocity),
    .io_global_update_packet_valid(SoundTopLevel_io_global_update_packet_valid),
    .io_global_update_packet_data_volume(SoundTopLevel_io_global_update_packet_data_volume),
    .io_global_update_packet_data_envelope_attack(SoundTopLevel_io_global_update_packet_data_envelope_attack),
    .io_global_update_packet_data_envelope_decay(SoundTopLevel_io_global_update_packet_data_envelope_decay),
    .io_global_update_packet_data_envelope_sustain(SoundTopLevel_io_global_update_packet_data_envelope_sustain),
    .io_global_update_packet_data_envelope_release(SoundTopLevel_io_global_update_packet_data_envelope_release),
    .io_global_update_packet_data_pitchwheels_0(SoundTopLevel_io_global_update_packet_data_pitchwheels_0),
    .io_global_update_packet_data_pitchwheels_1(SoundTopLevel_io_global_update_packet_data_pitchwheels_1),
    .io_global_update_packet_data_pitchwheels_2(SoundTopLevel_io_global_update_packet_data_pitchwheels_2),
    .io_global_update_packet_data_pitchwheels_3(SoundTopLevel_io_global_update_packet_data_pitchwheels_3),
    .io_global_update_packet_data_pitchwheels_4(SoundTopLevel_io_global_update_packet_data_pitchwheels_4),
    .io_global_update_packet_data_pitchwheels_5(SoundTopLevel_io_global_update_packet_data_pitchwheels_5),
    .io_global_update_packet_data_pitchwheels_6(SoundTopLevel_io_global_update_packet_data_pitchwheels_6),
    .io_global_update_packet_data_pitchwheels_7(SoundTopLevel_io_global_update_packet_data_pitchwheels_7),
    .io_global_update_packet_data_pitchwheels_8(SoundTopLevel_io_global_update_packet_data_pitchwheels_8),
    .io_global_update_packet_data_pitchwheels_9(SoundTopLevel_io_global_update_packet_data_pitchwheels_9),
    .io_global_update_packet_data_pitchwheels_10(SoundTopLevel_io_global_update_packet_data_pitchwheels_10),
    .io_global_update_packet_data_pitchwheels_11(SoundTopLevel_io_global_update_packet_data_pitchwheels_11),
    .io_global_update_packet_data_pitchwheels_12(SoundTopLevel_io_global_update_packet_data_pitchwheels_12),
    .io_global_update_packet_data_pitchwheels_13(SoundTopLevel_io_global_update_packet_data_pitchwheels_13),
    .io_global_update_packet_data_pitchwheels_14(SoundTopLevel_io_global_update_packet_data_pitchwheels_14),
    .io_global_update_packet_data_pitchwheels_15(SoundTopLevel_io_global_update_packet_data_pitchwheels_15),
    .io_step_sample(SoundTopLevel_io_step_sample),
    .io_sample_out(SoundTopLevel_io_sample_out),
    .io_sample_out_valid(SoundTopLevel_io_sample_out_valid)
  );
  SPISlave SPISlave (
    .clock(SPISlave_clock),
    .reset(SPISlave_reset),
    .io_RX_data_valid(SPISlave_io_RX_data_valid),
    .io_RX_data(SPISlave_io_RX_data),
    .io_spi_mosi(SPISlave_io_spi_mosi),
    .io_spi_miso(SPISlave_io_spi_miso),
    .io_spi_clk(SPISlave_io_spi_clk),
    .io_spi_cs_n(SPISlave_io_spi_cs_n)
  );
  SPIInputHandler SPIInputHandler (
    .clock(SPIInputHandler_clock),
    .reset(SPIInputHandler_reset),
    .io_packet_valid(SPIInputHandler_io_packet_valid),
    .io_packet_magic(SPIInputHandler_io_packet_magic),
    .io_packet_data(SPIInputHandler_io_packet_data),
    .io_RX_data(SPIInputHandler_io_RX_data),
    .io_RX_data_valid(SPIInputHandler_io_RX_data_valid)
  );
  PWM PWM (
    .clock(PWM_clock),
    .reset(PWM_reset),
    .io_high(PWM_io_high),
    .io_target(PWM_io_target)
  );
  assign _T_29 = SPIInputHandler_io_packet_data[199:0];
  assign _T_30 = _T_29[7:0];
  assign _T_32 = _T_29[15:8];
  assign _T_34 = _T_29[23:16];
  assign _T_36 = _T_29[31:24];
  assign _T_38 = _T_29[39:32];
  assign _T_40 = _T_29[47:40];
  assign _T_42 = _T_29[55:48];
  assign _T_44 = _T_29[63:56];
  assign _T_46 = _T_29[71:64];
  assign _T_48 = _T_29[79:72];
  assign _T_50 = _T_29[87:80];
  assign _T_52 = _T_29[95:88];
  assign _T_54 = _T_29[103:96];
  assign _T_56 = _T_29[111:104];
  assign _T_58 = _T_29[119:112];
  assign _T_60 = _T_29[127:120];
  assign _T_62 = _T_29[143:128];
  assign _T_64 = _T_29[167:152];
  assign _T_65 = _T_29[183:168];
  assign _T_82 = _T_65[7:0];
  assign _GEN_11 = {_T_82, 8'h0};
  assign _T_84 = {{7'd0}, _GEN_11};
  assign _T_85 = _T_65[15:8];
  assign _GEN_12 = {{15'd0}, _T_85};
  assign _T_86 = _T_84 | _GEN_12;
  assign _T_87 = _T_64[7:0];
  assign _GEN_13 = {_T_87, 8'h0};
  assign _T_89 = {{7'd0}, _GEN_13};
  assign _T_90 = _T_64[15:8];
  assign _GEN_14 = {{15'd0}, _T_90};
  assign _T_91 = _T_89 | _GEN_14;
  assign _T_92 = _T_62[7:0];
  assign _GEN_15 = {_T_92, 8'h0};
  assign _T_94 = {{7'd0}, _GEN_15};
  assign _T_95 = _T_62[15:8];
  assign _GEN_16 = {{15'd0}, _T_95};
  assign _T_96 = _T_94 | _GEN_16;
  assign _T_123 = SPIInputHandler_io_packet_data[71:0];
  assign _T_132 = _T_123[63:48];
  assign _T_136 = _T_132[7:0];
  assign _GEN_17 = {_T_136, 8'h0};
  assign _T_138 = {{7'd0}, _GEN_17};
  assign _T_139 = _T_132[15:8];
  assign _GEN_18 = {{15'd0}, _T_139};
  assign _T_140 = _T_138 | _GEN_18;
  assign _T_153 = value == 11'h46c;
  assign _T_156 = value + 11'h1;
  assign _GEN_19 = {$signed(_T_148), 13'h0};
  assign _T_163 = {{2{_GEN_19[44]}},_GEN_19};
  assign _T_166 = $signed(_T_163) + $signed(-47'sh80000000);
  assign _T_167 = $signed(_T_166);
  assign _T_168 = $unsigned(_T_167);
  assign _T_172 = 8'h0 == SPIInputHandler_io_packet_magic;
  assign _T_174 = 8'h1 == SPIInputHandler_io_packet_magic;
  assign _T_177 = 8'h2 == SPIInputHandler_io_packet_magic;
  assign _GEN_6 = _T_174 ? 1'h0 : _T_177;
  assign _GEN_7 = _T_172 ? 1'h0 : _T_174;
  assign _GEN_8 = _T_172 ? 1'h0 : _GEN_6;
  assign io_spi_miso = SPISlave_io_spi_miso;
  assign io_pwm_out_l = PWM_io_high;
  assign io_pwm_out_r = PWM_io_high;
  assign mmcm_CLKIN1 = clock;
  assign mmcm_RST = 1'h0;
  assign mmcm_PWRDWN = 1'h0;
  assign mmcm_CLKFBIN = mmcm_CLKFBOUT;
  assign SoundTopLevel_clock = mmcm_CLKOUT6;
  assign SoundTopLevel_reset = reset;
  assign SoundTopLevel_io_generator_update_packet_valid = SPIInputHandler_io_packet_valid & _GEN_8;
  assign SoundTopLevel_io_generator_update_packet_generator_index = _T_140[15:0];
  assign SoundTopLevel_io_generator_update_packet_data_reset_note = _T_123[40];
  assign SoundTopLevel_io_generator_update_packet_data_enabled = _T_123[32];
  assign SoundTopLevel_io_generator_update_packet_data_instrument = _T_123[31:24];
  assign SoundTopLevel_io_generator_update_packet_data_note_index = _T_123[23:16];
  assign SoundTopLevel_io_generator_update_packet_data_channel_index = _T_123[15:8];
  assign SoundTopLevel_io_generator_update_packet_data_velocity = _T_123[7:0];
  assign SoundTopLevel_io_global_update_packet_valid = SPIInputHandler_io_packet_valid & _GEN_7;
  assign SoundTopLevel_io_global_update_packet_data_volume = _T_29[191:184];
  assign SoundTopLevel_io_global_update_packet_data_envelope_attack = _T_86[15:0];
  assign SoundTopLevel_io_global_update_packet_data_envelope_decay = _T_91[15:0];
  assign SoundTopLevel_io_global_update_packet_data_envelope_sustain = _T_29[151:144];
  assign SoundTopLevel_io_global_update_packet_data_envelope_release = _T_96[15:0];
  assign SoundTopLevel_io_global_update_packet_data_pitchwheels_0 = $signed(_T_60);
  assign SoundTopLevel_io_global_update_packet_data_pitchwheels_1 = $signed(_T_58);
  assign SoundTopLevel_io_global_update_packet_data_pitchwheels_2 = $signed(_T_56);
  assign SoundTopLevel_io_global_update_packet_data_pitchwheels_3 = $signed(_T_54);
  assign SoundTopLevel_io_global_update_packet_data_pitchwheels_4 = $signed(_T_52);
  assign SoundTopLevel_io_global_update_packet_data_pitchwheels_5 = $signed(_T_50);
  assign SoundTopLevel_io_global_update_packet_data_pitchwheels_6 = $signed(_T_48);
  assign SoundTopLevel_io_global_update_packet_data_pitchwheels_7 = $signed(_T_46);
  assign SoundTopLevel_io_global_update_packet_data_pitchwheels_8 = $signed(_T_44);
  assign SoundTopLevel_io_global_update_packet_data_pitchwheels_9 = $signed(_T_42);
  assign SoundTopLevel_io_global_update_packet_data_pitchwheels_10 = $signed(_T_40);
  assign SoundTopLevel_io_global_update_packet_data_pitchwheels_11 = $signed(_T_38);
  assign SoundTopLevel_io_global_update_packet_data_pitchwheels_12 = $signed(_T_36);
  assign SoundTopLevel_io_global_update_packet_data_pitchwheels_13 = $signed(_T_34);
  assign SoundTopLevel_io_global_update_packet_data_pitchwheels_14 = $signed(_T_32);
  assign SoundTopLevel_io_global_update_packet_data_pitchwheels_15 = $signed(_T_30);
  assign SoundTopLevel_io_step_sample = value == 11'h0;
  assign SPISlave_clock = mmcm_CLKOUT6;
  assign SPISlave_reset = reset;
  assign SPISlave_io_spi_mosi = io_spi_mosi;
  assign SPISlave_io_spi_clk = io_spi_clk;
  assign SPISlave_io_spi_cs_n = io_spi_cs_n;
  assign SPIInputHandler_clock = mmcm_CLKOUT6;
  assign SPIInputHandler_reset = reset;
  assign SPIInputHandler_io_RX_data = SPISlave_io_RX_data;
  assign SPIInputHandler_io_RX_data_valid = SPISlave_io_RX_data_valid;
  assign PWM_clock = mmcm_CLKOUT6;
  assign PWM_reset = reset;
  assign PWM_io_target = _T_168[31:0];
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
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  _T_148 = _RAND_0[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  value = _RAND_1[10:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge mmcm_CLKOUT6) begin
    if (reset) begin
      _T_148 <= 32'sh0;
    end else begin
      if (SoundTopLevel_io_sample_out_valid) begin
        _T_148 <= SoundTopLevel_io_sample_out;
      end
    end
    if (reset) begin
      value <= 11'h0;
    end else begin
      if (_T_153) begin
        value <= 11'h0;
      end else begin
        value <= _T_156;
      end
    end
  end
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
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (lin64) Build 2552052 Fri May 24 14:47:09 MDT 2019
// Date        : Mon Nov 18 09:34:52 2019
// Host        : sdhgsdfg-X556URK running 64-bit Ubuntu 18.04.3 LTS
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
