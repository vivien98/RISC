--initialize t3 with 111
 entity microprocessor is
    
    port (
	   clk     : in  std_logic;
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


--signals

signal pc_out,t1_out,t2_out,t3_out,alu_out,ir_out,app7_out,se6_out,se9_out,rf_d1,rf_d2: std_logic_vector(15 downto 0);
signal membr1,membr2 : std_logic_vector(7 downto 0);
signal state: std_logic_vector(4 downto 0);
signal carry,zero,bit1: std_logic;

begin
 
 t11 :t1 
    
    port map (
	   clk        => clk,
	   state     =>  state,
	   rf_d1      => rf_d1,
	   membw1     => 
	   membw2     =>
	   alu_out    => 
	   t1_out     =>

     );
		

 t22 :t2 
    
    port map (
    	clk       => clk,
	   state    =>
	   rf_d1      =>
	   rf_d2      =>
	   alu_out    => 
	   se6_out     =>
	   t2_out     =>

     );
		

  t33 :t3 
    
    port map (
    	clk       =>  clk,
	   state    =>
	   alu_out    => 
	   t3_out     =>

     );
		
 pcc: pc 
    
    port map (
		clk        => clk,
	   state    =>
	   alu_out      =>
	   t2      =>
	   pc_out     =>

     );
		

  irr :ir 
    
    port map (
	   state    =>
	   membw1    =>
		membw2   => 
	   ir_out    => 

     );
		

  appp7 :app7 
    
    port  map(
	   ir_8      =>
	   app7_out   =>   

     );
		

  see9 :se9 
    
    port map (
	   ir_8     =>
	   se9_out     => 

     );
		

  see6 :se6 
    
    port map (
	   ir_5    =>
	   se6_out     =>

     );
		

 shifter :shift_wrapper 
    
    port map (
       clk     =>  clk,
     state    =>
       ir       => 
     shw_out    => 

     );
    

 all_reg :reg_file 
    
    port map (
	   clk        =>  clk,
	   rst        =>
	   wr         =>
	   rf_a1    =>
	   rf_a2    =>
	   rf_a3    =>
	   rf_d1      =>
	   rf_d2      =>
	   rf_d3    =>

     );
		

  memoryy :memory 
    
    port map (
	   clk         =>  clk,
	   mema     =>
		--memb      : inout  std_logic_vector(7 downto 0);
      membr1     =>
		membr2     =>
		membw1    =>
		membw2    =>
	    wr   =>
	    );    
    
  alu_wrp: alu_wrapper
    port map (
	    state    =>
	    ir        =>
		pc        =>
		t1        =>
		t2        =>
		t3        =>
		se6_out   =>
		se9_out   =>
	   alu_out     =>
		carry      =>
		zero      =>

     );
		




end architecture behave;