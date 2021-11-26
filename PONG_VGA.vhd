LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
----------------------------------------------------------------
ENTITY PONG_VGA IS
	PORT	(	clk			:	IN		STD_LOGIC;
				reset			:	IN    STD_LOGIC;
				clock1		:	OUT   STD_LOGIC;
				clock2		:	OUT 	STD_LOGIC;
				hsync			:	OUT	STD_LOGIC;
				vsync			:	OUT	STD_LOGIC;
				en_pelota   :  IN STD_LOGIC;
				R_VECTOR   	:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
				G_VECTOR		:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
				B_VECTOR		:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
				pulsa_1		:	IN 	STD_LOGIC;
				pulsa_2		:  IN 	STD_LOGIC;
				led_1        :	OUT	STD_LOGIC;
				led_2,led3 			:	OUT	STD_LOGIC;
				bits1				:   IN STD_LOGIC_vector (2 DOWNTO 0);
				bits2				:   IN STD_LOGIC_vector (2 DOWNTO 0);
				siete1,siete2,siete3,siete4			:  OUT  STD_LOGIC_VECTOR (7 DOWNTO 0)
				);
				
END ENTITY PONG_VGA;
----------------------------------------------------------------
ARCHITECTURE functional OF PONG_VGA IS	
		SIGNAL	bandera_j1,bandera_j2,bandera_j11	              :	STD_LOGIC_VECTOR(4 DOWNTO 0);
		SIGNAL	bandera_puntos				              :	STD_LOGIC_VECTOR(5 DOWNTO 0);
		SIGNAL   clea,clea1,clea2,clea3,velocidad_pelota                      :   STD_LOGIC;
		SIGNAL	h_cuenta_s,regxp_s,en_regxp_s	              :	STD_LOGIC_VECTOR(10 DOWNTO 0);
		SIGNAL	counter,counter2,counter_definitivo                   :	STD_LOGIC_VECTOR(29 DOWNTO 0);
		SIGNAL	hsync_s,reset_s1,reset_s2,actual_S1,actual_s2  :	STD_LOGIC;
		SIGNAL	v_cuenta_s,pos_reg1,pos_reg2, pos_actual_s_1,pos_actual_s_2,regyp_s,en_regyp_s	:	STD_LOGIC_VECTOR(9 DOWNTO 0);
		SIGNAL	vsync_s,ena_reg_s1,ena_reg_s2		     :	STD_LOGIC;
		SIGNAL	blank_s		              :	STD_LOGIC;	
		SIGNAL	R_s			              :	STD_LOGIC;
		SIGNAL	G_s,max,min,max1,min1,perdio_ss			        :	STD_LOGIC;	
		SIGNAL	B_s,E_Abajo_s1,E_Arriba_s1,E_Abajo_s2,E_Arriba_s2  :	STD_LOGIC;
		SIGNAL res_pel_s   			:	 	STD_LOGIC;
		SIGNAL		gra1_upi_s				:     STD_LOGIC;	
		SIGNAL		gra1_upd_s				:     STD_LOGIC;
		SIGNAL		gra1_dwi_s				:     STD_LOGIC;
		SIGNAL		gra1_dwd_s				:     STD_LOGIC;
		SIGNAL		gra2_upi_s				:     STD_LOGIC;			
		SIGNAL		gra2_upd_s				:     STD_LOGIC;
		SIGNAL		gra2_dwi_s				:     STD_LOGIC;
		SIGNAL		gra2_dwd_s				:     STD_LOGIC;
		SIGNAL		gra3_i_s 				:     STD_LOGIC;
		SIGNAL		gra3_d_s 				:     STD_LOGIC;
		SIGNAL		sgra1_upi_s         :			STD_LOGIC;			
		SIGNAL		sgra1_upd_s         :			STD_LOGIC;	
		SIGNAL		sgra1_dwi_s         :			STD_LOGIC;	
		SIGNAL		sgra1_dwd_s         :			STD_LOGIC;	
		SIGNAL		sgra2_upi_s         :			STD_LOGIC;				
		SIGNAL		sgra2_upd_s         :			STD_LOGIC;	
		SIGNAL		sgra2_dwi_s         :			STD_LOGIC;	
		SIGNAL		sgra2_dwd_s         :			STD_LOGIC;	
		SIGNAL		sgra3_i_s          	:			STD_LOGIC;	
		SIGNAL		sgra3_d_s,arriba_raq1,arriba_raq2,abajo_raq1,abajo_raq2           :			STD_LOGIC;	
		SIGNAL		perdio_s,perdioi_s,perdiod_s,en_cont_s            :			STD_LOGIC;
		SIGNAL      EN_reg_pel,en_vel_1s,en_vel_2s,en_vel_3s,LED3S					:		STD_LOGIC;
		SIGNAL      led_g1s,led_g2s,en_pelota_s,gano_1s,gano_1ss,gano_2s,bandera_2s,bandera_3s,bandera_4s,res_pelota_s  : STD_LOGIC;

BEGIN 

	Contador_horizontal: ENTITY WORK.contador_horizontal
			   PORT MAP(	clk50MHz		=> clk,
								reset 		=> not reset,
								h_cuenta		=> h_cuenta_s);			


	Generador_horizontal: ENTITY WORK.generador_hsync
			   PORT MAP(	clk50MHz		=> clk,
								reset 		=> not reset,
								h_cuenta    => h_cuenta_s,
								hsync			=> hsync_s);
								
	
	Contador_vertical: ENTITY WORK.contador_vertical
			   PORT MAP(	clk50MHz		=> clk,
								reset 		=> not reset,
								hsync		   => hsync_s,
								v_cuenta		=> v_cuenta_s);
								
	Generador_vertical: ENTITY WORK.generador_vsync
			   PORT MAP(	clk50MHz		=> clk,
								reset 		=> not reset,
								v_cuenta    => v_cuenta_s,
								vsync			=> vsync_s);
					
				
	Generador_blank: ENTITY WORK.generador_blank
			   PORT MAP(	hctr		   => h_cuenta_s,
								vctr		   => v_cuenta_s,
								blank			=>	blank_s);
								
	Generador_imagen: ENTITY WORK.image_generator
			   PORT MAP(	clk50MHz		=> clk,
								reset 		=> not reset,
								hctr			=> h_cuenta_s,
								vctr			=> v_cuenta_s,
								blank			=>	blank_s,
								pos_regxp   => regxp_s,
								pos_regyp   => regyp_s,
								pos_reg_1   => pos_reg1,
								pos_reg_2   => pos_reg2,
								R				=> R_s,
								G				=> G_s,
								B				=> B_S);
								
	controll: ENTITY WORK.control_raq_1
			   PORT MAP(	clk				=> clk,
								rst 				=> not reset,
								Arriba			=> arriba_raq1,
								Abajo				=>  abajo_raq1,
								E_Arriba			=>	E_Arriba_s1,
								E_Abajo     	=> E_Abajo_s1,
								reset_R        => reset_s1,
								ena_reg			=> ena_reg_s1,
								actual	      => actual_S1  );
arriba_raq1<=    bits2(0);
abajo_raq1 <=    bits2(2);

arriba_raq2<=    bits1(2);
abajo_raq2 <=    bits1(0);
clock1<=clk;
clock1<=clk;


						
	
								
		contro22: ENTITY WORK.control_raq_2
			   PORT MAP(	clk				=> clk,
								rst 				=> not reset,
								Arriba			=> arriba_raq2 ,
								Abajo				=> abajo_raq2,
								E_Arriba			=>	E_Arriba_s2,
								E_Abajo     	=> E_Abajo_s2,
								reset_R        => reset_s2,
								ena_reg			=> ena_reg_s2,
								actual	      => actual_S2  );
								
								
	posicionn: ENTITY WORK.Posicion_raq_1
			   PORT MAP(	
								ACTUAL			=> Actual_S1	,
								CLK 				=> clEA,	
								Pos_Pre			=> pos_reg1,
								E_Arriba 		=> E_Arriba_s1,
								E_Abajo			=> E_Abajo_s1,
								Pos_actual		=> pos_actual_s_1);
					
	posicionn2: ENTITY WORK.Posicion_raq_2
			   PORT MAP(	
								ACTUAL			=> Actual_S2	,
								CLK 				=> clEA,	
								Pos_Pre			=> pos_reg2,
								E_Arriba 		=> E_Arriba_s2,
								E_Abajo			=> E_Abajo_s2,
								Pos_actual		=> pos_actual_s_2);
	
	posicion_pelota :ENTITY work.posicion_pelota
		PORT MAP(
				clk			=> velocidad_pelota,
				res_pel   	=> res_pel_s ,
				gra1_upi		=> gra1_upi_s ,	
				gra1_upd			=> gra1_upd_s  ,
				gra1_dwi			=> gra1_dwi_s,
				gra1_dwd			=> gra1_dwd_s,
				gra2_upi			=>	gra2_upi_s,		
				gra2_upd			=> gra2_upd_s,
				gra2_dwi			=> gra2_dwi_s,
				gra2_dwd			=> gra2_dwd_s,
				gra3_i 			=> gra3_i_s,
				gra3_d 			=> gra3_d_s,
				posx_pre			=> regxp_s,
				posy_pre			=> regyp_s,
				posx_actual 			=> en_regxp_s,
				posy_actual 			=> en_regyp_s,
				perdio               => perdio_s, 
			   perdio_s             => perdio_ss	);
	
	
	registroo: ENTITY WORK.registro_raq_1
			   PORT MAP(	clk		=> clk,
								rst 		=> reset_s1,
								ena     	=> ena_reg_s1, 
								d			=> pos_actual_s_1,
								q			=> pos_reg1);		
								
	registroo2: ENTITY WORK.registro_raq_2
			   PORT MAP(	clk		=> clk,
								rst 		=> reset_s2,
								ena     	=> ena_reg_s2, 
								d			=> pos_actual_s_2,
								q			=> pos_reg2);	
-------------------
	registropx: ENTITY WORK.registro_pely
			   PORT MAP(	clk		=> velocidad_pelota,
								rst 		=> res_pel_s,
								ena     	=> EN_reg_pel, 
								d			=> en_regyp_s,
								q			=> regyp_s);		
								
	registropy: ENTITY WORK.registro_pelx
			   PORT MAP(	clk		=> velocidad_pelota,
								rst 		=> res_pel_s,
								ena     	=> EN_reg_pel, 
								d			=> en_regxp_s,
								q			=> regxp_s);
								
---------------------------------------------------------



clea <= 	   counter(20) and NOT counter (19) and not counter(18) and counter (17) and 
			not counter(16) and NOT counter (15) and not counter(14) and counter (13) and not counter(12) and counter (11) and 
			not counter(10) and NOT counter (9) and NOT counter(8) and not  counter (7) and counter(6) and not counter (5) and 
			not counter(4) and not counter (3) and not  counter(2) and not counter(1) and	not counter(0);
			
clea1 <=        counter2 (19) and  NOT  counter2(18) and not counter2 (17) and 
			not counter2(16) and NOT counter2 (15) and  NOT counter2(14) and counter2 (13) and  counter2(12) and counter2 (11) and 
			not counter2(10) and NOT  counter2 (9) and NOT counter2(8) and not  counter2 (7) and counter2(6) and counter2 (5) and 
			not  counter2(4) and  NOT counter2 (3) and   NOT counter2(2) and not counter2(1) and	 counter2(0);
clea2 <=   not      counter2(18) and counter2 (17) and 
			    counter2(16) and counter2 (15) and  counter2(14) and counter2 (13) and  counter2(12) and counter2 (11) and 
			   counter2(10) and counter2 (9) and counter2(8) and   counter2 (7) and counter2(6) and counter2 (5) and 
			   counter2(4) and  counter2 (3) and   counter2(2) and  counter2(1) and	 counter2(0);
clea3 <=     counter2 (17) and 
			 counter2(16) and not counter2 (15) and not  counter2(14) and  not counter2 (13) and  counter2(12) and counter2 (11) and 
			 counter2(10) and counter2 (9) and counter2(8) and not  counter2 (7) and counter2(6) and counter2 (5) and 
			 counter2(4) and  counter2 (3) and   counter2(2) and not counter2(1) and	 counter2(0);			 
			 
velocidad_pelota <= (clea1 and en_vel_1s ) or (clea2 and en_vel_2s) or (clea3 and en_vel_3s);			 
			 
	contador:ENTITY work.dec_segundos
		PORT MAP(
				clk			=> clk,
				rst			=> clea ,
				ena			=> '1',
				syn_clr		=> '0',
				load			=> '0',
				up				=> '1',
				d			 	=> "000000000000000000000000000000",
				max_tick	 	=> max,
				min_tick	 	=> min,
				counter	 	=> counter);	
	contador_pel :ENTITY work.dec_segundos
		PORT MAP(
				clk			=> clk,
				rst			=> velocidad_pelota ,
				ena			=> '1',
				syn_clr		=> '0',
				load			=> '0',
				up				=> '1',
				d			 	=> "000000000000000000000000000000",
				max_tick	 	=> max1,
				min_tick	 	=> min1,
				counter	 	=> counter2);
				
				
				
				
				
				
					contador_definitivo :ENTITY work.dec_segundos
		PORT MAP(
				clk			=> clk,
				rst			=> not reset ,
				ena			=> perdioi_s,
				syn_clr		=> '0',
				load			=> '0',
				up				=> '1',
				d			 	=> "000000000000000000000000000000",
				max_tick	 	=> max1,
				min_tick	 	=> min1,
				counter	 	=> counter_definitivo);
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				

		cont_jug11 :ENTITY work.con_jug1
		PORT MAP(
				clk			=> velocidad_pelota,
				rst			=> gano_1s ,
				ena			=> perdioi_s,
				syn_clr		=> '0',
				up				=> '1',
				counter	 	=> bandera_j1);
		cont_jug111 :ENTITY work.con_jug1
		PORT MAP(
				clk			=> velocidad_pelota,
				rst			=> gano_1ss ,
				ena			=> perdioi_s,
				syn_clr		=> '0',
				up				=> '1',
				counter	 	=> bandera_j11);				

	   	cont_jug22 :ENTITY work.con_jug1
		PORT MAP(
				clk			=> velocidad_pelota,
				rst			=> gano_2s,
				ena			=> perdiod_s,
				syn_clr		=> '0',
				up				=> '1',
	 			counter	 	=> bandera_j2);		
    				
contador_puntos :ENTITY work.con_puntos
		PORT MAP(
				clk			=> velocidad_pelota,
				rst			=> bandera_4s,
				ena			=> perdio_S,
				syn_clr		=> '0',
				up				=> '1',
	 			counter	 	=> bandera_puntos);		
    				
				
	control_pelotaa :ENTITY work.control_pelota
		PORT MAP(
				clk			=> velocidad_pelota,
				rst			=> res_pelota_s ,
				res_pel   	=> res_pel_s ,
				gra1_upi		=> gra1_upi_s ,	
				gra1_upd			=> gra1_upd_s  ,
				gra1_dwi			=> gra1_dwi_s,
				gra1_dwd			=> gra1_dwd_s,
				gra2_upi			=>	gra2_upi_s,		
				gra2_upd			=> gra2_upd_s,
				gra2_dwi			=> gra2_dwi_s,
				gra2_dwd			=> gra2_dwd_s,
				gra3_i 			=> gra3_i_s,
				gra3_d 			=> gra3_d_s,
				sgra1_upi      =>	sgra1_upi_s,		
				sgra1_upd      =>	sgra1_upd_s,
				sgra1_dwi      => sgra1_dwi_s,	
				sgra1_dwd      => sgra1_dwd_s,	
				sgra2_upi      => sgra2_upi_s,				
				sgra2_upd      => sgra2_upd_s,	
				sgra2_dwi      => sgra2_dwi_s,	
				sgra2_dwd      => sgra2_dwd_s,
				sgra3_i        => sgra3_i_s,	
				sgra3_d        => sgra3_d_s,
				perdio         => perdio_s,
				en_pelota		=> en_pelota_s,
				en_registro    => EN_reg_pel,
				en_cont			=> en_cont_s	);
	
comparador_pelotaa :ENTITY work.comparador_pelota
		PORT MAP(
				clk			=> velocidad_pelota,
				pos_x			=>  regxp_s,
				pos_y			=>  regyp_s,
				gra1_upi		=> gra1_upi_s ,	
				gra1_upd			=> gra1_upd_s  ,
				gra1_dwi			=> gra1_dwi_s,
				gra1_dwd			=> gra1_dwd_s,
				gra2_upi			=>	gra2_upi_s,		
				gra2_upd			=> gra2_upd_s,
				gra2_dwi			=> gra2_dwi_s,
				gra2_dwd			=> gra2_dwd_s,
				gra3_i 			=> gra3_i_s,
				gra3_d 			=> gra3_d_s,
				reg_raq1       => pos_reg1,
				reg_raq2       => pos_reg2,
				sgra1_upi      =>	sgra1_upi_s,		
				sgra1_upd      =>	sgra1_upd_s,
				sgra1_dwi      => sgra1_dwi_s,	
				sgra1_dwd      => sgra1_dwd_s,	
				sgra2_upi      => sgra2_upi_s,				
				sgra2_upd      => sgra2_upd_s,	
				sgra2_dwi      => sgra2_dwi_s,	
				sgra2_dwd      => sgra2_dwd_s,
				sgra3_i        => sgra3_i_s,	
				sgra3_d        => sgra3_d_s,
				perdioi         => perdioi_s,
				perdiod         => perdiod_s,
			   resetcontrol    => res_pel_s	);	
				
				
control_juegoo :ENTITY work.control_juego
		PORT MAP(
				clk					=> clk,
				rst					=> NOT reset,
				pul_1					=> NOT pulsa_1,
				pul_2					=> NOT pulsa_2,
				bandera_2			=> bandera_2s,
				bandera_3			=> bandera_3s,
				gano_1            => gano_1s,
				gano_2				=> gano_2s,
				En_vel_1				=> En_vel_1s,
				En_vel_2				=> En_vel_2s,
				En_vel_3    		=> En_vel_3s,
				res_pelota			=> res_pelota_s,
				led_G1            => led_g1s,
				led_G2				=> led_g2s,
				en_pelota			=> en_pelota_s,
				LED3					=> LED3S 
	);				
led_1 <= led_g1s;
led_2 <= led_g2s;
led3 <=LED3S;
bandera_4s <=   bandera_puntos (5) and  bandera_puntos (4) and   bandera_puntos (3) and  bandera_puntos (2) and   bandera_puntos (1) and  bandera_puntos (0);	
gano_1ss  <=   bandera_j11(4) and bandera_j11(3) and  bandera_j11(2) and   bandera_j11(1) and  not  bandera_j11(0) ;

perdio_S <= perdioi_s or perdiod_s;
	
hsync <= hsync_s;
vsync <= vsync_s;

R_VECTOR(0)<=R_s;
R_VECTOR(1)<=R_s;		
R_VECTOR(2)<=R_s;		
R_VECTOR(3)<=R_s;				

G_VECTOR(0)<=G_s;
G_VECTOR(1)<=G_s;		
G_VECTOR(2)<=G_s;		
G_VECTOR(3)<=G_s;				

B_VECTOR(0)<=B_s;
B_VECTOR(1)<=B_s;		
B_VECTOR(2)<=B_s;		
B_VECTOR(3)<=B_s;				
	
--
--WITH  bits2 SELECT
--  arriba_raq2 <=  '0'     WHEN "00000000" ,
--				 '1'      WHEN "11111111" ,				 
--		       '0'		 WHEN OTHERS ;	
--WITH  bits2 SELECT
--  abajo_raq2 <=  '0'     WHEN "11111111" ,
--				 '1'      WHEN "00000000" ,				 
--		       '0'		 WHEN OTHERS ;	
--WITH  bits1 SELECT
--  arriba_raq1 <=  '0'     WHEN "0000" ,
--				 '1'      WHEN "1111" ,				 
--		       '0'		 WHEN OTHERS ;	
--WITH  bits1 SELECT
--  abajo_raq1 <=  '0'     WHEN "1111" ,
--				 '1'      WHEN "0000" ,				 
--		       '0'		 WHEN OTHERS ;					 
--


WITH  bandera_j2 SELECT
  gano_1s <=  '0'     WHEN "00000" ,
				 '0'      WHEN "00001" ,
		       '0'      WHEN "00010" ,
				 '0'      WHEN "00011" ,
				 '0'      WHEN "00100" ,
		       '0'      WHEN "00101" ,
				 '0'      WHEN "00110" ,
		       '0'      WHEN "01111" ,
				 '1'      WHEN "11110" ,
				 '1'      WHEN "11111" ,				 
		       '0'		 WHEN OTHERS ;	



WITH  bandera_j1 SELECT
  gano_2s <=  '0'     WHEN "00000" ,
				 '0'      WHEN "00001" ,
		       '0'      WHEN "00010" ,
				 '0'      WHEN "00011" ,
				 '0'      WHEN "00100" ,
		       '0'      WHEN "00101" ,
				 '0'      WHEN "00110" ,
		       '0'      WHEN "01111" ,
				 '1'      WHEN "11110" ,
				 '1'      WHEN "11111" ,				 
		       '0'		 WHEN OTHERS ;	





WITH  bandera_puntos SELECT
  bandera_2s <=  '0'     WHEN "000000" ,
				 '0'      WHEN "000001" ,
		       '0'      WHEN "000010" ,
				 '0'      WHEN "000011" ,
				 '0'      WHEN "000100" ,
		       '0'      WHEN "000101" ,
				 '0'      WHEN "000110" ,
		       '0'      WHEN "001111" ,
				 '0'      WHEN "011110" ,
				 '1'      WHEN "010000" ,				 
		       '0'		 WHEN OTHERS ;	


WITH  bandera_puntos SELECT
  bandera_3s <=  '0'     WHEN "000000" ,
				 '0'      WHEN "000001" ,
		       '0'      WHEN "000010" ,
				 '0'      WHEN "000011" ,
				 '0'      WHEN "000100" ,
		       '0'      WHEN "000101" ,
				 '0'      WHEN "000110" ,
		       '0'      WHEN "001111" ,
				 '0'      WHEN "011110" ,
				 '1'      WHEN "100100" ,				 
		       '0'		 WHEN OTHERS ;	



WITH  bandera_J1 SELECT
  siete1 <= "01000000"      WHEN "00000" ,
				"01000000"      WHEN "00001" ,
				"01000000"      WHEN "00010" ,
			
			
				 "01111001"      WHEN "00011" ,
				 "01111001"      WHEN "00100" ,
				 "01111001"      WHEN "00101" ,
				 
				 
		       "00100100"      WHEN "00110" ,
		       "00100100"      WHEN "00111" ,
		       "00100100"      WHEN "01000" ,

				 
				 "00110000"      WHEN "01001" ,
				 "00110000"      WHEN "01010" ,
				 "00110000"      WHEN "01011" ,


				 
				 "00011001"      WHEN "01100" ,
				 "00011001"      WHEN "01101" ,
				 "00011001"      WHEN "01110" ,
				 
				 "00010010"      WHEN "01111" ,
				 "00010010"      WHEN "10000" ,
				 "00010010"      WHEN "10001" ,
				 
				 "00000010"      WHEN "10010" ,
				 "00000010"      WHEN "10011" ,
				 "00000010"      WHEN "10100" ,

		       
				 "01111000"      WHEN "10101" ,
				 "01111000"      WHEN "10110" ,
				 "01111000"      WHEN "10111" ,		
			
			
				 "00000000"      WHEN "11000" ,
				 "00000000"      WHEN "11001" ,
				 "00000000"      WHEN "11010" ,
				 
				 "00011000"      WHEN "11011" ,
				 "00011000"      WHEN "11100" ,				 
				 "00011000"      WHEN "11101" ,				 
				 
				 "01000000"      WHEN "11110" ,			 
				 "01000000"      WHEN "11111" ,					       
										 
				 
				 
				 "00000000" WHEN OTHERS ;

WITH  bandera_J1 SELECT
  siete2 <= 
				
				 
		       "11111001"      WHEN "01010" ,

				 
				
				 
				 "11000000" WHEN OTHERS ;
WITH  bandera_J2 SELECT
  siete4 <= 
				
				 
		       "11111001"      WHEN "01010" ,
				 
				
				 
				  "11000000" WHEN OTHERS ;
				 
				 
				 WITH  bandera_J2 SELECT
  siete3 <= "01000000"      WHEN "00000" ,
				"01000000"      WHEN "00001" ,
				"01000000"      WHEN "00010" ,
			
			
				 "01111001"      WHEN "00011" ,
				 "01111001"      WHEN "00100" ,
				 "01111001"      WHEN "00101" ,
				 
				 
		       "00100100"      WHEN "00110" ,
		       "00100100"      WHEN "00111" ,
		       "00100100"      WHEN "01000" ,

				 
				 "00110000"      WHEN "01001" ,
				 "00110000"      WHEN "01010" ,
				 "00110000"      WHEN "01011" ,


				 
				 "00011001"      WHEN "01100" ,
				 "00011001"      WHEN "01101" ,
				 "00011001"      WHEN "01110" ,
				 
				 "00010010"      WHEN "01111" ,
				 "00010010"      WHEN "10000" ,
				 "00010010"      WHEN "10001" ,
				 
				 "00000010"      WHEN "10010" ,
				 "00000010"      WHEN "10011" ,
				 "00000010"      WHEN "10100" ,

		       
				 "01111000"      WHEN "10101" ,
				 "01111000"      WHEN "10110" ,
				 "01111000"      WHEN "10111" ,		
			
			
				 "00000000"      WHEN "11000" ,
				 "00000000"      WHEN "11001" ,
				 "00000000"      WHEN "11010" ,
				 
				 "00011000"      WHEN "11011" ,
				 "00011000"      WHEN "11100" ,				 
				 "00011000"      WHEN "11101" ,				 
				 
				 "01000000"      WHEN "11110" ,			 
				 "01000000"      WHEN "11111" ,					       
										 
				 
				 
				 "00000000" WHEN OTHERS ;			

				 
				 
				 
					
END ARCHITECTURE functional;