--initialize t3 with 111
   library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
 entity microprocessor is
    
    port (
		clk50		: in std_logic;
	   clk1     : in  std_logic;
	   rsto		: in std_logic;
		stateOut	: out std_logic_vector(4 downto 0);
		o1,o2,o3,o4,o5,o6,o7,o8 : out std_logic_vector(15 downto 0) 
		
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
    	clk,shift        : in   std_logic;
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
	   t3_out     : out  std_logic_vector(15 downto 0);
		rst			: in std_logic
     );
		
  end component ;

  component t4 is

	port(
		clk: in std_logic;
		pc: in std_logic_vector(15 downto 0);
		state: in std_logic_vector(4 downto 0);
		ir: in std_logic_vector(15 downto 0);
		t4_out: out std_logic_vector(15 downto 0)
		);
	end component;

  component pc is
    
    port (
		clk        : in   std_logic;
	   state     : in  std_logic_vector(4 downto 0);
	   alu_out      : in  std_logic_vector(15 downto 0);
	   t1      : in  std_logic_vector(15 downto 0);
	   pc_out     : out  std_logic_vector(15 downto 0);
		rst			: in std_logic
     );
		
  end component ;

  component ir is
    
    port (
	 clk        : in   std_logic;
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
		t4         : in  std_logic_vector(15 downto 0);
	   pc         : in  std_logic_vector(15 downto 0);
	   app7       : in  std_logic_vector(15 downto 0);
	   state      : in  std_logic_vector(4 downto 0);
       rf_d1      : out  std_logic_vector(15 downto 0);
	   rf_d2      : out  std_logic_vector(15 downto 0);
		R7		  : in std_logic_vector(15 downto 0)
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
		t4         : in  std_logic_vector(15 downto 0);
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
	port(clk,rst: in std_logic ;nextState : in std_logic_vector(4 downto 0);state : out std_logic_vector(4 downto 0));
end component;
--signals

signal pc_out,t1_out,t2_out,t3_out,t4_out,alu_out,ir_out,app7_out,se6_out,se9_out,rf_d1,rf_d2: std_logic_vector(15 downto 0);
signal membr1,membr2 : std_logic_vector(7 downto 0);
signal state,nextState: std_logic_vector(4 downto 0);
signal carry,zero,bit1,bit0,shift,clk,t31,rst: std_logic;

begin
rst <= rsto;
stateOut <= state;
o1 <= pc_out;
o2 <= rf_d1;
o3 <= rf_d2;
o4 <= t1_out;
o5 <= t2_out;
o6(7 downto 0) <= membr1;
o6(15 downto 8) <= membr2;
o7 <= ir_out;
o8(0) <= carry;
o8(1) <= zero;
o8(2) <= shift;


clk <= clk1 and (state(4) or state(3) or state(2) or state(1) or state(0));
t31 <= (not t3_out(2)) and (not t3_out(0)) and (not t3_out(1));

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
    	shift	=> shift,
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
	   t3_out     => t3_out,
		rst		=> rst
     );

  t44 : t4

  port map(
  	clk => clk,
  	pc => pc_out,
  	state => state,
  	ir => ir_out,
  	t4_out => t4_out
  	);  
		
 pcc: pc 
    
    port map (
		clk        => clk,
	   state       =>  state,
	   alu_out      => alu_out,
	   t1          =>  t1_out,
	   pc_out     =>  pc_out,
		rst 	=> rst
     );
		

  irr :ir 
    
    port map (
	 clk        => clk1,
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
		t4			=> t4_out,
	   pc        =>  pc_out,
	   app7      =>  app7_out,
	   state    =>  state,
       rf_d1      => rf_d1,
	   rf_d2     =>  rf_d2,
		R7 		=> pc_out
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
		t4 		  => t4_out,
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
 	rst		=> rst,
 	state       =>   state,
    nextState    =>  nextState
 );
		




end architecture behave;
