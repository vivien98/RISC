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
		t4         : in  std_logic_vector(15 downto 0);
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

  signal carry_control,zero_control,carry1,zero1,carry2,zero2,branch_opcode: std_logic;
  signal xin,yin: std_logic_vector(15 downto 0);
  signal o: std_logic_vector(1 downto 0);
  signal B,A: std_logic_vector(2 downto 0);
  begin

zero_control <= ((not state(4)) and (not state(2)) and (not state(1)) and (not state(0))) or 
		((not state(4)) and (not state(3)) and (not state(2)) and state(1) and state(0)) ;

A(1) <= not(branch_opcode) and ((not state(3)) or (state(2) and state(0)));
A(0) <= not(branch_opcode) and ((not state(2)) and state(1));
A(2) <= branch_opcode;

branch_opcode <= ir(15) and not(ir(13)) and not(ir(12)) and ((not(state(4)) and state(3) and state(2) and state(1) and state(0))
or (state(4) and not(state(3)) and not(state(2)) and not(state(1)) and state(0)));

B(0) <= (state(2)) or ((not state(4)) and (not state(1)));
B(1) <= ((not state(4)) and (not state(3))) or ((not state(4)) and (not state(1)));
B(2) <= (not state(2)) and state(3); 

carry_control <= ((not ir(15)) and (not ir(14)) and (not ir(13))) and ((not state(4)) and (not state(3)) and (not state(2)) and state(1) and state(0));

o(1) <= ((not ir(15)) and (not ir(14)) and ir(13) and (not ir(12)));
o(0) <= (ir(15) and ir(14) and (not ir(13)) and (not ir(12)) and not(state(4)) and not(state(3)) and not(state(2)) and state(1) and state(0)) or 
        ((not (ir(15) and ir(14) and (not ir(13)) and (not ir(12)))) and (not state(2)) and state(3));

 carry <= carry2;
 zero <= zero2;

--xinn:process(A,t1,t2,t3,pc)
-- begin
--	 case A is
--		when "00" =>  xin <= t2;
--		when "01" =>  xin <= t3;
--		when "10" =>  xin <= pc; 
--		when others =>  xin <= t1;
--	 end case;
-- end process xinn;
 
 xin <= t2 when a = "000" else 
     t3 when a = "001" else 
     pc when a = "010" else 
     t1 when a = "011"else
     t4 when a = "100";


-- yinn:process(B)
-- begin
--	 case B is
--		when "000" =>  yin <= se9_out;
--		when "001" =>  yin <= se6_out;
--		when "010" =>  yin <= t2; 
--		when "011" =>  yin <= X"0001"; 
--		when others =>  yin <= X"0001";
--	 end case;
-- end process yinn;

 yin <= se9_out when b = "000" else 
     se6_out when b = "001" else 
     t2 when b = "010" else 
     X"0001" when b = "011" else
	  X"0001" when b = "100" else
	  X"0000"  when b = "101" or b = "111" or b = "110";

 --carry11: process(carry_control)
 --begin
 --	if(carry_control='1') then
 --		carry <= carry1;
 --	end if;
 --end process carry11;

  carry2 <= (carry_control and carry1) or ((not carry_control) and carry2);



 --zero11: process(zero_control)
 --begin
 --	if(zero_control='1') then
 --		zero <= zero1;
 --	end if;
 --end process zero11;

 zero2 <= (zero_control and zero1) or ((not zero_control) and zero2);
 
 

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