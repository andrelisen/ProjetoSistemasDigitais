	library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
	

entity MixColumns is
	port (
--		a : in std_logic_vector(7 downto 0);
--		b: out std_logic_vector(7 downto 0)
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

architecture Behavioral of MixColumns is

	signal estouro : std_logic_vector(7 downto 0) := "00011011";
	signal um : std_logic_vector(7 downto 0) := "00000001";
	
begin
--	b<=std_logic_vector(unsigned(a) sll 1);
--Temos uma propriedade em que 03 * ei,j pode ser escrita como 2 * ei,j xor ei,j
--Para a primeira coluna de state [e0:e3], temos a primeira linha da matriz [m0,m4,m8,m12]
	process(e0, e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11, e12, e13, e14, e15)
		variable calc : std_logic_vector(7 downto 0);
		variable result : std_logic_vector(7 downto 0) := "00000000";
		variable s0_v, s1_v, s2_v, s3_v : std_logic_vector(7 downto 0) := "00000000";
		variable s4_v, s5_v, s6_v, s7_v : std_logic_vector(7 downto 0) := "00000000";
		variable s8_v, s9_v, s10_v, s11_v : std_logic_vector(7 downto 0) := "00000000";
		variable s12_v, s13_v, s14_v, s15_v : std_logic_vector(7 downto 0) := "00000000";
		
	begin
		--ELEMENTO S0
		if(e0(7) = '1') then 
			calc := std_logic_vector(unsigned(e0) sll 1);
			s0_v := calc xor estouro;
		else 
			s0_v := std_logic_vector(unsigned(e0) sll 1);
		end if;
		
		if(e1(7) = '1') then --CASO DO 3
			calc := std_logic_vector(unsigned(e1) sll 1);
			result := calc xor estouro;
			s1_v := result xor e1;
		else 
			result := std_logic_vector(unsigned(e1) sll 1);
			s1_v := result xor e1;
		end if;
		--Fazer o calculo do primeiro elemento 0,0
		s0 <= s0_v xor s1_v xor e2 xor e3;
		
		
		--ELEMENTO S1
		if(e1(7) = '1') then 
			calc := std_logic_vector(unsigned(e1) sll 1);
			s1_v := calc xor estouro;
		else 
			s1_v := std_logic_vector(unsigned(e1) sll 1);
		end if;
		
		if(e2(7) = '1') then --CASO DO 3
			calc := std_logic_vector(unsigned(e2) sll 1);
			result := calc xor estouro;
			s2_v := result xor e2;
		else 
			result := std_logic_vector(unsigned(e2) sll 1);
			s2_v := result xor e2;
		end if;
		--Fazer o calculo do primeiro elemento 0,0
		s1 <= s1_v xor s2_v xor e0 xor e3;
		
		
		--ELEMENTO S2
		if(e2(7) = '1') then 
			calc := std_logic_vector(unsigned(e2) sll 1);
			s2_v := calc xor estouro;
		else 
			s2_v := std_logic_vector(unsigned(e2) sll 1);
		end if;
		
		if(e3(7) = '1') then --CASO DO 3
			calc := std_logic_vector(unsigned(e3) sll 1);
			result := calc xor estouro;
			s3_v := result xor e3;
		else 
			result := std_logic_vector(unsigned(e3) sll 1);
			s3_v := result xor e3;
		end if;
		--Fazer o calculo do primeiro elemento 0,0
		s2 <= s2_v xor s3_v xor e0 xor e1;
		
		
		--ELEMENTO S3
		if(e3(7) = '1') then 
			calc := std_logic_vector(unsigned(e3) sll 1);
			s3_v := calc xor estouro;
		else 
			s3_v := std_logic_vector(unsigned(e3) sll 1);
		end if;
		
		if(e0(7) = '1') then --CASO DO 3
			calc := std_logic_vector(unsigned(e0) sll 1);
			result := calc xor estouro;
			s0_v := result xor e0;
		else 
			result := std_logic_vector(unsigned(e0) sll 1);
			s0_v := result xor e0;
		end if;
		--Fazer o calculo do primeiro elemento 0,0
		s3 <= s3_v xor s0_v xor e2 xor e1;
		
-------------------------------------------------------------------------------------------------


		--ELEMENTO S4
		if(e4(7) = '1') then 
			calc := std_logic_vector(unsigned(e4) sll 1);
			s4_v := calc xor estouro;
		else 
			s4_v := std_logic_vector(unsigned(e4) sll 1);
		end if;
		
		if(e5(7) = '1') then --CASO DO 3
			calc := std_logic_vector(unsigned(e5) sll 1);
			result := calc xor estouro;
			s5_v := result xor e5;
		else 
			result := std_logic_vector(unsigned(e5) sll 1);
			s5_v := result xor e5;
		end if;
		--Fazer o calculo do primeiro elemento 0,0
		s4 <= s4_v xor s5_v xor e6 xor e7;

		
		--ELEMENTO S5
		if(e5(7) = '1') then 
			calc := std_logic_vector(unsigned(e5) sll 1);
			s5_v := calc xor estouro;
		else 
			s5_v := std_logic_vector(unsigned(e5) sll 1);
		end if;
		
		if(e6(7) = '1') then --CASO DO 3
			calc := std_logic_vector(unsigned(e6) sll 1);
			result := calc xor estouro;
			s6_v := result xor e6;
		else 
			result := std_logic_vector(unsigned(e6) sll 1);
			s6_v := result xor e6;
		end if;
		--Fazer o calculo do primeiro elemento 0,0
		s5 <= s5_v xor s6_v xor e4 xor e7;
		
		
		--ELEMENTO S6
		if(e6(7) = '1') then 
			calc := std_logic_vector(unsigned(e6) sll 1);
			s6_v := calc xor estouro;
		else 
			s6_v := std_logic_vector(unsigned(e6) sll 1);
		end if;
		
		if(e7(7) = '1') then --CASO DO 3
			calc := std_logic_vector(unsigned(e7) sll 1);
			result := calc xor estouro;
			s7_v := result xor e7;
		else 
			result := std_logic_vector(unsigned(e7) sll 1);
			s7_v := result xor e7;
		end if;
		--Fazer o calculo do primeiro elemento 0,0
		s6 <= s6_v xor s7_v xor e4 xor e5;
		
		
		--ELEMENTO S7
		if(e7(7) = '1') then 
			calc := std_logic_vector(unsigned(e7) sll 1);
			s7_v := calc xor estouro;
		else 
			s7_v := std_logic_vector(unsigned(e7) sll 1);
		end if;
		
		if(e4(7) = '1') then --CASO DO 3
			calc := std_logic_vector(unsigned(e4) sll 1);
			result := calc xor estouro;
			s4_v := result xor e4;
		else 
			result := std_logic_vector(unsigned(e4) sll 1);
			s4_v := result xor e4;
		end if;
		--Fazer o calculo do primeiro elemento 0,0
		s7 <= s7_v xor s4_v xor e5 xor e6;
		
------------------------------------------------------------------------------------------------------

		--ELEMENTO S8
		if(e8(7) = '1') then 
			calc := std_logic_vector(unsigned(e8) sll 1);
			s8_v := calc xor estouro;
		else 
			s8_v := std_logic_vector(unsigned(e8) sll 1);
		end if;
		
		if(e9(7) = '1') then --CASO DO 3
			calc := std_logic_vector(unsigned(e9) sll 1);
			result := calc xor estouro;
			s9_v := result xor e9;
		else 
			result := std_logic_vector(unsigned(e9) sll 1);
			s9_v := result xor e9;
		end if;
		--Fazer o calculo do primeiro elemento 0,0
		s8 <= s8_v xor s9_v xor e10 xor e11;
		
		
		--ELEMENTO S9
		if(e9(7) = '1') then 
			calc := std_logic_vector(unsigned(e9) sll 1);
			s9_v := calc xor estouro;
		else 
			s9_v := std_logic_vector(unsigned(e9) sll 1);
		end if;
		
		if(e10(7) = '1') then --CASO DO 3
			calc := std_logic_vector(unsigned(e10) sll 1);
			result := calc xor estouro;
			s10_v := result xor e10;
		else 
			result := std_logic_vector(unsigned(e10) sll 1);
			s10_v := result xor e10;
		end if;
		--Fazer o calculo do primeiro elemento 0,0
		s9 <= s10_v xor s9_v xor e8 xor e11;
		
		
		--ELEMENTO S10
		if(e10(7) = '1') then 
			calc := std_logic_vector(unsigned(e10) sll 1);
			s10_v := calc xor estouro;
		else 
			s10_v := std_logic_vector(unsigned(e10) sll 1);
		end if;
		
		if(e11(7) = '1') then --CASO DO 3
			calc := std_logic_vector(unsigned(e11) sll 1);
			result := calc xor estouro;
			s11_v := result xor e11;
		else 
			result := std_logic_vector(unsigned(e11) sll 1);
			s11_v := result xor e11;
		end if;
		--Fazer o calculo do primeiro elemento 0,0
		s10 <= s10_v xor s11_v xor e8 xor e9;
		
		
		--ELEMENTO S11
		if(e11(7) = '1') then 
			calc := std_logic_vector(unsigned(e11) sll 1);
			s11_v := calc xor estouro;
		else 
			s11_v := std_logic_vector(unsigned(e11) sll 1);
		end if;
		
		if(e8(7) = '1') then --CASO DO 3
			calc := std_logic_vector(unsigned(e8) sll 1);
			result := calc xor estouro;
			s8_v := result xor e8;
		else 
			result := std_logic_vector(unsigned(e8) sll 1);
			s8_v := result xor e8;
		end if;
		--Fazer o calculo do primeiro elemento 0,0
		s11 <= s11_v xor s8_v xor e9 xor e10;
		
--------------------------------------------------------------------------------
	
		--ELEMENTO S12
		if(e12(7) = '1') then 
			calc := std_logic_vector(unsigned(e12) sll 1);
			s12_v := calc xor estouro;
		else 
			s12_v := std_logic_vector(unsigned(e12) sll 1);
		end if;
		
		if(e13(7) = '1') then --CASO DO 3
			calc := std_logic_vector(unsigned(e13) sll 1);
			result := calc xor estouro;
			s13_v := result xor e13;
		else 
			result := std_logic_vector(unsigned(e13) sll 1);
			s13_v := result xor e13;
		end if;
		--Fazer o calculo do primeiro elemento 0,0
		s12 <= s12_v xor s13_v xor e14 xor e15;

		
		--ELEMENTO S13
		if(e13(7) = '1') then 
			calc := std_logic_vector(unsigned(e13) sll 1);
			s13_v := calc xor estouro;
		else 
			s13_v := std_logic_vector(unsigned(e13) sll 1);
		end if;
		
		if(e14(7) = '1') then --CASO DO 3
			calc := std_logic_vector(unsigned(e14) sll 1);
			result := calc xor estouro;
			s14_v := result xor e14;
		else 
			result := std_logic_vector(unsigned(e14) sll 1);
			s14_v := result xor e14;
		end if;
		--Fazer o calculo do primeiro elemento 0,0
		s13 <= s13_v xor s14_v xor e12 xor e15;
		
		
		--ELEMENTO S14
		if(e14(7) = '1') then 
			calc := std_logic_vector(unsigned(e14) sll 1);
			s14_v := calc xor estouro;
		else 
			s14_v := std_logic_vector(unsigned(e14) sll 1);
		end if;
		
		if(e15(7) = '1') then --CASO DO 3
			calc := std_logic_vector(unsigned(e15) sll 1);
			result := calc xor estouro;
			s15_v := result xor e15;
		else 
			result := std_logic_vector(unsigned(e15) sll 1);
			s15_v := result xor e15;
		end if;
		--Fazer o calculo do primeiro elemento 0,0
		s14 <= s14_v xor s15_v xor e12 xor e13;
		
		
		--ELEMENTO S15
		if(e15(7) = '1') then 
			calc := std_logic_vector(unsigned(e15) sll 1);
			s15_v := calc xor estouro;
		else 
			s15_v := std_logic_vector(unsigned(e15) sll 1);
		end if;
		
		if(e12(7) = '1') then --CASO DO 3
			calc := std_logic_vector(unsigned(e12) sll 1);
			result := calc xor estouro;
			s12_v := result xor e12;
		else 
			result := std_logic_vector(unsigned(e12) sll 1);
			s12_v := result xor e12;
		end if;
		--Fazer o calculo do primeiro elemento 0,0
		s15 <= s15_v xor s12_v xor e13 xor e14;
		
	end process;
end Behavioral;