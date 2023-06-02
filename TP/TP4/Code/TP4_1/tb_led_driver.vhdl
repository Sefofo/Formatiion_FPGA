library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith;


entity tb_led_driver is
end tb_led_driver;

architecture behavioral of tb_led_driver is
   
    signal resetn      : std_logic := '0';
	signal clk         : std_logic := '0';
	signal update         : std_logic := '0';
	signal btn_0         : std_logic := '0';
	signal btn_1         : std_logic := '0';
	signal color_code : std_logic_vector(1 downto 0);
    signal s_led_out_RGB  : std_logic_vector(2 downto 0);
 
    signal end_count : std_logic;   -- signal counter unit
    signal end_count2 : std_logic_vector(2 downto 0);  -- signal counter2 
    signal s_color_code : std_logic_vector(2 downto 0);
    signal state_led: std_logic_vector(2 downto 0);   -- état des leds
    
    signal rising_btn_0 : std_logic;
	-- Les constantes suivantes permette de definir la frequence de l'horloge 
	constant hp : time := 5 ns;      --demi periode de 5ns
	constant period : time := 2*hp;  --periode de 10ns, soit une frequence de 100Hz
	--constant  max_count : integer :=20000000;
    --constant   nb_bit : integer := 28;
	 constant  max_count : integer :=4;
     constant   nb_bit : integer := 3;
     
     --Déclaration du composant fsm
	component led_driver
		port ( 
	    clk			: in std_logic;   -- Signal d'horloge
        resetn		: in std_logic;   -- Signal de reset
        		--a completer
		update		: in std_logic;   -- Signal de mise à jour
		color_code  : in std_logic_vector(1 downto 0);  -- Code couleur en entrée (00, 01, 10, 11)
		led_out_RGB  : out std_logic_vector(2 downto 0)  -- LED RGB
		
		 );
	end component;
		
	begin
	dut: led_driver
        port map (
           clk	=> 	clk,
          resetn => resetn,   -- Signal de reset
        		--a completer
		update => update ,     -- Bouton d'entrée
		color_code => color_code ,    
		led_out_RGB => s_led_out_RGB  -- LED rouge
		
        );
		
	--Simulation du signal d'horloge en continue
	process
    begin    
		wait for hp;
		clk <= not clk;
	
	end process;
     --Simulation du signal restn en continue avec affichage de end_counter qui fonctionne après le cycle allumée éteint
	process
	begin        
		resetn <= '1';
		--wait for hp;
		wait for period*2;    
		resetn <= '0';
	     assert end_count='0'
		   report "end_counter : test failed";
		wait for period*max_count;
	    assert end_count='1'
		  report "end_counter : test failed";
		wait;
	end process;
	
--simulation de leds et clignotement	
process 
	begin
	
-- Resetn
    resetn <= '1';
    
    -- Verifions l'état initial idle (LED éteinte)
   update <= '0';
    color_code <= "00";
     wait for 20 ns; 
        resetn <= '0';
        wait for 20 ns;
        
-- Verifions l'état state 1  (LED rouge)
        update <= '1';
        color_code <= "01";
        wait for period*2*max_count;

        update <= '0';
        wait for 100 ns;
-- Verifions l'état state 1  (LED verte)
        update <= '1';
        color_code <= "10";
        wait for 30 ns;

        update <= '0';
        wait for 100 ns;
-- Verifions l'état state 1 (LED bleue)
        update <= '1';
        color_code <= "11";
        wait for 50 ns;

        update <= '0';
        wait for 100 ns;
-- Verifions l'état initial idle (LED éteinte)
        update <= '1';
       color_code <= "00";
        wait for 40 ns;

        update <= '0';
        wait for 100 ns;
  
--Pour finir la simulation	
wait;	
end process; 
	
end behavioral;