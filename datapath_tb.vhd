library ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.All;


ENTITY datapath_tb IS 

END;

--Architecture of the testbench with the signal names 
ARCHITECTURE datapath_tb_arch OF datapath_tb IS --Add any other signal you would like to see in your simulation
SIGNAL	Cout_SE_tb:  std_logic_vector (31 downto 0);
SIGNAL	InputUnit_tb :  std_logic_vector (31 downto 0);
SIGNAL	OutputUnit_tb :  std_logic_vector (31 downto 0); 
SIGNAL	tb_BusMuxOut:  std_logic_vector (31 downto 0);
SIGNAL	Clock_tb, TB_clr: Std_logic;
SIGNAL	StopRun_tb  :   STD_LOGIC;

	
	
--component instantiation of the datapath
	COMPONENT datapath 
	PORT (
		Cout_SE_DP: in std_logic_vector (31 downto 0);
		InputUnit : in std_logic_vector (31 downto 0);
		OutputUnit : out std_logic_vector (31 downto 0); 
		DP_BusMuxOut: inout std_logic_vector (31 downto 0);
		Clock, DP_clr:in Std_logic;
		StopRun_dp  :  in STD_LOGIC
		);
	END COMPONENT datapath;

BEGIN 
DUT  : datapath --port mapping: between the dutand the testbench signals
	PORT MAP (
		Cout_SE_DP => Cout_SE_tb,
		InputUnit =>InputUnit_tb,
		OutputUnit=>OutputUnit_tb,
		DP_BusMuxOut=>tb_BusMuxOut,
		Clock		=>	Clock_tb,
		DP_clr 	=> TB_clr,
		StopRun_dp => StopRun_tb
		);


--add test logic here
	
	Clock_process:	PROCESS		
		BEGIN
			Clock_tb	<=	'0';
			Wait	for	10	ns;		
			Clock_tb	<=	'1';
			Wait	for	10	ns;		
		END	PROCESS	Clock_process;
	Process
	begin
	TB_clr <= '0';
	wait for 20 ns;
	TB_clr <= '1';
	wait for 10000 ns;
	end process;
END ARCHITECTURE datapath_tb_arch;