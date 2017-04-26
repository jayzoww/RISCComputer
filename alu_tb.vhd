library ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.All;

entity alu_tb IS

end;

ARCHITECTURE alu_tb_arch OF alu_tb IS

	--SIGNAL tb_Add, tb_Sub, tb_And, tb_Or, tb_Not, tb_Booth, tb_Div, tb_Neg, tb_Shr, tb_Shl, tb_Ror, tb_Rol: STD_LOGIC;
	SIGNAL OP_tb : STD_LOGIC_VECTOR (3 downto 0);
	SIGNAL tb_inA, tb_inB : STD_LOGIC_VECTOR (31 downto 0);
	SIGNAL tb_Cout : STD_LOGIC_VECTOR (63 downto 0);


COMPONENT alu 
PORT (
		--OPAdd, OPSub, OPAnd, OPOr, OPNot, OPBooth, OPDiv, OPNeg, OPShr, OPShl, OPRor, OPRol: IN STD_LOGIC;
		OP : IN STD_LOGIC_VECTOR (3 downto 0);
		inA : IN STD_LOGIC_VECTOR (31 downto 0);
		inB : IN STD_LOGIC_VECTOR (31 downto 0);
		C_Out : OUT STD_LOGIC_VECTOR (63 downto 0)
);
end component alu;

begin 
DUT: alu

PORT MAP (
--	OPAdd	 => tb_Add, 
--	OPSub	 => tb_Sub, 
--	OPAnd	 => tb_And, 
--	OPOr	 => tb_Or, 
--	OPNot	 => tb_Not, 
--	OPBooth=> tb_Booth, 
--	OPDiv	 => tb_Div, 
--	OPNeg	 => tb_Neg, 
--	OPShr	 => tb_Shr, 
--	OPShl	 => tb_Shl, 
--	OPRor	 => tb_Ror, 
--	OPRol	 => tb_Rol,
	OP => OP_tb,
	inA	 => tb_inA, 
	inB	 => tb_inB, 
	C_Out  => tb_Cout
);

process 
	begin 
		wait for 20 ns;
		OP_tb <= "0001"; --add
		tb_inA <= x"00000014";
		tb_inB <= x"00000016";
		wait for 20 ns;
		OP_tb <= "1010"; --SHL
		tb_inA <= x"00000004";
		tb_inB <= x"00000002";
		wait for 20 ns;
		OP_tb <= "1011"; --ROR
		tb_inA <= x"00000006";
		tb_inB <= x"00000003";
		wait for 20 ns;
		OP_tb <= "0011"; --AND
		tb_inA <= x"00000044";
		tb_inB <= x"00000002";
		wait for 20 ns;
		OP_tb <= "0100"; --OR
		tb_inA <= x"00000022";
		tb_inB <= x"00000012";
		wait for 20 ns;
		OP_tb <= "1000"; --NEG
		tb_inA <= x"00000011";
		tb_inB <= x"00000072";
		wait for 20 ns;
		OP_tb <= "0111"; --DIV
		tb_inA <= x"00000064";
		tb_inB <= x"00000032";
		wait for 300 ns;
	end process;
end architecture;
