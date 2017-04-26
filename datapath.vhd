library ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.All;
USE work.my_components.all;

entity datapath is
PORT (	
		Cout_SE_DP: in std_logic_vector (31 downto 0);
		InputUnit : in std_logic_vector (31 downto 0);
		OutputUnit : out std_logic_vector (31 downto 0); 
		DP_BusMuxOut: inout std_logic_vector (31 downto 0);
		Clock, DP_clr:in Std_logic;
		StopRun_dp  :  in STD_LOGIC
		);
		
end entity;

architecture datapath_arch of datapath is

SIGNAL Gra_dp, Grb_dp, Grc_dp, ConFF_dp :  std_logic;
SIGNAL Rout_dp, Rin_dp, BAout_dp, CONin_dp  :  std_logic;
SIGNAL MDRout_dp, PCout_dp, Cout_dp, Highout_dp, Lowout_dp, Zlowout_dp, Zhighout_dp, inPortout_dp :  std_logic;
SIGNAL MARin_dp, PCin_dp, Zin_dp, ZHighin_dp, ZLowin_dp, Highin_dp, Lowin_dp, Cin_dp, MDRin_dp, IRin_dp, Yin_dp, outPortin_dp:  std_logic; 
SIGNAL Data_Read_dp, Data_Write_dp :  std_logic;
SIGNAL DP_OP : std_LOGIC_VECTOR (4 downto 0);

SIGNAL RegYToALU, Reg0ToBus, Reg1ToBus, Reg2ToBus, Reg3ToBus, Reg4ToBus, Reg5ToBus, Reg6ToBus, Reg7ToBus, Reg8ToBus, Reg9ToBus, Reg10ToBus, Reg11ToBus, 
		 Reg12ToBus, Reg13ToBus, Reg14ToBus, Reg15ToBus, RegHIToBus, RegLOToBus, RegPCToBus, RegMDRToBus, RegInportToBus, COutToBus, RegZHIToBus, RegZLOToBus, RegIROut, RegMARToRAM : STD_LOGIC_VECTOR(31 downto 0);
SIGNAL R0out_dp, R1out_dp, R2out_dp, R3out_dp, R4out_dp, R5out_dp, R6out_dp, R7out_dp, R8out_dp, R9out_dp, R10out_dp, R11out_dp, R12out_dp, R13out_dp, R14out_dp, R15out_dp,
		 R0in_dp, R1in_dp, R2in_dp, R3in_dp, R4in_dp, R5in_dp, R6in_dp, R7in_dp, R8in_dp, R9in_dp, R10in_dp, R11in_dp, R12in_dp, R13in_dp, R14in_dp, R15in_dp : std_logic;
SIGNAL DP_MDRMux_Out, DP_Mdatain : STD_LOGIC_VECTOR(31 downto 0);
SIGNAL DP_ENCODE_OUT : STD_LOGIC_VECTOR (4 downto 0);
SIGNAL DP_ALU_OUT : STD_LOGIC_VECTOR (63 downto 0);

begin

MDRMUX : MDR_mux port map (MDRRead => Data_Read_dp, 	Mdatain => DP_Mdatain, BusMuxOut => DP_BusMuxOut, MDRMux_Out => DP_MDRMux_Out);

CONTROL : control_unit port map	(
						Gra 			=> Gra_dp		, 
						Grb 			=> Grb_dp		, 
						Grc 			=> Grc_dp		,
						Rout 			=> Rout_dp 		, 
						Rin 			=> Rin_dp 		, 
						BAout			=> BAout_dp		, 
						CONin 		=> CONin_dp 	,
						MDRout		=> MDRout_dp	, 
						PCout			=> PCout_dp		, 
						Cout			=> Cout_dp		, 
						Highout		=> Highout_dp	, 
						Lowout		=> Lowout_dp	, 
						Zlowout		=> Zlowout_dp	, 
						Zhighout		=> Zhighout_dp	, 
						inPortout 	=> inPortout_dp,
						MARin			=> MARin_dp		, 
						PCin			=> PCin_dp		, 
						Zin			=> Zin_dp		, 
						ZHighin		=> ZHighin_dp	, 
						ZLowin		=> ZLowin_dp	, 
						Highin		=> Highin_dp	, 
						Lowin			=> Lowin_dp		, 
						Cin			=> Cin_dp		, 
						MDRin			=> MDRin_dp		, 
						IRin			=> IRin_dp		, 
						Yin			=> Yin_dp		, 
						outPortin	=> outPortin_dp,
						Data_Read	=> Data_Read_dp, 
						Data_Write 	=> Data_Write_dp,
						clk			=> Clock		, 
						clr			=> DP_clr		,
						ConFF			=> ConFF_dp		, 
						StopRun  	=> StopRun_dp  ,
						IR 			=> RegIROut,
						OP				=> DP_OP			
			);

BUSMUX : mux_32 port map (
						clk => Clock,
						ENCODE_IN => DP_ENCODE_OUT,
						BUS_0_IN => Reg0ToBus,
						BUS_1_IN => Reg1ToBus,
						BUS_2_IN => Reg2ToBus,
						BUS_3_IN => Reg3ToBus,
						BUS_4_IN => Reg4ToBus,
						BUS_5_IN => Reg5ToBus,
						BUS_6_IN => Reg6ToBus,
						BUS_7_IN => Reg7ToBus,
						BUS_8_IN => Reg8ToBus,
						BUS_9_IN => Reg9ToBus,
						BUS_10_IN => Reg10ToBus,
						BUS_11_IN => Reg11ToBus,
						BUS_12_IN => Reg12ToBus,
						BUS_13_IN => Reg13ToBus,
						BUS_14_IN => Reg14ToBus,
						BUS_15_IN => Reg15ToBus,
						BUS_HI_IN => RegHIToBus,
						BUS_LO_IN => RegLOToBus,
						BUS_ZHi_IN => RegZHIToBus,
						BUS_ZLo_IN => RegZLOToBus,
						BUS_PC_IN => RegPCToBus,
						BUS_MDR_IN => RegMDRToBus,
						BUS_InPort_IN => RegInportToBus,
						BUS_C_IN => COutToBus,
						BUS_OUT => DP_BusMuxOut );
						
ENCODER : Encode32_5 port map (
						clk => Clock,
						R0_OUT => R0out_dp,
						R1_OUT => R1out_dp,
						R2_OUT => R2out_dp,
						R3_OUT => R3out_dp,
						R4_OUT => R4out_dp,
						R5_OUT => R5out_dp,
                  R6_OUT => R6out_dp,
						R7_OUT => R7out_dp,
						R8_OUT => R8out_dp,
						R9_OUT => R9out_dp,
						R10_OUT => R10out_dp,
						R11_OUT => R11out_dp,
						R12_OUT => R12out_dp,
						R13_OUT => R13out_dp,
						R14_OUT => R14out_dp,
						R15_OUT => R15out_dp,
						HI_OUT => Highout_dp,
						LO_OUT => Lowout_dp,
						ZHi_OUT => Zhighout_dp,
						ZLo_OUT => Zlowout_dp,
						PC_OUT => PCout_dp,
						MDR_OUT => MDRout_dp,
                  InPort_OUT => inPortout_dp,
                  C_OUT => Cout_dp,
                  ENCODE_OUT => DP_ENCODE_OUT );

DP_ALU : alu port map (
						OP => DP_OP,
						inA => RegYToALU,
						inB => DP_BusMuxOut,
						C_Out => DP_ALU_OUT );
						
SELECTOR: sel_encode port map (

						IR => RegIROut,
						Gra	=>	Gra_dp,	
						Grb   => Grb_dp, 
						Grc   => Grc_dp,
						Rout  => Rout_dp,
						Rin   => Rin_dp,  
						BAout => BAout_dp,
						R0out  => R0out_dp,
						R1out  => R1out_dp,
						R2out  => R2out_dp,
						R3out  => R3out_dp,
						R4out  => R4out_dp,
						R5out  => R5out_dp,
						R6out  => R6out_dp,
						R7out  => R7out_dp,
						R8out  => R8out_dp,
						R9out  => R9out_dp,
						R10out => R10out_dp,
						R11out => R11out_dp,
						R12out => R12out_dp,
						R13out => R13out_dp,
						R14out => R14out_dp,
						R15out => R15out_dp,
						R0in  => R0in_dp,
						R1in  => R1in_dp,
						R2in  => R2in_dp,
						R3in  => R3in_dp,
						R4in  => R4in_dp,
						R5in  => R5in_dp,
						R6in  => R6in_dp,
						R7in  => R7in_dp,
						R8in  => R8in_dp,
						R9in  => R9in_dp,
						R10in => R10in_dp,
						R11in => R11in_dp,
						R12in => R12in_dp,
						R13in => R13in_dp,
						R14in => R14in_dp,
						R15in => R15in_dp,
						Cout_sign_extended => COutToBus);

CONTROLLA : CON_FF port map (
						
						IR => RegIROut,
						RegIn => DP_BusMuxOut,
						CONin => CONin_dp, 
						CONout=> ConFF_dp);
						
RAM_UNIT: RAM port map (
						address => RegMARToRAM(8 downto 0),
						clock => Clock,
						data	=> RegMDRToBus,
						rden	=> Data_Read_dp,
						wren	=> Data_Write_dp,
						q		=> DP_Mdatain);
						    
						
Reg0 : reg0x port map (clr => DP_clr, en => R0in_dp, clk => Clock, BAout => BAout_dp, d =>DP_BusMuxOut, q => Reg0ToBus);
Reg1 : bit32_reg port map (clr => DP_clr, en => R1in_dp, clk => Clock, d =>DP_BusMuxOut, q => Reg1ToBus);
Reg2 : bit32_reg port map (clr => DP_clr, en => R2in_dp, clk => Clock, d =>DP_BusMuxOut, q => Reg2ToBus);
Reg3 : bit32_reg port map (clr => DP_clr, en => R3in_dp, clk => Clock, d =>DP_BusMuxOut, q => Reg3ToBus);
Reg4 : bit32_reg port map (clr => DP_clr, en => R4in_dp, clk => Clock, d =>DP_BusMuxOut, q => Reg4ToBus);
Reg5 : bit32_reg port map (clr => DP_clr, en => R5in_dp, clk => Clock, d =>DP_BusMuxOut, q => Reg5ToBus);
                                                                                          
Reg6 : bit32_reg port map (clr => DP_clr, en => R6in_dp, clk => Clock, d =>DP_BusMuxOut, q => Reg6ToBus);
Reg7 : bit32_reg port map (clr => DP_clr, en => R7in_dp, clk => Clock, d =>DP_BusMuxOut, q => Reg7ToBus);
Reg8 : bit32_reg port map (clr => DP_clr, en => R8in_dp, clk => Clock, d =>DP_BusMuxOut, q => Reg8ToBus);
Reg9 : bit32_reg port map (clr => DP_clr, en => R9in_dp, clk => Clock, d =>DP_BusMuxOut, q => Reg9ToBus);
Reg10x : bit32_reg port map (clr => DP_clr, en => R10in_dp, clk => Clock, d =>DP_BusMuxOut, q => Reg10ToBus);
Reg11x : bit32_reg port map (clr => DP_clr, en => R11in_dp, clk => Clock, d =>DP_BusMuxOut, q => Reg11ToBus);

Reg12x : bit32_reg port map (clr => DP_clr, en => R12in_dp, clk => Clock, d =>DP_BusMuxOut, q => Reg12ToBus);
Reg13x : bit32_reg port map (clr => DP_clr, en => R13in_dp, clk => Clock, d =>DP_BusMuxOut, q => Reg13ToBus);
Reg14x : bit32_reg port map (clr => DP_clr, en => R14in_dp, clk => Clock, d =>DP_BusMuxOut, q => Reg14ToBus);
Reg15x : bit32_reg port map (clr => DP_clr, en => R15in_dp, clk => Clock, d =>DP_BusMuxOut, q => Reg15ToBus);
RegHI : bit32_reg port map (clr => DP_clr, en => Highin_dp, clk => Clock, d =>DP_BusMuxOut, q => RegHIToBus);
RegLO : bit32_reg port map (clr => DP_clr, en => Lowin_dp, clk => Clock, d =>DP_BusMuxOut,  q => RegLOToBus);

RegZHI : bit32_reg port map (clr => DP_clr, en => ZHighin_dp, clk => Clock, d =>DP_ALU_OUT (63 downto 32), q => RegZHIToBus );
RegZLO : bit32_reg port map (clr => DP_clr, en => ZLowin_dp, clk => Clock, d =>DP_ALU_OUT (31 downto 0),  q => RegZLOToBus );
RegPC : bit32_reg port map (clr => DP_clr, en => PCin_dp, clk => Clock, d =>DP_BusMuxOut, q => RegPCToBus);
RegMDR : bit32_reg port map (clr => DP_clr, en => MDRin_dp, clk => Clock, d =>DP_MDRMux_Out, q => RegMDRToBus);
--RegC : bit32_reg port map (clr => DP_clr, en => Cin, clk => Clock, d =>DP_BusMuxOut, q => COutToBus);
RegINPORT : bit32_reg port map (clr => DP_clr, en => inPortout_dp, clk => Clock, d =>inputUnit, q => RegInportToBus);
RegOUTPORT : bit32_reg port map (clr => DP_clr, en => outPortin_dp, clk => Clock, d =>DP_BusMuxOut, q => OutputUnit);
RegY : bit32_reg port map (clr => DP_clr, en => Yin_dp, clk => Clock, d =>DP_BusMuxOut, q => RegYToALU);
RegIR : bit32_reg	 port map (clr => DP_clr, en => IRin_dp, clk => Clock, d =>DP_BusMuxOut, q => RegIROut);
RegMAR : bit32_reg port map (clr => DP_clr, en => MARin_dp, clk => Clock, d =>DP_BusMuxOut, q => RegMARToRAM);

--RegC : bit64_reg port map (clr => DP_clr, en => R0in, clk => Clock, d => reg64_d, q => DP_ALU_OUT);

--Reg0ToBus <= x"00000000" when BAout_dp = '1' 



end architecture;
	