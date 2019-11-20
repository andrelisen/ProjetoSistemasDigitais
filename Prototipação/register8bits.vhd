-- Arquivo de criação do registradores de 8 bits

	library ieee;
	use ieee.std_logic_1164.all;
	
entity register8bits is
	port(
		clk		: in std_logic;
		enable	: in std_logic;
		d	      : in std_logic_vector(7 downto 0);
		q			: out std_logic_vector(7 downto 0)			
	);
end entity;

architecture hardwareRegistradores of register8bits is
begin
	process(clk) is
	begin 
		if(rising_edge(clk)) then
			if(enable = '1') then
				q <= d;
			end if;
		end if;
	end process;
end hardwareRegistradores;