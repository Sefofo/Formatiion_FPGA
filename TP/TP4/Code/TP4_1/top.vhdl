library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith;

entity top is
    
    port ( 
		clk			: in std_logic;   -- Signal d'horloge
        resetn		: in std_logic;   -- Signal de reset
        btn_0		: in std_logic;   -- Signal de mise à jour
	    btn_1		: in std_logic;   -- Signal de mise à jour
		led_out_RGB : out std_logic_vector(2 downto 0)  -- LED RGB
		
     );
end top;

architecture behavioral of top is

    signal update: std_logic;
    signal color_code : std_logic_vector(1 downto 0);
    signal s_led_out_RGB  : std_logic_vector(2 downto 0);
    
    ----RisingEdgebtn
    signal tmp_btn      : std_logic;
    signal previous_btn : std_logic;
    signal rising_btn_0 : std_logic;
	
 --Declaration de led_driver
component led_driver 

    port ( 
		clk			: in std_logic;   -- Signal d'horloge
        resetn		: in std_logic;   -- Signal de reset
        update		: in std_logic;   -- Signal de mise à jour
		color_code  : in std_logic_vector(1 downto 0);
		led_out_RGB : out std_logic_vector(2 downto 0)  -- LED Red	
     );
	 
end component; 

begin 

Ledriver : led_driver
port map (
            clk => clk, 
            resetn=>resetn, 
            update => update,
			color_code => color_code,
			led_out_RGB => s_led_out_RGB
        );
	
--- process s�quentielle du risingbtn_0 

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
	
	-- partie combinatoire des couleurs color_code 
	
	    color_code<="10" when (btn_1='1')
		    else  
			     "11";   
--- gestion des couleurs de sortie avec le signal interne s_led_out entre la FSM et la couleur

led_out_RGB <=s_led_out_RGB; 
  
 
end behavioral;