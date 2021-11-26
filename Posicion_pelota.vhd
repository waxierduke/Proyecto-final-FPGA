----------------------------------------------------------------
library IEEE;
 use IEEE.STD_LOGIC_1164.ALL; 
 use IEEE.STD_LOGIC_ARITH.ALL; 
 use IEEE.NUMERIC_STD.ALL;
 use IEEE.STD_LOGIC_UNSIGNED.ALL; 
----------------------------------------------------------------
ENTITY  Posicion_pelota IS
	PORT	(	clk					:	IN		STD_LOGIC;
				res_pel 				:	IN		STD_LOGIC;
				gra1_upi				:	IN		STD_LOGIC;
				gra1_upd				:	IN		STD_LOGIC;
				gra1_dwi				:	IN		STD_LOGIC;
				gra1_dwd				:	IN		STD_LOGIC;
				gra2_upi				:	IN		STD_LOGIC;
				gra2_upd				:	IN		STD_LOGIC;
				gra2_dwi				:	IN		STD_LOGIC;
				gra2_dwd				:	IN		STD_LOGIC;
				gra3_i				:	IN		STD_LOGIC;
				gra3_d				:	IN		STD_LOGIC;
				posx_pre				:	IN		STD_LOGIC_VECTOR(10 DOWNTO 0);
				posy_pre				:	IN		STD_LOGIC_VECTOR(9 DOWNTO 0);
				posx_actual			:	OUT	STD_LOGIC_VECTOR(10 DOWNTO 0);
				posy_actual			:	OUT	STD_LOGIC_VECTOR(9 DOWNTO 0);
				perdio            :  IN STD_LOGIC;
				perdio_s            :  OUT   STD_LOGIC);
				END ENTITY Posicion_pelota;
----------------------------------------------------------------
ARCHITECTURE fsm OF Posicion_pelota IS
	
	
 signal posy_pre_s : integer range 524 downto 0; 
 signal posy_actual_s : integer range 524 downto 0; 
 signal posx_pre_s : integer range 1586 downto 0; 
 signal posx_actual_s : integer range 1586 downto 0; 
 begin 

 posx_pre_s <= CONV_INTEGER (posx_pre); 
 posy_pre_s <= CONV_INTEGER (posy_pre); 
PROCESS (clk,gra1_upi,gra1_upd,gra1_dwd,gra1_dwi,gra2_upi,gra2_upd,gra2_dwd,gra2_dwi,gra3_d,gra3_i)
BEGIN 

IF(rising_edge(clk)) THEN
	
	
	IF (res_pel = '1')THEN
	posy_actual_s <= 250;
	posx_actual_s <= 585;
		perdio_s <= '0';
ELSIF (perdio = '1')THEN 

		perdio_s <= '1';
ELSIF (gra3_i = '1')THEN
	posx_actual_s <= posx_pre_s - 4;
	posy_actual_s <= posy_pre_s;
	perdio_s <= '0';
ELSIF (gra3_d = '1')THEN
	posx_actual_s <= posx_pre_s + 4;
	posy_actual_s <= posy_pre_s;
	perdio_s <= '0';
ELSIF (gra1_upi = '1')THEN
	posx_actual_s <= posx_pre_s - 2;
	posy_actual_s <= posy_pre_s - 1;
	perdio_s <= '0';
ELSIF (gra1_upd = '1')THEN
	posx_actual_s <= posx_pre_s + 2;
	posy_actual_s <= posy_pre_s - 1;
	perdio_s <= '0';
ELSIF (gra1_dwi = '1')THEN
	posx_actual_s <= posx_pre_s - 2;
	posy_actual_s <= posy_pre_s + 1;
	perdio_s <= '0';
ELSIF (gra1_dwd = '1')THEN
	posx_actual_s <= posx_pre_s + 2;
	posy_actual_s <= posy_pre_s + 1;
	perdio_s <= '0';
ELSIF (gra2_upi = '1')THEN
	posx_actual_s <= posx_pre_s - 4;
	posy_actual_s <= posy_pre_s - 1;
	perdio_s <= '0';
ELSIF (gra2_upd = '1')THEN
	posx_actual_s <= posx_pre_s + 4;
	posy_actual_s <= posy_pre_s - 1;
	perdio_s <= '0';
ELSIF (gra2_dwi = '1')THEN
	posx_actual_s <= posx_pre_s - 4;
	posy_actual_s <= posy_pre_s + 1;
	perdio_s <= '0';
ELSIF (gra2_dwd = '1')THEN
	posx_actual_s <= posx_pre_s + 4;
	posy_actual_s <= posy_pre_s + 1;
	perdio_s <= '0';
ELSE
	posx_actual_s <= posx_pre_s; 
	posy_actual_s <= posy_pre_s+2;
   perdio_s <= '0';
	END IF;
END IF;
END PROCESS;

posy_actual <= STD_LOGIC_VECTOR(TO_UNSIGNED (Posy_actual_s, 10));
posx_actual <= STD_LOGIC_VECTOR(TO_UNSIGNED (Posx_actual_s, 11));

END ARCHITECTURE fsm;