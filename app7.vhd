library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity app7 is
    
    port (
	   ir_8      : in  std_logic_vector(8 downto 0);
	   app7_out      : out  std_logic_vector(15 downto 0)

     );
		
  end entity ;
  
  architecture behave of app7 is
  begin
  
  app7_out(6 downto 0) <= (others => '0');
  app7_out(15 downto 7) <= ir_8;
  
  
  end architecture behave;
  
  
  