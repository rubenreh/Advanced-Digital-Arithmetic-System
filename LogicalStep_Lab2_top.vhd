-- Authors : Group 2, Mihir Seth Ruben Rehal

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LogicalStep_Lab2_top is port (
   clkin_50			: in	std_logic;							-- 50 MHz clock input
	pb_n				: in	std_logic_vector(3 downto 0);	-- push button inputs (active low)
 	sw   				: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds				: out std_logic_vector(7 downto 0); -- for displaying the switch content
   seg7_data 		: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char2  	: out	std_logic;				    		-- seg7 digit2 selector
	seg7_char1  	: out	std_logic				    		-- seg7 digit1 selector
	
); 
end LogicalStep_Lab2_top;

architecture SimpleCircuit of LogicalStep_Lab2_top is
--
-- Components Used ---
------------------------------------------------------------------- 
  component SevenSegment port (
   hex   		:  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
   sevenseg 	:  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
   ); 
   end component;
	
	component segment7_mux port(
	 clk         : in std_logic := '0';						-- clock imput
	 DIN2        : in std_logic_vector(6 downto 0);		-- data input for segment 2
	 DIN1        : in std_logic_vector(6 downto 0);		-- data input for segment 1
	 DOUT        : out std_logic_vector(6 downto 0);	-- output data for the display
	 DIG2        : out std_logic;								-- selector for segment 2
	 DIG1        : out std_logic								-- selector for segment 1
	 
    ); 
    end component;
	 
	 component Logic_Processor port(
	 	logic_in0, logic_in1 : in std_logic_vector(3 downto 0);										-- input for logic operation 0 and operation 1
		logic_select 								      : in std_logic_vector( 1 downto 0);			-- select line for logic operation
		logic_out                                : out std_logic_vector(3 downto 0)			-- output of the logic operation
	 
	 );
	 end component;
	 
	 component PB_Inverters port(
			pb_n : in std_logic_vector(3 downto 0);				-- inverted pushbutton inputs
			pb : out std_logic_vector(3 downto 0)					-- inverted pushbuttons
		);
	 end component;
	 
	 
	 
	 
	component two_bit_mux port (
		hex_input : in std_logic_vector(6 downto 0);				-- data input for the 2-bit multiplexer
		adder_input : in std_logic_vector(6 downto 0);			-- data input for the adder	
		mux_select : in std_logic_vector(0 downto 0);			-- select line for the multiplexer
		mux_output : out std_logic_vector(6 downto 0)			-- output of the multiplexer 

			
	);
	end component;


	 
	component full_adder_4bit port(
		input_a : in std_logic_vector (3 downto 0);				-- input A for the full adder
		input_b : in std_logic_vector (3 downto 0);				-- input B for the full adder
		carry_in : in std_logic; 										-- carry-in for the full adder
		full_sum_out:	out std_logic_vector (3 downto 0);		-- full adder sum output
		full_carry_out : out std_logic								-- full adder carry output
	);				

	end component;

	 
	
	
	
-- Create any signals, or temporary variables to be used
--
--  std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR
--
	signal hex_A	: std_logic_vector(3 downto 0);			-- signal for holding the lower of the switch input
	signal hex_B : std_logic_vector(3 downto 0);				-- signal for holding the upper of the switch input


	signal seg7_A : std_logic_vector(6 downto 0);			-- signal for the 7-segment display data for hex,A
	signal seg7_B : std_logic_vector(6 downto 0);			-- signal for the 7-segment display data for hex,B
	signal pb     : std_logic_vector(3 downto 0);			-- inverted pushbutton signals.
	
	signal sum_dig_1	: std_logic_vector(3 downto 0);		-- signal for the first digital of the sum
	signal sum_dig_2	: std_logic_vector(3 downto 0);		-- signal for the second digit of the sum
		
	signal hex_sum : std_logic_vector(3 downto 0);			-- signal for holding the sum of hex,A and hex,B
	signal signal_C : std_logic;									-- signal for the carry-out from the adder
	
	signal add1 : std_logic_Vector(6 downto 0);				-- signal for 7-segment display data for add1
	signal add2 : std_logic_vector(6 downto 0);				-- signal for 7-segment display data for add2
	
	signal num1 : std_logic_Vector(6 downto 0);				-- signal for holding the 7-segment display data for hex,A or add1
	signal num2 : std_logic_vector(6 downto 0);				-- signal for holding the 7-segment display data for hex,B or add2
	
	signal select1 : std_logic_Vector(6 downto 0);			-- signal for selecting the input for segment 1 of the 7-segment display
	signal select2 : std_logic_vector(6 downto 0);			-- signal for selecting the input for segment 2 of the 7-segment display
	
		
	
	
begin
  -- Splitting the switch input into two parts
	hex_A <= sw(3 downto 0);
	hex_B <= sw(7 downto 4);
	
	
	-- Performing addition of hex_A and hex_B
	INST6_4BIT_ADDER: full_adder_4bit port map(
		hex_A,
		hex_B,
		'0',
		hex_sum(3 downto 0),
		signal_C
	);
	
	-- Assigning carry-out as the most significant bit of the sum
	sum_dig_2 <= "000" & signal_C;
	
	-- Mapping switch inputs to 7-segment displays
	INST1: SevenSegment port map(hex_A, num1);
	INST2: SevenSegment port map(hex_B, num2);

   -- Inverting pushbutton signals
	INST4: PB_Inverters port map(pb_n, pb);
	
	-- Processing logic with inverted pushbuttons
	INST5: Logic_Processor port map(hex_B,hex_A,pb(1 downto 0), leds(3 downto 0));
	
	
	-- Mapping sum and carry-out to 7-segment displays
	INST7: SevenSegment port map(hex_sum, add1);
	
	-- Mapping the carry-out and concatenating zeros to ensure compatibility with 7-segment display
	INST8: SevenSegment port map("000" & signal_C, add2);
	
	-- Multiplexing between num1 and add1 based on the state of the third pushbutton
	INST9: two_bit_mux port map(num1, add1, pb(2 downto 2), select1);
	
	-- Multiplexing between num2 and add2 based on the state of the third pushbutton	
	INST10: two_bit_mux port map(num2, add2, pb(2 downto 2), select2);
	
	-- Multiplexing between the two sets of 7-segment data based on the state of the clock
	INST3: segment7_mux port map(clkin_50, select1, select2, seg7_data, seg7_char2, seg7_char1);



 
end SimpleCircuit;

