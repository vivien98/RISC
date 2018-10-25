  library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_wrapper is
    
    port (
	    state      : in  std_logic_vector(4 downto 0);
	    ir         : in  std_logic_vector(15 downto 0);
		pc         : in  std_logic_vector(15 downto 0);
		t1         : in  std_logic_vector(15 downto 0);
		t2         : in  std_logic_vector(15 downto 0);
		t3         : in  std_logic_vector(15 downto 0);
		se6_out    : in  std_logic_vector(15 downto 0);
		se9_out    : in  std_logic_vector(15 downto 0);
	   alu_out     : out  std_logic_vector(15 downto 0);
		carry       : out std_logic;
		zero        : out std_logic

     );
		
  end entity ;
  
  architecture behave of alu_wrapper is

  component alu is
  	port (xin,yin: in std_logic_vector(15 downto 0);m0,m1: in std_logic;zout: out std_logic_vector(15 downto 0);c,z : out std_logic);
  end component;

  signal carry_control,zero_control,carry1,zero1: std_logic;
  signal xin,yin: std_logic_vector(15 downto 0);
  signal o,A: std_logic_vector(1 downto 0);
  signal B: std_logic_vector(2 downto 0);
  begin

zero_control <= ((not state(4)) and (not state(2)) and (not state(1)) and (not state(0))) or 
		((not state(4)) and (not state(3)) and (not state(2)) and state(1) and state(0)) ;

A(1) <= (not state(3)) or (state(2) and state(0));
A(0) <= (not state(2)) and state(1);

B(0) <= (state(2)) or ((not state(4)) and (not state(1)));
B(1) <= ((not state(4)) and (not state(3))) and ((not state(4)) and (not state(1)));
B(2) <= (not state(2)) and state(3);

carry_control <= ((not ir(15)) and (not ir(14)) and (not ir(13))) and ((not state(4)) and (not state(3)) and (not state(2)) and state(1) and state(0));

o(1) <= ((not ir(15)) and (not ir(14)) and ir(13) and (not ir(12)));
o(0) <= (ir(15) and ir(14) and (not ir(13)) and (not ir(12))) or 
        ((not (ir(15) and ir(14) and (not ir(13)) and (not ir(12)))) and (not state(2)) and state(3));

xinn:process(A)
 begin
	 case A is
		when "00" =>  xin <= t2;
		when "01" =>  xin <= t3;
		when "10" =>  xin <= pc; 
		when others =>  xin <= t1;
	 end case;
 end process xinn;

 yinn:process(B)
 begin
	 case B is
		when "000" =>  yin <= se9_out;
		when "001" =>  yin <= se6_out;
		when "010" =>  yin <= t2; 
		when "011" =>  yin <= X"0001"; 
		when others =>  yin <= X"0001";
	 end case;
 end process yinn;

 carry11: process(carry_control)
 begin
 	if(carry_control='1') then
 		carry <= carry1;
 	end if;
 end process carry11;

 zero11: process(zero_control)
 begin
 	if(zero_control='1') then
 		zero <= zero1;
 	end if;
 end process zero11;
 
 

aluop: alu 
	port map
	(xin      =>   xin,           
	 yin      =>   yin,         
	 m0       =>  o(0)  ,            
	 m1       =>   o(1),     
	 zout     =>   alu_out,
	 c        => carry1,
	 z        =>  zero1  );

 
  end architecture behave;