	library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
	
entity SubChave is
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
end entity;

architecture hardware of SubChave is

	signal c12_sg, c13_sg, c14_sg, c15_sg : std_logic_vector(7 downto 0) := "00000000";
	signal t12_sg, t13_sg, t14_sg, t15_sg : std_logic_vector(7 downto 0):= "00000000";
	signal n0_sg, n1_sg, n2_sg, n3_sg, n4_sg, n5_sg, n6_sg : std_logic_vector(7 downto 0):= "00000000";
	signal n7_sg, n8_sg, n9_sg, n10_sg, n11_sg, n12_sg, n13_sg, n14_sg, n15_sg : std_logic_vector(7 downto 0):= "00000000";
	signal zero : std_logic_vector(7 downto 0) := "00000000";

	signal result :  std_logic_vector(7 downto 0) := "00000000";
	signal valor :  std_logic_vector(7 downto 0) := "00000000";
	
component memoria_sbox is
	port(
		entrada				: in 	   std_logic_vector   (7 downto 0);
		retorno				: out 	std_logic_vector   (7 downto 0)
		);
end component;
	
component MuxSub is 
	port(
		seletor : in std_logic_vector(3 downto 0);
		saida   : out std_logic_vector(7 downto 0)
	);
end component;	

begin
	
		seleciona : MuxSub
			port map(
				seletor => seletor,
				saida =>valor
			);
			--Rotaciona 1 byte
			c12_sg <= c13;
			c13_sg <= c14;
			c14_sg <= c15;
			c15_sg <= c12;
			
			--Troca esses valores por valores da S-BOX
			troca12 : memoria_sbox
				port map(
					entrada => c12_sg,
					retorno => t12_sg
				);
			
			troca13 : memoria_sbox
				port map(
					entrada => c13_sg,
					retorno => t13_sg
				);
			
			troca14 : memoria_sbox
				port map(
					entrada => c14_sg,
					retorno => t14_sg
				);
				
			troca15 : memoria_sbox
				port map(
					entrada => c15_sg,
					retorno => t15_sg
				);
			
			n0	<= t12_sg xor c0 xor valor;
			n0_sg <= t12_sg xor c0 xor valor;
			n1 <= t13_sg xor c1 xor zero;
			n1_sg <= t13_sg xor c1 xor zero;
			n2 <= t14_sg xor c2 xor zero;
			n2_sg <= t14_sg xor c2 xor zero;
			n3 <= t15_sg xor c3 xor zero;
			n3_sg <= t15_sg xor c3 xor zero;
			
			
			--pega nova coluna anterior e a segunda coluna da entrada da chave
			n4 <= n0_sg xor c4;
			n4_sg <= n0_sg xor c4;
			n5 <= n1_sg xor c5;
			n5_sg<= n1_sg xor c5;
			n6 <= n2_sg xor c6;
			n6_sg <= n2_sg xor c6;
			n7 <= n3_sg xor c7;
			n7_sg <=n3_sg xor c7;
			
			--pega coluna anterior e terceira coluna
			n8 <= n4_sg xor c8;
			n8_sg <= n4_sg xor c8;
			n9 <= n5_sg xor c9;
			n9_sg<= n5_sg xor c9;
			n10 <= n6_sg xor c10;
			n10_sg <= n6_sg xor c10;
			n11 <= n7_sg xor c11;
			n11_sg <=n7_sg xor c11;
			
			--pega coluna anterior e quarta coluna
			n12 <= n8_sg xor c12;
			n12_sg <= n8_sg xor c12;
			n13 <= n9_sg xor c13;
			n13_sg<= n9_sg xor c13;
			n14 <= n10_sg xor c14;
			n14_sg <= n10_sg xor c14;
			n15 <= n11_sg xor c15;
			n15_sg <=n11_sg xor c15;
					
		
end hardware;