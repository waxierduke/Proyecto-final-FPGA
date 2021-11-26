----------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------------------------
ENTITY  Control_pelota IS
	PORT	(	clk					:	IN		STD_LOGIC;
				rst					:	IN		STD_LOGIC;
				res_pel   			:	OUT 	STD_LOGIC;
				gra1_upi				:  OUT   STD_LOGIC;	
				gra1_upd				:  OUT   STD_LOGIC;
				gra1_dwi				:  OUT   STD_LOGIC;
				gra1_dwd				:  OUT   STD_LOGIC;
				gra2_upi				:  OUT   STD_LOGIC;			
				gra2_upd				:  OUT   STD_LOGIC;
				gra2_dwi				:  OUT   STD_LOGIC;
				gra2_dwd				:  OUT   STD_LOGIC;
				gra3_i 				:  OUT   STD_LOGIC;
				gra3_d 				:  OUT   STD_LOGIC;
				sgra1_upi         :	IN		STD_LOGIC;			
				sgra1_upd         :	IN		STD_LOGIC;	
				sgra1_dwi         :	IN		STD_LOGIC;	
				sgra1_dwd         :	IN		STD_LOGIC;	
				sgra2_upi         :	IN		STD_LOGIC;				
				sgra2_upd         :	IN		STD_LOGIC;	
				sgra2_dwi         :	IN		STD_LOGIC;	
				sgra2_dwd         :	IN		STD_LOGIC;	
				sgra3_i          	:	IN		STD_LOGIC;	
				sgra3_d           :	IN		STD_LOGIC;	
				perdio            :	IN		STD_LOGIC;
				en_pelota			:  IN 	STD_LOGIC;
				en_registro       :  OUT   STD_LOGIC;
				en_cont				:	OUT   STD_LOGIC
				
	);
END ENTITY Control_pelota;
----------------------------------------------------------------
ARCHITECTURE fsm OF Control_pelota IS
	TYPE state IS (s0,s00,s1, s2, s3, s4,s5,s6,s7,s8,s9,s10,s11);
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

	combinational: PROCESS(pr_state,sgra1_upi,sgra1_upd,sgra1_dwi,sgra1_dwd,sgra2_upi,sgra2_upd,sgra2_dwi,sgra2_dwd,sgra3_i ,sgra3_d,perdio,en_pelota)
	BEGIN
		CASE pr_state IS
			
			WHEN s00	=>

			   en_registro   		<= '0';
				res_pel   			<= '1';
  		 	   gra1_upi				<= '0';	
				gra1_upd				<= '0';
				gra1_dwi				<= '0';
				gra1_dwd				<= '0';
				gra2_upi				<= '0';			
				gra2_upd				<= '0';
				gra2_dwi				<= '0';
				gra2_dwd				<= '0';
				gra3_i 				<= '0';
				gra3_d 				<= '0';
				en_cont 				<= '0';
					 next_state <= s1;

			WHEN s0	=>

			   en_registro   		<= '0';
				res_pel   			<= '0';
  		 	   gra1_upi				<= '0';	
				gra1_upd				<= '0';
				gra1_dwi				<= '0';
				gra1_dwd				<= '0';
				gra2_upi				<= '0';			
				gra2_upd				<= '0';
				gra2_dwi				<= '0';
				gra2_dwd				<= '0';
				gra3_i 				<= '0';
				gra3_d 				<= '0';
				en_cont 				<= '1';
				
				 next_state <= s00; 
	
			
			WHEN s1	=>
				en_registro   		<= '0';
				res_pel   			<= '1';    
  		 	   gra1_upi				<= '0';	
				gra1_upd				<= '0';
				gra1_dwi				<= '0';
				gra1_dwd				<= '0';
				gra2_upi				<= '0';			
				gra2_upd				<= '0';
				gra2_dwi				<= '0';
				gra2_dwd				<= '0';
				gra3_i 				<= '0';
				gra3_d 				<= '0';
				en_cont 				<= '0';
				IF ( en_pelota ='1') THEN 

				next_state <= s8;
			
		         ELSE
				next_state <= s1;	
				
				END IF;

--------------------------------------------------------------------------------------------------------------------------------------------------------------				
			WHEN s2	=>
				en_cont 				<= '0';
				en_registro   		<= '1';
				res_pel   			<= '0';
  		 	   gra1_upi				<= '1';	
				gra1_upd				<= '0';
				gra1_dwi				<= '0';
				gra1_dwd				<= '0';
				gra2_upi				<= '0';			
				gra2_upd				<= '0';
				gra2_dwi				<= '0';
				gra2_dwd				<= '0';
				gra3_i 				<= '0';
				gra3_d 				<= '0';

			IF ( perdio ='1') THEN
		 
				 next_state <= s0; 

				
			ELSIF ( sgra1_upd ='1') THEN
		 
				 next_state <= s3; 
			ELSIF ( sgra1_dwi ='1') THEN
		 
				 next_state <= s4; 
			ELSIF ( sgra1_dwd ='1') THEN
		 
				 next_state <= s5; 
			ELSIF ( sgra2_upi ='1') THEN
		 
				 next_state <= s6; 
			ELSIF ( sgra2_upd ='1') THEN
		 
				 next_state <= s7; 
			ELSIF ( sgra2_dwi ='1') THEN
		 
				 next_state <= s8; 
			ELSIF ( sgra2_dwd ='1') THEN
		 
				 next_state <= s9; 
			ELSIF ( sgra3_i ='1') THEN
		 
				 next_state <= s10; 
			ELSIF ( sgra3_d ='1') THEN
		 
				 next_state <= s11; 
				 
			ELSE
		      next_state <= s2; 
			END IF;				
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------			


--------------------------------------------------------------------------------------------------------------------------------------------------------------				
			WHEN s3	=>
				en_cont 				<= '0';
			   en_registro   		<= '1';
				res_pel   			<= '0';
  		 	   gra1_upi				<= '0';	
				gra1_upd				<= '1';
				gra1_dwi				<= '0';
				gra1_dwd				<= '0';
				gra2_upi				<= '0';			
				gra2_upd				<= '0';
				gra2_dwi				<= '0';
				gra2_dwd				<= '0';
				gra3_i 				<= '0';
				gra3_d 				<= '0';

			
			IF 	( sgra1_upi ='1') THEN
		 
				 next_state <= s2; 
				
			ELSIF ( sgra1_dwi ='1') THEN
		 
				 next_state <= s4; 
			ELSIF ( sgra1_dwd ='1') THEN
		 
				 next_state <= s5; 
			ELSIF ( sgra2_upi ='1') THEN
		 
				 next_state <= s6; 
			ELSIF ( sgra2_upd ='1') THEN
		 
				 next_state <= s7; 
			ELSIF ( sgra2_dwi ='1') THEN
		 
				 next_state <= s8; 
			ELSIF ( sgra2_dwd ='1') THEN
		 
				 next_state <= s9; 
			ELSIF ( sgra3_i ='1') THEN
		 
				 next_state <= s10; 
			ELSIF ( sgra3_d ='1') THEN
		 
				 next_state <= s11; 
			ELSIF ( perdio ='1') THEN
		 
				 next_state <= s0; 
				 ELSE
		      next_state <= s3;
		
			END IF;				
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------			


--------------------------------------------------------------------------------------------------------------------------------------------------------------				
			WHEN s4	=>
				en_cont 				<= '0';
			   en_registro   		<= '1';
				res_pel   			<= '0';
  		 	   gra1_upi				<= '0';	
				gra1_upd				<= '0';
				gra1_dwi				<= '1';
				gra1_dwd				<= '0';
				gra2_upi				<= '0';			
				gra2_upd				<= '0';
				gra2_dwi				<= '0';
				gra2_dwd				<= '0';
				gra3_i 				<= '0';
				gra3_d 				<= '0';

			
			IF 	( sgra1_upi ='1') THEN
		 
				 next_state <= s2; 
				
			ELSIF ( sgra1_upd ='1') THEN
		 
				 next_state <= s3; 

			ELSIF ( sgra1_dwd ='1') THEN
		 
				 next_state <= s5; 
			ELSIF ( sgra2_upi ='1') THEN
		 
				 next_state <= s6; 
			ELSIF ( sgra2_upd ='1') THEN
		 
				 next_state <= s7; 
			ELSIF ( sgra2_dwi ='1') THEN
		 
				 next_state <= s8; 
			ELSIF ( sgra2_dwd ='1') THEN
		 
				 next_state <= s9; 
			ELSIF ( sgra3_i ='1') THEN
		 
				 next_state <= s10; 
			ELSIF ( sgra3_d ='1') THEN
		 
				 next_state <= s11; 
			ELSIF ( perdio ='1') THEN
		 
				 next_state <= s0; 
         ELSE
		      next_state <= s4;
				 
			END IF;				
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------			


--------------------------------------------------------------------------------------------------------------------------------------------------------------				
			WHEN s5	=>
				en_cont 				<= '0';
			   en_registro   		<= '1';
				res_pel   			<= '0';
  		 	   gra1_upi				<= '0';	
				gra1_upd				<= '0';
				gra1_dwi				<= '0';
				gra1_dwd				<= '1';
				gra2_upi				<= '0';			
				gra2_upd				<= '0';
				gra2_dwi				<= '0';
				gra2_dwd				<= '0';
				gra3_i 				<= '0';
				gra3_d 				<= '0';

			
			IF 	( sgra1_upi ='1') THEN
		 
				 next_state <= s2; 
				
			ELSIF ( sgra1_upd ='1') THEN
		 
				 next_state <= s3; 
			ELSIF ( sgra1_dwi ='1') THEN
		 
				 next_state <= s4; 
	
			ELSIF ( sgra2_upi ='1') THEN
		 
				 next_state <= s6; 
			ELSIF ( sgra2_upd ='1') THEN
		 
				 next_state <= s7; 
			ELSIF ( sgra2_dwi ='1') THEN
		 
				 next_state <= s8; 
			ELSIF ( sgra2_dwd ='1') THEN
		 
				 next_state <= s9; 
			ELSIF ( sgra3_i ='1') THEN
		 
				 next_state <= s10; 
			ELSIF ( sgra3_d ='1') THEN
		 
				 next_state <= s11; 
			ELSIF ( perdio ='1') THEN
		 
				 next_state <= s0; 
				 ELSE
		      next_state <= s5;
		
			END IF;				
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------			


--------------------------------------------------------------------------------------------------------------------------------------------------------------				
			WHEN s6	=>
				en_cont 				<= '0';
			   en_registro   		<= '1';
				res_pel   			<= '0';
  		 	   gra1_upi				<= '0';	
				gra1_upd				<= '0';
				gra1_dwi				<= '0';
				gra1_dwd				<= '0';
				gra2_upi				<= '1';			
				gra2_upd				<= '0';
				gra2_dwi				<= '0';
				gra2_dwd				<= '0';
				gra3_i 				<= '0';
				gra3_d 				<= '0';

			
			IF 	( sgra1_upi ='1') THEN
		 
				 next_state <= s2; 
				
			ELSIF ( sgra1_upd ='1') THEN
		 
				 next_state <= s3; 
			ELSIF ( sgra1_dwi ='1') THEN
		 
				 next_state <= s4; 
			ELSIF ( sgra1_dwd ='1') THEN
		 
				 next_state <= s5; 
			 
			ELSIF ( sgra2_upd ='1') THEN
		 
				 next_state <= s7; 
			ELSIF ( sgra2_dwi ='1') THEN
		 
				 next_state <= s8; 
			ELSIF ( sgra2_dwd ='1') THEN
		 
				 next_state <= s9; 
			ELSIF ( sgra3_i ='1') THEN
		 
				 next_state <= s10; 
			ELSIF ( sgra3_d ='1') THEN
		 
				 next_state <= s11; 
			ELSIF ( perdio ='1') THEN
		 
				 next_state <= s0; 
		   ELSE 
			
		      next_state <= s6;
			END IF;				
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------			


--------------------------------------------------------------------------------------------------------------------------------------------------------------				
			WHEN s7	=>
				en_cont 				<= '0';
			   en_registro   		<= '1';
				res_pel   			<= '0';
  		 	   gra1_upi				<= '0';	
				gra1_upd				<= '0';
				gra1_dwi				<= '0';
				gra1_dwd				<= '0';
				gra2_upi				<= '0';			
				gra2_upd				<= '1';
				gra2_dwi				<= '0';
				gra2_dwd				<= '0';
				gra3_i 				<= '0';
				gra3_d 				<= '0';

			
			IF 	( sgra1_upi ='1') THEN
		 
				 next_state <= s2; 
				
			ELSIF ( sgra1_upd ='1') THEN
		 
				 next_state <= s3; 
			ELSIF ( sgra1_dwi ='1') THEN
		 
				 next_state <= s4; 
			ELSIF ( sgra1_dwd ='1') THEN
		 
				 next_state <= s5; 
			ELSIF ( sgra2_upi ='1') THEN
		 
				 next_state <= s6; 

			ELSIF ( sgra2_dwi ='1') THEN
		 
				 next_state <= s8; 
			ELSIF ( sgra2_dwd ='1') THEN
		 
				 next_state <= s9; 
			ELSIF ( sgra3_i ='1') THEN
		 
				 next_state <= s10; 
			ELSIF ( sgra3_d ='1') THEN
		 
				 next_state <= s11; 
			ELSIF ( perdio ='1') THEN
		 
				 next_state <= s0; 
				 
			ELSE
		      next_state <= s7;
		
			END IF;				
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------			


--------------------------------------------------------------------------------------------------------------------------------------------------------------				
			WHEN s8	=>
				en_cont 				<= '0';
			   en_registro   		<= '1';
				res_pel   			<= '0';
  		 	   gra1_upi				<= '0';	
				gra1_upd				<= '0';
				gra1_dwi				<= '0';
				gra1_dwd				<= '0';
				gra2_upi				<= '0';			
				gra2_upd				<= '0';
				gra2_dwi				<= '1';
				gra2_dwd				<= '0';
				gra3_i 				<= '0';
				gra3_d 				<= '0';

			
			IF 	( sgra1_upi ='1') THEN
		 
				 next_state <= s2; 
				
			ELSIF ( sgra1_upd ='1') THEN
		 
				 next_state <= s3; 
			ELSIF ( sgra1_dwi ='1') THEN
		 
				 next_state <= s4; 
			ELSIF ( sgra1_dwd ='1') THEN
		 
				 next_state <= s5; 
			ELSIF ( sgra2_upi ='1') THEN
		 
				 next_state <= s6; 
			ELSIF ( sgra2_upd ='1') THEN
		 
				 next_state <= s7; 

			ELSIF ( sgra2_dwd ='1') THEN
		 
				 next_state <= s9; 
			ELSIF ( sgra3_i ='1') THEN
		 
				 next_state <= s10; 
			ELSIF ( sgra3_d ='1') THEN
		 
				 next_state <= s11; 
			ELSIF ( perdio ='1') THEN
		 
				 next_state <= s0; 
			
			ELSE
		      next_state <= s8;
		
			END IF;				
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------			


--------------------------------------------------------------------------------------------------------------------------------------------------------------				
			WHEN s9	=>
				en_cont 				<= '0';
			   en_registro   		<= '1';
				res_pel   			<= '0';
  		 	   gra1_upi				<= '0';	
				gra1_upd				<= '0';
				gra1_dwi				<= '0';
				gra1_dwd				<= '0';
				gra2_upi				<= '0';			
				gra2_upd				<= '0';
				gra2_dwi				<= '0';
				gra2_dwd				<= '1';
				gra3_i 				<= '0';
				gra3_d 				<= '0';

			
			IF 	( sgra1_upi ='1') THEN
		 
				 next_state <= s2; 
				
			ELSIF ( sgra1_upd ='1') THEN
		 
				 next_state <= s3; 
			ELSIF ( sgra1_dwi ='1') THEN
		 
				 next_state <= s4; 
			ELSIF ( sgra1_dwd ='1') THEN
		 
				 next_state <= s5; 
			ELSIF ( sgra2_upi ='1') THEN
		 
				 next_state <= s6; 
			ELSIF ( sgra2_upd ='1') THEN
		 
				 next_state <= s7; 
			ELSIF ( sgra2_dwi ='1') THEN
		 
				 next_state <= s8; 

			ELSIF ( sgra3_i ='1') THEN
		 
				 next_state <= s10; 
			ELSIF ( sgra3_d ='1') THEN
		 
				 next_state <= s11; 
			ELSIF ( perdio ='1') THEN
		 
				 next_state <= s0; 
		   ELSE
		      next_state <= s9;
			END IF;				
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------			


--------------------------------------------------------------------------------------------------------------------------------------------------------------				
			WHEN s10	=>
				en_cont 				<= '0';
			   en_registro   		<= '1';
				res_pel   			<= '0';
  		 	   gra1_upi				<= '0';	
				gra1_upd				<= '0';
				gra1_dwi				<= '0';
				gra1_dwd				<= '0';
				gra2_upi				<= '0';			
				gra2_upd				<= '0';
				gra2_dwi				<= '0';
				gra2_dwd				<= '0';
				gra3_i 				<= '1';
				gra3_d 				<= '0';

			
			IF 	( sgra1_upi ='1') THEN
		 
				 next_state <= s2; 
				
			ELSIF ( sgra1_upd ='1') THEN
		 
				 next_state <= s3; 
			ELSIF ( sgra1_dwi ='1') THEN
		 
				 next_state <= s4; 
			ELSIF ( sgra1_dwd ='1') THEN
		 
				 next_state <= s5; 
			ELSIF ( sgra2_upi ='1') THEN
		 
				 next_state <= s6; 
			ELSIF ( sgra2_upd ='1') THEN
		 
				 next_state <= s7; 
			ELSIF ( sgra2_dwi ='1') THEN
		 
				 next_state <= s8; 
			ELSIF ( sgra2_dwd ='1') THEN
		 
				 next_state <= s9; 

			ELSIF ( sgra3_d ='1') THEN
		 
				 next_state <= s11; 
			ELSIF ( perdio ='1') THEN
		 
				 next_state <= s0; 
		   ELSE
		      next_state <= s10;
			END IF;				
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------			


--------------------------------------------------------------------------------------------------------------------------------------------------------------				
			WHEN s11	=>
				en_cont 				<= '0';
			   en_registro   		<= '1';
				res_pel   			<= '0';
  		 	   gra1_upi				<= '0';	
				gra1_upd				<= '0';
				gra1_dwi				<= '0';
				gra1_dwd				<= '0';
				gra2_upi				<= '0';			
				gra2_upd				<= '0';
				gra2_dwi				<= '0';
				gra2_dwd				<= '0';
				gra3_i 				<= '0';
				gra3_d 				<= '1';

			
			IF 	( sgra1_upi ='1') THEN
		 
				 next_state <= s2; 
				
			ELSIF ( sgra1_upd ='1') THEN
		 
				 next_state <= s3; 
			ELSIF ( sgra1_dwi ='1') THEN
		 
				 next_state <= s4; 
			ELSIF ( sgra1_dwd ='1') THEN
		 
				 next_state <= s5; 
			ELSIF ( sgra2_upi ='1') THEN
		 
				 next_state <= s6; 
			ELSIF ( sgra2_upd ='1') THEN
		 
				 next_state <= s7; 
			ELSIF ( sgra2_dwi ='1') THEN
		 
				 next_state <= s8; 
			ELSIF ( sgra2_dwd ='1') THEN
		 
				 next_state <= s9; 
			ELSIF ( sgra3_i ='1') THEN
		 
				 next_state <= s10; 
			
			ELSIF ( perdio ='1') THEN
		 
				 next_state <= s0;
				
			ELSE
		      next_state <= s11;	
		
			END IF;				
-----------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------			

           when others=>
				en_cont 				<= '0';
			   en_registro   		<= '1';
				res_pel   			<= '0';
  		 	   gra1_upi				<= '0';	
				gra1_upd				<= '0';
				gra1_dwi				<= '0';
				gra1_dwd				<= '0';
				gra2_upi				<= '0';			
				gra2_upd				<= '1';
				gra2_dwi				<= '0';
				gra2_dwd				<= '0';
				gra3_i 				<= '0';
				gra3_d 				<= '0';
				next_state <= s0;




	
		
		END CASE;
	END PROCESS combinational;
END ARCHITECTURE fsm;