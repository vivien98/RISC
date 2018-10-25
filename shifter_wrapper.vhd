  library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_wrapper is
    
    port (
       clk       : in std_logic;
	   state     : in  std_logic_vector(4 downto 0);
       ir        : in  std_logic_vector(15 downto 0);
	   shw_out     : out  std_logic

     );
		
  end entity ;
  
  architecture behave of shift_wrapper is

  component shifter is
	port(clk,shift,wr: in std_logic ;writeData : in std_logic_vector(7 downto 0);bit1: out std_logic);
end component;

  signal shift,wr: std_logic;

  begin

wr <= (not state(3)) and state(2) and state(1) and (not state(0)) ;
shift <= state(3) and state(2) and (not state(1)) and (not state(0)) ;

 shifting: shifter 
	port map
	(clk        =>   clk           ,
	 shift      =>   shift         ,
	 wr         =>   wr            , 
	 writeData  =>   ir(7 downto 0)     ,
	 bit1       =>   shw_out     );


 
  end architecture behave;