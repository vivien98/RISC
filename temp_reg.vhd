library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity t1 is
    
    port (
	   state     : in  std_logic_vector(4 downto 0);
	   alu_out      : in  std_logic_vector(15 downto 0);
	   t2      : in  std_logic_vector(15 downto 0);
	   t1_out     : out  std_logic_vector(15 downto 0)

     );
		
  end entity ;
  
  architecture behave of pc is

  signal pc_control: std_logic_vector(1 downto 0);
  signal pc_out1: std_logic_vector(15 downto 0);

  begin

  pc_control(0) <= ((not state(0)) and (not state(4))) or ((not state(3)) and (not state(4))) or 
           ((not state(3)) and state(2)) or ((not state(2)) and state(1)) or ((not state(1)) and state(4) and state(3));
			  
  pc_control(1) <= (not state(4)) or ((not state(1)) and state(3)) or ((not state(3)) and state(2)) or ((not state(2)) and state(1));
  
pc_out <= pc_out1;

pcout:process(pc_control,alu_out,t2)
 begin
	 case pc_control is
		when "00" =>  pc_out1 <= alu_out;
		when "01" =>  pc_out1 <= t2;
		when others =>  pc_out1 <= pc_out1;
	 end case;
 end process pcout;

  
  
  
  end architecture behave;
  
  
  