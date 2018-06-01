library IEEE;
use IEEE.std_logic_1164.all;

package array_roundkey is
	type rk is array(1 to 32) of std_logic_vector(63 downto 0);
end package array_roundkey;