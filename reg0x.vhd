LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY reg0x IS

Port (
		clr, en, clk, BAout : IN STD_LOGIC;
		d : IN STD_LOGIC_VECTOR (31 downto 0);
		q : OUT STD_LOGIC_VECTOR (31 downto 0)
);
END ENTITY;


architecture reg0x_arch of reg0x IS
signal q_sig : std_logic_vector(31 downto 0);
begin
	process (en, clr, clk)
		begin	if (clr = '0') then 
		q_sig <= x"00000000";
		elsif (clk = '1') then
			if (en = '1') then
--				if (BAout = '1') then
--					q <= x"00000000";
--				else
--					q <= d;
--				end if;
				q_sig <= d;
			end if;
		end if;
	end process;
	q <= q_sig when (BAout = '0') else
			x"00000000";
end reg0x_arch;