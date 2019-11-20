-- Criação do Add Round Key

library ieee;
use ieee.std_logic_1164.all;

entity AddRound is
	port(
		e0, e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11, e12, e13, e14, e15	:	in std_logic_vector(7 downto 0);
		t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15	:	in std_logic_vector(7 downto 0);
		r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15 : out std_logic_vector(7 downto 0)
	);
end entity;

architecture hardwareAddRound of AddRound is
begin
			r0 <= e0 xor t0;
			r1 <= e1 xor t1;
			r2 <= e2 xor t2;
			r3 <= e3 xor t3;
			r4 <= e4 xor t4;
			r5 <= e5 xor t5;
			r6 <= e6 xor t6;
			r7 <= e7 xor t7;
			r8 <= e8 xor t8;
			r9 <= e9 xor t9;
			r10 <= e10 xor t10;
			r11 <= e11 xor t11;
			r12 <= e12 xor t12;
			r13 <= e13 xor t13;
			r14 <= e14 xor t14;
			r15 <= e15 xor t15;
		
end hardwareAddRound;