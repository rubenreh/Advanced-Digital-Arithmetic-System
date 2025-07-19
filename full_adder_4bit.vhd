-- Authors : Group 2, Mihir Seth Ruben Rehal

library ieee;
use ieee.std_logic_1164.all;

entity full_adder_4bit is
port(
		input_a : in std_logic_vector (3 downto 0);
		input_b : in std_logic_vector (3 downto 0);
		carry_in : in std_logic; 
		full_carry_out : out std_logic;
		full_sum_out:	out std_logic_vector (3 downto 0)

--	half_carry, half_sum: out std_logic
);

end full_adder_4bit;

architecture full_adder_4bit_logic of full_adder_4bit is 


	component full_adder_1bit port(
		input_a, input_b,carry_in : in std_logic;
		full_carry_out, full_sum_out:	out std_logic
	);

	end component;
	signal internal_carry: std_logic_vector(2 downto 0);


begin 
	INST1: full_adder_1bit port map (input_a(0),input_b(0),carry_in, internal_carry(0), full_sum_out(0));
	INST2: full_adder_1bit port map (input_a(1),input_b(1),internal_carry(0), internal_carry(1), full_sum_out(1));
	INST3: full_adder_1bit port map (input_a(2),input_b(2),internal_carry(1), internal_carry(2), full_sum_out(2));
	INST4: full_adder_1bit port map (input_a(3),input_b(3),internal_carry(2), full_carry_out, full_sum_out(3));

			
			  
end full_adder_4bit_logic;


--
--    FA0: full_adder_1bit Port Map (a(0), b(0), cin, internal_carry(0), sum(0), open, open);
--    FA1: full_adder_1bit Port Map (a(1), b(1), internal_carry(0), internal_carry(1), sum(1), open, open);
--    FA2: full_adder_1bit Port Map (a(2), b(2), internal_carry(1), internal_carry(2), sum(2), open, open);
--    FA3: full_adder_1bit Port Map (a(3), b(3), internal_carry(2), cout, sum(3), open, open);
--end Behavioral;
