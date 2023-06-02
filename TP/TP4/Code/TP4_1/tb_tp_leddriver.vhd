library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith;


entity tb_top  is
end tb_top ;

architecture behavioral of tb_top  is
   
   -- signaux de top 
    signal resetn      : std_logic := '0';
	signal clk         : std_logic := '0';
	signal btn_0         : std_logic := '0';
	signal btn_1         : std_logic := '0';
    signal led_out_RGB: std_logic_vector(2 downto 0);   -- état des leds
    
   
	-- Les constantes suivantes permette de definir la frequence de l'horloge 
	constant hp : time := 5 ns;      --demi periode de 5ns
	constant period : time := 2*hp;  --periode de 10ns, soit une frequence de 100Hz

	 constant  max_count : integer :=20000000;
     constant   nb_bit : integer := 28;
     
     --Déclaration du composant fsm
	component top 
		port ( 
	    clk			: in std_logic;   -- Signal d'horloge
        resetn		: in std_logic;   -- Signal de reset
        		--a completer
		btn_0 		: in std_logic;   -- Signal de mise à jour
		btn_1  : in std_logic;  -- Signal de mise à jour
		led_out_RGB  : out std_logic_vector(2 downto 0)  -- LED RGB
		
		 );
	end component;
		
	begin
	dut: top
        port map (
           clk	=> 	clk,
           resetn => resetn,   -- Signal de reset
        		--a completer
		     btn_0 => btn_0 ,     -- Bouton d'entrée
		      btn_1 => btn_1 ,    
		   led_out_RGB => led_out_RGB  -- LED rouge
		
        );
		
	--Simulation du signal d'horloge en continue
	process
    begin    
		wait for hp;
		clk <= not clk;
	
	end process;

process 
	begin
	
-- Resetn
    resetn <= '1';
     wait for 10 ns;
        resetn<='0';
    -- Verifions l'état initial idle (LED éteinte)

      
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
        
--Pour finir la simulation	
wait;	
end process; 
	
end behavioral;