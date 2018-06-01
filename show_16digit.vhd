--wait tukatte nantoka sitai

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity show_16digit is
	port( clk: in std_logic;
			C: in std_logic_vector(63 downto 0);
			D3,D2,D1,D0: out std_logic_vector(7 downto 0));	--Digit
end show_16digit;

architecture rtl of show_16digit is
	type temp is array(0 to 15) of std_logic_vector(7 downto 0);
	signal count: integer range 0 to 250000000;
	constant b2d: temp := ("00000011", "10011111", "00100101", "00001101",
								  "10011001", "01001001", "01000001", "00011011",
								  "00000001", "00001001", "00010001", "11000001",
								  "01100011", "10000101", "01100001", "01110001");
	signal bd: temp;	--bit digit
begin
	setDigit: for i in 0 to 15 generate
		bd(i)<=b2d(conv_integer(C(4*i+3 downto 4*i)));
	end generate;
	
	process(clk,count)
	begin
		if clk'event and clk='1' then
			count<=count+1;
			if count<50000000 then
				D3<=bd(15);	D2<=bd(14);	D1<=bd(13);	D0<=bd(12);
			end if;
			if (count>49999999) and (count<100000000) then
				D3<=bd(11);	D2<=bd(10);	D1<=bd(9);	D0<=bd(8);
			end if;
			if (count>99999999) and (count<150000000) then
				D3<=bd(7);	D2<=bd(6);	D1<=bd(5);	D0<=bd(4);
			end if;
			if (count>149999999) and (count<200000000) then
				D3<=bd(3);	D2<=bd(2);	D1<=bd(1);	D0<=bd(0);
			end if;
			if (count>199999999) and (count<250000000) then
				D3<="11111110"; D2<="11111110"; D1<="11111110"; D0<="11111110";
			end if;
			if count>249999999 then
				count<=0;
			end if;
		end if;
	end process;
end rtl;