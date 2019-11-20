--Código do Mux 4:1

	library ieee;
	use ieee.std_logic_1164.all;
	
	entity Mux4p1 is
		port(
			inicio	: in std_logic_vector(127 downto 0);
			mix	: in std_logic_vector(127 downto 0);
			shift	: in std_logic_vector(127 downto 0);
			seletor	: in std_logic_vector(1 downto 0);
			saida		: out std_logic_vector(127 downto 0)
		);
	end entity;
	
	architecture implementaMux of Mux4p1 is
	signal d :  std_logic_vector(127 downto 0);
	begin 
		saida <= inicio when (seletor = "00") else
					mix 	 when (seletor = "01") else
					shift;
	end implementaMux;