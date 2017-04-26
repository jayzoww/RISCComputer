LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Encode32_5 IS

Port (
		clk : IN STD_LOGIC;
		R0_OUT : IN STD_LOGIC;
		R1_OUT : IN STD_LOGIC;
		R2_OUT : IN STD_LOGIC;
		R3_OUT : IN STD_LOGIC;
		R4_OUT : IN STD_LOGIC;
		R5_OUT : IN STD_LOGIC;
		R6_OUT : IN STD_LOGIC;
		R7_OUT : IN STD_LOGIC;
		R8_OUT : IN STD_LOGIC;
		R9_OUT : IN STD_LOGIC;
		R10_OUT : IN STD_LOGIC;
		R11_OUT : IN STD_LOGIC;
		R12_OUT : IN STD_LOGIC;
		R13_OUT : IN STD_LOGIC;
		R14_OUT : IN STD_LOGIC;
		R15_OUT : IN STD_LOGIC;
		HI_OUT : IN STD_LOGIC;
		LO_OUT : IN STD_LOGIC;
		ZHi_OUT : IN STD_LOGIC;
		ZLo_OUT : IN STD_LOGIC;
		PC_OUT : IN STD_LOGIC;
		MDR_OUT : IN STD_LOGIC;
		InPort_OUT : IN STD_LOGIC;
		C_OUT : IN STD_LOGIC;
		ENCODE_OUT : OUT STD_LOGIC_VECTOR (4 downto 0)
);
END ENTITY;

ARCHITECTURE Encode32_5_arch of Encode32_5 IS


BEGIN


ENCODE_OUT <= "00000" when ( R0_OUT = '1') else
				  "00001" when ( R1_OUT = '1') else
				  "00010" when ( R2_OUT = '1') else
				  "00011" when ( R3_OUT = '1') else
				  "00100" when ( R4_OUT = '1') else
				  "00101" when ( R5_OUT = '1') else
				  "00110" when ( R6_OUT = '1') else
				  "00111" when ( R7_OUT = '1') else
				  "01000" when ( R8_OUT = '1') else
				  "01001" when ( R9_OUT = '1') else
				  "01010" when ( R10_OUT = '1') else
				  "01011" when ( R11_OUT = '1') else
				  "01100" when ( R12_OUT = '1') else
				  "01101" when ( R13_OUT = '1') else
				  "01110" when ( R14_OUT = '1') else
				  "01111" when ( R15_OUT = '1') else
				  "10000" when ( HI_OUT = '1') else
				  "10001" when ( LO_OUT = '1') else
				  "10010" when ( ZHi_OUT = '1') else
				  "10011" when ( ZLo_OUT = '1') else
				  "10100" when ( PC_OUT = '1') else
				  "10101" when ( MDR_OUT = '1') else
				  "10110" when ( InPort_OUT = '1') else
				  "10111" when ( C_OUT = '1') else
				  "11111";

END ARCHITECTURE;
		