

	library ieee;
	use ieee.std_logic_1164.all;
	
	entity MuxSub is 
	port(
		seletor : in std_logic_vector(3 downto 0);
		saida   : out std_logic_vector(7 downto 0)
	);
	end entity;
	
	architecture hardware of MuxSub is 
			
		signal r1 : std_logic_vector(7 downto 0) := X"01";
		signal r2 : std_logic_vector(7 downto 0) := X"02";
		signal r3 : std_logic_vector(7 downto 0) := X"04";
		signal r4 : std_logic_vector(7 downto 0) := X"08";
		signal r5 : std_logic_vector(7 downto 0) := X"10";
		signal r6 : std_logic_vector(7 downto 0) := X"20";
		signal r7 : std_logic_vector(7 downto 0) := X"40";
		signal r8 : std_logic_vector(7 downto 0) := X"80";
		signal r9 : std_logic_vector(7 downto 0) := X"1b";
		signal r10 : std_logic_vector(7 downto 0) := X"36";
	
	begin
	
	process(seletor)
	begin
		if(seletor = "0001") then
			saida <= r1;
		elsif (seletor = "0010") then
			saida <= r2;
		elsif (seletor = "0011") then 
			saida <= r3;
		elsif (seletor = "0100") then
			saida <= r4;
		elsif (seletor = "0101") then
			saida <= r5;
		elsif (seletor = "0110") then 
			saida <= r6;
		elsif (seletor = "0111") then
			saida <= r7;
		elsif (seletor = "1000") then
			saida <= r8;
		elsif (seletor = "1001") then
			saida <= r9;
		elsif (seletor = "1010") then
			saida <= r10;
		end if;
	end process;
	end hardware;