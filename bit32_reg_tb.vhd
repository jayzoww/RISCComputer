LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity bit32_reg_tb IS
END;

ARCHITECTURE bit32_reg_tb_arch of bit32_reg_tb IS
	SIGNAL	clr_tb,  en_tb, clk_tb :  STD_LOGIC := '0';
	SIGNAL		d_tb :  STD_LOGIC_VECTOR (31 downto 0);
	SIGNAL		q_tb :  STD_LOGIC_VECTOR (31 downto 0); 
	COMPONENT bit32_reg
	PORT(	clr, en, clk : IN STD_LOGIC;
		d : IN STD_LOGIC_VECTOR (31 downto 0);
		q : OUT STD_LOGIC_VECTOR (31 downto 0)
	); END COMPONENT bit32_reg;
	
BEGIN
	DUT1 : bit32_reg
	PORT MAP(clk => clk_tb, 
				clr => clr_tb,
				en => en_tb,
				d => d_tb,
				q => q_tb
	);
	

	
	sim_process : process
	begin

		d_tb <= x"00000001";
		wait for 50 ns;
		clr_tb <= '1';
		wait for 50 ns;
		en_tb <= '1';

		wait;
	end process;
END;
	
	

	
