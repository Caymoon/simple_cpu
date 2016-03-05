----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:52:51 11/08/2012 
-- Design Name: 
-- Module Name:    cpu - Behavioral 
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

entity cpu is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           abus : out  STD_LOGIC_VECTOR (15 downto 0);
           dbus : inout  STD_LOGIC_VECTOR (15 downto 0);
           nmreq : out  STD_LOGIC;
           nrd,cyout : out  STD_LOGIC;
           nwr : out  STD_LOGIC;
           nbhe : out  STD_LOGIC;
           nble : out  STD_LOGIC;
			  abusout,irout : out  STD_LOGIC_VECTOR (15 downto 0);
           dbusout : out  STD_LOGIC_VECTOR (15 downto 0);
           nmreqout : out  STD_LOGIC;
           nrdout : out  STD_LOGIC;
           nwrout : out  STD_LOGIC;
           nbheout : out  STD_LOGIC;
			  ttout:out std_logic_vector(4 downto 0);
           nbleout : out  STD_LOGIC);
end cpu;

architecture Behavioral of cpu is
component count5 is
port(
     clk: in std_logic;
	rest:in std_logic; 
 	t: out std_logic_vector(4 downto 0));
end component;
component irctl is
    Port ( t0 : in  STD_LOGIC;
           t1,clk : in  STD_LOGIC;
           pcnew : in  STD_LOGIC_VECTOR (15 downto 0);
           pcupdate : in  STD_LOGIC;
           irreq : out  STD_LOGIC;
			  rest:in std_logic;
           irout : out  STD_LOGIC_VECTOR (15 downto 0);
           pcout : out  STD_LOGIC_VECTOR (15 downto 0);
			  irnew: in STD_LOGIC_VECTOR (15 downto 0));
end component;
component alu is
    Port ( ir,pcin : in  STD_LOGIC_VECTOR (15 downto 0);
           t2,t3,clk,rest : in  STD_LOGIC;
           aluout : out  STD_LOGIC_VECTOR (7 downto 0);
           addr,pcnewout : out  STD_LOGIC_VECTOR (15 downto 0);
           Rupdate : in  STD_LOGIC;
			  writereq,zout,cyout: out STD_LOGIC;
			  readreq:out STD_LOGIC;
           Raddr : in  STD_LOGIC_vector(2 downto 0);
           Rdata : in  STD_LOGIC_VECTOR (7 downto 0);
			  Rdataout:out STD_LOGIC_VECTOR (7 downto 0));			  
end component;
component memory is
    Port ( t3 : in  STD_LOGIC;
           ir : in  STD_LOGIC_VECTOR (15 downto 0);
           aluin : in  STD_LOGIC_VECTOR (7 downto 0);
           Rtmpout : out  STD_LOGIC_VECTOR (7 downto 0);
           mdrin : in  STD_LOGIC_VECTOR (7 downto 0));
end component;
component rewrite is
    Port ( Rtmpin : in  STD_LOGIC_VECTOR (7 downto 0);
           pcin,pcnewin : in  STD_LOGIC_VECTOR (15 downto 0);
           t4,cyin,zin : in  STD_LOGIC;
           Raddrout : out  STD_LOGIC_VECTOR (2 downto 0);
           Rdataout : out  STD_LOGIC_VECTOR (7 downto 0);
           Rupdate : out  STD_LOGIC;
			  ir:in STD_LOGIC_VECTOR (15 downto 0);
           pcnewout : out  STD_LOGIC_VECTOR (15 downto 0);
           pcupdate : out  STD_LOGIC);
end component;
component memctl is
    Port ( irreq : in  STD_LOGIC;
           wr : in  STD_LOGIC;
           rd : in  STD_LOGIC;
           addr : in  STD_LOGIC_VECTOR (15 downto 0);
			  pcaddr : in  STD_LOGIC_VECTOR (15 downto 0);
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
end component;
signal tclk,trst,tpcupdate,tirreq,trd,twr,tRupdate,tz,tcy,twnRD,twnWR,twnBHE,twnBLe,twnMREQ:std_logic;
signal tt:std_logic_vector(4 downto 0);
signal tpcin,tir,tpc,tirin,taddr,twABUS,twDBUS,tzcpc:std_logic_vector(15 downto 0);
signal taluout,tRdata,tRtmp,tmdr,tRdatam:std_logic_vector(7 downto 0);
signal tRaddr:std_logic_vector(2 downto 0);
begin
	u1:count5 port map(clk=>tclk,rest=>trst,t=>tt);
	u2:irctl port map(t0=>tt(0),t1=>tt(1),clk=>tclk,pcnew=>tpcin,pcupdate=>tpcupdate,irreq=>tirreq,rest=>trst,irout=>tir,pcout=>tpc,irnew=>tirin);
	u3:alu port map(ir=>tir,pcin=>tpc,t2=>tt(2),t3=>tt(3),clk=>tclk,rest=>trst,aluout=>taluout,addr=>taddr,pcnewout=>tzcpc,Rupdate=>tRupdate,writereq=>twr,zout=>tz,cyout=>tcy,readreq=>trd,Raddr=>tRaddr,Rdata=>tRdata,Rdataout=>tRdatam);
	u4:memory port map(t3=>tt(3),ir=>tir,aluin=>taluout,Rtmpout=>tRtmp,mdrin=>tmdr);
	u5:rewrite port map(Rtmpin=>tRtmp,pcin=>tpc,pcnewin=>tzcpc,t4=>tt(4),cyin=>tcy,zin=>tz,Raddrout=>tRaddr,Rdataout=>tRdata,Rupdate=>tRupdate,ir=>tir,pcnewout=>tpcin,pcupdate=>tpcupdate);
	u6:memctl port map(irreq=>tirreq,wr=>twr,rd=>trd,addr=>taddr,pcaddr=>tpc,mdr=>tmdr,ir=>tirin,regdata=>tRdatam,ABUS=>twABUS,DBUS=>DBUS,nMERQ=>twnMReQ,nRD=>twnRD,nWR=>twnWR,nBLE=>twnBLE,nBHE=>twnBHE);
	trst<=rst;
   tclk<=clk;
   abus<=twABUS;
--	twDBUS<=dbus;
   nmreq<=twnMREQ;
   nrd<=twnRD;
   nwr<=twnWR;
   nbhe<=twnBHE;
   nble<=twnBLE;
---------------------------------------
	abusout<=twABUS;
	--irout<=tir;
	irout<=tpc;
   dbusout<=dbus;
   nmreqout<=twnMREQ;
   nrdout<=twnRD;
   nwrout<=twnWR;
   nbheout<=twnBHE;
	ttout<=tt;
   nbleout<=twnBLE;
	cyout<=tcy;
end Behavioral;

