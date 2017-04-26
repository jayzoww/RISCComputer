LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.All;
USE ieee.std_logic_arith.All;
USE ieee.numeric_std.ALL;
USE ieee.numeric_bit.ALL;
USE work.my_components.all;

ENTITY alu IS

PORT (
		--OPAdd, OPSub, OPAnd, OPOr, OPNot, OPBooth, OPDiv, OPNeg, OPShr, OPShl, OPRor, OPRol: IN STD_LOGIC;
		OP : IN STD_LOGIC_VECTOR (3 downto 0);
		inA : IN STD_LOGIC_VECTOR (31 downto 0);
		inB : IN STD_LOGIC_VECTOR (31 downto 0);
		C_Out : OUT STD_LOGIC_VECTOR (63 downto 0)
);
END ENTITY;

ARCHITECTURE alu_arch OF alu IS

SIGNAL Shl_Out, Shr_Out, Rol_Out, Ror_Out, Add_Out, Sub_Out, Div_Out, Remain_Out, IncPC : STD_LOGIC_VECTOR (31 downto 0);
SIGNAL Booth_Out : STD_LOGIC_VECTOR (63 downto 0);

BEGIN
SigSHL : Shift port map (data => inA, direction => '0', distance => inB(4 downto 0), result => Shl_Out);
SigSHR : Shift port map (data => inA, direction => '1', distance => inB(4 downto 0), result => Shr_Out);
SigROL : Rotate port map (data => inA, direction => '0', distance => inB(4 downto 0), result => Rol_Out);
SigROR : Rotate port map (data => inA, direction => '1', distance => inB(4 downto 0), result => Ror_Out);
SigAdd : Add_Sub port map (dataa => inA, datab => inB, add_sub => '1', result  => Add_Out);
SigPCinc: Add_Sub port map (dataa => x"00000001", datab => inB, add_sub => '1', result  => IncPC);
SigSub : Add_Sub port map (dataa => inA, datab => inB, add_sub => '0', result  => Sub_Out);
SigDiv : div port map (denom => inB, numer => inA, quotient => Div_Out, remain => Remain_Out);
SigBooth : booth port map (multiplicand =>inA, multiplier => inB, result => Booth_Out);


--	OPAdd 	= "00001" 
--	OPSub 	= "00010" 
--	OPAnd		= "00011" 
--	OPOr 		= "00100" 
--	OPNot 	= "00101" 
--	OPBooth 	= "00110" 
--	OPDiv 	= "00111" 
--	OPNeg 	= "01000" 
--	OPShr 	= "01001" 
--	OPShl 	= "01010" 
--	OPRor 	= "01011" 
--	OPRol 	= "01100"
-- IncPC 	= "01101"	
	
	C_Out (63 downto 32) <= Div_Out when (OP = "00111") else
									Booth_Out(63 downto 32) when (OP = "00110") else 
									x"00000000";
	C_Out (31 downto 0)	<= Add_Out when 	  (OP = "00001") else
									Sub_Out when 	  (OP = "00010") else
									inA and inB When (OP = "00011") else
									inA or  inB When (OP = "00100") else
									NOT inA When 	  (OP = "00101") else
									Booth_Out(31 downto 0)	when (OP = "00110") else
									Remain_Out when  (OP = "00111") else
									(NOT inA)+'1'when(OP = "01000") else
									Shr_Out when 	  (OP = "01001") else
									Shl_Out when 	  (OP = "01010") else
									Ror_Out when 	  (OP = "01011") else
									Rol_Out when 	  (OP = "01100") else
									IncPC	  when 	  (OP = "01101") else
									x"00000000";
									
									

END ARCHITECTURE;