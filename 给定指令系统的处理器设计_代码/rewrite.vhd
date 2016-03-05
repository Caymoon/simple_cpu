----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:22:06 11/07/2012 
-- Design Name: 
-- Module Name:    rewrite - Behavioral 
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

entity rewrite is
    Port ( Rtmpin : in  STD_LOGIC_VECTOR (7 downto 0);
           pcin,pcnewin : in  STD_LOGIC_VECTOR (15 downto 0);
           t4,cyin,zin : in  STD_LOGIC;
           Raddrout : out  STD_LOGIC_VECTOR (2 downto 0);
           Rdataout : out  STD_LOGIC_VECTOR (7 downto 0);
           Rupdate : out  STD_LOGIC;
			  ir:in STD_LOGIC_VECTOR (15 downto 0);
           pcnewout : out  STD_LOGIC_VECTOR (15 downto 0);
           pcupdate : out  STD_LOGIC);
end rewrite;

architecture Behavioral of rewrite is
begin
process(t4,ir,pcin,Rtmpin)
begin
			Rdataout <= "00000000";
			pcnewout <= "0000000000000000";
    		Rupdate <= '0';
			pcupdate <= '0';
			Raddrout <= "000";
if(t4='1')then
	case (ir(15 downto 11)) is
		when "00000"=>Rdataout<=Rtmpin; Raddrout<=ir(10 downto 8);Rupdate<='1';--mov ri shu
		when "00001"=>Rdataout<=Rtmpin; Raddrout<=ir(10 downto 8);Rupdate<='1';--mov ri rj
		when "00010"=>Rdataout<=Rtmpin; Raddrout<=ir(10 downto 8);Rupdate<='1';--mov ri di
		--when "00011"=>Rdataout<=B; writereq<='1';--mov di ri
		when "00100"=>Rdataout<=Rtmpin; Raddrout<=ir(10 downto 8);Rupdate<='1';--add ri shu
		when "00101"=>Rdataout<=Rtmpin; Raddrout<=ir(10 downto 8);Rupdate<='1';--add ri rj
		when "00110"=>Rdataout<=Rtmpin; Raddrout<=ir(10 downto 8);Rupdate<='1';--sub ri shu
		when "00111"=>Rdataout<=Rtmpin; Raddrout<=ir(10 downto 8);Rupdate<='1';--sub ri rj
		when "01000"=>Rdataout<=Rtmpin; Raddrout<=ir(10 downto 8);Rupdate<='1';--and ri shu
		when "01001"=>Rdataout<=Rtmpin; Raddrout<=ir(10 downto 8);Rupdate<='1';--and ri rj
		when "01010"=>Rdataout<=Rtmpin; Raddrout<=ir(10 downto 8);Rupdate<='1';--or ri shu
		when "01011"=>Rdataout<=Rtmpin; Raddrout<=ir(10 downto 8);Rupdate<='1';--or ri rj
		when "01110"=>pcnewout<="00000000"&ir(7 downto 0); pcupdate<='1';--jmp 
		when "01111"=>if(zin='1') then pcnewout<=pcnewin; pcupdate<='1'; end if; --jz sign 
		when "10000"=>if(cyin='1') then pcnewout<=pcnewin; pcupdate<='1'; end if;--jc sign
		when "10001"=>Rdataout<=Rtmpin; Raddrout<=ir(10 downto 8);Rupdate<='1';--mov ri [rj]
		when "10010"=>Rdataout<=Rtmpin; Raddrout<=ir(10 downto 8);Rupdate<='1';--mov ri [rj+r6]
		when others=>null;
	end case;
end if;
end process;

end Behavioral;

