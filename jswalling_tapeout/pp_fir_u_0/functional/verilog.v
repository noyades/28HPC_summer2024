// Created by ihdl
module pp_fir_u_0 (VDD, VSS, VNW, VPW, 
	clk, 
	rst_n, 
	enb_1_8_0, 
	In1_re, 
	In1_im, 
	mag_re, 
	sign_re, 
	mag_im, 
	sign_im);
   inout VDD, VSS, VNW, VPW;
 input clk;
   input rst_n;
   input enb_1_8_0;
   input [15:0] In1_re;
   input [15:0] In1_im;
   output [255:0] mag_re;
   output sign_re;
   output [255:0] mag_im;
   output sign_im;

   // Internal wires
   wire FE_PSN132_rst_n;
   wire FE_PSN131_FE_OCPN899_FE_OFN364_rst_n;
   wire FE_OCPN130_FE_OFN1182_n;
   wire FE_OCPN129_FE_OFN1182_n;
   wire FE_OCPN128_FE_OFN1182_n;
   wire CTS_212;
   wire CTS_211;
   wire CTS_210;
   wire CTS_209;
   wire CTS_208;
   wire CTS_207;
   wire CTS_204;
   wire CTS_206;
   wire CTS_205;
   wire CTS_201;
   wire CTS_200;
   wire CTS_199;
   wire CTS_203;
   wire CTS_202;
   wire CTS_196;
   wire CTS_195;
   wire CTS_198;
   wire CTS_197;
   wire CTS_194;
   wire CTS_191;
   wire CTS_193;
   wire CTS_192;
   wire CTS_188;
   wire CTS_187;
   wire CTS_190;
   wire CTS_189;
   wire CTS_184;
   wire CTS_183;
   wire CTS_186;
   wire CTS_185;
   wire CTS_182;
   wire CTS_181;
   wire CTS_178;
   wire CTS_180;
   wire CTS_179;
   wire CTS_175;
   wire CTS_174;
   wire CTS_177;
   wire CTS_176;
   wire CTS_171;
   wire CTS_170;
   wire CTS_173;
   wire CTS_172;
   wire CTS_169;
   wire CTS_166;
   wire CTS_165;
   wire CTS_168;
   wire CTS_167;
   wire CTS_162;
   wire CTS_161;
   wire CTS_160;
   wire CTS_164;
   wire CTS_163;
   wire CTS_157;
   wire CTS_156;
   wire CTS_155;
   wire CTS_159;
   wire CTS_158;
   wire CTS_154;
   wire CTS_153;
   wire CTS_152;
   wire CTS_151;
   wire CTS_150;
   wire CTS_149;
   wire CTS_148;
   wire CTS_147;
   wire CTS_146;
   wire CTS_145;
   wire CTS_144;
   wire CTS_141;
   wire CTS_140;
   wire CTS_139;
   wire CTS_143;
   wire CTS_142;
   wire CTS_136;
   wire CTS_135;
   wire CTS_138;
   wire CTS_137;
   wire CTS_132;
   wire CTS_131;
   wire CTS_130;
   wire CTS_134;
   wire CTS_133;
   wire CTS_129;
   wire CTS_126;
   wire CTS_128;
   wire CTS_127;
   wire CTS_123;
   wire CTS_122;
   wire CTS_121;
   wire CTS_125;
   wire CTS_124;
   wire CTS_118;
   wire CTS_120;
   wire CTS_119;
   wire CTS_117;
   wire CTS_116;
   wire CTS_115;
   wire CTS_114;
   wire CTS_113;
   wire CTS_112;
   wire CTS_111;
   wire CTS_110;
   wire CTS_109;
   wire CTS_108;
   wire CTS_107;
   wire CTS_106;
   wire CTS_105;
   wire CTS_104;
   wire CTS_103;
   wire CTS_102;
   wire CTS_101;
   wire CTS_100;
   wire CTS_99;
   wire CTS_96;
   wire CTS_95;
   wire CTS_98;
   wire CTS_97;
   wire CTS_94;
   wire CTS_93;
   wire CTS_92;
   wire CTS_91;
   wire CTS_90;
   wire CTS_89;
   wire CTS_88;
   wire CTS_85;
   wire CTS_84;
   wire CTS_87;
   wire CTS_86;
   wire CTS_81;
   wire CTS_83;
   wire CTS_82;
   wire CTS_80;
   wire CTS_77;
   wire CTS_76;
   wire CTS_79;
   wire CTS_78;
   wire CTS_73;
   wire CTS_75;
   wire CTS_74;
   wire CTS_70;
   wire CTS_69;
   wire CTS_68;
   wire CTS_72;
   wire CTS_71;
   wire CTS_67;
   wire CTS_64;
   wire CTS_63;
   wire CTS_62;
   wire CTS_66;
   wire CTS_65;
   wire CTS_59;
   wire CTS_58;
   wire CTS_61;
   wire CTS_60;
   wire CTS_57;
   wire CTS_56;
   wire CTS_55;
   wire CTS_52;
   wire CTS_51;
   wire CTS_54;
   wire CTS_53;
   wire CTS_48;
   wire CTS_47;
   wire CTS_46;
   wire CTS_50;
   wire CTS_49;
   wire CTS_45;
   wire CTS_42;
   wire CTS_41;
   wire CTS_44;
   wire CTS_43;
   wire CTS_38;
   wire CTS_37;
   wire CTS_36;
   wire CTS_40;
   wire CTS_39;
   wire CTS_33;
   wire CTS_32;
   wire CTS_35;
   wire CTS_34;
   wire CTS_31;
   wire CTS_30;
   wire CTS_27;
   wire CTS_26;
   wire CTS_29;
   wire CTS_28;
   wire CTS_23;
   wire CTS_22;
   wire CTS_21;
   wire CTS_25;
   wire CTS_24;
   wire CTS_18;
   wire CTS_17;
   wire CTS_16;
   wire CTS_20;
   wire CTS_19;
   wire CTS_15;
   wire CTS_12;
   wire CTS_11;
   wire CTS_10;
   wire CTS_14;
   wire CTS_13;
   wire CTS_7;
   wire CTS_6;
   wire CTS_5;
   wire CTS_9;
   wire CTS_8;
   wire CTS_2;
   wire CTS_1;
   wire CTS_4;
   wire CTS_3;
   wire n_41;
   wire n_40;
   wire FE_OFN319_FE_OCPN1007_n;
   wire FE_OFN318_FE_OCPN174_n;
   wire FE_OCPN313_FE_OFN30_n_0;
   wire FE_OCPN312_FE_OFN30_n_0;
   wire FE_OCPN308_rst_n;
   wire FE_RN_1;
   wire FE_OCPN174_n;
   wire FE_OFN5_FE_OCPN1002;
   wire [8:0] signed_mag_0_abs_im_stage1;
   wire [8:0] signed_mag_0_abs_re_stage1;
   wire [15:0] pp_fir_out_re;
   wire [15:0] pp_fir_out_im;
   wire [8:0] Data_Type_Conversion_out_im;
   wire [8:0] Data_Type_Conversion_out_re;
   wire [255:0] signed_mag_0_re_mag;
   wire [255:0] signed_mag_0_im_mag;
   wire FE_OCPN874_FE_OFN50_n_0;
   wire FE_OCPN876_FE_OFN30_n_0;
   wire FE_OCPN884_FE_OFN30_n_0;
   wire FE_OCPN886_FE_OFN30_n_0;
   wire FE_OCPN887_FE_OFN30_n_0;
   wire FE_OCPN888_FE_OFN30_n_0;
   wire FE_OCPN889_FE_OFN49_n_0;
   wire FE_OCPN899_FE_OFN364_rst_n;
   wire FE_OCPN907_n;
   wire FE_OCPN908_FE_OFN364_rst_n;
   wire FE_OCPN984_FE_OFN30_n_0;
   wire FE_OCPN985_FE_OFN30_n_0;
   wire FE_OCPN986_n;
   wire FE_OCPN990_FE_OFN364_rst_n;
   wire FE_OCPN1002_FE_OFN49_n_0;
   wire FE_OCPN1006_n;
   wire FE_OCPN1007_n;
   wire FE_OCPN1072_n;
   wire FE_OCPN1079_FE_OFN30_n_0;
   wire FE_OCPN1080_FE_OFN374_rst_n;
   wire FE_OCPN1081_FE_OFN374_rst_n;
   wire FE_OCPN1083_FE_OFN374_rst_n;
   wire FE_OCPN1091_FE_OFN384_rst_n;
   wire FE_OCPN1092_FE_OFN49_n_0;
   wire FE_OCPN1103_n;
   wire FE_OCPN1139_n;
   wire FE_OCPN1150_FE_OFN49_n_0;
   wire FE_OCPN1198_FE_OFN376_rst_n;
   wire FE_OCPN1207_n;
   wire FE_OCPN1210_n;
   wire FE_OCPN1217_n;
   wire FE_OFN30_n_0;
   wire FE_OFN31_n_0;
   wire FE_OFN32_n_0;
   wire FE_OFN33_n_0;
   wire FE_OFN38_n_0;
   wire FE_OFN49_n_0;
   wire FE_OFN50_n_0;
   wire FE_OFN53_n_0;
   wire FE_OFN55_n_0;
   wire FE_OFN56_n_0;
   wire FE_OFN57_n_0;
   wire FE_OFN64_n_0;
   wire FE_OFN65_n_0;
   wire FE_OFN66_n_0;
   wire FE_OFN73_n_0;
   wire FE_OFN75_n_0;
   wire FE_OFN76_n_0;
   wire FE_OFN77_n_0;
   wire FE_OFN78_n_0;
   wire FE_OFN79_n_0;
   wire FE_OFN80_n_0;
   wire FE_OFN81_n_0;
   wire FE_OFN125_signed_mag_0_abs_re_stage1_3;
   wire FE_OFN126_signed_mag_0_abs_im_stage1_3;
   wire FE_OFN127_signed_mag_0_abs_im_stage1_3;
   wire FE_OFN129_n_59;
   wire FE_OFN130_signed_mag_0_abs_im_stage1_4;
   wire FE_OFN133_signed_mag_0_abs_im_stage1_5;
   wire FE_OFN134_signed_mag_0_abs_re_stage1_5;
   wire FE_OFN136_signed_mag_0_abs_re_stage1_4;
   wire FE_OFN140_n_95;
   wire FE_OFN147_n_128;
   wire FE_OFN301_signed_mag_0_abs_re_stage1_3;
   wire FE_OFN302_n_51;
   wire FE_OFN304_n_53;
   wire FE_OFN306_n_77;
   wire FE_OFN307_n_79;
   wire FE_OFN308_signed_mag_0_abs_im_stage1_7;
   wire FE_OFN362_rst_n;
   wire FE_OFN372_rst_n;
   wire FE_OFN374_rst_n;
   wire FE_OFN375_rst_n;
   wire FE_OFN376_rst_n;
   wire FE_OFN377_rst_n;
   wire FE_OFN380_rst_n;
   wire FE_OFN396_n_156;
   wire FE_OFN483_n;
   wire FE_OFN487_n;
   wire FE_OFN490_n;
   wire FE_OFN491_n;
   wire FE_OFN492_n;
   wire FE_OFN494_n;
   wire FE_OFN495_n;
   wire FE_OFN720_n;
   wire FE_OFN779_n;
   wire FE_OFN1180_FE_OCPN986_n;
   wire FE_OFN1182_n;
   wire FE_RN_2;
   wire FE_RN_3;
   wire FE_RN_4;
   wire FE_RN_5;
   wire UNCONNECTED7;
   wire UNCONNECTED8;
   wire UNCONNECTED9;
   wire UNCONNECTED10;
   wire n_1;
   wire n_2;
   wire n_3;
   wire n_4;
   wire n_5;
   wire n_6;
   wire n_7;
   wire n_8;
   wire n_9;
   wire n_10;
   wire n_11;
   wire n_12;
   wire n_13;
   wire n_14;
   wire n_15;
   wire n_16;
   wire n_17;
   wire n_18;
   wire n_19;
   wire n_20;
   wire n_21;
   wire n_22;
   wire n_23;
   wire n_24;
   wire n_25;
   wire n_26;
   wire n_27;
   wire n_28;
   wire n_29;
   wire n_30;
   wire n_31;
   wire n_32;
   wire n_33;
   wire n_34;
   wire n_35;
   wire n_36;
   wire n_37;
   wire n_38;
   wire n_39;
   wire n_42;
   wire n_43;
   wire n_44;
   wire n_45;
   wire n_46;
   wire n_47;
   wire n_48;
   wire n_49;
   wire n_50;
   wire n_51;
   wire n_52;
   wire n_53;
   wire n_54;
   wire n_55;
   wire n_56;
   wire n_57;
   wire n_58;
   wire n_59;
   wire n_60;
   wire n_61;
   wire n_62;
   wire n_63;
   wire n_64;
   wire n_65;
   wire n_66;
   wire n_67;
   wire n_68;
   wire n_69;
   wire n_70;
   wire n_71;
   wire n_72;
   wire n_73;
   wire n_74;
   wire n_75;
   wire n_76;
   wire n_77;
   wire n_78;
   wire n_79;
   wire n_80;
   wire n_81;
   wire n_82;
   wire n_83;
   wire n_84;
   wire n_85;
   wire n_86;
   wire n_87;
   wire n_88;
   wire n_89;
   wire n_90;
   wire n_91;
   wire n_92;
   wire n_93;
   wire n_95;
   wire n_96;
   wire n_97;
   wire n_98;
   wire n_99;
   wire n_100;
   wire n_101;
   wire n_102;
   wire n_103;
   wire n_104;
   wire n_105;
   wire n_106;
   wire n_107;
   wire n_108;
   wire n_109;
   wire n_110;
   wire n_111;
   wire n_112;
   wire n_113;
   wire n_114;
   wire n_115;
   wire n_116;
   wire n_117;
   wire n_118;
   wire n_119;
   wire n_120;
   wire n_121;
   wire n_122;
   wire n_123;
   wire n_124;
   wire n_125;
   wire n_126;
   wire n_128;
   wire n_129;
   wire n_130;
   wire n_131;
   wire n_132;
   wire n_133;
   wire n_134;
   wire n_135;
   wire n_136;
   wire n_137;
   wire n_138;
   wire n_139;
   wire n_140;
   wire n_141;
   wire n_142;
   wire n_143;
   wire n_144;
   wire n_145;
   wire n_146;
   wire n_147;
   wire n_148;
   wire n_149;
   wire n_150;
   wire n_151;
   wire n_152;
   wire n_153;
   wire n_154;
   wire n_156;
   wire n_157;
   wire n_158;
   wire n_159;
   wire n_160;
   wire n_161;
   wire n_162;
   wire n_163;
   wire n_164;
   wire n_165;
   wire n_166;
   wire n_167;
   wire n_168;
   wire n_169;
   wire n_170;
   wire n_171;
   wire n_172;
   wire n_173;
   wire n_174;
   wire n_175;
   wire n_176;
   wire n_177;
   wire n_178;
   wire n_179;
   wire n_180;
   wire n_181;
   wire n_182;
   wire n_183;
   wire n_184;
   wire n_185;
   wire n_186;
   wire n_187;
   wire n_188;
   wire n_189;
   wire n_190;
   wire n_191;
   wire n_192;
   wire n_193;
   wire n_194;
   wire n_195;
   wire n_196;
   wire n_197;
   wire n_198;
   wire n_199;
   wire n_200;
   wire n_201;
   wire n_202;
   wire n_203;
   wire n_204;
   wire n_205;
   wire n_206;
   wire n_207;
   wire n_208;
   wire n_209;
   wire n_210;
   wire n_211;
   wire n_212;
   wire n_213;
   wire n_214;
   wire n_215;
   wire n_216;
   wire n_217;
   wire n_218;
   wire n_219;
   wire n_220;
   wire n_221;
   wire n_222;
   wire n_223;
   wire n_224;
   wire n_225;
   wire n_226;
   wire n_227;
   wire n_228;
   wire n_229;
   wire n_230;
   wire n_231;
   wire n_232;
   wire n_233;
   wire n_234;
   wire n_235;
   wire n_236;
   wire n_237;
   wire n_238;
   wire n_239;
   wire n_240;
   wire n_241;
   wire n_242;
   wire n_243;
   wire n_244;
   wire n_245;
   wire n_246;
   wire n_247;
   wire n_248;
   wire n_249;
   wire n_250;
   wire n_251;
   wire n_252;
   wire n_253;
   wire n_254;
   wire n_255;
   wire n_256;
   wire n_257;
   wire n_258;
   wire n_259;
   wire n_260;
   wire n_261;
   wire n_262;
   wire n_263;
   wire n_264;
   wire n_265;
   wire n_266;
   wire n_267;
   wire n_268;
   wire n_269;
   wire n_270;
   wire n_271;
   wire n_272;
   wire n_273;
   wire n_274;
   wire n_275;
   wire n_276;
   wire n_277;
   wire n_278;
   wire n_279;
   wire n_280;
   wire n_281;
   wire n_282;
   wire n_283;
   wire n_284;
   wire n_285;
   wire n_286;
   wire n_287;
   wire n_288;
   wire n_289;
   wire n_290;
   wire n_291;
   wire n_292;
   wire n_293;
   wire n_294;
   wire n_295;
   wire n_296;
   wire n_297;
   wire n_298;
   wire n_299;
   wire n_300;
   wire n_301;
   wire n_302;
   wire n_303;
   wire n_304;
   wire n_305;
   wire n_306;
   wire n_307;
   wire n_308;
   wire n_309;
   wire n_310;
   wire n_311;
   wire n_312;
   wire n_313;
   wire n_314;
   wire n_315;
   wire n_316;
   wire n_317;
   wire n_318;
   wire n_319;
   wire n_320;
   wire n_321;
   wire n_322;
   wire n_323;
   wire n_324;
   wire n_325;
   wire n_326;
   wire n_327;
   wire n_328;
   wire n_329;
   wire n_330;
   wire n_331;
   wire n_332;
   wire n_333;
   wire n_334;
   wire n_335;
   wire n_336;
   wire n_337;
   wire n_338;
   wire n_339;
   wire n_340;
   wire n_341;
   wire n_342;
   wire n_343;
   wire n_344;
   wire n_345;
   wire n_346;
   wire n_347;
   wire n_348;
   wire n_349;
   wire n_350;
   wire n_351;
   wire n_352;
   wire n_353;
   wire n_354;
   wire n_355;
   wire n_356;
   wire n_357;
   wire n_358;
   wire n_359;
   wire n_360;
   wire n_361;
   wire n_362;
   wire n_363;
   wire n_364;
   wire n_365;
   wire n_366;
   wire n_367;
   wire n_368;
   wire n_369;
   wire n_370;
   wire n_371;
   wire n_372;
   wire n_373;
   wire n_374;
   wire n_375;
   wire n_376;
   wire n_377;
   wire n_378;
   wire n_379;
   wire n_380;
   wire n_381;
   wire n_382;
   wire n_383;
   wire n_384;
   wire n_385;
   wire n_386;
   wire n_387;
   wire n_388;
   wire n_389;
   wire n_390;
   wire n_391;
   wire n_392;
   wire n_393;
   wire n_394;
   wire n_395;
   wire n_396;
   wire n_397;
   wire n_398;
   wire n_399;
   wire n_400;
   wire n_401;
   wire n_402;
   wire n_403;
   wire n_404;
   wire n_405;
   wire n_406;
   wire n_407;
   wire n_408;
   wire n_409;
   wire n_410;
   wire n_411;
   wire n_412;
   wire n_413;
   wire n_414;
   wire n_415;
   wire n_416;
   wire n_417;
   wire n_418;
   wire n_419;
   wire n_420;
   wire n_421;
   wire n_422;
   wire n_423;
   wire n_424;
   wire n_425;
   wire n_426;
   wire n_427;
   wire n_428;
   wire n_429;
   wire n_430;
   wire n_431;
   wire n_432;
   wire n_433;
   wire n_434;
   wire n_435;
   wire n_436;
   wire n_437;
   wire n_438;
   wire n_439;
   wire n_440;
   wire n_441;
   wire n_442;
   wire n_443;
   wire n_444;
   wire n_445;
   wire n_446;
   wire n_447;
   wire n_448;
   wire n_449;
   wire n_450;
   wire n_451;
   wire n_452;
   wire n_453;
   wire n_454;
   wire n_455;
   wire n_456;
   wire n_457;
   wire n_458;
   wire n_459;
   wire n_460;
   wire n_461;
   wire n_462;
   wire n_463;
   wire n_464;
   wire n_465;
   wire n_466;
   wire n_467;
   wire n_468;
   wire n_469;
   wire n_470;
   wire n_471;
   wire n_472;
   wire n_473;
   wire n_474;
   wire n_475;
   wire n_476;
   wire n_477;
   wire n_478;
   wire n_479;
   wire n_480;
   wire n_481;
   wire n_482;
   wire n_483;
   wire n_484;
   wire n_485;
   wire n_486;
   wire n_487;
   wire n_488;
   wire n_489;
   wire n_490;
   wire n_491;
   wire n_492;
   wire n_493;
   wire n_494;
   wire n_495;
   wire n_496;
   wire n_497;
   wire n_498;
   wire n_499;
   wire n_500;
   wire n_501;
   wire n_502;
   wire n_503;
   wire n_504;
   wire n_505;
   wire n_506;
   wire n_507;
   wire n_508;
   wire n_509;
   wire n_510;
   wire n_511;
   wire n_512;
   wire n_513;
   wire n_514;
   wire n_515;
   wire n_516;
   wire n_517;
   wire n_518;
   wire n_519;
   wire n_520;
   wire n_521;
   wire n_522;
   wire n_523;
   wire n_524;
   wire n_525;
   wire n_526;
   wire n_527;
   wire n_528;
   wire n_529;
   wire n_530;
   wire n_531;
   wire n_532;
   wire n_533;
   wire n_534;
   wire n_535;
   wire n_536;
   wire n_537;
   wire n_538;
   wire n_539;
   wire n_540;
   wire n_541;
   wire n_542;
   wire n_543;
   wire n_544;
   wire n_545;
   wire n_546;
   wire n_547;
   wire n_548;
   wire n_549;
   wire n_550;
   wire n_551;
   wire n_552;
   wire n_553;
   wire n_554;
   wire n_555;
   wire n_556;
   wire n_557;
   wire n_558;
   wire n_559;
   wire n_560;
   wire n_561;
   wire n_562;
   wire n_563;
   wire n_564;
   wire n_565;
   wire n_566;
   wire n_567;
   wire n_568;
   wire n_569;
   wire n_570;
   wire n_571;
   wire n_572;
   wire n_573;
   wire n_574;
   wire n_575;
   wire n_576;
   wire n_577;
   wire n_578;
   wire n_579;
   wire n_580;
   wire n_581;
   wire n_582;
   wire n_583;
   wire n_584;
   wire n_585;
   wire n_586;
   wire n_587;
   wire n_588;
   wire n_589;
   wire n_590;
   wire n_591;
   wire n_592;
   wire n_593;
   wire n_594;
   wire n_595;
   wire n_596;
   wire n_597;
   wire n_598;
   wire n_599;
   wire n_600;
   wire n_601;
   wire n_602;
   wire n_603;
   wire n_604;
   wire n_605;
   wire n_606;
   wire n_607;
   wire n_608;
   wire n_609;
   wire n_610;
   wire n_611;
   wire n_612;
   wire n_613;
   wire n_614;
   wire n_615;
   wire n_616;
   wire n_617;
   wire n_618;
   wire n_619;
   wire n_620;
   wire n_621;
   wire n_622;
   wire n_623;
   wire n_624;
   wire n_625;
   wire n_626;
   wire n_627;
   wire n_628;
   wire n_629;
   wire n_630;
   wire n_631;
   wire n_632;
   wire n_633;
   wire n_634;
   wire n_635;
   wire n_636;
   wire n_637;
   wire n_638;
   wire n_639;
   wire n_640;
   wire n_641;
   wire n_642;
   wire n_643;
   wire n_644;
   wire n_645;
   wire n_646;
   wire n_647;
   wire signed_mag_0_sign_im_stage1;
   wire signed_mag_0_sign_re_stage1;

   BUF_X13M_A9PP140ZTL_C30 FE_PSC867_rst_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(rst_n),
	.Y(FE_PSN132_rst_n));
   BUFH_X6M_A9PP140ZTL_C30 FE_PSC866_FE_OCPN899_FE_OFN364_rst_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN899_FE_OFN364_rst_n),
	.Y(FE_PSN131_FE_OCPN899_FE_OFN364_rst_n));
   BUF_X11M_A9PP140ZTL_C30 FE_OCPC865_FE_OFN1182_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN1182_n),
	.Y(FE_OCPN130_FE_OFN1182_n));
   BUF_X6M_A9PP140ZTL_C30 FE_OCPC864_FE_OFN1182_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN1182_n),
	.Y(FE_OCPN129_FE_OFN1182_n));
   BUF_X1M_A9PP140ZTL_C30 FE_OCPC863_FE_OFN1182_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN1182_n),
	.Y(FE_OCPN128_FE_OFN1182_n));
   INV_X1M_A9PP140ZTL_C30 FE_OFC645_n_51 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_51),
	.Y(n_50));
   BUFH_X1M_A9PP140ZTL_C30 FE_OFC644_n_51 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_51),
	.Y(FE_OFN302_n_51));
   INV_X0P8M_A9PP140ZTL_C30 FE_OFC643_n_57 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_57),
	.Y(n_56));
   INV_X1M_A9PP140ZTL_C30 FE_OFC642_n_95 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_95),
	.Y(FE_OFN140_n_95));
   INV_X3M_A9PP140ZTL_C30 FE_OFC585_FE_OCPN1002_FE_OFN49_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN1002_FE_OFN49_n_0),
	.Y(FE_OFN5_FE_OCPN1002));
   INV_X2M_A9PP140ZTL_C30 FE_OFC584_FE_OCPN1002_FE_OFN49_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN1002_FE_OFN49_n_0),
	.Y(FE_OFN77_n_0));
   INV_X5M_A9PP140ZTL_C30 FE_OFC572_FE_OCPN1092_FE_OFN49_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN1092_FE_OFN49_n_0),
	.Y(FE_RN_2));
   INV_X6M_A9PP140ZTL_C30 FE_OFC551_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN55_n_0),
	.Y(FE_OFN53_n_0));
   INV_X6M_A9PP140ZTL_C30 FE_OFC550_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN884_FE_OFN30_n_0),
	.Y(FE_OFN32_n_0));
   INV_X3P5M_A9PP140ZTL_C30 FE_OFC549_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN884_FE_OFN30_n_0),
	.Y(FE_OFN33_n_0));
   INV_X1P7M_A9PP140ZTL_C30 FE_OFC548_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN884_FE_OFN30_n_0),
	.Y(FE_OFN38_n_0));
   INV_X11M_A9PP140ZTL_C30 FE_OFC547_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN884_FE_OFN30_n_0),
	.Y(FE_OFN57_n_0));
   INV_X3M_A9PP140ZTL_C30 FE_OFC546_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN884_FE_OFN30_n_0),
	.Y(FE_OCPN313_FE_OFN30_n_0));
   BUFH_X4M_A9PP140ZTL_C30 FE_OFC544_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN30_n_0),
	.Y(FE_OFN380_rst_n));
   INV_X6M_A9PP140ZTL_C30 FE_OFC543_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN30_n_0),
	.Y(FE_OFN55_n_0));
   BUFH_X4M_A9PP140ZTL_C30 FE_OFC542_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN30_n_0),
	.Y(FE_OCPN312_FE_OFN30_n_0));
   INV_X6M_A9PP140ZTL_C30 FE_OFC539_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN30_n_0),
	.Y(FE_OCPN884_FE_OFN30_n_0));
   BUF_X6M_A9PP140ZTL_C30 FE_OFC537_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN30_n_0),
	.Y(FE_OCPN888_FE_OFN30_n_0));
   INV_X16M_A9PP140ZTL_C30 FE_OFC508_FE_OCPN874_FE_OFN50_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN874_FE_OFN50_n_0),
	.Y(FE_OFN487_n));
   INV_X5M_A9PP140ZTL_C30 FE_OFC478_FE_OCPN876_FE_OFN30_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN876_FE_OFN30_n_0),
	.Y(FE_OFN50_n_0));
   INV_X4M_A9PP140ZTL_C30 FE_OFC477_FE_OCPN1006_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN1006_n),
	.Y(FE_OCPN1217_n));
   INV_X3P5M_A9PP140ZTL_C30 FE_OFC468_FE_OCPN1198_FE_OFN376_rst_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN1198_FE_OFN376_rst_n),
	.Y(FE_OCPN1080_FE_OFN374_rst_n));
   INV_X6M_A9PP140ZTL_C30 FE_OFC464_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN65_n_0),
	.Y(FE_OFN495_n));
   INV_X2M_A9PP140ZTL_C30 FE_OFC463_FE_OCPN1007_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN1007_n),
	.Y(FE_OCPN1103_n));
   INV_X5M_A9PP140ZTL_C30 FE_OFC462_FE_OCPN1007_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN1007_n),
	.Y(FE_OFN319_FE_OCPN1007_n));
   INV_X3M_A9PP140ZTL_C30 FE_OFC460_FE_OCPN174_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN174_n),
	.Y(FE_OFN318_FE_OCPN174_n));
   INV_X7P5M_A9PP140ZTL_C30 FE_OFC458_FE_OCPN1072_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN1072_n),
	.Y(FE_OFN73_n_0));
   INV_X4M_A9PP140ZTL_C30 FE_OFC457_FE_OCPN1072_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN1072_n),
	.Y(FE_RN_5));
   INV_X13M_A9PP140ZTL_C30 FE_OFC447_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN720_n),
	.Y(FE_OFN1182_n));
   INV_X1P7M_A9PP140ZTL_C30 FE_OFC446_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN720_n),
	.Y(FE_OFN779_n));
   INV_X6M_A9PP140ZTL_C30 FE_OFC442_FE_OCPN986_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN986_n),
	.Y(FE_OCPN1210_n));
   INV_X0P8M_A9PP140ZTL_C30 FE_OFC441_FE_OCPN986_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN986_n),
	.Y(FE_OFN1180_FE_OCPN986_n));
   INV_X13M_A9PP140ZTL_C30 FE_OFC440_FE_OCPN986_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN986_n),
	.Y(FE_OCPN1207_n));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00085 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_204),
	.Y(CTS_206));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00083 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_204),
	.Y(CTS_205));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00501 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_207),
	.Y(CTS_204));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00025 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_201),
	.Y(CTS_200));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00023 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_201),
	.Y(CTS_199));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00022 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_201),
	.Y(CTS_203));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00021 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_201),
	.Y(CTS_202));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00381 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_207),
	.Y(CTS_201));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00020 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_196),
	.Y(CTS_195));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00019 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_196),
	.Y(CTS_198));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00016 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_196),
	.Y(CTS_197));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00380 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_207),
	.Y(CTS_196));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00550 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_208),
	.Y(CTS_207));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00114 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_191),
	.Y(CTS_193));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00089 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_191),
	.Y(CTS_192));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00499 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_194),
	.Y(CTS_191));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00090 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_188),
	.Y(CTS_187));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00088 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_188),
	.Y(CTS_190));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00026 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_188),
	.Y(CTS_189));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00396 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_194),
	.Y(CTS_188));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00087 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_184),
	.Y(CTS_183));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00086 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_184),
	.Y(CTS_186));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00084 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_184),
	.Y(CTS_185));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00395 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_194),
	.Y(CTS_184));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00549 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_208),
	.Y(CTS_194));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00573 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_209),
	.Y(CTS_208));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00113 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_178),
	.Y(CTS_180));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00079 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_178),
	.Y(CTS_179));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00406 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_181),
	.Y(CTS_178));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00012 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_175),
	.Y(CTS_174));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00008 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_175),
	.Y(CTS_177));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00007 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_175),
	.Y(CTS_176));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00379 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_181),
	.Y(CTS_175));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00006 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_171),
	.Y(CTS_170));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00005 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_171),
	.Y(CTS_173));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00004 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_171),
	.Y(CTS_172));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00378 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_181),
	.Y(CTS_171));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00512 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_182),
	.Y(CTS_181));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00082 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_166),
	.Y(CTS_165));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00017 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_166),
	.Y(CTS_168));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00014 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_166),
	.Y(CTS_167));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00394 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_169),
	.Y(CTS_166));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00081 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_162),
	.Y(CTS_161));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00018 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_162),
	.Y(CTS_160));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00015 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_162),
	.Y(CTS_164));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00010 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_162),
	.Y(CTS_163));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00393 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_169),
	.Y(CTS_162));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00080 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_157),
	.Y(CTS_156));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00013 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_157),
	.Y(CTS_155));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00011 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_157),
	.Y(CTS_159));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00009 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_157),
	.Y(CTS_158));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00392 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_169),
	.Y(CTS_157));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00508 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_182),
	.Y(CTS_169));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00555 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_209),
	.Y(CTS_182));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00587 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_210),
	.Y(CTS_209));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_inv_00594 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_211),
	.Y(CTS_210));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00120 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_150),
	.Y(CTS_149));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00487 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_151),
	.Y(CTS_150));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00093 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_148),
	.Y(CTS_147));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00486 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_151),
	.Y(CTS_148));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00003 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_146),
	.Y(CTS_145));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00456 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_151),
	.Y(CTS_146));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00539 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_152),
	.Y(CTS_151));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00116 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_141),
	.Y(CTS_140));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00096 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_141),
	.Y(CTS_139));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00095 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_141),
	.Y(CTS_143));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00031 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_141),
	.Y(CTS_142));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00408 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_144),
	.Y(CTS_141));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00098 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_136),
	.Y(CTS_135));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00097 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_136),
	.Y(CTS_138));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00036 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_136),
	.Y(CTS_137));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00399 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_144),
	.Y(CTS_136));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00034 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_132),
	.Y(CTS_131));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00033 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_132),
	.Y(CTS_130));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00032 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_132),
	.Y(CTS_134));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00030 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_132),
	.Y(CTS_133));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00382 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_144),
	.Y(CTS_132));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00514 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_152),
	.Y(CTS_144));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00115 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_126),
	.Y(CTS_128));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00024 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_126),
	.Y(CTS_127));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00407 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_129),
	.Y(CTS_126));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00094 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_123),
	.Y(CTS_122));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00092 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_123),
	.Y(CTS_121));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00029 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_123),
	.Y(CTS_125));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00028 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_123),
	.Y(CTS_124));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00398 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_129),
	.Y(CTS_123));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00091 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_118),
	.Y(CTS_120));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00027 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_118),
	.Y(CTS_119));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00397 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_129),
	.Y(CTS_118));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00513 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_152),
	.Y(CTS_129));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00565 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_153),
	.Y(CTS_152));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00581 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_154),
	.Y(CTS_153));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00124 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_114),
	.Y(CTS_113));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00413 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_115),
	.Y(CTS_114));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00526 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_116),
	.Y(CTS_115));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00559 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_117),
	.Y(CTS_116));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00578 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_154),
	.Y(CTS_117));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_inv_00590 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_211),
	.Y(CTS_154));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00598 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_212),
	.Y(CTS_211));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_inv_00601 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(clk),
	.Y(CTS_212));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00125 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_106),
	.Y(CTS_105));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00493 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_107),
	.Y(CTS_106));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00544 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_108),
	.Y(CTS_107));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00569 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_109),
	.Y(CTS_108));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00583 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_110),
	.Y(CTS_109));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00002 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_101),
	.Y(CTS_100));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00478 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_102),
	.Y(CTS_101));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00536 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_103),
	.Y(CTS_102));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00123 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_96),
	.Y(CTS_95));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00122 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_96),
	.Y(CTS_98));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00121 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_96),
	.Y(CTS_97));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00412 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_99),
	.Y(CTS_96));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00525 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_103),
	.Y(CTS_99));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00563 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_104),
	.Y(CTS_103));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00580 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_110),
	.Y(CTS_104));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_inv_00592 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_111),
	.Y(CTS_110));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00597 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_112),
	.Y(CTS_111));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00103 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_89),
	.Y(CTS_88));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00490 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_90),
	.Y(CTS_89));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00102 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_85),
	.Y(CTS_84));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00101 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_85),
	.Y(CTS_87));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00043 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_85),
	.Y(CTS_86));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00401 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_90),
	.Y(CTS_85));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00044 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_81),
	.Y(CTS_83));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00042 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_81),
	.Y(CTS_82));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00384 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_90),
	.Y(CTS_81));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00542 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_91),
	.Y(CTS_90));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00117 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_77),
	.Y(CTS_76));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00106 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_77),
	.Y(CTS_79));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00105 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_77),
	.Y(CTS_78));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00409 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_80),
	.Y(CTS_77));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00104 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_73),
	.Y(CTS_75));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00045 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_73),
	.Y(CTS_74));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00402 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_80),
	.Y(CTS_73));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00049 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_70),
	.Y(CTS_69));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00047 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_70),
	.Y(CTS_68));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00046 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_70),
	.Y(CTS_72));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00039 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_70),
	.Y(CTS_71));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00385 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_80),
	.Y(CTS_70));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00515 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_91),
	.Y(CTS_80));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00100 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_64),
	.Y(CTS_63));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00099 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_64),
	.Y(CTS_62));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00041 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_64),
	.Y(CTS_66));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00037 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_64),
	.Y(CTS_65));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00400 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_67),
	.Y(CTS_64));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00040 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_59),
	.Y(CTS_58));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00038 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_59),
	.Y(CTS_61));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00035 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_59),
	.Y(CTS_60));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00383 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_67),
	.Y(CTS_59));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00509 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_91),
	.Y(CTS_67));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00567 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_92),
	.Y(CTS_91));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00582 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_93),
	.Y(CTS_92));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00119 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_52),
	.Y(CTS_51));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00062 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_52),
	.Y(CTS_54));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00001 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_52),
	.Y(CTS_53));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00411 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_55),
	.Y(CTS_52));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00060 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_48),
	.Y(CTS_47));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00059 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_48),
	.Y(CTS_46));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00056 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_48),
	.Y(CTS_50));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00055 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_48),
	.Y(CTS_49));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00388 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_55),
	.Y(CTS_48));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00517 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_56),
	.Y(CTS_55));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00108 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_42),
	.Y(CTS_41));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00107 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_42),
	.Y(CTS_44));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00058 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_42),
	.Y(CTS_43));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00403 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_45),
	.Y(CTS_42));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00057 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_38),
	.Y(CTS_37));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00054 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_38),
	.Y(CTS_36));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00053 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_38),
	.Y(CTS_40));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00052 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_38),
	.Y(CTS_39));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00387 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_45),
	.Y(CTS_38));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00051 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_33),
	.Y(CTS_32));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00050 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_33),
	.Y(CTS_35));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00048 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_33),
	.Y(CTS_34));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00386 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_45),
	.Y(CTS_33));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00510 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_56),
	.Y(CTS_45));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00557 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_57),
	.Y(CTS_56));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00118 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_27),
	.Y(CTS_26));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00111 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_27),
	.Y(CTS_29));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00068 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_27),
	.Y(CTS_28));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00410 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_30),
	.Y(CTS_27));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00110 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_23),
	.Y(CTS_22));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00109 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_23),
	.Y(CTS_21));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00067 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_23),
	.Y(CTS_25));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00066 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_23),
	.Y(CTS_24));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00404 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_30),
	.Y(CTS_23));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00065 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_18),
	.Y(CTS_17));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00064 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_18),
	.Y(CTS_16));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00063 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_18),
	.Y(CTS_20));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00061 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_18),
	.Y(CTS_19));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00389 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_30),
	.Y(CTS_18));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00516 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_31),
	.Y(CTS_30));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00112 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_12),
	.Y(CTS_11));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00078 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_12),
	.Y(CTS_10));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00077 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_12),
	.Y(CTS_14));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00075 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_12),
	.Y(CTS_13));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00405 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_15),
	.Y(CTS_12));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00076 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_7),
	.Y(CTS_6));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00072 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_7),
	.Y(CTS_5));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00070 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_7),
	.Y(CTS_9));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00069 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_7),
	.Y(CTS_8));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00391 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_15),
	.Y(CTS_7));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00074 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_2),
	.Y(CTS_1));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00073 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_2),
	.Y(CTS_4));
   INV_X7P5B_A9PP140ZTL_C30 CTS_ccl_a_inv_00071 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_2),
	.Y(CTS_3));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00390 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_15),
	.Y(CTS_2));
   INV_X6B_A9PP140ZTL_C30 CTS_ccl_a_inv_00511 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_31),
	.Y(CTS_15));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00556 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_57),
	.Y(CTS_31));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00577 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_93),
	.Y(CTS_57));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_inv_00591 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_94),
	.Y(CTS_93));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_a_inv_00596 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(CTS_112),
	.Y(CTS_94));
   INV_X4B_A9PP140ZTL_C30 CTS_ccl_inv_00600 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(clk),
	.Y(CTS_112));
   TIELO_X1M_A9PP140ZTL_C30 LTIE_LTIELO_1 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .Y(mag_im[0]));
   TIELO_X1M_A9PP140ZTL_C30 LTIE_LTIELO (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .Y(mag_re[255]));
   INV_X0P8M_A9PP140ZTL_C30 FE_OFC1131_n_136 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_136),
	.Y(n_135));
   INV_X1P7M_A9PP140ZTL_C30 FE_OFC1008_FE_OCPN1083_FE_OFN374_rst_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN1083_FE_OFN374_rst_n),
	.Y(FE_OFN377_rst_n));
   INV_X7P5M_A9PP140ZTL_C30 FE_OFC1007_FE_OCPN1083_FE_OFN374_rst_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN1083_FE_OFN374_rst_n),
	.Y(FE_RN_1));
   INV_X0P8B_A9PP140ZTL_C30 FE_OFC994_n_128 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_128),
	.Y(FE_OFN147_n_128));
   INV_X0P8M_A9PP140ZTL_C30 FE_OFC980_n_126 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_126),
	.Y(n_125));
   INV_X0P8B_A9PP140ZTL_C30 FE_OFC979_n_156 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_156),
	.Y(FE_OFN396_n_156));
   BUF_X5M_A9PP140ZTL_C30 FE_OCPC684_rst_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(rst_n),
	.Y(FE_OCPN308_rst_n));
   BUFH_X3M_A9PP140ZTL_C30 FE_OCPC549_FE_OFN30_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN1079_FE_OFN30_n_0),
	.Y(FE_OCPN174_n));
   INV_X11M_A9PP140ZTL_C30 FE_OFC525_rst_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_PSN132_rst_n),
	.Y(FE_OFN30_n_0));
   INV_X2M_A9PP140ZTL_C30 FE_OFC524_rst_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_PSN132_rst_n),
	.Y(FE_OFN49_n_0));
   INV_X13M_A9PP140ZTL_C30 FE_OFC521_rst_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_PSN132_rst_n),
	.Y(FE_RN_3));
   BUFH_X16M_A9PP140ZTL_C30 FE_OFC515_rst_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_PSN132_rst_n),
	.Y(FE_OCPN1079_FE_OFN30_n_0));
   INV_X3M_A9PP140ZTL_C30 FE_OFC92_rst_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN362_rst_n),
	.Y(FE_OFN64_n_0));
   pp_fir_0 pp_fir_0_1_1 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .enb_1_8_0(enb_1_8_0),
	.pp_fir_0_in_re(In1_re),
	.pp_fir_0_in_im(In1_im),
	.pp_fir_0_out_re({ pp_fir_out_re[15],
		pp_fir_out_re[14],
		pp_fir_out_re[13],
		pp_fir_out_re[12],
		pp_fir_out_re[11],
		pp_fir_out_re[10],
		pp_fir_out_re[9],
		pp_fir_out_re[8],
		pp_fir_out_re[7],
		pp_fir_out_re[6],
		pp_fir_out_re[5],
		pp_fir_out_re[4],
		pp_fir_out_re[3],
		pp_fir_out_re[2],
		UNCONNECTED8,
		UNCONNECTED7 }),
	.pp_fir_0_out_im({ pp_fir_out_im[15],
		pp_fir_out_im[14],
		pp_fir_out_im[13],
		pp_fir_out_im[12],
		pp_fir_out_im[11],
		pp_fir_out_im[10],
		pp_fir_out_im[9],
		pp_fir_out_im[8],
		pp_fir_out_im[7],
		pp_fir_out_im[6],
		pp_fir_out_im[5],
		pp_fir_out_im[4],
		pp_fir_out_im[3],
		pp_fir_out_im[2],
		UNCONNECTED10,
		UNCONNECTED9 }),
	.rst_n_BAR(FE_OFN50_n_0),
	.FE_OFN15_n_0(FE_OCPN312_FE_OFN30_n_0),
	.FE_OFN14_n_0(FE_RN_2),
	.FE_OFN13_n_0(FE_OFN80_n_0),
	.FE_OFN12_n_0(FE_OFN76_n_0),
	.FE_OFN11_n_0(FE_OCPN889_FE_OFN49_n_0),
	.FE_OFN10_n_0(FE_OFN30_n_0),
	.FE_OFN9_n_0(FE_OCPN908_FE_OFN364_rst_n),
	.FE_OFN8_n_0(FE_OFN495_n),
	.FE_OFN7_n_0(FE_OCPN886_FE_OFN30_n_0),
	.FE_OFN6_n_0(FE_OCPN1079_FE_OFN30_n_0),
	.FE_OFN5_n_0(FE_OCPN888_FE_OFN30_n_0),
	.FE_OFN3_n_0(FE_RN_3),
	.FE_OFN2_n_0(FE_OFN81_n_0),
	.FE_OFN1_n_0(FE_OFN57_n_0),
	.FE_OFN0_n_0(FE_OCPN984_FE_OFN30_n_0),
	.FE_OFN17_rst_n(FE_OFN66_n_0),
	.FE_OFN16_rst_n(FE_RN_5),
	.FE_OFN23_rst_n(FE_OCPN985_FE_OFN30_n_0),
	.FE_OFN22_rst_n(FE_OFN30_n_0),
	.FE_OFN21_rst_n(FE_OFN380_rst_n),
	.FE_OFN20_rst_n(FE_OCPN1198_FE_OFN376_rst_n),
	.FE_OFN19_rst_n(FE_OCPN1080_FE_OFN374_rst_n),
	.FE_OFN18_rst_n(FE_OFN372_rst_n),
	.FE_OFN25_n(FE_OFN494_n),
	.FE_OFN24_n(FE_OFN376_rst_n),
	.FE_OFN26_n(FE_OFN79_n_0),
	.FE_OCPN27_FE_OFN50_n_0(FE_OCPN874_FE_OFN50_n_0),
	.FE_OCPN28_FE_OFN30_n_0(FE_OCPN887_FE_OFN30_n_0),
	.FE_OCPN29_FE_OFN364_rst_n(FE_PSN131_FE_OCPN899_FE_OFN364_rst_n),
	.FE_OCPN30_FE_OFN364_rst_n(FE_OCPN990_FE_OFN364_rst_n),
	.FE_OCPN31_n(FE_OCPN907_n),
	.FE_OCPN32_n(FE_OCPN899_FE_OFN364_rst_n),
	.FE_OCPN33_FE_OFN384_rst_n(FE_OFN55_n_0),
	.FE_OCPN34_n(FE_OCPN1006_n),
	.FE_OCPN35_FE_OFN30_n_0(rst_n),
	.FE_OCPN36_FE_OFN374_rst_n(FE_OCPN1080_FE_OFN374_rst_n),
	.FE_OCPN37_FE_OFN384_rst_n(FE_OCPN1091_FE_OFN384_rst_n),
	.FE_OCPN38_FE_OFN380_rst_n(FE_OFN53_n_0),
	.FE_OCPN39_FE_OFN49_n_0(FE_OCPN1150_FE_OFN49_n_0),
	.FE_OFN40_n(FE_OCPN1080_FE_OFN374_rst_n),
	.FE_OFN41_FE_RN_3(FE_OCPN174_n),
	.FE_OCPN43_n(FE_OFN380_rst_n),
	.FE_OCPN42_n(FE_OFN55_n_0),
	.FE_OCPN0_rst_n(FE_OCPN308_rst_n),
	.FE_OCPN1_FE_OFN30_n_0(FE_OCPN313_FE_OFN30_n_0),
	.clk_clone40(CTS_25),
	.clk_clone37(CTS_54),
	.clk_clone15(CTS_115),
	.clk_clone13(CTS_145),
	.clk_clone18(CTS_116),
	.clk_clone3(CTS_206),
	.clk_clone9(CTS_150),
	.clk_clone10(CTS_149),
	.clk_clone11(CTS_148),
	.clk_clone8(CTS_180),
	.clk_clone6(CTS_193),
	.clk_clone5(CTS_191),
	.clk_clone14(CTS_153),
	.clk_clone7(CTS_190),
	.clk_clone1(CTS_210),
	.clk_clone4(CTS_205),
	.clk(CTS_212),
	.clk_clone2(CTS_204),
	.clk_clone12(CTS_146),
	.clk_clone39(CTS_26),
	.clk_clone38(CTS_53),
	.clk_clone36(CTS_51),
	.clk_clone35(CTS_88),
	.clk_clone34(CTS_89),
	.clk_clone32(CTS_97),
	.clk_clone31(CTS_98),
	.clk_clone30(CTS_95),
	.clk_clone29(CTS_96),
	.clk_clone28(CTS_99),
	.clk_clone27(CTS_100),
	.clk_clone26(CTS_101),
	.clk_clone25(CTS_102),
	.clk_clone33(CTS_104),
	.clk_clone22(CTS_105),
	.clk_clone21(CTS_106),
	.clk_clone23(CTS_107),
	.clk_clone20(CTS_108),
	.clk_clone24(CTS_109),
	.clk_clone19(CTS_111),
	.clk_clone17(CTS_113),
	.clk_clone16(CTS_114),
	.FE_PSN0_rst_n(FE_PSN132_rst_n));
   INV_X2M_A9PP140ZTL_C30 FE_OCPC3181_FE_OFN30_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_RN_3),
	.Y(FE_OCPN1006_n));
   BUF_X6M_A9PP140ZTL_C30 FE_OCPC3157_FE_OFN30_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_RN_3),
	.Y(FE_OFN31_n_0));
   INV_X2M_A9PP140ZTL_C30 FE_OCPC3154_FE_OFN376_rst_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN376_rst_n),
	.Y(FE_OCPN1198_FE_OFN376_rst_n));
   INV_X3M_A9PP140ZTL_C30 FE_OCPC3152_FE_OFN376_rst_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN376_rst_n),
	.Y(FE_OCPN1083_FE_OFN374_rst_n));
   INV_X5M_A9PP140ZTL_C30 FE_OCPC3151_FE_OFN376_rst_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN376_rst_n),
	.Y(FE_OFN374_rst_n));
   BUFH_X1M_A9PP140ZTL_C30 FE_OFC3149_signed_mag_0_abs_im_stage1_7 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_im_stage1[7]),
	.Y(n_105));
   INV_X0P8M_A9PP140ZTL_C30 FE_OFC3148_signed_mag_0_abs_im_stage1_7 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_im_stage1[7]),
	.Y(FE_OFN308_signed_mag_0_abs_im_stage1_7));
   INV_X13M_A9PP140ZTL_C30 FE_OFC2759_FE_RN_3 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN1079_FE_OFN30_n_0),
	.Y(FE_OFN75_n_0));
   INV_X16M_A9PP140ZTL_C30 FE_OFC2758_FE_RN_3 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN1079_FE_OFN30_n_0),
	.Y(FE_OCPN889_FE_OFN49_n_0));
   BUFH_X1M_A9PP140ZTL_C30 FE_OFC2698_n_77 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_77),
	.Y(FE_OFN306_n_77));
   INV_X7P5M_A9PP140ZTL_C30 FE_OFC2648_FE_OCPN1139_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN1139_n),
	.Y(FE_OFN483_n));
   INV_X6M_A9PP140ZTL_C30 FE_OFC2647_FE_OCPN1139_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN1139_n),
	.Y(FE_RN_4));
   INV_X5M_A9PP140ZTL_C30 FE_OFC2600_rst_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN374_rst_n),
	.Y(FE_OCPN1081_FE_OFN374_rst_n));
   INV_X4M_A9PP140ZTL_C30 FE_OFC2599_rst_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN374_rst_n),
	.Y(FE_OFN375_rst_n));
   BUFH_X16M_A9PP140ZTL_C30 FE_OCPC2193_FE_OFN49_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_PSN132_rst_n),
	.Y(FE_OCPN1150_FE_OFN49_n_0));
   BUF_X6M_A9PP140ZTL_C30 FE_OCPC2182_FE_OFN364_rst_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN899_FE_OFN364_rst_n),
	.Y(FE_OCPN1139_n));
   BUF_X7P5M_A9PP140ZTL_C30 FE_OCPC2136_FE_OFN30_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_RN_3),
	.Y(FE_OFN56_n_0));
   INV_X4M_A9PP140ZTL_C30 FE_OCPC2135_FE_OFN30_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_RN_3),
	.Y(FE_OCPN1007_n));
   INV_X2M_A9PP140ZTL_C30 FE_OCPC2132_FE_OFN30_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_RN_3),
	.Y(FE_OFN362_rst_n));
   INV_X4M_A9PP140ZTL_C30 FE_OCPC2130_FE_OFN30_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_RN_3),
	.Y(FE_OCPN876_FE_OFN30_n_0));
   BUFH_X1M_A9PP140ZTL_C30 FE_OCPC2120_FE_OFN49_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_PSN132_rst_n),
	.Y(FE_OCPN1092_FE_OFN49_n_0));
   BUFH_X3M_A9PP140ZTL_C30 FE_OCPC2097_FE_OFN364_rst_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN899_FE_OFN364_rst_n),
	.Y(FE_OCPN1072_n));
   BUFH_X3M_A9PP140ZTL_C30 FE_OCPC2027_FE_OFN49_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_PSN132_rst_n),
	.Y(FE_OCPN1002_FE_OFN49_n_0));
   BUF_X2M_A9PP140ZTL_C30 FE_OCPC2007_FE_OFN364_rst_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_PSN132_rst_n),
	.Y(FE_OCPN990_FE_OFN364_rst_n));
   BUFH_X6M_A9PP140ZTL_C30 FE_OCPC2003_FE_OFN364_rst_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN899_FE_OFN364_rst_n),
	.Y(FE_OCPN986_n));
   BUFH_X1M_A9PP140ZTL_C30 FE_OCPC1925_FE_OFN364_rst_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_PSN132_rst_n),
	.Y(FE_OCPN908_FE_OFN364_rst_n));
   BUFH_X3M_A9PP140ZTL_C30 FE_OCPC1924_FE_OFN364_rst_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN899_FE_OFN364_rst_n),
	.Y(FE_OCPN907_n));
   BUFH_X16M_A9PP140ZTL_C30 FE_OCPC1905_FE_OFN364_rst_n (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_PSN132_rst_n),
	.Y(FE_OCPN899_FE_OFN364_rst_n));
   INV_X3M_A9PP140ZTL_C30 FE_OCPC1859_FE_OFN30_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN49_n_0),
	.Y(FE_OFN65_n_0));
   BUFH_X16M_A9PP140ZTL_C30 FE_OCPC1853_FE_OFN50_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN899_FE_OFN364_rst_n),
	.Y(FE_OCPN874_FE_OFN50_n_0));
   INV_X4M_A9PP140ZTL_C30 FE_OFC1719_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN78_n_0),
	.Y(FE_OFN720_n));
   INV_X2M_A9PP140ZTL_C30 FE_OFC1534_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_PSN132_rst_n),
	.Y(FE_OFN79_n_0));
   INV_X4M_A9PP140ZTL_C30 FE_OFC1530_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_PSN132_rst_n),
	.Y(FE_OFN78_n_0));
   INV_X5M_A9PP140ZTL_C30 FE_OFC1526_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_PSN132_rst_n),
	.Y(FE_OFN80_n_0));
   INV_X4M_A9PP140ZTL_C30 FE_OFC1525_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_PSN132_rst_n),
	.Y(FE_OFN81_n_0));
   INV_X5M_A9PP140ZTL_C30 FE_OFC1523_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_PSN132_rst_n),
	.Y(FE_OFN76_n_0));
   INV_X7P5M_A9PP140ZTL_C30 FE_OFC1159_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN374_rst_n),
	.Y(FE_OFN492_n));
   INV_X1M_A9PP140ZTL_C30 FE_OFC1158_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN374_rst_n),
	.Y(FE_OFN491_n));
   INV_X7P5M_A9PP140ZTL_C30 FE_OFC1157_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN374_rst_n),
	.Y(FE_OFN490_n));
   BUF_X3P5M_A9PP140ZTL_C30 FE_OFC1151_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN376_rst_n),
	.Y(FE_OFN372_rst_n));
   INV_X13M_A9PP140ZTL_C30 FE_OFC1150_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_PSN132_rst_n),
	.Y(FE_OFN376_rst_n));
   INV_X6M_A9PP140ZTL_C30 FE_OFC987_n_0 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OCPN899_FE_OFN364_rst_n),
	.Y(FE_OFN66_n_0));
   INV_X1M_A9PP140ZTL_C30 FE_OFC768_n_53 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_53),
	.Y(n_52));
   INV_X1M_A9PP140ZTL_C30 FE_OFC722_n_154 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_154),
	.Y(n_153));
   BUFH_X1M_A9PP140ZTL_C30 FE_OFC587_n_79 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_79),
	.Y(FE_OFN307_n_79));
   BUFH_X1M_A9PP140ZTL_C30 FE_OFC584_n_53 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_53),
	.Y(FE_OFN304_n_53));
   BUF_X1M_A9PP140ZTL_C30 FE_OFC581_signed_mag_0_abs_re_stage1_3 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_re_stage1[3]),
	.Y(FE_OFN301_signed_mag_0_abs_re_stage1_3));
   INV_X1M_A9PP140ZTL_C30 FE_OFC212_n_438 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_438),
	.Y(n_437));
   INV_X0P6B_A9PP140ZTL_C30 FE_OFC200_n_446 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_446),
	.Y(n_445));
   BUF_X1M_A9PP140ZTL_C30 FE_OFC190_signed_mag_0_abs_re_stage1_4 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_re_stage1[4]),
	.Y(FE_OFN136_signed_mag_0_abs_re_stage1_4));
   INV_X0P6B_A9PP140ZTL_C30 FE_OFC189_signed_mag_0_abs_re_stage1_4 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_re_stage1[4]),
	.Y(n_54));
   INV_X0P6B_A9PP140ZTL_C30 FE_OFC187_n_90 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_90),
	.Y(n_89));
   INV_X1B_A9PP140ZTL_C30 FE_OFC182_signed_mag_0_abs_re_stage1_5 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_72),
	.Y(FE_OFN134_signed_mag_0_abs_re_stage1_5));
   INV_X1M_A9PP140ZTL_C30 FE_OFC181_signed_mag_0_abs_re_stage1_5 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_re_stage1[5]),
	.Y(n_72));
   INV_X1B_A9PP140ZTL_C30 FE_OFC180_signed_mag_0_abs_im_stage1_5 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_73),
	.Y(FE_OFN133_signed_mag_0_abs_im_stage1_5));
   INV_X1M_A9PP140ZTL_C30 FE_OFC179_signed_mag_0_abs_im_stage1_5 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_im_stage1[5]),
	.Y(n_73));
   INV_X1B_A9PP140ZTL_C30 FE_OFC174_signed_mag_0_abs_im_stage1_4 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_55),
	.Y(FE_OFN130_signed_mag_0_abs_im_stage1_4));
   INV_X1M_A9PP140ZTL_C30 FE_OFC173_signed_mag_0_abs_im_stage1_4 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_im_stage1[4]),
	.Y(n_55));
   INV_X1M_A9PP140ZTL_C30 FE_OFC172_n_84 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_84),
	.Y(n_83));
   INV_X1M_A9PP140ZTL_C30 FE_OFC171_n_59 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_59),
	.Y(FE_OFN129_n_59));
   BUF_X1M_A9PP140ZTL_C30 FE_OFC169_n_59 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_59),
	.Y(n_58));
   BUFH_X1M_A9PP140ZTL_C30 FE_OFC167_signed_mag_0_abs_im_stage1_3 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_im_stage1[3]),
	.Y(FE_OFN127_signed_mag_0_abs_im_stage1_3));
   INV_X1M_A9PP140ZTL_C30 FE_OFC166_signed_mag_0_abs_im_stage1_3 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_im_stage1[3]),
	.Y(FE_OFN126_signed_mag_0_abs_im_stage1_3));
   INV_X1M_A9PP140ZTL_C30 FE_OFC164_signed_mag_0_abs_re_stage1_3 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_re_stage1[3]),
	.Y(FE_OFN125_signed_mag_0_abs_re_stage1_3));
   DFFRPQA_X1M_A9PP140ZTL_C30 \Data_Type_Conversion_out_im_reg[0]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_105),
	.D(pp_fir_out_im[6]),
	.R(FE_OCPN312_FE_OFN30_n_0),
	.Q(Data_Type_Conversion_out_im[0]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \Data_Type_Conversion_out_im_reg[1]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_105),
	.D(pp_fir_out_im[7]),
	.R(FE_OCPN312_FE_OFN30_n_0),
	.QN(Data_Type_Conversion_out_im[1]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \Data_Type_Conversion_out_im_reg[2]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_105),
	.D(pp_fir_out_im[8]),
	.R(FE_OCPN312_FE_OFN30_n_0),
	.QN(Data_Type_Conversion_out_im[2]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \Data_Type_Conversion_out_im_reg[3]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_105),
	.D(pp_fir_out_im[9]),
	.R(FE_OCPN312_FE_OFN30_n_0),
	.QN(Data_Type_Conversion_out_im[3]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \Data_Type_Conversion_out_im_reg[4]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_113),
	.D(pp_fir_out_im[10]),
	.R(FE_OFN495_n),
	.QN(Data_Type_Conversion_out_im[4]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \Data_Type_Conversion_out_im_reg[5]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_105),
	.D(pp_fir_out_im[11]),
	.R(FE_OCPN312_FE_OFN30_n_0),
	.QN(Data_Type_Conversion_out_im[5]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \Data_Type_Conversion_out_im_reg[6]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_113),
	.D(pp_fir_out_im[12]),
	.R(FE_OFN495_n),
	.QN(Data_Type_Conversion_out_im[6]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \Data_Type_Conversion_out_im_reg[7]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_113),
	.D(pp_fir_out_im[13]),
	.R(FE_OFN495_n),
	.QN(Data_Type_Conversion_out_im[7]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \Data_Type_Conversion_out_im_reg[8]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_113),
	.D(pp_fir_out_im[14]),
	.R(FE_OFN495_n),
	.QN(Data_Type_Conversion_out_im[8]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \Data_Type_Conversion_out_re_reg[0]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_95),
	.D(pp_fir_out_re[6]),
	.R(FE_OFN80_n_0),
	.Q(Data_Type_Conversion_out_re[0]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \Data_Type_Conversion_out_re_reg[1]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_98),
	.D(pp_fir_out_re[7]),
	.R(FE_OFN80_n_0),
	.QN(Data_Type_Conversion_out_re[1]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \Data_Type_Conversion_out_re_reg[2]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_98),
	.D(pp_fir_out_re[8]),
	.R(FE_OFN80_n_0),
	.QN(Data_Type_Conversion_out_re[2]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \Data_Type_Conversion_out_re_reg[3]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_98),
	.D(pp_fir_out_re[9]),
	.R(FE_OFN80_n_0),
	.QN(Data_Type_Conversion_out_re[3]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \Data_Type_Conversion_out_re_reg[4]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_95),
	.D(pp_fir_out_re[10]),
	.R(FE_OFN80_n_0),
	.QN(Data_Type_Conversion_out_re[4]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \Data_Type_Conversion_out_re_reg[5]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_95),
	.D(pp_fir_out_re[11]),
	.R(FE_OFN80_n_0),
	.QN(Data_Type_Conversion_out_re[5]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \Data_Type_Conversion_out_re_reg[6]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_98),
	.D(pp_fir_out_re[12]),
	.R(FE_OFN80_n_0),
	.QN(Data_Type_Conversion_out_re[6]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \Data_Type_Conversion_out_re_reg[7]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_97),
	.D(pp_fir_out_re[13]),
	.R(FE_OFN80_n_0),
	.QN(Data_Type_Conversion_out_re[7]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \Data_Type_Conversion_out_re_reg[8]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_97),
	.D(pp_fir_out_re[14]),
	.R(FE_OFN80_n_0),
	.QN(n_647));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \signed_mag_0_abs_im_stage1_reg[0]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_145),
	.D(Data_Type_Conversion_out_im[0]),
	.R(FE_OFN380_rst_n),
	.QN(signed_mag_0_abs_im_stage1[0]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \signed_mag_0_abs_im_stage1_reg[1]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_135),
	.D(n_11),
	.R(FE_OFN380_rst_n),
	.QN(signed_mag_0_abs_im_stage1[1]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \signed_mag_0_abs_im_stage1_reg[2]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_145),
	.D(n_18),
	.R(FE_OFN380_rst_n),
	.QN(signed_mag_0_abs_im_stage1[2]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \signed_mag_0_abs_im_stage1_reg[3]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_149),
	.D(n_24),
	.R(FE_OFN53_n_0),
	.QN(signed_mag_0_abs_im_stage1[3]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \signed_mag_0_abs_im_stage1_reg[4]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_140),
	.D(n_37),
	.R(FE_OCPN313_FE_OFN30_n_0),
	.QN(signed_mag_0_abs_im_stage1[4]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \signed_mag_0_abs_im_stage1_reg[5]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_140),
	.D(n_43),
	.R(FE_OFN380_rst_n),
	.QN(signed_mag_0_abs_im_stage1[5]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \signed_mag_0_abs_im_stage1_reg[6]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_149),
	.D(n_63),
	.R(FE_OFN53_n_0),
	.QN(signed_mag_0_abs_im_stage1[6]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \signed_mag_0_abs_im_stage1_reg[7]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_149),
	.D(n_82),
	.R(FE_OFN53_n_0),
	.QN(signed_mag_0_abs_im_stage1[7]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \signed_mag_0_abs_re_stage1_reg[0]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_51),
	.D(Data_Type_Conversion_out_re[0]),
	.R(FE_OFN76_n_0),
	.QN(signed_mag_0_abs_re_stage1[0]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \signed_mag_0_abs_re_stage1_reg[1]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_51),
	.D(n_12),
	.R(FE_OFN76_n_0),
	.QN(signed_mag_0_abs_re_stage1[1]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \signed_mag_0_abs_re_stage1_reg[2]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_51),
	.D(n_19),
	.R(FE_OFN76_n_0),
	.QN(signed_mag_0_abs_re_stage1[2]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \signed_mag_0_abs_re_stage1_reg[3]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_47),
	.D(n_25),
	.R(FE_OFN76_n_0),
	.QN(signed_mag_0_abs_re_stage1[3]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \signed_mag_0_abs_re_stage1_reg[4]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_47),
	.D(n_38),
	.R(FE_OFN76_n_0),
	.QN(signed_mag_0_abs_re_stage1[4]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \signed_mag_0_abs_re_stage1_reg[5]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_51),
	.D(n_44),
	.R(FE_OFN76_n_0),
	.QN(signed_mag_0_abs_re_stage1[5]));
   DFFRPQNA_X1M_A9PP140ZTL_C30 \signed_mag_0_abs_re_stage1_reg[6]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_47),
	.D(n_61),
	.R(FE_OFN76_n_0),
	.QN(signed_mag_0_abs_re_stage1[6]));
   DFFRPQN_X2M_A9PP140ZTL_C30 \signed_mag_0_abs_re_stage1_reg[7]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_47),
	.D(n_62),
	.R(FE_OFN76_n_0),
	.QN(signed_mag_0_abs_re_stage1[7]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[0]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_10),
	.D(n_430),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_re_mag[0]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[1]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_11),
	.D(n_399),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_re_mag[1]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[2]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_11),
	.D(n_429),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_re_mag[2]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[3]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_10),
	.D(n_408),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_re_mag[3]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[4]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_13),
	.D(n_410),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_re_mag[4]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[5]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_11),
	.D(n_425),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_re_mag[5]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[6]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_4),
	.D(n_411),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_re_mag[6]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[7]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_14),
	.D(n_423),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_re_mag[7]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[8]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_13),
	.D(n_427),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_re_mag[8]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[9]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_6),
	.D(n_404),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_re_mag[9]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[10]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_6),
	.D(n_426),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_re_mag[10]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[11]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_5),
	.D(n_405),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_re_mag[11]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[12]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_29),
	.D(n_428),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_re_mag[12]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[13]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_5),
	.D(n_398),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_re_mag[13]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[14]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_6),
	.D(n_416),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_re_mag[14]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[15]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_10),
	.D(FE_OFN396_n_156),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_re_mag[15]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[16]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_3),
	.D(n_376),
	.R(FE_OFN318_FE_OCPN174_n),
	.Q(signed_mag_0_re_mag[16]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[17]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_1),
	.D(n_219),
	.R(FE_OFN318_FE_OCPN174_n),
	.Q(signed_mag_0_re_mag[17]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[18]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_1),
	.D(n_378),
	.R(FE_OFN318_FE_OCPN174_n),
	.Q(signed_mag_0_re_mag[18]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[19]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_3),
	.D(n_181),
	.R(FE_OFN318_FE_OCPN174_n),
	.Q(signed_mag_0_re_mag[19]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[20]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_3),
	.D(n_323),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_re_mag[20]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[21]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_3),
	.D(n_201),
	.R(FE_OFN318_FE_OCPN174_n),
	.Q(signed_mag_0_re_mag[21]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[22]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_3),
	.D(n_322),
	.R(FE_OFN318_FE_OCPN174_n),
	.Q(signed_mag_0_re_mag[22]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[23]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_3),
	.D(n_364),
	.R(FE_OFN318_FE_OCPN174_n),
	.Q(signed_mag_0_re_mag[23]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[24]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_9),
	.D(n_374),
	.R(FE_OFN318_FE_OCPN174_n),
	.Q(signed_mag_0_re_mag[24]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[25]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_9),
	.D(n_194),
	.R(FE_OFN318_FE_OCPN174_n),
	.Q(signed_mag_0_re_mag[25]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[26]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_9),
	.D(n_375),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_re_mag[26]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[27]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_9),
	.D(n_190),
	.R(FE_OFN318_FE_OCPN174_n),
	.Q(signed_mag_0_re_mag[27]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[28]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_9),
	.D(n_377),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_re_mag[28]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[29]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_24),
	.D(n_221),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_re_mag[29]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[30]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_9),
	.D(n_180),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_re_mag[30]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[31]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_9),
	.D(n_153),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_re_mag[31]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[32]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_26),
	.D(n_392),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_re_mag[32]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[33]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_24),
	.D(n_226),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_re_mag[33]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[34]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_24),
	.D(n_391),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_re_mag[34]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[35]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_25),
	.D(n_193),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_re_mag[35]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[36]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_26),
	.D(n_339),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_re_mag[36]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[37]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_26),
	.D(n_186),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_re_mag[37]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[38]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_25),
	.D(n_340),
	.R(FE_OFN81_n_0),
	.Q(signed_mag_0_re_mag[38]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[39]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_26),
	.D(n_367),
	.R(FE_OFN81_n_0),
	.Q(signed_mag_0_re_mag[39]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[40]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_25),
	.D(n_383),
	.R(FE_OFN81_n_0),
	.Q(signed_mag_0_re_mag[40]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[41]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_25),
	.D(n_208),
	.R(FE_OFN81_n_0),
	.Q(signed_mag_0_re_mag[41]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[42]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_17),
	.D(n_384),
	.R(FE_OFN81_n_0),
	.Q(signed_mag_0_re_mag[42]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[43]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_25),
	.D(n_202),
	.R(FE_OFN81_n_0),
	.Q(signed_mag_0_re_mag[43]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[44]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_54),
	.D(n_393),
	.R(FE_OFN81_n_0),
	.Q(signed_mag_0_re_mag[44]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[45]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_54),
	.D(n_228),
	.R(FE_OFN81_n_0),
	.Q(signed_mag_0_re_mag[45]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[46]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_54),
	.D(n_175),
	.R(FE_OFN81_n_0),
	.Q(signed_mag_0_re_mag[46]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[47]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_17),
	.D(n_149),
	.R(FE_OFN81_n_0),
	.Q(signed_mag_0_re_mag[47]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[48]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_20),
	.D(n_124),
	.R(FE_OFN81_n_0),
	.Q(signed_mag_0_re_mag[48]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[49]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_20),
	.D(n_119),
	.R(FE_OFN81_n_0),
	.Q(signed_mag_0_re_mag[49]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[50]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_19),
	.D(n_115),
	.R(FE_OFN77_n_0),
	.Q(signed_mag_0_re_mag[50]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[51]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_20),
	.D(n_122),
	.R(FE_OFN77_n_0),
	.Q(signed_mag_0_re_mag[51]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[52]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_19),
	.D(n_110),
	.R(FE_OFN77_n_0),
	.Q(signed_mag_0_re_mag[52]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[53]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_54),
	.D(n_117),
	.R(FE_OFN77_n_0),
	.Q(signed_mag_0_re_mag[53]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[54]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_47),
	.D(n_111),
	.R(FE_OFN77_n_0),
	.Q(signed_mag_0_re_mag[54]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[55]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_47),
	.D(n_112),
	.R(FE_OFN76_n_0),
	.Q(signed_mag_0_re_mag[55]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[56]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_47),
	.D(n_114),
	.R(FE_OFN779_n),
	.Q(signed_mag_0_re_mag[56]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[57]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_46),
	.D(n_120),
	.R(FE_OFN77_n_0),
	.Q(signed_mag_0_re_mag[57]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[58]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_47),
	.D(n_113),
	.R(FE_OFN77_n_0),
	.Q(signed_mag_0_re_mag[58]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[59]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_47),
	.D(n_121),
	.R(FE_OFN779_n),
	.Q(signed_mag_0_re_mag[59]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[60]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_46),
	.D(n_116),
	.R(FE_OFN779_n),
	.Q(signed_mag_0_re_mag[60]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[61]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_49),
	.D(n_118),
	.R(FE_OFN779_n),
	.Q(signed_mag_0_re_mag[61]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[62]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_49),
	.D(n_123),
	.R(FE_OFN779_n),
	.Q(signed_mag_0_re_mag[62]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[63]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_46),
	.D(n_97),
	.R(FE_OFN779_n),
	.Q(signed_mag_0_re_mag[63]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[64]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_36),
	.D(n_388),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(signed_mag_0_re_mag[64]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[65]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_44),
	.D(n_223),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(signed_mag_0_re_mag[65]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[66]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_37),
	.D(n_389),
	.R(FE_OFN1182_n),
	.Q(signed_mag_0_re_mag[66]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[67]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_37),
	.D(n_189),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(signed_mag_0_re_mag[67]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[68]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_50),
	.D(n_333),
	.R(FE_OFN1182_n),
	.Q(signed_mag_0_re_mag[68]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[69]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_49),
	.D(n_185),
	.R(FE_OFN779_n),
	.Q(signed_mag_0_re_mag[69]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[70]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_40),
	.D(n_334),
	.R(FE_RN_2),
	.Q(signed_mag_0_re_mag[70]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[71]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_39),
	.D(n_365),
	.R(FE_OFN779_n),
	.Q(signed_mag_0_re_mag[71]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[72]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_36),
	.D(n_381),
	.R(FE_OFN1182_n),
	.Q(signed_mag_0_re_mag[72]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[73]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_36),
	.D(n_204),
	.R(FE_OFN1182_n),
	.Q(signed_mag_0_re_mag[73]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[74]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_39),
	.D(n_382),
	.R(FE_RN_2),
	.Q(signed_mag_0_re_mag[74]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[75]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_39),
	.D(n_198),
	.R(FE_RN_2),
	.Q(signed_mag_0_re_mag[75]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[76]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_79),
	.D(n_390),
	.R(FE_RN_2),
	.Q(signed_mag_0_re_mag[76]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[77]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_39),
	.D(n_224),
	.R(FE_RN_2),
	.Q(signed_mag_0_re_mag[77]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[78]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_32),
	.D(n_174),
	.R(FE_OCPN129_FE_OFN1182_n),
	.Q(signed_mag_0_re_mag[78]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[79]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_32),
	.D(n_131),
	.R(FE_OCPN129_FE_OFN1182_n),
	.Q(signed_mag_0_re_mag[79]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[80]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_35),
	.D(n_254),
	.R(FE_OCPN129_FE_OFN1182_n),
	.Q(signed_mag_0_re_mag[80]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[81]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_35),
	.D(n_278),
	.R(FE_OCPN129_FE_OFN1182_n),
	.Q(signed_mag_0_re_mag[81]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[82]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_35),
	.D(n_253),
	.R(FE_OCPN129_FE_OFN1182_n),
	.Q(signed_mag_0_re_mag[82]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[83]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_34),
	.D(n_313),
	.R(FE_RN_2),
	.Q(signed_mag_0_re_mag[83]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[84]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_34),
	.D(n_165),
	.R(FE_OCPN129_FE_OFN1182_n),
	.Q(signed_mag_0_re_mag[84]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[85]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_68),
	.D(n_360),
	.R(FE_OFN56_n_0),
	.Q(signed_mag_0_re_mag[85]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[86]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_32),
	.D(n_164),
	.R(FE_OCPN129_FE_OFN1182_n),
	.Q(signed_mag_0_re_mag[86]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[87]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_79),
	.D(n_196),
	.R(FE_RN_2),
	.Q(signed_mag_0_re_mag[87]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[88]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_34),
	.D(n_237),
	.R(FE_OFN56_n_0),
	.Q(signed_mag_0_re_mag[88]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[89]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_34),
	.D(n_303),
	.R(FE_OFN56_n_0),
	.Q(signed_mag_0_re_mag[89]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[90]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_69),
	.D(n_236),
	.R(FE_OFN56_n_0),
	.Q(signed_mag_0_re_mag[90]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[91]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_71),
	.D(n_307),
	.R(FE_OFN56_n_0),
	.Q(signed_mag_0_re_mag[91]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[92]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_68),
	.D(n_251),
	.R(FE_OFN56_n_0),
	.Q(signed_mag_0_re_mag[92]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[93]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_71),
	.D(n_274),
	.R(FE_OFN64_n_0),
	.Q(signed_mag_0_re_mag[93]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[94]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_71),
	.D(n_346),
	.R(FE_OFN56_n_0),
	.Q(signed_mag_0_re_mag[94]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[95]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_68),
	.D(n_151),
	.R(FE_OFN56_n_0),
	.Q(signed_mag_0_re_mag[95]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[96]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_72),
	.D(n_263),
	.R(FE_OFN64_n_0),
	.Q(signed_mag_0_re_mag[96]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[97]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_72),
	.D(n_284),
	.R(FE_OFN64_n_0),
	.Q(signed_mag_0_re_mag[97]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[98]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_72),
	.D(n_261),
	.R(FE_OFN64_n_0),
	.Q(signed_mag_0_re_mag[98]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[99]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_71),
	.D(n_316),
	.R(FE_OFN64_n_0),
	.Q(signed_mag_0_re_mag[99]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[100]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_72),
	.D(n_169),
	.R(FE_OFN64_n_0),
	.Q(signed_mag_0_re_mag[100]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[101]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_83),
	.D(n_363),
	.R(FE_OFN64_n_0),
	.Q(signed_mag_0_re_mag[101]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[102]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_72),
	.D(n_170),
	.R(FE_OCPN1103_n),
	.Q(signed_mag_0_re_mag[102]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[103]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_74),
	.D(n_199),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(signed_mag_0_re_mag[103]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[104]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_83),
	.D(n_246),
	.R(FE_OCPN1103_n),
	.Q(signed_mag_0_re_mag[104]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[105]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_74),
	.D(n_305),
	.R(FE_OCPN1103_n),
	.Q(signed_mag_0_re_mag[105]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[106]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_83),
	.D(n_243),
	.R(FE_OCPN1103_n),
	.Q(signed_mag_0_re_mag[106]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[107]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_74),
	.D(n_310),
	.R(FE_OCPN1103_n),
	.Q(signed_mag_0_re_mag[107]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[108]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_82),
	.D(n_265),
	.R(FE_OCPN1103_n),
	.Q(signed_mag_0_re_mag[108]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[109]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_74),
	.D(n_281),
	.R(FE_OCPN1103_n),
	.Q(signed_mag_0_re_mag[109]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[110]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_74),
	.D(n_348),
	.R(FE_OCPN1103_n),
	.Q(signed_mag_0_re_mag[110]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[111]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_82),
	.D(n_147),
	.R(FE_OCPN1217_n),
	.Q(signed_mag_0_re_mag[111]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[112]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_86),
	.D(n_354),
	.R(FE_OCPN1217_n),
	.Q(signed_mag_0_re_mag[112]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[113]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_82),
	.D(n_210),
	.R(FE_OCPN1217_n),
	.Q(signed_mag_0_re_mag[113]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[114]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_86),
	.D(n_355),
	.R(FE_OCPN1217_n),
	.Q(signed_mag_0_re_mag[114]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[115]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_86),
	.D(n_257),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(signed_mag_0_re_mag[115]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[116]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_86),
	.D(n_271),
	.R(FE_OCPN1217_n),
	.Q(signed_mag_0_re_mag[116]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[117]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_82),
	.D(n_325),
	.R(FE_OCPN1217_n),
	.Q(signed_mag_0_re_mag[117]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[118]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_58),
	.D(n_272),
	.R(FE_OCPN1217_n),
	.Q(signed_mag_0_re_mag[118]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[119]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_87),
	.D(n_413),
	.R(FE_OFN50_n_0),
	.Q(signed_mag_0_re_mag[119]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[120]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_58),
	.D(n_344),
	.R(FE_OCPN1217_n),
	.Q(signed_mag_0_re_mag[120]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[121]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_58),
	.D(n_231),
	.R(FE_OCPN1217_n),
	.Q(signed_mag_0_re_mag[121]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[122]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_58),
	.D(n_345),
	.R(FE_OCPN1217_n),
	.Q(signed_mag_0_re_mag[122]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[123]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_66),
	.D(n_320),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(signed_mag_0_re_mag[123]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[124]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_61),
	.D(n_353),
	.R(FE_OCPN1217_n),
	.Q(signed_mag_0_re_mag[124]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[125]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_61),
	.D(n_213),
	.R(FE_OCPN1217_n),
	.Q(signed_mag_0_re_mag[125]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[126]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_66),
	.D(n_415),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(signed_mag_0_re_mag[126]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[127]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_76),
	.D(n_91),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(signed_mag_0_re_mag[127]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[128]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_61),
	.D(n_373),
	.R(FE_OFN31_n_0),
	.Q(signed_mag_0_re_mag[128]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[129]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_61),
	.D(n_205),
	.R(FE_OFN31_n_0),
	.Q(signed_mag_0_re_mag[129]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[130]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_66),
	.D(n_372),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(signed_mag_0_re_mag[130]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[131]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_66),
	.D(n_183),
	.R(FE_OFN31_n_0),
	.Q(signed_mag_0_re_mag[131]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[132]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_65),
	.D(n_394),
	.R(FE_OFN31_n_0),
	.Q(signed_mag_0_re_mag[132]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[133]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_61),
	.D(n_255),
	.R(FE_OFN31_n_0),
	.Q(signed_mag_0_re_mag[133]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[134]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_65),
	.D(n_397),
	.R(FE_OFN31_n_0),
	.Q(signed_mag_0_re_mag[134]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[135]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_65),
	.D(n_358),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(signed_mag_0_re_mag[135]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[136]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_131),
	.D(n_370),
	.R(FE_OFN31_n_0),
	.Q(signed_mag_0_re_mag[136]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[137]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_60),
	.D(n_184),
	.R(FE_OFN31_n_0),
	.Q(signed_mag_0_re_mag[137]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[138]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_131),
	.D(n_369),
	.R(FE_OFN31_n_0),
	.Q(signed_mag_0_re_mag[138]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[139]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_65),
	.D(n_182),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(signed_mag_0_re_mag[139]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[140]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_131),
	.D(n_371),
	.R(FE_OFN32_n_0),
	.Q(signed_mag_0_re_mag[140]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[141]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_138),
	.D(n_206),
	.R(FE_OFN33_n_0),
	.Q(signed_mag_0_re_mag[141]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[142]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_137),
	.D(n_218),
	.R(FE_OFN33_n_0),
	.Q(signed_mag_0_re_mag[142]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[143]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_131),
	.D(n_129),
	.R(FE_OFN31_n_0),
	.Q(signed_mag_0_re_mag[143]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[144]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_130),
	.D(n_298),
	.R(FE_OFN32_n_0),
	.Q(signed_mag_0_re_mag[144]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[145]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_130),
	.D(n_240),
	.R(FE_OFN32_n_0),
	.Q(signed_mag_0_re_mag[145]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[146]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_130),
	.D(n_297),
	.R(FE_OFN33_n_0),
	.Q(signed_mag_0_re_mag[146]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[147]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_130),
	.D(n_301),
	.R(FE_OFN33_n_0),
	.Q(signed_mag_0_re_mag[147]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[148]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_134),
	.D(n_177),
	.R(FE_OFN32_n_0),
	.Q(signed_mag_0_re_mag[148]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[149]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_130),
	.D(n_357),
	.R(FE_OFN32_n_0),
	.Q(signed_mag_0_re_mag[149]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[150]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_130),
	.D(n_176),
	.R(FE_OFN32_n_0),
	.Q(signed_mag_0_re_mag[150]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[151]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_142),
	.D(n_220),
	.R(FE_OFN57_n_0),
	.Q(signed_mag_0_re_mag[151]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[152]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_142),
	.D(n_289),
	.R(FE_OFN57_n_0),
	.Q(signed_mag_0_re_mag[152]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[153]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_134),
	.D(n_290),
	.R(FE_OFN32_n_0),
	.Q(signed_mag_0_re_mag[153]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[154]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_142),
	.D(n_288),
	.R(FE_OFN32_n_0),
	.Q(signed_mag_0_re_mag[154]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[155]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_142),
	.D(n_295),
	.R(FE_OFN57_n_0),
	.Q(signed_mag_0_re_mag[155]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[156]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_133),
	.D(n_296),
	.R(FE_OFN32_n_0),
	.Q(signed_mag_0_re_mag[156]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[157]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_133),
	.D(n_238),
	.R(FE_OFN32_n_0),
	.Q(signed_mag_0_re_mag[157]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[158]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_142),
	.D(n_330),
	.R(FE_OFN32_n_0),
	.Q(signed_mag_0_re_mag[158]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[159]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_133),
	.D(FE_OFN147_n_128),
	.R(FE_OFN32_n_0),
	.Q(signed_mag_0_re_mag[159]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[160]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_133),
	.D(n_293),
	.R(FE_OFN492_n),
	.Q(signed_mag_0_re_mag[160]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[161]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_122),
	.D(n_229),
	.R(FE_OFN492_n),
	.Q(signed_mag_0_re_mag[161]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[162]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_142),
	.D(n_292),
	.R(FE_OFN492_n),
	.Q(signed_mag_0_re_mag[162]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[163]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_122),
	.D(n_299),
	.R(FE_OFN57_n_0),
	.Q(signed_mag_0_re_mag[163]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[164]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_124),
	.D(n_172),
	.R(FE_OFN492_n),
	.Q(signed_mag_0_re_mag[164]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[165]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_124),
	.D(n_356),
	.R(FE_OFN492_n),
	.Q(signed_mag_0_re_mag[165]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[166]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_124),
	.D(n_171),
	.R(FE_OFN492_n),
	.Q(signed_mag_0_re_mag[166]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[167]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_121),
	.D(n_216),
	.R(FE_OFN57_n_0),
	.Q(signed_mag_0_re_mag[167]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[168]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_125),
	.D(n_286),
	.R(FE_OFN492_n),
	.Q(signed_mag_0_re_mag[168]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[169]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_124),
	.D(n_287),
	.R(FE_OFN492_n),
	.Q(signed_mag_0_re_mag[169]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[170]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_124),
	.D(n_285),
	.R(FE_OFN492_n),
	.Q(signed_mag_0_re_mag[170]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[171]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_121),
	.D(n_294),
	.R(FE_OFN492_n),
	.Q(signed_mag_0_re_mag[171]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[172]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_124),
	.D(n_291),
	.R(FE_OFN492_n),
	.Q(signed_mag_0_re_mag[172]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[173]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_119),
	.D(n_227),
	.R(FE_OFN490_n),
	.Q(signed_mag_0_re_mag[173]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[174]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_127),
	.D(n_324),
	.R(FE_OFN491_n),
	.Q(signed_mag_0_re_mag[174]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[175]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_127),
	.D(n_125),
	.R(FE_OFN490_n),
	.Q(signed_mag_0_re_mag[175]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[176]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_119),
	.D(n_241),
	.R(FE_OFN490_n),
	.Q(signed_mag_0_re_mag[176]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[177]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_119),
	.D(n_217),
	.R(FE_OFN490_n),
	.Q(signed_mag_0_re_mag[177]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[178]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_120),
	.D(n_319),
	.R(FE_OFN490_n),
	.Q(signed_mag_0_re_mag[178]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[179]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_120),
	.D(n_280),
	.R(FE_OFN490_n),
	.Q(signed_mag_0_re_mag[179]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[180]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_200),
	.D(n_192),
	.R(FE_OFN490_n),
	.Q(signed_mag_0_re_mag[180]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[181]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_120),
	.D(n_335),
	.R(FE_OFN490_n),
	.Q(signed_mag_0_re_mag[181]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[182]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_120),
	.D(n_191),
	.R(FE_OFN490_n),
	.Q(signed_mag_0_re_mag[182]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[183]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_120),
	.D(n_267),
	.R(FE_OFN490_n),
	.Q(signed_mag_0_re_mag[183]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[184]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_199),
	.D(n_312),
	.R(FE_OFN490_n),
	.Q(signed_mag_0_re_mag[184]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[185]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_200),
	.D(n_248),
	.R(FE_RN_1),
	.Q(signed_mag_0_re_mag[185]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[186]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_200),
	.D(n_311),
	.R(FE_RN_1),
	.Q(signed_mag_0_re_mag[186]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[187]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_120),
	.D(n_258),
	.R(FE_RN_1),
	.Q(signed_mag_0_re_mag[187]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[188]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_199),
	.D(n_318),
	.R(FE_OFN377_rst_n),
	.Q(signed_mag_0_re_mag[188]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[189]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_199),
	.D(n_215),
	.R(FE_OFN377_rst_n),
	.Q(signed_mag_0_re_mag[189]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[190]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_199),
	.D(n_321),
	.R(FE_OFN377_rst_n),
	.Q(signed_mag_0_re_mag[190]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[191]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_122),
	.D(FE_OFN140_n_95),
	.R(FE_OFN57_n_0),
	.Q(signed_mag_0_re_mag[191]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[192]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_186),
	.D(n_338),
	.R(FE_RN_1),
	.Q(signed_mag_0_re_mag[192]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[193]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_203),
	.D(n_214),
	.R(FE_RN_1),
	.Q(signed_mag_0_re_mag[193]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[194]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_199),
	.D(n_337),
	.R(FE_RN_1),
	.Q(signed_mag_0_re_mag[194]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[195]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_189),
	.D(n_268),
	.R(FE_RN_1),
	.Q(signed_mag_0_re_mag[195]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[196]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_202),
	.D(n_232),
	.R(FE_RN_1),
	.Q(signed_mag_0_re_mag[196]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[197]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_202),
	.D(n_329),
	.R(FE_RN_1),
	.Q(signed_mag_0_re_mag[197]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[198]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_202),
	.D(n_233),
	.R(FE_RN_1),
	.Q(signed_mag_0_re_mag[198]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[199]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_186),
	.D(n_315),
	.R(FE_RN_1),
	.Q(signed_mag_0_re_mag[199]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[200]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_202),
	.D(n_328),
	.R(FE_RN_1),
	.Q(signed_mag_0_re_mag[200]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[201]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_198),
	.D(n_239),
	.R(FE_OCPN1080_FE_OFN374_rst_n),
	.Q(signed_mag_0_re_mag[201]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[202]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_198),
	.D(n_327),
	.R(FE_OCPN1080_FE_OFN374_rst_n),
	.Q(signed_mag_0_re_mag[202]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[203]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_195),
	.D(n_247),
	.R(FE_OCPN1080_FE_OFN374_rst_n),
	.Q(signed_mag_0_re_mag[203]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[204]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_198),
	.D(n_336),
	.R(FE_OCPN1080_FE_OFN374_rst_n),
	.Q(signed_mag_0_re_mag[204]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[205]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_195),
	.D(n_209),
	.R(FE_OCPN1080_FE_OFN374_rst_n),
	.Q(signed_mag_0_re_mag[205]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[206]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_195),
	.D(n_402),
	.R(FE_OCPN1080_FE_OFN374_rst_n),
	.Q(signed_mag_0_re_mag[206]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[207]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_195),
	.D(n_158),
	.R(FE_OCPN1080_FE_OFN374_rst_n),
	.Q(signed_mag_0_re_mag[207]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[208]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_197),
	.D(n_533),
	.R(FE_OCPN1080_FE_OFN374_rst_n),
	.Q(signed_mag_0_re_mag[208]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[209]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_197),
	.D(n_489),
	.R(FE_OCPN1080_FE_OFN374_rst_n),
	.Q(signed_mag_0_re_mag[209]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[210]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_168),
	.D(n_532),
	.R(FE_OCPN1207_n),
	.Q(signed_mag_0_re_mag[210]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[211]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_197),
	.D(n_523),
	.R(FE_OCPN1080_FE_OFN374_rst_n),
	.Q(signed_mag_0_re_mag[211]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[212]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_197),
	.D(n_457),
	.R(FE_OCPN1207_n),
	.Q(signed_mag_0_re_mag[212]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[213]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_168),
	.D(n_565),
	.R(FE_OCPN1207_n),
	.Q(signed_mag_0_re_mag[213]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[214]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_168),
	.D(n_456),
	.R(FE_OCPN1210_n),
	.Q(signed_mag_0_re_mag[214]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[215]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_160),
	.D(n_487),
	.R(FE_OFN66_n_0),
	.Q(signed_mag_0_re_mag[215]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[216]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_160),
	.D(n_528),
	.R(FE_OCPN1210_n),
	.Q(signed_mag_0_re_mag[216]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[217]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_167),
	.D(n_510),
	.R(FE_OCPN1207_n),
	.Q(signed_mag_0_re_mag[217]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[218]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_168),
	.D(n_527),
	.R(FE_OCPN1207_n),
	.Q(signed_mag_0_re_mag[218]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[219]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_168),
	.D(n_514),
	.R(FE_OCPN1210_n),
	.Q(signed_mag_0_re_mag[219]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[220]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_168),
	.D(n_531),
	.R(FE_OCPN1207_n),
	.Q(signed_mag_0_re_mag[220]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[221]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_164),
	.D(n_488),
	.R(FE_OCPN1207_n),
	.Q(signed_mag_0_re_mag[221]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[222]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_167),
	.D(n_550),
	.R(FE_OCPN1207_n),
	.Q(signed_mag_0_re_mag[222]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[223]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_159),
	.D(n_139),
	.R(FE_OCPN1207_n),
	.Q(signed_mag_0_re_mag[223]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[224]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_160),
	.D(n_544),
	.R(FE_OCPN1207_n),
	.Q(signed_mag_0_re_mag[224]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[225]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_164),
	.D(n_476),
	.R(FE_OCPN1207_n),
	.Q(signed_mag_0_re_mag[225]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[226]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_164),
	.D(n_543),
	.R(FE_OCPN1207_n),
	.Q(signed_mag_0_re_mag[226]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[227]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_164),
	.D(n_503),
	.R(FE_OCPN1207_n),
	.Q(signed_mag_0_re_mag[227]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[228]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_164),
	.D(n_468),
	.R(FE_OCPN1207_n),
	.Q(signed_mag_0_re_mag[228]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[229]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_158),
	.D(n_551),
	.R(FE_OCPN1207_n),
	.Q(signed_mag_0_re_mag[229]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[230]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_158),
	.D(n_467),
	.R(FE_OCPN1207_n),
	.Q(signed_mag_0_re_mag[230]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[231]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_163),
	.D(n_507),
	.R(FE_RN_5),
	.Q(signed_mag_0_re_mag[231]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[232]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_174),
	.D(n_537),
	.R(FE_RN_4),
	.Q(signed_mag_0_re_mag[232]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[233]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_158),
	.D(n_490),
	.R(FE_RN_4),
	.Q(signed_mag_0_re_mag[233]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[234]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_177),
	.D(n_536),
	.R(FE_RN_4),
	.Q(signed_mag_0_re_mag[234]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[235]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_177),
	.D(n_495),
	.R(FE_RN_4),
	.Q(signed_mag_0_re_mag[235]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[236]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_174),
	.D(n_542),
	.R(FE_OFN483_n),
	.Q(signed_mag_0_re_mag[236]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[237]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_176),
	.D(n_475),
	.R(FE_OFN483_n),
	.Q(signed_mag_0_re_mag[237]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[238]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_176),
	.D(n_545),
	.R(FE_OFN483_n),
	.Q(signed_mag_0_re_mag[238]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[239]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_177),
	.D(n_138),
	.R(FE_OFN487_n),
	.Q(signed_mag_0_re_mag[239]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[240]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_159),
	.D(n_422),
	.R(FE_OCPN1207_n),
	.Q(signed_mag_0_re_mag[240]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[241]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_164),
	.D(n_396),
	.R(FE_OCPN1207_n),
	.Q(signed_mag_0_re_mag[241]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[242]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_164),
	.D(n_421),
	.R(FE_OCPN1207_n),
	.Q(signed_mag_0_re_mag[242]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[243]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_164),
	.D(n_409),
	.R(FE_OFN73_n_0),
	.Q(signed_mag_0_re_mag[243]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[244]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_158),
	.D(n_400),
	.R(FE_RN_4),
	.Q(signed_mag_0_re_mag[244]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[245]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_158),
	.D(n_424),
	.R(FE_RN_4),
	.Q(signed_mag_0_re_mag[245]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[246]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_158),
	.D(n_401),
	.R(FE_RN_4),
	.Q(signed_mag_0_re_mag[246]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[247]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_155),
	.D(n_412),
	.R(FE_OFN73_n_0),
	.Q(signed_mag_0_re_mag[247]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[248]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_176),
	.D(n_419),
	.R(FE_OFN487_n),
	.Q(signed_mag_0_re_mag[248]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[249]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_173),
	.D(n_403),
	.R(FE_OFN487_n),
	.Q(signed_mag_0_re_mag[249]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[250]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_173),
	.D(n_418),
	.R(FE_OFN487_n),
	.Q(signed_mag_0_re_mag[250]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[251]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_173),
	.D(n_406),
	.R(FE_OFN487_n),
	.Q(signed_mag_0_re_mag[251]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[252]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_173),
	.D(n_420),
	.R(FE_OFN487_n),
	.Q(signed_mag_0_re_mag[252]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[253]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_172),
	.D(n_395),
	.R(FE_OFN487_n),
	.Q(signed_mag_0_re_mag[253]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_iOut_reg[254]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_172),
	.D(n_417),
	.R(FE_OFN487_n),
	.Q(signed_mag_0_re_mag[254]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[1]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_11),
	.D(n_601),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_im_mag[1]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[2]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_11),
	.D(n_586),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_im_mag[2]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[3]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_14),
	.D(n_607),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_im_mag[3]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[4]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_14),
	.D(n_595),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_im_mag[4]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[5]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_1),
	.D(n_604),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_im_mag[5]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[6]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_14),
	.D(n_593),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_im_mag[6]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[7]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_4),
	.D(n_603),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_im_mag[7]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[8]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_26),
	.D(n_600),
	.R(FE_OFN318_FE_OCPN174_n),
	.Q(signed_mag_0_im_mag[8]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[9]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_9),
	.D(n_591),
	.R(FE_OFN318_FE_OCPN174_n),
	.Q(signed_mag_0_im_mag[9]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[10]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_28),
	.D(n_610),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_im_mag[10]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[11]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_8),
	.D(n_590),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_im_mag[11]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[12]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_29),
	.D(n_596),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_im_mag[12]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[13]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_28),
	.D(n_606),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_im_mag[13]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[14]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_29),
	.D(n_587),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_im_mag[14]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[15]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_22),
	.D(n_605),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_im_mag[15]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[16]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_13),
	.D(n_434),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_im_mag[16]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[17]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_14),
	.D(n_643),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_im_mag[17]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[18]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_4),
	.D(n_621),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_im_mag[18]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[19]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_14),
	.D(n_642),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_im_mag[19]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[20]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_4),
	.D(n_627),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_im_mag[20]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[21]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_4),
	.D(n_639),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_im_mag[21]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[22]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_8),
	.D(n_626),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_im_mag[22]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[23]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_5),
	.D(n_638),
	.R(FE_OFN75_n_0),
	.Q(signed_mag_0_im_mag[23]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[24]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_28),
	.D(n_629),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_im_mag[24]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[25]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_28),
	.D(n_620),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_im_mag[25]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[26]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_28),
	.D(n_645),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_im_mag[26]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[27]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_28),
	.D(n_619),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_im_mag[27]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[28]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_21),
	.D(n_628),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_im_mag[28]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[29]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_21),
	.D(n_641),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_im_mag[29]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[30]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_29),
	.D(n_622),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_im_mag[30]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[31]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_22),
	.D(n_640),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_im_mag[31]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[32]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_22),
	.D(n_435),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_im_mag[32]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[33]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_21),
	.D(n_644),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_im_mag[33]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[34]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_21),
	.D(n_624),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_im_mag[34]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[35]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_21),
	.D(n_637),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_im_mag[35]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[36]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_21),
	.D(n_631),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_im_mag[36]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[37]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_17),
	.D(n_634),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_im_mag[37]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[38]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_17),
	.D(n_630),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(signed_mag_0_im_mag[38]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[39]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_17),
	.D(n_633),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(signed_mag_0_im_mag[39]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[40]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_20),
	.D(n_623),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(signed_mag_0_im_mag[40]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[41]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_17),
	.D(n_618),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(signed_mag_0_im_mag[41]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[42]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_16),
	.D(n_646),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(signed_mag_0_im_mag[42]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[43]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_16),
	.D(n_617),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(signed_mag_0_im_mag[43]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[44]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_20),
	.D(n_632),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(signed_mag_0_im_mag[44]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[45]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_41),
	.D(n_636),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(signed_mag_0_im_mag[45]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[46]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_41),
	.D(n_625),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(signed_mag_0_im_mag[46]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[47]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_41),
	.D(n_635),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(signed_mag_0_im_mag[47]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[48]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_41),
	.D(n_441),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(signed_mag_0_im_mag[48]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[49]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_19),
	.D(n_546),
	.R(FE_OFN77_n_0),
	.Q(signed_mag_0_im_mag[49]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[50]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_19),
	.D(n_478),
	.R(FE_OFN77_n_0),
	.Q(signed_mag_0_im_mag[50]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[51]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_19),
	.D(n_562),
	.R(FE_OFN77_n_0),
	.Q(signed_mag_0_im_mag[51]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[52]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_46),
	.D(n_501),
	.R(FE_OFN77_n_0),
	.Q(signed_mag_0_im_mag[52]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[53]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_19),
	.D(n_556),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(signed_mag_0_im_mag[53]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[54]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_41),
	.D(n_499),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(signed_mag_0_im_mag[54]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[55]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_44),
	.D(n_555),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(signed_mag_0_im_mag[55]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[56]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_50),
	.D(n_538),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(signed_mag_0_im_mag[56]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[57]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_46),
	.D(n_497),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(signed_mag_0_im_mag[57]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[58]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_44),
	.D(n_557),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(signed_mag_0_im_mag[58]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[59]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_44),
	.D(n_496),
	.R(FE_OFN77_n_0),
	.Q(signed_mag_0_im_mag[59]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[60]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_37),
	.D(n_508),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(signed_mag_0_im_mag[60]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[61]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_44),
	.D(n_561),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(signed_mag_0_im_mag[61]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[62]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_44),
	.D(n_479),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(signed_mag_0_im_mag[62]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[63]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_44),
	.D(n_560),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(signed_mag_0_im_mag[63]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[64]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_69),
	.D(n_135),
	.R(FE_OFN79_n_0),
	.Q(signed_mag_0_im_mag[64]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[65]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_37),
	.D(n_549),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(signed_mag_0_im_mag[65]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[66]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_37),
	.D(n_480),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(signed_mag_0_im_mag[66]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[67]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_50),
	.D(n_541),
	.R(FE_OFN1182_n),
	.Q(signed_mag_0_im_mag[67]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[68]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_49),
	.D(n_505),
	.R(FE_OFN779_n),
	.Q(signed_mag_0_im_mag[68]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[69]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_50),
	.D(n_535),
	.R(FE_OFN1182_n),
	.Q(signed_mag_0_im_mag[69]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[70]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_49),
	.D(n_502),
	.R(FE_OFN1182_n),
	.Q(signed_mag_0_im_mag[70]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[71]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_49),
	.D(n_534),
	.R(FE_OFN779_n),
	.Q(signed_mag_0_im_mag[71]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[72]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_39),
	.D(n_506),
	.R(FE_RN_2),
	.Q(signed_mag_0_im_mag[72]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[73]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_37),
	.D(n_466),
	.R(FE_OFN1182_n),
	.Q(signed_mag_0_im_mag[73]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[74]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_40),
	.D(n_559),
	.R(FE_OFN1182_n),
	.Q(signed_mag_0_im_mag[74]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[75]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_40),
	.D(n_465),
	.R(FE_OCPN129_FE_OFN1182_n),
	.Q(signed_mag_0_im_mag[75]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[76]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_39),
	.D(n_509),
	.R(FE_RN_2),
	.Q(signed_mag_0_im_mag[76]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[77]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_40),
	.D(n_540),
	.R(FE_RN_2),
	.Q(signed_mag_0_im_mag[77]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[78]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_40),
	.D(n_482),
	.R(FE_OCPN129_FE_OFN1182_n),
	.Q(signed_mag_0_im_mag[78]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[79]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_40),
	.D(n_539),
	.R(FE_RN_2),
	.Q(signed_mag_0_im_mag[79]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[80]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_35),
	.D(n_449),
	.R(FE_OCPN129_FE_OFN1182_n),
	.Q(signed_mag_0_im_mag[80]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[81]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_79),
	.D(n_554),
	.R(FE_RN_2),
	.Q(signed_mag_0_im_mag[81]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[82]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_79),
	.D(n_492),
	.R(FE_OFN79_n_0),
	.Q(signed_mag_0_im_mag[82]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[83]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_79),
	.D(n_520),
	.R(FE_RN_2),
	.Q(signed_mag_0_im_mag[83]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[84]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_78),
	.D(n_521),
	.R(FE_OFN79_n_0),
	.Q(signed_mag_0_im_mag[84]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[85]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_78),
	.D(n_512),
	.R(FE_OFN79_n_0),
	.Q(signed_mag_0_im_mag[85]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[86]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_79),
	.D(n_513),
	.R(FE_RN_2),
	.Q(signed_mag_0_im_mag[86]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[87]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_78),
	.D(n_511),
	.R(FE_OFN79_n_0),
	.Q(signed_mag_0_im_mag[87]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[88]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_78),
	.D(n_481),
	.R(FE_OFN79_n_0),
	.Q(signed_mag_0_im_mag[88]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[89]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_76),
	.D(n_616),
	.R(FE_OFN56_n_0),
	.Q(signed_mag_0_im_mag[89]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[90]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_69),
	.D(n_566),
	.R(FE_OFN56_n_0),
	.Q(signed_mag_0_im_mag[90]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[91]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_71),
	.D(n_452),
	.R(FE_OFN56_n_0),
	.Q(signed_mag_0_im_mag[91]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[92]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_76),
	.D(n_529),
	.R(FE_OFN56_n_0),
	.Q(signed_mag_0_im_mag[92]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[93]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_71),
	.D(n_519),
	.R(FE_OFN56_n_0),
	.Q(signed_mag_0_im_mag[93]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[94]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_69),
	.D(n_494),
	.R(FE_OFN79_n_0),
	.Q(signed_mag_0_im_mag[94]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[95]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_69),
	.D(n_518),
	.R(FE_OFN79_n_0),
	.Q(signed_mag_0_im_mag[95]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[96]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_71),
	.D(n_447),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(signed_mag_0_im_mag[96]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[97]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_76),
	.D(n_558),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(signed_mag_0_im_mag[97]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[98]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_76),
	.D(n_498),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(signed_mag_0_im_mag[98]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[99]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_76),
	.D(n_524),
	.R(FE_OFN56_n_0),
	.Q(signed_mag_0_im_mag[99]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[100]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_76),
	.D(n_522),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(signed_mag_0_im_mag[100]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[101]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_76),
	.D(n_515),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(signed_mag_0_im_mag[101]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[102]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_76),
	.D(n_517),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(signed_mag_0_im_mag[102]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[103]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_75),
	.D(n_516),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(signed_mag_0_im_mag[103]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[104]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_86),
	.D(n_485),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(signed_mag_0_im_mag[104]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[105]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_86),
	.D(n_454),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(signed_mag_0_im_mag[105]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[106]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_88),
	.D(n_567),
	.R(FE_OFN50_n_0),
	.Q(signed_mag_0_im_mag[106]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[107]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_75),
	.D(n_455),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(signed_mag_0_im_mag[107]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[108]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_84),
	.D(n_530),
	.R(FE_OFN50_n_0),
	.Q(signed_mag_0_im_mag[108]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[109]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_75),
	.D(n_525),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(signed_mag_0_im_mag[109]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[110]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_88),
	.D(n_500),
	.R(FE_OFN50_n_0),
	.Q(signed_mag_0_im_mag[110]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[111]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_88),
	.D(n_526),
	.R(FE_OFN50_n_0),
	.Q(signed_mag_0_im_mag[111]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[112]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_87),
	.D(n_437),
	.R(FE_OFN50_n_0),
	.Q(signed_mag_0_im_mag[112]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[113]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_88),
	.D(n_483),
	.R(FE_OFN50_n_0),
	.Q(signed_mag_0_im_mag[113]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[114]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_84),
	.D(n_474),
	.R(FE_OFN50_n_0),
	.Q(signed_mag_0_im_mag[114]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[115]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_84),
	.D(n_575),
	.R(FE_OFN50_n_0),
	.Q(signed_mag_0_im_mag[115]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[116]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_63),
	.D(n_462),
	.R(FE_OFN50_n_0),
	.Q(signed_mag_0_im_mag[116]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[117]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_87),
	.D(n_572),
	.R(FE_OFN50_n_0),
	.Q(signed_mag_0_im_mag[117]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[118]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_87),
	.D(n_461),
	.R(FE_OFN50_n_0),
	.Q(signed_mag_0_im_mag[118]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[119]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_63),
	.D(n_571),
	.R(FE_OFN50_n_0),
	.Q(signed_mag_0_im_mag[119]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[120]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_63),
	.D(n_568),
	.R(FE_OFN50_n_0),
	.Q(signed_mag_0_im_mag[120]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[121]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_87),
	.D(n_547),
	.R(FE_OFN50_n_0),
	.Q(signed_mag_0_im_mag[121]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[122]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_63),
	.D(n_504),
	.R(FE_OFN50_n_0),
	.Q(signed_mag_0_im_mag[122]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[123]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_87),
	.D(n_548),
	.R(FE_OFN50_n_0),
	.Q(signed_mag_0_im_mag[123]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[124]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_63),
	.D(n_460),
	.R(FE_OFN50_n_0),
	.Q(signed_mag_0_im_mag[124]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[125]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_65),
	.D(n_574),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(signed_mag_0_im_mag[125]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[126]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_62),
	.D(n_473),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(signed_mag_0_im_mag[126]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[127]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_63),
	.D(n_573),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(signed_mag_0_im_mag[127]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[128]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_147),
	.D(FE_OFN308_signed_mag_0_abs_im_stage1_7),
	.R(FE_OFN38_n_0),
	.Q(signed_mag_0_im_mag[128]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[129]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_62),
	.D(n_414),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(signed_mag_0_im_mag[129]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[130]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_62),
	.D(n_212),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(signed_mag_0_im_mag[130]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[131]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_62),
	.D(n_352),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(signed_mag_0_im_mag[131]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[132]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_135),
	.D(n_242),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(signed_mag_0_im_mag[132]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[133]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_62),
	.D(n_343),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(signed_mag_0_im_mag[133]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[134]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_62),
	.D(n_230),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(signed_mag_0_im_mag[134]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[135]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_62),
	.D(n_342),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(signed_mag_0_im_mag[135]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[136]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_135),
	.D(n_407),
	.R(FE_OFN380_rst_n),
	.Q(signed_mag_0_im_mag[136]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[137]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_135),
	.D(n_270),
	.R(FE_OFN380_rst_n),
	.Q(signed_mag_0_im_mag[137]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[138]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_137),
	.D(n_326),
	.R(FE_OCPN313_FE_OFN30_n_0),
	.Q(signed_mag_0_im_mag[138]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[139]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_137),
	.D(n_269),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(signed_mag_0_im_mag[139]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[140]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_138),
	.D(n_256),
	.R(FE_OFN33_n_0),
	.Q(signed_mag_0_im_mag[140]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[141]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_137),
	.D(n_351),
	.R(FE_OFN33_n_0),
	.Q(signed_mag_0_im_mag[141]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[142]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_137),
	.D(n_211),
	.R(FE_OFN33_n_0),
	.Q(signed_mag_0_im_mag[142]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[143]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_138),
	.D(n_350),
	.R(FE_OCPN313_FE_OFN30_n_0),
	.Q(signed_mag_0_im_mag[143]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[144]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_139),
	.D(n_143),
	.R(FE_OFN33_n_0),
	.Q(signed_mag_0_im_mag[144]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[145]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_139),
	.D(n_349),
	.R(FE_OCPN313_FE_OFN30_n_0),
	.Q(signed_mag_0_im_mag[145]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[146]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_135),
	.D(n_282),
	.R(FE_OCPN313_FE_OFN30_n_0),
	.Q(signed_mag_0_im_mag[146]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[147]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_139),
	.D(n_264),
	.R(FE_OFN33_n_0),
	.Q(signed_mag_0_im_mag[147]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[148]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_135),
	.D(n_309),
	.R(FE_OCPN313_FE_OFN30_n_0),
	.Q(signed_mag_0_im_mag[148]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[149]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_140),
	.D(n_245),
	.R(FE_OCPN313_FE_OFN30_n_0),
	.Q(signed_mag_0_im_mag[149]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[150]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_140),
	.D(n_306),
	.R(FE_OCPN313_FE_OFN30_n_0),
	.Q(signed_mag_0_im_mag[150]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[151]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_140),
	.D(n_244),
	.R(FE_OCPN313_FE_OFN30_n_0),
	.Q(signed_mag_0_im_mag[151]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[152]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_140),
	.D(n_200),
	.R(FE_OFN38_n_0),
	.Q(signed_mag_0_im_mag[152]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[153]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_143),
	.D(n_167),
	.R(FE_OFN38_n_0),
	.Q(signed_mag_0_im_mag[153]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[154]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_140),
	.D(n_362),
	.R(FE_OFN38_n_0),
	.Q(signed_mag_0_im_mag[154]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[155]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_140),
	.D(n_168),
	.R(FE_OFN38_n_0),
	.Q(signed_mag_0_im_mag[155]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[156]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_147),
	.D(n_317),
	.R(FE_OFN57_n_0),
	.Q(signed_mag_0_im_mag[156]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[157]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_143),
	.D(n_266),
	.R(FE_OFN38_n_0),
	.Q(signed_mag_0_im_mag[157]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[158]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_143),
	.D(n_283),
	.R(FE_OFN38_n_0),
	.Q(signed_mag_0_im_mag[158]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[159]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_147),
	.D(n_262),
	.R(FE_OFN57_n_0),
	.Q(signed_mag_0_im_mag[159]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[160]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_122),
	.D(n_145),
	.R(FE_OFN57_n_0),
	.Q(signed_mag_0_im_mag[160]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[161]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_147),
	.D(n_347),
	.R(FE_OFN38_n_0),
	.Q(signed_mag_0_im_mag[161]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[162]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_147),
	.D(n_273),
	.R(FE_OFN57_n_0),
	.Q(signed_mag_0_im_mag[162]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[163]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_147),
	.D(n_252),
	.R(FE_OFN57_n_0),
	.Q(signed_mag_0_im_mag[163]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[164]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_128),
	.D(n_308),
	.R(FE_OFN57_n_0),
	.Q(signed_mag_0_im_mag[164]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[165]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_147),
	.D(n_235),
	.R(FE_OFN57_n_0),
	.Q(signed_mag_0_im_mag[165]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[166]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_121),
	.D(n_304),
	.R(FE_OFN57_n_0),
	.Q(signed_mag_0_im_mag[166]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[167]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_187),
	.D(n_234),
	.R(FE_OFN57_n_0),
	.Q(signed_mag_0_im_mag[167]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[168]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_128),
	.D(n_195),
	.R(FE_OFN57_n_0),
	.Q(signed_mag_0_im_mag[168]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[169]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_128),
	.D(n_163),
	.R(FE_OFN57_n_0),
	.Q(signed_mag_0_im_mag[169]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[170]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_128),
	.D(n_361),
	.R(FE_OFN57_n_0),
	.Q(signed_mag_0_im_mag[170]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[171]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_128),
	.D(n_166),
	.R(FE_OFN57_n_0),
	.Q(signed_mag_0_im_mag[171]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[172]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_128),
	.D(n_314),
	.R(FE_OFN57_n_0),
	.Q(signed_mag_0_im_mag[172]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[173]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_128),
	.D(n_250),
	.R(FE_OFN372_rst_n),
	.Q(signed_mag_0_im_mag[173]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[174]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_187),
	.D(n_279),
	.R(FE_OFN372_rst_n),
	.Q(signed_mag_0_im_mag[174]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[175]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_128),
	.D(n_249),
	.R(FE_OFN372_rst_n),
	.Q(signed_mag_0_im_mag[175]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[176]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_120),
	.D(n_133),
	.R(FE_OFN372_rst_n),
	.Q(signed_mag_0_im_mag[176]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[177]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_192),
	.D(n_173),
	.R(FE_OFN372_rst_n),
	.Q(signed_mag_0_im_mag[177]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[178]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_193),
	.D(n_225),
	.R(FE_OFN372_rst_n),
	.Q(signed_mag_0_im_mag[178]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[179]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_192),
	.D(n_387),
	.R(FE_OFN372_rst_n),
	.Q(signed_mag_0_im_mag[179]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[180]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_192),
	.D(n_197),
	.R(FE_OFN372_rst_n),
	.Q(signed_mag_0_im_mag[180]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[181]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_192),
	.D(n_380),
	.R(FE_OFN372_rst_n),
	.Q(signed_mag_0_im_mag[181]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[182]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_192),
	.D(n_203),
	.R(FE_OFN372_rst_n),
	.Q(signed_mag_0_im_mag[182]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[183]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_192),
	.D(n_379),
	.R(FE_OFN372_rst_n),
	.Q(signed_mag_0_im_mag[183]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[184]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_193),
	.D(n_366),
	.R(FE_OFN377_rst_n),
	.Q(signed_mag_0_im_mag[184]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[185]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_193),
	.D(n_332),
	.R(FE_OFN372_rst_n),
	.Q(signed_mag_0_im_mag[185]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[186]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_183),
	.D(n_187),
	.R(FE_RN_1),
	.Q(signed_mag_0_im_mag[186]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[187]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_190),
	.D(n_331),
	.R(FE_RN_1),
	.Q(signed_mag_0_im_mag[187]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[188]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_183),
	.D(n_188),
	.R(FE_RN_1),
	.Q(signed_mag_0_im_mag[188]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[189]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_183),
	.D(n_386),
	.R(FE_OFN377_rst_n),
	.Q(signed_mag_0_im_mag[189]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[190]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_183),
	.D(n_222),
	.R(FE_OFN377_rst_n),
	.Q(signed_mag_0_im_mag[190]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[191]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_183),
	.D(n_385),
	.R(FE_OFN377_rst_n),
	.Q(signed_mag_0_im_mag[191]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[192]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_190),
	.D(n_142),
	.R(FE_RN_1),
	.Q(signed_mag_0_im_mag[192]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[193]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_183),
	.D(n_359),
	.R(FE_RN_1),
	.Q(signed_mag_0_im_mag[193]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[194]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_190),
	.D(n_300),
	.R(FE_RN_1),
	.Q(signed_mag_0_im_mag[194]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[195]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_190),
	.D(n_277),
	.R(FE_RN_1),
	.Q(signed_mag_0_im_mag[195]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[196]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_186),
	.D(n_431),
	.R(FE_RN_1),
	.Q(signed_mag_0_im_mag[196]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[197]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_190),
	.D(n_259),
	.R(FE_OCPN1081_FE_OFN374_rst_n),
	.Q(signed_mag_0_im_mag[197]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[198]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_190),
	.D(n_432),
	.R(FE_OCPN1081_FE_OFN374_rst_n),
	.Q(signed_mag_0_im_mag[198]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[199]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_206),
	.D(n_260),
	.R(FE_OCPN1081_FE_OFN374_rst_n),
	.Q(signed_mag_0_im_mag[199]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[200]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_186),
	.D(n_207),
	.R(FE_RN_1),
	.Q(signed_mag_0_im_mag[200]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[201]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_206),
	.D(n_178),
	.R(FE_OCPN1080_FE_OFN374_rst_n),
	.Q(signed_mag_0_im_mag[201]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[202]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_206),
	.D(n_368),
	.R(FE_OCPN1081_FE_OFN374_rst_n),
	.Q(signed_mag_0_im_mag[202]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[203]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_206),
	.D(n_179),
	.R(FE_OCPN1080_FE_OFN374_rst_n),
	.Q(signed_mag_0_im_mag[203]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[204]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_206),
	.D(n_341),
	.R(FE_OCPN1080_FE_OFN374_rst_n),
	.Q(signed_mag_0_im_mag[204]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[205]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_206),
	.D(n_276),
	.R(FE_OCPN1080_FE_OFN374_rst_n),
	.Q(signed_mag_0_im_mag[205]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[206]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_185),
	.D(n_302),
	.R(FE_OFN375_rst_n),
	.Q(signed_mag_0_im_mag[206]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[207]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_205),
	.D(n_275),
	.R(FE_OCPN1080_FE_OFN374_rst_n),
	.Q(signed_mag_0_im_mag[207]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[208]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_185),
	.D(n_443),
	.R(FE_OCPN1081_FE_OFN374_rst_n),
	.Q(signed_mag_0_im_mag[208]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[209]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_185),
	.D(n_453),
	.R(FE_OCPN1081_FE_OFN374_rst_n),
	.Q(signed_mag_0_im_mag[209]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[210]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_185),
	.D(n_493),
	.R(FE_OCPN1081_FE_OFN374_rst_n),
	.Q(signed_mag_0_im_mag[210]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[211]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_185),
	.D(n_583),
	.R(FE_OCPN1081_FE_OFN374_rst_n),
	.Q(signed_mag_0_im_mag[211]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[212]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_205),
	.D(n_472),
	.R(FE_OFN66_n_0),
	.Q(signed_mag_0_im_mag[212]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[213]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_205),
	.D(n_581),
	.R(FE_OFN66_n_0),
	.Q(signed_mag_0_im_mag[213]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[214]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_205),
	.D(n_477),
	.R(FE_OFN66_n_0),
	.Q(signed_mag_0_im_mag[214]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[215]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_205),
	.D(n_582),
	.R(FE_OFN66_n_0),
	.Q(signed_mag_0_im_mag[215]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[216]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_165),
	.D(n_570),
	.R(FE_OFN66_n_0),
	.Q(signed_mag_0_im_mag[216]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[217]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_161),
	.D(n_563),
	.R(FE_OFN66_n_0),
	.Q(signed_mag_0_im_mag[217]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[218]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_161),
	.D(n_463),
	.R(FE_OFN66_n_0),
	.Q(signed_mag_0_im_mag[218]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[219]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_165),
	.D(n_564),
	.R(FE_OFN66_n_0),
	.Q(signed_mag_0_im_mag[219]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[220]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_165),
	.D(n_469),
	.R(FE_OFN66_n_0),
	.Q(signed_mag_0_im_mag[220]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[221]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_165),
	.D(n_585),
	.R(FE_OFN66_n_0),
	.Q(signed_mag_0_im_mag[221]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[222]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_165),
	.D(n_491),
	.R(FE_OFN66_n_0),
	.Q(signed_mag_0_im_mag[222]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[223]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_165),
	.D(n_584),
	.R(FE_OFN66_n_0),
	.Q(signed_mag_0_im_mag[223]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[224]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_174),
	.D(n_439),
	.R(FE_OFN73_n_0),
	.Q(signed_mag_0_im_mag[224]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[225]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_161),
	.D(n_458),
	.R(FE_OFN66_n_0),
	.Q(signed_mag_0_im_mag[225]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[226]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_163),
	.D(n_486),
	.R(FE_OFN66_n_0),
	.Q(signed_mag_0_im_mag[226]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[227]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_161),
	.D(n_580),
	.R(FE_RN_5),
	.Q(signed_mag_0_im_mag[227]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[228]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_161),
	.D(n_464),
	.R(FE_RN_5),
	.Q(signed_mag_0_im_mag[228]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[229]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_161),
	.D(n_577),
	.R(FE_RN_5),
	.Q(signed_mag_0_im_mag[229]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[230]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_161),
	.D(n_470),
	.R(FE_RN_5),
	.Q(signed_mag_0_im_mag[230]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[231]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_156),
	.D(n_576),
	.R(FE_OFN73_n_0),
	.Q(signed_mag_0_im_mag[231]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[232]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_156),
	.D(n_569),
	.R(FE_OFN73_n_0),
	.Q(signed_mag_0_im_mag[232]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[233]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_156),
	.D(n_553),
	.R(FE_OFN73_n_0),
	.Q(signed_mag_0_im_mag[233]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[234]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_180),
	.D(n_471),
	.R(FE_OFN73_n_0),
	.Q(signed_mag_0_im_mag[234]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[235]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_180),
	.D(n_552),
	.R(FE_RN_5),
	.Q(signed_mag_0_im_mag[235]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[236]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_179),
	.D(n_459),
	.R(FE_OFN483_n),
	.Q(signed_mag_0_im_mag[236]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[237]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_156),
	.D(n_579),
	.R(FE_RN_5),
	.Q(signed_mag_0_im_mag[237]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[238]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_179),
	.D(n_484),
	.R(FE_OFN483_n),
	.Q(signed_mag_0_im_mag[238]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[239]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_179),
	.D(n_578),
	.R(FE_OFN487_n),
	.Q(signed_mag_0_im_mag[239]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[240]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_170),
	.D(n_445),
	.R(FE_OFN487_n),
	.Q(signed_mag_0_im_mag[240]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[241]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_163),
	.D(n_602),
	.R(FE_OFN73_n_0),
	.Q(signed_mag_0_im_mag[241]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[242]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_155),
	.D(n_588),
	.R(FE_OFN73_n_0),
	.Q(signed_mag_0_im_mag[242]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[243]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_163),
	.D(n_615),
	.R(FE_OFN1180_FE_OCPN986_n),
	.Q(signed_mag_0_im_mag[243]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[244]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_155),
	.D(n_594),
	.R(FE_OFN73_n_0),
	.Q(signed_mag_0_im_mag[244]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[245]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_155),
	.D(n_611),
	.R(FE_OFN73_n_0),
	.Q(signed_mag_0_im_mag[245]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[246]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_156),
	.D(n_592),
	.R(FE_OFN73_n_0),
	.Q(signed_mag_0_im_mag[246]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[247]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_176),
	.D(n_612),
	.R(FE_RN_4),
	.Q(signed_mag_0_im_mag[247]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[248]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_179),
	.D(n_608),
	.R(FE_OFN487_n),
	.Q(signed_mag_0_im_mag[248]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[249]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_179),
	.D(n_599),
	.R(FE_OFN487_n),
	.Q(signed_mag_0_im_mag[249]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[250]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_179),
	.D(n_609),
	.R(FE_OFN487_n),
	.Q(signed_mag_0_im_mag[250]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[251]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_176),
	.D(n_598),
	.R(FE_OFN487_n),
	.Q(signed_mag_0_im_mag[251]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[252]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_170),
	.D(n_597),
	.R(FE_OFN487_n),
	.Q(signed_mag_0_im_mag[252]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[253]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_170),
	.D(n_614),
	.R(FE_OFN487_n),
	.Q(signed_mag_0_im_mag[253]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[254]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_170),
	.D(n_589),
	.R(FE_OFN487_n),
	.Q(signed_mag_0_im_mag[254]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_b2u_8to255_quad_0_qOut_reg[255]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_173),
	.D(n_613),
	.R(FE_OFN487_n),
	.Q(signed_mag_0_im_mag[255]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[1]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_11),
	.D(signed_mag_0_im_mag[1]),
	.R(FE_OFN75_n_0),
	.Q(mag_im[1]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[2]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_11),
	.D(signed_mag_0_im_mag[2]),
	.R(FE_OFN75_n_0),
	.Q(mag_im[2]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[3]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_11),
	.D(signed_mag_0_im_mag[3]),
	.R(FE_OFN75_n_0),
	.Q(mag_im[3]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[4]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_11),
	.D(signed_mag_0_im_mag[4]),
	.R(FE_OFN75_n_0),
	.Q(mag_im[4]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[5]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_1),
	.D(signed_mag_0_im_mag[5]),
	.R(FE_OFN75_n_0),
	.Q(mag_im[5]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[6]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_14),
	.D(signed_mag_0_im_mag[6]),
	.R(FE_OFN75_n_0),
	.Q(mag_im[6]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[7]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_14),
	.D(signed_mag_0_im_mag[7]),
	.R(FE_OFN75_n_0),
	.Q(mag_im[7]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[8]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_1),
	.D(signed_mag_0_im_mag[8]),
	.R(FE_OFN318_FE_OCPN174_n),
	.Q(mag_im[8]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[9]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_1),
	.D(signed_mag_0_im_mag[9]),
	.R(FE_OFN75_n_0),
	.Q(mag_im[9]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[10]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_5),
	.D(signed_mag_0_im_mag[10]),
	.R(FE_OFN75_n_0),
	.Q(mag_im[10]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[11]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_4),
	.D(signed_mag_0_im_mag[11]),
	.R(FE_OFN75_n_0),
	.Q(mag_im[11]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[12]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_5),
	.D(signed_mag_0_im_mag[12]),
	.R(FE_OFN75_n_0),
	.Q(mag_im[12]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[13]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_28),
	.D(signed_mag_0_im_mag[13]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_im[13]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[14]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_6),
	.D(signed_mag_0_im_mag[14]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_im[14]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[15]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_29),
	.D(signed_mag_0_im_mag[15]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_im[15]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[16]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_13),
	.D(signed_mag_0_im_mag[16]),
	.R(FE_OFN75_n_0),
	.Q(mag_im[16]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[17]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_13),
	.D(signed_mag_0_im_mag[17]),
	.R(FE_OFN75_n_0),
	.Q(mag_im[17]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[18]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_4),
	.D(signed_mag_0_im_mag[18]),
	.R(FE_OFN75_n_0),
	.Q(mag_im[18]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[19]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_14),
	.D(signed_mag_0_im_mag[19]),
	.R(FE_OFN75_n_0),
	.Q(mag_im[19]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[20]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_4),
	.D(signed_mag_0_im_mag[20]),
	.R(FE_OFN75_n_0),
	.Q(mag_im[20]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[21]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_8),
	.D(signed_mag_0_im_mag[21]),
	.R(FE_OFN75_n_0),
	.Q(mag_im[21]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[22]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_4),
	.D(signed_mag_0_im_mag[22]),
	.R(FE_OFN75_n_0),
	.Q(mag_im[22]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[23]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_5),
	.D(signed_mag_0_im_mag[23]),
	.R(FE_OFN75_n_0),
	.Q(mag_im[23]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[24]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_8),
	.D(signed_mag_0_im_mag[24]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_im[24]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[25]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_5),
	.D(signed_mag_0_im_mag[25]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_im[25]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[26]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_6),
	.D(signed_mag_0_im_mag[26]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_im[26]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[27]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_29),
	.D(signed_mag_0_im_mag[27]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_im[27]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[28]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_29),
	.D(signed_mag_0_im_mag[28]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_im[28]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[29]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_29),
	.D(signed_mag_0_im_mag[29]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_im[29]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[30]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_29),
	.D(signed_mag_0_im_mag[30]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_im[30]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[31]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_22),
	.D(signed_mag_0_im_mag[31]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_im[31]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[32]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_22),
	.D(signed_mag_0_im_mag[32]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_im[32]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[33]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_22),
	.D(signed_mag_0_im_mag[33]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_im[33]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[34]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_21),
	.D(signed_mag_0_im_mag[34]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_im[34]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[35]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_22),
	.D(signed_mag_0_im_mag[35]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_im[35]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[36]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_17),
	.D(signed_mag_0_im_mag[36]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_im[36]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[37]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_22),
	.D(signed_mag_0_im_mag[37]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_im[37]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[38]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_22),
	.D(signed_mag_0_im_mag[38]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_im[38]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[39]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_21),
	.D(signed_mag_0_im_mag[39]),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(mag_im[39]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[40]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_16),
	.D(signed_mag_0_im_mag[40]),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(mag_im[40]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[41]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_16),
	.D(signed_mag_0_im_mag[41]),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(mag_im[41]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[42]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_16),
	.D(signed_mag_0_im_mag[42]),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(mag_im[42]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[43]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_16),
	.D(signed_mag_0_im_mag[43]),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(mag_im[43]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[44]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_16),
	.D(signed_mag_0_im_mag[44]),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(mag_im[44]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[45]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_16),
	.D(signed_mag_0_im_mag[45]),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(mag_im[45]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[46]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_41),
	.D(signed_mag_0_im_mag[46]),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(mag_im[46]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[47]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_41),
	.D(signed_mag_0_im_mag[47]),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(mag_im[47]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[48]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_41),
	.D(signed_mag_0_im_mag[48]),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(mag_im[48]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[49]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_19),
	.D(signed_mag_0_im_mag[49]),
	.R(FE_OFN77_n_0),
	.Q(mag_im[49]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[50]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_41),
	.D(signed_mag_0_im_mag[50]),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(mag_im[50]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[51]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_41),
	.D(signed_mag_0_im_mag[51]),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(mag_im[51]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[52]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_44),
	.D(signed_mag_0_im_mag[52]),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(mag_im[52]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[53]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_43),
	.D(signed_mag_0_im_mag[53]),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(mag_im[53]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[54]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_43),
	.D(signed_mag_0_im_mag[54]),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(mag_im[54]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[55]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_43),
	.D(signed_mag_0_im_mag[55]),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(mag_im[55]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[56]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_37),
	.D(signed_mag_0_im_mag[56]),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(mag_im[56]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[57]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_46),
	.D(signed_mag_0_im_mag[57]),
	.R(FE_OFN77_n_0),
	.Q(mag_im[57]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[58]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_43),
	.D(signed_mag_0_im_mag[58]),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(mag_im[58]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[59]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_43),
	.D(signed_mag_0_im_mag[59]),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(mag_im[59]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[60]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_44),
	.D(signed_mag_0_im_mag[60]),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(mag_im[60]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[61]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_43),
	.D(signed_mag_0_im_mag[61]),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(mag_im[61]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[62]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_43),
	.D(signed_mag_0_im_mag[62]),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(mag_im[62]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[63]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_43),
	.D(signed_mag_0_im_mag[63]),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(mag_im[63]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[64]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_78),
	.D(signed_mag_0_im_mag[64]),
	.R(FE_OFN79_n_0),
	.Q(mag_im[64]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[65]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_43),
	.D(signed_mag_0_im_mag[65]),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(mag_im[65]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[66]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_44),
	.D(signed_mag_0_im_mag[66]),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(mag_im[66]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[67]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_36),
	.D(signed_mag_0_im_mag[67]),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(mag_im[67]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[68]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_49),
	.D(signed_mag_0_im_mag[68]),
	.R(FE_OFN779_n),
	.Q(mag_im[68]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[69]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_37),
	.D(signed_mag_0_im_mag[69]),
	.R(FE_OFN1182_n),
	.Q(mag_im[69]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[70]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_50),
	.D(signed_mag_0_im_mag[70]),
	.R(FE_OCPN128_FE_OFN1182_n),
	.Q(mag_im[70]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[71]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_50),
	.D(signed_mag_0_im_mag[71]),
	.R(FE_OCPN128_FE_OFN1182_n),
	.Q(mag_im[71]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[72]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_100),
	.D(signed_mag_0_im_mag[72]),
	.R(FE_RN_2),
	.Q(mag_im[72]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[73]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_32),
	.D(signed_mag_0_im_mag[73]),
	.R(FE_OCPN129_FE_OFN1182_n),
	.Q(mag_im[73]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[74]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_36),
	.D(signed_mag_0_im_mag[74]),
	.R(FE_OCPN129_FE_OFN1182_n),
	.Q(mag_im[74]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[75]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_32),
	.D(signed_mag_0_im_mag[75]),
	.R(FE_OCPN129_FE_OFN1182_n),
	.Q(mag_im[75]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[76]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_40),
	.D(signed_mag_0_im_mag[76]),
	.R(FE_RN_2),
	.Q(mag_im[76]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[77]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_40),
	.D(signed_mag_0_im_mag[77]),
	.R(FE_OCPN129_FE_OFN1182_n),
	.Q(mag_im[77]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[78]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_36),
	.D(signed_mag_0_im_mag[78]),
	.R(FE_OCPN129_FE_OFN1182_n),
	.Q(mag_im[78]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[79]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_40),
	.D(signed_mag_0_im_mag[79]),
	.R(FE_OCPN129_FE_OFN1182_n),
	.Q(mag_im[79]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[80]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_32),
	.D(signed_mag_0_im_mag[80]),
	.R(FE_OCPN129_FE_OFN1182_n),
	.Q(mag_im[80]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[81]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_35),
	.D(signed_mag_0_im_mag[81]),
	.R(FE_RN_2),
	.Q(mag_im[81]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[82]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_79),
	.D(signed_mag_0_im_mag[82]),
	.R(FE_RN_2),
	.Q(mag_im[82]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[83]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_79),
	.D(signed_mag_0_im_mag[83]),
	.R(FE_RN_2),
	.Q(mag_im[83]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[84]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_78),
	.D(signed_mag_0_im_mag[84]),
	.R(FE_OFN79_n_0),
	.Q(mag_im[84]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[85]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_79),
	.D(signed_mag_0_im_mag[85]),
	.R(FE_OFN79_n_0),
	.Q(mag_im[85]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[86]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_79),
	.D(signed_mag_0_im_mag[86]),
	.R(FE_RN_2),
	.Q(mag_im[86]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[87]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_78),
	.D(signed_mag_0_im_mag[87]),
	.R(FE_OFN79_n_0),
	.Q(mag_im[87]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[88]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_78),
	.D(signed_mag_0_im_mag[88]),
	.R(FE_OFN79_n_0),
	.Q(mag_im[88]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[89]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_78),
	.D(signed_mag_0_im_mag[89]),
	.R(FE_OFN79_n_0),
	.Q(mag_im[89]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[90]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_34),
	.D(signed_mag_0_im_mag[90]),
	.R(FE_OFN56_n_0),
	.Q(mag_im[90]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[91]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_71),
	.D(signed_mag_0_im_mag[91]),
	.R(FE_OFN56_n_0),
	.Q(mag_im[91]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[92]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_69),
	.D(signed_mag_0_im_mag[92]),
	.R(FE_OFN56_n_0),
	.Q(mag_im[92]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[93]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_69),
	.D(signed_mag_0_im_mag[93]),
	.R(FE_OFN56_n_0),
	.Q(mag_im[93]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[94]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_69),
	.D(signed_mag_0_im_mag[94]),
	.R(FE_OFN56_n_0),
	.Q(mag_im[94]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[95]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_69),
	.D(signed_mag_0_im_mag[95]),
	.R(FE_OFN56_n_0),
	.Q(mag_im[95]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[96]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_72),
	.D(signed_mag_0_im_mag[96]),
	.R(FE_OFN64_n_0),
	.Q(mag_im[96]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[97]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_75),
	.D(signed_mag_0_im_mag[97]),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(mag_im[97]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[98]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_75),
	.D(signed_mag_0_im_mag[98]),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(mag_im[98]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[99]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_71),
	.D(signed_mag_0_im_mag[99]),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(mag_im[99]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[100]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_75),
	.D(signed_mag_0_im_mag[100]),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(mag_im[100]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[101]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_75),
	.D(signed_mag_0_im_mag[101]),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(mag_im[101]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[102]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_75),
	.D(signed_mag_0_im_mag[102]),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(mag_im[102]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[103]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_75),
	.D(signed_mag_0_im_mag[103]),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(mag_im[103]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[104]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_74),
	.D(signed_mag_0_im_mag[104]),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(mag_im[104]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[105]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_74),
	.D(signed_mag_0_im_mag[105]),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(mag_im[105]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[106]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_84),
	.D(signed_mag_0_im_mag[106]),
	.R(FE_OFN50_n_0),
	.Q(mag_im[106]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[107]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_86),
	.D(signed_mag_0_im_mag[107]),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(mag_im[107]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[108]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_84),
	.D(signed_mag_0_im_mag[108]),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(mag_im[108]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[109]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_84),
	.D(signed_mag_0_im_mag[109]),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(mag_im[109]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[110]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_84),
	.D(signed_mag_0_im_mag[110]),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(mag_im[110]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[111]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_88),
	.D(signed_mag_0_im_mag[111]),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(mag_im[111]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[112]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_86),
	.D(signed_mag_0_im_mag[112]),
	.R(FE_OCPN1217_n),
	.Q(mag_im[112]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[113]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_88),
	.D(signed_mag_0_im_mag[113]),
	.R(FE_OFN50_n_0),
	.Q(mag_im[113]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[114]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_84),
	.D(signed_mag_0_im_mag[114]),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(mag_im[114]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[115]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_84),
	.D(signed_mag_0_im_mag[115]),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(mag_im[115]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[116]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_87),
	.D(signed_mag_0_im_mag[116]),
	.R(FE_OFN50_n_0),
	.Q(mag_im[116]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[117]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_87),
	.D(signed_mag_0_im_mag[117]),
	.R(FE_OFN50_n_0),
	.Q(mag_im[117]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[118]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_87),
	.D(signed_mag_0_im_mag[118]),
	.R(FE_OFN50_n_0),
	.Q(mag_im[118]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[119]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_63),
	.D(signed_mag_0_im_mag[119]),
	.R(FE_OFN50_n_0),
	.Q(mag_im[119]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[120]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_63),
	.D(signed_mag_0_im_mag[120]),
	.R(FE_OFN50_n_0),
	.Q(mag_im[120]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[121]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_87),
	.D(signed_mag_0_im_mag[121]),
	.R(FE_OFN50_n_0),
	.Q(mag_im[121]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[122]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_66),
	.D(signed_mag_0_im_mag[122]),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(mag_im[122]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[123]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_63),
	.D(signed_mag_0_im_mag[123]),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(mag_im[123]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[124]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_66),
	.D(signed_mag_0_im_mag[124]),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(mag_im[124]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[125]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_66),
	.D(signed_mag_0_im_mag[125]),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(mag_im[125]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[126]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_66),
	.D(signed_mag_0_im_mag[126]),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(mag_im[126]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[127]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_66),
	.D(signed_mag_0_im_mag[127]),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(mag_im[127]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[128]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_139),
	.D(signed_mag_0_im_mag[128]),
	.R(FE_OFN33_n_0),
	.Q(mag_im[128]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[129]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_62),
	.D(signed_mag_0_im_mag[129]),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(mag_im[129]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[130]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_65),
	.D(signed_mag_0_im_mag[130]),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(mag_im[130]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[131]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_65),
	.D(signed_mag_0_im_mag[131]),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(mag_im[131]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[132]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_62),
	.D(signed_mag_0_im_mag[132]),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(mag_im[132]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[133]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_62),
	.D(signed_mag_0_im_mag[133]),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(mag_im[133]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[134]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_137),
	.D(signed_mag_0_im_mag[134]),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(mag_im[134]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[135]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_137),
	.D(signed_mag_0_im_mag[135]),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(mag_im[135]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[136]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_135),
	.D(signed_mag_0_im_mag[136]),
	.R(FE_OFN380_rst_n),
	.Q(mag_im[136]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[137]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_135),
	.D(signed_mag_0_im_mag[137]),
	.R(FE_OFN380_rst_n),
	.Q(mag_im[137]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[138]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_138),
	.D(signed_mag_0_im_mag[138]),
	.R(FE_OCPN313_FE_OFN30_n_0),
	.Q(mag_im[138]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[139]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_65),
	.D(signed_mag_0_im_mag[139]),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(mag_im[139]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[140]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_137),
	.D(signed_mag_0_im_mag[140]),
	.R(FE_OFN33_n_0),
	.Q(mag_im[140]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[141]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_138),
	.D(signed_mag_0_im_mag[141]),
	.R(FE_OCPN313_FE_OFN30_n_0),
	.Q(mag_im[141]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[142]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_138),
	.D(signed_mag_0_im_mag[142]),
	.R(FE_OFN33_n_0),
	.Q(mag_im[142]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[143]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_138),
	.D(signed_mag_0_im_mag[143]),
	.R(FE_OFN33_n_0),
	.Q(mag_im[143]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[144]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_138),
	.D(signed_mag_0_im_mag[144]),
	.R(FE_OFN33_n_0),
	.Q(mag_im[144]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[145]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_139),
	.D(signed_mag_0_im_mag[145]),
	.R(FE_OFN33_n_0),
	.Q(mag_im[145]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[146]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_139),
	.D(signed_mag_0_im_mag[146]),
	.R(FE_OCPN313_FE_OFN30_n_0),
	.Q(mag_im[146]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[147]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_139),
	.D(signed_mag_0_im_mag[147]),
	.R(FE_OFN33_n_0),
	.Q(mag_im[147]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[148]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_138),
	.D(signed_mag_0_im_mag[148]),
	.R(FE_OCPN313_FE_OFN30_n_0),
	.Q(mag_im[148]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[149]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_130),
	.D(signed_mag_0_im_mag[149]),
	.R(FE_OFN33_n_0),
	.Q(mag_im[149]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[150]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_139),
	.D(signed_mag_0_im_mag[150]),
	.R(FE_OFN33_n_0),
	.Q(mag_im[150]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[151]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_139),
	.D(signed_mag_0_im_mag[151]),
	.R(FE_OFN33_n_0),
	.Q(mag_im[151]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[152]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_143),
	.D(signed_mag_0_im_mag[152]),
	.R(FE_OFN38_n_0),
	.Q(mag_im[152]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[153]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_143),
	.D(signed_mag_0_im_mag[153]),
	.R(FE_OFN38_n_0),
	.Q(mag_im[153]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[154]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_143),
	.D(signed_mag_0_im_mag[154]),
	.R(FE_OFN57_n_0),
	.Q(mag_im[154]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[155]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_143),
	.D(signed_mag_0_im_mag[155]),
	.R(FE_OFN57_n_0),
	.Q(mag_im[155]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[156]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_122),
	.D(signed_mag_0_im_mag[156]),
	.R(FE_OFN57_n_0),
	.Q(mag_im[156]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[157]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_143),
	.D(signed_mag_0_im_mag[157]),
	.R(FE_OFN57_n_0),
	.Q(mag_im[157]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[158]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_122),
	.D(signed_mag_0_im_mag[158]),
	.R(FE_OFN57_n_0),
	.Q(mag_im[158]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[159]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_122),
	.D(signed_mag_0_im_mag[159]),
	.R(FE_OFN57_n_0),
	.Q(mag_im[159]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[160]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_121),
	.D(signed_mag_0_im_mag[160]),
	.R(FE_OFN492_n),
	.Q(mag_im[160]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[161]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_147),
	.D(signed_mag_0_im_mag[161]),
	.R(FE_OFN38_n_0),
	.Q(mag_im[161]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[162]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_122),
	.D(signed_mag_0_im_mag[162]),
	.R(FE_OFN57_n_0),
	.Q(mag_im[162]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[163]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_122),
	.D(signed_mag_0_im_mag[163]),
	.R(FE_OFN57_n_0),
	.Q(mag_im[163]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[164]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_147),
	.D(signed_mag_0_im_mag[164]),
	.R(FE_OFN57_n_0),
	.Q(mag_im[164]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[165]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_121),
	.D(signed_mag_0_im_mag[165]),
	.R(FE_OFN57_n_0),
	.Q(mag_im[165]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[166]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_121),
	.D(signed_mag_0_im_mag[166]),
	.R(FE_OFN57_n_0),
	.Q(mag_im[166]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[167]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_121),
	.D(signed_mag_0_im_mag[167]),
	.R(FE_OFN57_n_0),
	.Q(mag_im[167]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[168]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_121),
	.D(signed_mag_0_im_mag[168]),
	.R(FE_OFN57_n_0),
	.Q(mag_im[168]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[169]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_121),
	.D(signed_mag_0_im_mag[169]),
	.R(FE_OFN57_n_0),
	.Q(mag_im[169]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[170]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_121),
	.D(signed_mag_0_im_mag[170]),
	.R(FE_OFN57_n_0),
	.Q(mag_im[170]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[171]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_187),
	.D(signed_mag_0_im_mag[171]),
	.R(FE_OFN372_rst_n),
	.Q(mag_im[171]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[172]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_187),
	.D(signed_mag_0_im_mag[172]),
	.R(FE_OFN372_rst_n),
	.Q(mag_im[172]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[173]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_187),
	.D(signed_mag_0_im_mag[173]),
	.R(FE_OFN372_rst_n),
	.Q(mag_im[173]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[174]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_127),
	.D(signed_mag_0_im_mag[174]),
	.R(FE_OFN491_n),
	.Q(mag_im[174]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[175]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_192),
	.D(signed_mag_0_im_mag[175]),
	.R(FE_OFN372_rst_n),
	.Q(mag_im[175]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[176]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_120),
	.D(signed_mag_0_im_mag[176]),
	.R(FE_OFN490_n),
	.Q(mag_im[176]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[177]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_187),
	.D(signed_mag_0_im_mag[177]),
	.R(FE_OFN372_rst_n),
	.Q(mag_im[177]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[178]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_192),
	.D(signed_mag_0_im_mag[178]),
	.R(FE_OFN372_rst_n),
	.Q(mag_im[178]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[179]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_187),
	.D(signed_mag_0_im_mag[179]),
	.R(FE_OFN372_rst_n),
	.Q(mag_im[179]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[180]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_187),
	.D(signed_mag_0_im_mag[180]),
	.R(FE_OFN372_rst_n),
	.Q(mag_im[180]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[181]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_187),
	.D(signed_mag_0_im_mag[181]),
	.R(FE_OFN372_rst_n),
	.Q(mag_im[181]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[182]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_189),
	.D(signed_mag_0_im_mag[182]),
	.R(FE_OFN372_rst_n),
	.Q(mag_im[182]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[183]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_189),
	.D(signed_mag_0_im_mag[183]),
	.R(FE_OFN372_rst_n),
	.Q(mag_im[183]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[184]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_183),
	.D(signed_mag_0_im_mag[184]),
	.R(FE_OFN372_rst_n),
	.Q(mag_im[184]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[185]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_192),
	.D(signed_mag_0_im_mag[185]),
	.R(FE_OFN372_rst_n),
	.Q(mag_im[185]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[186]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_190),
	.D(signed_mag_0_im_mag[186]),
	.R(FE_RN_1),
	.Q(mag_im[186]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[187]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_190),
	.D(signed_mag_0_im_mag[187]),
	.R(FE_RN_1),
	.Q(mag_im[187]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[188]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_183),
	.D(signed_mag_0_im_mag[188]),
	.R(FE_RN_1),
	.Q(mag_im[188]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[189]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_199),
	.D(signed_mag_0_im_mag[189]),
	.R(FE_RN_1),
	.Q(mag_im[189]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[190]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_189),
	.D(signed_mag_0_im_mag[190]),
	.R(FE_RN_1),
	.Q(mag_im[190]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[191]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_189),
	.D(signed_mag_0_im_mag[191]),
	.R(FE_OFN377_rst_n),
	.Q(mag_im[191]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[192]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_183),
	.D(signed_mag_0_im_mag[192]),
	.R(FE_RN_1),
	.Q(mag_im[192]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[193]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_186),
	.D(signed_mag_0_im_mag[193]),
	.R(FE_RN_1),
	.Q(mag_im[193]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[194]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_183),
	.D(signed_mag_0_im_mag[194]),
	.R(FE_RN_1),
	.Q(mag_im[194]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[195]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_189),
	.D(signed_mag_0_im_mag[195]),
	.R(FE_RN_1),
	.Q(mag_im[195]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[196]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_186),
	.D(signed_mag_0_im_mag[196]),
	.R(FE_RN_1),
	.Q(mag_im[196]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[197]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_186),
	.D(signed_mag_0_im_mag[197]),
	.R(FE_RN_1),
	.Q(mag_im[197]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[198]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_186),
	.D(signed_mag_0_im_mag[198]),
	.R(FE_RN_1),
	.Q(mag_im[198]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[199]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_186),
	.D(signed_mag_0_im_mag[199]),
	.R(FE_OCPN1081_FE_OFN374_rst_n),
	.Q(mag_im[199]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[200]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_186),
	.D(signed_mag_0_im_mag[200]),
	.R(FE_OCPN1081_FE_OFN374_rst_n),
	.Q(mag_im[200]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[201]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_185),
	.D(signed_mag_0_im_mag[201]),
	.R(FE_OCPN1081_FE_OFN374_rst_n),
	.Q(mag_im[201]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[202]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_185),
	.D(signed_mag_0_im_mag[202]),
	.R(FE_OCPN1081_FE_OFN374_rst_n),
	.Q(mag_im[202]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[203]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_206),
	.D(signed_mag_0_im_mag[203]),
	.R(FE_OCPN1081_FE_OFN374_rst_n),
	.Q(mag_im[203]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[204]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_205),
	.D(signed_mag_0_im_mag[204]),
	.R(FE_OCPN1081_FE_OFN374_rst_n),
	.Q(mag_im[204]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[205]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_185),
	.D(signed_mag_0_im_mag[205]),
	.R(FE_OCPN1081_FE_OFN374_rst_n),
	.Q(mag_im[205]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[206]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_195),
	.D(signed_mag_0_im_mag[206]),
	.R(FE_OFN375_rst_n),
	.Q(mag_im[206]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[207]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_195),
	.D(signed_mag_0_im_mag[207]),
	.R(FE_OFN375_rst_n),
	.Q(mag_im[207]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[208]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_195),
	.D(signed_mag_0_im_mag[208]),
	.R(FE_OFN375_rst_n),
	.Q(mag_im[208]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[209]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_197),
	.D(signed_mag_0_im_mag[209]),
	.R(FE_OFN375_rst_n),
	.Q(mag_im[209]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[210]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_160),
	.D(signed_mag_0_im_mag[210]),
	.R(FE_OCPN1081_FE_OFN374_rst_n),
	.Q(mag_im[210]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[211]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_160),
	.D(signed_mag_0_im_mag[211]),
	.R(FE_OCPN1081_FE_OFN374_rst_n),
	.Q(mag_im[211]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[212]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_185),
	.D(signed_mag_0_im_mag[212]),
	.R(FE_OFN66_n_0),
	.Q(mag_im[212]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[213]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_205),
	.D(signed_mag_0_im_mag[213]),
	.R(FE_OFN66_n_0),
	.Q(mag_im[213]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[214]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_205),
	.D(signed_mag_0_im_mag[214]),
	.R(FE_OFN66_n_0),
	.Q(mag_im[214]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[215]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_165),
	.D(signed_mag_0_im_mag[215]),
	.R(FE_OFN66_n_0),
	.Q(mag_im[215]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[216]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_165),
	.D(signed_mag_0_im_mag[216]),
	.R(FE_OFN66_n_0),
	.Q(mag_im[216]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[217]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_160),
	.D(signed_mag_0_im_mag[217]),
	.R(FE_OFN66_n_0),
	.Q(mag_im[217]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[218]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_165),
	.D(signed_mag_0_im_mag[218]),
	.R(FE_OFN66_n_0),
	.Q(mag_im[218]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[219]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_160),
	.D(signed_mag_0_im_mag[219]),
	.R(FE_OFN66_n_0),
	.Q(mag_im[219]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[220]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_165),
	.D(signed_mag_0_im_mag[220]),
	.R(FE_OFN66_n_0),
	.Q(mag_im[220]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[221]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_161),
	.D(signed_mag_0_im_mag[221]),
	.R(FE_OFN66_n_0),
	.Q(mag_im[221]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[222]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_160),
	.D(signed_mag_0_im_mag[222]),
	.R(FE_OFN66_n_0),
	.Q(mag_im[222]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[223]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_163),
	.D(signed_mag_0_im_mag[223]),
	.R(FE_OCPN1210_n),
	.Q(mag_im[223]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[224]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_174),
	.D(signed_mag_0_im_mag[224]),
	.R(FE_OFN483_n),
	.Q(mag_im[224]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[225]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_163),
	.D(signed_mag_0_im_mag[225]),
	.R(FE_OCPN1210_n),
	.Q(mag_im[225]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[226]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_163),
	.D(signed_mag_0_im_mag[226]),
	.R(FE_OCPN1210_n),
	.Q(mag_im[226]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[227]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_163),
	.D(signed_mag_0_im_mag[227]),
	.R(FE_OFN1180_FE_OCPN986_n),
	.Q(mag_im[227]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[228]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_161),
	.D(signed_mag_0_im_mag[228]),
	.R(FE_RN_5),
	.Q(mag_im[228]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[229]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_156),
	.D(signed_mag_0_im_mag[229]),
	.R(FE_RN_5),
	.Q(mag_im[229]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[230]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_156),
	.D(signed_mag_0_im_mag[230]),
	.R(FE_RN_5),
	.Q(mag_im[230]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[231]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_155),
	.D(signed_mag_0_im_mag[231]),
	.R(FE_OFN73_n_0),
	.Q(mag_im[231]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[232]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_155),
	.D(signed_mag_0_im_mag[232]),
	.R(FE_OFN73_n_0),
	.Q(mag_im[232]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[233]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_174),
	.D(signed_mag_0_im_mag[233]),
	.R(FE_OFN73_n_0),
	.Q(mag_im[233]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[234]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_156),
	.D(signed_mag_0_im_mag[234]),
	.R(FE_OFN73_n_0),
	.Q(mag_im[234]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[235]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_156),
	.D(signed_mag_0_im_mag[235]),
	.R(FE_OFN73_n_0),
	.Q(mag_im[235]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[236]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_174),
	.D(signed_mag_0_im_mag[236]),
	.R(FE_OFN483_n),
	.Q(mag_im[236]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[237]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_174),
	.D(signed_mag_0_im_mag[237]),
	.R(FE_OFN483_n),
	.Q(mag_im[237]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[238]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_176),
	.D(signed_mag_0_im_mag[238]),
	.R(FE_OFN483_n),
	.Q(mag_im[238]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[239]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_179),
	.D(signed_mag_0_im_mag[239]),
	.R(FE_RN_4),
	.Q(mag_im[239]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[240]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_173),
	.D(signed_mag_0_im_mag[240]),
	.R(FE_OFN487_n),
	.Q(mag_im[240]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[241]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_163),
	.D(signed_mag_0_im_mag[241]),
	.R(FE_OFN73_n_0),
	.Q(mag_im[241]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[242]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_155),
	.D(signed_mag_0_im_mag[242]),
	.R(FE_OFN73_n_0),
	.Q(mag_im[242]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[243]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_174),
	.D(signed_mag_0_im_mag[243]),
	.R(FE_OFN483_n),
	.Q(mag_im[243]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[244]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_155),
	.D(signed_mag_0_im_mag[244]),
	.R(FE_RN_4),
	.Q(mag_im[244]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[245]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_179),
	.D(signed_mag_0_im_mag[245]),
	.R(FE_OFN483_n),
	.Q(mag_im[245]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[246]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_179),
	.D(signed_mag_0_im_mag[246]),
	.R(FE_OFN483_n),
	.Q(mag_im[246]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[247]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_176),
	.D(signed_mag_0_im_mag[247]),
	.R(FE_OFN483_n),
	.Q(mag_im[247]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[248]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_179),
	.D(signed_mag_0_im_mag[248]),
	.R(FE_OFN487_n),
	.Q(mag_im[248]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[249]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_170),
	.D(signed_mag_0_im_mag[249]),
	.R(FE_OFN487_n),
	.Q(mag_im[249]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[250]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_170),
	.D(signed_mag_0_im_mag[250]),
	.R(FE_OFN487_n),
	.Q(mag_im[250]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[251]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_176),
	.D(signed_mag_0_im_mag[251]),
	.R(FE_OFN487_n),
	.Q(mag_im[251]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[252]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_170),
	.D(signed_mag_0_im_mag[252]),
	.R(FE_OFN487_n),
	.Q(mag_im[252]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[253]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_170),
	.D(signed_mag_0_im_mag[253]),
	.R(FE_OFN487_n),
	.Q(mag_im[253]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[254]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_172),
	.D(signed_mag_0_im_mag[254]),
	.R(FE_OFN487_n),
	.Q(mag_im[254]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_im_reg[255]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_172),
	.D(signed_mag_0_im_mag[255]),
	.R(FE_OFN487_n),
	.Q(mag_im[255]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[0]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_10),
	.D(signed_mag_0_re_mag[0]),
	.R(FE_OFN75_n_0),
	.Q(mag_re[0]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[1]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_10),
	.D(signed_mag_0_re_mag[1]),
	.R(FE_OFN75_n_0),
	.Q(mag_re[1]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[2]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_10),
	.D(signed_mag_0_re_mag[2]),
	.R(FE_OFN75_n_0),
	.Q(mag_re[2]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[3]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_10),
	.D(signed_mag_0_re_mag[3]),
	.R(FE_OFN75_n_0),
	.Q(mag_re[3]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[4]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_10),
	.D(signed_mag_0_re_mag[4]),
	.R(FE_OFN75_n_0),
	.Q(mag_re[4]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[5]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_10),
	.D(signed_mag_0_re_mag[5]),
	.R(FE_OFN75_n_0),
	.Q(mag_re[5]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[6]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_13),
	.D(signed_mag_0_re_mag[6]),
	.R(FE_OFN75_n_0),
	.Q(mag_re[6]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[7]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_14),
	.D(signed_mag_0_re_mag[7]),
	.R(FE_OFN75_n_0),
	.Q(mag_re[7]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[8]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_13),
	.D(signed_mag_0_re_mag[8]),
	.R(FE_OFN75_n_0),
	.Q(mag_re[8]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[9]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_13),
	.D(signed_mag_0_re_mag[9]),
	.R(FE_OFN75_n_0),
	.Q(mag_re[9]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[10]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_6),
	.D(signed_mag_0_re_mag[10]),
	.R(FE_OFN75_n_0),
	.Q(mag_re[10]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[11]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_13),
	.D(signed_mag_0_re_mag[11]),
	.R(FE_OFN75_n_0),
	.Q(mag_re[11]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[12]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_5),
	.D(signed_mag_0_re_mag[12]),
	.R(FE_OFN75_n_0),
	.Q(mag_re[12]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[13]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_6),
	.D(signed_mag_0_re_mag[13]),
	.R(FE_OFN75_n_0),
	.Q(mag_re[13]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[14]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_6),
	.D(signed_mag_0_re_mag[14]),
	.R(FE_OFN75_n_0),
	.Q(mag_re[14]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[15]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_13),
	.D(signed_mag_0_re_mag[15]),
	.R(FE_OFN75_n_0),
	.Q(mag_re[15]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[16]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_1),
	.D(signed_mag_0_re_mag[16]),
	.R(FE_OFN318_FE_OCPN174_n),
	.Q(mag_re[16]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[17]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_1),
	.D(signed_mag_0_re_mag[17]),
	.R(FE_OFN318_FE_OCPN174_n),
	.Q(mag_re[17]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[18]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_1),
	.D(signed_mag_0_re_mag[18]),
	.R(FE_OFN75_n_0),
	.Q(mag_re[18]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[19]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_3),
	.D(signed_mag_0_re_mag[19]),
	.R(FE_OFN318_FE_OCPN174_n),
	.Q(mag_re[19]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[20]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_4),
	.D(signed_mag_0_re_mag[20]),
	.R(FE_OFN75_n_0),
	.Q(mag_re[20]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[21]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_3),
	.D(signed_mag_0_re_mag[21]),
	.R(FE_OFN318_FE_OCPN174_n),
	.Q(mag_re[21]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[22]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_8),
	.D(signed_mag_0_re_mag[22]),
	.R(FE_OFN318_FE_OCPN174_n),
	.Q(mag_re[22]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[23]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_8),
	.D(signed_mag_0_re_mag[23]),
	.R(FE_OFN318_FE_OCPN174_n),
	.Q(mag_re[23]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[24]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_8),
	.D(signed_mag_0_re_mag[24]),
	.R(FE_OFN318_FE_OCPN174_n),
	.Q(mag_re[24]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[25]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_8),
	.D(signed_mag_0_re_mag[25]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_re[25]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[26]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_5),
	.D(signed_mag_0_re_mag[26]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_re[26]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[27]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_3),
	.D(signed_mag_0_re_mag[27]),
	.R(FE_OFN318_FE_OCPN174_n),
	.Q(mag_re[27]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[28]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_28),
	.D(signed_mag_0_re_mag[28]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_re[28]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[29]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_9),
	.D(signed_mag_0_re_mag[29]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_re[29]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[30]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_24),
	.D(signed_mag_0_re_mag[30]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_re[30]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[31]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_8),
	.D(signed_mag_0_re_mag[31]),
	.R(FE_OFN75_n_0),
	.Q(mag_re[31]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[32]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_24),
	.D(signed_mag_0_re_mag[32]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_re[32]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[33]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_28),
	.D(signed_mag_0_re_mag[33]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_re[33]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[34]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_24),
	.D(signed_mag_0_re_mag[34]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_re[34]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[35]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_24),
	.D(signed_mag_0_re_mag[35]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_re[35]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[36]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_24),
	.D(signed_mag_0_re_mag[36]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_re[36]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[37]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_25),
	.D(signed_mag_0_re_mag[37]),
	.R(FE_OCPN889_FE_OFN49_n_0),
	.Q(mag_re[37]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[38]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_25),
	.D(signed_mag_0_re_mag[38]),
	.R(FE_OFN81_n_0),
	.Q(mag_re[38]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[39]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_25),
	.D(signed_mag_0_re_mag[39]),
	.R(FE_OFN81_n_0),
	.Q(mag_re[39]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[40]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_17),
	.D(signed_mag_0_re_mag[40]),
	.R(FE_OFN81_n_0),
	.Q(mag_re[40]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[41]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_24),
	.D(signed_mag_0_re_mag[41]),
	.R(FE_OFN81_n_0),
	.Q(mag_re[41]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[42]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_17),
	.D(signed_mag_0_re_mag[42]),
	.R(FE_OFN81_n_0),
	.Q(mag_re[42]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[43]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_54),
	.D(signed_mag_0_re_mag[43]),
	.R(FE_OFN81_n_0),
	.Q(mag_re[43]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[44]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_20),
	.D(signed_mag_0_re_mag[44]),
	.R(FE_OFN81_n_0),
	.Q(mag_re[44]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[45]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_54),
	.D(signed_mag_0_re_mag[45]),
	.R(FE_OFN81_n_0),
	.Q(mag_re[45]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[46]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_54),
	.D(signed_mag_0_re_mag[46]),
	.R(FE_OFN81_n_0),
	.Q(mag_re[46]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[47]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_16),
	.D(signed_mag_0_re_mag[47]),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(mag_re[47]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[48]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_20),
	.D(signed_mag_0_re_mag[48]),
	.R(FE_OFN77_n_0),
	.Q(mag_re[48]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[49]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_20),
	.D(signed_mag_0_re_mag[49]),
	.R(FE_OFN5_FE_OCPN1002),
	.Q(mag_re[49]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[50]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_19),
	.D(signed_mag_0_re_mag[50]),
	.R(FE_OFN77_n_0),
	.Q(mag_re[50]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[51]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_20),
	.D(signed_mag_0_re_mag[51]),
	.R(FE_OFN77_n_0),
	.Q(mag_re[51]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[52]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_20),
	.D(signed_mag_0_re_mag[52]),
	.R(FE_OFN77_n_0),
	.Q(mag_re[52]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[53]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_19),
	.D(signed_mag_0_re_mag[53]),
	.R(FE_OFN77_n_0),
	.Q(mag_re[53]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[54]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_47),
	.D(signed_mag_0_re_mag[54]),
	.R(FE_OFN77_n_0),
	.Q(mag_re[54]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[55]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_54),
	.D(signed_mag_0_re_mag[55]),
	.R(FE_OFN76_n_0),
	.Q(mag_re[55]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[56]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_46),
	.D(signed_mag_0_re_mag[56]),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(mag_re[56]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[57]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_19),
	.D(signed_mag_0_re_mag[57]),
	.R(FE_OFN77_n_0),
	.Q(mag_re[57]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[58]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_46),
	.D(signed_mag_0_re_mag[58]),
	.R(FE_OFN779_n),
	.Q(mag_re[58]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[59]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_47),
	.D(signed_mag_0_re_mag[59]),
	.R(FE_OFN779_n),
	.Q(mag_re[59]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[60]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_50),
	.D(signed_mag_0_re_mag[60]),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(mag_re[60]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[61]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_50),
	.D(signed_mag_0_re_mag[61]),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(mag_re[61]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[62]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_50),
	.D(signed_mag_0_re_mag[62]),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(mag_re[62]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[63]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_46),
	.D(signed_mag_0_re_mag[63]),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(mag_re[63]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[64]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_43),
	.D(signed_mag_0_re_mag[64]),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(mag_re[64]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[65]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_36),
	.D(signed_mag_0_re_mag[65]),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(mag_re[65]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[66]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_36),
	.D(signed_mag_0_re_mag[66]),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(mag_re[66]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[67]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_37),
	.D(signed_mag_0_re_mag[67]),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(mag_re[67]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[68]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_50),
	.D(signed_mag_0_re_mag[68]),
	.R(FE_OFN1182_n),
	.Q(mag_re[68]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[69]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_49),
	.D(signed_mag_0_re_mag[69]),
	.R(FE_OFN779_n),
	.Q(mag_re[69]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[70]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_36),
	.D(signed_mag_0_re_mag[70]),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(mag_re[70]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[71]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_49),
	.D(signed_mag_0_re_mag[71]),
	.R(FE_OCPN128_FE_OFN1182_n),
	.Q(mag_re[71]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[72]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_36),
	.D(signed_mag_0_re_mag[72]),
	.R(FE_OCPN130_FE_OFN1182_n),
	.Q(mag_re[72]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[73]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_32),
	.D(signed_mag_0_re_mag[73]),
	.R(FE_OCPN129_FE_OFN1182_n),
	.Q(mag_re[73]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[74]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_39),
	.D(signed_mag_0_re_mag[74]),
	.R(FE_RN_2),
	.Q(mag_re[74]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[75]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_39),
	.D(signed_mag_0_re_mag[75]),
	.R(FE_RN_2),
	.Q(mag_re[75]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[76]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_40),
	.D(signed_mag_0_re_mag[76]),
	.R(FE_RN_2),
	.Q(mag_re[76]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[77]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_39),
	.D(signed_mag_0_re_mag[77]),
	.R(FE_RN_2),
	.Q(mag_re[77]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[78]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_32),
	.D(signed_mag_0_re_mag[78]),
	.R(FE_OCPN129_FE_OFN1182_n),
	.Q(mag_re[78]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[79]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_32),
	.D(signed_mag_0_re_mag[79]),
	.R(FE_OCPN129_FE_OFN1182_n),
	.Q(mag_re[79]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[80]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_35),
	.D(signed_mag_0_re_mag[80]),
	.R(FE_OCPN129_FE_OFN1182_n),
	.Q(mag_re[80]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[81]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_32),
	.D(signed_mag_0_re_mag[81]),
	.R(FE_OCPN129_FE_OFN1182_n),
	.Q(mag_re[81]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[82]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_35),
	.D(signed_mag_0_re_mag[82]),
	.R(FE_OCPN129_FE_OFN1182_n),
	.Q(mag_re[82]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[83]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_35),
	.D(signed_mag_0_re_mag[83]),
	.R(FE_RN_2),
	.Q(mag_re[83]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[84]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_34),
	.D(signed_mag_0_re_mag[84]),
	.R(FE_OFN56_n_0),
	.Q(mag_re[84]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[85]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_34),
	.D(signed_mag_0_re_mag[85]),
	.R(FE_OFN56_n_0),
	.Q(mag_re[85]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[86]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_35),
	.D(signed_mag_0_re_mag[86]),
	.R(FE_OCPN129_FE_OFN1182_n),
	.Q(mag_re[86]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[87]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_35),
	.D(signed_mag_0_re_mag[87]),
	.R(FE_RN_2),
	.Q(mag_re[87]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[88]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_34),
	.D(signed_mag_0_re_mag[88]),
	.R(FE_OFN56_n_0),
	.Q(mag_re[88]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[89]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_68),
	.D(signed_mag_0_re_mag[89]),
	.R(FE_OFN56_n_0),
	.Q(mag_re[89]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[90]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_34),
	.D(signed_mag_0_re_mag[90]),
	.R(FE_OFN56_n_0),
	.Q(mag_re[90]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[91]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_69),
	.D(signed_mag_0_re_mag[91]),
	.R(FE_OFN56_n_0),
	.Q(mag_re[91]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[92]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_34),
	.D(signed_mag_0_re_mag[92]),
	.R(FE_OFN56_n_0),
	.Q(mag_re[92]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[93]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_68),
	.D(signed_mag_0_re_mag[93]),
	.R(FE_OFN56_n_0),
	.Q(mag_re[93]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[94]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_68),
	.D(signed_mag_0_re_mag[94]),
	.R(FE_OFN56_n_0),
	.Q(mag_re[94]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[95]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_68),
	.D(signed_mag_0_re_mag[95]),
	.R(FE_OFN56_n_0),
	.Q(mag_re[95]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[96]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_68),
	.D(signed_mag_0_re_mag[96]),
	.R(FE_OFN64_n_0),
	.Q(mag_re[96]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[97]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_68),
	.D(signed_mag_0_re_mag[97]),
	.R(FE_OFN64_n_0),
	.Q(mag_re[97]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[98]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_68),
	.D(signed_mag_0_re_mag[98]),
	.R(FE_OFN64_n_0),
	.Q(mag_re[98]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[99]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_72),
	.D(signed_mag_0_re_mag[99]),
	.R(FE_OFN64_n_0),
	.Q(mag_re[99]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[100]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_72),
	.D(signed_mag_0_re_mag[100]),
	.R(FE_OFN64_n_0),
	.Q(mag_re[100]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[101]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_72),
	.D(signed_mag_0_re_mag[101]),
	.R(FE_OFN64_n_0),
	.Q(mag_re[101]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[102]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_83),
	.D(signed_mag_0_re_mag[102]),
	.R(FE_OFN64_n_0),
	.Q(mag_re[102]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[103]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_74),
	.D(signed_mag_0_re_mag[103]),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(mag_re[103]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[104]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_83),
	.D(signed_mag_0_re_mag[104]),
	.R(FE_OCPN1103_n),
	.Q(mag_re[104]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[105]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_72),
	.D(signed_mag_0_re_mag[105]),
	.R(FE_OCPN1103_n),
	.Q(mag_re[105]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[106]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_83),
	.D(signed_mag_0_re_mag[106]),
	.R(FE_OCPN1103_n),
	.Q(mag_re[106]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[107]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_83),
	.D(signed_mag_0_re_mag[107]),
	.R(FE_OCPN1103_n),
	.Q(mag_re[107]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[108]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_83),
	.D(signed_mag_0_re_mag[108]),
	.R(FE_OCPN1103_n),
	.Q(mag_re[108]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[109]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_74),
	.D(signed_mag_0_re_mag[109]),
	.R(FE_OCPN1103_n),
	.Q(mag_re[109]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[110]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_83),
	.D(signed_mag_0_re_mag[110]),
	.R(FE_OCPN1103_n),
	.Q(mag_re[110]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[111]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_82),
	.D(signed_mag_0_re_mag[111]),
	.R(FE_OCPN1217_n),
	.Q(mag_re[111]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[112]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_82),
	.D(signed_mag_0_re_mag[112]),
	.R(FE_OCPN1217_n),
	.Q(mag_re[112]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[113]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_82),
	.D(signed_mag_0_re_mag[113]),
	.R(FE_OCPN1217_n),
	.Q(mag_re[113]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[114]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_86),
	.D(signed_mag_0_re_mag[114]),
	.R(FE_OCPN1217_n),
	.Q(mag_re[114]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[115]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_86),
	.D(signed_mag_0_re_mag[115]),
	.R(FE_OCPN1217_n),
	.Q(mag_re[115]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[116]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_82),
	.D(signed_mag_0_re_mag[116]),
	.R(FE_OCPN1217_n),
	.Q(mag_re[116]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[117]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_58),
	.D(signed_mag_0_re_mag[117]),
	.R(FE_OCPN1217_n),
	.Q(mag_re[117]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[118]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_82),
	.D(signed_mag_0_re_mag[118]),
	.R(FE_OCPN1217_n),
	.Q(mag_re[118]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[119]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_66),
	.D(signed_mag_0_re_mag[119]),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(mag_re[119]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[120]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_58),
	.D(signed_mag_0_re_mag[120]),
	.R(FE_OCPN1217_n),
	.Q(mag_re[120]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[121]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_58),
	.D(signed_mag_0_re_mag[121]),
	.R(FE_OCPN1217_n),
	.Q(mag_re[121]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[122]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_58),
	.D(signed_mag_0_re_mag[122]),
	.R(FE_OCPN1217_n),
	.Q(mag_re[122]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[123]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_58),
	.D(signed_mag_0_re_mag[123]),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(mag_re[123]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[124]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_61),
	.D(signed_mag_0_re_mag[124]),
	.R(FE_OCPN1217_n),
	.Q(mag_re[124]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[125]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_61),
	.D(signed_mag_0_re_mag[125]),
	.R(FE_OCPN1217_n),
	.Q(mag_re[125]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[126]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_61),
	.D(signed_mag_0_re_mag[126]),
	.R(FE_OCPN1217_n),
	.Q(mag_re[126]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[127]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_71),
	.D(signed_mag_0_re_mag[127]),
	.R(FE_OFN319_FE_OCPN1007_n),
	.Q(mag_re[127]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[128]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_61),
	.D(signed_mag_0_re_mag[128]),
	.R(FE_OFN31_n_0),
	.Q(mag_re[128]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[129]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_61),
	.D(signed_mag_0_re_mag[129]),
	.R(FE_OFN31_n_0),
	.Q(mag_re[129]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[130]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_60),
	.D(signed_mag_0_re_mag[130]),
	.R(FE_OFN31_n_0),
	.Q(mag_re[130]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[131]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_60),
	.D(signed_mag_0_re_mag[131]),
	.R(FE_OFN31_n_0),
	.Q(mag_re[131]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[132]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_60),
	.D(signed_mag_0_re_mag[132]),
	.R(FE_OFN31_n_0),
	.Q(mag_re[132]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[133]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_60),
	.D(signed_mag_0_re_mag[133]),
	.R(FE_OFN31_n_0),
	.Q(mag_re[133]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[134]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_60),
	.D(signed_mag_0_re_mag[134]),
	.R(FE_OFN31_n_0),
	.Q(mag_re[134]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[135]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_65),
	.D(signed_mag_0_re_mag[135]),
	.R(FE_OCPN888_FE_OFN30_n_0),
	.Q(mag_re[135]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[136]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_60),
	.D(signed_mag_0_re_mag[136]),
	.R(FE_OFN31_n_0),
	.Q(mag_re[136]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[137]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_60),
	.D(signed_mag_0_re_mag[137]),
	.R(FE_OFN31_n_0),
	.Q(mag_re[137]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[138]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_60),
	.D(signed_mag_0_re_mag[138]),
	.R(FE_OFN31_n_0),
	.Q(mag_re[138]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[139]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_137),
	.D(signed_mag_0_re_mag[139]),
	.R(FE_OFN31_n_0),
	.Q(mag_re[139]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[140]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_131),
	.D(signed_mag_0_re_mag[140]),
	.R(FE_OFN31_n_0),
	.Q(mag_re[140]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[141]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_131),
	.D(signed_mag_0_re_mag[141]),
	.R(FE_OFN31_n_0),
	.Q(mag_re[141]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[142]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_137),
	.D(signed_mag_0_re_mag[142]),
	.R(FE_OFN33_n_0),
	.Q(mag_re[142]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[143]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_60),
	.D(signed_mag_0_re_mag[143]),
	.R(FE_OFN31_n_0),
	.Q(mag_re[143]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[144]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_131),
	.D(signed_mag_0_re_mag[144]),
	.R(FE_OFN32_n_0),
	.Q(mag_re[144]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[145]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_131),
	.D(signed_mag_0_re_mag[145]),
	.R(FE_OFN32_n_0),
	.Q(mag_re[145]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[146]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_131),
	.D(signed_mag_0_re_mag[146]),
	.R(FE_OFN32_n_0),
	.Q(mag_re[146]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[147]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_130),
	.D(signed_mag_0_re_mag[147]),
	.R(FE_OFN32_n_0),
	.Q(mag_re[147]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[148]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_134),
	.D(signed_mag_0_re_mag[148]),
	.R(FE_OFN32_n_0),
	.Q(mag_re[148]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[149]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_134),
	.D(signed_mag_0_re_mag[149]),
	.R(FE_OFN32_n_0),
	.Q(mag_re[149]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[150]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_134),
	.D(signed_mag_0_re_mag[150]),
	.R(FE_OFN32_n_0),
	.Q(mag_re[150]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[151]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_142),
	.D(signed_mag_0_re_mag[151]),
	.R(FE_OFN57_n_0),
	.Q(mag_re[151]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[152]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_134),
	.D(signed_mag_0_re_mag[152]),
	.R(FE_OFN32_n_0),
	.Q(mag_re[152]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[153]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_134),
	.D(signed_mag_0_re_mag[153]),
	.R(FE_OFN32_n_0),
	.Q(mag_re[153]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[154]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_134),
	.D(signed_mag_0_re_mag[154]),
	.R(FE_OFN32_n_0),
	.Q(mag_re[154]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[155]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_142),
	.D(signed_mag_0_re_mag[155]),
	.R(FE_OFN32_n_0),
	.Q(mag_re[155]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[156]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_133),
	.D(signed_mag_0_re_mag[156]),
	.R(FE_OFN32_n_0),
	.Q(mag_re[156]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[157]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_133),
	.D(signed_mag_0_re_mag[157]),
	.R(FE_OFN32_n_0),
	.Q(mag_re[157]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[158]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_133),
	.D(signed_mag_0_re_mag[158]),
	.R(FE_OFN32_n_0),
	.Q(mag_re[158]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[159]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_133),
	.D(signed_mag_0_re_mag[159]),
	.R(FE_OFN32_n_0),
	.Q(mag_re[159]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[160]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_125),
	.D(signed_mag_0_re_mag[160]),
	.R(FE_OFN492_n),
	.Q(mag_re[160]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[161]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_125),
	.D(signed_mag_0_re_mag[161]),
	.R(FE_OFN492_n),
	.Q(mag_re[161]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[162]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_125),
	.D(signed_mag_0_re_mag[162]),
	.R(FE_OFN492_n),
	.Q(mag_re[162]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[163]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_125),
	.D(signed_mag_0_re_mag[163]),
	.R(FE_OFN492_n),
	.Q(mag_re[163]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[164]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_125),
	.D(signed_mag_0_re_mag[164]),
	.R(FE_OFN492_n),
	.Q(mag_re[164]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[165]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_125),
	.D(signed_mag_0_re_mag[165]),
	.R(FE_OFN492_n),
	.Q(mag_re[165]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[166]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_125),
	.D(signed_mag_0_re_mag[166]),
	.R(FE_OFN492_n),
	.Q(mag_re[166]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[167]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_124),
	.D(signed_mag_0_re_mag[167]),
	.R(FE_OFN492_n),
	.Q(mag_re[167]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[168]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_125),
	.D(signed_mag_0_re_mag[168]),
	.R(FE_OFN492_n),
	.Q(mag_re[168]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[169]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_124),
	.D(signed_mag_0_re_mag[169]),
	.R(FE_OFN492_n),
	.Q(mag_re[169]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[170]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_127),
	.D(signed_mag_0_re_mag[170]),
	.R(FE_OFN492_n),
	.Q(mag_re[170]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[171]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_124),
	.D(signed_mag_0_re_mag[171]),
	.R(FE_OFN492_n),
	.Q(mag_re[171]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[172]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_127),
	.D(signed_mag_0_re_mag[172]),
	.R(FE_OFN490_n),
	.Q(mag_re[172]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[173]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_127),
	.D(signed_mag_0_re_mag[173]),
	.R(FE_OFN490_n),
	.Q(mag_re[173]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[174]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_119),
	.D(signed_mag_0_re_mag[174]),
	.R(FE_OFN490_n),
	.Q(mag_re[174]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[175]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_127),
	.D(signed_mag_0_re_mag[175]),
	.R(FE_OFN490_n),
	.Q(mag_re[175]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[176]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_119),
	.D(signed_mag_0_re_mag[176]),
	.R(FE_OFN490_n),
	.Q(mag_re[176]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[177]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_119),
	.D(signed_mag_0_re_mag[177]),
	.R(FE_OFN490_n),
	.Q(mag_re[177]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[178]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_119),
	.D(signed_mag_0_re_mag[178]),
	.R(FE_OFN490_n),
	.Q(mag_re[178]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[179]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_200),
	.D(signed_mag_0_re_mag[179]),
	.R(FE_OFN490_n),
	.Q(mag_re[179]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[180]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_119),
	.D(signed_mag_0_re_mag[180]),
	.R(FE_OFN490_n),
	.Q(mag_re[180]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[181]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_119),
	.D(signed_mag_0_re_mag[181]),
	.R(FE_OFN490_n),
	.Q(mag_re[181]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[182]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_200),
	.D(signed_mag_0_re_mag[182]),
	.R(FE_OFN490_n),
	.Q(mag_re[182]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[183]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_189),
	.D(signed_mag_0_re_mag[183]),
	.R(FE_OFN490_n),
	.Q(mag_re[183]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[184]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_200),
	.D(signed_mag_0_re_mag[184]),
	.R(FE_RN_1),
	.Q(mag_re[184]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[185]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_200),
	.D(signed_mag_0_re_mag[185]),
	.R(FE_RN_1),
	.Q(mag_re[185]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[186]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_200),
	.D(signed_mag_0_re_mag[186]),
	.R(FE_RN_1),
	.Q(mag_re[186]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[187]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_199),
	.D(signed_mag_0_re_mag[187]),
	.R(FE_OFN490_n),
	.Q(mag_re[187]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[188]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_203),
	.D(signed_mag_0_re_mag[188]),
	.R(FE_RN_1),
	.Q(mag_re[188]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[189]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_203),
	.D(signed_mag_0_re_mag[189]),
	.R(FE_RN_1),
	.Q(mag_re[189]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[190]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_203),
	.D(signed_mag_0_re_mag[190]),
	.R(FE_RN_1),
	.Q(mag_re[190]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[191]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_127),
	.D(signed_mag_0_re_mag[191]),
	.R(FE_OFN491_n),
	.Q(mag_re[191]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[192]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_199),
	.D(signed_mag_0_re_mag[192]),
	.R(FE_RN_1),
	.Q(mag_re[192]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[193]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_203),
	.D(signed_mag_0_re_mag[193]),
	.R(FE_OFN377_rst_n),
	.Q(mag_re[193]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[194]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_203),
	.D(signed_mag_0_re_mag[194]),
	.R(FE_OFN377_rst_n),
	.Q(mag_re[194]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[195]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_203),
	.D(signed_mag_0_re_mag[195]),
	.R(FE_OFN377_rst_n),
	.Q(mag_re[195]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[196]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_203),
	.D(signed_mag_0_re_mag[196]),
	.R(FE_RN_1),
	.Q(mag_re[196]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[197]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_202),
	.D(signed_mag_0_re_mag[197]),
	.R(FE_RN_1),
	.Q(mag_re[197]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[198]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_203),
	.D(signed_mag_0_re_mag[198]),
	.R(FE_RN_1),
	.Q(mag_re[198]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[199]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_202),
	.D(signed_mag_0_re_mag[199]),
	.R(FE_RN_1),
	.Q(mag_re[199]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[200]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_202),
	.D(signed_mag_0_re_mag[200]),
	.R(FE_RN_1),
	.Q(mag_re[200]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[201]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_202),
	.D(signed_mag_0_re_mag[201]),
	.R(FE_OFN375_rst_n),
	.Q(mag_re[201]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[202]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_202),
	.D(signed_mag_0_re_mag[202]),
	.R(FE_OFN375_rst_n),
	.Q(mag_re[202]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[203]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_195),
	.D(signed_mag_0_re_mag[203]),
	.R(FE_OFN375_rst_n),
	.Q(mag_re[203]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[204]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_198),
	.D(signed_mag_0_re_mag[204]),
	.R(FE_OFN375_rst_n),
	.Q(mag_re[204]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[205]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_198),
	.D(signed_mag_0_re_mag[205]),
	.R(FE_OFN375_rst_n),
	.Q(mag_re[205]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[206]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_198),
	.D(signed_mag_0_re_mag[206]),
	.R(FE_OFN375_rst_n),
	.Q(mag_re[206]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[207]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_195),
	.D(signed_mag_0_re_mag[207]),
	.R(FE_OFN375_rst_n),
	.Q(mag_re[207]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[208]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_198),
	.D(signed_mag_0_re_mag[208]),
	.R(FE_OFN375_rst_n),
	.Q(mag_re[208]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[209]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_198),
	.D(signed_mag_0_re_mag[209]),
	.R(FE_OFN375_rst_n),
	.Q(mag_re[209]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[210]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_198),
	.D(signed_mag_0_re_mag[210]),
	.R(FE_OFN375_rst_n),
	.Q(mag_re[210]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[211]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_198),
	.D(signed_mag_0_re_mag[211]),
	.R(FE_OFN375_rst_n),
	.Q(mag_re[211]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[212]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_197),
	.D(signed_mag_0_re_mag[212]),
	.R(FE_OCPN1207_n),
	.Q(mag_re[212]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[213]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_197),
	.D(signed_mag_0_re_mag[213]),
	.R(FE_OCPN1207_n),
	.Q(mag_re[213]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[214]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_168),
	.D(signed_mag_0_re_mag[214]),
	.R(FE_OCPN1207_n),
	.Q(mag_re[214]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[215]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_160),
	.D(signed_mag_0_re_mag[215]),
	.R(FE_OCPN1210_n),
	.Q(mag_re[215]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[216]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_168),
	.D(signed_mag_0_re_mag[216]),
	.R(FE_OCPN1210_n),
	.Q(mag_re[216]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[217]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_197),
	.D(signed_mag_0_re_mag[217]),
	.R(FE_OCPN1207_n),
	.Q(mag_re[217]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[218]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_167),
	.D(signed_mag_0_re_mag[218]),
	.R(FE_OCPN1207_n),
	.Q(mag_re[218]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[219]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_168),
	.D(signed_mag_0_re_mag[219]),
	.R(FE_OCPN1207_n),
	.Q(mag_re[219]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[220]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_197),
	.D(signed_mag_0_re_mag[220]),
	.R(FE_OCPN1207_n),
	.Q(mag_re[220]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[221]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_167),
	.D(signed_mag_0_re_mag[221]),
	.R(FE_OCPN1207_n),
	.Q(mag_re[221]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[222]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_167),
	.D(signed_mag_0_re_mag[222]),
	.R(FE_OCPN1210_n),
	.Q(mag_re[222]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[223]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_167),
	.D(signed_mag_0_re_mag[223]),
	.R(FE_OCPN1210_n),
	.Q(mag_re[223]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[224]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_167),
	.D(signed_mag_0_re_mag[224]),
	.R(FE_OCPN1207_n),
	.Q(mag_re[224]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[225]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_164),
	.D(signed_mag_0_re_mag[225]),
	.R(FE_OCPN1207_n),
	.Q(mag_re[225]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[226]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_167),
	.D(signed_mag_0_re_mag[226]),
	.R(FE_OCPN1207_n),
	.Q(mag_re[226]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[227]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_167),
	.D(signed_mag_0_re_mag[227]),
	.R(FE_OCPN1207_n),
	.Q(mag_re[227]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[228]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_159),
	.D(signed_mag_0_re_mag[228]),
	.R(FE_OCPN1210_n),
	.Q(mag_re[228]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[229]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_159),
	.D(signed_mag_0_re_mag[229]),
	.R(FE_OCPN1210_n),
	.Q(mag_re[229]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[230]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_159),
	.D(signed_mag_0_re_mag[230]),
	.R(FE_OCPN1210_n),
	.Q(mag_re[230]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[231]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_155),
	.D(signed_mag_0_re_mag[231]),
	.R(FE_OFN1180_FE_OCPN986_n),
	.Q(mag_re[231]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[232]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_158),
	.D(signed_mag_0_re_mag[232]),
	.R(FE_RN_4),
	.Q(mag_re[232]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[233]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_158),
	.D(signed_mag_0_re_mag[233]),
	.R(FE_RN_4),
	.Q(mag_re[233]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[234]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_177),
	.D(signed_mag_0_re_mag[234]),
	.R(FE_RN_4),
	.Q(mag_re[234]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[235]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_177),
	.D(signed_mag_0_re_mag[235]),
	.R(FE_RN_4),
	.Q(mag_re[235]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[236]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_174),
	.D(signed_mag_0_re_mag[236]),
	.R(FE_OFN483_n),
	.Q(mag_re[236]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[237]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_177),
	.D(signed_mag_0_re_mag[237]),
	.R(FE_OFN483_n),
	.Q(mag_re[237]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[238]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_177),
	.D(signed_mag_0_re_mag[238]),
	.R(FE_OFN483_n),
	.Q(mag_re[238]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[239]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_173),
	.D(signed_mag_0_re_mag[239]),
	.R(FE_OFN487_n),
	.Q(mag_re[239]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[240]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_159),
	.D(signed_mag_0_re_mag[240]),
	.R(FE_OCPN1210_n),
	.Q(mag_re[240]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[241]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_159),
	.D(signed_mag_0_re_mag[241]),
	.R(FE_OCPN1210_n),
	.Q(mag_re[241]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[242]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_159),
	.D(signed_mag_0_re_mag[242]),
	.R(FE_OCPN1210_n),
	.Q(mag_re[242]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[243]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_163),
	.D(signed_mag_0_re_mag[243]),
	.R(FE_OFN1180_FE_OCPN986_n),
	.Q(mag_re[243]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[244]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_177),
	.D(signed_mag_0_re_mag[244]),
	.R(FE_RN_4),
	.Q(mag_re[244]));
   DFFRPQ_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[245]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_158),
	.D(signed_mag_0_re_mag[245]),
	.R(FE_OCPN1210_n),
	.Q(mag_re[245]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[246]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_177),
	.D(signed_mag_0_re_mag[246]),
	.R(FE_RN_4),
	.Q(mag_re[246]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[247]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_176),
	.D(signed_mag_0_re_mag[247]),
	.R(FE_RN_4),
	.Q(mag_re[247]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[248]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_170),
	.D(signed_mag_0_re_mag[248]),
	.R(FE_OFN487_n),
	.Q(mag_re[248]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[249]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_173),
	.D(signed_mag_0_re_mag[249]),
	.R(FE_OFN487_n),
	.Q(mag_re[249]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[250]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_173),
	.D(signed_mag_0_re_mag[250]),
	.R(FE_OFN487_n),
	.Q(mag_re[250]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[251]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_172),
	.D(signed_mag_0_re_mag[251]),
	.R(FE_OFN487_n),
	.Q(mag_re[251]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[252]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_172),
	.D(signed_mag_0_re_mag[252]),
	.R(FE_OFN487_n),
	.Q(mag_re[252]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[253]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_172),
	.D(signed_mag_0_re_mag[253]),
	.R(FE_OFN487_n),
	.Q(mag_re[253]));
   DFFRPQA_X1M_A9PP140ZTL_C30 \signed_mag_0_mag_re_reg[254]  (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_172),
	.D(signed_mag_0_re_mag[254]),
	.R(FE_OFN487_n),
	.Q(mag_re[254]));
   DFFRPQA_X1M_A9PP140ZTL_C30 signed_mag_0_sign_im_reg (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_145),
	.D(signed_mag_0_sign_im_stage1),
	.R(FE_OFN380_rst_n),
	.Q(sign_im));
   DFFRPQA_X1M_A9PP140ZTL_C30 signed_mag_0_sign_im_stage1_reg (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_145),
	.D(n_1),
	.R(FE_OFN380_rst_n),
	.Q(signed_mag_0_sign_im_stage1));
   DFFRPQA_X1M_A9PP140ZTL_C30 signed_mag_0_sign_re_reg (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_100),
	.D(signed_mag_0_sign_re_stage1),
	.R(FE_RN_2),
	.Q(sign_re));
   OAI21_X1M_A9PP140ZTL_C30 g2871974 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_451),
	.A1(n_60),
	.B0(n_436),
	.Y(n_646));
   OAI21_X1M_A9PP140ZTL_C30 g2871975 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_436),
	.A1(n_60),
	.B0(n_433),
	.Y(n_645));
   OAI21_X1M_A9PP140ZTL_C30 g2871976 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_93),
	.A1(n_451),
	.B0(n_436),
	.Y(n_644));
   OAI21_X1M_A9PP140ZTL_C30 g2871977 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_93),
	.A1(n_436),
	.B0(n_433),
	.Y(n_643));
   OAI21_X1M_A9PP140ZTL_C30 g2871978 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_80),
	.A1(n_436),
	.B0(n_433),
	.Y(n_642));
   OAI21_X1M_A9PP140ZTL_C30 g2871979 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_78),
	.A1(n_436),
	.B0(n_433),
	.Y(n_641));
   OAI21_X1M_A9PP140ZTL_C30 g2871980 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_81),
	.A1(n_436),
	.B0(n_433),
	.Y(n_640));
   OAI21_X1M_A9PP140ZTL_C30 g2871981 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_70),
	.A1(n_436),
	.B0(n_433),
	.Y(n_639));
   OAI21_X1M_A9PP140ZTL_C30 g2871982 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_65),
	.A1(n_436),
	.B0(n_433),
	.Y(n_638));
   OAI21_X1M_A9PP140ZTL_C30 g2871983 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_80),
	.A1(n_451),
	.B0(n_436),
	.Y(n_637));
   OAI21_X1M_A9PP140ZTL_C30 g2871984 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_78),
	.A1(n_451),
	.B0(n_436),
	.Y(n_636));
   OAI21_X1M_A9PP140ZTL_C30 g2871985 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_81),
	.A1(n_451),
	.B0(n_436),
	.Y(n_635));
   OAI21_X1M_A9PP140ZTL_C30 g2871986 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_70),
	.A1(n_451),
	.B0(n_436),
	.Y(n_634));
   OAI21_X1M_A9PP140ZTL_C30 g2871987 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_65),
	.A1(n_451),
	.B0(n_436),
	.Y(n_633));
   OAI21_X1M_A9PP140ZTL_C30 g2871988 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_451),
	.A1(n_58),
	.B0(n_436),
	.Y(n_632));
   OAI21_X1M_A9PP140ZTL_C30 g2871989 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_451),
	.A1(FE_OFN304_n_53),
	.B0(n_436),
	.Y(n_631));
   OAI21_X1M_A9PP140ZTL_C30 g2871990 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_67),
	.A1(n_451),
	.B0(n_436),
	.Y(n_630));
   OAI21_X1M_A9PP140ZTL_C30 g2871991 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_436),
	.A1(FE_OFN127_signed_mag_0_abs_im_stage1_3),
	.B0(n_433),
	.Y(n_629));
   OAI21_X1M_A9PP140ZTL_C30 g2871992 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_436),
	.A1(n_58),
	.B0(n_433),
	.Y(n_628));
   OAI21_X1M_A9PP140ZTL_C30 g2871993 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_436),
	.A1(FE_OFN304_n_53),
	.B0(n_433),
	.Y(n_627));
   OAI21_X1M_A9PP140ZTL_C30 g2871994 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_67),
	.A1(n_436),
	.B0(n_433),
	.Y(n_626));
   OAI21_X1M_A9PP140ZTL_C30 g2871995 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_451),
	.A1(n_69),
	.B0(n_436),
	.Y(n_625));
   OAI21_X1M_A9PP140ZTL_C30 g2871996 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_451),
	.A1(n_74),
	.B0(n_436),
	.Y(n_624));
   OAI21_X1M_A9PP140ZTL_C30 g2871997 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_451),
	.A1(FE_OFN127_signed_mag_0_abs_im_stage1_3),
	.B0(n_436),
	.Y(n_623));
   OAI21_X1M_A9PP140ZTL_C30 g2871998 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_436),
	.A1(n_69),
	.B0(n_433),
	.Y(n_622));
   OAI21_X1M_A9PP140ZTL_C30 g2871999 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_436),
	.A1(n_74),
	.B0(n_433),
	.Y(n_621));
   OAI21_X1M_A9PP140ZTL_C30 g2872000 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_47),
	.A1(n_436),
	.B0(n_433),
	.Y(n_620));
   OAI21_X1M_A9PP140ZTL_C30 g2872001 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_45),
	.A1(n_436),
	.B0(n_433),
	.Y(n_619));
   OAI21_X1M_A9PP140ZTL_C30 g2872002 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_47),
	.A1(n_451),
	.B0(n_436),
	.Y(n_618));
   OAI21_X1M_A9PP140ZTL_C30 g2872003 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_45),
	.A1(n_451),
	.B0(n_436),
	.Y(n_617));
   OAI21_X1M_A9PP140ZTL_C30 g2872242 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_47),
	.A1(n_160),
	.B0(n_450),
	.Y(n_616));
   NAND2_X1M_A9PP140ZTL_C30 g2872315 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_446),
	.B(n_80),
	.Y(n_615));
   NAND2_X1M_A9PP140ZTL_C30 g2872316 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_446),
	.B(n_78),
	.Y(n_614));
   NAND2_X1M_A9PP140ZTL_C30 g2872317 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_446),
	.B(n_81),
	.Y(n_613));
   NAND2_X1M_A9PP140ZTL_C30 g2872318 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_65),
	.B(n_446),
	.Y(n_612));
   NAND2_X1M_A9PP140ZTL_C30 g2872319 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_70),
	.B(n_446),
	.Y(n_611));
   NOR2_X1A_A9PP140ZTL_C30 g2872320 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_433),
	.B(n_60),
	.Y(n_610));
   NAND2_X1M_A9PP140ZTL_C30 g2872321 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_446),
	.B(n_60),
	.Y(n_609));
   NAND2_X1M_A9PP140ZTL_C30 g2872322 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_446),
	.B(FE_OFN127_signed_mag_0_abs_im_stage1_3),
	.Y(n_608));
   NOR2_X1A_A9PP140ZTL_C30 g2872323 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_80),
	.B(n_433),
	.Y(n_607));
   NOR2_X1A_A9PP140ZTL_C30 g2872324 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_78),
	.B(n_433),
	.Y(n_606));
   NOR2_X1A_A9PP140ZTL_C30 g2872325 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_81),
	.B(n_433),
	.Y(n_605));
   NOR2_X1A_A9PP140ZTL_C30 g2872326 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_70),
	.B(n_433),
	.Y(n_604));
   NOR2_X0P7A_A9PP140ZTL_C30 g2872327 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_65),
	.B(n_433),
	.Y(n_603));
   NAND2_X1M_A9PP140ZTL_C30 g2872328 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_446),
	.B(n_93),
	.Y(n_602));
   NOR2_X1A_A9PP140ZTL_C30 g2872329 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_93),
	.B(n_433),
	.Y(n_601));
   NOR2_X1A_A9PP140ZTL_C30 g2872330 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_433),
	.B(FE_OFN127_signed_mag_0_abs_im_stage1_3),
	.Y(n_600));
   NAND2_X1M_A9PP140ZTL_C30 g2872331 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_47),
	.B(n_446),
	.Y(n_599));
   NAND2_X1M_A9PP140ZTL_C30 g2872332 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_45),
	.B(n_446),
	.Y(n_598));
   NAND2_X1M_A9PP140ZTL_C30 g2872333 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_446),
	.B(n_58),
	.Y(n_597));
   NOR2_X0P7A_A9PP140ZTL_C30 g2872334 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_433),
	.B(n_58),
	.Y(n_596));
   NOR2_X1A_A9PP140ZTL_C30 g2872335 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_433),
	.B(FE_OFN304_n_53),
	.Y(n_595));
   NAND2_X1M_A9PP140ZTL_C30 g2872336 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_446),
	.B(FE_OFN304_n_53),
	.Y(n_594));
   NOR2_X1A_A9PP140ZTL_C30 g2872337 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_433),
	.B(n_67),
	.Y(n_593));
   NAND2_X1M_A9PP140ZTL_C30 g2872338 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_446),
	.B(n_67),
	.Y(n_592));
   NOR2_X0P7A_A9PP140ZTL_C30 g2872339 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_47),
	.B(n_433),
	.Y(n_591));
   NOR2_X0P7A_A9PP140ZTL_C30 g2872340 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_45),
	.B(n_433),
	.Y(n_590));
   NAND2_X1M_A9PP140ZTL_C30 g2872341 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_446),
	.B(n_69),
	.Y(n_589));
   NAND2_X1M_A9PP140ZTL_C30 g2872342 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_446),
	.B(n_74),
	.Y(n_588));
   NOR2_X1A_A9PP140ZTL_C30 g2872343 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_433),
	.B(n_69),
	.Y(n_587));
   NOR2_X1A_A9PP140ZTL_C30 g2872344 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_433),
	.B(n_74),
	.Y(n_586));
   OAI21_X1M_A9PP140ZTL_C30 g2872345 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_78),
	.A1(FE_OFN133_signed_mag_0_abs_im_stage1_5),
	.B0(n_444),
	.Y(n_585));
   OAI21_X1M_A9PP140ZTL_C30 g2872346 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_81),
	.A1(FE_OFN133_signed_mag_0_abs_im_stage1_5),
	.B0(n_444),
	.Y(n_584));
   OAI21_X1M_A9PP140ZTL_C30 g2872347 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_80),
	.A1(FE_OFN133_signed_mag_0_abs_im_stage1_5),
	.B0(n_444),
	.Y(n_583));
   OAI21_X1M_A9PP140ZTL_C30 g2872348 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_65),
	.A1(FE_OFN133_signed_mag_0_abs_im_stage1_5),
	.B0(n_444),
	.Y(n_582));
   OAI21_X1M_A9PP140ZTL_C30 g2872349 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_70),
	.A1(FE_OFN133_signed_mag_0_abs_im_stage1_5),
	.B0(n_444),
	.Y(n_581));
   OAI21_X1M_A9PP140ZTL_C30 g2872350 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_80),
	.A1(FE_OFN130_signed_mag_0_abs_im_stage1_4),
	.B0(n_440),
	.Y(n_580));
   OAI21_X1M_A9PP140ZTL_C30 g2872351 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_78),
	.A1(FE_OFN130_signed_mag_0_abs_im_stage1_4),
	.B0(n_440),
	.Y(n_579));
   OAI21_X1M_A9PP140ZTL_C30 g2872352 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_81),
	.A1(FE_OFN130_signed_mag_0_abs_im_stage1_4),
	.B0(n_440),
	.Y(n_578));
   OAI21_X1M_A9PP140ZTL_C30 g2872353 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_70),
	.A1(FE_OFN130_signed_mag_0_abs_im_stage1_4),
	.B0(n_440),
	.Y(n_577));
   OAI21_X1M_A9PP140ZTL_C30 g2872354 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_65),
	.A1(FE_OFN130_signed_mag_0_abs_im_stage1_4),
	.B0(n_440),
	.Y(n_576));
   OAI21_X1M_A9PP140ZTL_C30 g2872355 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_80),
	.A1(n_105),
	.B0(n_438),
	.Y(n_575));
   OAI21_X1M_A9PP140ZTL_C30 g2872356 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_78),
	.A1(signed_mag_0_abs_im_stage1[7]),
	.B0(n_438),
	.Y(n_574));
   OAI21_X1M_A9PP140ZTL_C30 g2872357 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_81),
	.A1(signed_mag_0_abs_im_stage1[7]),
	.B0(n_438),
	.Y(n_573));
   OAI21_X1M_A9PP140ZTL_C30 g2872358 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_70),
	.A1(n_105),
	.B0(n_438),
	.Y(n_572));
   OAI21_X1M_A9PP140ZTL_C30 g2872359 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_65),
	.A1(signed_mag_0_abs_im_stage1[7]),
	.B0(n_438),
	.Y(n_571));
   OAI21_X1M_A9PP140ZTL_C30 g2872360 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN133_signed_mag_0_abs_im_stage1_5),
	.A1(FE_OFN127_signed_mag_0_abs_im_stage1_3),
	.B0(n_444),
	.Y(n_570));
   OAI21_X1M_A9PP140ZTL_C30 g2872361 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN127_signed_mag_0_abs_im_stage1_3),
	.A1(FE_OFN130_signed_mag_0_abs_im_stage1_4),
	.B0(n_440),
	.Y(n_569));
   OAI21_X1M_A9PP140ZTL_C30 g2872362 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(signed_mag_0_abs_im_stage1[7]),
	.A1(signed_mag_0_abs_im_stage1[3]),
	.B0(n_438),
	.Y(n_568));
   OAI21_X1M_A9PP140ZTL_C30 g2872363 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_60),
	.A1(n_162),
	.B0(n_448),
	.Y(n_567));
   OAI21_X1M_A9PP140ZTL_C30 g2872364 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_160),
	.A1(n_60),
	.B0(n_450),
	.Y(n_566));
   OAI21_X1M_A9PP140ZTL_C30 g2872365 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_161),
	.A1(n_48),
	.B0(n_140),
	.Y(n_565));
   OAI21_X1M_A9PP140ZTL_C30 g2872366 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_45),
	.A1(FE_OFN133_signed_mag_0_abs_im_stage1_5),
	.B0(n_444),
	.Y(n_564));
   OAI21_X1M_A9PP140ZTL_C30 g2872367 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_47),
	.A1(FE_OFN133_signed_mag_0_abs_im_stage1_5),
	.B0(n_444),
	.Y(n_563));
   OAI21_X1M_A9PP140ZTL_C30 g2872368 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_80),
	.A1(n_136),
	.B0(n_442),
	.Y(n_562));
   OAI21_X1M_A9PP140ZTL_C30 g2872369 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_78),
	.A1(n_136),
	.B0(n_442),
	.Y(n_561));
   OAI21_X1M_A9PP140ZTL_C30 g2872370 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_81),
	.A1(n_136),
	.B0(n_442),
	.Y(n_560));
   OAI21_X1M_A9PP140ZTL_C30 g2872371 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_157),
	.A1(n_60),
	.B0(n_136),
	.Y(n_559));
   OAI21_X1M_A9PP140ZTL_C30 g2872372 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_93),
	.A1(n_162),
	.B0(n_448),
	.Y(n_558));
   OAI21_X1M_A9PP140ZTL_C30 g2872373 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_60),
	.A1(n_136),
	.B0(n_442),
	.Y(n_557));
   OAI21_X1M_A9PP140ZTL_C30 g2872374 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_70),
	.A1(n_136),
	.B0(n_442),
	.Y(n_556));
   OAI21_X1M_A9PP140ZTL_C30 g2872375 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_65),
	.A1(n_136),
	.B0(n_442),
	.Y(n_555));
   OAI21_X1M_A9PP140ZTL_C30 g2872376 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_93),
	.A1(n_160),
	.B0(n_450),
	.Y(n_554));
   OAI21_X1M_A9PP140ZTL_C30 g2872377 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_47),
	.A1(FE_OFN130_signed_mag_0_abs_im_stage1_4),
	.B0(n_440),
	.Y(n_553));
   OAI21_X1M_A9PP140ZTL_C30 g2872378 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_45),
	.A1(FE_OFN130_signed_mag_0_abs_im_stage1_4),
	.B0(n_440),
	.Y(n_552));
   OAI21_X1M_A9PP140ZTL_C30 g2872379 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_140),
	.A1(n_48),
	.B0(n_137),
	.Y(n_551));
   OAI21_X1M_A9PP140ZTL_C30 g2872380 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_92),
	.A1(n_161),
	.B0(n_140),
	.Y(n_550));
   OAI21_X1M_A9PP140ZTL_C30 g2872381 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_157),
	.A1(n_93),
	.B0(n_136),
	.Y(n_549));
   OAI21_X1M_A9PP140ZTL_C30 g2872382 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_45),
	.A1(n_105),
	.B0(n_438),
	.Y(n_548));
   OAI21_X1M_A9PP140ZTL_C30 g2872383 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_47),
	.A1(n_105),
	.B0(n_438),
	.Y(n_547));
   OAI21_X1M_A9PP140ZTL_C30 g2872384 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_93),
	.A1(n_136),
	.B0(n_442),
	.Y(n_546));
   OAI21_X1M_A9PP140ZTL_C30 g2872385 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_92),
	.A1(n_140),
	.B0(n_137),
	.Y(n_545));
   OAI21_X1M_A9PP140ZTL_C30 g2872386 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN306_n_77),
	.A1(n_140),
	.B0(n_137),
	.Y(n_544));
   OAI21_X1M_A9PP140ZTL_C30 g2872387 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN307_n_79),
	.A1(n_140),
	.B0(n_137),
	.Y(n_543));
   OAI21_X1M_A9PP140ZTL_C30 g2872388 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_76),
	.A1(n_140),
	.B0(n_137),
	.Y(n_542));
   OAI21_X1M_A9PP140ZTL_C30 g2872389 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_80),
	.A1(n_157),
	.B0(n_136),
	.Y(n_541));
   OAI21_X1M_A9PP140ZTL_C30 g2872390 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_78),
	.A1(n_157),
	.B0(n_136),
	.Y(n_540));
   OAI21_X1M_A9PP140ZTL_C30 g2872391 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_81),
	.A1(n_157),
	.B0(n_136),
	.Y(n_539));
   OAI21_X1M_A9PP140ZTL_C30 g2872392 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_136),
	.A1(FE_OFN127_signed_mag_0_abs_im_stage1_3),
	.B0(n_442),
	.Y(n_538));
   OAI21_X1M_A9PP140ZTL_C30 g2872393 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_71),
	.A1(n_140),
	.B0(n_137),
	.Y(n_537));
   OAI21_X1M_A9PP140ZTL_C30 g2872394 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_66),
	.A1(n_140),
	.B0(n_137),
	.Y(n_536));
   OAI21_X1M_A9PP140ZTL_C30 g2872395 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_70),
	.A1(n_157),
	.B0(n_136),
	.Y(n_535));
   OAI21_X1M_A9PP140ZTL_C30 g2872396 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_65),
	.A1(n_157),
	.B0(n_136),
	.Y(n_534));
   OAI21_X1M_A9PP140ZTL_C30 g2872397 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN306_n_77),
	.A1(n_161),
	.B0(n_140),
	.Y(n_533));
   OAI21_X1M_A9PP140ZTL_C30 g2872398 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN307_n_79),
	.A1(n_161),
	.B0(n_140),
	.Y(n_532));
   OAI21_X1M_A9PP140ZTL_C30 g2872399 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_76),
	.A1(n_161),
	.B0(n_140),
	.Y(n_531));
   OAI21_X1M_A9PP140ZTL_C30 g2872400 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_162),
	.A1(n_58),
	.B0(n_448),
	.Y(n_530));
   OAI21_X1M_A9PP140ZTL_C30 g2872401 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_160),
	.A1(n_58),
	.B0(n_450),
	.Y(n_529));
   OAI21_X1M_A9PP140ZTL_C30 g2872402 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_71),
	.A1(n_161),
	.B0(n_140),
	.Y(n_528));
   OAI21_X1M_A9PP140ZTL_C30 g2872403 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_66),
	.A1(n_161),
	.B0(n_140),
	.Y(n_527));
   OAI21_X1M_A9PP140ZTL_C30 g2872404 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_81),
	.A1(n_162),
	.B0(n_448),
	.Y(n_526));
   OAI21_X1M_A9PP140ZTL_C30 g2872405 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_78),
	.A1(n_162),
	.B0(n_448),
	.Y(n_525));
   OAI21_X1M_A9PP140ZTL_C30 g2872406 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_80),
	.A1(n_162),
	.B0(n_448),
	.Y(n_524));
   OAI21_X1M_A9PP140ZTL_C30 g2872407 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_161),
	.A1(n_57),
	.B0(n_140),
	.Y(n_523));
   OAI21_X1M_A9PP140ZTL_C30 g2872408 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_162),
	.A1(FE_OFN304_n_53),
	.B0(n_448),
	.Y(n_522));
   OAI21_X1M_A9PP140ZTL_C30 g2872409 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_160),
	.A1(FE_OFN304_n_53),
	.B0(n_450),
	.Y(n_521));
   OAI21_X1M_A9PP140ZTL_C30 g2872410 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_80),
	.A1(n_160),
	.B0(n_450),
	.Y(n_520));
   OAI21_X1M_A9PP140ZTL_C30 g2872411 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_78),
	.A1(n_160),
	.B0(n_450),
	.Y(n_519));
   OAI21_X1M_A9PP140ZTL_C30 g2872412 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_81),
	.A1(n_160),
	.B0(n_450),
	.Y(n_518));
   OAI21_X1M_A9PP140ZTL_C30 g2872413 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_67),
	.A1(n_162),
	.B0(n_448),
	.Y(n_517));
   OAI21_X1M_A9PP140ZTL_C30 g2872414 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_65),
	.A1(n_162),
	.B0(n_448),
	.Y(n_516));
   OAI21_X1M_A9PP140ZTL_C30 g2872415 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_70),
	.A1(n_162),
	.B0(n_448),
	.Y(n_515));
   OAI21_X1M_A9PP140ZTL_C30 g2872416 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_161),
	.A1(FE_OFN302_n_51),
	.B0(n_140),
	.Y(n_514));
   OAI21_X1M_A9PP140ZTL_C30 g2872417 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_67),
	.A1(n_160),
	.B0(n_450),
	.Y(n_513));
   OAI21_X1M_A9PP140ZTL_C30 g2872418 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_70),
	.A1(n_160),
	.B0(n_450),
	.Y(n_512));
   OAI21_X1M_A9PP140ZTL_C30 g2872419 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_65),
	.A1(n_160),
	.B0(n_450),
	.Y(n_511));
   OAI21_X1M_A9PP140ZTL_C30 g2872420 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_68),
	.A1(n_161),
	.B0(n_140),
	.Y(n_510));
   OAI21_X1M_A9PP140ZTL_C30 g2872421 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_157),
	.A1(n_58),
	.B0(n_136),
	.Y(n_509));
   OAI21_X1M_A9PP140ZTL_C30 g2872422 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_136),
	.A1(n_58),
	.B0(n_442),
	.Y(n_508));
   OAI21_X1M_A9PP140ZTL_C30 g2872423 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_140),
	.A1(FE_OFN301_signed_mag_0_abs_re_stage1_3),
	.B0(n_137),
	.Y(n_507));
   OAI21_X1M_A9PP140ZTL_C30 g2872424 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_157),
	.A1(FE_OFN127_signed_mag_0_abs_im_stage1_3),
	.B0(n_136),
	.Y(n_506));
   OAI21_X1M_A9PP140ZTL_C30 g2872425 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_157),
	.A1(FE_OFN304_n_53),
	.B0(n_136),
	.Y(n_505));
   OAI21_X1M_A9PP140ZTL_C30 g2872426 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_60),
	.A1(n_105),
	.B0(n_438),
	.Y(n_504));
   OAI21_X1M_A9PP140ZTL_C30 g2872427 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_140),
	.A1(n_57),
	.B0(n_137),
	.Y(n_503));
   OAI21_X1M_A9PP140ZTL_C30 g2872428 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_157),
	.A1(n_67),
	.B0(n_136),
	.Y(n_502));
   OAI21_X1M_A9PP140ZTL_C30 g2872429 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_136),
	.A1(FE_OFN304_n_53),
	.B0(n_442),
	.Y(n_501));
   OAI21_X1M_A9PP140ZTL_C30 g2872430 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_69),
	.A1(n_162),
	.B0(n_448),
	.Y(n_500));
   OAI21_X1M_A9PP140ZTL_C30 g2872431 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_67),
	.A1(n_136),
	.B0(n_442),
	.Y(n_499));
   OAI21_X1M_A9PP140ZTL_C30 g2872432 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_74),
	.A1(n_162),
	.B0(n_448),
	.Y(n_498));
   OAI21_X1M_A9PP140ZTL_C30 g2872433 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_47),
	.A1(n_136),
	.B0(n_442),
	.Y(n_497));
   OAI21_X1M_A9PP140ZTL_C30 g2872434 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_45),
	.A1(n_136),
	.B0(n_442),
	.Y(n_496));
   OAI21_X1M_A9PP140ZTL_C30 g2872435 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_140),
	.A1(FE_OFN302_n_51),
	.B0(n_137),
	.Y(n_495));
   OAI21_X1M_A9PP140ZTL_C30 g2872436 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_69),
	.A1(n_160),
	.B0(n_450),
	.Y(n_494));
   OAI21_X1M_A9PP140ZTL_C30 g2872437 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_74),
	.A1(FE_OFN133_signed_mag_0_abs_im_stage1_5),
	.B0(n_444),
	.Y(n_493));
   OAI21_X1M_A9PP140ZTL_C30 g2872438 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_74),
	.A1(n_160),
	.B0(n_450),
	.Y(n_492));
   OAI21_X1M_A9PP140ZTL_C30 g2872439 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_69),
	.A1(FE_OFN133_signed_mag_0_abs_im_stage1_5),
	.B0(n_444),
	.Y(n_491));
   OAI21_X1M_A9PP140ZTL_C30 g2872440 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_68),
	.A1(n_140),
	.B0(n_137),
	.Y(n_490));
   OAI21_X1M_A9PP140ZTL_C30 g2872441 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_161),
	.A1(n_75),
	.B0(n_140),
	.Y(n_489));
   OAI21_X1M_A9PP140ZTL_C30 g2872442 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_161),
	.A1(n_64),
	.B0(n_140),
	.Y(n_488));
   OAI21_X1M_A9PP140ZTL_C30 g2872443 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_161),
	.A1(FE_OFN301_signed_mag_0_abs_re_stage1_3),
	.B0(n_140),
	.Y(n_487));
   OAI21_X1M_A9PP140ZTL_C30 g2872444 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_74),
	.A1(FE_OFN130_signed_mag_0_abs_im_stage1_4),
	.B0(n_440),
	.Y(n_486));
   OAI21_X1M_A9PP140ZTL_C30 g2872445 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_162),
	.A1(FE_OFN127_signed_mag_0_abs_im_stage1_3),
	.B0(n_448),
	.Y(n_485));
   OAI21_X1M_A9PP140ZTL_C30 g2872446 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_69),
	.A1(FE_OFN130_signed_mag_0_abs_im_stage1_4),
	.B0(n_440),
	.Y(n_484));
   OAI21_X1M_A9PP140ZTL_C30 g2872447 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_93),
	.A1(n_105),
	.B0(n_438),
	.Y(n_483));
   OAI21_X1M_A9PP140ZTL_C30 g2872448 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_157),
	.A1(n_69),
	.B0(n_136),
	.Y(n_482));
   OAI21_X1M_A9PP140ZTL_C30 g2872449 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_160),
	.A1(FE_OFN127_signed_mag_0_abs_im_stage1_3),
	.B0(n_450),
	.Y(n_481));
   OAI21_X1M_A9PP140ZTL_C30 g2872450 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_157),
	.A1(n_74),
	.B0(n_136),
	.Y(n_480));
   OAI21_X1M_A9PP140ZTL_C30 g2872451 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_69),
	.A1(n_136),
	.B0(n_442),
	.Y(n_479));
   OAI21_X1M_A9PP140ZTL_C30 g2872452 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_74),
	.A1(n_136),
	.B0(n_442),
	.Y(n_478));
   OAI21_X1M_A9PP140ZTL_C30 g2872453 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_67),
	.A1(FE_OFN133_signed_mag_0_abs_im_stage1_5),
	.B0(n_444),
	.Y(n_477));
   OAI21_X1M_A9PP140ZTL_C30 g2872454 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_140),
	.A1(n_75),
	.B0(n_137),
	.Y(n_476));
   OAI21_X1M_A9PP140ZTL_C30 g2872455 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_140),
	.A1(n_64),
	.B0(n_137),
	.Y(n_475));
   OAI21_X1M_A9PP140ZTL_C30 g2872456 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_74),
	.A1(n_105),
	.B0(n_438),
	.Y(n_474));
   OAI21_X1M_A9PP140ZTL_C30 g2872457 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_69),
	.A1(signed_mag_0_abs_im_stage1[7]),
	.B0(n_438),
	.Y(n_473));
   OAI21_X1M_A9PP140ZTL_C30 g2872458 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN304_n_53),
	.A1(FE_OFN133_signed_mag_0_abs_im_stage1_5),
	.B0(n_444),
	.Y(n_472));
   OAI21_X1M_A9PP140ZTL_C30 g2872459 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_60),
	.A1(FE_OFN130_signed_mag_0_abs_im_stage1_4),
	.B0(n_440),
	.Y(n_471));
   OAI21_X1M_A9PP140ZTL_C30 g2872460 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_67),
	.A1(FE_OFN130_signed_mag_0_abs_im_stage1_4),
	.B0(n_440),
	.Y(n_470));
   OAI21_X1M_A9PP140ZTL_C30 g2872461 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_58),
	.A1(FE_OFN133_signed_mag_0_abs_im_stage1_5),
	.B0(n_444),
	.Y(n_469));
   OAI21_X1M_A9PP140ZTL_C30 g2872462 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_46),
	.A1(n_140),
	.B0(n_137),
	.Y(n_468));
   OAI21_X1M_A9PP140ZTL_C30 g2872463 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_49),
	.A1(n_140),
	.B0(n_137),
	.Y(n_467));
   OAI21_X1M_A9PP140ZTL_C30 g2872464 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_47),
	.A1(n_157),
	.B0(n_136),
	.Y(n_466));
   OAI21_X1M_A9PP140ZTL_C30 g2872465 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_45),
	.A1(n_157),
	.B0(n_136),
	.Y(n_465));
   OAI21_X1M_A9PP140ZTL_C30 g2872466 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN304_n_53),
	.A1(FE_OFN130_signed_mag_0_abs_im_stage1_4),
	.B0(n_440),
	.Y(n_464));
   OAI21_X1M_A9PP140ZTL_C30 g2872467 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_60),
	.A1(FE_OFN133_signed_mag_0_abs_im_stage1_5),
	.B0(n_444),
	.Y(n_463));
   OAI21_X1M_A9PP140ZTL_C30 g2872468 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN304_n_53),
	.A1(signed_mag_0_abs_im_stage1[7]),
	.B0(n_438),
	.Y(n_462));
   OAI21_X1M_A9PP140ZTL_C30 g2872469 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_67),
	.A1(n_105),
	.B0(n_438),
	.Y(n_461));
   OAI21_X1M_A9PP140ZTL_C30 g2872470 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_58),
	.A1(signed_mag_0_abs_im_stage1[7]),
	.B0(n_438),
	.Y(n_460));
   OAI21_X1M_A9PP140ZTL_C30 g2872471 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_58),
	.A1(FE_OFN130_signed_mag_0_abs_im_stage1_4),
	.B0(n_440),
	.Y(n_459));
   OAI21_X1M_A9PP140ZTL_C30 g2872472 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_93),
	.A1(FE_OFN130_signed_mag_0_abs_im_stage1_4),
	.B0(n_440),
	.Y(n_458));
   OAI21_X1M_A9PP140ZTL_C30 g2872473 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_46),
	.A1(n_161),
	.B0(n_140),
	.Y(n_457));
   OAI21_X1M_A9PP140ZTL_C30 g2872474 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_49),
	.A1(n_161),
	.B0(n_140),
	.Y(n_456));
   OAI21_X1M_A9PP140ZTL_C30 g2872475 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_45),
	.A1(n_162),
	.B0(n_448),
	.Y(n_455));
   OAI21_X1M_A9PP140ZTL_C30 g2872476 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_47),
	.A1(n_162),
	.B0(n_448),
	.Y(n_454));
   OAI21_X1M_A9PP140ZTL_C30 g2872477 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_93),
	.A1(FE_OFN133_signed_mag_0_abs_im_stage1_5),
	.B0(n_444),
	.Y(n_453));
   OAI21_X1M_A9PP140ZTL_C30 g2872478 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_45),
	.A1(n_160),
	.B0(n_450),
	.Y(n_452));
   INV_X0P8M_A9PP140ZTL_C30 g2872480 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_450),
	.Y(n_449));
   INV_X0P8M_A9PP140ZTL_C30 g2872481 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_448),
	.Y(n_447));
   INV_X0P8M_A9PP140ZTL_C30 g2872483 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_444),
	.Y(n_443));
   INV_X0P8M_A9PP140ZTL_C30 g2872484 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_442),
	.Y(n_441));
   INV_X0P8M_A9PP140ZTL_C30 g2872485 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_440),
	.Y(n_439));
   INV_X0P8M_A9PP140ZTL_C30 g2872487 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_436),
	.Y(n_435));
   INV_X0P8M_A9PP140ZTL_C30 g2872488 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_433),
	.Y(n_434));
   OAI21_X1M_A9PP140ZTL_C30 g2872524 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_67),
	.A1(n_84),
	.B0(n_141),
	.Y(n_432));
   OAI21_X1M_A9PP140ZTL_C30 g2872525 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_84),
	.A1(FE_OFN304_n_53),
	.B0(n_141),
	.Y(n_431));
   NAND2_X1M_A9PP140ZTL_C30 g2872526 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_156),
	.B(FE_OFN306_n_77),
	.Y(n_430));
   NAND2_X1M_A9PP140ZTL_C30 g2872527 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_156),
	.B(FE_OFN307_n_79),
	.Y(n_429));
   NAND2_X1M_A9PP140ZTL_C30 g2872528 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_156),
	.B(n_76),
	.Y(n_428));
   NAND2_X1M_A9PP140ZTL_C30 g2872529 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_71),
	.B(n_156),
	.Y(n_427));
   NAND2_X1M_A9PP140ZTL_C30 g2872530 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_66),
	.B(n_156),
	.Y(n_426));
   NAND2_X1M_A9PP140ZTL_C30 g2872531 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_156),
	.B(n_48),
	.Y(n_425));
   NOR2_X1A_A9PP140ZTL_C30 g2872532 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_137),
	.B(n_48),
	.Y(n_424));
   NAND2_X1M_A9PP140ZTL_C30 g2872533 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_156),
	.B(FE_OFN301_signed_mag_0_abs_re_stage1_3),
	.Y(n_423));
   NOR2_X1A_A9PP140ZTL_C30 g2872534 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN306_n_77),
	.B(n_137),
	.Y(n_422));
   NOR2_X1A_A9PP140ZTL_C30 g2872535 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(FE_OFN307_n_79),
	.B(n_137),
	.Y(n_421));
   NOR2_X1A_A9PP140ZTL_C30 g2872536 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_76),
	.B(n_137),
	.Y(n_420));
   NOR2_X0P7A_A9PP140ZTL_C30 g2872537 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_71),
	.B(n_137),
	.Y(n_419));
   NOR2_X1A_A9PP140ZTL_C30 g2872538 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_66),
	.B(n_137),
	.Y(n_418));
   NOR2_X1A_A9PP140ZTL_C30 g2872539 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_92),
	.B(n_137),
	.Y(n_417));
   NAND2_X1M_A9PP140ZTL_C30 g2872540 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_156),
	.B(n_92),
	.Y(n_416));
   OAI21_X1M_A9PP140ZTL_C30 g2872541 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_98),
	.A1(n_92),
	.B0(signed_mag_0_abs_re_stage1[7]),
	.Y(n_415));
   OAI21_X1M_A9PP140ZTL_C30 g2872542 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_101),
	.A1(n_93),
	.B0(signed_mag_0_abs_im_stage1[7]),
	.Y(n_414));
   OAI21_X1M_A9PP140ZTL_C30 g2872543 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_98),
	.A1(FE_OFN301_signed_mag_0_abs_re_stage1_3),
	.B0(signed_mag_0_abs_re_stage1[7]),
	.Y(n_413));
   NOR2_X1A_A9PP140ZTL_C30 g2872544 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_137),
	.B(FE_OFN301_signed_mag_0_abs_re_stage1_3),
	.Y(n_412));
   NAND2_X1M_A9PP140ZTL_C30 g2872545 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_49),
	.B(n_156),
	.Y(n_411));
   NAND2_X1M_A9PP140ZTL_C30 g2872546 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_46),
	.B(n_156),
	.Y(n_410));
   NOR2_X0P7A_A9PP140ZTL_C30 g2872547 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_137),
	.B(n_57),
	.Y(n_409));
   NAND2_X1M_A9PP140ZTL_C30 g2872548 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_156),
	.B(n_57),
	.Y(n_408));
   OAI21_X1M_A9PP140ZTL_C30 g2872549 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_101),
	.A1(signed_mag_0_abs_im_stage1[3]),
	.B0(signed_mag_0_abs_im_stage1[7]),
	.Y(n_407));
   NOR2_X1A_A9PP140ZTL_C30 g2872550 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_137),
	.B(FE_OFN302_n_51),
	.Y(n_406));
   NAND2_X1M_A9PP140ZTL_C30 g2872551 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_156),
	.B(n_51),
	.Y(n_405));
   NAND2_X1M_A9PP140ZTL_C30 g2872552 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_156),
	.B(n_68),
	.Y(n_404));
   NOR2_X1A_A9PP140ZTL_C30 g2872553 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_137),
	.B(n_68),
	.Y(n_403));
   OAI21_X1M_A9PP140ZTL_C30 g2872554 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_92),
	.A1(n_95),
	.B0(n_159),
	.Y(n_402));
   NOR2_X0P7A_A9PP140ZTL_C30 g2872555 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_49),
	.B(n_137),
	.Y(n_401));
   NOR2_X0P7A_A9PP140ZTL_C30 g2872556 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_46),
	.B(n_137),
	.Y(n_400));
   NAND2_X1M_A9PP140ZTL_C30 g2872557 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_156),
	.B(n_75),
	.Y(n_399));
   NAND2_X1M_A9PP140ZTL_C30 g2872558 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_156),
	.B(n_64),
	.Y(n_398));
   OAI21_X1M_A9PP140ZTL_C30 g2872559 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_49),
	.A1(signed_mag_0_abs_re_stage1[7]),
	.B0(n_130),
	.Y(n_397));
   NOR2_X1A_A9PP140ZTL_C30 g2872560 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_137),
	.B(n_75),
	.Y(n_396));
   NOR2_X1A_A9PP140ZTL_C30 g2872561 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_137),
	.B(n_64),
	.Y(n_395));
   OAI21_X1M_A9PP140ZTL_C30 g2872562 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_46),
	.A1(signed_mag_0_abs_re_stage1[7]),
	.B0(n_130),
	.Y(n_394));
   OAI21_X1M_A9PP140ZTL_C30 g2872563 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_76),
	.A1(FE_OFN134_signed_mag_0_abs_re_stage1_5),
	.B0(n_150),
	.Y(n_393));
   OAI21_X1M_A9PP140ZTL_C30 g2872564 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN306_n_77),
	.A1(FE_OFN134_signed_mag_0_abs_re_stage1_5),
	.B0(n_150),
	.Y(n_392));
   OAI21_X1M_A9PP140ZTL_C30 g2872565 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN307_n_79),
	.A1(FE_OFN134_signed_mag_0_abs_re_stage1_5),
	.B0(n_150),
	.Y(n_391));
   OAI21_X1M_A9PP140ZTL_C30 g2872566 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_76),
	.A1(signed_mag_0_abs_re_stage1[6]),
	.B0(n_132),
	.Y(n_390));
   OAI21_X1M_A9PP140ZTL_C30 g2872567 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN307_n_79),
	.A1(signed_mag_0_abs_re_stage1[6]),
	.B0(n_132),
	.Y(n_389));
   OAI21_X1M_A9PP140ZTL_C30 g2872568 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN306_n_77),
	.A1(signed_mag_0_abs_re_stage1[6]),
	.B0(n_132),
	.Y(n_388));
   OAI21_X1M_A9PP140ZTL_C30 g2872569 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_80),
	.A1(signed_mag_0_abs_im_stage1[6]),
	.B0(n_134),
	.Y(n_387));
   OAI21_X1M_A9PP140ZTL_C30 g2872570 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_78),
	.A1(signed_mag_0_abs_im_stage1[6]),
	.B0(n_134),
	.Y(n_386));
   OAI21_X1M_A9PP140ZTL_C30 g2872571 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_81),
	.A1(signed_mag_0_abs_im_stage1[6]),
	.B0(n_134),
	.Y(n_385));
   OAI21_X1M_A9PP140ZTL_C30 g2872572 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_66),
	.A1(FE_OFN134_signed_mag_0_abs_re_stage1_5),
	.B0(n_150),
	.Y(n_384));
   OAI21_X1M_A9PP140ZTL_C30 g2872573 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_71),
	.A1(FE_OFN134_signed_mag_0_abs_re_stage1_5),
	.B0(n_150),
	.Y(n_383));
   OAI21_X1M_A9PP140ZTL_C30 g2872574 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_66),
	.A1(signed_mag_0_abs_re_stage1[6]),
	.B0(n_132),
	.Y(n_382));
   OAI21_X1M_A9PP140ZTL_C30 g2872575 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_71),
	.A1(signed_mag_0_abs_re_stage1[6]),
	.B0(n_132),
	.Y(n_381));
   OAI21_X1M_A9PP140ZTL_C30 g2872576 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_70),
	.A1(signed_mag_0_abs_im_stage1[6]),
	.B0(n_134),
	.Y(n_380));
   OAI21_X1M_A9PP140ZTL_C30 g2872577 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_65),
	.A1(signed_mag_0_abs_im_stage1[6]),
	.B0(n_134),
	.Y(n_379));
   OAI21_X1M_A9PP140ZTL_C30 g2872578 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN307_n_79),
	.A1(FE_OFN136_signed_mag_0_abs_re_stage1_4),
	.B0(n_154),
	.Y(n_378));
   OAI21_X1M_A9PP140ZTL_C30 g2872579 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_76),
	.A1(FE_OFN136_signed_mag_0_abs_re_stage1_4),
	.B0(n_154),
	.Y(n_377));
   OAI21_X1M_A9PP140ZTL_C30 g2872580 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN306_n_77),
	.A1(FE_OFN136_signed_mag_0_abs_re_stage1_4),
	.B0(n_154),
	.Y(n_376));
   OAI21_X1M_A9PP140ZTL_C30 g2872581 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_66),
	.A1(FE_OFN136_signed_mag_0_abs_re_stage1_4),
	.B0(n_154),
	.Y(n_375));
   OAI21_X1M_A9PP140ZTL_C30 g2872582 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_71),
	.A1(FE_OFN136_signed_mag_0_abs_re_stage1_4),
	.B0(n_154),
	.Y(n_374));
   OAI21_X1M_A9PP140ZTL_C30 g2872583 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN306_n_77),
	.A1(signed_mag_0_abs_re_stage1[7]),
	.B0(n_130),
	.Y(n_373));
   OAI21_X1M_A9PP140ZTL_C30 g2872584 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN307_n_79),
	.A1(signed_mag_0_abs_re_stage1[7]),
	.B0(n_130),
	.Y(n_372));
   OAI21_X1M_A9PP140ZTL_C30 g2872585 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_76),
	.A1(signed_mag_0_abs_re_stage1[7]),
	.B0(n_130),
	.Y(n_371));
   OAI21_X1M_A9PP140ZTL_C30 g2872586 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_71),
	.A1(signed_mag_0_abs_re_stage1[7]),
	.B0(n_130),
	.Y(n_370));
   OAI21_X1M_A9PP140ZTL_C30 g2872587 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_66),
	.A1(signed_mag_0_abs_re_stage1[7]),
	.B0(n_130),
	.Y(n_369));
   OAI21_X1M_A9PP140ZTL_C30 g2872588 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_60),
	.A1(n_84),
	.B0(n_141),
	.Y(n_368));
   OAI21_X1M_A9PP140ZTL_C30 g2872589 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN134_signed_mag_0_abs_re_stage1_5),
	.A1(FE_OFN301_signed_mag_0_abs_re_stage1_3),
	.B0(n_150),
	.Y(n_367));
   OAI21_X1M_A9PP140ZTL_C30 g2872590 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN127_signed_mag_0_abs_im_stage1_3),
	.A1(signed_mag_0_abs_im_stage1[6]),
	.B0(n_134),
	.Y(n_366));
   OAI21_X1M_A9PP140ZTL_C30 g2872591 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN301_signed_mag_0_abs_re_stage1_3),
	.A1(signed_mag_0_abs_re_stage1[6]),
	.B0(n_132),
	.Y(n_365));
   OAI21_X1M_A9PP140ZTL_C30 g2872592 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN301_signed_mag_0_abs_re_stage1_3),
	.A1(FE_OFN136_signed_mag_0_abs_re_stage1_4),
	.B0(n_154),
	.Y(n_364));
   OAI21_X1M_A9PP140ZTL_C30 g2872593 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_106),
	.A1(n_48),
	.B0(n_148),
	.Y(n_363));
   OAI21_X1M_A9PP140ZTL_C30 g2872594 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_107),
	.A1(n_60),
	.B0(n_144),
	.Y(n_362));
   OAI21_X1M_A9PP140ZTL_C30 g2872595 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_60),
	.A1(n_109),
	.B0(n_146),
	.Y(n_361));
   OAI21_X1M_A9PP140ZTL_C30 g2872596 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_48),
	.A1(n_108),
	.B0(n_152),
	.Y(n_360));
   OAI21_X1M_A9PP140ZTL_C30 g2872597 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_93),
	.A1(n_84),
	.B0(n_141),
	.Y(n_359));
   OAI21_X1M_A9PP140ZTL_C30 g2872598 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(signed_mag_0_abs_re_stage1[7]),
	.A1(FE_OFN301_signed_mag_0_abs_re_stage1_3),
	.B0(n_130),
	.Y(n_358));
   OAI21_X1M_A9PP140ZTL_C30 g2872599 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_48),
	.A1(n_104),
	.B0(n_128),
	.Y(n_357));
   OAI21_X1M_A9PP140ZTL_C30 g2872600 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_100),
	.A1(n_48),
	.B0(n_126),
	.Y(n_356));
   OAI21_X1M_A9PP140ZTL_C30 g2872601 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN307_n_79),
	.A1(n_98),
	.B0(signed_mag_0_abs_re_stage1[7]),
	.Y(n_355));
   OAI21_X1M_A9PP140ZTL_C30 g2872602 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN306_n_77),
	.A1(n_98),
	.B0(signed_mag_0_abs_re_stage1[7]),
	.Y(n_354));
   OAI21_X1M_A9PP140ZTL_C30 g2872603 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_76),
	.A1(n_98),
	.B0(signed_mag_0_abs_re_stage1[7]),
	.Y(n_353));
   OAI21_X1M_A9PP140ZTL_C30 g2872604 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_80),
	.A1(n_101),
	.B0(signed_mag_0_abs_im_stage1[7]),
	.Y(n_352));
   OAI21_X1M_A9PP140ZTL_C30 g2872605 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_78),
	.A1(n_101),
	.B0(signed_mag_0_abs_im_stage1[7]),
	.Y(n_351));
   OAI21_X1M_A9PP140ZTL_C30 g2872606 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_81),
	.A1(n_101),
	.B0(signed_mag_0_abs_im_stage1[7]),
	.Y(n_350));
   OAI21_X1M_A9PP140ZTL_C30 g2872607 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_93),
	.A1(n_107),
	.B0(n_144),
	.Y(n_349));
   OAI21_X1M_A9PP140ZTL_C30 g2872608 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_92),
	.A1(n_106),
	.B0(n_148),
	.Y(n_348));
   OAI21_X1M_A9PP140ZTL_C30 g2872609 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_93),
	.A1(n_109),
	.B0(n_146),
	.Y(n_347));
   OAI21_X1M_A9PP140ZTL_C30 g2872610 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_92),
	.A1(n_108),
	.B0(n_152),
	.Y(n_346));
   OAI21_X1M_A9PP140ZTL_C30 g2872611 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_66),
	.A1(n_98),
	.B0(signed_mag_0_abs_re_stage1[7]),
	.Y(n_345));
   OAI21_X1M_A9PP140ZTL_C30 g2872612 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_71),
	.A1(n_98),
	.B0(signed_mag_0_abs_re_stage1[7]),
	.Y(n_344));
   OAI21_X1M_A9PP140ZTL_C30 g2872613 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_70),
	.A1(n_101),
	.B0(signed_mag_0_abs_im_stage1[7]),
	.Y(n_343));
   OAI21_X1M_A9PP140ZTL_C30 g2872614 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_65),
	.A1(n_101),
	.B0(signed_mag_0_abs_im_stage1[7]),
	.Y(n_342));
   OAI21_X1M_A9PP140ZTL_C30 g2872615 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_84),
	.A1(n_58),
	.B0(n_141),
	.Y(n_341));
   OAI21_X1M_A9PP140ZTL_C30 g2872616 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_49),
	.A1(FE_OFN134_signed_mag_0_abs_re_stage1_5),
	.B0(n_150),
	.Y(n_340));
   OAI21_X1M_A9PP140ZTL_C30 g2872617 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_46),
	.A1(FE_OFN134_signed_mag_0_abs_re_stage1_5),
	.B0(n_150),
	.Y(n_339));
   OAI21_X1M_A9PP140ZTL_C30 g2872618 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN306_n_77),
	.A1(n_95),
	.B0(n_159),
	.Y(n_338));
   OAI21_X1M_A9PP140ZTL_C30 g2872619 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN307_n_79),
	.A1(n_95),
	.B0(n_159),
	.Y(n_337));
   OAI21_X1M_A9PP140ZTL_C30 g2872620 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_76),
	.A1(n_95),
	.B0(n_159),
	.Y(n_336));
   OAI21_X1M_A9PP140ZTL_C30 g2872621 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_103),
	.A1(n_48),
	.B0(n_95),
	.Y(n_335));
   OAI21_X1M_A9PP140ZTL_C30 g2872622 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_49),
	.A1(signed_mag_0_abs_re_stage1[6]),
	.B0(n_132),
	.Y(n_334));
   OAI21_X1M_A9PP140ZTL_C30 g2872623 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_46),
	.A1(signed_mag_0_abs_re_stage1[6]),
	.B0(n_132),
	.Y(n_333));
   OAI21_X1M_A9PP140ZTL_C30 g2872624 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_47),
	.A1(signed_mag_0_abs_im_stage1[6]),
	.B0(n_134),
	.Y(n_332));
   OAI21_X1M_A9PP140ZTL_C30 g2872625 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_45),
	.A1(signed_mag_0_abs_im_stage1[6]),
	.B0(n_134),
	.Y(n_331));
   OAI21_X1M_A9PP140ZTL_C30 g2872626 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_92),
	.A1(n_104),
	.B0(n_128),
	.Y(n_330));
   OAI21_X1M_A9PP140ZTL_C30 g2872627 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_48),
	.A1(n_95),
	.B0(n_159),
	.Y(n_329));
   OAI21_X1M_A9PP140ZTL_C30 g2872628 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_71),
	.A1(n_95),
	.B0(n_159),
	.Y(n_328));
   OAI21_X1M_A9PP140ZTL_C30 g2872629 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_66),
	.A1(n_95),
	.B0(n_159),
	.Y(n_327));
   OAI21_X1M_A9PP140ZTL_C30 g2872630 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_101),
	.A1(n_60),
	.B0(signed_mag_0_abs_im_stage1[7]),
	.Y(n_326));
   OAI21_X1M_A9PP140ZTL_C30 g2872631 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_98),
	.A1(n_48),
	.B0(signed_mag_0_abs_re_stage1[7]),
	.Y(n_325));
   OAI21_X1M_A9PP140ZTL_C30 g2872632 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_92),
	.A1(n_100),
	.B0(n_126),
	.Y(n_324));
   OAI21_X1M_A9PP140ZTL_C30 g2872633 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_46),
	.A1(FE_OFN136_signed_mag_0_abs_re_stage1_4),
	.B0(n_154),
	.Y(n_323));
   OAI21_X1M_A9PP140ZTL_C30 g2872634 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_49),
	.A1(FE_OFN136_signed_mag_0_abs_re_stage1_4),
	.B0(n_154),
	.Y(n_322));
   OAI21_X1M_A9PP140ZTL_C30 g2872635 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_103),
	.A1(n_92),
	.B0(n_95),
	.Y(n_321));
   OR2_X1M_A9PP140ZTL_C30 g2872636 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_136),
	.B(signed_mag_0_abs_im_stage1[4]),
	.Y(n_451));
   AND2_X1M_A9PP140ZTL_C30 g2872637 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_157),
	.B(n_136),
	.Y(n_450));
   AND2_X1M_A9PP140ZTL_C30 g2872638 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_160),
	.B(n_136),
	.Y(n_448));
   NOR2_X1A_A9PP140ZTL_C30 g2872639 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_87),
	.B(n_142),
	.Y(n_446));
   NOR2_X1A_A9PP140ZTL_C30 g2872640 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_142),
	.B(n_83),
	.Y(n_444));
   OR2_X1M_A9PP140ZTL_C30 g2872641 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_88),
	.B(n_136),
	.Y(n_442));
   NOR2_X1A_A9PP140ZTL_C30 g2872642 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_142),
	.B(n_73),
	.Y(n_440));
   OA1B2_X1M_A9PP140ZTL_C30 g2872643 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0N(n_135),
	.B0(n_88),
	.B1(n_105),
	.Y(n_438));
   OR2_X1M_A9PP140ZTL_C30 g2872644 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_136),
	.B(signed_mag_0_abs_im_stage1[5]),
	.Y(n_436));
   OR2_X1M_A9PP140ZTL_C30 g2872645 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_84),
	.B(n_136),
	.Y(n_433));
   OAI21_X1M_A9PP140ZTL_C30 g2872646 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_98),
	.A1(FE_OFN302_n_51),
	.B0(signed_mag_0_abs_re_stage1[7]),
	.Y(n_320));
   OAI21_X1M_A9PP140ZTL_C30 g2872647 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN307_n_79),
	.A1(n_103),
	.B0(n_95),
	.Y(n_319));
   OAI21_X1M_A9PP140ZTL_C30 g2872648 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_76),
	.A1(n_103),
	.B0(n_95),
	.Y(n_318));
   OAI21_X1M_A9PP140ZTL_C30 g2872649 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_107),
	.A1(n_58),
	.B0(n_144),
	.Y(n_317));
   OAI21_X1M_A9PP140ZTL_C30 g2872650 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_106),
	.A1(n_57),
	.B0(n_148),
	.Y(n_316));
   OAI21_X1M_A9PP140ZTL_C30 g2872651 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_95),
	.A1(FE_OFN301_signed_mag_0_abs_re_stage1_3),
	.B0(n_159),
	.Y(n_315));
   OAI21_X1M_A9PP140ZTL_C30 g2872652 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_109),
	.A1(n_58),
	.B0(n_146),
	.Y(n_314));
   OAI21_X1M_A9PP140ZTL_C30 g2872653 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_108),
	.A1(n_57),
	.B0(n_152),
	.Y(n_313));
   OAI21_X1M_A9PP140ZTL_C30 g2872654 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_71),
	.A1(n_103),
	.B0(n_95),
	.Y(n_312));
   OAI21_X1M_A9PP140ZTL_C30 g2872655 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_66),
	.A1(n_103),
	.B0(n_95),
	.Y(n_311));
   OAI21_X1M_A9PP140ZTL_C30 g2872656 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_106),
	.A1(FE_OFN302_n_51),
	.B0(n_148),
	.Y(n_310));
   OAI21_X1M_A9PP140ZTL_C30 g2872657 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_107),
	.A1(FE_OFN304_n_53),
	.B0(n_144),
	.Y(n_309));
   OAI21_X1M_A9PP140ZTL_C30 g2872658 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_109),
	.A1(FE_OFN304_n_53),
	.B0(n_146),
	.Y(n_308));
   OAI21_X1M_A9PP140ZTL_C30 g2872659 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_108),
	.A1(FE_OFN302_n_51),
	.B0(n_152),
	.Y(n_307));
   OAI21_X1M_A9PP140ZTL_C30 g2872660 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_67),
	.A1(n_107),
	.B0(n_144),
	.Y(n_306));
   OAI21_X1M_A9PP140ZTL_C30 g2872661 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_68),
	.A1(n_106),
	.B0(n_148),
	.Y(n_305));
   OAI21_X1M_A9PP140ZTL_C30 g2872662 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_67),
	.A1(n_109),
	.B0(n_146),
	.Y(n_304));
   OAI21_X1M_A9PP140ZTL_C30 g2872663 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_68),
	.A1(n_108),
	.B0(n_152),
	.Y(n_303));
   OAI21_X1M_A9PP140ZTL_C30 g2872664 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_69),
	.A1(n_84),
	.B0(n_141),
	.Y(n_302));
   OAI21_X1M_A9PP140ZTL_C30 g2872665 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_104),
	.A1(n_57),
	.B0(n_128),
	.Y(n_301));
   OAI21_X1M_A9PP140ZTL_C30 g2872666 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_74),
	.A1(n_84),
	.B0(n_141),
	.Y(n_300));
   OAI21_X1M_A9PP140ZTL_C30 g2872667 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_100),
	.A1(n_57),
	.B0(n_126),
	.Y(n_299));
   OAI21_X1M_A9PP140ZTL_C30 g2872668 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN306_n_77),
	.A1(n_104),
	.B0(n_128),
	.Y(n_298));
   OAI21_X1M_A9PP140ZTL_C30 g2872669 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN307_n_79),
	.A1(n_104),
	.B0(n_128),
	.Y(n_297));
   OAI21_X1M_A9PP140ZTL_C30 g2872670 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_76),
	.A1(n_104),
	.B0(n_128),
	.Y(n_296));
   OAI21_X1M_A9PP140ZTL_C30 g2872671 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_104),
	.A1(FE_OFN302_n_51),
	.B0(n_128),
	.Y(n_295));
   OAI21_X1M_A9PP140ZTL_C30 g2872672 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_100),
	.A1(FE_OFN302_n_51),
	.B0(n_126),
	.Y(n_294));
   OAI21_X1M_A9PP140ZTL_C30 g2872673 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN306_n_77),
	.A1(n_100),
	.B0(n_126),
	.Y(n_293));
   OAI21_X1M_A9PP140ZTL_C30 g2872674 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN307_n_79),
	.A1(n_100),
	.B0(n_126),
	.Y(n_292));
   OAI21_X1M_A9PP140ZTL_C30 g2872675 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_76),
	.A1(n_100),
	.B0(n_126),
	.Y(n_291));
   OAI21_X1M_A9PP140ZTL_C30 g2872676 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_68),
	.A1(n_104),
	.B0(n_128),
	.Y(n_290));
   OAI21_X1M_A9PP140ZTL_C30 g2872677 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_71),
	.A1(n_104),
	.B0(n_128),
	.Y(n_289));
   OAI21_X1M_A9PP140ZTL_C30 g2872678 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_66),
	.A1(n_104),
	.B0(n_128),
	.Y(n_288));
   OAI21_X1M_A9PP140ZTL_C30 g2872679 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_68),
	.A1(n_100),
	.B0(n_126),
	.Y(n_287));
   OAI21_X1M_A9PP140ZTL_C30 g2872680 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_71),
	.A1(n_100),
	.B0(n_126),
	.Y(n_286));
   OAI21_X1M_A9PP140ZTL_C30 g2872681 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_66),
	.A1(n_100),
	.B0(n_126),
	.Y(n_285));
   OAI21_X1M_A9PP140ZTL_C30 g2872682 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_75),
	.A1(n_106),
	.B0(n_148),
	.Y(n_284));
   OAI21_X1M_A9PP140ZTL_C30 g2872683 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_69),
	.A1(n_107),
	.B0(n_144),
	.Y(n_283));
   OAI21_X1M_A9PP140ZTL_C30 g2872684 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_74),
	.A1(n_107),
	.B0(n_144),
	.Y(n_282));
   OAI21_X1M_A9PP140ZTL_C30 g2872685 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_64),
	.A1(n_106),
	.B0(n_148),
	.Y(n_281));
   OAI21_X1M_A9PP140ZTL_C30 g2872686 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_103),
	.A1(n_57),
	.B0(n_95),
	.Y(n_280));
   OAI21_X1M_A9PP140ZTL_C30 g2872687 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_69),
	.A1(n_109),
	.B0(n_146),
	.Y(n_279));
   OAI21_X1M_A9PP140ZTL_C30 g2872688 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_75),
	.A1(n_108),
	.B0(n_152),
	.Y(n_278));
   OAI21_X1M_A9PP140ZTL_C30 g2872689 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_80),
	.A1(n_84),
	.B0(n_141),
	.Y(n_277));
   OAI21_X1M_A9PP140ZTL_C30 g2872690 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_78),
	.A1(n_84),
	.B0(n_141),
	.Y(n_276));
   OAI21_X1M_A9PP140ZTL_C30 g2872691 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_81),
	.A1(n_84),
	.B0(n_141),
	.Y(n_275));
   OAI21_X1M_A9PP140ZTL_C30 g2872692 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_64),
	.A1(n_108),
	.B0(n_152),
	.Y(n_274));
   OAI21_X1M_A9PP140ZTL_C30 g2872693 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_74),
	.A1(n_109),
	.B0(n_146),
	.Y(n_273));
   OAI21_X1M_A9PP140ZTL_C30 g2872694 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_49),
	.A1(n_98),
	.B0(signed_mag_0_abs_re_stage1[7]),
	.Y(n_272));
   OAI21_X1M_A9PP140ZTL_C30 g2872695 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_46),
	.A1(n_98),
	.B0(signed_mag_0_abs_re_stage1[7]),
	.Y(n_271));
   OAI21_X1M_A9PP140ZTL_C30 g2872696 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_47),
	.A1(n_101),
	.B0(signed_mag_0_abs_im_stage1[7]),
	.Y(n_270));
   OAI21_X1M_A9PP140ZTL_C30 g2872697 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_45),
	.A1(n_101),
	.B0(signed_mag_0_abs_im_stage1[7]),
	.Y(n_269));
   OAI21_X1M_A9PP140ZTL_C30 g2872698 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_95),
	.A1(n_57),
	.B0(n_159),
	.Y(n_268));
   OAI21_X1M_A9PP140ZTL_C30 g2872699 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_103),
	.A1(FE_OFN301_signed_mag_0_abs_re_stage1_3),
	.B0(n_95),
	.Y(n_267));
   OAI21_X1M_A9PP140ZTL_C30 g2872700 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_78),
	.A1(n_107),
	.B0(n_144),
	.Y(n_266));
   OAI21_X1M_A9PP140ZTL_C30 g2872701 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_76),
	.A1(n_106),
	.B0(n_148),
	.Y(n_265));
   OAI21_X1M_A9PP140ZTL_C30 g2872702 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_80),
	.A1(n_107),
	.B0(n_144),
	.Y(n_264));
   OAI21_X1M_A9PP140ZTL_C30 g2872703 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN306_n_77),
	.A1(n_106),
	.B0(n_148),
	.Y(n_263));
   OAI21_X1M_A9PP140ZTL_C30 g2872704 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_81),
	.A1(n_107),
	.B0(n_144),
	.Y(n_262));
   OAI21_X1M_A9PP140ZTL_C30 g2872705 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN307_n_79),
	.A1(n_106),
	.B0(n_148),
	.Y(n_261));
   OAI21_X1M_A9PP140ZTL_C30 g2872706 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_65),
	.A1(n_84),
	.B0(n_141),
	.Y(n_260));
   OAI21_X1M_A9PP140ZTL_C30 g2872707 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_70),
	.A1(n_84),
	.B0(n_141),
	.Y(n_259));
   OAI21_X1M_A9PP140ZTL_C30 g2872708 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_103),
	.A1(FE_OFN302_n_51),
	.B0(n_95),
	.Y(n_258));
   OAI21_X1M_A9PP140ZTL_C30 g2872709 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_98),
	.A1(n_57),
	.B0(signed_mag_0_abs_re_stage1[7]),
	.Y(n_257));
   OAI21_X1M_A9PP140ZTL_C30 g2872710 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_101),
	.A1(n_58),
	.B0(signed_mag_0_abs_im_stage1[7]),
	.Y(n_256));
   OAI21_X1M_A9PP140ZTL_C30 g2872711 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_48),
	.A1(signed_mag_0_abs_re_stage1[7]),
	.B0(n_130),
	.Y(n_255));
   OAI21_X1M_A9PP140ZTL_C30 g2872712 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN306_n_77),
	.A1(n_108),
	.B0(n_152),
	.Y(n_254));
   OAI21_X1M_A9PP140ZTL_C30 g2872713 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN307_n_79),
	.A1(n_108),
	.B0(n_152),
	.Y(n_253));
   OAI21_X1M_A9PP140ZTL_C30 g2872714 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_80),
	.A1(n_109),
	.B0(n_146),
	.Y(n_252));
   OAI21_X1M_A9PP140ZTL_C30 g2872715 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_76),
	.A1(n_108),
	.B0(n_152),
	.Y(n_251));
   OAI21_X1M_A9PP140ZTL_C30 g2872716 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_78),
	.A1(n_109),
	.B0(n_146),
	.Y(n_250));
   OAI21_X1M_A9PP140ZTL_C30 g2872717 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_81),
	.A1(n_109),
	.B0(n_146),
	.Y(n_249));
   OAI21_X1M_A9PP140ZTL_C30 g2872718 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_103),
	.A1(n_68),
	.B0(n_95),
	.Y(n_248));
   OAI21_X1M_A9PP140ZTL_C30 g2872719 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_95),
	.A1(FE_OFN302_n_51),
	.B0(n_159),
	.Y(n_247));
   OAI21_X1M_A9PP140ZTL_C30 g2872720 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_71),
	.A1(n_106),
	.B0(n_148),
	.Y(n_246));
   OAI21_X1M_A9PP140ZTL_C30 g2872721 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_70),
	.A1(n_107),
	.B0(n_144),
	.Y(n_245));
   OAI21_X1M_A9PP140ZTL_C30 g2872722 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_65),
	.A1(n_107),
	.B0(n_144),
	.Y(n_244));
   OAI21_X1M_A9PP140ZTL_C30 g2872723 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_66),
	.A1(n_106),
	.B0(n_148),
	.Y(n_243));
   OAI21_X1M_A9PP140ZTL_C30 g2872724 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_101),
	.A1(n_53),
	.B0(signed_mag_0_abs_im_stage1[7]),
	.Y(n_242));
   OAI21_X1M_A9PP140ZTL_C30 g2872725 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN306_n_77),
	.A1(n_103),
	.B0(n_95),
	.Y(n_241));
   OAI21_X1M_A9PP140ZTL_C30 g2872726 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_75),
	.A1(n_104),
	.B0(n_128),
	.Y(n_240));
   OAI21_X1M_A9PP140ZTL_C30 g2872727 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_68),
	.A1(n_95),
	.B0(n_159),
	.Y(n_239));
   OAI21_X1M_A9PP140ZTL_C30 g2872728 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_64),
	.A1(n_104),
	.B0(n_128),
	.Y(n_238));
   OAI21_X1M_A9PP140ZTL_C30 g2872729 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_71),
	.A1(n_108),
	.B0(n_152),
	.Y(n_237));
   OAI21_X1M_A9PP140ZTL_C30 g2872730 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_66),
	.A1(n_108),
	.B0(n_152),
	.Y(n_236));
   OAI21_X1M_A9PP140ZTL_C30 g2872731 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_70),
	.A1(n_109),
	.B0(n_146),
	.Y(n_235));
   OAI21_X1M_A9PP140ZTL_C30 g2872732 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_65),
	.A1(n_109),
	.B0(n_146),
	.Y(n_234));
   OAI21_X1M_A9PP140ZTL_C30 g2872733 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_49),
	.A1(n_95),
	.B0(n_159),
	.Y(n_233));
   OAI21_X1M_A9PP140ZTL_C30 g2872734 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_46),
	.A1(n_95),
	.B0(n_159),
	.Y(n_232));
   OAI21_X1M_A9PP140ZTL_C30 g2872735 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_98),
	.A1(n_68),
	.B0(signed_mag_0_abs_re_stage1[7]),
	.Y(n_231));
   OAI21_X1M_A9PP140ZTL_C30 g2872736 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_101),
	.A1(n_67),
	.B0(signed_mag_0_abs_im_stage1[7]),
	.Y(n_230));
   OAI21_X1M_A9PP140ZTL_C30 g2872737 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_75),
	.A1(n_100),
	.B0(n_126),
	.Y(n_229));
   OAI21_X1M_A9PP140ZTL_C30 g2872738 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_64),
	.A1(FE_OFN134_signed_mag_0_abs_re_stage1_5),
	.B0(n_150),
	.Y(n_228));
   OAI21_X1M_A9PP140ZTL_C30 g2872739 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_64),
	.A1(n_100),
	.B0(n_126),
	.Y(n_227));
   OAI21_X1M_A9PP140ZTL_C30 g2872740 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_75),
	.A1(FE_OFN134_signed_mag_0_abs_re_stage1_5),
	.B0(n_150),
	.Y(n_226));
   OAI21_X1M_A9PP140ZTL_C30 g2872741 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_74),
	.A1(signed_mag_0_abs_im_stage1[6]),
	.B0(n_134),
	.Y(n_225));
   OAI21_X1M_A9PP140ZTL_C30 g2872742 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_64),
	.A1(signed_mag_0_abs_re_stage1[6]),
	.B0(n_132),
	.Y(n_224));
   OAI21_X1M_A9PP140ZTL_C30 g2872743 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_75),
	.A1(signed_mag_0_abs_re_stage1[6]),
	.B0(n_132),
	.Y(n_223));
   OAI21_X1M_A9PP140ZTL_C30 g2872744 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_69),
	.A1(signed_mag_0_abs_im_stage1[6]),
	.B0(n_134),
	.Y(n_222));
   OAI21_X1M_A9PP140ZTL_C30 g2872745 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_64),
	.A1(FE_OFN136_signed_mag_0_abs_re_stage1_4),
	.B0(n_154),
	.Y(n_221));
   OAI21_X1M_A9PP140ZTL_C30 g2872746 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_104),
	.A1(FE_OFN301_signed_mag_0_abs_re_stage1_3),
	.B0(n_128),
	.Y(n_220));
   OAI21_X1M_A9PP140ZTL_C30 g2872747 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_75),
	.A1(FE_OFN136_signed_mag_0_abs_re_stage1_4),
	.B0(n_154),
	.Y(n_219));
   OAI21_X1M_A9PP140ZTL_C30 g2872748 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_92),
	.A1(signed_mag_0_abs_re_stage1[7]),
	.B0(n_130),
	.Y(n_218));
   OAI21_X1M_A9PP140ZTL_C30 g2872749 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_103),
	.A1(n_75),
	.B0(n_95),
	.Y(n_217));
   OAI21_X1M_A9PP140ZTL_C30 g2872750 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_100),
	.A1(FE_OFN301_signed_mag_0_abs_re_stage1_3),
	.B0(n_126),
	.Y(n_216));
   OAI21_X1M_A9PP140ZTL_C30 g2872751 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_103),
	.A1(n_64),
	.B0(n_95),
	.Y(n_215));
   OAI21_X1M_A9PP140ZTL_C30 g2872752 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_75),
	.A1(n_95),
	.B0(n_159),
	.Y(n_214));
   OAI21_X1M_A9PP140ZTL_C30 g2872753 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_98),
	.A1(n_64),
	.B0(signed_mag_0_abs_re_stage1[7]),
	.Y(n_213));
   OAI21_X1M_A9PP140ZTL_C30 g2872754 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_101),
	.A1(n_74),
	.B0(signed_mag_0_abs_im_stage1[7]),
	.Y(n_212));
   OAI21_X1M_A9PP140ZTL_C30 g2872755 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_101),
	.A1(n_69),
	.B0(signed_mag_0_abs_im_stage1[7]),
	.Y(n_211));
   OAI21_X1M_A9PP140ZTL_C30 g2872756 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_98),
	.A1(n_75),
	.B0(signed_mag_0_abs_re_stage1[7]),
	.Y(n_210));
   OAI21_X1M_A9PP140ZTL_C30 g2872757 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_64),
	.A1(n_95),
	.B0(n_159),
	.Y(n_209));
   OAI21_X1M_A9PP140ZTL_C30 g2872758 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_68),
	.A1(FE_OFN134_signed_mag_0_abs_re_stage1_5),
	.B0(n_150),
	.Y(n_208));
   OAI21_X1M_A9PP140ZTL_C30 g2872759 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_84),
	.A1(FE_OFN127_signed_mag_0_abs_im_stage1_3),
	.B0(n_141),
	.Y(n_207));
   OAI21_X1M_A9PP140ZTL_C30 g2872760 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_64),
	.A1(signed_mag_0_abs_re_stage1[7]),
	.B0(n_130),
	.Y(n_206));
   OAI21_X1M_A9PP140ZTL_C30 g2872761 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_75),
	.A1(signed_mag_0_abs_re_stage1[7]),
	.B0(n_130),
	.Y(n_205));
   OAI21_X1M_A9PP140ZTL_C30 g2872762 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_68),
	.A1(signed_mag_0_abs_re_stage1[6]),
	.B0(n_132),
	.Y(n_204));
   OAI21_X1M_A9PP140ZTL_C30 g2872763 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_67),
	.A1(signed_mag_0_abs_im_stage1[6]),
	.B0(n_134),
	.Y(n_203));
   OAI21_X1M_A9PP140ZTL_C30 g2872764 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_51),
	.A1(FE_OFN134_signed_mag_0_abs_re_stage1_5),
	.B0(n_150),
	.Y(n_202));
   OAI21_X1M_A9PP140ZTL_C30 g2872765 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_48),
	.A1(FE_OFN136_signed_mag_0_abs_re_stage1_4),
	.B0(n_154),
	.Y(n_201));
   OAI21_X1M_A9PP140ZTL_C30 g2872766 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_107),
	.A1(FE_OFN127_signed_mag_0_abs_im_stage1_3),
	.B0(n_144),
	.Y(n_200));
   OAI21_X1M_A9PP140ZTL_C30 g2872767 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_106),
	.A1(FE_OFN301_signed_mag_0_abs_re_stage1_3),
	.B0(n_148),
	.Y(n_199));
   OAI21_X1M_A9PP140ZTL_C30 g2872768 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN302_n_51),
	.A1(signed_mag_0_abs_re_stage1[6]),
	.B0(n_132),
	.Y(n_198));
   OAI21_X1M_A9PP140ZTL_C30 g2872769 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN304_n_53),
	.A1(signed_mag_0_abs_im_stage1[6]),
	.B0(n_134),
	.Y(n_197));
   OAI21_X1M_A9PP140ZTL_C30 g2872770 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_108),
	.A1(FE_OFN301_signed_mag_0_abs_re_stage1_3),
	.B0(n_152),
	.Y(n_196));
   OAI21_X1M_A9PP140ZTL_C30 g2872771 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_109),
	.A1(FE_OFN127_signed_mag_0_abs_im_stage1_3),
	.B0(n_146),
	.Y(n_195));
   OAI21_X1M_A9PP140ZTL_C30 g2872772 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_68),
	.A1(FE_OFN136_signed_mag_0_abs_re_stage1_4),
	.B0(n_154),
	.Y(n_194));
   OAI21_X1M_A9PP140ZTL_C30 g2872773 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_57),
	.A1(FE_OFN134_signed_mag_0_abs_re_stage1_5),
	.B0(n_150),
	.Y(n_193));
   OAI21_X1M_A9PP140ZTL_C30 g2872774 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_46),
	.A1(n_103),
	.B0(n_95),
	.Y(n_192));
   OAI21_X1M_A9PP140ZTL_C30 g2872775 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_49),
	.A1(n_103),
	.B0(n_95),
	.Y(n_191));
   OAI21_X1M_A9PP140ZTL_C30 g2872776 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_51),
	.A1(FE_OFN136_signed_mag_0_abs_re_stage1_4),
	.B0(n_154),
	.Y(n_190));
   OAI21_X1M_A9PP140ZTL_C30 g2872777 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_57),
	.A1(signed_mag_0_abs_re_stage1[6]),
	.B0(n_132),
	.Y(n_189));
   OAI21_X1M_A9PP140ZTL_C30 g2872778 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_58),
	.A1(signed_mag_0_abs_im_stage1[6]),
	.B0(n_134),
	.Y(n_188));
   OAI21_X1M_A9PP140ZTL_C30 g2872779 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_60),
	.A1(signed_mag_0_abs_im_stage1[6]),
	.B0(n_134),
	.Y(n_187));
   OAI21_X1M_A9PP140ZTL_C30 g2872780 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_48),
	.A1(FE_OFN134_signed_mag_0_abs_re_stage1_5),
	.B0(n_150),
	.Y(n_186));
   OAI21_X1M_A9PP140ZTL_C30 g2872781 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_48),
	.A1(signed_mag_0_abs_re_stage1[6]),
	.B0(n_132),
	.Y(n_185));
   OAI21_X1M_A9PP140ZTL_C30 g2872782 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_68),
	.A1(signed_mag_0_abs_re_stage1[7]),
	.B0(n_130),
	.Y(n_184));
   OAI21_X1M_A9PP140ZTL_C30 g2872783 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_57),
	.A1(signed_mag_0_abs_re_stage1[7]),
	.B0(n_130),
	.Y(n_183));
   OAI21_X1M_A9PP140ZTL_C30 g2872784 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN302_n_51),
	.A1(signed_mag_0_abs_re_stage1[7]),
	.B0(n_130),
	.Y(n_182));
   OAI21_X1M_A9PP140ZTL_C30 g2872785 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_57),
	.A1(FE_OFN136_signed_mag_0_abs_re_stage1_4),
	.B0(n_154),
	.Y(n_181));
   OAI21_X1M_A9PP140ZTL_C30 g2872786 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_92),
	.A1(FE_OFN136_signed_mag_0_abs_re_stage1_4),
	.B0(n_154),
	.Y(n_180));
   OAI21_X1M_A9PP140ZTL_C30 g2872787 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_45),
	.A1(n_84),
	.B0(n_141),
	.Y(n_179));
   OAI21_X1M_A9PP140ZTL_C30 g2872788 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_47),
	.A1(n_84),
	.B0(n_141),
	.Y(n_178));
   OAI21_X1M_A9PP140ZTL_C30 g2872789 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_46),
	.A1(n_104),
	.B0(n_128),
	.Y(n_177));
   OAI21_X1M_A9PP140ZTL_C30 g2872790 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_49),
	.A1(n_104),
	.B0(n_128),
	.Y(n_176));
   OAI21_X1M_A9PP140ZTL_C30 g2872791 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_92),
	.A1(FE_OFN134_signed_mag_0_abs_re_stage1_5),
	.B0(n_150),
	.Y(n_175));
   OAI21_X1M_A9PP140ZTL_C30 g2872792 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_92),
	.A1(signed_mag_0_abs_re_stage1[6]),
	.B0(n_132),
	.Y(n_174));
   OAI21_X1M_A9PP140ZTL_C30 g2872793 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_93),
	.A1(signed_mag_0_abs_im_stage1[6]),
	.B0(n_134),
	.Y(n_173));
   OAI21_X1M_A9PP140ZTL_C30 g2872794 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_46),
	.A1(n_100),
	.B0(n_126),
	.Y(n_172));
   OAI21_X1M_A9PP140ZTL_C30 g2872795 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_49),
	.A1(n_100),
	.B0(n_126),
	.Y(n_171));
   OAI21_X1M_A9PP140ZTL_C30 g2872796 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_49),
	.A1(n_106),
	.B0(n_148),
	.Y(n_170));
   OAI21_X1M_A9PP140ZTL_C30 g2872797 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_46),
	.A1(n_106),
	.B0(n_148),
	.Y(n_169));
   OAI21_X1M_A9PP140ZTL_C30 g2872798 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_45),
	.A1(n_107),
	.B0(n_144),
	.Y(n_168));
   OAI21_X1M_A9PP140ZTL_C30 g2872799 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_47),
	.A1(n_107),
	.B0(n_144),
	.Y(n_167));
   OAI21_X1M_A9PP140ZTL_C30 g2872800 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_45),
	.A1(n_109),
	.B0(n_146),
	.Y(n_166));
   OAI21_X1M_A9PP140ZTL_C30 g2872801 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_46),
	.A1(n_108),
	.B0(n_152),
	.Y(n_165));
   OAI21_X1M_A9PP140ZTL_C30 g2872802 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_49),
	.A1(n_108),
	.B0(n_152),
	.Y(n_164));
   OAI21_X1M_A9PP140ZTL_C30 g2872803 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_47),
	.A1(n_109),
	.B0(n_146),
	.Y(n_163));
   INV_X0P8M_A9PP140ZTL_C30 g2872804 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_159),
	.Y(n_158));
   INV_X0P8M_A9PP140ZTL_C30 g2872807 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_152),
	.Y(n_151));
   INV_X0P8M_A9PP140ZTL_C30 g2872808 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_150),
	.Y(n_149));
   INV_X0P8M_A9PP140ZTL_C30 g2872809 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_148),
	.Y(n_147));
   INV_X0P8M_A9PP140ZTL_C30 g2872810 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_146),
	.Y(n_145));
   INV_X0P8M_A9PP140ZTL_C30 g2872811 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_144),
	.Y(n_143));
   INV_X1M_A9PP140ZTL_C30 g2872812 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_142),
	.Y(n_141));
   INV_X0P8M_A9PP140ZTL_C30 g2872813 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_140),
	.Y(n_139));
   INV_X0P8M_A9PP140ZTL_C30 g2872814 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_137),
	.Y(n_138));
   OR2_X1M_A9PP140ZTL_C30 g2872820 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_105),
	.B(signed_mag_0_abs_im_stage1[4]),
	.Y(n_162));
   OR2_X1M_A9PP140ZTL_C30 g2872821 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_95),
	.B(signed_mag_0_abs_re_stage1[4]),
	.Y(n_161));
   OR2_X1M_A9PP140ZTL_C30 g2872822 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_im_stage1[5]),
	.B(n_105),
	.Y(n_160));
   OR2_X1M_A9PP140ZTL_C30 g2872823 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_90),
	.B(n_95),
	.Y(n_159));
   OR2_X1M_A9PP140ZTL_C30 g2872824 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_84),
	.B(n_105),
	.Y(n_157));
   NOR2_X1A_A9PP140ZTL_C30 g2872825 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_89),
	.B(n_97),
	.Y(n_156));
   NOR2_X1A_A9PP140ZTL_C30 g2872826 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_97),
	.B(n_72),
	.Y(n_154));
   AND2_X1M_A9PP140ZTL_C30 g2872827 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_106),
	.B(signed_mag_0_abs_re_stage1[7]),
	.Y(n_152));
   NOR2_X1A_A9PP140ZTL_C30 g2872828 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_97),
	.B(n_85),
	.Y(n_150));
   AND2_X1M_A9PP140ZTL_C30 g2872829 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_98),
	.B(signed_mag_0_abs_re_stage1[7]),
	.Y(n_148));
   AND2_X1M_A9PP140ZTL_C30 g2872830 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_107),
	.B(signed_mag_0_abs_im_stage1[7]),
	.Y(n_146));
   AND2_X1M_A9PP140ZTL_C30 g2872831 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_101),
	.B(signed_mag_0_abs_im_stage1[7]),
	.Y(n_144));
   NAND2_X1M_A9PP140ZTL_C30 g2872832 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_im_stage1[6]),
	.B(signed_mag_0_abs_im_stage1[7]),
	.Y(n_142));
   OR2_X1M_A9PP140ZTL_C30 g2872833 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_95),
	.B(signed_mag_0_abs_re_stage1[5]),
	.Y(n_140));
   OR2_X1M_A9PP140ZTL_C30 g2872834 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_86),
	.B(n_95),
	.Y(n_137));
   OR2_X2M_A9PP140ZTL_C30 g2872835 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_im_stage1[7]),
	.B(signed_mag_0_abs_im_stage1[6]),
	.Y(n_136));
   INV_X0P8M_A9PP140ZTL_C30 g2872836 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_134),
	.Y(n_133));
   INV_X0P8M_A9PP140ZTL_C30 g2872837 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_132),
	.Y(n_131));
   INV_X0P8M_A9PP140ZTL_C30 g2872838 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_130),
	.Y(n_129));
   OAI21_X1M_A9PP140ZTL_C30 g2872841 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN306_n_77),
	.A1(n_86),
	.B0(n_96),
	.Y(n_124));
   OAI21_X1M_A9PP140ZTL_C30 g2872842 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_92),
	.A1(n_86),
	.B0(n_96),
	.Y(n_123));
   OAI21_X1M_A9PP140ZTL_C30 g2872843 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_86),
	.A1(n_57),
	.B0(n_96),
	.Y(n_122));
   OAI21_X1M_A9PP140ZTL_C30 g2872844 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_86),
	.A1(FE_OFN302_n_51),
	.B0(n_96),
	.Y(n_121));
   OAI21_X1M_A9PP140ZTL_C30 g2872845 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_68),
	.A1(n_86),
	.B0(n_96),
	.Y(n_120));
   OAI21_X1M_A9PP140ZTL_C30 g2872846 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_75),
	.A1(n_86),
	.B0(n_96),
	.Y(n_119));
   OAI21_X1M_A9PP140ZTL_C30 g2872847 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_64),
	.A1(n_86),
	.B0(n_96),
	.Y(n_118));
   OAI21_X1M_A9PP140ZTL_C30 g2872848 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_48),
	.A1(n_86),
	.B0(n_96),
	.Y(n_117));
   OAI21_X1M_A9PP140ZTL_C30 g2872849 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_76),
	.A1(n_86),
	.B0(n_96),
	.Y(n_116));
   OAI21_X1M_A9PP140ZTL_C30 g2872850 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(FE_OFN307_n_79),
	.A1(n_86),
	.B0(n_96),
	.Y(n_115));
   OAI21_X1M_A9PP140ZTL_C30 g2872851 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_71),
	.A1(n_86),
	.B0(n_96),
	.Y(n_114));
   OAI21_X1M_A9PP140ZTL_C30 g2872852 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_66),
	.A1(n_86),
	.B0(n_96),
	.Y(n_113));
   OAI21_X1M_A9PP140ZTL_C30 g2872853 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_86),
	.A1(signed_mag_0_abs_re_stage1[3]),
	.B0(n_96),
	.Y(n_112));
   OAI21_X1M_A9PP140ZTL_C30 g2872854 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_49),
	.A1(n_86),
	.B0(n_96),
	.Y(n_111));
   OAI21_X1M_A9PP140ZTL_C30 g2872855 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_46),
	.A1(n_86),
	.B0(n_96),
	.Y(n_110));
   OA1B2_X1M_A9PP140ZTL_C30 g2872856 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0N(FE_OFN308_signed_mag_0_abs_im_stage1_7),
	.B0(n_88),
	.B1(signed_mag_0_abs_im_stage1[6]),
	.Y(n_134));
   OA1B2_X1M_A9PP140ZTL_C30 g2872857 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0N(n_91),
	.B0(n_90),
	.B1(signed_mag_0_abs_re_stage1[6]),
	.Y(n_132));
   OA1B2_X1M_A9PP140ZTL_C30 g2872858 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0N(FE_OFN140_n_95),
	.B0(n_90),
	.B1(signed_mag_0_abs_re_stage1[7]),
	.Y(n_130));
   NOR2_X1A_A9PP140ZTL_C30 g2872859 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_99),
	.B(FE_OFN140_n_95),
	.Y(n_128));
   NOR2_X1A_A9PP140ZTL_C30 g2872860 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_102),
	.B(FE_OFN140_n_95),
	.Y(n_126));
   OR2_X1M_A9PP140ZTL_C30 g2872863 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_im_stage1[6]),
	.B(signed_mag_0_abs_im_stage1[4]),
	.Y(n_109));
   OR2_X1M_A9PP140ZTL_C30 g2872864 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_re_stage1[6]),
	.B(signed_mag_0_abs_re_stage1[4]),
	.Y(n_108));
   OR2_X1M_A9PP140ZTL_C30 g2872865 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_im_stage1[5]),
	.B(signed_mag_0_abs_im_stage1[6]),
	.Y(n_107));
   OR2_X1M_A9PP140ZTL_C30 g2872866 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_re_stage1[5]),
	.B(signed_mag_0_abs_re_stage1[6]),
	.Y(n_106));
   INV_X1M_A9PP140ZTL_C30 g2872868 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_103),
	.Y(n_102));
   INV_X1M_A9PP140ZTL_C30 g2872869 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_100),
	.Y(n_99));
   INV_X1M_A9PP140ZTL_C30 g2872870 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_97),
	.Y(n_96));
   OR2_X1M_A9PP140ZTL_C30 g2872872 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_re_stage1[7]),
	.B(signed_mag_0_abs_re_stage1[4]),
	.Y(n_104));
   OR2_X1M_A9PP140ZTL_C30 g2872873 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_86),
	.B(signed_mag_0_abs_re_stage1[7]),
	.Y(n_103));
   OR2_X1M_A9PP140ZTL_C30 g2872874 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_84),
	.B(signed_mag_0_abs_im_stage1[6]),
	.Y(n_101));
   OR2_X1M_A9PP140ZTL_C30 g2872875 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_re_stage1[5]),
	.B(signed_mag_0_abs_re_stage1[7]),
	.Y(n_100));
   OR2_X1M_A9PP140ZTL_C30 g2872876 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_86),
	.B(signed_mag_0_abs_re_stage1[6]),
	.Y(n_98));
   NAND2_X1M_A9PP140ZTL_C30 g2872877 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_re_stage1[6]),
	.B(signed_mag_0_abs_re_stage1[7]),
	.Y(n_97));
   OR2_X2M_A9PP140ZTL_C30 g2872878 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_re_stage1[7]),
	.B(signed_mag_0_abs_re_stage1[6]),
	.Y(n_95));
   INV_X0P8M_A9PP140ZTL_C30 g2872879 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_re_stage1[7]),
	.Y(n_91));
   OR2_X1M_A9PP140ZTL_C30 g2872880 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_74),
	.B(signed_mag_0_abs_im_stage1[0]),
	.Y(n_93));
   OR2_X1M_A9PP140ZTL_C30 g2872881 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_64),
	.B(signed_mag_0_abs_re_stage1[0]),
	.Y(n_92));
   INV_X0P8M_A9PP140ZTL_C30 g2872886 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_88),
	.Y(n_87));
   INV_X0P8M_A9PP140ZTL_C30 g2872887 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_86),
	.Y(n_85));
   XNOR2_X0P5M_A9PP140ZTL_C30 g2872889 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_42),
	.B(Data_Type_Conversion_out_im[7]),
	.Y(n_82));
   NOR2_X1B_A9PP140ZTL_C30 g2872890 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_72),
	.B(n_54),
	.Y(n_90));
   NOR2_X1B_A9PP140ZTL_C30 g2872891 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_73),
	.B(n_55),
	.Y(n_88));
   OR2_X2M_A9PP140ZTL_C30 g2872892 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_re_stage1[5]),
	.B(signed_mag_0_abs_re_stage1[4]),
	.Y(n_86));
   OR2_X1M_A9PP140ZTL_C30 g2872893 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_im_stage1[5]),
	.B(signed_mag_0_abs_im_stage1[4]),
	.Y(n_84));
   NOR2_X1A_A9PP140ZTL_C30 g2872896 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_30),
	.B(FE_OFN129_n_59),
	.Y(n_81));
   OR2_X1M_A9PP140ZTL_C30 g2872897 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_31),
	.B(n_53),
	.Y(n_80));
   NOR2_X1A_A9PP140ZTL_C30 g2872898 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_29),
	.B(n_56),
	.Y(n_79));
   NOR2_X1A_A9PP140ZTL_C30 g2872899 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_33),
	.B(FE_OFN129_n_59),
	.Y(n_78));
   NOR2_X1A_A9PP140ZTL_C30 g2872900 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_26),
	.B(n_56),
	.Y(n_77));
   OR2_X1M_A9PP140ZTL_C30 g2872901 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_27),
	.B(n_51),
	.Y(n_76));
   AND2_X1M_A9PP140ZTL_C30 g2872902 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_57),
	.B(signed_mag_0_abs_re_stage1[1]),
	.Y(n_75));
   OR2_X2M_A9PP140ZTL_C30 g2872903 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_53),
	.B(signed_mag_0_abs_im_stage1[1]),
	.Y(n_74));
   XOR2_X0P5M_A9PP140ZTL_C30 g2872906 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_39),
	.B(Data_Type_Conversion_out_im[6]),
	.Y(n_63));
   XNOR2_X0P5M_A9PP140ZTL_C30 g2872907 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_36),
	.B(Data_Type_Conversion_out_re[7]),
	.Y(n_62));
   XNOR2_X0P7M_A9PP140ZTL_C30 g2872908 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_35),
	.B(Data_Type_Conversion_out_re[6]),
	.Y(n_61));
   OA1B2_X1P4M_A9PP140ZTL_C30 g2872909 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0N(n_50),
	.B0(n_27),
	.B1(signed_mag_0_abs_re_stage1[3]),
	.Y(n_71));
   AOI21_X1M_A9PP140ZTL_C30 g2872910 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_33),
	.A1(FE_OFN126_signed_mag_0_abs_im_stage1_3),
	.B0(n_52),
	.Y(n_70));
   AND2_X1M_A9PP140ZTL_C30 g2872911 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_59),
	.B(signed_mag_0_abs_im_stage1[1]),
	.Y(n_69));
   OA21B_X1P4M_A9PP140ZTL_C30 g2872912 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(signed_mag_0_abs_re_stage1[3]),
	.A1(signed_mag_0_abs_re_stage1[1]),
	.B0N(n_50),
	.Y(n_68));
   OA21B_X1M_A9PP140ZTL_C30 g2872913 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(signed_mag_0_abs_im_stage1[3]),
	.A1(signed_mag_0_abs_im_stage1[1]),
	.B0N(n_52),
	.Y(n_67));
   AOI21_X1M_A9PP140ZTL_C30 g2872914 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_29),
	.A1(FE_OFN125_signed_mag_0_abs_re_stage1_3),
	.B0(n_50),
	.Y(n_66));
   OA1B2_X1M_A9PP140ZTL_C30 g2872915 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0N(n_52),
	.B0(n_31),
	.B1(signed_mag_0_abs_im_stage1[3]),
	.Y(n_65));
   OR2_X2M_A9PP140ZTL_C30 g2872916 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_51),
	.B(signed_mag_0_abs_re_stage1[1]),
	.Y(n_64));
   OA21B_X1M_A9PP140ZTL_C30 g2872923 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(signed_mag_0_abs_im_stage1[1]),
	.A1(signed_mag_0_abs_im_stage1[2]),
	.B0N(FE_OFN126_signed_mag_0_abs_im_stage1_3),
	.Y(n_60));
   AND2_X1M_A9PP140ZTL_C30 g2872924 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_im_stage1[2]),
	.B(signed_mag_0_abs_im_stage1[3]),
	.Y(n_59));
   AND2_X1M_A9PP140ZTL_C30 g2872925 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_re_stage1[2]),
	.B(signed_mag_0_abs_re_stage1[3]),
	.Y(n_57));
   OR2_X1M_A9PP140ZTL_C30 g2872928 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_im_stage1[3]),
	.B(signed_mag_0_abs_im_stage1[2]),
	.Y(n_53));
   OR2_X1M_A9PP140ZTL_C30 g2872929 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_re_stage1[3]),
	.B(signed_mag_0_abs_re_stage1[2]),
	.Y(n_51));
   XNOR2_X0P7M_A9PP140ZTL_C30 g2872930 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_22),
	.B(Data_Type_Conversion_out_re[5]),
	.Y(n_44));
   XNOR2_X0P7M_A9PP140ZTL_C30 g2872931 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_23),
	.B(Data_Type_Conversion_out_im[5]),
	.Y(n_43));
   AOI21_X1M_A9PP140ZTL_C30 g2872932 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_34),
	.A1(Data_Type_Conversion_out_im[6]),
	.B0(Data_Type_Conversion_out_im[8]),
	.Y(n_42));
   OA1B2_X1M_A9PP140ZTL_C30 g2872933 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0N(FE_OFN125_signed_mag_0_abs_re_stage1_3),
	.B0(n_28),
	.B1(signed_mag_0_abs_re_stage1[2]),
	.Y(n_49));
   OA21B_X1M_A9PP140ZTL_C30 g2872934 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(signed_mag_0_abs_re_stage1[1]),
	.A1(signed_mag_0_abs_re_stage1[2]),
	.B0N(FE_OFN125_signed_mag_0_abs_re_stage1_3),
	.Y(n_48));
   OA1B2_X1M_A9PP140ZTL_C30 g2872935 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0N(FE_OFN126_signed_mag_0_abs_im_stage1_3),
	.B0(n_32),
	.B1(signed_mag_0_abs_im_stage1[2]),
	.Y(n_47));
   OA1B2_X1M_A9PP140ZTL_C30 g2872936 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0N(FE_OFN125_signed_mag_0_abs_re_stage1_3),
	.B0(n_27),
	.B1(signed_mag_0_abs_re_stage1[2]),
	.Y(n_46));
   OA1B2_X1M_A9PP140ZTL_C30 g2872937 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0N(FE_OFN126_signed_mag_0_abs_im_stage1_3),
	.B0(n_31),
	.B1(signed_mag_0_abs_im_stage1[2]),
	.Y(n_45));
   OR2_X1B_A9PP140ZTL_C30 g2872940 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_34),
	.B(Data_Type_Conversion_out_im[8]),
	.Y(n_39));
   XOR2_X0P5M_A9PP140ZTL_C30 g2872943 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_16),
	.B(Data_Type_Conversion_out_re[4]),
	.Y(n_38));
   XOR2_X0P5M_A9PP140ZTL_C30 g2872944 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_17),
	.B(Data_Type_Conversion_out_im[4]),
	.Y(n_37));
   AOI31_X1M_A9PP140ZTL_C30 g2872945 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_20),
	.A1(Data_Type_Conversion_out_re[6]),
	.A2(Data_Type_Conversion_out_re[5]),
	.B0(n_647),
	.Y(n_36));
   AOI21_X1M_A9PP140ZTL_C30 g2872946 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A0(n_20),
	.A1(Data_Type_Conversion_out_re[5]),
	.B0(n_647),
	.Y(n_35));
   INV_X0P8M_A9PP140ZTL_C30 g2872947 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_33),
	.Y(n_32));
   INV_X1M_A9PP140ZTL_C30 g2872948 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_30),
	.Y(n_31));
   NOR2XB_X1M_A9PP140ZTL_C30 g2872949 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_21),
	.BN(Data_Type_Conversion_out_im[5]),
	.Y(n_34));
   NOR2_X1A_A9PP140ZTL_C30 g2872950 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_im_stage1[0]),
	.B(signed_mag_0_abs_im_stage1[1]),
	.Y(n_33));
   NAND2_X1M_A9PP140ZTL_C30 g2872951 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_im_stage1[0]),
	.B(signed_mag_0_abs_im_stage1[1]),
	.Y(n_30));
   INV_X0P8M_A9PP140ZTL_C30 g2872954 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_29),
	.Y(n_28));
   INV_X1M_A9PP140ZTL_C30 g2872955 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_26),
	.Y(n_27));
   XNOR2_X0P7M_A9PP140ZTL_C30 g2872956 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_10),
	.B(Data_Type_Conversion_out_re[3]),
	.Y(n_25));
   XNOR2_X0P7M_A9PP140ZTL_C30 g2872957 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_13),
	.B(Data_Type_Conversion_out_im[3]),
	.Y(n_24));
   NOR2B_X1M_A9PP140ZTL_C30 g2872958 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .AN(n_21),
	.B(Data_Type_Conversion_out_im[8]),
	.Y(n_23));
   NOR2_X1A_A9PP140ZTL_C30 g2872959 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_20),
	.B(n_647),
	.Y(n_22));
   NOR2_X1A_A9PP140ZTL_C30 g2872960 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_re_stage1[0]),
	.B(signed_mag_0_abs_re_stage1[1]),
	.Y(n_29));
   NAND2_X1M_A9PP140ZTL_C30 g2872961 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(signed_mag_0_abs_re_stage1[0]),
	.B(signed_mag_0_abs_re_stage1[1]),
	.Y(n_26));
   NAND2B_X1M_A9PP140ZTL_C30 g2872962 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .AN(n_15),
	.B(Data_Type_Conversion_out_im[4]),
	.Y(n_21));
   NOR2XB_X1M_A9PP140ZTL_C30 g2872963 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_14),
	.BN(Data_Type_Conversion_out_re[4]),
	.Y(n_20));
   XOR2_X0P5M_A9PP140ZTL_C30 g2872966 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_6),
	.B(Data_Type_Conversion_out_re[2]),
	.Y(n_19));
   XOR2_X0P5M_A9PP140ZTL_C30 g2872967 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_9),
	.B(Data_Type_Conversion_out_im[2]),
	.Y(n_18));
   NAND2XB_X1M_A9PP140ZTL_C30 g2872968 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_15),
	.BN(Data_Type_Conversion_out_im[8]),
	.Y(n_17));
   NAND2_X1M_A9PP140ZTL_C30 g2872969 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_14),
	.B(Data_Type_Conversion_out_re[8]),
	.Y(n_16));
   NAND2_X1B_A9PP140ZTL_C30 g2872970 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_8),
	.B(Data_Type_Conversion_out_im[3]),
	.Y(n_15));
   NAND2_X1M_A9PP140ZTL_C30 g2872971 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_7),
	.B(Data_Type_Conversion_out_re[3]),
	.Y(n_14));
   NOR2_X1A_A9PP140ZTL_C30 g2872972 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_8),
	.B(Data_Type_Conversion_out_im[8]),
	.Y(n_13));
   XNOR2_X0P7M_A9PP140ZTL_C30 g2872973 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_3),
	.B(Data_Type_Conversion_out_re[1]),
	.Y(n_12));
   XNOR2_X0P7M_A9PP140ZTL_C30 g2872974 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_2),
	.B(Data_Type_Conversion_out_im[1]),
	.Y(n_11));
   NOR2_X1A_A9PP140ZTL_C30 g2872975 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_7),
	.B(n_647),
	.Y(n_10));
   NAND2B_X1M_A9PP140ZTL_C30 g2872977 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .AN(Data_Type_Conversion_out_im[8]),
	.B(n_5),
	.Y(n_9));
   NOR2B_X1M_A9PP140ZTL_C30 g2872978 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .AN(Data_Type_Conversion_out_im[2]),
	.B(n_5),
	.Y(n_8));
   NAND2_X1M_A9PP140ZTL_C30 g2872979 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_4),
	.B(Data_Type_Conversion_out_re[8]),
	.Y(n_6));
   NOR2XB_X1M_A9PP140ZTL_C30 g2872980 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_4),
	.BN(Data_Type_Conversion_out_re[2]),
	.Y(n_7));
   NOR2B_X1M_A9PP140ZTL_C30 g2872984 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .AN(Data_Type_Conversion_out_re[0]),
	.B(n_647),
	.Y(n_3));
   NAND2B_X1M_A9PP140ZTL_C30 g2872985 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .AN(Data_Type_Conversion_out_im[0]),
	.B(Data_Type_Conversion_out_im[1]),
	.Y(n_5));
   NOR2B_X1M_A9PP140ZTL_C30 g2872986 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .AN(Data_Type_Conversion_out_im[0]),
	.B(Data_Type_Conversion_out_im[8]),
	.Y(n_2));
   NAND2B_X1M_A9PP140ZTL_C30 g2872987 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .AN(Data_Type_Conversion_out_re[0]),
	.B(Data_Type_Conversion_out_re[1]),
	.Y(n_4));
   INV_X1M_A9PP140ZTL_C30 g2872997 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(n_647),
	.Y(Data_Type_Conversion_out_re[8]));
   INV_X0P8M_A9PP140ZTL_C30 g2872998 (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .A(Data_Type_Conversion_out_im[8]),
	.Y(n_1));
   SDFFQL_X1M_A9PP140ZTL_C30 signed_mag_0_sign_re_stage1_reg (.VDD(VDD), .VSS(VSS), .VNW(VDD), .VPW(VSS), .CK(CTS_53),
	.D(signed_mag_0_sign_re_stage1),
	.SE(FE_PSN132_rst_n),
	.SI(Data_Type_Conversion_out_re[8]),
	.Q(signed_mag_0_sign_re_stage1));
endmodule
