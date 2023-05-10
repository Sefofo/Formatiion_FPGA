library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity tb_counter is
end tb_counter;

architecture behavioral of tb_counter is

    signal resetn      :  std_logic := '0';
    signal clk         :  std_logic := '0';
   signal restart     : std_logic := '0';
   signal  led0_b  : std_logic :='0';
    signal end_counter: std_logic;
    -- Les constantes suivantes permette de definir la frequence de l'horloge 
    constant hp : time := 5 ns;      --demi periode de 5ns
    constant period : time := 2*hp;  --periode de 10ns, soit une frequence de 100Hz

    --Declaration de l'entite a tester
   component counter_unit 
        port ( 
            clk           : in std_logic; 
            resetn        : in std_logic; 
           restart     : in std_logic;
           led0_b      : out std_logic;
            end_counter   : out std_logic
         );
 end component;



    begin

    --Affectation des signaux du testbench avec ceux de l'entite a tester
    uut: counter_unit
    
        port map (
            clk => clk, 
            resetn=>resetn, 
            restart=>restart,
            led0_b=>led0_b,
            end_counter => end_counter
        );

    --Simulation du signal d'horloge en continue
    process
    begin
        wait for hp;
        clk <= not clk;
    end process;

    process
    begin

       -- TESTS A EFFECTUER
       resetn <= '1';
       wait for 10ns;
       resetn <= '0';
--
wait for 4000 ms;
--       assert end_counter='1' report "test fail" severity failure;
    end process;


end behavioral;
