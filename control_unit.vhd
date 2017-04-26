LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.All;
USE work.my_components.all;


entity control_unit is
Port (
		Gra , Grb , Grc  : OUT std_logic;
		Rout , Rin , BAout, CONin  : OUT std_logic;
		MDRout, PCout, Cout, Highout, Lowout, Zlowout, Zhighout, inPortout : OUT std_logic;
		MARin, PCin, Zin, ZHighin, ZLowin, Highin, Lowin, Cin, MDRin, IRin, Yin, outPortin: OUT std_logic; 
		Data_Read, Data_Write : OUT std_logic;
		OP : OUT std_LOGIC_VECTOR (4 downto 0);
		clk, clr:in Std_logic;
		ConFF, StopRun  : in STD_LOGIC;
		IR : in std_LOGIC_VECTOR(31 downto 0)
);
end entity;

Architecture control_unit_arch of control_unit is
	SIGNAL finish : std_logic;
	TYPE State IS (default, fetch0, fetch1, fetchwait, fetch2, fetchwait2,
						--booth
						booth1, booth2, booth3, booth4,
						--add
						add1, add2, add3, 
						--subtract
						sub1, sub2, sub3, 
						--divide
						div1, div2, div3, div4,
						--and	
						and1, and2, and3,
						--or	
						or1,  or2,  or3,
						--shift right	
						shr1, shr2, shr3,
						--shift left
						shl1, shl2, shl3,
						--rotate right	
						ror1, ror2, ror3, 
						--rotate left
						rol1, rol2, rol3, 
						--not
						not1, not2, not3, 
						--negate
						neg1, neg2, neg3,
						--ld
						ld1, ld2, ld3, ld4, ld5, ld4wait,
						--ldi
						ldi1, ldi2, ldi3,  						
						--ldr	
						ldr1, ldr2, ldr3, ldr4, ldr3wait,
						--store
						st1, st2, st3, st4, st5, 
						--str
						str1, str2, str3, str4, 
						-- addi
						addi1, addi2, addi3, 
						-- ori
						ori1, ori2, ori3, 
						-- andi
						andi1, andi2, andi3, 
						--branch
						branch1, branch2, 
						--JUMP
						jump1,
						jal1, jal2, 
						--mfhi/lo
						mfhi1, 
						mflo1, 
						--in/out
						in1, 
						out1, 
						--interrupt states
						nop, halt
						);
	SIGNAL Present_state: State := default;
 begin
	finish <= StopRun;
	process (clk, clr, StopRun)
	begin
		if (clr = '0') then
			present_state <= default;
		elsif (clk'EVENT and clk = '1' ) then
			CASE present_state is
				when default =>
					present_state <= fetch0;
				when fetch0 =>
					present_state <= fetch1;
				when fetch1 =>
					present_state <= fetchwait;
				when fetchwait =>
					present_state <= fetch2;
				when fetch2 =>
					present_state <= fetchwait2;
				when fetchwait2 =>
				--Select operation after loading instruction
					CASE IR(31 downto 27) IS
						WHEN "00001"	=>
							present_state <= add1;
						WHEN "00010"	=>
							present_state <= sub1;
						WHEN "00011"	=>
							present_state <= and1;
						WHEN "00100"	=>
							present_state <= or1;
						WHEN "00101"	=>
							present_state <= not1;
						WHEN "00110"	=>
							present_state <= booth1;
						WHEN "00111"	=>
							present_state <= div1;
						WHEN "01000"	=>
							present_state <= neg1;
						WHEN "01001"	=>
							present_state <= shr1;
						WHEN "01010"	=>
							present_state <= shl1;
						WHEN "01011"	=>
							present_state <= ror1;
						WHEN "01100"	=>
							present_state <= rol1;
						WHEN "10000" 	=>
							present_state <= nop;
						WHEN "10001"	=>
							present_state <= ld1;
						WHEN "10010"	=>
							present_state <= ldi1;
						WHEN "10011"	=>
							present_state <= ldr1;
						WHEN "10100"	=>
							present_state <= st1;
						WHEN "10101"	=>
							present_state <= str1;
						WHEN "10110"	=>
							present_state <= addi1;
						WHEN "10111"	=>
							present_state <= and1;
						WHEN "11000"	=>
							present_state <= ori1;
						WHEN "11001"	=>
							present_state <= branch1;
						WHEN "11010"	=>
							present_state <= jump1;
						WHEN "11011"	=>
							present_state <= mfhi1;
						WHEN "11100"	=>
							present_state <= mflo1;
						WHEN "11101"	=>
							present_state <= in1;
						WHEN "11110"	=>
							present_state <= out1;
						WHEN "11111"	=>
							present_state <= jal1;
						WHEN "00000"  	=>
							present_state <= halt;
						when others=>
					end case;
				--continue execution after selecting op
					--if ADD
				when add1 =>
					present_state <= add2;
				when add2 =>
					present_state <= add3;	
					--if SUB
				when sub1 =>
					present_state <= sub2;
				when sub2 =>
					present_state <= sub3;
					--if AND
				when and1 =>
					present_state <= and2;
				when and2 =>
					present_state <= and3;
					--if OR
				when or1 =>
					present_state <= or2;
				when or2 =>
					present_state <= or3;
					--if DIV
				when div1 =>
					present_state <= div2;
				when div2 =>
					present_state <= div3;
				when div3 =>
					present_state <= div4;
					--if BOOTH
				when booth1 =>
					present_state <= booth2;
				when booth2 =>
					present_state <= booth3;
				when booth3 =>
					present_state <= booth4;
					--if NOT
				when not1 =>
					present_state <= not2;
				when not2 =>
					present_state <= not3;
					--if NEG
				when neg1 =>
					present_state <= neg2;
				when neg2 =>
					present_state <= neg3;
					--if SHL
				when shl1 =>
					present_state <= shl2;
				when shl2 =>
					present_state <= shl3;
					--if SHR
				when shr1 =>
					present_state <= shr2;
				when shr2 =>
					present_state <= shr3;
					--if ROL
				when rol1 =>
					present_state <= rol2;
				when rol2 =>
					present_state <= rol3;
					--if ROR
				when ror1 =>
					present_state <= ror2;
				when ror2 =>
					present_state <= ror3;
					--if LD
				when ld1 =>
					present_state <= ld2;
				when ld2 =>
					present_state <= ld3;
				when ld3 =>
					present_state <= ld4;
				when ld4 =>
					present_state <= ld4wait;
				when ld4wait =>
					present_state <= ld5;
					--if ldi
				when ldi1 =>
					present_state <= ldi2;
				when ldi2 =>
					present_state <= ldi3;
					--if ldr
				when ldr1 =>
					present_state <= ldr2;
				when ldr2 =>
					present_state <= ldr3;
				when ldr3 =>
					present_state <= ldr3wait;
				when ldr3wait =>
					present_state <= ldr4;
					--if st
				when st1 =>
					present_state <= st2;
				when st2 =>
					present_state <= st3;
				when st3 =>
					present_state <= st4;
				when st4 =>
					present_state <= st5;
					--if str
				when str1 =>
					present_state <= str2;
				when str2 =>
					present_state <= str3;
				when str3 =>
					present_state <= str4;
					--if addi
				when addi1 =>
					present_state <= addi2;
				when addi2 =>
					present_state <= addi3;	
					--if ori
				when ori1 =>
					present_state <= ori2;
				when ori2 =>
					present_state <= ori3;
					--if andi
				when andi1 =>
					present_state <= andi2;
				when andi2 =>
					present_state <= andi3;
					--if branch
				when branch1 =>
					present_state <= branch2;
					--if jal
				when jal1 =>
					present_state <= jal2;		
				when others =>
					present_state <= default;
			end case;
		end if;
	end process;
	
	process (present_state)
	begin
	--control signals asserted in each stage
		case present_state is 
			WHEN default =>
				-- initialize	the	signals
				Gra<= '0'; Grb<= '0'; Grc<= '0'; 
				Rout<= '0'; Rin<= '0'; BAout<= '0';
				PCout	<=	'0'; MDRout	<=	'0'; Cout <= '0'; inPortout <= '0';	
				ZHighout <= '0'; ZLowout	<= '0'; Highout <= '0'; Lowout <= '0';
				Zin	<=	'0'; ZHighin <= '0'; ZLowin	<= '0'; Highin <= '0'; Lowin	<= '0';
				MARin <=	'0';  PCin <= '0'; outPortin <= '0'; 
				Cin	<= '0';  MDRin	<=	'0'; IRin <= '0'; Yin <=	'0';		
				Data_Read	<=	'0'; Data_Write<=	'0';
			--Instr. Fetch
			WHEN	fetch0	=>
				MDRout <= '0';	Gra <= '0'; Rin <= '0';
				PCout <=	'1'; MARin <=	'1'; OP <= "01101"; Zlowin	<=	'1';
			WHEN	fetch1 =>
			   PCout <=	'0'; MARin <=	'0'; Zlowin	<=	'0'; OP <= "00000";
				Zlowout	<=	'1'; PCin	<=	'1'; Data_Read	<=	'1'; 
			WHEN fetchwait =>
				MDRin	<=	'1';
			WHEN	fetch2 => 
			   Zlowout	<=	'0'; PCin	<=	'0'; Data_Read	<=	'0'; MDRin	<=	'0';
				MDRout <= '1'; IRin <= '1'; 
			When fetchwait2 =>
				
				
			--ADD
			WHEN	add1 => 
				PCout <=	'0'; MARin <=	'0'; OP <= "00000"; Zlowin	<=	'0';
			   MDRout <= '0'; IRin <= '0'; 
				Grb <=	'1'; Rout <= '1'; Yin	<=	'1';  
			WHEN	add2 => 
			   Grb <=	'0'; Rout <= '0'; Yin	<=	'0'; 
				Cout <=	'1'; OP <= IR(31 downto 27); Zlowin	<=	'1'; 
			WHEN	add3	=> 
				OP <= "00000";
			   Cout <=	'0'; Zlowin	<=	'0';
				Zlowout <= '1'; Rin	<=	'1';
				
			--SUB
			WHEN	sub1 => 
			   MDRout <= '0'; IRin <= '0'; 
				Grb <=	'1'; Rout <= '1'; Yin	<=	'1';  
			WHEN	sub2 => 
			   Grb <=	'0'; Rout <= '0'; Yin	<=	'0'; 
				Cout <=	'1'; OP <= IR(31 downto 27); Zlowin	<=	'1'; 
			WHEN	sub3	=> 
				OP <= "00000";
			   Cout <=	'0'; Zlowin	<=	'0';
				Zlowout <= '1'; Rin	<=	'1';
				
			--AND
			WHEN	and1 => 
			   MDRout <= '0'; IRin <= '0'; 
				Grb <=	'1'; Rout <= '1'; Yin	<=	'1';  
			WHEN	and2 => 
			   Grb <=	'0'; Rout <= '0'; Yin	<=	'0'; 
				Cout <=	'1'; OP <= IR(31 downto 27); Zlowin	<=	'1'; 
			WHEN	and3	=> 
				OP <= "00000";
			   Cout <=	'0'; Zlowin	<=	'0';
				Zlowout <= '1'; Rin	<=	'1';	
				
			--OR
			WHEN	or1 => 
			   MDRout <= '0'; IRin <= '0'; 
				Grb <=	'1'; Rout <= '1'; Yin	<=	'1';  
			WHEN	or2 => 
			   Grb <=	'0'; Rout <= '0'; Yin	<=	'0'; 
				Cout <=	'1'; OP <= IR(31 downto 27); Zlowin	<=	'1'; 
			WHEN	or3	=> 
				OP <= "00000";
			   Cout <=	'0'; Zlowin	<=	'0';
				Zlowout <= '1'; Rin	<=	'1';
				
			--DIV
			WHEN	div1 => 
			   MDRout <= '0'; IRin <= '0'; 
				Grb <=	'1'; Rout <= '1'; Yin	<=	'1';  
			WHEN	div2 => 
			   Grb <=	'0'; Rout <= '0'; Yin	<=	'0'; 
				Cout <=	'1'; OP <= IR(31 downto 27); Zlowin	<=	'1'; Zhighin <= '1';
			WHEN	div3	=> 
				OP <= "00000";
			   Cout <=	'0'; Zlowin	<=	'0'; Zhighin <= '0';
				Zlowout <= '1'; Lowin	<=	'1';	
			WHEN div4 =>
				Zlowout <= '0'; Lowin	<=	'0';	
				ZHighout <= '1'; Highin <= '1';
				
			--BOOTH
			WHEN	booth1 =>
				ZHighout <= '0'; Highin <= '0';
			   MDRout <= '0'; IRin <= '0'; 
				Grb <=	'1'; Rout <= '1'; Yin	<=	'1';  
			WHEN	booth2 => 
			   Grb <=	'0'; Rout <= '0'; Yin	<=	'0'; 
				Cout <=	'1'; OP <= IR(31 downto 27); Zlowin	<=	'1'; Zhighin <= '1';
			WHEN	booth3	=> 
				OP <= "00000";
			   Cout <=	'0'; Zlowin	<=	'0'; Zhighin <= '0';
				Zlowout <= '1'; Lowin	<=	'1';
			WHEN booth4 =>
				Zlowout <= '0'; Lowin	<=	'0';	
				ZHighout <= '1'; Highin <= '1';
				
			--NOT
			WHEN	not1 => 
				ZHighout <= '0'; Highin <= '0';
			   MDRout <= '0'; IRin <= '0'; 
				Grb <=	'1'; Rout <= '1'; Yin	<=	'1';  
			WHEN	not2 => 
			   Grb <=	'0'; Rout <= '0'; Yin	<=	'0'; 
				Cout <=	'1'; OP <= IR(31 downto 27); Zlowin	<=	'1'; 
			WHEN	not3	=> 
				OP <= "00000";
			   Cout <=	'0'; Zlowin	<=	'0';
				Zlowout <= '1'; Rin	<=	'1';	
				
			--NEG
			WHEN	neg1 => 
			   MDRout <= '0'; IRin <= '0'; 
				Grb <=	'1'; Rout <= '1'; Yin	<=	'1';  
			WHEN	neg2 => 
			   Grb <=	'0'; Rout <= '0'; Yin	<=	'0'; 
				Cout <=	'1'; OP <= IR(31 downto 27); Zlowin	<=	'1'; 
			WHEN	neg3	=> 
				OP <= "00000";
			   Cout <=	'0'; Zlowin	<=	'0';
				Zlowout <= '1'; Rin	<=	'1';
				
			--SHL
			WHEN	shl1 => 
			   MDRout <= '0'; IRin <= '0'; 
				Grb <=	'1'; Rout <= '1'; Yin	<=	'1';  
			WHEN	shl2 => 
			   Grb <=	'0'; Rout <= '0'; Yin	<=	'0'; 
				Cout <=	'1'; OP <= IR(31 downto 27); Zlowin	<=	'1'; 
			WHEN	shl3	=> 
				OP <= "00000";
			   Cout <=	'0'; Zlowin	<=	'0';
				Zlowout <= '1'; Rin	<=	'1';	
				
			--SHR
			WHEN	shr1 => 
			   MDRout <= '0'; IRin <= '0'; 
				Grb <=	'1'; Rout <= '1'; Yin	<=	'1';  
			WHEN	shr2 => 
			   Grb <=	'0'; Rout <= '0'; Yin	<=	'0'; 
				Cout <=	'1'; OP <= IR(31 downto 27); Zlowin	<=	'1'; 
			WHEN	shr3	=> 
				OP <= "00000";
			   Cout <=	'0'; Zlowin	<=	'0';
				Zlowout <= '1'; Rin	<=	'1';
				
			--ROL
			WHEN	rol1 => 
			   MDRout <= '0'; IRin <= '0'; 
				Grb <=	'1'; Rout <= '1'; Yin	<=	'1';  
			WHEN	rol2 => 
			   Grb <=	'0'; Rout <= '0'; Yin	<=	'0'; 
				Cout <=	'1'; OP <= IR(31 downto 27); Zlowin	<=	'1'; 
			WHEN	rol3	=> 
				OP <= "00000";
			   Cout <=	'0'; Zlowin	<=	'0';
				Zlowout <= '1'; Rin	<=	'1';	
				
			--ROR
			WHEN	ror1 => 
			   MDRout <= '0'; IRin <= '0'; 
				Grb <=	'1'; Rout <= '1'; Yin	<=	'1';  
			WHEN	ror2 => 
			   Grb <=	'0'; Rout <= '0'; Yin	<=	'0'; 
				Cout <=	'1'; OP <= IR(31 downto 27); Zlowin	<=	'1'; 
			WHEN	ror3	=> 
				OP <= "00000";
			   Cout <=	'0'; Zlowin	<=	'0';
				Zlowout <= '1'; Rin	<=	'1';
				
			--ld
			WHEN	ld1 => 
			   MDRout <= '0'; IRin <= '0'; 
				Grb <= '1'; BAout <=	'1'; Yin	<=	'1';  
			WHEN	ld2 => 
			   Grb <= '0'; BAout <=	'0'; Yin	<=	'0';  
				Cout <=	'1'; OP <= "00001"; Zlowin	<=	'1'; 
			WHEN	ld3	=> 
			   Cout <=	'0'; Zlowin	<=	'0'; 
				Zlowout <= '1'; MARin	<=	'1';
				OP <= "00000";
			WHEN 	ld4 =>
				Zlowout <= '0'; MARin	<= '0';
				Data_Read <= '1'; 
			WHEN ld4wait =>
				MDRin	<=	'1';
			WHEN 	ld5 =>
				Data_Read <= '0'; MDRin <= '0';
				MDRout <= '1';	Gra <= '1'; Rin <= '1';
				
			--ldi
			WHEN	ldi1 => 
			   MDRout <= '0'; IRin <= '0'; 
				Grb <= '1'; BAout <=	'1'; Yin	<=	'1';  
			WHEN	ldi2 => 
			   Grb <= '0'; Yin	<=	'0'; BAout <=	'0';  
				Cout <=	'1'; OP <= "00001"; Zlowin	<=	'1'; 
			WHEN 	ldi3 =>
				Cout <=	'0'; OP <= "00000"; Zlowin	<=	'0'; 
				Zlowout <= '1'; Gra <= '1'; Rin <= '1'; Highin <= '1';

			--ldr
			WHEN	ldr1 => 
			   MDRout <= '0'; IRin <= '0';   
				Cout <=	'1'; OP <= "00001"; Zlowin	<=	'1'; 
			WHEN	ldr2	=> 
			   Cout <=	'0'; Zlowin	<=	'0'; 
				Zlowout <= '1'; MARin	<=	'1';
				OP <= "00000";
			WHEN 	ldr3 =>
				Zlowout <= '0'; MARin	<= '0';
				Data_Read <= '1'; 
			WHEN ldr3wait =>
				MDRin	<=	'1';
			WHEN 	ldr4 =>
				Data_Read <= '0'; MDRin <= '0';
				MDRout <= '1';	Gra <= '1'; Rin <= '1';
				
			--st
			WHEN	st1 => 
			   MDRout <= '0'; IRin <= '0'; 
				Grb <= '1'; BAout <=	'1'; Yin	<=	'1';  
			WHEN	st2 => 
			   Grb <= '0'; BAout <=	'0'; Yin	<=	'0';  
				Cout <=	'1'; OP <= "00001"; Zlowin	<=	'1'; 
			WHEN	st3	=> 
			   Cout <=	'0'; Zlowin	<=	'0'; 
				Zlowout <= '1'; MARin	<=	'1';
				OP <= "00000";
			WHEN 	st4 =>
				Zlowout <= '0'; MARin	<= '0';
				Rout <= '1'; Gra <= '1'; MDRin <= '1';
			WHEN  st5 =>
				Rout <= '0'; Gra <= '0'; MDRin <= '0';
				Data_Write <= '1';
				
			--str
			WHEN	str1 => 
			   MDRout <= '0'; IRin <= '0';   
				--OP code determined by control unit later
				Cout <=	'1'; OP <= "00001"; Zlowin	<=	'1'; 
			WHEN	str2	=> 
			   Cout <=	'0'; Zlowin	<=	'0'; 
				Zlowout <= '1'; MARin	<=	'1';
				OP <= "00000";
			WHEN 	str3 =>
				Zlowout <= '0'; MARin	<= '0';
				Rout <= '1'; Gra <= '1'; MDRin <= '1';
			WHEN  str4 =>
				Rout <= '0'; Gra <= '0'; MDRin <= '0';
				Data_Write <= '1';
				
			--addi
			WHEN	addi1 => 
			   MDRout <= '0'; IRin <= '0'; 
				Grb <=	'1'; Rout <= '1'; Yin	<=	'1';  
			WHEN	addi2 => 
			   Grb <=	'0'; Rout <= '0'; Yin	<=	'0'; 
				Cout <=	'1'; OP <= "00001"; Zlowin	<=	'1'; 
			WHEN	addi3	=> 
				OP <= "00000";
			   Cout <=	'0'; Zlowin	<=	'0';
				Zlowout <= '1'; Rin	<=	'1';
				
			--andi
			WHEN	andi1 => 
			   MDRout <= '0'; IRin <= '0'; 
				Grb <=	'1'; Rout <= '1'; Yin	<=	'1';  
			WHEN	andi2 => 
			   Grb <=	'0'; Rout <= '0'; Yin	<=	'0'; 
				Cout <=	'1'; OP <= "00001"; Zlowin	<=	'1'; 
			WHEN	andi3	=> 
				OP <= "00000";
			   Cout <=	'0'; Zlowin	<=	'0';
				Zlowout <= '1'; Rin	<=	'1';	
				
			--ori
			WHEN	ori1 => 
			   MDRout <= '0'; IRin <= '0'; 
				Grb <=	'1'; Rout <= '1'; Yin	<=	'1';  
			WHEN	ori2 => 
			   Grb <=	'0'; Rout <= '0'; Yin	<=	'0'; 
				Cout <=	'1'; OP <= "00001"; Zlowin	<=	'1'; 
			WHEN	ori3	=> 
				OP <= "00000";
			   Cout <=	'0'; Zlowin	<=	'0';
				Zlowout <= '1'; Rin	<=	'1';
				
			--branch
			WHEN	branch1 => --decode instruction
			   MDRout <= '0'; IRin <= '0'; 
				Gra <=	'1'; Rout <= '1'; CONin	<=	'1';  
			WHEN	branch2 => --decode / execute instruction
			   Gra <=	'0'; Rout <= '0'; CONin	<=	'0'; 
				Grb <=	'1'; Rout <= '1'; 
				if ConFF = '1' then PCin <= '1';
				else PCin <= '0'; end if;
				
			--jump
			WHEN	jump1 => --decode instruction
			   MDRout <= '0'; IRin <= '0'; 
				Gra <=	'1'; Rout <= '1'; PCin	<=	'1';  
				
			--jal
			WHEN	jal1 => --decode instruction
				MDRout <= '0'; IRin <= '0';
				Grb <=	'1'; Rin <= '1'; PCout <=	'1';
			WHEN	jal2 => 
			   Grb <=	'0'; Rin <= '0'; PCout <=	'0';
				Gra <=	'1'; Rout <= '1'; PCin	<=	'1';  
				
			--mfhi
			WHEN	mfhi1 => --decode instruction
			   MDRout <= '0'; IRin <= '0'; 
				Gra <=	'1'; Rin <= '1'; Highout	<=	'1';  
			
			--mflo
			WHEN	mflo1 => --decode instruction
			   MDRout <= '0'; IRin <= '0'; 
				Gra <=	'1'; Rin <= '1'; Lowout	<=	'1';    
				
			--in
			WHEN	in1 => --decode instruction
			   MDRout <= '0'; IRin <= '0'; 
				Gra <=	'1'; Rin <= '1'; InPortout	<=	'1';  
			
			--out
			WHEN	out1 => --decode instruction
			   MDRout <= '0'; IRin <= '0'; 
				Gra <=	'1'; Rout <= '1'; OutPortin <= '1'; 
			
			--No Op
			WHEN nop =>
				PCout <=	'1'; MARin <=	'1'; OP <= "01101"; Zlowin	<=	'1';
			--Halt
			WHEN halt =>
				
			
			WHEN others =>
		end Case;
	end process;		
end architecture;