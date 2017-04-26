library ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.All;
--use work.my_components.ALL;

entity booth_tb is
end entity;

architecture test_arch of booth_tb is 

signal tmulper, tmulcand : std_logic_vector(31 downto 0);
signal tres : std_logic_vector(63 downto 0);
component booth
	port (
		multiplicand, multiplier : in STD_LOGIC_VECTOR (31 downto 0);
		result: out STD_LOGIC_VECTOR (63 downto 0)
	);
	end component booth;

begin 
DUT : booth
port map (
						multiplicand => tmulcand, 
						multiplier => tmulper,
						result => tres);

process 
	begin 
		wait for 20 ns;
		tmulcand <= x"00000007";
		tmulper <= x"00000001";
		wait for 20 ns;
		tmulcand <= x"00000004";
		tmulper <= x"00000002";
		wait for 20 ns;
		tmulcand <= x"00000004";
		tmulper <= x"80000002";
		wait for 20 ns;
		tmulcand <= x"00000044";
		tmulper <= x"00000102";
		wait for 500 ns;
	end process;
end test_arch;		
			
			