-- Authors : Group 2, Mihir Seth Ruben Rehal

library ieee;
use ieee.std_logic_1164.all;

-- Entity declaration for the hex multiplexer
entity hex_mux is

port(
	
	--Input ports representing four 4-bit hexadecimal numbers
	hex_num3, hex_num2, hex_num1, hex_num0 : in std_logic_vector(3 downto 0);
	
	--Input port representing the select signal for multiplexing
	mux_select 								      : in std_logic_vector( 1 downto 0);
	
	-- Output port representing the selected 4-bit hexadecimal number
	hex_out                                : out std_logic_vector(3 downto 0)
);

end hex_mux;

-- architecture specifying the behaviour of the hex multiplexer

architecture mux_logic of hex_mux is 		

begin 

-- Process for selecting the appropriate input based on mux_select with mux_select(1 downto 0) select
with mux_select(1 downto 0) select

-- Assigning output based on the value of mux_select
hex_out <= hex_num0 when "00",
			  hex_num1 when "01",
			  hex_num2 when "10",
			  hex_num3 when "11";
			  
end mux_logic;