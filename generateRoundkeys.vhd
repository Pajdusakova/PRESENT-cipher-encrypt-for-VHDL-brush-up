library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

library work;
use work.array_roundkey.all;

entity generateRoundkeys is
	port( X: in std_logic_vector(79 downto 0);
			Y: out rk);
end generateRoundkeys;

architecture rtl of generateRoundkeys is
	type s is array(0 to 15) of std_logic_vector(3 downto 0);
	constant sbox: s := ("1100", "0101", "0110", "1011",
								"1001", "0000", "1010", "1101",
								"0011", "1110", "1111", "1000",
								"0100", "0111", "0001", "0010");
	type temp is array(0 to 32) of std_logic_vector(79 downto 0);
	signal R: temp;	--rotate shifted
	signal C: temp;	--sbox converted
	signal A: temp;	--add counter
begin
--	Y(1)<=X(79 downto 16);
	A(0)<=X;
--	generateKeys: for i in 1 to 31 generate
--		R(i)<=to_stdlogicvector(to_bitvector(A(i-1)) ror 19);
--		C(i)<=sbox(conv_integer(R(i)(79 downto 76))) & R(i)(75 downto 0);
--		A(i)<=C(i) xor to_stdlogicvector(to_bitvector(conv_std_logic_vector(i, 64)) sll 15);
--		Y(i+1)<=A(i)(79 downto 16);
--	end generate;
	generateKeys: for i in 1 to 32 generate
		Y(i)<=A(i-1)(79 downto 16);
		R(i)<=to_stdlogicvector(to_bitvector(A(i-1)) ror 19);
		C(i)<=sbox(conv_integer(R(i)(79 downto 76))) & R(i)(75 downto 0);
		A(i)<=C(i) xor to_stdlogicvector(to_bitvector(conv_std_logic_vector(i, 64)) sll 15);
	end generate;
end rtl;