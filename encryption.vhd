library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.array_roundkey.all;

entity encryption is
	port( plaintxt: in std_logic_vector(63 downto 0);
			roundkey: in rk;
			crypt: 	out std_logic_vector(63 downto 0));
end encryption;

architecture rtl of encryption is
	component sBoxLayer is
		port( X:  in std_logic_vector(63 downto 0);
				Y: out std_logic_vector(63 downto 0));
	end component;
	component pLayer is
		port( X:  in std_logic_vector(63 downto 0);
				Y: out std_logic_vector(63 downto 0));
	end component;
	type temp is array(0 to 31) of std_logic_vector(63 downto 0);
	signal A: temp;	-- add roundkey
	signal S: temp;	-- through sBoxLayer
	signal P: temp;	-- permutated
begin
	P(0)<=plaintxt;
	encrypting: for i in 1 to 31 generate
		A(i)<=P(i-1) xor roundkey(i);
		UU1:sBoxLayer port map(A(i),S(i));
		UU2:pLayer port map(S(i),P(i));
	end generate;
	crypt<=P(31) xor roundkey(32);
end rtl;