library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith;

entity topFIFO is
    
    port ( 
		clk			: in std_logic;   -- Signal d'horloge
        resetn		: in std_logic;   -- Signal de reset
        btn_0		: in std_logic;   -- Signal de mise a  jour
	    btn_1		: in std_logic;   -- Signal de mise a  jour
		led_out_RGB : out std_logic_vector(2 downto 0)  -- LED RGB
		
     );
end topFIFO;

architecture behavioral of topFIFO is

    signal update: std_logic;
    signal color_code0 : std_logic_vector(1 downto 0);
    signal color_code : std_logic_vector(1 downto 0);
    signal s_led_out_RGB  : std_logic_vector(2 downto 0);
    signal end_cycle  : std_logic;  -- End_cycle
   
    ----RisingEdgebtn
    signal tmp_btn      : std_logic;
    signal previous_btn : std_logic;
    signal rising_btn_0 : std_logic;
	
	
 --Declaration de led_driver
component led_driver1 

    port ( 
		clk			: in std_logic;   -- Signal d'horloge
        resetn		: in std_logic;   -- Signal de reset
        update		: in std_logic;   -- Signal de mise a  jour
		color_code  : in std_logic_vector(1 downto 0);
		end_cycle  : out std_logic;  -- End_cycle
		led_out_RGB : out std_logic_vector(2 downto 0)  -- LED Red	
     );
	 
end component; 

 -- Declaration de la FIFO LED 

component FIFO_LED
   port  (
    clk : in std_logic; 
    srst : in std_logic; 
    din : in std_logic_vector(1 downto 0);          -- donnee a ecrire
    wr_en : in std_logic; 
    rd_en : in std_logic; 
    dout : out std_logic_vector(1 downto 0)         -- donne lue
 
  );
end component; 

begin 

Ledriver : led_driver1
port map (
            clk => clk, 
            resetn=>resetn, 
            update => update,
			color_code => color_code,
			led_out_RGB => s_led_out_RGB,
			end_cycle => end_cycle
        );
           
FIFO : FIFO_LED
port map  (
      
      clk => clk,
      srst => resetn,
      din => color_code0 ,
      wr_en => rising_btn_0,
      rd_en => end_cycle,
      dout => color_code       
	 );

--- process séquentielle du risingbtn_0 

    process (clk, resetn)
    begin
        if (resetn = '1') then
            tmp_btn      <= '0';
            previous_btn <= '0';
        elsif (rising_edge(clk)) then
            tmp_btn      <= btn_0;
            previous_btn <= tmp_btn;
        end if;
    end process;
    --Partie de la partie combinatoire 
    rising_btn_0 <= tmp_btn and ( not(previous_btn));
	update<= rising_btn_0;
	
	-- partie combinatoire des couleurs color_code pour le vert et le bleu
	
	    color_code0<="10" when (btn_1='1')
		    else  
			     "11";   
--- gestion des couleurs de sortie avec le signal interne s_led_out entre la FSM et la couleur

led_out_RGB <=s_led_out_RGB; 
  
end behavioral;