	library ieee;
	use ieee.std_logic_1164.all;
	
entity Conecta_topo is
	port(
		--declara apenas os sinais de entrada e saída sem os enables, já que eles irão vir da maq de estados
		--Entrada do texto
			entrada0_top		:	in std_logic_vector(7 downto 0);
			entrada1_top		:	in std_logic_vector(7 downto 0);
			entrada2_top		:	in std_logic_vector(7 downto 0);
			entrada3_top		:	in std_logic_vector(7 downto 0);
			entrada4_top		:	in std_logic_vector(7 downto 0);
			entrada5_top		:	in std_logic_vector(7 downto 0);
			entrada6_top		:	in std_logic_vector(7 downto 0);
			entrada7_top		:	in std_logic_vector(7 downto 0);
		--Clock e reset
			clk						:	in std_logic;
			rst						: 	in std_logic;
			
		--Sinal de depuracao
			out0Add_top, out1Add_top, out2Add_top, out3Add_top, out4Add_top, out5Add_top, out6Add_top, out7Add_top : out std_logic_vector(7 downto 0);
			out8Add_top, out9Add_top, out10Add_top, out11Add_top, out12Add_top, out13Add_top, out14Add_top, out15Add_top : out std_logic_vector(7 downto 0)
	
	);
end entity;	


architecture conectando_controle_operativa of Conecta_topo is 

component AES is
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
end component;

component controle_AES is
    port (
			--SINAL DE ENTRADA PARA A MAQ DE ESTADOS FUNCIONAR
			clock : in std_logic;
			reset : in std_logic;
			--SINAIS DE SAÍDA CALCULADOS PELA MAQ DE ESTADOS
			--Sinal de enable
			Enable_registradoresA	:	out std_logic;	--Inicializa 8 registradores
			Enable_registradoresB	:	out std_logic;	--Inicializa 8 registradores
			Enable_registradoresC	:	out std_logic;	--Inicializa 8 registradores
			Enable_registradoresD	:	out std_logic;	--Inicializa 8 registradores
			Enable_Add 					:	out std_logic;
			Enable_SubBytes			:  out std_logic;
			Enable_ShiftRows			:  out std_logic;
			Enable_Mix					:  out std_logic;
			Enable_SubChave			:  out std_logic;
		--Seletores
			Sel_EntradaAddTxt 		: out std_logic_vector(1 downto 0); -- entrada mux add txt
			Sel_EntradaAddKey 		: out std_logic;						  -- entrada mux add sub chave
			Sel_EntradaSubChave 		: out std_logic;
			Sel_rcon						: out std_logic_vector(3 downto 0)
    );
end component;
	
		--SINAIS QUE VAO CONECTAR CONTROLE COM PARTE OPERATIVA [controle_AES --> AES]
		signal ea_cntrl, eb_cntrl, ec_cntrl, ed_cntrl, eadd_cntrl, esubBytes_cntrl, eshift_cntrl, emix_cntrl, esubChave_cntrl : std_logic;
		signal  seletorAddKey_cntrl, seletorSubChave_cntrl : std_logic;
		signal seletorAddTxt_cntrl : std_logic_vector(1 downto 0);
		signal seletorRcon_cntrl : std_logic_vector(3 downto 0);

begin

	PC : controle_AES
		port map(
			clock => clk, 
			reset => rst, 
			Enable_registradoresA => ea_cntrl,
			Enable_registradoresB => eb_cntrl,
			Enable_registradoresC => ec_cntrl,
			Enable_registradoresD => ed_cntrl,
			Enable_Add				=> eadd_cntrl,
			Enable_SubBytes		=> esubBytes_cntrl,
			Enable_ShiftRows		=> eshift_cntrl,
			Enable_Mix				=> emix_cntrl,
			Enable_SubChave		=> esubChave_cntrl,
			Sel_EntradaAddTxt		=> seletorAddTxt_cntrl,
			Sel_EntradaAddKey		=> seletorAddKey_cntrl,
			Sel_EntradaSubChave	=> seletorSubChave_cntrl,
			Sel_rcon 				=> seletorRcon_cntrl
		);

	PO : AES
		port map(
			entrada0		=> entrada0_top,
			entrada1		=> entrada1_top,
			entrada2		=> entrada2_top,
			entrada3		=> entrada3_top,
			entrada4		=> entrada4_top,
			entrada5		=> entrada5_top,
			entrada6		=> entrada6_top,
			entrada7 	=> entrada7_top,
			Enable_registradoresA => ea_cntrl,
			Enable_registradoresB => eb_cntrl,
			Enable_registradoresC => ec_cntrl,
			Enable_registradoresD => ed_cntrl,
			Enable_Add				=> eadd_cntrl,
			Enable_SubBytes		=> esubBytes_cntrl,
			Enable_ShiftRows		=> eshift_cntrl,
			Enable_Mix				=> emix_cntrl,
			Enable_SubChave		=> esubChave_cntrl,
			Sel_EntradaAddTxt		=> seletorAddTxt_cntrl,
			Sel_EntradaAddKey		=> seletorAddKey_cntrl,
			Sel_EntradaSubChave	=> seletorSubChave_cntrl,
			Sel_rcon 				=> seletorRcon_cntrl,
			clock => clk,
			out0Add_view => out0Add_top, 
			out1Add_view => out1Add_top, 
			out2Add_view => out2Add_top,
			out3Add_view => out3Add_top, 
			out4Add_view => out4Add_top,
			out5Add_view => out5Add_top, 
			out6Add_view => out6Add_top, 
			out7Add_view => out7Add_top, 
			out8Add_view => out8Add_top,
			out9Add_view => out9Add_top, 
			out10Add_view => out10Add_top, 
			out11Add_view => out11Add_top, 
			out12Add_view => out12Add_top, 
			out13Add_view => out13Add_top, 
			out14Add_view => out14Add_top,
			out15Add_view => out15Add_top
		);
		
		
end conectando_controle_operativa;