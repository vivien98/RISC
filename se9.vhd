library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity se9 is
    
    port (
	   ir_8      : in  std_logic_vector(8 downto 0);
	   se9_out      : out  std_logic_vector(15 downto 0)

     );
		
  end entity ;
  
  architecture behave of se9 is
  begin
  
  se9_out(8 downto 0) <= ir_8;
  se9_out(15 downto 9) <= (others => '0');
  
  
  end architecture behave;
  
  
  