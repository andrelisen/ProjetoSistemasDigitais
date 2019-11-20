--Código do Mux 2:1

	library ieee;
	use ieee.std_logic_1164.all;
	
	entity Mux2p1 is
		port(
			chave_inicial	: in std_logic_vector(127 downto 0);
			chave_calculada	: in std_logic_vector(127 downto 0);
			seletor	: in std_logic;
			saida		: out std_logic_vector(127 downto 0)
		);
	end entity;
	
	architecture implementaMux of Mux2p1 is
	begin 
		saida <= chave_inicial when (seletor = '1') else
					chave_calculada;
	end implementaMux;