LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity out_port is 
Port (
		clr, clk, en : in std_logic;
		d : in std_logic_vector(31 downto 0);
		q : out std_logic_vector (31 downto 0)
		);
end entity;
Architecture out_port_arch of out_port is
begin
process (clk, en, clr)
	begin
		if (clr = '0') then 
			q <= x"00000000";
			elsif (clk = '1') then
				if (en = '1') then
				q <= d;
				end if;
			end if;
	end process;
end architecture;