library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith;


entity tb_tp_fsm is
end tb_tp_fsm;

architecture behavioral of tb_tp_fsm is
     
     --signaux de clk, resetn et restart
	signal resetn      : std_logic := '0';
	signal clk         : std_logic := '0';
	signal restart         : std_logic := '0';
	
	--Signaux de sorties 
	signal end_count2 : integer range 0 to 5:=0;
	signal end_counter2 : std_logic:='0';
	 signal  s_led_out_B  : std_logic;
    signal  s_led_out_V  : std_logic;
    signal  s_led_out_R  : std_logic;
    
	-- Les constantes suivantes permette de definir la frequence de l'horloge 
	constant hp : time := 5 ns;      --demi periode de 5ns
	constant period : time := 2*hp;  --periode de 10ns, soit une frequence de 100Hz
	constant nbre_cycle : positive := 6 ; 
--	constant  max_count : integer :=200000000;
--    constant   nb_bit : integer := 28;
	 constant  max_count : integer :=4;
      constant   nb_bit : integer := 3;
     
     --Déclaration du composant fsm
	component tp_fsm
		port ( 
			clk			: in std_logic; 
			resetn		: in std_logic;
			restart		: in std_logic;
			--a completer
			 end_counter2  : out std_logic;
			 led_out_V:  out std_logic;
			 led_out_R:  out std_logic;
			 led_out_B:  out std_logic
		 );
	end component;
		
	begin
	dut: tp_fsm
        port map (
            clk => clk, 
            resetn => resetn,
            restart => restart,
			--a completer
			end_counter2 => end_counter2,
			led_out_B => s_led_out_B ,
            led_out_V => s_led_out_V ,
            led_out_R  => s_led_out_R 
        );
		
	--Simulation du signal d'horloge en continue
	process
    begin
      
		wait for hp;
		clk <= not clk;
	
	end process;

     --Simulation du signal restn en continue avec affichage de end_counter2 qui fonctionne après le nombre de cycle
	process
	begin        
	
		resetn <= '1';
		--wait for hp;
		wait for period*1;    
		resetn <= '0';
	     assert end_counter2='0'
		   report "end_counter2 : test failed";
		 wait for period*2;     
	   		--a completer  
		wait for period*nbre_cycle*max_count;
	    assert end_counter2='1'
		  report "end_counter2 : test failed";
		wait;
	end process;
--simulation de leds et clignotement	
process 
	begin
   wait for period*1;
-- Restart
    restart <= '1';
    wait for 40 ns;
    restart <= '0';
    wait for period*nbre_cycle*max_count;

    -- Verifions l'état initial idle (LED blanche)
    assert (s_led_out_R = '1' and s_led_out_V = '1' and s_led_out_B = '1')
      report "Initial state mismatch" severity error;

    -- Wait for 3 clignotements en blanc (INITIAL state : idle)
    wait for period*nbre_cycle*max_count;

    -- Verifions RED state1
    assert (s_led_out_R = '1' and s_led_out_V = '0' and s_led_out_B = '0')
      report "RED state mismatch" severity error;

    -- Wait for 3 clignotements en rouge (RED state)
    wait for period*nbre_cycle*max_count;

    -- Verifions BLUE state2
    assert (s_led_out_R = '0' and s_led_out_V = '0' and s_led_out_B = '1')
      report "BLUE state mismatch" severity error;

    -- Wait for 3 clignotements en bleu (BLUE state)
    wait for period*nbre_cycle*max_count;

    -- Verifions GREEN state3
    assert (s_led_out_R = '0' and s_led_out_V = '1' and s_led_out_B = '0')
      report "GREEN state mismatch" severity error;

    -- Wait for 3 clignotements en vert (GREEN state)
    wait for period*nbre_cycle*max_count;

--Pour finir la simulation	
wait;	
end process; 
	
end behavioral;