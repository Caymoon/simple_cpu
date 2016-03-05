----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:28:59 11/08/2012 
-- Design Name: 
-- Module Name:    count5 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity count5 is
port(
     clk: in std_logic;
	rest:in std_logic; 
 	t: out std_logic_vector(4 downto 0));
end count5;

architecture Behavioral of count5 is
	signal tmp:std_logic_vector(4 downto 0 );
begin
      process( clk, rest )
		begin 
		   if rest = '1'then 
			    t <= "00000"; 
			    tmp <= "00001"; 
		   elsif clk = '1' and clk'event then 
				  t <= tmp;
			     if    (tmp = "00001") then tmp <= "00010";
				  elsif (tmp = "00010") then tmp <= "00100";
				  elsif (tmp = "00100") then tmp <= "01000";
		        elsif (tmp = "01000") then tmp <= "10000";
				  elsif (tmp="10000")	then tmp<="00001";
				  end if;
		   end if;		    
		  end process;
end Behavioral;
