library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity mux1 is
	port(ip: in std_logic_vector(1 downto 0);control : in std_logic ; fop : out std_logic)
end entity;
architecture kahipan of mux is
begin
 fop <= (ip(0) and (not control)) or (ip(1) and control);
end kahipan;

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity mux2 is
	port(control: in std_logic_vector(1 downto 0); ip: in std_logic_vector(3 downto 0); fop : out std_logic)
end entity;
architecture kahipan of mux is
component mux1 is
	port(ip: in std_logic_vector(1 downto 0);control: in std_logic ; fop : out std_logic)
end component;
signal op:std_logic_vector(1 downto 0);
begin
 com0 : mux1 port map(ip => ip(1 downto 0),control => control(0),fop => op(0) );
 com1 : mux1 port map(ip => ip(3 downto 2),control => control(0),fop => op(1) );
 com3 : mux1 port map(ip => op(1 downto 0),control => control(1),fop => op );
end kahipan;

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity mux3 is
	port(control: in std_logic_vector(2 downto 0); ip: in std_logic_vector(7 downto 0); fop : out std_logic)
end entity;
architecture kahipan of mux is
component mux1 is
	port(ip: in std_logic_vector(1 downto 0);control: in std_logic ; fop : out std_logic)
end component;
component mux2 is
	port(control: in std_logic_vector(1 downto 0); ip: in std_logic_vector(3 downto 0); fop : out std_logic)
end component;
signal op:std_logic_vector(1 downto 0);
begin
 com0 : mux2 port map(ip => ip(3 downto 0),control => control(1 downto 0),fop => op(0) );
 com1 : mux2 port map(ip => ip(7 downto 4),control => control(1 downto 0),fop => op(1) );
 com3 : mux1 port map(ip => op(1 downto 0),control => control(2),fop => fop );
end kahipan;

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity mux4 is
	port(control: in std_logic_vector(3 downto 0); ip: in std_logic_vector(15 downto 0); fop : out std_logic)
end entity;
architecture kahipan of mux is
component mux1 is
	port(ip: in std_logic_vector(1 downto 0);control: in std_logic ; fop : out std_logic)
end component;
component mux3 is
	port(control: in std_logic_vector(2 downto 0); ip: in std_logic_vector(7 downto 0); fop : out std_logic)
end component;
signal op:std_logic_vector(1 downto 0);
begin
 com0 : mux3 port map(ip => ip(7 downto 0),control => control(2 downto 0),fop => op(0) );
 com1 : mux3 port map(ip => ip(15 downto 8),control => control(2 downto 0),fop => op(1) );
 com3 : mux1 port map(op => op(1 downto 0),control => control(3),fop => fop );
end kahipan;


library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity twenty_mux is
	port(control: in std_logic_vector(4 downto 0); ip: in std_logic_vector(19 downto 0); fop : out std_logic)
end entity;
architecture kahipan of mux is
component mux1 is
	port(ip: in std_logic_vector(1 downto 0);control: in std_logic ; fop : out std_logic)
end component;
component mux4 is
	port(control: in std_logic_vector(3 downto 0); ip: in std_logic_vector(15 downto 0); fop : out std_logic)
end component;
signal op:std_logic_vector(1 downto 0);
begin
 com0 : mux4 port map(ip => ip(15 downto 0),control => control(3 downto 0),fop => op(0) );
 com1 : mux2 port map(ip => ip(19 downto 16),control => control(1 downto 0),fop => op(1) );
 com3 : mux1 port map(ip => op(1 downto 0),control => control(4),fop => fop );
end kahipan;

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity state_mux is
	port()


