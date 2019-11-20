
	library ieee;
	use ieee.std_logic_1164.all;
	
entity tb_AES is
end entity;
	
architecture hardware of tb_AES is

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
			--Enable_EntradaAddTxt		:  in std_logic;
			--Enable_EntradaAddKey		: 	in std_logic;
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

	signal e0, e1, e2, e3, e4, e5, e6, e7 : std_logic_vector(7 downto 0) := "00000000";
	signal ea, eb, ec, ed, eadd, esub, eshift, emix, echave : std_logic := '0';
	signal sel_addtxt : std_logic_vector(1 downto 0) := "00";
	signal sel_addkey, sel_entradasub : std_logic := '0';
	signal clk : std_logic := '0';
	signal out0, out1, out2, out3, out4, out5, out6, out7, out8, out9, out10,out11 : std_logic_vector(7 downto 0) := "00000000";
	signal out12, out13, out14, out15 : std_logic_vector(7 downto 0) := "00000000";
	signal eaddT, eaddK  : std_logic := '0';
	signal sel_rcon_sg : std_logic_vector(3 downto 0);
		
	begin


	instancia_topo : AES	
		port map(
			entrada0 => e0,
			entrada1 => e1,
			entrada2 => e2,
			entrada3 => e3,
			entrada4 => e4,
			entrada5 => e5,
			entrada6 => e6,
			entrada7 => e7,
			Enable_registradoresA => ea,
			Enable_registradoresB => eb,
			Enable_registradoresC => ec,
			Enable_registradoresD  => ed,
			Enable_Add => eadd,
			Enable_SubBytes	 => esub,
			Enable_ShiftRows	  => eshift,		
			Enable_Mix			 => emix,		
			Enable_SubChave	 => echave,	 
			Sel_EntradaAddTxt   => sel_addtxt,		
			Sel_EntradaAddKey => sel_addkey,	
			Sel_EntradaSubChave 	=> sel_entradasub,
			Sel_rcon => sel_rcon_sg,
			clock					=> clk,	
			out0Add_view => out0,
			out1Add_view => out1,
			out2Add_view => out2,
			out3Add_view => out3,
			out4Add_view => out4,
			out5Add_view => out5,
			out6Add_view => out6,
			out7Add_view => out7,
			out8Add_view => out8,
			out9Add_view => out9,
			out10Add_view => out10,
			out11Add_view => out11,
			out12Add_view => out12,
			out13Add_view => out13,
			out14Add_view => out14,
			out15Add_view => out15
		);

		-- Geracao do clock
		clk <= not clk after 20 ns; -- como começa com 0 em 20 ns ele vira 1 e assim sucessivamente
		
		process
		begin
		
		--Inicializa registradores-- 12*40ns + 5 ns +75 ns
		--estado 1
		wait for 5 ns;
		e0 <= X"6b";
		e1 <= X"c1";
		e2 <= X"be";
		e3 <= X"e2";
		e4 <= X"2e";
		e5 <= X"40";
		e6 <= X"9f"; 
		e7 <= X"96";
		ea <='1';
		wait for 40 ns;
		ea<='0';
		e0 <=	"00000000";
		e1 <=	"00000000";
		e2 <=	"00000000";
		e3 <=	"00000000";
		e4 <=	"00000000";
		e5 <=	"00000000";
		e6 <=	"00000000";
		e7 <=	"00000000";
		--estado 2
		wait for 40 ns;
		e0 <= X"e9";
		e1 <= X"3d";
		e2 <= X"7e";
		e3 <= X"11";
		e4 <= X"73";
		e5 <= X"93";
		e6 <= X"17";
		e7 <= X"2a";
		eb  <='1';
		wait for 40 ns;
		eb <= '0';
		e0 <=	"00000000";
		e1 <=	"00000000";
		e2 <=	"00000000";
		e3 <=	"00000000";
		e4 <=	"00000000";
		e5 <=	"00000000";
		e6 <=	"00000000";
		e7 <=	"00000000";
		--estado 3
		wait for 40 ns;
		e0 <=	X"2b";
		e1 <=	X"7e";
		e2 <=	X"15";
		e3 <=	X"16";
		e4 <=	X"28";
		e5 <=	X"ae";
		e6 <=	X"d2";
		e7 <=	X"a6";
		ec <= '1';
		wait for 40 ns;
		ec <= '0';
		e0 <=	"00000000";
		e1 <=	"00000000";
		e2 <=	"00000000";
		e3 <=	"00000000";
		e4 <=	"00000000";
		e5 <=	"00000000";
		e6 <=	"00000000";
		e7 <=	"00000000";
		--estado 4
		wait for 40 ns;
		e0 <= X"ab";
		e1 <= X"f7";
		e2 <= X"15"; -- aqui era 15 mas não ta aceitando, agora está :)
		e3 <= X"88";
		e4 <= X"09";
		e5 <= X"cf";
		e6 <= X"4f";
		e7 <= X"3c";
		ed <= '1';
		wait for 40 ns;
		ed <= '0';
		e0 <=	"00000000";
		e1 <=	"00000000";
		e2 <=	"00000000";
		e3 <=	"00000000";
		e4 <=	"00000000";
		e5 <=	"00000000";
		e6 <=	"00000000";
		e7 <=	"00000000";
	--Fim da inicializacao dos reg--
	
	--estado 5
	--Calculo do Add Round Key com texto e chave inicial --
		wait for 40 ns;
		sel_addtxt <= "00";
		sel_addkey <= '1';
		wait for 40 ns;
		eadd <= '1';
		wait for 40 ns;
		eadd <= '0'; 
	--fim do add round key com txt e chave inicial--
	
	--Calculo da sub chave usando chave inicial como entrada		
		wait for 40 ns;
		sel_entradasub <= '1';
		wait for 20 ns;
		Sel_rcon_sg	<= "0001";
		wait for 55 ns;
		echave <= '1';
		wait for 40 ns;
		echave <= '0';
	-- Fim do calculo da sub chave utilizando a chave inicial como entrada
	--estado 6	
			--RODADA 1--
	--Calculo Sub Bytes--
		wait for 40 ns;
		esub <= '1';
		wait for 40 ns;
		esub <= '0';
	-- Fim do Sub  Bytes-- 
	
	--Calculo Shift Rows--
		wait for 40 ns;
		eshift <= '1';
		wait for 40 ns;
		eshift <= '0';
	-- Fim do Shift -- 

	--Calculo do Mix--
		wait for 40 ns;
		emix <= '1';
		wait for 40 ns;
		emix <= '0';
	-- Fim do Mix-- 	
	
	--Calculo do Add Round Key com Mix e chave calculada --
		wait for 40 ns;
		sel_addtxt <= "01";
		sel_addkey <= '0';
		wait for 40 ns;
		eadd <= '1';
		wait for 40 ns;
		eadd <= '0'; 
	--fim do add round key com Mix e chave calculada--
	
	--Calculo da sub chave usando chave calculada como entrada		
		wait for 40 ns;
		sel_entradasub <= '0';
		wait for 20 ns;
		Sel_rcon_sg	<= "0010";
		wait for 55 ns;
		echave <= '1';
		wait for 40 ns;
		echave <= '0';
	-- Fim do calculo da sub chave utilizando a chave calculada como entrada
	--estado 7
			--RODADA 2--
	--Calculo Sub Bytes--
		wait for 40 ns;
		esub <= '1';
		wait for 40 ns;
		esub <= '0';
	-- Fim do Sub  Bytes-- 
	
	--Calculo Shift Rows--
		wait for 40 ns;
		eshift <= '1';
		wait for 40 ns;
		eshift <= '0';
	-- Fim do Shift -- 

	--Calculo do Mix--
		wait for 40 ns;
		emix <= '1';
		wait for 40 ns;
		emix <= '0';
	-- Fim do Mix-- 	
	
	--Calculo do Add Round Key com Mix e chave calculada --
		wait for 40 ns;
		sel_addtxt <= "01";
		sel_addkey <= '0';
		wait for 40 ns;
		eadd <= '1';
		wait for 40 ns;
		eadd <= '0'; 
	--fim do add round key com Mix e chave calculada--
	
	--Calculo da sub chave usando chave calculada como entrada		
		wait for 40 ns;
		sel_entradasub <= '0';
		wait for 20 ns;
		Sel_rcon_sg	<= "0011";
		wait for 55 ns;
		echave <= '1';
		wait for 40 ns;
		echave <= '0';
	-- Fim do calculo da sub chave utilizando a chave calculada como entrada
	--estado 8
			--RODADA 3--
		--Calculo Sub Bytes--
		wait for 40 ns;
		esub <= '1';
		wait for 40 ns;
		esub <= '0';
	-- Fim do Sub  Bytes-- 
	
	--Calculo Shift Rows--
		wait for 40 ns;
		eshift <= '1';
		wait for 40 ns;
		eshift <= '0';
	-- Fim do Shift -- 

	--Calculo do Mix--
		wait for 40 ns;
		emix <= '1';
		wait for 40 ns;
		emix <= '0';
	-- Fim do Mix-- 	
	
	--Calculo do Add Round Key com Mix e chave calculada --
		wait for 40 ns;
		sel_addtxt <= "01";
		sel_addkey <= '0';
		wait for 40 ns;
		eadd <= '1';
		wait for 40 ns;
		eadd <= '0'; 
	--fim do add round key com Mix e chave calculada--
	
	--Calculo da sub chave usando chave calculada como entrada		
		wait for 40 ns;
		sel_entradasub <= '0';
		wait for 20 ns;
		Sel_rcon_sg	<= "0100";
		wait for 55 ns;
		echave <= '1';
		wait for 40 ns;
		echave <= '0';
	-- Fim do calculo da sub chave utilizando a chave calculada como entrada
	--estado 9
			--RODADA 4--
		--Calculo Sub Bytes--
		wait for 40 ns;
		esub <= '1';
		wait for 40 ns;
		esub <= '0';
	-- Fim do Sub  Bytes-- 
	
	--Calculo Shift Rows--
		wait for 40 ns;
		eshift <= '1';
		wait for 40 ns;
		eshift <= '0';
	-- Fim do Shift -- 

	--Calculo do Mix--
		wait for 40 ns;
		emix <= '1';
		wait for 40 ns;
		emix <= '0';
	-- Fim do Mix-- 	
	
	--Calculo do Add Round Key com Mix e chave calculada --
		wait for 40 ns;
		sel_addtxt <= "01";
		sel_addkey <= '0';
		wait for 40 ns;
		eadd <= '1';
		wait for 40 ns;
		eadd <= '0'; 
	--fim do add round key com Mix e chave calculada--
	
	--Calculo da sub chave usando chave calculada como entrada		
		wait for 40 ns;
		sel_entradasub <= '0';
		wait for 20 ns;
		Sel_rcon_sg	<= "0101"; --chave 5
		wait for 55 ns;
		echave <= '1';
		wait for 40 ns;
		echave <= '0';
	-- Fim do calculo da sub chave utilizando a chave calculada como entrada
	--estado 10
			--RODADA 5--
		--Calculo Sub Bytes--
		wait for 40 ns;
		esub <= '1';
		wait for 40 ns;
		esub <= '0';
	-- Fim do Sub  Bytes-- 
	
	--Calculo Shift Rows--
		wait for 40 ns;
		eshift <= '1';
		wait for 40 ns;
		eshift <= '0';
	-- Fim do Shift -- 

	--Calculo do Mix--
		wait for 40 ns;
		emix <= '1';
		wait for 40 ns;
		emix <= '0';
	-- Fim do Mix-- 	
	
	--Calculo do Add Round Key com Mix e chave calculada --
		wait for 40 ns;
		sel_addtxt <= "01";
		sel_addkey <= '0';
		wait for 40 ns;
		eadd <= '1';
		wait for 40 ns;
		eadd <= '0'; 
	--fim do add round key com Mix e chave calculada--
	
	--Calculo da sub chave usando chave calculada como entrada		
		wait for 40 ns;
		sel_entradasub <= '0';
		wait for 20 ns;
		Sel_rcon_sg	<= "0110";
		wait for 55 ns;
		echave <= '1';
		wait for 40 ns;
		echave <= '0';
	-- Fim do calculo da sub chave utilizando a chave calculada como entrada
	--estado 11
			--RODADA 6--
		--Calculo Sub Bytes--
		wait for 40 ns;
		esub <= '1';
		wait for 40 ns;
		esub <= '0';
	-- Fim do Sub  Bytes-- 
	
	--Calculo Shift Rows--
		wait for 40 ns;
		eshift <= '1';
		wait for 40 ns;
		eshift <= '0';
	-- Fim do Shift -- 

	--Calculo do Mix--
		wait for 40 ns;
		emix <= '1';
		wait for 40 ns;
		emix <= '0';
	-- Fim do Mix-- 	
	
	--Calculo do Add Round Key com Mix e chave calculada --
		wait for 40 ns;
		sel_addtxt <= "01";
		sel_addkey <= '0';
		wait for 40 ns;
		eadd <= '1';
		wait for 40 ns;
		eadd <= '0'; 
	--fim do add round key com Mix e chave calculada--
	
	--Calculo da sub chave usando chave calculada como entrada		
		wait for 40 ns;
		sel_entradasub <= '0';
		wait for 20 ns;
		Sel_rcon_sg	<= "0111";
		wait for 55 ns;
		echave <= '1';
		wait for 40 ns;
		echave <= '0';
	-- Fim do calculo da sub chave utilizando a chave calculada como entrada
	--estado 12
			--RODADA 7--
		--Calculo Sub Bytes--
		wait for 40 ns;
		esub <= '1';
		wait for 40 ns;
		esub <= '0';
	-- Fim do Sub  Bytes-- 
	
	--Calculo Shift Rows--
		wait for 40 ns;
		eshift <= '1';
		wait for 40 ns;
		eshift <= '0';
	-- Fim do Shift -- 

	--Calculo do Mix--
		wait for 40 ns;
		emix <= '1';
		wait for 40 ns;
		emix <= '0';
	-- Fim do Mix-- 	
	
	--Calculo do Add Round Key com Mix e chave calculada --
		wait for 40 ns;
		sel_addtxt <= "01";
		sel_addkey <= '0';
		wait for 40 ns;
		eadd <= '1';
		wait for 40 ns;
		eadd <= '0'; 
	--fim do add round key com Mix e chave calculada--
	
	--Calculo da sub chave usando chave calculada como entrada		
		wait for 40 ns;
		sel_entradasub <= '0';
		wait for 20 ns;
		Sel_rcon_sg	<= "1000";
		wait for 55 ns;
		echave <= '1';
		wait for 40 ns;
		echave <= '0';
	-- Fim do calculo da sub chave utilizando a chave calculada como entrada
	--estado 13
			--RODADA 8--
		--Calculo Sub Bytes--
		wait for 40 ns;
		esub <= '1';
		wait for 40 ns;
		esub <= '0';
	-- Fim do Sub  Bytes-- 
	
	--Calculo Shift Rows--
		wait for 40 ns;
		eshift <= '1';
		wait for 40 ns;
		eshift <= '0';
	-- Fim do Shift -- 

	--Calculo do Mix--
		wait for 40 ns;
		emix <= '1';
		wait for 40 ns;
		emix <= '0';
	-- Fim do Mix-- 	
	
	--Calculo do Add Round Key com Mix e chave calculada --
		wait for 40 ns;
		sel_addtxt <= "01";
		sel_addkey <= '0';
		wait for 40 ns;
		eadd <= '1';
		wait for 40 ns;
		eadd <= '0'; 
	--fim do add round key com Mix e chave calculada--
	
	--Calculo da sub chave usando chave calculada como entrada		
		wait for 40 ns;
		sel_entradasub <= '0';
		wait for 20 ns;
		Sel_rcon_sg	<= "1001";
		wait for 55 ns;
		echave <= '1';
		wait for 40 ns;
		echave <= '0';
	-- Fim do calculo da sub chave utilizando a chave calculada como entrada
	--estado 14
			--RODADA 9--
	--Calculo Sub Bytes--
		wait for 40 ns;
		esub <= '1';
		wait for 40 ns;
		esub <= '0';
	-- Fim do Sub  Bytes-- 
	
	--Calculo Shift Rows--
		wait for 40 ns;
		eshift <= '1';
		wait for 40 ns;
		eshift <= '0';
	-- Fim do Shift -- 

	--Calculo do Mix--
		wait for 40 ns;
		emix <= '1';
		wait for 40 ns;
		emix <= '0';
	-- Fim do Mix-- 	
	
	--Calculo do Add Round Key com Mix e chave calculada --
		wait for 40 ns;
		sel_addtxt <= "01";
		sel_addkey <= '0';
		wait for 40 ns;
		eadd <= '1';
		wait for 40 ns;
		eadd <= '0'; 
	--fim do add round key com Mix e chave calculada--
	
	--Calculo da sub chave usando chave calculada como entrada		
		wait for 40 ns;
		sel_entradasub <= '0';
		wait for 20 ns;
		Sel_rcon_sg	<= "1010";
		wait for 55 ns;
		echave <= '1';
		wait for 40 ns;
		echave <= '0';
	-- Fim do calculo da sub chave utilizando a chave calculada como entrada
		--estado 15
		--RODADA 10--  7*40ns
		
		--Calculo Sub Bytes--
		wait for 40 ns;
		esub <= '1';
		wait for 40 ns;
		esub <= '0';
	-- Fim do Sub  Bytes-- 
	
	--Calculo Shift Rows--
		wait for 40 ns;
		eshift <= '1';
		wait for 40 ns;
		eshift <= '0';
	-- Fim do Shift -- 
	
	--Calculo do Add Round Key com Shift e chave calculada --
		wait for 40 ns;
		sel_addtxt <= "10";
		sel_addkey <= '0';
		wait for 40 ns;
		eadd <= '1';
		wait for 40 ns;
		eadd <= '0'; 
	--fim do add round key com Shift e chave calculada--	
		wait;
		end process;
		
		
end hardware;