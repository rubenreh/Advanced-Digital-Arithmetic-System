-- Authors : Group 2, Mihir Seth Ruben Rehal

library ieee;
use ieee.std_logic_1164.all;


entity two_bit_mux is 
port (

    -- Input representing a 7-bit hexadecimal value
	hex_input : in std_logic_vector(6 downto 0);
	
	-- Input representing a 7-bit binary value for addition
	adder_input : in std_logic_vector(6 downto 0);
	
	-- Input representing selection signal for multiplexer
	mux_select : in std_logic_vector(0 downto 0);
	
	-- Output representing the selected data
	mux_output : out std_logic_vector(6 downto 0)

	
);
end two_bit_mux;

architecture mux_logic of two_bit_mux is

begin

with mux_select select

-- Multiplexer output selection based on mux_select input

mux_output <= 

            -- Select adder_input when mux_select is '1'
				adder_input when "1",
				
				-- Select hex_input when mux_select is '0'
				hex_input   when "0";
end mux_logic;