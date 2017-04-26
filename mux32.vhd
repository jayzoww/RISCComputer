LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux_32 IS

Port (
		clk : IN STD_LOGIC;
		ENCODE_IN : IN STD_LOGIC_VECTOR (4 downto 0);
		BUS_0_IN : IN STD_LOGIC_VECTOR (31 downto 0);
		BUS_1_IN : IN STD_LOGIC_VECTOR (31 downto 0);
		BUS_2_IN : IN STD_LOGIC_VECTOR (31 downto 0);
		BUS_3_IN : IN STD_LOGIC_VECTOR (31 downto 0);
		BUS_4_IN : IN STD_LOGIC_VECTOR (31 downto 0);
		BUS_5_IN : IN STD_LOGIC_VECTOR (31 downto 0);
		BUS_6_IN : IN STD_LOGIC_VECTOR (31 downto 0);
		BUS_7_IN : IN STD_LOGIC_VECTOR (31 downto 0);
		BUS_8_IN : IN STD_LOGIC_VECTOR (31 downto 0);
		BUS_9_IN : IN STD_LOGIC_VECTOR (31 downto 0);
		BUS_10_IN : IN STD_LOGIC_VECTOR (31 downto 0);
		BUS_11_IN : IN STD_LOGIC_VECTOR (31 downto 0);
		BUS_12_IN : IN STD_LOGIC_VECTOR (31 downto 0);
		BUS_13_IN : IN STD_LOGIC_VECTOR (31 downto 0);
		BUS_14_IN : IN STD_LOGIC_VECTOR (31 downto 0);
		BUS_15_IN : IN STD_LOGIC_VECTOR (31 downto 0);
		BUS_HI_IN : IN STD_LOGIC_VECTOR (31 downto 0);
		BUS_LO_IN : IN STD_LOGIC_VECTOR (31 downto 0);
		BUS_ZHi_IN : IN STD_LOGIC_VECTOR (31 downto 0);
		BUS_ZLo_IN : IN STD_LOGIC_VECTOR (31 downto 0);
		BUS_PC_IN : IN STD_LOGIC_VECTOR (31 downto 0);
		BUS_MDR_IN : IN STD_LOGIC_VECTOR (31 downto 0);
		BUS_InPort_IN : IN STD_LOGIC_VECTOR (31 downto 0);
		BUS_C_IN : IN STD_LOGIC_VECTOR (31 downto 0);
		BUS_OUT : OUT STD_LOGIC_VECTOR (31 downto 0)
);
END ENTITY;

ARCHITECTURE mux_32_arch of mux_32 IS


BEGIN


BUS_OUT <= BUS_0_IN when (ENCODE_IN = "00000") else
			  BUS_1_IN when (ENCODE_IN = "00001") else
			  BUS_2_IN when (ENCODE_IN = "00010") else
			  BUS_3_IN when (ENCODE_IN = "00011") else
			  BUS_4_IN when (ENCODE_IN = "00100") else
			  BUS_5_IN when (ENCODE_IN = "00101") else
			  BUS_6_IN when (ENCODE_IN = "00110") else
			  BUS_7_IN when (ENCODE_IN = "00111") else
			  BUS_8_IN when (ENCODE_IN = "01000") else
			  BUS_9_IN when (ENCODE_IN = "01001") else
			  BUS_10_IN when (ENCODE_IN = "01010") else
			  BUS_11_IN when (ENCODE_IN = "01011") else
			  BUS_12_IN when (ENCODE_IN = "01100") else
			  BUS_13_IN when (ENCODE_IN = "01101") else
			  BUS_14_IN when (ENCODE_IN = "01110") else
			  BUS_15_IN when (ENCODE_IN = "01111") else
			  BUS_HI_IN when (ENCODE_IN = "10000") else
			  BUS_LO_IN when (ENCODE_IN = "10001") else
			  BUS_ZHi_IN when (ENCODE_IN = "10010") else
			  BUS_ZLo_IN when (ENCODE_IN = "10011") else
			  BUS_PC_IN when (ENCODE_IN = "10100") else
			  BUS_MDR_IN when (ENCODE_IN = "10101") else
			  BUS_InPort_IN when (ENCODE_IN = "10110") else
			  BUS_C_IN when (ENCODE_IN = "10111") else
			  x"00000000";

END ARCHITECTURE;
		