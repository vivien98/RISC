  library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ir is
    
    port (
	   state     : in  std_logic_vector(4 downto 0);
	   membw1     : in  std_logic_vector(7 downto 0);
		membw2     : in  std_logic_vector(7 downto 0);
	   ir_out     : out  std_logic_vector(15 downto 0)

     );
		
  end entity ;
  
  architecture behave of ir is

  signal ir_control: std_logic;
  signal ir_out1: std_logic_vector(15 downto 0);

  begin

ir_control <= (not state(4)) and (not state(3)) and (not state(2)) and (not state(1)) ;
ir_out <= ir_out1;

irout:process(ir_control)
 begin
	 case ir_control is
		when '1' =>  ir_out1(15 downto 8) <= membw1; ir_out1(7 downto 0) <= membw2;
		when others =>  ir_out1 <= ir_out1;
	 end case;
 end process irout;
 
  end architecture behave;