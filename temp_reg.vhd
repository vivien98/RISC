library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity t1 is
    
    port (
	   clk        : in   std_logic;
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

t1out:process(clk,t1_control,alu_out,rf_d1,membw2,membw1)
 begin
 if rising_edge(clk) then
	 case t1_control is
		when "00" =>  t1_out1 <= rf_d1;
		when "01" =>  t1_out1 <= alu_out;
		when "10" =>  t1_out1(15 downto 8) <= membw1; t1_out1(7 downto 0) <= membw2;
		when others =>  t1_out1 <= t1_out1;
	 end case;
 end if;
 end process t1out;
 
  end architecture behave;
  
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
  
  
  entity t2 is
    
    port (
    	clk        : in   std_logic;
	   state     : in  std_logic_vector(4 downto 0);
	   rf_d1      : in  std_logic_vector(15 downto 0);
	   rf_d2      : in  std_logic_vector(15 downto 0);
	   alu_out     : in  std_logic_vector(15 downto 0);
	   se6_out     : in  std_logic_vector(15 downto 0);
	   t2_out     : out  std_logic_vector(15 downto 0)

     );
		
  end entity ;
  
  architecture behave of t2 is

  signal t2_control: std_logic_vector(2 downto 0);
  signal t2_out1: std_logic_vector(15 downto 0);

  begin

  t2_control(0) <= ((not state(2))) or (state(0) and state(1)) or 
                    (state(0) and state(3)) or (state(3) and state(1)) or ((not state(1)) and (not state(3)) and (not state(0)));
			  
  t2_control(1) <= (state(3)) or (state(4)) or 
                   ((not state(1)) and (not state(2))) or ((not state(1)) and (not state(0))) or (state(0) and state(1));
						 
  t2_control(2) <= (state(0)) or (state(4)) or 
                   ((not state(1)) and (not state(3))) or ((not state(1)) and (not state(2))) or (state(3) and state(1));
  
t2_out <= t2_out1;
t2out:process(clk,t2_control,alu_out,rf_d1,rf_d2,se6_out)
 begin
 if rising_edge(clk) then
	 case t2_control is
		when "000" =>  t2_out1 <= rf_d1;
		when "001" =>  t2_out1 <= rf_d2;
		when "010" =>  t2_out1 <= alu_out;
		when "011" =>  t2_out1 <= se6_out;
		when others =>  t2_out1 <= t2_out1;
	 end case;
end if;
 end process t2out;
 
  end architecture behave;
  
  
  library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity t3 is
    
    port (
    	clk        : in   std_logic;
	   state     : in  std_logic_vector(4 downto 0);
	   alu_out     : in  std_logic_vector(15 downto 0);
	   t3_out     : out  std_logic_vector(15 downto 0)

     );
		
  end entity ;
  
  architecture behave of t3 is

  signal t3_control: std_logic;
  signal t3_out1: std_logic_vector(15 downto 0);

  begin

t3_control <= state(3) and (not state(2)) and state(1) ;
t3_out <= t3_out1;

t3out:process(clk,t3_control,alu_out)
 begin
 if rising_edge(clk) then
	 case t3_control is
		when '1' =>  t3_out1 <= alu_out;
		when others =>  t3_out1 <= t3_out1;
	 end case;
end if;
 end process t3out;
 
  end architecture behave;
  
  
  
  
  
  
  
  
  
  
  
  