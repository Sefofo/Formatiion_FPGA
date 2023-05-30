library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith;

entity tp_leddriver is
    generic (
       --max_count : integer :=20000000;
       --nb_bit : integer := 28;
       max_count : integer :=4;
       nb_bit : integer := 3;
       nbre_cycle : positive :=2  --cycle de clignotement allumé et éteint
    );
    port ( 
		clk			: in std_logic;   -- Signal d'horloge
        resetn		: in std_logic;   -- Signal de reset
        		--a completer
		btn_0      : in std_logic;  -- Bouton d'entrée
		led_out_R  : out std_logic;  -- LED rouge
		led_out_V  : out std_logic    -- LED verte 
     );
end tp_leddriver;


architecture behavioral of tp_leddriver is

    type state is (idle, state1); --a modifier avec vos etats
    
    signal current_state : state;  --etat dans lequel on se trouve actuellement
    signal next_state : state;	   --etat dans lequel on passera au prochain coup d'horloge
    signal s_led_out_V  : std_logic;
    signal s_led_out_R  : std_logic;
    signal end_count : std_logic;
    signal state_led: std_logic;   -- état des leds
    ----RisingEdgebtn
    signal tmp_btn      : std_logic;
    signal previous_btn : std_logic;
    signal rising_btn_0 : std_logic;
 --Declaration de l'entite a tester
   component counter_unit 
   generic (
     --max_count : integer :=20000000;
      -- nb_bit : integer := 28
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
         --max_count =>20000000,
        -- nb_bit => 28
       max_count =>4,
       nb_bit => 3
         )
port map (
            clk => clk, 
            resetn=>resetn, 
            end_counter => end_count
        );
   
	-- Process séquentielle  Logique de la machine à états
process(clk,resetn,end_count)
		begin
		if resetn = '1' then
            current_state <= idle;
              elsif rising_edge(end_count)then
            current_state <= next_state;
        end if;
end process;	

---Process séquentielle de risingedgebtn 

    process (clk, resetn)
    begin
        if (resetn = '1') then
            tmp_btn      <= '0';
            previous_btn <= '0';
        elsif (rising_edge(clk)and end_count='1') then
            tmp_btn      <= btn_0;
            previous_btn <= tmp_btn;
        end if;
    end process;
    --Partie combinatoire 
    rising_btn_0 <= tmp_btn and (not( previous_btn));	
										
		-- FSM Logique de contrôle de la machine à états
process(current_state, rising_btn_0,state_led) --a completer avec vos signaux
		
begin	
             --signaux pilotes par la fsm état ou les leds sont éteintes 
             
           case current_state is
              when idle =>                  -- idle= état de led éteinte
              state_led<='0';
              next_state <= state1;         -- prochain état idle= état de led allumée
          
           --signaux pilotes par la fsm état ou les leds sont allumées
               when state1 =>                  -- state1= état de led allumée
              state_led<='1';
              next_state <= idle;           -- prochain état idle= état de led éteinte
              
              end case;                     
end process;

--Partie combinatoire logique de controle des Leds 
--gestion de la led rouge et verte les premières questions
--s_led_out_V<='1' when(state_led='1' and btn_0='1')
 --else '0';
--s_led_out_R<='1' when(state_led='1' and btn_0='0')
--   else '0';  
   
 --gestion de la led rouge et verte avec la nouvelle condition avec rising_edge btn_0   

s_led_out_V <= '1' when (state_led = '1' and rising_btn_0 = '1') else
             '0';
s_led_out_R<='1' when(state_led='1' and rising_btn_0 = '0')
 else '0';       
   
 led_out_R<=s_led_out_R; -- led rouge
 led_out_V<=s_led_out_V; -- led verte
 
end behavioral;
