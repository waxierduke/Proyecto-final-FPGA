
library IEEE;
 use IEEE.STD_LOGIC_1164.ALL; 
 use IEEE.STD_LOGIC_ARITH.ALL; 
 use IEEE.NUMERIC_STD.ALL;
 use IEEE.STD_LOGIC_UNSIGNED.ALL; 
----------------------------------------------------------------
ENTITY  Comparador_pelota IS
PORT ( clk     : IN  STD_LOGIC;
   pos_x     : IN  STD_LOGIC_VECTOR (10 DOWNTO 0);    
   pos_y     : IN    STD_LOGIC_VECTOR (9 DOWNTO 0);
   gra1_upi    : IN  STD_LOGIC;
   gra1_upd    : IN  STD_LOGIC;
   gra1_dwi    : IN  STD_LOGIC;
   gra1_dwd    : IN  STD_LOGIC;
   gra2_upi    : IN  STD_LOGIC;
   gra2_upd    : IN  STD_LOGIC;
   gra2_dwi    : IN  STD_LOGIC;
   gra2_dwd    : IN  STD_LOGIC;
   gra3_i    : IN  STD_LOGIC;
   gra3_d    : IN  STD_LOGIC;
   reg_raq1    : IN  STD_LOGIC_VECTOR (9 DOWNTO 0);
   reg_raq2    : IN  STD_LOGIC_VECTOR (9 DOWNTO 0);
   sgra1_upi   : OUT STD_LOGIC;
   sgra1_upd   : OUT STD_LOGIC;
   sgra1_dwi   : OUT STD_LOGIC;
   sgra1_dwd   : OUT STD_LOGIC;
   sgra2_upi   : OUT STD_LOGIC;
   sgra2_upd   : OUT STD_LOGIC;
   sgra2_dwi   : OUT STD_LOGIC;
   sgra2_dwd   : OUT STD_LOGIC;
   sgra3_i    : OUT STD_LOGIC;
   sgra3_d    : OUT STD_LOGIC;
   perdioi    : OUT STD_LOGIC;
   perdiod    : OUT STD_LOGIC;
	resetcontrol    : IN STD_LOGIC
	);
   END ENTITY Comparador_pelota;
----------------------------------------------------------------
ARCHITECTURE fsm OF Comparador_pelota IS


 signal pos_y_s : integer range 524 downto 0; 
 signal pos_x_s : integer range 1586 downto 0; 
 signal reg_raq1_s : integer range 524 downto 0;
 signal reg_raq2_s : integer range 524 downto 0;
 begin 
 

 pos_x_s <= CONV_INTEGER (pos_x); 
 pos_y_s <= CONV_INTEGER (pos_y);
 reg_raq1_s <=  CONV_INTEGER (reg_raq1);
 reg_raq2_s <=  CONV_INTEGER (reg_raq2);
PROCESS (clk,gra1_upi,gra1_upd,gra1_dwd,gra1_dwi,gra2_upi,gra2_upd,gra2_dwd,gra2_dwi,gra3_d,gra3_i,pos_x_s,pos_y_s)
BEGIN 

IF(rising_edge(clk)) THEN
  IF RESETCONTROL = '1' THEN 
    
	 perdiod <= '0';
perdioi <= '0';
sgra3_i <= '0';
sgra1_upi <= '0';   
sgra1_upd <= '0';   
sgra1_dwi <= '0';   
sgra1_dwd <= '0';   
sgra2_upi <= '0';   
sgra2_upd <= '0';   
sgra2_dwi <= '0';  
sgra2_dwd <= '0';     
sgra3_d   <= '0';


  
 ELSIF (pos_x_s <= 10 )THEN
  perdioi <= '1';
  perdiod <= '0';
  sgra1_dwd <= '0';
  sgra1_upi <= '0';   
  sgra1_upd <= '0';   
  sgra1_dwi <= '0';     
  sgra2_upi <= '0';   
  sgra2_upd <= '0';  
  sgra2_dwi <= '0';  
  sgra2_dwd <= '0';  
  sgra3_i  <= '0';   
  sgra3_d   <= '0';
 ELSIF (pos_x_s >= 1235)THEN

  perdiod <= '1';
  perdioi <= '0';
  sgra1_dwd <= '0';
  sgra1_upi <= '0';   
  sgra1_upd <= '0';   
  sgra1_dwi <= '0';     
  sgra2_upi <= '0';   
  sgra2_upd <= '0';  
  sgra2_dwi <= '0';  
  sgra2_dwd <= '0';  
  sgra3_i  <= '0';   
  sgra3_d   <= '0';
  
ELSE
		IF(pos_y_s - 4 <= 13) THEN
					IF(gra1_upd = '1')THEN
   perdiod <= '0';
   perdioi <= '0';
   sgra1_dwd <= '1';
   sgra1_upi <= '0';   
   sgra1_upd <= '0';   
   sgra1_dwi <= '0';     
   sgra2_upi <= '0';   
   sgra2_upd <= '0';  
   sgra2_dwi <= '0';  
   sgra2_dwd <= '0';  
   sgra3_i  <= '0';   
   sgra3_d   <= '0';
  ELSIF(gra1_upi = '1')THEN
   perdiod <= '0';
   perdioi <= '0';
   sgra1_dwi <= '1';
   sgra1_upi <= '0';   
   sgra1_upd <= '0';     
   sgra1_dwd <= '0';   
   sgra2_upi <= '0';   
   sgra2_upd <= '0';   
   sgra2_dwi <= '0';  
   sgra2_dwd <= '0';  
   sgra3_i  <= '0';   
   sgra3_d   <= '0';
  ELSIF(gra2_upd = '1')THEN
   perdiod <= '0';
   perdioi <= '0';
   sgra2_dwd <= '1';
   sgra1_upi <= '0';   
   sgra1_upd <= '0';   
   sgra1_dwi <= '0';   
   sgra1_dwd <= '0';   
   sgra2_upi <= '0';   
   sgra2_upd <= '0';   
   sgra2_dwi <= '0';    
   sgra3_i  <= '0';   
   sgra3_d   <= '0';
  ELSIF(gra2_upi = '1')THEN
   perdiod <= '0';
   perdioi <= '0';
   sgra2_dwi <= '1';
   sgra1_upi <= '0';   
   sgra1_upd <= '0';   
   sgra1_dwi <= '0';   
   sgra1_dwd <= '0';   
   sgra2_upi <= '0';   
   sgra2_upd <= '0';    
   sgra2_dwd <= '0';  
   sgra3_i  <= '0';   
   sgra3_d   <= '0';
  END IF;
  
 ELSIF (pos_y_s + 3 >= 476) THEN
  IF(gra1_dwd = '1')THEN
 perdiod <= '0';
   perdioi <= '0';
   sgra1_upi <= '0';  
   sgra1_upd <= '1';   
   sgra1_dwi <= '0';   
   sgra1_dwd <= '0';   
   sgra2_upi <= '0';   
   sgra2_upd <= '0';   
   sgra2_dwi <= '0';  
   sgra2_dwd <= '0';  
   sgra3_i  <= '0';   
   sgra3_d   <= '0';
  ELSIF(gra1_dwi = '1')THEN
   perdiod <= '0';
   perdioi <= '0';
   sgra1_upi <= '1';  
   sgra1_upd <= '0';   
   sgra1_dwi <= '0';   
   sgra1_dwd <= '0';   
   sgra2_upi <= '0';   
   sgra2_upd <= '0';   
   sgra2_dwi <= '0';  
   sgra2_dwd <= '0';  
   sgra3_i  <= '0';   
   sgra3_d   <= '0';
  ELSIF(gra2_dwi = '1')THEN
   perdiod <= '0';
   perdioi <= '0';
   sgra2_upi <= '1';
   sgra1_upi <= '0';   
   sgra1_upd <= '0';   
   sgra1_dwi <= '0';   
   sgra1_dwd <= '0';     
   sgra2_upd <= '0';   
   sgra2_dwi <= '0';  
   sgra2_dwd <= '0';  
   sgra3_i  <= '0';   
   sgra3_d   <= '0';
  ELSIF(gra2_dwd = '1')THEN
  
  
   perdiod <= '0';
   perdioi <= '0';
   sgra2_upd <= '1';
   sgra1_upi <= '0';   
   sgra1_upd <= '0';   
   sgra1_dwi <= '0';   
   sgra1_dwd <= '0';   
   sgra2_upi <= '0';     
   sgra2_dwi <= '0';  
   sgra2_dwd <= '0';  
   sgra3_i  <= '0';   
   sgra3_d   <= '0';
   END IF;
 ELSIF (pos_x_s - 8 <= 81)THEN
  IF ((pos_y_s >= reg_raq1_s -5) AND (pos_y_s <= reg_raq1_s +4))THEN
   perdiod <= '0';
   perdioi <= '0';
   sgra3_d <= '1';
   sgra1_upi <= '0';   
   sgra1_upd <= '0';   
   sgra1_dwi <= '0';   
   sgra1_dwd <= '0';   
   sgra2_upi <= '0';   
   sgra2_upd <= '0';   
   sgra2_dwi <= '0';  
   sgra2_dwd <= '0';  
   sgra3_i  <= '0';   

  ELSIF ((pos_y_s <= reg_raq1_s -6) AND (pos_y_s >= reg_raq1_s -20))THEN
   perdiod <= '0';
   perdioi <= '0';
   sgra2_upd <= '1';
   sgra1_upi <= '0';   
   sgra1_upd <= '0';   
   sgra1_dwi <= '0';   
   sgra1_dwd <= '0';   
   sgra2_upi <= '0';      
   sgra2_dwi <= '0';  
   sgra2_dwd <= '0';  
   sgra3_i  <= '0';   
   sgra3_d   <= '0';
  ELSIF ((pos_y_s <= reg_raq1_s -21) AND (pos_y_s >= reg_raq1_s -35))THEN
   perdiod <= '0';
   perdioi <= '0';
   sgra1_upd <= '1';
   sgra1_upi <= '0';      
   sgra1_dwi <= '0';   
   sgra1_dwd <= '0';   
   sgra2_upi <= '0';   
   sgra2_upd <= '0';   
   sgra2_dwi <= '0';  
   sgra2_dwd <= '0';  
   sgra3_i  <= '0';   
   sgra3_d   <= '0';
  ELSIF ((pos_y_s >= reg_raq1_s + 5) AND (pos_y_s <= reg_raq1_s +20))THEN
   perdiod <= '0';
   perdioi <= '0';
   sgra2_dwd <= '1';
   sgra1_upi <= '0';   
   sgra1_upd <= '0';   
   sgra1_dwi <= '0';   
   sgra1_dwd <= '0';   
   sgra2_upi <= '0';   
   sgra2_upd <= '0';   
   sgra2_dwi <= '0';    
   sgra3_i  <= '0';   
   sgra3_d   <= '0';
  ELSIF ((pos_y_s >= reg_raq1_s +21) AND (pos_y_s <= reg_raq1_s +35))THEN
   perdiod <= '0';
   perdioi <= '0';
   sgra1_dwd <= '1';
   sgra1_upi <= '0';   
   sgra1_upd <= '0';   
   sgra1_dwi <= '0';     
   sgra2_upi <= '0';   
   sgra2_upd <= '0';   
   sgra2_dwi <= '0';  
   sgra2_dwd <= '0';  
   sgra3_i  <= '0';   
   sgra3_d   <= '0';
  END IF;
  
 ELSIF (pos_x_s + 7 >= 1231)THEN
  IF ((pos_y_s >= reg_raq2_s -5) AND (pos_y_s <= reg_raq2_s +4))THEN
   perdiod <= '0';
   perdioi <= '0';
   sgra3_i <= '1';
   sgra1_upi <= '0';   
   sgra1_upd <= '0';   
   sgra1_dwi <= '0';   
   sgra1_dwd <= '0';   
   sgra2_upi <= '0';   
   sgra2_upd <= '0';   
   sgra2_dwi <= '0';  
   sgra2_dwd <= '0';     
   sgra3_d   <= '0';
  ELSIF ((pos_y_s <= reg_raq2_s -6) AND (pos_y_s >= reg_raq2_s -20))THEN
   perdiod <= '0';
   perdioi <= '0';
   sgra2_upi <= '1';
   sgra1_upi <= '0';   
   sgra1_upd <= '0';   
   sgra1_dwi <= '0';   
   sgra1_dwd <= '0';    
   sgra2_upd <= '0';   
   sgra2_dwi <= '0';  
   sgra2_dwd <= '0';  
   sgra3_i  <= '0';   
   sgra3_d   <= '0';
  ELSIF ((pos_y_s <= reg_raq2_s -21) AND (pos_y_s >= reg_raq2_s -35))THEN
   perdiod <= '0';
   perdioi <= '0';
   sgra1_upi <= '1';  
   sgra1_upd <= '0';   
   sgra1_dwi <= '0';   
   sgra1_dwd <= '0';   
   sgra2_upi <= '0';   
   sgra2_upd <= '0';   
   sgra2_dwi <= '0';  
   sgra2_dwd <= '0';  
   sgra3_i  <= '0';   
   sgra3_d   <= '0';
  ELSIF ((pos_y_s >= reg_raq2_s + 5) AND (pos_y_s <= reg_raq2_s +20))THEN
   perdiod <= '0';
   perdioi <= '0';
   sgra2_dwi <= '1';
   sgra1_upi <= '0';   
   sgra1_upd <= '0';   
   sgra1_dwi <= '0';   
   sgra1_dwd <= '0';   
   sgra2_upi <= '0';   
   sgra2_upd <= '0';   
   sgra2_dwd <= '0';  
   sgra3_i  <= '0';   
   sgra3_d   <= '0';
  ELSIF ((pos_y_s >= reg_raq2_s +21) AND (pos_y_s <= reg_raq2_s +35))THEN
   perdiod <= '0';
   perdioi <= '0';
   sgra1_dwi <= '1';
   sgra1_upi <= '0';   
   sgra1_upd <= '0';      
   sgra1_dwd <= '0';   
   sgra2_upi <= '0';   
   sgra2_upd <= '0';   
   sgra2_dwi <= '0';  
   sgra2_dwd <= '0';  
   sgra3_i  <= '0';   
   sgra3_d   <= '0';
  END IF;
 
 ELSIF (gra1_dwd = '1')THEN 
perdiod <= '0';
perdioi <= '0';
sgra1_dwd <= '1';
sgra1_upi <= '0';   
sgra1_upd <= '0';   
sgra1_dwi <= '0';   
sgra1_dwd <= '0';   
sgra2_upi <= '0';   
sgra2_upd <= '0';   
sgra2_dwi <= '0';    
sgra3_i  <= '0';   
sgra3_d   <= '0';
 ELSIF (gra1_dwi = '1')THEN
perdiod <= '0';
perdioi <= '0';
sgra1_dwi <= '1';
sgra1_upi <= '0';   
sgra1_upd <= '0';      
sgra1_dwd <= '0';   
sgra2_upi <= '0';   
sgra2_upd <= '0';   
sgra2_dwi <= '0';  
sgra2_dwd <= '0';  
sgra3_i  <= '0';   
sgra3_d   <= '0';
 ELSIF (gra1_upd = '1')THEN
perdiod <= '0';
perdioi <= '0';
sgra1_upd <= '1';
sgra1_upi <= '0';      
sgra1_dwi <= '0';   
sgra1_dwd <= '0';   
sgra2_upi <= '0';   
sgra2_upd <= '0';   
sgra2_dwi <= '0';  
sgra2_dwd <= '0';  
sgra3_i  <= '0';   
sgra3_d   <= '0';
 ELSIF (gra1_upi = '1')THEN
perdiod <= '0';
perdioi <= '0';
sgra1_upi <= '1'; 
sgra1_upd <= '0';   
sgra1_dwi <= '0';   
sgra1_dwd <= '0';   
sgra2_upi <= '0';   
sgra2_upd <= '0';   
sgra2_dwi <= '0';  
sgra2_dwd <= '0';  
sgra3_i  <= '0';   
sgra3_d   <= '0';
 ELSIF (gra2_dwd = '1')THEN
perdiod <= '0';
perdioi <= '0';
sgra2_dwd <= '1';
sgra1_upi <= '0';   
sgra1_upd <= '0';   
sgra1_dwi <= '0';   
sgra1_dwd <= '0';   
sgra2_upi <= '0';   
sgra2_upd <= '0';   
sgra2_dwi <= '0';    
sgra3_i  <= '0';   
sgra3_d   <= '0'; 
 ELSIF (gra2_dwi = '1')THEN
perdiod <= '0';
perdioi <= '0';
sgra2_dwi <= '1';
sgra1_upi <= '0';   
sgra1_upd <= '0';   
sgra1_dwi <= '0';   
sgra1_dwd <= '0';   
sgra2_upi <= '0';   
sgra2_upd <= '0';   
sgra2_dwd <= '0';  
sgra3_i  <= '0';   
sgra3_d   <= '0';

 ELSIF (gra2_upd = '1')THEN
perdiod <= '0';
perdioi <= '0';
sgra2_upd <= '1';
sgra1_upi <= '0';   
sgra1_upd <= '0';   
sgra1_dwi <= '0';   
sgra1_dwd <= '0';   
sgra2_upi <= '0';      
sgra2_dwi <= '0';  
sgra2_dwd <= '0';  
sgra3_i  <= '0';   
sgra3_d   <= '0';
 ELSIF (gra2_upi = '1')THEN
perdiod <= '0';
perdioi <= '0';
sgra2_upi <= '1';
sgra1_upi <= '0';   
sgra1_upd <= '0';   
sgra1_dwi <= '0';   
sgra1_dwd <= '0';    
sgra2_upd <= '0';   
sgra2_dwi <= '0';  
sgra2_dwd <= '0';  
sgra3_i  <= '0';   
sgra3_d   <= '0'; 
 ELSIF (gra3_d = '1')THEN
perdiod <= '0';
perdioi <= '0';
sgra3_d <= '1';
sgra1_upi <= '0';   
sgra1_upd <= '0';   
sgra1_dwi <= '0';   
sgra1_dwd <= '0';   
sgra2_upi <= '0';   
sgra2_upd <= '0';   
sgra2_dwi <= '0';  
sgra2_dwd <= '0';  
sgra3_i  <= '0';   
sgra3_d   <= '0'; 
 ELSIF (gra3_i = '1')THEN
perdiod <= '0';
perdioi <= '0';
sgra3_i <= '1';
sgra1_upi <= '0';   
sgra1_upd <= '0';   
sgra1_dwi <= '0';   
sgra1_dwd <= '0';   
sgra2_upi <= '0';   
sgra2_upd <= '0';   
sgra2_dwi <= '0';  
sgra2_dwd <= '0';     
sgra3_d   <= '0';

END IF;



END IF;
END IF;

END PROCESS;

END ARCHITECTURE fsm;
