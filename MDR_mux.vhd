LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MDR_mux IS

Port (
		MDRRead : IN STD_LOGIC;
		Mdatain : IN STD_LOGIC_VECTOR (31 downto 0);
		BusMuxOut : IN STD_LOGIC_VECTOR (31 downto 0);
		MDRMux_Out : OUT STD_LOGIC_VECTOR (31 downto 0)
);
END ENTITY;

ARCHITECTURE MDR_mux_arch of MDR_mux IS


BEGIN


MDRMux_Out <= BusMuxOut when (MDRRead = '0') else
				  Mdatain;

END ARCHITECTURE;
		