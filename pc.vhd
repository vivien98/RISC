library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is
    
    port (
		clk        : in   std_logic;
	   state     : in  std_logic_vector(4 downto 0);
	   alu_out      : in  std_logic_vector(15 downto 0);
	   --t2      : in  std_logic_vector(15 downto 0);
	   t1      : in  std_logic_vector(15 downto 0);
	   pc_out     : out  std_logic_vector(15 downto 0);
		rst		: in std_logic
     );
		
  end entity ;
  
  architecture behave of pc is

  signal pc_control: std_logic_vector(1 downto 0);
  signal pc_out1: std_logic_vector(15 downto 0) := X"0000";

  begin

  pc_control(0) <= ((not state(0)) and (not state(4))) or ((not state(1)) and (not state(0))) or 
           ((not state(1)) and state(2)) or ((not state(2)) and state(3)) or ((not state(3)) and state(1) and state(0));
			  
  pc_control(1) <= (not state(0)) or ((not state(3)) and state(1)) or ((not state(1)) and state(2)) or ((not state(2)) and state(3));
  
pc_out <= pc_out1;

pcout:process(rst,clk,pc_control)
 begin
 if rst = '1' then
 	pc_out1 <= x"0000";
 elsif rising_edge(clk) then
	 case pc_control is
		when "00" =>  pc_out1 <= alu_out;
		when "10" =>  pc_out1 <= t1;
		when others =>  pc_out1 <= pc_out1;
	 end case;
	end if;
 end process pcout;

  
  
  
  end architecture behave;
  
  
  
