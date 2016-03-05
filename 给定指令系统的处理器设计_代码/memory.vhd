----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:46:48 11/06/2012 
-- Design Name: 
-- Module Name:    memory - Behavioral 
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

entity memory is
    Port ( t3 : in  STD_LOGIC;
           ir : in  STD_LOGIC_VECTOR (15 downto 0);
           aluin : in  STD_LOGIC_VECTOR (7 downto 0);
           Rtmpout : out  STD_LOGIC_VECTOR (7 downto 0);
           mdrin : in  STD_LOGIC_VECTOR (7 downto 0));
end memory;

architecture Behavioral of memory is
signal Rtmp:std_logic_vector(7 downto 0);
begin
process(t3,ir)
begin
	if(t3='1') then
	case ir(15 downto 11) is
		when "00000"=>Rtmp<=aluin;--mov ri shu
		when "00001"=>Rtmp<=aluin;--mov ri rj
	   when "00010"=>Rtmp<=mdrin;--mov ri di
		--when "00011"=>Rtmp<=mdrin;--mov di ri
		when "00100"=>Rtmp<=aluin;--add ri shu
	   when "00101"=>Rtmp<=aluin;--add ri rj
		when "00110"=>Rtmp<=aluin;--sub ri shu
		when "00111"=>Rtmp<=aluin;--sub ri rj
		when "01000"=>Rtmp<=aluin;--and ri shu
		when "01001"=>Rtmp<=aluin;--and ri rj
		when "01010"=>Rtmp<=aluin;--or ri shu
		when "01011"=>Rtmp<=aluin;--or ri rj
		--when "01100"=>cy<='0';--clc
		--when "01101"=>cy<='1';--stc
		--jmp donothing
--		when "01111"=>if(cy='1') then addr<=pcin+(ir and "0000000011111111"); else addr<=pcin; end if; --jz sign 
--		when "10000"=>if(cy='1') then addr<=pcin+ir(7 downto 0);end if ;--jc sign
		when "10001"=>Rtmp<=mdrin;--mov ri [rj]
		when "10010"=>Rtmp<=mdrin;--mov ri [ri+r6]
		when others=>null;
	end case;
	end if;
	Rtmpout<=Rtmp;
end process;

end Behavioral;

