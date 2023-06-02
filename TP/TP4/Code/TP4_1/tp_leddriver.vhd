library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith;

entity led_driver is
  
    port ( 
		clk			: in std_logic;   -- Signal d'horloge
        resetn		: in std_logic;   -- Signal de reset
        update		: in std_logic;   -- Signal de mise à jour
		color_code  : in std_logic_vector(1 downto 0);
		Led_out_RGB : out std_logic_vector(2 downto 0)  -- LED Red
	  --led_out_R  : out std_logic_vector(2 downto 0)  -- LED Red
	  --led_out_V  : out std_logic_vector(2 downto 0)  -- LED Green
	  --led_out_B  : out std_logic_vector(2 downto 0)  -- LED Blu
		
     );
end led_driver;


architecture behavioral of led_driver is
       
	  -- signal pour la FSM 
    type state is (idle, state1); --a modifier avec vos etats
    
    signal current_state : state;  --etat dans lequel on se trouve actuellement
    signal next_state : state;	   --etat dans lequel on passera au prochain coup d'horloge
    signal state_led: std_logic_vector(2 downto 0);   -- état des leds
    
    signal end_count : std_logic;   -- signal counter_unit
    signal end_count2 : std_logic_vector(2 downto 0);  -- signal de sortie counter2 qui gère le clignotement de la led 
	
    signal s_color_code  : std_logic_vector(2 downto 0);  -- signal de Code couleur en entrée (00, 01, 10, 11) sortie mux
	signal s_led_out_RGB  : std_logic_vector(2 downto 0);   -- signal de led Rouge sortie
  --signal s_led_out_V  : std_logic_vector(2 downto 0);   -- signal de led Rouge sortie
  --signal s_led_out_R  : std_logic_vector(2 downto 0);   -- signal de led verte sortie
  --signal s_led_out_B  : std_logic_vector(2 downto 0);   -- signal de led bleue sortie
   
	
 --Declaration de counter_unit l'entite à l'intérieur de led_driver
   
   component counter_unit 
   generic (
     max_count : integer :=20000000;
      nb_bit : integer := 28
      --max_count : integer :=4;
     -- nb_bit : integer := 3
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
         max_count =>20000000,
         nb_bit => 28
      -- max_count =>4,
     --  nb_bit => 3
         )
port map (
            clk => clk, 
            resetn=>resetn, 
            end_counter => end_count
        );
   
	-- Process séquentielle  du resetn et du clk
process(clk,resetn)
		begin
		if resetn = '1' then
            current_state <= idle;
              elsif rising_edge(clk)then
            current_state <= next_state;
        end if;
end process;	

										
		-- FSM Logique de contrôle de la machine à états
process(current_state, end_count) --a completer avec vos signaux
		
begin	
             --signaux pilotes par la fsm état ou les leds sont éteintes 
             
           case current_state is
              when idle =>                  -- idle= état de led éteinte
              state_led<="000";
              if end_count='1' then
              next_state <= state1;         -- prochain état idle= état de led allumée
               else
               next_state <= current_state;  
          end if;
           --signaux pilotes par la fsm état ou les leds sont allumées
               when state1 =>                  -- state1= état de led allumée
              state_led<="111";
              if end_count='1' then
              next_state <= idle;           -- prochain état idle= état de led éteinte
               else
               next_state <= current_state; 
              end if;
              
              end case;                     
end process;

---Process de la gestion des codes couleur avec le registre 
process(clk,resetn)
		begin
		if resetn = '1' then
            end_count2 <= "000";
              elsif rising_edge(clk)then
                  if update ='1' then
                   end_count2 <= s_color_code;
                   else
                   end_count2 <=end_count2;
              end if;
        end if;
end process;	
--Partie combinatoire logique de controle des Leds avec s_color_code et end_count2

 --gestion des couleurs color_code et s_color_code avec le mux 

	  s_color_code<= "000" when (color_Code = "00")
            else "001" when (color_Code = "01")
               else "010" when (color_Code = "10")
                  else "100" when (color_Code = "11")
                    else "000";

--- gestion des couleurs de sortie avec le signal interne s_led_out entre la FSM et la couleur

 s_led_out_RGB <= end_count2 and state_led;    

led_out_RGB <=s_led_out_RGB; 
 
end behavioral;