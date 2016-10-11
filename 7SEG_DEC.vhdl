--------------------------
-------Zack Gehrken-------
--------09/20/2016--------
--zack.gehrken@gmail.com--
--------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity SEG_DEC is
port (
	   SYSINV_Y: in STD_LOGIC;
       SYS_Y: in std_logic_vector(7 downto 0);	 	 
	   DEC_Z: out STD_LOGIC;
       SEGM_Z: out std_logic_vector(6 downto 0)
      );
end SEG_DEC;

architecture BEHAVIORAL of SEG_DEC is 
 
 SIGNAL DEC_ZIN: STD_LOGIC;
 SIGNAL SEGM_ZIN: std_logic_vector(6 downto 0);
 
begin
P01: process (SYS_Y,DEC_ZIN,SEGM_ZIN,SYSINV_Y)
	begin
	
	   --------------------SYMBOLS--------------------
		if SYS_Y(7) = '1' then
			SEGM_ZIN <= "1111111"; --BLANKALL

	    elsif SYS_Y(6) = '1' then
			SEGM_ZIN <= "0001001"; --H 
			
	    elsif SYS_Y(5) = '1' then
			SEGM_ZIN <= "0111111"; --DASH
			
		--------------------SYMBOLS--------------------
		--###########################################--
		--------------------NUMBERS--------------------		
		 elsif SYS_Y(3 downto 0) = "0000" then --0
		   SEGM_ZIN <= "1000000";
			
		 elsif SYS_Y(3 downto 0) = "0001" then --1
		   SEGM_ZIN <= "1111001";

         elsif SYS_Y(3 downto 0) = "0010" then --2
		   SEGM_ZIN <= "0100100";
			
		 elsif SYS_Y(3 downto 0) = "0011" then --3
		   SEGM_ZIN <= "0110000";
			
		 elsif SYS_Y(3 downto 0) = "0100" then --4
		   SEGM_ZIN <= "0011001";
			
		 elsif SYS_Y(3 downto 0) = "0101" then --5
		   SEGM_ZIN <= "0010010";

         elsif SYS_Y(3 downto 0) = "0110" then --6
		   SEGM_ZIN <= "0000010";
			
		 elsif SYS_Y(3 downto 0) = "0111" then --7
		   SEGM_ZIN <= "1111000";
			
		 elsif SYS_Y(3 downto 0) = "1000" then --8
		   SEGM_ZIN <= "0000000";
			
		 elsif SYS_Y(3 downto 0) = "1001" then --9
		   SEGM_ZIN <= "0011000";

         elsif SYS_Y(3 downto 0) = "1010" then --A(10)
		   SEGM_ZIN <= "0001000";
			
		 elsif SYS_Y(3 downto 0) = "1011" then --b(11)
		   SEGM_ZIN <= "0000011";
			
		 elsif SYS_Y(3 downto 0) = "1100" then --C(12)
		   SEGM_ZIN <= "1000110";
			
		 elsif SYS_Y(3 downto 0) = "1101" then --d(13)
		   SEGM_ZIN <= "0100001";

         elsif SYS_Y(3 downto 0) = "1110" then --E(14)
		   SEGM_ZIN <= "0000110";
			
		 elsif SYS_Y(3 downto 0) = "1111" then --F(15)
		   SEGM_ZIN <= "0001110";
						
		end if;
		--------------------NUMBERS--------------------	
		--###########################################--
		--------------------DECIMAL--------------------	
		if SYS_Y(4) = '1' then 
			 DEC_ZIN <= '0';
			
		else DEC_ZIN <='1';
		
		end if;
		--------------------DECIMAL--------------------	
		--###########################################--
		----------------OUTPUT INVERTER----------------
		if SYSINV_Y = '1' then --Inverts Output For Active High Displays 
		   DEC_Z <= not DEC_ZIN;
		   SEGM_Z <= not SEGM_ZIN;
			
		elsif SYSINV_Y = '0' then --Output For Active Low Displays
		   DEC_Z <= DEC_ZIN;
    	   SEGM_Z <= SEGM_ZIN;
			  
		end if;
		----------------OUTPUT INVERTER----------------
		
	end process;
end BEHAVIORAL;