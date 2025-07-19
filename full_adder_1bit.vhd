-- Authors : Group 2, Mihir Seth Ruben Rehal

library ieee;
use ieee.std_logic_1164.all;

entity full_adder_1bit is
port(
	input_a, input_b,carry_in : in std_logic;
	full_carry_out, full_sum_out:	out std_logic
--	half_carry, half_sum: out std_logic
);

end full_adder_1bit;

-- Architecture defining the behavior of the 1-bit full adder
architecture full_adder_1bit_logic of full_adder_1bit is 

signal half_carry: std_logic;		-- Intermediate signal for half-carry calculation
signal half_sum: std_logic;		-- Intermediate signal for half-sum calculation

begin

	-- Calculation of half-carry and half-sum
	half_carry <= (input_a AND input_b);			-- Half-carry calculation: A AND B
	half_sum <= (input_a XOR input_b);				-- Half-sum calculation: A XOR B
	
	-- Calculation of full sum and carry-out
	full_sum_out <= (carry_in XOR half_sum);							-- Full sum calculation: Carry-in XOR half-sum
	full_carry_out <= (half_carry OR (carry_in AND half_sum));  -- Carry-out calculation

					 
				
			  
end full_adder_1bit_logic;


