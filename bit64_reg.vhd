LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY bit64_reg IS

Port (
		clr, en, clk : IN STD_LOGIC;
		d : IN STD_LOGIC_VECTOR (63 downto 0);
		q : OUT STD_LOGIC_VECTOR (63 downto 0)
);
END ENTITY;


architecture bit64_reg_arch of bit64_reg IS
begin
	process (en, clr)
		begin	if (clr = '0') then 
		q <= x"0000000000000000";
		elsif(rising_edge(clk)) then
			if (en = '1') then
			q <= d;
			end if;
		end if;
	end process;
end bit64_reg_arch;

