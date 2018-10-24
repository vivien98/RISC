library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity stateMachine is
	port(bit1,bit0,t3,shift,carry,zero: in std_logic;state: in std_logic_vector(4 downto 0);opcode: in std_logic_vector(3 downto 0);nextState: out std_logic_vector(4 downto 0));
end entity;
architecture kahipan of stateMachine is

begin
SM : process (state,bit1,bit0,t3,shift,carry,zero,opcode) begin
	case state is
		when "00001" =>
			if (opcode = "0000" or opcode = "0010") then
				nextState <= "00010";
			elsif (opcode = "0101" or opcode = "0001" or opcode = "0100") then
				nextState <= "00101";
			elsif (opcode = "0011") then
				nextState <= "10011";
			elsif (opcode = "0110" or opcode = "0111") then
				nextState <= "00110";
			elsif (opcode = "1000" or opcode = "1001") then
				nextState <= "01000";
			end if;
		when "00010" =>
			if (opcode = "0000" or opcode = "0010") then
				if ((bit1 = '1' and bit0 = '0' and carry = '0')or(bit1 = '0' and bit0 = '1' and zero = '0')) then
					nextState <= "00001";
				elsif ((bit1 = '1' and bit0 = '0' and carry = '1')or(bit1 = '0' and bit0 = '1' and zero = '1') or (bit1 = '0' and bit0 = '0')) then
					nextState <= "00011";
				end if;
			elsif (opcode = "1100") then
				nextState <= "00011";
			elsif (opcode = "1001") then
				nextState <= "10010";
			end if;
		when "00011" =>
			if(opcode = "0000" or opcode = "0001" or opcode = "0010") then
				nextState <= "00100";
			elsif(opcode = "0100") then
				nextState <= "01000";
			elsif(opcode = "0101") then
				nextState <= "00110";
			elsif(opcode = "1100" and zero = '1') then
				nextState <= "01111";
			elsif(opcode = "1100" and zero = '0') then
				nextState <= "00001";
			end if;
		when "00110" =>
			if(opcode = "0101") then
				nextState <= "00111";
			elsif(opcode = "0110") then
				nextState <= "01001";
			elsif(opcode = "0111") then
				nextState <= "01101";
			end if;
		when "01001" =>
			if(shift = '1') then
				nextState <= "01010";
			elsif(shift = '0') then
				nextState <= "01011";
			end if;
		when "01100" =>
			if(opcode = "0110")then
				nextState <= "01001";
			elsif(opcode = "0111")then
				nextState <= "01101";
			end if;
		when "01011" =>
			if(t3 = '1') then
				nextState <= "00001";
			elsif(t3 = '0') then
				nextState <= "01100";
			end if;
		when "01101" =>
			if(shift = '1') then
				nextState <= "01110";
			elsif(shift = '0') then
				nextState <= "01011";
			end if;
		when "10000" =>
			if(opcode = "1001")then
				nextState <= "00010";
			elsif(opcode = "1000")then
				nextState <= "10001";
			end if;
		when "00101" =>
			nextState <= "00011";
		when "01000" =>
			nextState <= "00100";
		when "01110" =>
			nextState <= "01011";
		when "01010" =>
			nextState <= "01100";
		when others =>
			nextState <= "00001";
	end case;	
end process SM;
end kahipan;

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity stateReg is
	port(clk: in std_logic ;nextState : in std_logic_vector(4 downto 0);state : out std_logic_vector(4 downto 0));
end entity;
architecture kahipan of stateReg is

begin
load: process (clk,nextState) begin
	if(clk'event and clk = '1')then
		state <= nextState;
	end if;
end process load;
end kahipan;


library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity shifter is
	port(clk,shift,wr: in std_logic ;writeData : in std_logic_vector(7 downto 0);data : out std_logic_vector(7 downto 0);bit1: out std_logic);
end entity;
architecture kahipan of shifter is
signal data1,data2 : std_logic_vector(7 downto 0);

begin
store: process (clk,shift,wr) is
	begin
	if(rising_edge(clk)) then
		if(wr = '1') then
		data1 <= writeData ;
		end if;
		if(shift = '1')then
			data1(7 downto 1) <= data1(6 downto 0);
			data1(0) <= '0';
		end if;
	end if;	
end process store;
data <= data1;
end kahipan;













