library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.array_roundkey.all;

entity present_encrypt_80 is
	port( clk: 						 in std_logic;
			HEX3,HEX2,HEX1,HEX0: out std_logic_vector(7 downto 0));
end present_encrypt_80;

architecture rtl of present_encrypt_80 is
	signal plaintxt: std_logic_vector(63 downto 0) := (others=>'0');
	signal key: std_logic_vector(79 downto 0) := (others=>'0');
	signal crypt: std_logic_vector(63 downto 0);
	signal roundkey: rk;
	component generateRoundkeys is
		port( X:  in std_logic_vector(79 downto 0);
				Y: out rk);
	end component;
	component encryption is
		port( plaintxt: in std_logic_vector(63 downto 0);
				roundkey: in rk;
				crypt: 	out std_logic_vector(63 downto 0));
	end component;
	component show_16digit is
		port( clk: 			  in std_logic;
				C: 			  in std_logic_vector(63 downto 0);
				D3,D2,D1,D0: out std_logic_vector(7 downto 0));
	end component;
begin
	U1:generateRoundkeys port map(key,roundkey);
	U2:encryption port map(plaintxt,roundkey,crypt);
	U3:show_16digit port map(clk,crypt,HEX3,HEX2,HEX1,HEX0);
end rtl;