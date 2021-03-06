library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity memory is
    
    port (
	   clk         : in   std_logic;
	   mema      : in  std_logic_vector(15 downto 0);
		--memb      : inout  std_logic_vector(7 downto 0);
      membr1      : out  std_logic_vector(7 downto 0);
		membr2      : out  std_logic_vector(7 downto 0);
		membw1      : in  std_logic_vector(7 downto 0);
		membw2      : in  std_logic_vector(7 downto 0);
	   wr         : in   std_logic
     );
		
  end entity ;


architecture behave of memory is
signal m12,m13,m14,m15,m18,m19,m20,m21:  std_logic_vector(7 downto 0):= (others => '0');
--signal m0 :std_logic_vector(7 downto 0) :=  "01010010"; --sw
--signal m1 :std_logic_vector(7 downto 0) :=  "10000011";--sw
--signal m2 :std_logic_vector(7 downto 0) :=  "00000000";--adc
--signal m3 :std_logic_vector(7 downto 0) :=  "01010010";--adc
signal m0 :std_logic_vector (7 downto 0) := "00100010";
signal m1:std_logic_vector (7 downto 0) :=  "10001000";

signal m2 :std_logic_vector(7 downto 0) :=  "00101111";
signal m3 :std_logic_vector(7 downto 0) :=  "01110001";

signal m4 :std_logic_vector (7 downto 0) := "00000000";
signal m5:std_logic_vector (7 downto 0) :=  "00000000";

signal m6 :std_logic_vector(7 downto 0) :=  "00000000";
signal m7 :std_logic_vector(7 downto 0) :=  "00000000";

signal m8 :std_logic_vector (7 downto 0) := "00000000";
signal m9:std_logic_vector (7 downto 0) :=  "00000000";

signal m10 :std_logic_vector(7 downto 0) :=  "00000000";
signal m11 :std_logic_vector(7 downto 0) :=  "00000000";

signal m16 :std_logic_vector(7 downto 0) :=  "00000000";
signal m17 :std_logic_vector(7 downto 0) :=  "00000000";

begin

membr1 <= m0 when mema = x"0000" and wr='0' else
		  m2 when mema = x"0001" and wr='0' else
		  m4 when mema = x"0002" and wr='0' else
		  m6 when mema = x"0003" and wr='0' else
		  m8 when mema = x"0004" and wr='0' else
		  m10 when mema = x"0005" and wr='0' else
		  m12 when mema = x"0006" and wr='0' else
		  m14 when mema = x"0007" and wr='0' else  	
		  m16 when mema = x"0008" and wr='0' else
		  m18 when mema = x"0009" and wr='0';

membr2 <= m1 when mema = x"0000" and wr='0' else
		  m3 when mema = x"0001" and wr='0' else
		  m5 when mema = x"0002" and wr='0' else
		  m7 when mema = x"0003" and wr='0' else
		  m9 when mema = x"0004" and wr='0' else
		  m11 when mema = x"0005" and wr='0' else
		  m13 when mema = x"0006" and wr='0' else
		  m15 when mema = x"0007" and wr='0' else  	
		  m17 when mema = x"0008" and wr='0' else
		  m19 when mema = x"0009" and wr='0';			  

 mem_access:process(wr,mema,clk)
 begin
 	--if(wr='0') then
		--case mema is
		--	when X"0000" =>  membr1 <= m0 ; membr2 <= m1;
		--	when X"0001" =>  membr1 <= m2 ; membr2 <= m3;
		--	when X"0002" =>  membr1 <= m4 ; membr2 <= m5;
		--	when X"0003" =>  membr1 <= m6 ; membr2 <= m7;
		--	when X"0004" =>  membr1 <= m8 ; membr2 <= m9;
		--	when X"0005" =>  membr1 <= m10 ; membr2 <= m11;
		--	when X"0006" =>  membr1 <= m12 ; membr2 <= m13;
		--   when X"0007" =>  membr1 <= m14 ; membr2 <= m15; 
		--   when X"0008" =>  membr1 <= m16 ; membr2 <= m17;
		--	when X"0009" =>  membr1 <= m18 ; membr2 <= m19;
		--	when others =>   membr1 <= x"00"; membr2 <= x"00";
		--end case;
	if rising_edge(clk) and wr='1'then 
		case mema is
			when x"0000" =>  m0 <= membw1; m1 <= membw2;
			when x"0001" =>  m2 <= membw1; m3 <= membw2; 
			when x"0002" =>  m4 <= membw1; m5 <= membw2;
			when x"0003" =>  m6 <= membw1; m7 <= membw2;
			when x"0004" =>  m8 <= membw1; m9 <= membw2;
			when x"0005" =>  m10 <= membw1; m11 <= membw2;
			when x"0006" =>  m12 <= membw1; m13 <= membw2;
			when x"0007" =>  m14 <= membw1; m15 <= membw2;
			when x"0008" =>  m16 <= membw1; m17 <= membw2;
			when x"0009" =>  m18 <= membw1; m19 <= membw2;
			when others =>   m20<= membw1; m21 <= membw2;
			
		end case;
	end if;
 end process mem_access;


end architecture behave;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_wrapper is

port (

	   clk        : in   std_logic;
       membr1      : out  std_logic_vector(7 downto 0);
		 membr2      : out  std_logic_vector(7 downto 0);
       pc         : in  std_logic_vector(15 downto 0);
       t1         : in  std_logic_vector(15 downto 0);
	   t2         : in  std_logic_vector(15 downto 0); 
	   state      : in   std_logic_vector(4 downto 0)
	
);

end entity memory_wrapper;


architecture behave of memory_wrapper is

   signal Y,wr : std_logic;
   signal X: std_logic_vector(1 downto 0);
   signal membw1,membw2: std_logic_vector(7 downto 0);
   signal mema: std_logic_vector(15 downto 0);

   component memory is
    
    port (
	   clk         : in   std_logic;
	   mema      : in  std_logic_vector(15 downto 0);
		--memb      : inout  std_logic_vector(7 downto 0);
      membr1      : out  std_logic_vector(7 downto 0);
		membr2      : out  std_logic_vector(7 downto 0);
		membw1      : in  std_logic_vector(7 downto 0);
		membw2      : in  std_logic_vector(7 downto 0);
	   wr         : in   std_logic
     );
		
  end component ;

begin

wr <= ((not state(4)) and (not state(3)) and state(2) and state(1) and state(0)) or
      ((not state(4)) and state(3) and state(2) and state(1) and (not state(0)));

X(0) <= ((not state(4)) and state(3) and (not state(2)) and (not state(1)) and (not state(0))) or
      ((not state(4)) and (not state(3)) and state(2) and state(1) and state(0));

X(1)	<= ((not state(4)) and state(3) and (not state(2)) and (not state(1)) and state(0)) or
      ((not state(4)) and state(3) and state(2) and state(1) and (not state(0)));

Y	<= (not state(4)) and state(3) and state(2) and state(1) and (not state(0)); 

 --membb:process(Y)
 --begin
	-- case Y is
	--	when '0' =>  membw1 <= t2(15 downto 8); membw2 <= t2(7 downto 0);
	--	when others =>  membw1 <= t1(15 downto 8); membw2 <= t1(7 downto 0);
	-- end case;
 --end process membb;

 membw1 <= t2(15 downto 8) when Y='0' else
 			t1(15 downto 8) when Y='1';

 membw2 <= t2(7 downto 0) when Y='0' else
 			t1(7 downto 0) when Y='1';			


 --memaa:process(X)
 --begin
	-- case X is
	--	when "00" =>  mema <= pc;
	--	when "01" =>  mema <= t1;
	--	when others =>  mema <= t2;
	-- end case;
 --end process memaa;

 mema <= pc when X="00" else
 			t1 when X="01" else
 			t2 when X="10" or X="11";


 mem_wrap: memory
    
    port map (
	   clk       => clk ,
	   mema      => mema,
      membr1     => membr1,
		membr2     => membr2,
	   membw1     => membw1,
		membw2     => membw2,
	   wr        => wr 
     );
		





end architecture behave;
