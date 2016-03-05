----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:55:44 11/07/2012 
-- Design Name: 
-- Module Name:    memctl - Behavioral 
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

entity memctl is
    Port ( irreq : in  STD_LOGIC;
           wr : in  STD_LOGIC;
           rd : in  STD_LOGIC;
           addr : in  STD_LOGIC_VECTOR (15 downto 0);
			  pcaddr:in  STD_LOGIC_VECTOR (15 downto 0);
           mdr : out  STD_LOGIC_VECTOR (7 downto 0);
			  ir:out STD_LOGIC_VECTOR (15 downto 0);
			  regdata : in  STD_LOGIC_VECTOR (7 downto 0);
           ABUS : out  STD_LOGIC_VECTOR (15 downto 0);
           DBUS : inout  STD_LOGIC_VECTOR (15 downto 0);
           nMERQ : out  STD_LOGIC;
           nRD : out  STD_LOGIC;
           nWR : out  STD_LOGIC;
           nBHE : out  STD_LOGIC;
           nBLE : out  STD_LOGIC);
end memctl;

architecture Behavioral of memctl is

begin
process (wr,rd,irreq,addr)
begin
----DBUS <="ZZZZZZZZZZZZZZZZ";
if(irreq='1') then
	nBLE<='0';
	nBHE<='0';
	nWR<='1';
	nRD<='0';
	nMERQ<='0';
	ABUS<=pcaddr;
	ir<=DBUS;
	DBUS <="ZZZZZZZZZZZZZZZZ";
elsif(wr='1') then
	nBLE<='0';
	nBHE<='1';
	nWR<='0';
	nRD<='1';
	nMERQ<='0';
	ABUS<=addr;
	DBUS(7 downto 0)<=regdata;
	DBUS(15 downto 8)<="00000000";
elsif(rd='1') then
	nBLE<='0';
	nBHE<='1';
	nWR<='1';
	nRD<='0';
	nMERQ<='0';
	ABUS<=addr;
	mdr<=DBUS(7 downto 0);
	DBUS <="ZZZZZZZZZZZZZZZZ";
else
	nBLE<='1';
	nBHE<='1';
	nWR<='1';
	nRD<='1';
	nMERQ<='1';
	ABUS<="ZZZZZZZZZZZZZZZZ";
	DBUS <="ZZZZZZZZZZZZZZZZ";
end if;
end process;
end Behavioral;

