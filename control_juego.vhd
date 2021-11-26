----------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------------------------
ENTITY  Control_juego IS
	PORT	(	clk					:	IN		STD_LOGIC;
				rst					:	IN		STD_LOGIC;
				pul_1					:	IN		STD_LOGIC;
				pul_2					:	IN		STD_LOGIC;
				bandera_2			:	IN		STD_LOGIC;
				bandera_3			:	IN		STD_LOGIC;
				gano_1            :	IN		STD_LOGIC;
				gano_2				:  IN		STD_LOGIC;
				En_vel_1				:	OUT   STD_LOGIC;
				En_vel_2				:	OUT	STD_LOGIC;
				En_vel_3    		: 	OUT 	STD_LOGIC;
				res_pelota			:	OUT   STD_LOGIC;
				led_G1            :  OUT	STD_LOGIC;
				led_G2				:	OUT   STD_LOGIC;
				en_pelota			:	OUT   STD_LOGIC;
				led3					:	OUT	STD_LOGIC
	);
END ENTITY Control_juego;
----------------------------------------------------------------
ARCHITECTURE fsm OF Control_juego IS
	TYPE state IS (s0,s1,s2,s3,S4,S5,S6,S7,S8);
	SIGNAL pr_state, next_state	:	state;
BEGIN
	sequential: PROCESS(rst, clk)
	BEGIN
		IF (rst = '1') THEN
			pr_state	<=	s0;
		ELSIF (rising_edge(clk)) THEN
			pr_state	<=	next_state;
		END IF;
	END PROCESS sequential;

	combinational: PROCESS(pr_state, pul_1,pul_2,bandera_3,bandera_2,gano_1,gano_2)
	BEGIN
		CASE pr_state IS
			
			WHEN s0	=>
							 
				En_vel_1				<= '0';
				En_vel_2				<= '0';
				En_vel_3    		<= '0';
				res_pelota			<= '1';
				led_G1            <= '0';
				led_G2				<= '0';
				en_pelota			<= '0';
				LED3               <= '0';
				IF (pul_1 ='1') THEN
		 
				 next_state <= s1; 
				
				ELSIF (pul_2 = '1') THEN
				
				 next_state <= s2; 
				
			   ELSE
				
				 next_state <= s0; 
				END IF;
			WHEN s1	=>
				LED3               <= '0';	 
				En_vel_1				<= '0';
				En_vel_2				<= '0';
				En_vel_3    		<= '0';
				res_pelota			<= '1';
				led_G1            <= '0';
				led_G2				<= '0';
				en_pelota			<= '0';
				
				IF (pul_2 ='1') THEN
		 
				 next_state <= s3; 
				
			   ELSE
				
				 next_state <= s1; 
				END IF;
		
	      	WHEN s2	=>
				LED3               <= '0';	 
				En_vel_1				<= '0';
				En_vel_2				<= '0';
				En_vel_3    		<= '0';
				res_pelota			<= '1';
				led_G1            <= '0';
				led_G2				<= '0';
				en_pelota			<= '0';
				
				IF (pul_1 ='1') THEN
		 
				 next_state <= s3; 
				
			   ELSE
				
				 next_state <= s2; 
				END IF;
				
				
					WHEN s3	=>
					 
				En_vel_1				<= '0';
				En_vel_2				<= '0';
				En_vel_3    		<= '0';
				res_pelota			<= '0';
				led_G1            <= '0';
				led_G2				<= '0';
				en_pelota			<= '1';
	         LED3               <= '0';	 
				 next_state <= s4; 
				
				
					WHEN s4	=>
					 
				En_vel_1				<= '1';
				En_vel_2				<= '0';
				En_vel_3    		<= '0';
				res_pelota			<= '0';
				led_G1            <= '1';
				led_G2				<= '1';
				en_pelota			<= '1';
				LED3               <= '1';
				IF (bandera_2 ='1') THEN
		 
				 next_state <= s5; 
				
			   ELSIF (gano_1 ='1') THEN
				
				 next_state <= s7; 
				ELSIF (gano_2 ='1') THEN
				
				 next_state <= s8; 
				ELSE
				  next_state <= s4; 
				END IF;
				
			   	WHEN s5	=>
					 
				En_vel_1				<= '0';
				En_vel_2				<= '1';
				En_vel_3    		<= '0';
				res_pelota			<= '0';
				led_G1            <= '1';
				led_G2				<= '0';
				en_pelota			<= '1';
				LED3               <= '0';
				IF (bandera_3 ='1') THEN
		 
				 next_state <= s6; 
				
			   ELSIF (gano_1 ='1') THEN
				
				 next_state <= s7; 
				ELSIF (gano_2 ='1') THEN
				
				 next_state <= s8; 
				ELSE
				  next_state <= s5; 
				END IF;
				
				WHEN s6	=>
					 
				En_vel_1				<= '0';
				En_vel_2				<= '0';
				En_vel_3    		<= '1';
				res_pelota			<= '0';
				led_G1            <= '0';
				led_G2				<= '1';
				en_pelota			<= '1';
				LED3               <= '0';
				IF (gano_1 ='1') THEN
		 
				 next_state <= s7; 
				
			   ELSIF  (gano_2 ='1') THEN
				
				 next_state <= s8; 
				ELSE
				
				 next_state <= s6;
				END IF;
				
				
				WHEN s7	=>
					 
				En_vel_1				<= '0';
				En_vel_2				<= '0';
				En_vel_3    		<= '0';
				res_pelota			<= '1';
				led_G1            <= '1';
				led_G2				<= '1';
				en_pelota			<= '0';
				LED3               <= '0';
				
				
		      WHEN s8	=>
				LED3               <= '0';	 
				En_vel_1				<= '0';
				En_vel_2				<= '0';
				En_vel_3    		<= '0';
				res_pelota			<= '1';
				led_G1            <= '1';
				led_G2				<= '1';
				en_pelota			<= '0';
				
				
				WHEN others	=>
				LED3               <= '0';	 
				En_vel_1				<= '0';
				En_vel_2				<= '0';
				En_vel_3    		<= '0';
				res_pelota			<= '0';
				led_G1            <= '0';
				led_G2				<= '0';
				en_pelota			<= '0';
				
				
				
		END CASE;
	END PROCESS combinational;
END ARCHITECTURE fsm;