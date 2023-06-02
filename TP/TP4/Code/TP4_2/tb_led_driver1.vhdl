library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith;


entity tb_topFifo_led is
end tb_topFifo_led ;

architecture behavioral of tb_topFifo_led  is
   
    signal resetn      : std_logic := '0';
	signal clk         : std_logic := '0';
	signal update         : std_logic := '0';
    signal btn_0      : std_logic := '0';
	signal btn_1        : std_logic := '0';
	signal color_code : std_logic_vector(1 downto 0);
    signal s_led_out_RGB  : std_logic_vector(2 downto 0);
    signal end_cycle : std_logic:= '0'; 
    signal end_count : std_logic;   -- signal counter unit
    signal end_count2 : std_logic_vector(2 downto 0);  -- signal counter2 
    signal s_color_code : std_logic_vector(2 downto 0);
    signal state_led: std_logic_vector(2 downto 0);   -- Ã©tat des leds
    
	-- Les constantes suivantes permette de definir la frequence de l'horloge 
	constant hp : time := 5 ns;      --demi periode de 5ns
	constant period : time := 2*hp;  --periode de 10ns, soit une frequence de 100Hz
	constant  max_count : integer :=20000000;
    constant   nb_bit : integer := 28;
	-- constant  max_count : integer :=4;
    -- constant   nb_bit : integer := 3;
     
     --Dclaration du composant fsm
	component topFIFO
		 port ( 
		clk			: in std_logic;   -- Signal d'horloge
        resetn		: in std_logic;   -- Signal de reset
        btn_0		: in std_logic;   -- Signal de mise a  jour
	    btn_1		: in std_logic;   -- Signal de mise a  jour
		led_out_RGB : out std_logic_vector(2 downto 0)  -- LED RGB
		
     );
	end component;
		
	begin
	dut: topFIFO
        port map (
          clk	=> 	clk,
          resetn => resetn,   -- Signal de reset
        		--a completer
		 btn_0 => btn_0 ,     -- Bouton d'entrÃ©e
		 btn_1 => btn_1 ,    
		
		led_out_RGB => s_led_out_RGB  -- LED rouge	
        );
		
	--Simulation du signal d'horloge en continue
	process
    begin    
		wait for hp;
		clk <= not clk;
	
	end process;
     --Simulation du signal restn en continue avec affichage de end_counter qui fonctionne aprÃ¨s le cycle allumÃ©e Ã©teint

process
		 
	begin
	
-- Resetn
    resetn <= '1';
     wait for 10 ns;
        resetn<='0';

  --Verifions l'état initial idle (LED éteinte)

      
       btn_1<='1'; 
         wait for 80ns; 
        btn_0<='1'; 
        wait for 80ns; 
-- Verifions l'état state 1  (LED verte

        wait for 50 ns;
        
        btn_1<='0'; 
         wait for 80ns; 
        btn_0<='0'; 
        wait for 80ns; 
-- Verifions l'état state 1 (LED bleue)
     
        btn_0<='1'; 
        
        wait for 50 ns;
        
         btn_1<='1'; 
         wait for 40ns; 
        btn_0<='0'; 
        wait for 80ns; 
        btn_0<='1'; 
        
-- Verifions l'état state 1  (LED verte

        wait for 50 ns;
        
        btn_1<='0'; 
         wait for 80ns; 
        btn_0<='0'; 
        wait for 80ns; 
-- Verifions l'état state 1 (LED bleue)
     
        btn_0<='1'; 
        
        wait for 50 ns;
        
         btn_1<='1'; 
         wait for 40ns; 
        btn_0<='0'; 
        wait for 80ns; 
        btn_0<='1'; 
          
     
          
--Pour finir la simulation	
wait;	
end process; 
	
end behavioral;