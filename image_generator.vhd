library IEEE;
 use IEEE.STD_LOGIC_1164.ALL; 
 use IEEE.STD_LOGIC_ARITH.ALL; 
 
 use IEEE.STD_LOGIC_UNSIGNED.ALL; 
 entity image_generator is 
 
 Port ( 
 hctr     : in std_logic_vector (10 downto 0); 
 vctr     : in std_logic_vector (9 downto 0); 
 blank    : in std_logic; -- blank interval signal 
 clk50MHz : in std_logic; -- main clock 
 reset    : in std_logic; -- global reset
 pos_regxp: in std_logic_vector(10 DOWNTO 0); -- global reset  
 pos_regyp: in std_logic_vector(9 DOWNTO 0); -- global reset 
 pos_reg_1: in std_logic_vector(9 DOWNTO 0); -- global reset  
 pos_reg_2: in std_logic_vector(9 DOWNTO 0); -- global reset 
 R        : out std_logic; -- Red colour signal 
 G        : out std_logic; -- Green colour signal 
 B        : out std_logic); -- Blue colour signal 
 
 end image_generator; 
 
 architecture Behavioral of image_generator is 
 
 signal hctr_int,pos_regxp_S : integer range 1586 downto 0; 
 signal vctr_int : integer range 524 downto 0; 
 signal R_int, G_int, B_int: std_logic; 
 signal color: std_logic_vector (2 downto 0); 
 signal pos_reg_s1,pos_reg_s2,pos_regyp_s : integer range 524 DOWNTO 0;
 begin hctr_int <= CONV_INTEGER (hctr); 
 vctr_int <= CONV_INTEGER (vctr); -- utilizamos biestables de salida para evitar posibles Glitches
pos_reg_s1 <= CONV_INTEGER (pos_reg_1);
pos_regyp_s <= CONV_INTEGER (pos_regyp);
pos_regxp_s <= CONV_INTEGER (pos_regxp);
pos_reg_s2 <= CONV_INTEGER (pos_reg_2);
 -- Iniiciaizamos los biestables a cero 
 process (clk50MHz,reset,R_int,G_int,B_int,pos_reg_s1,pos_reg_s2) 
 begin 
 if reset = '1' then 
 
 R <= '0'; 
 G <= '0'; 
 B <= '0'; 
 elsif 
 
 clk50MHz='1' and clk50MHz'event then 
 R <= R_int; 
 G <= G_int; 
 B <= B_int; 
 end if; 
 end process;
 
 color <= "110" when ((hctr_int >= 60) AND (hctr_int < 80) AND  (vctr_int >= (pos_reg_s1-35)) AND (vctr_int < (pos_reg_s1 + 35))  AND (blank = '1')) else
			 "110" when ((hctr_int >= 1230) AND (hctr_int < 1250) AND  (vctr_int >= (pos_reg_s2-35)) AND (vctr_int < (pos_reg_s2 + 35))  AND (blank = '1')) else

		 "011" when ((hctr_int >= pos_regxp_s -8) AND (hctr_int < pos_regxp_s+7) AND  (vctr_int >= pos_regyp_s -4) AND (vctr_int < pos_regyp_s +3)  AND (blank = '1')) else
--			 "100" when ((hctr_int >= 82) AND (hctr_int < 86) AND  (vctr_int >= 251 ) AND (vctr_int < 259)  AND (blank = '1')) else
 "111" when ((hctr_int >= 0) AND (hctr_int < 1586) AND  (vctr_int >= 0 ) AND (vctr_int < 9)  AND (blank = '1')) else
  "111" when ((hctr_int >= 0) AND (hctr_int < 1586) AND  (vctr_int >= 477 ) AND (vctr_int < 555)  AND (blank = '1')) else


--			 "100" when ((hctr_int >= 86) AND (hctr_int < 94) AND  (vctr_int >= 250) AND (vctr_int < 259)  AND (blank = '1')) else





					  
			  
--			 
--			 "100" when ((hctr_int >= 82) AND (hctr_int < 86) AND  (vctr_int >= 251 ) AND (vctr_int < 259)  AND (blank = '1')) else
--			 "100" when ((hctr_int >= 86) AND (hctr_int < 94) AND  (vctr_int >= 250 ) AND (vctr_int < 259)  AND (blank = '1')) else
--			 "100" when ((hctr_int >= 94) AND (hctr_int < 98) AND  (vctr_int >= 250 ) AND (vctr_int < 260)  AND (blank = '1')) else
--			 
--			 
--			 "100" when ((hctr_int >= 82) AND (hctr_int < 86) AND  (vctr_int >= 251 ) AND (vctr_int < 259)  AND (blank = '1')) else
--			 "100" when ((hctr_int >= 86) AND (hctr_int < 94) AND  (vctr_int >= 250 ) AND (vctr_int < 259)  AND (blank = '1')) else
--			 "100" when ((hctr_int >= 94) AND (hctr_int < 98) AND  (vctr_int >= 250 ) AND (vctr_int < 260)  AND (blank = '1')) else
		"000" ;

 R_int <= color(2);
 G_int <= color(1); 
 B_int <= color(0); 
 end Behavioral;