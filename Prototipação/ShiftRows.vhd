	library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
	
entity ShiftRows is 
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

architecture implementaShift of ShiftRows is
begin
	--linha 1
	s0  <= e0;
	s4  <= e4;
	s8  <= e8;
	s12 <= e12;

	--linha 2
	s1	 <= e5;
	s5  <= e9;
	s9  <= e13;
	s13 <= e1;
	
	--linha 3
	s2  <= e10;
	s6  <= e14;
	s10 <= e2;
	s14 <= e6;
	
	--linha 4
	s3  <= e15;
	s7  <= e3;
	s11 <= e7;
	s15 <= e11;
	
	
end implementaShift;