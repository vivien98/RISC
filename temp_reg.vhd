library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity t1 is
    
    port (
	   state     : in  std_logic_vector(4 downto 0);
	   rf_d1      : in  std_logic_vector(15 downto 0);
	   membw1      : in  std_logic_vector(7 downto 0);
	   membw2      : in  std_logic_vector(7 downto 0);
	   alu_out     : in  std_logic_vector(15 downto 0);
	   t1_out     : out  std_logic_vector(15 downto 0)

     );
		
  end entity ;
  
  architecture behave of t1 is

  signal t1_control: std_logic_vector(1 downto 0);
  signal t1_out1: std_logic_vector(15 downto 0);

  begin

  t1_control(0) <= (state(4)) or (state(0) and state(1)) or 
           ((not state(0)) and state(2)) or (state(3) and state(1)) or ((not state(2)) and (not state(3)) and state(0));
			  
  t1_control(1) <= (state(4)) or ((not state(1)) or (not state(2))) or 
                   ((not state(1)) and (not state(0))) or (state(2) and state(1)) or ((not state(2)) and state(3));
  
t1_out <= t1_out1;

t1out:process(t1_control,alu_out,rf_d1,membw2,membw1)
 begin
	 case t1_control is
		when "00" =>  t1_out1 <= rf_d1;
		when "01" =>  t1_out1 <= alu_out;
		when "10" =>  t1_out1(15 downto 8) <= membw1; t1_out1(7 downto 0) <= membw2;
		when others =>  t1_out1 <= t1_out1;
	 end case;
 end process t1out;
 
  end architecture behave;
  
  
  
  
  
  