--initialize t3 with 111
   library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
 entity microprocessor is
    
    port (
	   clk1     : in  std_logic
     );
		
  end entity ;

 architecture behave of microprocessor is

 -- components

 component t1 is
    
    port (
	   clk        : in   std_logic;
	   state     : in  std_logic_vector(4 downto 0);
	   rf_d1      : in  std_logic_vector(15 downto 0);
	   membr1      : in  std_logic_vector(7 downto 0);
	   membr2      : in  std_logic_vector(7 downto 0);
	   alu_out     : in  std_logic_vector(15 downto 0);
	   t1_out     : out  std_logic_vector(15 downto 0)

     );
		
 end component ;
 component t2 is
    
    port (
    	clk        : in   std_logic;
	   state     : in  std_logic_vector(4 downto 0);
	   rf_d1      : in  std_logic_vector(15 downto 0);
	   rf_d2      : in  std_logic_vector(15 downto 0);
	   alu_out     : in  std_logic_vector(15 downto 0);
	   se6_out     : in  std_logic_vector(15 downto 0);
	   t2_out     : out  std_logic_vector(15 downto 0)

     );
		
  end component ;


  component t3 is
    
    port (
    	clk        : in   std_logic;
	   state     : in  std_logic_vector(4 downto 0);
	   alu_out     : in  std_logic_vector(15 downto 0);
	   t3_out     : out  std_logic_vector(15 downto 0)

     );
		
  end component ;

  component pc is
    
    port (
		clk        : in   std_logic;
	   state     : in  std_logic_vector(4 downto 0);
	   alu_out      : in  std_logic_vector(15 downto 0);
	   t2      : in  std_logic_vector(15 downto 0);
	   pc_out     : out  std_logic_vector(15 downto 0)

     );
		
  end component ;

  component ir is
    
    port (
	   state     : in  std_logic_vector(4 downto 0);
	   membr1     : in  std_logic_vector(7 downto 0);
		membr2     : in  std_logic_vector(7 downto 0);
	   ir_out     : out  std_logic_vector(15 downto 0)

     );
		
  end component ;

  component app7 is
    
    port (
	   ir_8      : in  std_logic_vector(8 downto 0);
	   app7_out      : out  std_logic_vector(15 downto 0)

     );
		
  end component ;

  component se9 is
    
    port (
	   ir_8      : in  std_logic_vector(8 downto 0);
	   se9_out      : out  std_logic_vector(15 downto 0)

     );
		
  end component ;

  component se6 is
    
    port (
	   ir_5      : in  std_logic_vector(5 downto 0);
	   se6_out      : out  std_logic_vector(15 downto 0)

     );
		
  end component ;

 component shift_wrapper is
    
    port (
       clk       : in std_logic;
     state     : in  std_logic_vector(4 downto 0);
       ir        : in  std_logic_vector(15 downto 0);
     shw_out     : out  std_logic

     );
    
 end component ;

 component reg_file_wrap is
    
    port (
	   clk        : in   std_logic;
	   rst        : in   std_logic;
		ir         : in  std_logic_vector(15 downto 0);
	   t1         : in  std_logic_vector(15 downto 0);
	   t3         : in  std_logic_vector(15 downto 0);
	   pc         : in  std_logic_vector(15 downto 0);
	   app7       : in  std_logic_vector(15 downto 0);
	   state      : in  std_logic_vector(4 downto 0);
       rf_d1      : out  std_logic_vector(15 downto 0);
	   rf_d2      : out  std_logic_vector(15 downto 0)

     );
		
  end component ;

component memory_wrapper is

port (

	   clk        : in   std_logic;
       membr1      : out  std_logic_vector(7 downto 0);
		 membr2      : out  std_logic_vector(7 downto 0);
       pc         : in  std_logic_vector(15 downto 0);
       t1         : in  std_logic_vector(15 downto 0);
	   t2         : in  std_logic_vector(15 downto 0); 
	   state      : in   std_logic_vector(4 downto 0)
	
);

end component;


  component alu_wrapper is
    
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
		
  end component ;

  component stateMachine is
	port(bit1,bit0,t3,shift,carry,zero: in std_logic;state: in std_logic_vector(4 downto 0);opcode: in std_logic_vector(3 downto 0);nextState: out std_logic_vector(4 downto 0));
end component;

component stateReg is
	port(clk: in std_logic ;nextState : in std_logic_vector(4 downto 0);state : out std_logic_vector(4 downto 0));
end component;
--signals

signal pc_out,t1_out,t2_out,t3_out,alu_out,ir_out,app7_out,se6_out,se9_out,rf_d1,rf_d2: std_logic_vector(15 downto 0);
signal membr1,membr2 : std_logic_vector(7 downto 0);
signal state,nextState: std_logic_vector(4 downto 0);
signal carry,zero,bit1,bit0,shift,rst,clk,t31: std_logic;

begin

clk <= clk1 and (state(4) or state(3) or state(2) or state(1) or state(0));
t31 <= t3_out(2) and t3_out(0) and t3_out(1);
 t11 :t1 
    
    port map (
	   clk        => clk,
	   state     =>  state,
	   rf_d1      => rf_d1,
	   membr1     => membr1,
	   membr2     => membr2,
	   alu_out    => alu_out,
	   t1_out     => t1_out

     );
		

 t22 :t2 
    
    port map (
    	clk       => clk,
	   state    =>  state,
	   rf_d1      =>  rf_d1,
	   rf_d2      =>  rf_d2,
	   alu_out    =>  alu_out,
	   se6_out     => se6_out,
	   t2_out     => t2_out

     );
		

  t33 :t3 
    
    port map (
    	clk       =>  clk,
	   state    =>  state,
	   alu_out    =>  alu_out,
	   t3_out     => t3_out

     );
		
 pcc: pc 
    
    port map (
		clk        => clk,
	   state       =>  state,
	   alu_out      => alu_out,
	   t2          =>  t2_out,
	   pc_out     =>  pc_out

     );
		

  irr :ir 
    
    port map (
	   state    =>  state,
	   membr1    => membr1,
		membr2   => membr2,
	   ir_out    => ir_out

     );
		

  appp7 :app7 
    
    port  map(
	   ir_8      => ir_out(8 downto 0),
	   app7_out   =>   app7_out

     );
		

  see9 :se9 
    
    port map (
	   ir_8        =>  ir_out(8 downto 0),
	   se9_out     => se9_out

     );
		

  see6 :se6 
    
    port map (
	   ir_5        => ir_out(5 downto 0),
	   se6_out     => se6_out

     );
		

 shifter :shift_wrapper 
    
    port map (
       clk      =>  clk,
     state      =>  state,
       ir       =>  ir_out,
     shw_out    =>  shift

     );
    

 all_reg: reg_file_wrap
    
    port map (
	   clk        => clk,
	   rst        => rst,
		ir        => ir_out,
	   t1        =>  t1_out,
	   t3        =>  t3_out,
	   pc        =>  pc_out,
	   app7      =>  app7_out,
	   state    =>  state,
       rf_d1      => rf_d1,
	   rf_d2     =>  rf_d2

     );
		

memoryy: memory_wrapper 

port map (

	   clk        => clk,
       membr1     => membr1,
		 membr2   => membr2,
       pc         => pc_out,
       t1         => t1_out,
	   t2         => t2_out,
	   state      => state
	
);   
    
  alu_wrp: alu_wrapper
    port map (
	    state     => state,
	    ir        => ir_out,
		pc        => pc_out,
		t1        => t1_out,
		t2        => t2_out,
		t3        => t3_out,
		se6_out   => se6_out,
		se9_out   => se9_out,
	   alu_out    => alu_out,
		carry     => carry,
		zero      => zero

     );

 state_mach:stateMachine 
	port map(

    bit1         =>  ir_out(1),                
    bit0         =>  ir_out(0),        
    t3          =>   t31,
    shift       =>   shift,
    carry       =>   carry,
    zero        =>   zero,
    state       =>   state,
    opcode       =>  ir_out(15 downto 12),
    nextState    =>  nextState
);

 state_reg: stateReg
 port map (
 	clk       =>  clk1,
 	state       =>   state,
    nextState    =>  nextState
 );
		




end architecture behave;