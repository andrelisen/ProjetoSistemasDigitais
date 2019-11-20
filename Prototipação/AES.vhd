
	library ieee;
	use ieee.std_logic_1164.all;
	
entity AES is
	port(
		--Entrada do texto
			entrada0		:	in std_logic_vector(7 downto 0);
			entrada1		:	in std_logic_vector(7 downto 0);
			entrada2		:	in std_logic_vector(7 downto 0);
			entrada3		:	in std_logic_vector(7 downto 0);
			entrada4		:	in std_logic_vector(7 downto 0);
			entrada5		:	in std_logic_vector(7 downto 0);
			entrada6		:	in std_logic_vector(7 downto 0);
			entrada7		:	in std_logic_vector(7 downto 0);
		--Sinal de enable
			Enable_registradoresA	:	in std_logic;	--Inicializa 8 registradores
			Enable_registradoresB	:	in std_logic;	--Inicializa 8 registradores
			Enable_registradoresC	:	in std_logic;	--Inicializa 8 registradores
			Enable_registradoresD	:	in std_logic;	--Inicializa 8 registradores
			Enable_Add 					:	in std_logic;
			Enable_SubBytes			:  in std_logic;
			Enable_ShiftRows			:  in std_logic;
			Enable_Mix					:  in std_logic;
			Enable_SubChave			:  in std_logic;
		--Seletores
			Sel_EntradaAddTxt 		: in std_logic_vector(1 downto 0); -- entrada mux add txt
			Sel_EntradaAddKey 		: in std_logic;						  -- entrada mux add sub chave
			Sel_EntradaSubChave 		: in std_logic;
			Sel_rcon						: in std_logic_vector(3 downto 0);
		--Sinal de clock
			clock							:	in std_logic;
		--Sinal de depuracao
			out0Add_view, out1Add_view, out2Add_view, out3Add_view, out4Add_view, out5Add_view, out6Add_view, out7Add_view : out std_logic_vector(7 downto 0);
			out8Add_view, out9Add_view, out10Add_view, out11Add_view, out12Add_view, out13Add_view, out14Add_view, out15Add_view : out std_logic_vector(7 downto 0)
	);
end entity;

architecture implementa of AES is

component AddRound is
	port(
		e0, e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11, e12, e13, e14, e15	:	in std_logic_vector(7 downto 0);
		t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15	:	in std_logic_vector(7 downto 0);
		r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15 : out std_logic_vector(7 downto 0)
	);
end component;

component register8bits is
	port(
		clk		: in std_logic;
		enable	: in std_logic;
		d	      : in std_logic_vector(7 downto 0);
		q			: out std_logic_vector(7 downto 0)			
	);
end component;

component Mux4p1 is
		port(
			inicio	: in std_logic_vector(127 downto 0);
			mix	: in std_logic_vector(127 downto 0);
			shift	: in std_logic_vector(127 downto 0);
			seletor	: in std_logic_vector(1 downto 0);
			saida		: out std_logic_vector(127 downto 0)
		);
end component;

component Mux2p1 is
		port(
			chave_inicial	: in std_logic_vector(127 downto 0);
			chave_calculada	: in std_logic_vector(127 downto 0);
			seletor	: in std_logic;
			saida		: out std_logic_vector(127 downto 0)
		);
end component;

component SubBytes is 
	port(
		--STATE
		e0, e1, e2, e3			:	in std_logic_vector(7 downto 0);
		e4, e5, e6, e7			:	in std_logic_vector(7 downto 0);
		e8, e9, e10, e11		:	in std_logic_vector(7 downto 0);
		e12, e13, e14, e15	:	in std_logic_vector(7 downto 0);
		--RESULTADO
		s0, s1, s2, s3 		: out std_logic_vector(7 downto 0);
		s4, s5, s6, s7 		: out std_logic_vector(7 downto 0);
		s8, s9, s10, s11 		: out std_logic_vector(7 downto 0);
		s12, s13, s14, s15 		: out std_logic_vector(7 downto 0)
	);
end component;	

component SubChave is
	port(
		--CHAVE
		c0, c1, c2, c3			:	in std_logic_vector(7 downto 0);
		c4, c5, c6, c7			:	in std_logic_vector(7 downto 0);
		c8, c9, c10, c11		:	in std_logic_vector(7 downto 0);
		c12, c13, c14, c15	:	in std_logic_vector(7 downto 0);
		seletor 					:  in std_logic_vector(3 downto 0);
		--NOVA CHAVE
		n0, n1, n2, n3 		: out std_logic_vector(7 downto 0);
		n4, n5, n6, n7 		: out std_logic_vector(7 downto 0);
		n8, n9, n10, n11 		: out std_logic_vector(7 downto 0);
		n12, n13, n14, n15 		: out std_logic_vector(7 downto 0)
	);
end component;

component ShiftRows is 
	port(	
		--STATE
		e0, e1, e2, e3			:	in std_logic_vector(7 downto 0);
		e4, e5, e6, e7			:	in std_logic_vector(7 downto 0);
		e8, e9, e10, e11		:	in std_logic_vector(7 downto 0);
		e12, e13, e14, e15	:	in std_logic_vector(7 downto 0);
		--RESULTADO
		s0, s1, s2, s3 		: out std_logic_vector(7 downto 0);
		s4, s5, s6, s7 		: out std_logic_vector(7 downto 0);
		s8, s9, s10, s11 		: out std_logic_vector(7 downto 0);
		s12, s13, s14, s15 		: out std_logic_vector(7 downto 0)
	);
end component;

component MixColumns is
	port (
		e0, e1, e2, e3			:	in std_logic_vector(7 downto 0);
		e4, e5, e6, e7			:	in std_logic_vector(7 downto 0);
		e8, e9, e10, e11		:	in std_logic_vector(7 downto 0);
		e12, e13, e14, e15	:	in std_logic_vector(7 downto 0);
		s0, s1, s2, s3 		: out std_logic_vector(7 downto 0);
		s4, s5, s6, s7 		: out std_logic_vector(7 downto 0);
		s8, s9, s10, s11 		: out std_logic_vector(7 downto 0);
		s12, s13, s14, s15 		: out std_logic_vector(7 downto 0)
	);
end component;

	--Saidas dos registradores de entrada
	signal reg0_txt, reg1_txt, reg2_txt, reg3_txt, reg4_txt, reg5_txt, reg6_txt, reg7_txt : std_logic_vector(7 downto 0) := "00000000";
	signal reg8_txt, reg9_txt, reg10_txt, reg11_txt, reg12_txt, reg13_txt, reg14_txt, reg15_txt : std_logic_vector(7 downto 0) := "00000000";
	signal reg0_key, reg1_key, reg2_key, reg3_key, reg4_key, reg5_key, reg6_key, reg7_key : std_logic_vector(7 downto 0) := "00000000";
	signal reg8_key, reg9_key, reg10_key, reg11_key, reg12_key, reg13_key, reg14_key, reg15_key : std_logic_vector(7 downto 0) := "00000000";
	
	signal inicio_sg, mix_sg, shift_sg : std_logic_vector(127 downto 0) := (others=>'0');
	
	
	signal out0_mix, out1_mix, out2_mix, out3_mix, out4_mix, out5_mix, out6_mix, out7_mix : std_logic_vector(7 downto 0) := "00000000";
	signal out8_mix, out9_mix, out10_mix, out11_mix, out12_mix, out13_mix, out14_mix, out15_mix : std_logic_vector(7 downto 0) := "00000000";
	signal reg0_mix, reg1_mix, reg2_mix, reg3_mix, reg4_mix, reg5_mix, reg6_mix, reg7_mix : std_logic_vector(7 downto 0) := "00000000";
	signal reg8_mix, reg9_mix, reg10_mix, reg11_mix, reg12_mix, reg13_mix, reg14_mix, reg15_mix : std_logic_vector(7 downto 0) := "00000000";
	
	signal out0_shift, out1_shift, out2_shift, out3_shift, out4_shift, out5_shift, out6_shift, out7_shift: std_logic_vector(7 downto 0) := "00000000";
	signal out8_shift, out9_shift, out10_shift, out11_shift, out12_shift, out13_shift, out14_shift, out15_shift: std_logic_vector(7 downto 0) := "00000000";
	signal reg0_shift, reg1_shift, reg2_shift, reg3_shift, reg4_shift, reg5_shift, reg6_shift, reg7_shift: std_logic_vector(7 downto 0) := "00000000";
	signal reg8_shift, reg9_shift, reg10_shift, reg11_shift, reg12_shift, reg13_shift, reg14_shift, reg15_shift: std_logic_vector(7 downto 0) := "00000000";
	
	signal out0_subchave, out1_subchave, out2_subchave, out3_subchave, out4_subchave, out5_subchave, out6_subchave, out7_subchave: std_logic_vector(7 downto 0) := "00000000";
	signal out8_subchave, out9_subchave, out10_subchave, out11_subchave, out12_subchave, out13_subchave, out14_subchave, out15_subchave: std_logic_vector(7 downto 0) := "00000000";
	signal reg0_subchave, reg1_subchave, reg2_subchave, reg3_subchave, reg4_subchave, reg5_subchave, reg6_subchave, reg7_subchave: std_logic_vector(7 downto 0) := "00000000";
	signal reg8_subchave, reg9_subchave, reg10_subchave, reg11_subchave, reg12_subchave, reg13_subchave, reg14_subchave, reg15_subchave: std_logic_vector(7 downto 0) := "00000000";
	
	
	signal out0_subbytes, out1_subbytes, out2_subbytes, out3_subbytes, out4_subbytes, out5_subbytes, out6_subbytes, out7_subbytes, out8_subbytes , out9_subbytes : std_logic_vector(7 downto 0) := "00000000";
	signal out10_subbytes, out11_subbytes, out12_subbytes, out13_subbytes, out14_subbytes, out15_subbytes : std_logic_vector(7 downto 0) := "00000000";
	signal reg0_subbytes, reg1_subbytes, reg2_subbytes, reg3_subbytes, reg4_subbytes, reg5_subbytes, reg6_subbytes, reg7_subbytes, reg8_subbytes , reg9_subbytes : std_logic_vector(7 downto 0) := "00000000";
	signal reg10_subbytes, reg11_subbytes, reg12_subbytes, reg13_subbytes, reg14_subbytes, reg15_subbytes : std_logic_vector(7 downto 0) := "00000000";
	
	signal out0_add, out1_add, out2_add, out3_add, out4_add, out5_add, out6_add, out7_add, out8_add , out9_add : std_logic_vector(7 downto 0) := "00000000";
	signal out10_add, out11_add, out12_add, out13_add, out14_add, out15_add : std_logic_vector(7 downto 0) := "00000000";
	signal reg0_add, reg1_add, reg2_add, reg3_add, reg4_add, reg5_add, reg6_add, reg7_add, reg8_add , reg9_add : std_logic_vector(7 downto 0) := "00000000";
	signal reg10_add, reg11_add, reg12_add, reg13_add, reg14_add, reg15_add : std_logic_vector(7 downto 0) := "00000000";
	
	
	signal saida_key 	 : std_logic_vector(127 downto 0) := (others=>'0');
	signal saida_texto : std_logic_vector(127 downto 0) := (others=>'0');
	signal inicial_sg, calculada_sg : std_logic_vector(127 downto 0) := (others=>'0');
	signal saida_SubChave  : std_logic_vector(127 downto 0) := (others=>'0');
	
	
	
	begin
	
	r0_txt	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresA,
			d	      => entrada0,
			q			=> reg0_txt	
		);
		
	r1_txt	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresA,
			d	      => entrada1,
			q			=> reg1_txt	
		);
	
	r2_txt	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresA,
			d	      => entrada2,
			q			=> reg2_txt	
		);
	
	r3_txt	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresA,
			d	      => entrada3,
			q			=> reg3_txt	
		);
	
	r4_txt	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresA,
			d	      => entrada4,
			q			=> reg4_txt	
		);
	
	r5_txt	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresA,
			d	      => entrada5,
			q			=> reg5_txt	
		);
	
	r6_txt	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresA,
			d	      => entrada6,
			q			=> reg6_txt	
		);	
	
	r7_txt	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresA,
			d	      => entrada7,
			q			=> reg7_txt	
		);	
		
	r8_txt	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresB,
			d	      => entrada0,
			q			=> reg8_txt	
		);	
		
	r9_txt	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresB,
			d	      => entrada1,
			q			=> reg9_txt	
		);	
	
	r10_txt	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresB,
			d	      => entrada2,
			q			=> reg10_txt	
		);	
		
	r11_txt	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresB,
			d	      => entrada3,
			q			=> reg11_txt	
		);	
		
	r12_txt	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresB,
			d	      => entrada4,
			q			=> reg12_txt	
		);	
	
	r13_txt	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresB,
			d	      => entrada5,
			q			=> reg13_txt	
		);	
		
	r14_txt	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresB,
			d	      => entrada6,
			q			=> reg14_txt	
		);	
		
	r15_txt	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresB,
			d	      => entrada7,
			q			=> reg15_txt	
		);
	
	r0_key	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresC,
			d	      => entrada0,
			q			=> reg0_key	
		);
		
	r1_key	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresC,
			d	      => entrada1,
			q			=> reg1_key	
		);
	
	r2_key	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresC,
			d	      => entrada2,
			q			=> reg2_key	
		);
	
	r3_key	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresC,
			d	      => entrada3,
			q			=> reg3_key	
		);
	
	r4_key	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresC,
			d	      => entrada4,
			q			=> reg4_key	
		);
	
	r5_key	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresC,
			d	      => entrada5,
			q			=> reg5_key	
		);
	
	r6_key	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresC,
			d	      => entrada6,
			q			=> reg6_key	
		);	
	
	r7_key	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresC,
			d	      => entrada7,
			q			=> reg7_key	
		);	
		
	r8_key	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresD,
			d	      => entrada0,
			q			=> reg8_key	
		);	
		
	r9_key	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresD,
			d	      => entrada1,
			q			=> reg9_key	
		);	
	
	r10_key	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresD,
			d	      => entrada2,
			q			=> reg10_key	
		);	
		
	r11_key	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresD,
			d	      => entrada3,
			q			=> reg11_key	
		);	
		
	r12_key	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresD,
			d	      => entrada4,
			q			=> reg12_key	
		);	
	
	r13_key	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresD,
			d	      => entrada5,
			q			=> reg13_key	
		);	
		
	r14_key	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresD,
			d	      => entrada6,
			q			=> reg14_key	
		);	
		
	r15_key	:	register8bits
		port map(
			clk		=> clock,
			enable	=> Enable_registradoresD,
			d	      => entrada7,
			q			=> reg15_key	
		);
		
	inicio_sg <= reg0_txt&reg1_txt&reg2_txt&reg3_txt&reg4_txt&reg5_txt&reg6_txt&reg7_txt&reg8_txt&reg9_txt&reg10_txt&reg11_txt&reg12_txt&reg13_txt&reg14_txt&reg15_txt;	
	mix_sg <= reg0_mix&reg1_mix&reg2_mix&reg3_mix&reg4_mix&reg5_mix&reg6_mix&reg7_mix&reg8_mix&reg9_mix&reg10_mix&reg11_mix&reg12_mix&reg13_mix&reg14_mix&reg15_mix;	
	shift_sg <= reg0_shift&reg1_shift&reg2_shift&reg3_shift&reg4_shift&reg5_shift&reg6_shift&reg7_shift&reg8_shift&reg9_shift&reg10_shift&reg11_shift&reg12_shift&reg13_shift&reg14_shift&reg15_shift;	
	
	Escolhe_Qual_Texto : mux4p1
		port map(
			inicio	=> inicio_sg,
			mix		=> mix_sg,
			shift		=> shift_sg,
			seletor	=> sel_EntradaAddTxt,
			saida		=> saida_texto
		);
	
	inicial_sg <= reg0_key&reg1_key&reg2_key&reg3_key&reg4_key&reg5_key&reg6_key&reg7_key&reg8_key&reg9_key&reg10_key&reg11_key&reg12_key&reg13_key&reg14_key&reg15_key;	
	calculada_sg <= reg0_subchave&reg1_subchave&reg2_subchave&reg3_subchave&reg4_subchave&reg5_subchave&reg6_subchave&reg7_subchave&reg8_subchave&reg9_subchave&reg10_subchave&reg11_subchave&reg12_subchave&reg13_subchave&reg14_subchave&reg15_subchave;	
	
	Escolhe_Qual_Chave : mux2p1
		port map(
			chave_inicial	=> inicial_sg,
			chave_calculada	=> calculada_sg,
			seletor	=> sel_EntradaAddKey,
			saida		=> saida_key
		);
	
		Add : AddRound
		port map(
			e0  => saida_texto(127 downto 120),
			e1  => saida_texto(119 downto 112),
			e2  => saida_texto(111 downto 104),
			e3  => saida_texto(103 downto 96),
			e4  => saida_texto(95 downto 88),
			e5  => saida_texto(87 downto 80),
			e6  => saida_texto(79 downto 72),
			e7  => saida_texto(71 downto 64),
			e8  => saida_texto(63 downto 56),
			e9  => saida_texto(55 downto 48),
			e10 => saida_texto(47 downto 40),
			e11 => saida_texto(39 downto 32),
			e12 => saida_texto(31 downto 24),
			e13 => saida_texto(23 downto 16),
			e14 => saida_texto(15 downto 8),
			e15 => saida_texto(7 downto 0),
			t0  => saida_key(127 downto 120),
			t1  => saida_key(119 downto 112),
			t2  => saida_key(111 downto 104),
			t3  => saida_key(103 downto 96),
			t4  => saida_key(95 downto 88),
			t5  => saida_key(87 downto 80),
			t6  => saida_key(79 downto 72),
			t7  => saida_key(71 downto 64),
			t8  => saida_key(63 downto 56),
			t9  => saida_key(55 downto 48),
			t10 => saida_key(47 downto 40),
			t11 => saida_key(39 downto 32),
			t12 => saida_key(31 downto 24),
			t13 => saida_key(23 downto 16),
			t14 => saida_key(15 downto 8),
			t15 => saida_key(7 downto 0),
			r0  => out0_Add,
			r1  => out1_Add,
			r2  => out2_Add,
			r3  => out3_Add,
			r4  => out4_Add,
			r5  => out5_Add,
			r6  => out6_Add,
			r7  => out7_Add,
			r8  => out8_Add,
			r9  => out9_Add,
			r10 => out10_Add,
			r11 => out11_Add,
			r12 => out12_Add,
			r13 => out13_Add,
			r14 => out14_Add,
			r15 => out15_Add
		);
		
	r0_add : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_Add,
			d 			=> out0_add,
			q			=> reg0_add
		);
		
	r1_add : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_Add,
			d 			=> out1_add,
			q			=> reg1_add
		);
	
	r2_add : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_Add,
			d 			=> out2_add,
			q			=> reg2_add
		);
	
	r3_add : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_Add,
			d 			=> out3_add,
			q			=> reg3_add
		);
	
	r4_add : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_Add,
			d 			=> out4_add,
			q			=> reg4_add
		);
	
	r5_add : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_Add,
			d 			=> out5_add,
			q			=> reg5_add
		);
	
	r6_add : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_Add,
			d 			=> out6_add,
			q			=> reg6_add
		);
	
	r7_add : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_Add,
			d 			=> out7_add,
			q			=> reg7_add
		);
	
	r8_add : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_Add,
			d 			=> out8_add,
			q			=> reg8_add
		);
	
	r9_add : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_Add,
			d 			=> out9_add,
			q			=> reg9_add
		);
	
	r10_add : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_Add,
			d 			=> out10_add,
			q			=> reg10_add
		);
		
	r11_add : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_Add,
			d 			=> out11_add,
			q			=> reg11_add
		);
	
	r12_add : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_Add,
			d 			=> out12_add,
			q			=> reg12_add
		);
	
	r13_add : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_Add,
			d 			=> out13_add,
			q			=> reg13_add
		);
	
	r14_add : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_Add,
			d 			=> out14_add,
			q			=> reg14_add
		);
	
	r15_add : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_Add,
			d 			=> out15_add,
			q			=> reg15_add
		);
	
	SubB : SubBytes
		port map(
			e0 => reg0_add, 
			e1 => reg1_add,
			e2 => reg2_add, 
			e3 => reg3_add,
			e4 => reg4_add,
			e5 => reg5_add, 
			e6 => reg6_add, 
			e7 => reg7_add,
			e8 => reg8_add,
			e9 => reg9_add, 
			e10 => reg10_add, 
			e11 => reg11_add,	
			e12 => reg12_add,
			e13 => reg13_add,
			e14 => reg14_add,
			e15 => reg15_add,
			s0 =>out0_subbytes,
			s1 => out1_subbytes,
			s2 => out2_subbytes,
			s3 => out3_subbytes, 		
			s4 => out4_subbytes,
			s5 => out5_subbytes, 
			s6	=> out6_subbytes, 
			s7  => out7_subbytes,		
			s8 => out8_subbytes,
			s9 => out9_subbytes, 
			s10 => out10_subbytes, 
			s11 => out11_subbytes, 		
			s12 => out12_subbytes,
			s13 => out13_subbytes,
			s14 => out14_subbytes,
			s15  => out15_subbytes		
		);
	
	r0_subbytes : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subBytes,
			d 			=> out0_subbytes,
			q			=> reg0_subbytes
		);
		
	r1_subbytes : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subBytes,
			d 			=> out1_subbytes,
			q			=> reg1_subbytes
		);
	
	r2_subbytes : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subBytes,
			d 			=> out2_subbytes,
			q			=> reg2_subbytes
		);
	
	r3_subbytes : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subBytes,
			d 			=> out3_subbytes,
			q			=> reg3_subbytes
		);
	
	r4_subbytes : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subBytes,
			d 			=> out4_subbytes,
			q			=> reg4_subbytes
		);
	
	r5_subbytes : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subBytes,
			d 			=> out5_subbytes,
			q			=> reg5_subbytes
		);
	
	r6_subbytes : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subBytes,
			d 			=> out6_subbytes,
			q			=> reg6_subbytes
		);
	
	r7_subbytes : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subBytes,
			d 			=> out7_subbytes,
			q			=> reg7_subbytes
		);
	
	r8_subbytes : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subBytes,
			d 			=> out8_subbytes,
			q			=> reg8_subbytes
		);
	
	r9_subbytes : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subBytes,
			d 			=> out9_subbytes,
			q			=> reg9_subbytes
		);
	
	r10_subbytes : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subBytes,
			d 			=> out10_subbytes,
			q			=> reg10_subbytes
		);
		
	r11_subbytes : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subBytes,
			d 			=> out11_subbytes,
			q			=> reg11_subbytes
		);
	
	r12_subbytes : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subBytes,
			d 			=> out12_subbytes,
			q			=> reg12_subbytes
		);
	
	r13_subbytes: register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subBytes,
			d 			=> out13_subbytes,
			q			=> reg13_subbytes
		);
	
	r14_subbytes : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subBytes,
			d 			=> out14_subbytes,
			q			=> reg14_subbytes
		);
	
	r15_subbytes : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subBytes,
			d 			=> out15_subbytes,
			q			=> reg15_subbytes
		);
	
	shift : shiftRows
		port map(	
			e0 => reg0_subbytes, 
			e1 => reg1_subbytes,
			e2 => reg2_subbytes, 
			e3 => reg3_subbytes,
			e4 => reg4_subbytes,
			e5 => reg5_subbytes, 
			e6 => reg6_subbytes, 
			e7 => reg7_subbytes,
			e8 => reg8_subbytes,
			e9 => reg9_subbytes, 
			e10 => reg10_subbytes, 
			e11 => reg11_subbytes,	
			e12 => reg12_subbytes,
			e13 => reg13_subbytes,
			e14 => reg14_subbytes,
			e15 => reg15_subbytes,
			s0 => out0_shift,
			s1 => out1_shift,
			s2 => out2_shift,
			s3 => out3_shift, 		
			s4 => out4_shift,
			s5 => out5_shift, 
			s6	=> out6_shift, 
			s7  => out7_shift,		
			s8 => out8_shift,
			s9 => out9_shift, 
			s10 => out10_shift, 
			s11 => out11_shift, 		
			s12 => out12_shift,
			s13 => out13_shift,
			s14 => out14_shift,
			s15  => out15_shift
		);
		
		r0_shift : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_shiftRows,
			d 			=> out0_shift,
			q			=> reg0_shift
		);
		
	r1_shift : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_shiftRows,
			d 			=> out1_shift,
			q			=> reg1_shift
		);
	
	r2_shift : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_shiftRows,
			d 			=> out2_shift,
			q			=> reg2_shift
		);
	
	r3_shift : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_shiftRows,
			d 			=> out3_shift,
			q			=> reg3_shift
		);
	
	r4_shift : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_shiftRows,
			d 			=> out4_shift,
			q			=> reg4_shift
		);
	
	r5_shift : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_shiftRows,
			d 			=> out5_shift,
			q			=> reg5_shift
		);
	
	r6_shift : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_shiftRows,
			d 			=> out6_shift,
			q			=> reg6_shift
		);
	
	r7_shift : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_shiftRows,
			d 			=> out7_shift,
			q			=> reg7_shift
		);
	
	r8_shift : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_shiftRows,
			d 			=> out8_shift,
			q			=> reg8_shift
		);
	
	r9_shift : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_shiftRows,
			d 			=> out9_shift,
			q			=> reg9_shift
		);
	
	r10_shift : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_shiftRows,
			d 			=> out10_shift,
			q			=> reg10_shift
		);
		
	r11_shift : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_shiftRows,
			d 			=> out11_shift,
			q			=> reg11_shift
		);
	
	r12_shift : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_shiftRows,
			d 			=> out12_shift,
			q			=> reg12_shift
		);
	
	r13_shift: register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_shiftRows,
			d 			=> out13_shift,
			q			=> reg13_shift
		);
	
	r14_shift : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_shiftRows,
			d 			=> out14_shift,
			q			=> reg14_shift
		);
	
	r15_shift : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_shiftRows,
			d 			=> out15_shift,
			q			=> reg15_shift
		);
	
	Mix : mixColumns
		port map(	
			e0 => reg0_shift, 
			e1 => reg1_shift,
			e2 => reg2_shift, 
			e3 => reg3_shift,
			e4 => reg4_shift,
			e5 => reg5_shift, 
			e6 => reg6_shift, 
			e7 => reg7_shift,
			e8 => reg8_shift,
			e9 => reg9_shift, 
			e10 => reg10_shift, 
			e11 => reg11_shift,	
			e12 => reg12_shift,
			e13 => reg13_shift,
			e14 => reg14_shift,
			e15 => reg15_shift,
			s0 => out0_mix,
			s1 => out1_mix,
			s2 => out2_mix,
			s3 => out3_mix, 		
			s4 => out4_mix,
			s5 => out5_mix, 
			s6	=> out6_mix, 
			s7  => out7_mix,		
			s8 => out8_mix,
			s9 => out9_mix, 
			s10 => out10_mix, 
			s11 => out11_mix, 		
			s12 => out12_mix,
			s13 => out13_mix,
			s14 => out14_mix,
			s15  => out15_mix
		);
		
		r0_mix : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_mix,
			d 			=> out0_mix,
			q			=> reg0_mix
		);
		
	r1_mix : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_mix,
			d 			=> out1_mix,
			q			=> reg1_mix
		);
	
	r2_mix : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_mix,
			d 			=> out2_mix,
			q			=> reg2_mix
		);
	
	r3_mix : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_mix,
			d 			=> out3_mix,
			q			=> reg3_mix
		);
	
	r4_mix : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_mix,
			d 			=> out4_mix,
			q			=> reg4_mix
		);
	
	r5_mix : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_mix,
			d 			=> out5_mix,
			q			=> reg5_mix
		);
	
	r6_mix : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_mix,
			d 			=> out6_mix,
			q			=> reg6_mix
		);
	
	r7_mix : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_mix,
			d 			=> out7_mix,
			q			=> reg7_mix
		);
	
	r8_mix : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_mix,
			d 			=> out8_mix,
			q			=> reg8_mix
		);
	
	r9_mix : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_mix,
			d 			=> out9_mix,
			q			=> reg9_mix
		);
	
	r10_mix : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_mix,
			d 			=> out10_mix,
			q			=> reg10_mix
		);
		
	r11_mix : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_mix,
			d 			=> out11_mix,
			q			=> reg11_mix
		);
	
	r12_mix : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_mix,
			d 			=> out12_mix,
			q			=> reg12_mix
		);
	
	r13_mix: register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_mix,
			d 			=> out13_mix,
			q			=> reg13_mix
		);
	
	r14_mix : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_mix,
			d 			=> out14_mix,
			q			=> reg14_mix
		);
	
	r15_mix : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_mix,
			d 			=> out15_mix,
			q			=> reg15_mix
		);
	
	inicial_sg <= reg0_key&reg1_key&reg2_key&reg3_key&reg4_key&reg5_key&reg6_key&reg7_key&reg8_key&reg9_key&reg10_key&reg11_key&reg12_key&reg13_key&reg14_key&reg15_key;	
	calculada_sg <= reg0_subchave&reg1_subchave&reg2_subchave&reg3_subchave&reg4_subchave&reg5_subchave&reg6_subchave&reg7_subchave&reg8_subchave&reg9_subchave&reg10_subchave&reg11_subchave&reg12_subchave&reg13_subchave&reg14_subchave&reg15_subchave;	
		
	Escolhe_EntradaCalculo_SubChave : Mux2p1
		port map(
			chave_inicial	=> inicial_sg,
			chave_calculada	=> calculada_sg,
			seletor	=> sel_EntradaSubChave,
			saida		=> saida_subChave
		);

	
	Calculo_SubChave : SubChave
		port map(
			c0 => saida_SubChave(127 downto 120), 
			c1 => saida_SubChave(119 downto 112),
			c2 => saida_SubChave(111 downto 104),
			c3 => saida_SubChave(103 downto 96),	
			c4 => saida_SubChave(95 downto 88),
			c5 => saida_SubChave(87 downto 80),
			c6 => saida_SubChave(79 downto 72),
			c7 => saida_SubChave(71 downto 64),	
			c8 => saida_SubChave(63 downto 56), 
			c9 => saida_SubChave(55 downto 48),
			c10 => saida_SubChave(47 downto 40), 
			c11 => saida_SubChave(39 downto 32),	
			c12 => saida_SubChave(31 downto 24), 
			c13 => saida_SubChave(23 downto 16), 
			c14 => saida_SubChave(15 downto 8), 
			c15 => saida_SubChave(7 downto 0),	
			seletor => sel_rcon,
			n0 => out0_subchave, 
			n1 => out1_subchave, 
			n2 => out2_subchave, 
			n3 => out3_subchave, 		
			n4 => out4_subchave, 
			n5 => out5_subchave, 
			n6 => out6_subchave, 
			n7 => out7_subchave,		
			n8 => out8_subchave,
			n9 => out9_subchave, 
			n10 => out10_subchave, 
			n11 => out11_subchave, 	
			n12 => out12_subchave,
			n13 => out13_subchave,
			n14 => out14_subchave, 
			n15  => out15_subchave
		);
	
	r0_subchave : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subChave,
			d 			=> out0_subchave,
			q			=> reg0_subchave
	);
		
	r1_subchave : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subchave,
			d 			=> out1_subchave,
			q			=> reg1_subchave
		);
	
	r2_subchave : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subchave,
			d 			=> out2_subchave,
			q			=> reg2_subchave
		);
	
	r3_subchave : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subchave,
			d 			=> out3_subchave,
			q			=> reg3_subchave
		);
	
	r4_subchave : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subchave,
			d 			=> out4_subchave,
			q			=> reg4_subchave
		);
	
	r5_subchave : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subchave,
			d 			=> out5_subchave,
			q			=> reg5_subchave
		);
	
	r6_subchave : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subchave,
			d 			=> out6_subchave,
			q			=> reg6_subchave
		);
	
	r7_subchave : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subchave,
			d 			=> out7_subchave,
			q			=> reg7_subchave
		);
	
	r8_subchave : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subchave,
			d 			=> out8_subchave,
			q			=> reg8_subchave
		);
	
	r9_subchave : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subchave,
			d 			=> out9_subchave,
			q			=> reg9_subchave
		);
	
	r10_subchave : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subchave,
			d 			=> out10_subchave,
			q			=> reg10_subchave
		);
		
	r11_subchave : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subchave,
			d 			=> out11_subchave,
			q			=> reg11_subchave
		);
	
	r12_subchave : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subchave,
			d 			=> out12_subchave,
			q			=> reg12_subchave
		);
	
	r13_subchave: register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subchave,
			d 			=> out13_subchave,
			q			=> reg13_subchave
		);
	
	r14_subchave : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subchave,
			d 			=> out14_subchave,
			q			=> reg14_subchave
		);
	
	r15_subchave : register8bits 
		port map(
			clk 		=> clock,
			enable 	=> enable_subchave,
			d 			=> out15_subchave,
			q			=> reg15_subchave
		);
	
	out0Add_view <= reg0_add;
	out1Add_view <= reg1_add;
	out2Add_view <= reg2_add;
	out3Add_view <= reg3_add;
	out4Add_view <= reg4_add;
	out5Add_view <= reg5_add;
	out6Add_view <= reg6_add;
	out7Add_view <= reg7_add;
	out8Add_view <= reg8_add;
	out9Add_view <= reg9_add;
	out10Add_view <= reg10_add;
	out11Add_view <= reg11_add;
	out12Add_view <= reg12_add;
	out13Add_view <= reg13_add;
	out14Add_view <= reg14_add;
	out15Add_view <= reg15_add;

--	out0Add_view <= r0_saidaT;
--	out1Add_view <= r1_saidaT;
--	out2Add_view <= r2_saidaT;
--	out3Add_view <= r3_saidaT;
--	out4Add_view <= r4_saidaT;
--	out5Add_view <= r5_saidaT;
--	out6Add_view <= r6_saidaT;
--	out7Add_view <= r7_saidaT;
--	out8Add_view <= r8_saidaT;
--	out9Add_view <= r9_saidaT;
--	out10Add_view <= r10_saidaT;
--	out11Add_view <= r11_saidaT;
--	out12Add_view <= r12_saidaT;
--	out13Add_view <= r13_saidaT;
--	out14Add_view <= r14_saidaT;
--	out15Add_view <= r15_saidaT;
	
--	out0mix_view <= reg0_mix;
--	out1mix_view <= reg1_mix;
--	out2mix_view <= reg2_mix;
--	out3mix_view <= reg3_mix;
--	out4mix_view <= reg4_mix;
--	out5mix_view <= reg5_mix;
--	out6mix_view <= reg6_mix;
--	out7mix_view <= reg7_mix;
--	out8mix_view <= reg8_mix;
--	out9mix_view <= reg9_mix;
--	out10mix_view <= reg10_mix;
--	out11mix_view <= reg11_mix;
--	out12mix_view <= reg12_mix;
--	out13mix_view <= reg13_mix;
--	out14mix_view <= reg14_mix;
--	out15mix_view <= reg15_mix;
--	
--	out0mix_view <= reg0_txt;
--	out1mix_view <= reg1_txt;
--	out2mix_view <= reg2_txt;
--	out3mix_view <= reg3_txt;
--	out4mix_view <= reg4_txt;
--	out5mix_view <= reg5_txt;
--	out6mix_view <= reg6_txt;
--	out7mix_view <= reg7_txt;
--	out8mix_view <= reg8_txt;
--	out9mix_view <= reg9_txt;
--	out10mix_view <= reg10_txt;
--	out11mix_view <= reg11_txt;
--	out12mix_view <= reg12_txt;
--	out13mix_view <= reg13_txt;
--	out14mix_view <= reg14_txt;
--	out15mix_view <= reg15_txt;
--	
--
--	out0Chave_view <= reg0_subchave;
--	out1Chave_view <= reg1_subchave;
--	out2Chave_view <= reg2_subchave;
--	out3Chave_view <= reg3_subchave;
--	out4Chave_view <= reg4_subchave;
--	out5Chave_view <= reg5_subchave;
--	out6Chave_view <= reg6_subchave;
--	out7Chave_view <= reg7_subchave;
--	out8Chave_view <= reg8_subchave;
--	out9Chave_view <= reg9_subchave;
--	out10Chave_view <= reg10_subchave;
--	out11Chave_view <= reg11_subchave;
--	out12Chave_view <= reg12_subchave;
--	out13Chave_view <= reg13_subchave;
--	out14Chave_view <= reg14_subchave;
--	out15Chave_view <= reg15_subchave;
----		
--	out0Add_view <= reg0_key;
--	out1Add_view <= reg1_key;
--	out2Add_view <= reg2_key;
--	out3Add_view <= reg3_key;
--	out4Add_view <= reg4_key;
--	out5Add_view <= reg5_key;
--	out6Add_view <= reg6_key;
--	out7Add_view <= reg7_key;
--	out8Add_view <= reg8_key;
--	out9Add_view <= reg9_key;
--	out10Add_view <= reg10_key;
--	out11Add_view <= reg11_key;
--	out12Add_view <= reg12_key;
--	out13Add_view <= reg13_key;
--	out14Add_view <= reg14_key;
--	out15Add_view <= reg15_key;

--	out0Add_view <= reg0_mix;
--	out1Add_view <= reg1_mix;
--	out2Add_view <= reg2_mix;
--	out3Add_view <= reg3_mix;
--	out4Add_view <= reg4_mix;
--	out5Add_view <= reg5_mix;
--	out6Add_view <= reg6_mix;
--	out7Add_view <= reg7_mix;
--	out8Add_view <= reg8_mix;
--	out9Add_view <= reg9_mix;
--	out10Add_view <= reg10_mix;
--	out11Add_view <= reg11_mix;
--	out12Add_view <= reg12_mix;
--	out13Add_view <= reg13_mix;
--	out14Add_view <= reg14_mix;
--	out15Add_view <= reg15_mix;
	
--	out0Add_view <= reg0_subchave;
--	out1Add_view <= reg1_subchave;
--	out2Add_view <= reg2_subchave;
--	out3Add_view <= reg3_subchave;
--	out4Add_view <= reg4_subchave;
--	out5Add_view <= reg5_subchave;
--	out6Add_view <= reg6_subchave;
--	out7Add_view <= reg7_subchave;
--	out8Add_view <= reg8_subchave;
--	out9Add_view <= reg9_subchave;
--	out10Add_view <= reg10_subchave;
--	out11Add_view <= reg11_subchave;
--	out12Add_view <= reg12_subchave;
--	out13Add_view <= reg13_subchave;
--	out14Add_view <= reg14_subchave;
--	out15Add_view <= reg15_subchave;
----
--	out0Add_view <= reg0_txt;
--	out1Add_view <= reg1_txt;
--	out2Add_view <= reg2_txt;
--	out3Add_view <= reg3_txt;
--	out4Add_view <= reg4_txt;
--	out5Add_view <= reg5_txt;
--	out6Add_view <= reg6_txt;
--	out7Add_view <= reg7_txt;
--	out8Add_view <= reg8_txt;
--	out9Add_view <= reg9_txt;
--	out10Add_view <= reg10_txt;
--	out11Add_view <= reg11_txt;
--	out12Add_view <= reg12_txt;
--	out13Add_view <= reg13_txt;
--	out14Add_view <= reg14_txt;
--	out15Add_view <= reg15_txt;
----	
--	

--	out0Add_view <= reg0_key;
--	out1Add_view <= reg1_key;
--	out2Add_view <= reg2_key;
--	out3Add_view <= reg3_key;
--	out4Add_view <= reg4_key;
--	out5Add_view <= reg5_key;
--	out6Add_view <= reg6_key;
--	out7Add_view <= reg7_key;
--	out8Add_view <= reg8_key;
--	out9Add_view <= reg9_key;
--	out10Add_view <= reg10_key;
--	out11Add_view <= reg11_key;
--	out12Add_view <= reg12_key;
--	out13Add_view <= reg13_key;
--	out14Add_view <= reg14_key;
--	out15Add_view <= reg15_key;
--	

end implementa;
