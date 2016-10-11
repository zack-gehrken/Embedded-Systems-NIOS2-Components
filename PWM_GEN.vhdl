--------------------------
-------Zack Gehrken-------
--zack.gehrken@gmail.com--
---------10/05/16---------
--------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; --Needed for Vector to Unsigned Int conversion

entity PWM_GEN is
	Port (
		SYS_clk: IN STD_LOGIC;
		PWM_VAL: IN STD_LOGIC_VECTOR(15 downto 0);
		PWM_Out: OUT STD_LOGIC
	);
end PWM_GEN;

architecture Behavioral of PWM_GEN is 
	signal PWM_int: integer;
	signal clkcntr: integer range 0 to 65535 := 0; --Clock divider counter to create 763 Hz clock pulse 
    signal PWM_clk: STD_LOGIC;
	
begin
	PWM_GEN: process(SYS_clk,PWM_VAL,PWM_clk) begin
					
	if rising_edge(SYS_clk) then --On rising edge of 50Mhz sys clock trigger this 	
		 if (PWM_int > 0) then --Make output high aslong as input transfer register is not 0
		 	PWM_int <= PWM_int - 1;
			PWM_Out <= '1';
		 else 
		 	PWM_Out <= '0';
		 end if; 
		 		 
		 if (clkcntr = 65535) then -- Every 65536 sys clock cycles run this 
		 	PWM_clk <= NOT(PWM_clk);
		 	PWM_int <= conv_integer(unsigned(PWM_Val)); --Update input transfer register with new values 
			clkcntr <= 0; --Reset if statement 				
		 else
		 	clkcntr <= clkcntr + 1; --Increment counter every sys clock cycle 	
		 end if;	
			
	end if;
			
	end process;	 
end Behavioral;
   