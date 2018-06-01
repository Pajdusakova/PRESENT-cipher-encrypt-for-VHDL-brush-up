library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity sBoxLayer is
	port( X:  in std_logic_vector(63 downto 0);
			Y: out std_logic_vector(63 downto 0));
end sBoxLayer;

architecture rtl of sBoxLayer is
	type s is array(0 to 15) of std_logic_vector(3 downto 0);
	constant sbox: s := ("1100", "0101", "0110", "1011",
								"1001", "0000", "1010", "1101",
								"0011", "1110", "1111", "1000",
								"0100", "0111", "0001", "0010");
begin
	Y<=sbox(conv_integer(X(63 downto 60))) & 
		sbox(conv_integer(X(59 downto 56))) & 
		sbox(conv_integer(X(55 downto 52))) & 
		sbox(conv_integer(X(51 downto 48))) & 
		sbox(conv_integer(X(47 downto 44))) & 
		sbox(conv_integer(X(43 downto 40))) & 
		sbox(conv_integer(X(39 downto 36))) & 
		sbox(conv_integer(X(35 downto 32))) & 
		sbox(conv_integer(X(31 downto 28))) & 
		sbox(conv_integer(X(27 downto 24))) & 
		sbox(conv_integer(X(23 downto 20))) & 
		sbox(conv_integer(X(19 downto 16))) & 
		sbox(conv_integer(X(15 downto 12))) & 
		sbox(conv_integer(X(11 downto  8))) & 
		sbox(conv_integer(X( 7 downto  4))) & 
		sbox(conv_integer(X( 3 downto  0)));
end rtl;