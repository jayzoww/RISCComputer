LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.my_components.all;

entity sel_encode is
Port (
		IR : in std_logic_vector(31 downto 0);
		Gra, Grb, Grc : in std_logic;
		Rout, Rin, BAout : in std_logic;
		R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out : out std_logic;
		R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in: out std_logic;
		Cout_sign_extended : out std_logic_vector(31 downto 0)
	);
end entity;

Architecture sel_encode_arch of sel_encode is

SIGNAL Ra, Rb, Rc , R_toDecode: std_logic_vector (3 downto 0);
SIGNAL DecoderRes : std_logic_vector(15 downto 0) := (others => '0');
SIGNAL intermediate : std_logic;

BEGIN
		Ra <= IR(26 downto 23);
		Rb <= IR(22 downto 19);
		Rc <= IR(18 downto 15);
		R_toDecode <= Ra when Gra = '1' else
						  Rb when Grb = '1' else
						  Rc;
					  
	DecoderRes <= x"0001" when (R_toDecode = "0000") else
					  x"0002" when (R_toDecode = "0001") else
					  x"0004" when (R_toDecode = "0010") else
					  x"0008" when (R_toDecode = "0011") else
					  x"0010" when (R_toDecode = "0100") else
					  x"0020" when (R_toDecode = "0101") else
					  x"0040" when (R_toDecode = "0110") else
					  x"0080" when (R_toDecode = "0111") else
					  x"0100" when (R_toDecode = "1000") else
					  x"0200" when (R_toDecode = "1001") else
					  x"0400" when (R_toDecode = "1010") else
					  x"0800" when (R_toDecode = "1011") else
					  x"1000" when (R_toDecode = "1100") else
					  x"2000" when (R_toDecode = "1101") else
					  x"4000" when (R_toDecode = "1110") else
					  x"8000" when (R_toDecode = "1111");
		--Register In Signal Generation					  
		R0in <= Rin and DecoderRes(0);
		R1in <= Rin and DecoderRes(1);
		R2in <= Rin and DecoderRes(2);
		R3in <= Rin and DecoderRes(3);
		R4in <= Rin and DecoderRes(4);
		R5in <= Rin and DecoderRes(5);
		R6in <= Rin and DecoderRes(6);
		R7in <= Rin and DecoderRes(7);
		R8in <= Rin and DecoderRes(8);
		R9in <= Rin and DecoderRes(9);
		R10in <= Rin and DecoderRes(10);
		R11in <= Rin and DecoderRes(11);
		R12in <= Rin and DecoderRes(12);
		R13in <= Rin and DecoderRes(13);
		R14in <= Rin and DecoderRes(14);
		R15in <= Rin and DecoderRes(15);

		--Register Out Signal Generation
		R0out <= (Rout OR BAout) and DecoderRes(0);
		R1out <= (Rout OR BAout)and DecoderRes(1);
		R2out <= (Rout OR BAout)and DecoderRes(2);
		R3out <= (Rout OR BAout)and DecoderRes(3);
		R4out <= (Rout OR BAout)and DecoderRes(4);
		R5out <= (Rout OR BAout)and DecoderRes(5);
		R6out <= (Rout OR BAout)and DecoderRes(6);
		R7out <= (Rout OR BAout)and DecoderRes(7);
		R8out <= (Rout OR BAout)and DecoderRes(8);
		R9out <= (Rout OR BAout)and DecoderRes(9);
		R10out <= (Rout OR BAout)and DecoderRes(10);
		R11out <= (Rout OR BAout)and DecoderRes(11);
		R12out <= (Rout OR BAout)and DecoderRes(12);
		R13out <= (Rout OR BAout)and DecoderRes(13);
		R14out <= (Rout OR BAout)and DecoderRes(14);
		R15out <= (Rout OR BAout)and DecoderRes(15);
	
	--op code: tentative
--		ld		 10001
--		ldi	 10010 
--		ldr	 10011
--		st		 10100
--		str	 10101
--		addi	 10110
--		andi	 10111
--		ori	 11000
--		branch 11001
--		jump	 11010
--		mfhi	 11011
--		mflo	 11100
--		in		 11101
--		out	 11110
--		out	 11111
--	intermediate <= '1' when IR(31) = '1';
	Cout_sign_extended (18 downto 0) <= IR (18 downto 0);
	Cout_sign_extended (31 downto 19)<= "1111111111111" when (IR(31) = '1' and IR(18) = '1') else
													"0000000000000" when (IR(31) = '1' and IR(18) = '0');
	
		
end architecture;