library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith;

entity tp_fsm is
    generic (
--       max_count : integer :=200000000;
--       nb_bit : integer := 28;
       max_count : integer :=4;
       nb_bit : integer := 3;
       nbre_cycle : positive :=6  --cycle de clignotement allumé et éteint
    );
    port ( 
		clk			: in std_logic; 
        resetn		: in std_logic;
        		--a completer
		restart     : in std_logic;
		end_counter2 : out std_logic;
		led_out_R  : out std_logic;
		led_out_B  : out std_logic;
		led_out_V  : out std_logic
     );
end tp_fsm;


architecture behavioral of tp_fsm is

    type state is (idle, state1, state2, state3); --a modifier avec vos etats
    
    signal current_state : state;  --etat dans lequel on se trouve actuellement
    signal next_state : state;	   --etat dans lequel on passera au prochain coup d'horloge
    signal  s_led_out_B  : std_logic;  -- signal de sortie de LED RGB
    signal  s_led_out_V  : std_logic;
    signal  s_led_out_R  : std_logic;
    signal raz : std_logic;                 -- signal de remise à zéro
    signal end_count : std_logic;            -- signal de sortie de counter_unit
    signal end_count2 : integer range 0 to 5:=0;                -- signal de sortie de counter2
    signal state_led: std_logic;                     -- signal de'état de led
    
 --Declaration de l'entite a tester counter_unit
   component counter_unit 
   generic (
--         max_count : integer :=200000000;
--         nb_bit : integer := 28
          max_count : integer :=4;
       nb_bit : integer := 3
         );
        port ( 
            clk           : in std_logic; 
            resetn        : in std_logic; 
          
            end_counter   : out std_logic
         );
 end component;
	
	begin


compteur : counter_unit
generic map (
--         max_count =>200000000,
--         nb_bit => 28
          max_count =>4,
       nb_bit => 3
         )
port map (
            clk => clk, 
            resetn=>resetn, 
            end_counter => end_count
        );
        
	-- Process séquentielle du clk, resetn, restart 
	
		process(clk,resetn,restart)
		begin
		
    if(resetn='1' or restart='1') then
            end_count2<= 0;
            current_state <= idle;
                             
	elsif(rising_edge(clk)) then
			current_state <= next_state;
			
			 if(raz='0') then
			        if (end_count='1') then
			          end_count2<=end_count2 +1;
			         elsif(end_count='0') then 
			             end_count2<=end_count2; 
			         end if; 
			    else 
			          end_count2<=0;
			     end if;		
			
		end if;
		
end process;
				
				--Partie combinatoire a completer avec votre compteur de cycles
				
				--remise à zero à la fin du compteur de cycles				
		raz <= '1'  when (end_count2 = ((nbre_cycle)-1) and end_count = '1')
                else '0';
          end_counter2 <= raz;
          
         
      -- Vérification de l'état de end_counter2 pour determine si la led doit etre 'on' or 'off'
		state_led <= '0' when( end_count2 mod 2 = 0 )else '1';   
					
		
		-- FSM
process(current_state, restart,state_led,end_counter2) --a completer avec les signaux current_state, restart,state_led,end_counter2
		
begin	
             --signaux pilotes par la fsm les signaux sont affectés dans les différentes cas
             
           case current_state is
              when idle =>
              s_led_out_R<=state_led;
              s_led_out_B<=state_led;
              s_led_out_V<=state_led;
             if restart='0' then
             
                   if(end_counter2='1') then
                     next_state <= state1;
                    
                     else
                   
                     next_state <= idle;             --prochain etat
                     end if;                          
                else 
                next_state<=idle;
             
                   end if;
                 
              when state1 =>
                s_led_out_R<=state_led;
                s_led_out_B<='0';
                s_led_out_V<='0';
             if restart='0' then
           
                     if(end_counter2='1') then
                     next_state <= state2;              --prochain etat
                 
                     else
                 
                     next_state <= state1;
                   
                     end if;
                 else
                 next_state <= idle;   
                
                 end if;  
            
              when state2 =>
                 s_led_out_R<='0';
                 s_led_out_B<=state_led;
                 s_led_out_V<='0';
             if restart='0' then
                   if(end_counter2='1') then
               
                    next_state <= state3;                    --prochain etat
                   
                     else
                    
                     next_state <= current_state;
                     end if;
                   else
                 next_state <= idle;   
                 end if; 
                        
             when state3 =>
                s_led_out_R<='0';
                s_led_out_B<='0';
                s_led_out_V<=state_led;
             if restart='0' then 
            
                       if(end_counter2='1') then
                     next_state <= state1;                   --prochain etat
                  
                     else
                   
                     next_state <= current_state;
                     end if;
                     else
                 next_state <= idle;   
                 end if; 
                                      
                --signaux pilotes par la fsm
                when others =>
               
               next_state <= idle;
             
              end case;
                      
end process;

--Partie combinatoire a completer avec les leds affectations de signaux
 led_out_R<=s_led_out_R;
 led_out_B<=s_led_out_B;
 led_out_V<=s_led_out_V;  
 
end behavioral;