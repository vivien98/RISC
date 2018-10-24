library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity se6 is
    
    port (
	   ir_5      : in  std_logic_vector(5 downto 0);
	   se6_out      : out  std_logic_vector(15 downto 0)

     );
		
  end entity ;
  
  architecture behave of se6 is
  begin
  
  se6_out(5 downto 0) <= ir_5;
  se6_out(15 downto 6) <= (others => '0');
  
  
  end architecture behave;
  
  
  