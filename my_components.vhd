library ieee;
use ieee.std_logic_1164.all;
package my_components is 
	component mux_32
		port(
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
	end component;
	component Encode32_5
		port(
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
	end component;
	component bit32_reg
		port(
			clr, en, clk : IN STD_LOGIC;
			d : IN STD_LOGIC_VECTOR (31 downto 0);
			q : OUT STD_LOGIC_VECTOR (31 downto 0)
	);
	end component;
	component bit64_reg
		port (
			clr, en, clk : IN STD_LOGIC;
			d : IN STD_LOGIC_VECTOR (63 downto 0);
			q : OUT STD_LOGIC_VECTOR (63 downto 0)
	);
	end component;
	component reg0x
		port(
			clr, en, clk, BAout : IN STD_LOGIC;
			d : IN STD_LOGIC_VECTOR (31 downto 0);
			q : OUT STD_LOGIC_VECTOR (31 downto 0)
	);
	end component;
	component MDR_mux
		Port (
			MDRRead : IN STD_LOGIC;
			Mdatain : IN STD_LOGIC_VECTOR (31 downto 0);
			BusMuxOut : IN STD_LOGIC_VECTOR (31 downto 0);
			MDRMux_Out : OUT STD_LOGIC_VECTOR (31 downto 0)
	);
	end component;
	component alu
	PORT (
		--OPAdd, OPSub, OPAnd, OPOr, OPNot, OPBooth, OPDiv, OPNeg, OPShr, OPShl, OPRor, OPRol: IN STD_LOGIC;
		OP : IN STD_LOGIC_VECTOR (3 downto 0);
		inA : IN STD_LOGIC_VECTOR (31 downto 0);
		inB : IN STD_LOGIC_VECTOR (31 downto 0);
		C_Out : OUT STD_LOGIC_VECTOR (63 downto 0)
	);
	end component;
	
	component Shift
		PORT
			(
				data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
				direction		: IN STD_LOGIC ;
				distance		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
				result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	end component;
	component Rotate 
		PORT 
			(
			data	: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			direction	: IN STD_LOGIC ;
			distance	: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			result	: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	end component;
	component Add_Sub
		PORT 
			(
		add_sub		: IN STD_LOGIC ;
		dataa		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		datab		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	end component;
	component div
		PORT
		(
		denom		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		numer		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		quotient		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		remain		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	end component;
	component booth
	port (
		multiplicand, multiplier : in STD_LOGIC_VECTOR (31 downto 0);
		result: out STD_LOGIC_VECTOR (63 downto 0)
	);
	end component;
	component sel_encode is
	Port (
		IR : in std_logic_vector(31 downto 0);
		Gra, Grb, Grc : in std_logic;
		Rout, Rin, BAout : in std_logic;
		R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out : out std_logic;
		R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in: out std_logic;
		Cout_sign_extended : out std_logic_vector(31 downto 0)
	);
	end component;
	component CON_FF is
	Port ( 
		IR, RegIn : in std_logic_vector (31 downto 0);
		CONin : in std_logic;
		CONout : out std_logic
		);
	end component;
	component RAM is
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (8 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		rden		: IN STD_LOGIC  := '1';
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	END component;
end package;