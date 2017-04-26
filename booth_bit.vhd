library ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.All;

entity booth_bit is
	port (
		multiplicand, multiplier : in STD_logic_vector (31 downto 0);
		result: out Std_logic_vector (63 downto 0);
		test: out Std_logic_vector (63 downto 0)
	);
	end entity;
	
architecture booth_bit_arch of booth_bit is
begin
	process(multiplicand, multiplier)
		variable mult, nmult : std_logic_vector (31 downto 0);
		variable mult2, nmult2 : std_logic_vector (32 downto 0);
		variable res : std_logic_vector (63 downto 0);
		variable bit_left, bit_right: std_logic;
		begin
			res (63 downto 32) := (others => '0');
			res (31 downto 0)  := multiplier;	--0001
			mult := multiplicand;	--0111
			nmult := (not multiplicand) + '1'; --1001
			mult2 (32 downto 1) := multiplicand; --1110
			mult2 (0) := '0';
			nmult2 (32 downto 1):=(not multiplicand) + '1'; -- 10010
			nmult2 (0) := '0';
			bit_right := '0';
			--bit_left := res (1);
			
			loop1: for i in 15 downto 0 loop
				--get second bit for bit pair
				bit_left := res (1);
				
				--net = 0
				if((res(0) = '0' and bit_right = '0' and bit_left = '0') OR
					(res(0) = '1' and bit_right = '1' and bit_left = '1')) then
					--Update bit to the right
					bit_right := res(1);
					--Shift result 2
					res(61 downto 0) := res(63 downto 2);
					
				--net = +1
				elsif((res(0) = '0' and bit_right = '1' and bit_left = '0') OR 
						(res(0) = '1' and bit_right = '0' and bit_left = '0')) then
					--Add multiplicand
					res(63 downto 32) := res(63 downto 32) + mult;	
					test <= res;
					--Update bit to the right
					bit_right := res(1);
					--Shift result 2
					res(61 downto 0) := res(63 downto 2);
					
				--net = -1
				elsif ((res(0) = '0' and bit_right = '1' and bit_left = '1') OR 
						 (res(0) = '1' and bit_right = '0' and bit_left = '1')) then
					--Add negative multiplicand
					res(63 downto 32) := res(63 downto 32) + nmult;					
					--Update bit to the right
					bit_right := res(1);
					--Shift result 2
					res(61 downto 0) := res(63 downto 2);
					
				--net = +2
				elsif (res(0) = '1' and bit_right = '1' and bit_left = '0')  then
					--Add 2x multiplicand
					res(63 downto 32) := res(63 downto 32) + mult2(31 downto 0);					
					--Update bit to the right
					bit_right := res(1);
					--Shift result 2
					res(61 downto 0) := res(63 downto 2);				

				--net = -2
				elsif (res(0) = '0' and bit_right = '0' and bit_left = '1')  then
					--Add 2x negative multiplicand
					res(63 downto 32) := res(63 downto 32) + nmult2(31 downto 0);					
					--Update bit to the right
					bit_right := res(1);
					--Shift result 2
					res(61 downto 0) := res(63 downto 2);					
				end if;
			end loop loop1;
			result <= res;
	end process;
end architecture;	
