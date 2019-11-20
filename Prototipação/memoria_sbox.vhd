-- Memória SBOX
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity memoria_sbox is
	port(
		entrada				: in 	   std_logic_vector   (7 downto 0);
		retorno				: out 	std_logic_vector   (7 downto 0)
		);
end entity;
			
architecture behaviour of memoria_sbox is

type tamanho is array (integer range 0 to 255) of std_logic_vector(7 downto 0); --definition of the type for the four LUTS to be used.
signal tabela_sbox		: tamanho; 
signal const : std_logic_vector(7 downto 0) :="00001010";
begin
	
	tabela_sbox(0) <= X"63";
	tabela_sbox(1) <= X"7c";
	tabela_sbox(2) <= X"77";
	tabela_sbox(3) <= X"7b";	
	tabela_sbox(4) <= X"f2";
	tabela_sbox(5) <= X"6b";
	tabela_sbox(6) <= X"6f";
	tabela_sbox(7) <= X"c5";
	tabela_sbox(8) <= X"30";
	tabela_sbox(9) <= X"01";
	tabela_sbox(10) <= X"67"; --0a
	tabela_sbox(11) <= X"2b"; --0b
	tabela_sbox(12) <= X"fe"; --0c
	tabela_sbox(13) <= X"d7"; --0d
	
	
	tabela_sbox(14) <= X"ab"; --0e
	tabela_sbox(15) <= X"76"; --0f
	tabela_sbox(16) <= X"ca"; --10
	tabela_sbox(17) <= X"82"; --11
	tabela_sbox(18) <= X"c9"; --12
	tabela_sbox(19) <= X"7d"; --13
	tabela_sbox(20) <= X"fa"; --14
	tabela_sbox(21) <= X"59"; --15
	tabela_sbox(22) <= X"47"; --16
	tabela_sbox(23) <= X"f0"; --17 
	tabela_sbox(24) <= X"ad"; --18
	tabela_sbox(25) <= X"d4"; --19
	tabela_sbox(26) <= X"a2"; --1a
	tabela_sbox(27) <= X"af"; --1b
	tabela_sbox(28) <= X"9c"; --1c
	
	
	tabela_sbox(29) <= X"a4"; --1d
	tabela_sbox(30) <= X"72"; --1e
	tabela_sbox(31) <= X"c0"; --1f
	tabela_sbox(32) <= X"b7"; --20
	tabela_sbox(33) <= X"fd"; --21
	tabela_sbox(34) <= X"93"; --22
	tabela_sbox(35) <= X"26"; --23
	tabela_sbox(36) <= X"36"; --24
	tabela_sbox(37) <= X"3f"; --25
	tabela_sbox(38) <= X"f7"; --26
	tabela_sbox(39) <= X"cc";  --27
	tabela_sbox(40) <= X"34";  --28
	tabela_sbox(41) <= X"a5";  --29
	tabela_sbox(42) <= X"e5";  --2a
	
	
	tabela_sbox(43) <= X"f1";  --2b
	tabela_sbox(44) <= X"71";  --2c
	tabela_sbox(45) <= X"d8";  --2d
	tabela_sbox(46) <= X"31";  --2e
	tabela_sbox(47) <= X"15";  --2f
	
	tabela_sbox(48) <= X"04"; --30
	tabela_sbox(49) <= X"c7"; --31
	tabela_sbox(50) <= X"23"; --32
	tabela_sbox(51) <= X"c3"; --33
	tabela_sbox(52) <= X"18"; --34
	tabela_sbox(53) <= X"96"; --35
	tabela_sbox(54) <= X"05"; --36
	tabela_sbox(55) <= X"9a"; --37
	tabela_sbox(56) <= X"07"; --38
	tabela_sbox(57) <= X"12"; --39
	tabela_sbox(58) <= X"80"; --3a
	tabela_sbox(59) <= X"e2"; --3b
	tabela_sbox(60) <= X"eb"; --3c
	tabela_sbox(61) <= X"27"; --3d
	
	
	tabela_sbox(62) <= X"b2"; --3e
	tabela_sbox(63) <= X"75"; --3f
	tabela_sbox(64) <= X"09"; --40
	tabela_sbox(65) <= X"83"; --41
	tabela_sbox(66) <= X"2c"; --42
	tabela_sbox(67) <= X"1a"; --43
	tabela_sbox(68) <= X"1b"; --44
	tabela_sbox(69) <= X"6e"; --45
	tabela_sbox(70) <= X"5a"; --46
	tabela_sbox(71) <= X"a0"; --47
	tabela_sbox(72) <= X"52"; --48
	tabela_sbox(73) <= X"3b"; --49
	tabela_sbox(74) <= X"d6"; --4a
	tabela_sbox(75) <= X"b3"; --4b
	
	
	tabela_sbox(76) <= X"29"; --4c
	tabela_sbox(77) <= X"e3"; --4d
	tabela_sbox(78) <= X"2f"; --4e
	tabela_sbox(79) <= X"84"; --4f
	tabela_sbox(80) <= X"53"; --50
	tabela_sbox(81) <= X"d1"; --51
	tabela_sbox(82) <= X"00"; --52
	tabela_sbox(83) <= X"ed"; --53
	tabela_sbox(84) <= X"20"; --54
	tabela_sbox(85) <= X"fc"; --55
	tabela_sbox(86) <= X"b1"; --56
	tabela_sbox(87) <= X"5b"; --57
	tabela_sbox(88) <= X"6a"; --58
	tabela_sbox(89) <= X"cb"; --59
	
	
	tabela_sbox(90) <= X"be"; --5a
	tabela_sbox(91) <= X"39"; --5b
	tabela_sbox(92) <= X"4a"; --5c
	tabela_sbox(93) <= X"4c";--5d
	tabela_sbox(94) <= X"58";--5e
	tabela_sbox(95) <= X"cf"; --5f
	tabela_sbox(96) <= X"d0"; --60
	tabela_sbox(97) <= X"ef"; --61
	tabela_sbox(98) <= X"aa"; --62
	tabela_sbox(99) <= X"fb"; --63
	tabela_sbox(100) <= X"43"; --64
	tabela_sbox(101) <= X"4d"; --65
	tabela_sbox(102) <= X"33"; --66
	tabela_sbox(103) <= X"85"; --67
	
	
	tabela_sbox(104) <= X"45"; --68
	tabela_sbox(105) <= X"f9"; --69
	tabela_sbox(106) <= X"02"; --6a
	tabela_sbox(107) <= X"7f"; --6b
	tabela_sbox(108) <= X"50"; --6c
	tabela_sbox(109) <= X"3c"; --6d
	tabela_sbox(110) <= X"9f"; --6e
	tabela_sbox(111) <= X"a8"; --6f
	tabela_sbox(112) <= X"51"; --70
	tabela_sbox(113) <= X"a3"; --71
	tabela_sbox(114) <= X"40"; --72
	tabela_sbox(115) <= X"8f"; --73
	tabela_sbox(116) <= X"92"; --74
	tabela_sbox(117) <= X"9d"; --75
	
	
	tabela_sbox(118) <= X"38"; --76
	tabela_sbox(119) <= X"f5"; --77
	tabela_sbox(120) <= X"bc"; --78
	tabela_sbox(121) <= X"b6"; --79
	tabela_sbox(122) <= X"da"; --7a
	tabela_sbox(123) <= X"21"; --7b
	tabela_sbox(124) <= X"10"; --7c
	tabela_sbox(125) <= X"ff"; --7d
	tabela_sbox(126) <= X"f3"; --7e
	tabela_sbox(127) <= X"d2"; --7f
	tabela_sbox(128) <= X"cd"; --80
	tabela_sbox(129) <= X"0c"; --81
	tabela_sbox(130) <= X"13"; --82
	tabela_sbox(131) <= X"ec"; --83
	
	
	tabela_sbox(132) <= X"5f"; --84
	tabela_sbox(133) <= X"97"; --85
	tabela_sbox(134) <= X"44";	--86
	tabela_sbox(135) <= X"17"; --87
	tabela_sbox(136) <= X"c4"; --88
	tabela_sbox(137) <= X"a7"; --89
	tabela_sbox(138) <= X"7e"; --8a
	tabela_sbox(139) <= X"3d"; --8b
	tabela_sbox(140) <= X"64"; --8c
	tabela_sbox(141) <= X"5d"; --8d
	tabela_sbox(142) <= X"19"; --8e
	tabela_sbox(143) <= X"73"; --8f
	tabela_sbox(144) <= X"60"; --90
	tabela_sbox(145) <= X"81"; --91
	
	
	tabela_sbox(146) <= X"4f"; --92
	tabela_sbox(147) <= X"dc"; --93
	tabela_sbox(148) <= X"22"; --94
	tabela_sbox(149) <= X"2a"; --95
	tabela_sbox(150) <= X"90"; --96
	tabela_sbox(151) <= X"88"; --97
	tabela_sbox(152) <= X"46"; --98
	tabela_sbox(153) <= X"ee"; --99
	tabela_sbox(154) <= X"b8"; --9a
	tabela_sbox(155) <= X"14"; --9b
	tabela_sbox(156) <= X"de"; --9c
	tabela_sbox(157) <= X"5e"; --9d
	tabela_sbox(158) <= X"0b"; --9e
	tabela_sbox(159) <= X"db"; --9f
	
	
	tabela_sbox(160) <= X"e0"; --a0
	tabela_sbox(161) <= X"32"; --a1
	tabela_sbox(162) <= X"3a"; --a2
	tabela_sbox(163) <= X"0a"; --a3
	tabela_sbox(164) <= X"49"; --a4
	tabela_sbox(165) <= X"06"; --a5
	tabela_sbox(166) <= X"24"; --a6
	tabela_sbox(167) <= X"5c"; --a7
	tabela_sbox(168) <= X"c2"; --a8
	tabela_sbox(169) <= X"d3"; --a9
	tabela_sbox(170) <= X"ac"; --aa
	tabela_sbox(171) <= X"62"; --ab
	tabela_sbox(172) <= X"91"; --ac
	tabela_sbox(173) <= X"95"; --ad
	
	
	tabela_sbox(174) <= X"e4"; --ae
	tabela_sbox(175) <= X"79"; --af
	tabela_sbox(176) <= X"e7"; --b0
	tabela_sbox(177) <= X"c8"; --b1
	tabela_sbox(178) <= X"37"; --b2
	tabela_sbox(179) <= X"6d"; --b3
	tabela_sbox(180) <= X"8d"; --b4
	tabela_sbox(181) <= X"d5"; --b5
	tabela_sbox(182) <= X"4e"; --b6
	tabela_sbox(183) <= X"a9"; --b7
	tabela_sbox(184) <= X"6c"; --b8
	tabela_sbox(185) <= X"56"; --b9
	tabela_sbox(186) <= X"f4"; --ba
	tabela_sbox(187) <= X"ea"; --bb
	
	
	tabela_sbox(188) <= X"65"; --bc
	tabela_sbox(189) <= X"7a"; --bd
	tabela_sbox(190) <= X"ae"; --be
	tabela_sbox(191) <= X"08"; --bf
	tabela_sbox(192) <= X"ba"; --c0
	tabela_sbox(193) <= X"78"; --c1
	tabela_sbox(194) <= X"25"; --c2
	tabela_sbox(195) <= X"2e"; --c3
	tabela_sbox(196) <= X"1c"; --c4
	tabela_sbox(197) <= X"a6"; --c5
	tabela_sbox(198) <= X"b4"; --c6
	tabela_sbox(199) <= X"c6"; --c7
	tabela_sbox(200) <= X"e8"; --c8
	tabela_sbox(201) <= X"dd"; --c9
	
	tabela_sbox(202) <= X"74"; --ca
	tabela_sbox(203) <= X"1f"; --cb
	tabela_sbox(204) <= X"4b"; --cc
	tabela_sbox(205) <= X"bd"; --cd
	tabela_sbox(206) <= X"8b"; --ce
	tabela_sbox(207) <= X"8a"; --cf
	tabela_sbox(208) <= X"70"; --d0
	tabela_sbox(209) <= X"3e"; --d1
	tabela_sbox(210) <= X"b5"; --d2
	tabela_sbox(211) <= X"66"; --d3
	tabela_sbox(212) <= X"48"; --d4
	tabela_sbox(213) <= X"03"; --d5
	tabela_sbox(214) <= X"f6"; --d6
	tabela_sbox(215) <= X"0e"; --d7
	
	
	tabela_sbox(216) <= X"61"; --d8
	tabela_sbox(217) <= X"35"; --d9
	tabela_sbox(218) <= X"57"; --da
	tabela_sbox(219) <= X"b9"; --db
	tabela_sbox(220) <= X"86"; --dc
	tabela_sbox(221) <= X"c1"; --dd
	tabela_sbox(222) <= X"1d"; --de
	tabela_sbox(223) <= X"9e"; --df
	tabela_sbox(224) <= X"e1"; --e0
	tabela_sbox(225) <= X"f8"; --e1
	tabela_sbox(226) <= X"98"; --e2
	tabela_sbox(227) <= X"11"; --e3
	tabela_sbox(228) <= X"69"; --e4
	tabela_sbox(229) <= X"d9"; --e5
	
	tabela_sbox(230) <= X"8e"; --e6
	tabela_sbox(231) <= X"94"; --e7
	tabela_sbox(232) <= X"9b"; --e8
	tabela_sbox(233) <= X"1e"; --e9
	tabela_sbox(234) <= X"87"; --ea
	tabela_sbox(235) <= X"e9"; --eb
	tabela_sbox(236) <= X"ce"; --ec
	tabela_sbox(237) <= X"55"; --ed
	tabela_sbox(238) <= X"28"; --ee
	tabela_sbox(239) <= X"df"; --ef
	tabela_sbox(240) <= X"8c"; --f0
	tabela_sbox(241) <= X"a1"; --f1
	tabela_sbox(242) <= X"89"; --f2
	tabela_sbox(243) <= X"0d"; --f3
	
	
	tabela_sbox(244) <= X"bf"; --f4
	tabela_sbox(245) <= X"e6"; --f5
	tabela_sbox(246) <= X"42"; --f6
	tabela_sbox(247) <= X"68"; --f7
	tabela_sbox(248) <= X"41"; --f8
	tabela_sbox(249) <= X"99"; --f9
	tabela_sbox(250) <= X"2d"; --fa
	tabela_sbox(251) <= X"0f"; --fb
	tabela_sbox(252) <= X"b0"; --fc
	tabela_sbox(253) <= X"54"; --fd
	tabela_sbox(254) <= X"bb";--fe
	tabela_sbox(255) <= X"16"; --ff
	
	
--Agora para retornar o que for pedido, basta fazer a conversão usando converte integer e unsigned 	
	retorno <= tabela_sbox(conv_integer(unsigned(entrada)));

end behaviour;