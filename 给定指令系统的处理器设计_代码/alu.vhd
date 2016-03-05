----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:49:30 11/11/2012 
-- Design Name: 
-- Module Name:    alu - Behavioral 
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

entity alu is
    Port ( ir,pcin : in  STD_LOGIC_VECTOR (15 downto 0);
           t2,t3,clk,rest: in  STD_LOGIC;
           aluout : out  STD_LOGIC_VECTOR (7 downto 0);
           addr,pcnewout : out  STD_LOGIC_VECTOR (15 downto 0);
           Rupdate : in  STD_LOGIC;
			  writereq,zout,cyout: out STD_LOGIC;
			  readreq:out STD_LOGIC;
           Raddr : in  STD_LOGIC_vector(2 downto 0);
           Rdata : in  STD_LOGIC_VECTOR (7 downto 0);
			  Rdataout:out STD_LOGIC_VECTOR (7 downto 0));
			  
end alu;

architecture Behavioral of alu is
   type data8 IS array(0 to 7) of std_logic_vector(7 downto 0); 
   signal  A,B,alutmp,alusy:std_logic_vector(8 downto 0);--A\B alu2个运算数
   signal reg:data8; --定义寄存器 
	signal cy:std_logic;
	signal z:std_logic;
begin

process(ir,t2)--r
 begin
	   A(7 downto 0)<= reg(conv_integer( ir( 10 downto 8 )));
    	B(7 downto 0)<= reg(conv_integer( ir( 2 downto 0 )));
		A(8)<='0';
		B(8)<='0';
		if(ir(15 downto 11)="10001") then addr(7 downto 0)<=reg(conv_integer( ir( 2 downto 0 )));addr( 15 downto 8 ) <= reg(7);	--r
		elsif(ir(15 downto 11)="10010") then addr(7 downto 0)<=reg(conv_integer( ir( 2 downto 0 )))+reg(6);addr( 15 downto 8 ) <= reg(7);
		else
     	addr( 15 downto 8 ) <= reg(7);
     	addr( 7 downto 0 ) <= IR( 7 downto 0 );
		end if;
end process;
process (ir,t2,Rupdate,clk,rest,t3)
begin
readreq<='0';
writereq<='0';
if(Rupdate='1') then 
	if(clk='0' and clk'event) then
	reg(conv_integer(ir(10 downto 8))) <= Rdata;	 --回写寄存器 
	end if;
end if;
if(t2='1') then
	case ir(15 downto 11) is
		when "00000"=>alutmp(7 downto 0)<=ir(7 downto 0);--mov ri shu 	r
		when "00001"=>alutmp(7 downto 0)<=B(7 downto 0);--mov ri rj	r
		when "00010"=>readreq<='1'; writereq<='0';--mov ri di
		when "00011"=>Rdataout<=A(7 downto 0); writereq<='1'; readreq<='0';--mov di ri
		when "00100"=>alutmp<=A+ir(7 downto 0)+cy; alusy<=alutmp;--add ri shu	r
		when "00101"=>alutmp<=A+B+cy; alusy<=alutmp;--add ri rj	r
		when "00110"=>alutmp<=A-ir(7 downto 0)-cy; alusy<=alutmp;--sub ri shu
		when "00111"=>alutmp<=A-B-cy; alusy<=alutmp;--sub ri rj	r
		when "01000"=>alutmp<=A and '0'&ir(7 downto 0);alusy<=alutmp;--and ri shu
		when "01001"=>alutmp<=A and B;alusy<=alutmp;--and ri rj
		when "01010"=>alutmp<=A or '0'&ir(7 downto 0);alusy<=alutmp;--or ri shu
		when "01011"=>alutmp<=A or B;alusy<=alutmp;--or ri rj
		when "01100"=>alusy(8)<='0';--clc	r
		when "01101"=>alusy(8)<='1';--stc	r
		--jmp donothing
		when "01111"=>pcnewout(7 downto 0)<=pcin(7 downto 0)+ir(7 downto 0);pcnewout(15 downto 8)<="00000000";--jz sign  
		when "10000"=>pcnewout(7 downto 0)<=pcin(7 downto 0)+ir(7 downto 0);pcnewout(15 downto 8)<="00000000";--jc sign 
		when "10001"=>readreq<='1'; writereq<='0';--mov ri [rj]
		when "10010"=>readreq<='1'; writereq<='0';--mov ri [rj+r6]
		when others=>null;
	end case;	
 end if;
 if(rest='1') then
	alutmp(8)<='0';
	alusy<="000000001";
	cy<='0';
	z<='0';
else
	if( t3='1')then cy<=alusy(8);end if;	
	if(alusy="000000000") then z<='1'; else z<='0'; end if;
	end if;
end process;
	aluout<=alutmp(7 downto 0);
	cyout<=cy;
   zout<=z;
end Behavioral;


