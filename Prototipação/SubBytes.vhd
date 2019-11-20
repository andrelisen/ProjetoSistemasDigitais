	library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

entity SubBytes is 
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
end entity;	

architecture hardwareSub of SubBytes is 

component memoria_sbox is
	port(
		entrada				: in 	   std_logic_vector   (7 downto 0);
		retorno				: out 	std_logic_vector   (7 downto 0)
		);
end component;

begin 

	e0_q : memoria_sbox
		port map(
			entrada => e0,
			retorno => s0
		);
		
	e1_q	: memoria_sbox
		port map(
			entrada => e1, 
			retorno => s1
		);

	e2_q	:	memoria_sbox
		port map(
			entrada => e2,
			retorno => s2
		);
		
	e3_q : memoria_sbox
		port map(
			entrada => e3,
			retorno =>s3
		);

	e4_q : memoria_sbox
		port map(
			entrada => e4,
			retorno => s4
		);
		
	e5_q	: memoria_sbox
		port map(
			entrada => e5, 
			retorno => s5
		);

	e6_q	:	memoria_sbox
		port map(
			entrada => e6,
			retorno => s6
		);
		
	e7_q : memoria_sbox
		port map(
			entrada => e7,
			retorno =>s7
		);
		
	e8_q : memoria_sbox
		port map(
			entrada => e8,
			retorno => s8
		);
		
	e9_q	: memoria_sbox
		port map(
			entrada => e9, 
			retorno => s9
		);

	e10_q	:	memoria_sbox
		port map(
			entrada => e10,
			retorno => s10
		);
		
	e11_q : memoria_sbox
		port map(
			entrada => e11,
			retorno =>s11
		);

	e12_q : memoria_sbox
		port map(
			entrada => e12,
			retorno => s12
		);
		
	e13_q	: memoria_sbox
		port map(
			entrada => e13, 
			retorno => s13
		);

	e14_q	:	memoria_sbox
		port map(
			entrada => e14,
			retorno => s14
		);
		
	e15_q : memoria_sbox
		port map(
			entrada => e15,
			retorno =>s15
		);
end hardwareSub;