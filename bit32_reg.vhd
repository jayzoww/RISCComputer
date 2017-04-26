LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY bit32_reg IS

Port (
		clr, en, clk : IN STD_LOGIC;
		d : IN STD_LOGIC_VECTOR (31 downto 0);
		q : OUT STD_LOGIC_VECTOR (31 downto 0)
);
END ENTITY;


architecture bit32_reg_arch of bit32_reg IS
begin
	process (en, clr, clk)
		begin	if (clr = '0') then 
		q <= x"00000000";
		elsif (clk = '1') then
			if (en = '1') then
			q <= d;
			end if;
		end if;
	end process;
end bit32_reg_arch;

