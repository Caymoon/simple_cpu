----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:16:00 11/02/2012 
-- Design Name: 
-- Module Name:    irctl - Behavioral 
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity irctl is
    Port ( t0 : in  STD_LOGIC;
           t1,clk: in  STD_LOGIC;
           pcnew : in  STD_LOGIC_VECTOR (15 downto 0);
           pcupdate : in  STD_LOGIC;
           irreq : out  STD_LOGIC;
			  rest:in std_logic;
           irout : out  STD_LOGIC_VECTOR (15 downto 0);
           pcout : out  STD_LOGIC_VECTOR (15 downto 0);
			  irnew: in STD_LOGIC_VECTOR (15 downto 0));
end irctl;

architecture Behavioral of irctl is
signal pc:std_logic_vector(15 downto 0);
signal ir:std_logic_vector(15 downto 0);
begin
process(t0,irnew,rest,pcupdate,t1,clk)
begin
	if(rest='1') then 
	pc<="0000000000000000";
	irreq<='0';
	ir<="ZZZZZZZZZZZZZZZZ";
	elsif (t0='1') then
	irreq<='1';
	ir<=irnew;
	elsif(t1='1') then
	IF(CLK='0' AND CLK'EVENT) THEN
	pc<=pc+'1';END IF;irreq<='0'; 
   elsif(pcupdate='1') then
	 pc<=pcnew;
	end if;
end process;
	pcout<=pc;
	irout<=ir;
end Behavioral;

