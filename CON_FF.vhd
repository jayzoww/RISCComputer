LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;

entity CON_FF is
Port ( 
		IR, RegIn : in std_logic_vector (31 downto 0);
		CONin : in std_logic;
		CONout : out std_logic
		);
end entity;
Architecture CON_FF_arch of CON_FF is
SIGNAL Branch : std_logic_vector (1 downto 0);
SIGNAL BusRes : std_logic;
SIGNAL DecodeOut : std_logic_vector(3 downto 0);
begin

		BusRes <= nor_reduce (RegIn(31 downto 0));
		Branch <= IR(1 downto 0);

		DecodeOut <= "0001" when branch = "00" else
						 "0010" when branch = "01" else
						 "0100" when branch = "10" else
						 "1000" when branch = "11";
						 
		CONout <= (DecodeOut(0) AND BusRes) OR 
					(DecodeOut(1) AND NOT(BusRes)) OR 
					(DecodeOut(2) AND NOT(RegIn(31))) OR 
					(DecodeOut(3) AND RegIn(31)) 
					when CONin = '1' ;
--	process
--	begin
--		if CONin = '1' then
--				CONout <= (DecodeOut(0) AND BusRes) OR 
--							 (DecodeOut(1) AND NOT(BusRes)) OR 
--							 (DecodeOut(2) AND NOT(RegIn(31))) OR 
--							 (DecodeOut(3) AND RegIn(31));
--		end if;
--	end process;
end Architecture;