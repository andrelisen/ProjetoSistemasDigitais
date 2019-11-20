	library ieee;
	use ieee.std_logic_1164.all;

	entity tb_TOPO is
	end entity;
	
architecture implementa of tb_TOPO is

component Conecta_topo is
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
end component;	
	
	signal e0, e1, e2, e3, e4, e5, e6, e7 : std_logic_vector(7 downto 0) := "00000000";
	signal clk_sg, rst_sg : std_logic := '0';
	signal out0, out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13, out14, out15 : std_logic_vector(7 downto 0);
	
begin 

	instancia_topo : Conecta_topo
		port map(
			entrada0_top	=> e0,	
			entrada1_top	=> e1,	
			entrada2_top	=> e2,	
			entrada3_top	=> e3,	
			entrada4_top	=> e4,	
			entrada5_top	=> e5,	
			entrada6_top	=> e6,	
			entrada7_top	=> e7,
			clk				=> clk_sg,
			rst				=> rst_sg,
			out0Add_top		=> out0,
			out1Add_top		=>out1,
			out2Add_top		=>out2,
			out3Add_top		=>out3,
			out4Add_top		=>out4,
			out5Add_top		=>out5,
			out6Add_top		=>out6,
			out7Add_top		=>out7,
			out8Add_top		=>out8,
			out9Add_top		=>out9,
			out10Add_top	=>out10,
			out11Add_top	=>out11,
			out12Add_top	=>out12,
			out13Add_top	=>out13,
			out14Add_top => out14,
			out15Add_top => out15
		);
		
		clk_sg <= not clk_sg after 120 ns;
		
		process
		begin 
		rst_sg <= '1';
		e0 <= X"6b";
		e1 <= X"c1";
		e2 <= X"be";
		e3 <= X"e2";
		e4	<= X"2e";
		e5	<= X"40";
		e6 <= X"9f";
		e7 <= X"96";
		wait for 240 ns;
		rst_sg <= '0';
		wait for 340 ns;
		e0 <= X"e9";
		e1 <= X"3d";
		e2 <= X"7e";
		e3 <= X"11";
		e4	<= X"73";
		e5	<= X"93";
		e6 <= X"17";
		e7 <= X"2a";
		wait for 120 ns;
		e0 <= X"2b";
		e1 <= X"7e";
		e2 <= X"15";
		e3 <= X"16";
		e4	<= X"28";
		e5	<= X"ae";
		e6 <= X"d2";
		e7 <= X"a6";
		wait for 340 ns;
		e0 <= X"ab";
		e1 <= X"f7";
		e2 <= X"15";
		e3 <= X"88";
		e4	<= X"09";
		e5	<= X"cf";
		e6 <= X"4f";
		e7 <= X"3c";
		wait;
		end process;

end implementa;