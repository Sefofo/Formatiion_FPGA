library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all; 


entity counter_unit is

    port ( 
		clk			: in std_logic; 
        resetn		: in std_logic; 
        restart     : in std_logic;
        led0_b      : out std_logic;
        end_counter	 : out std_logic
     );
end counter_unit;

architecture behavioral of counter_unit is
	
	--Declaration des signaux internes
	--constant hp : time := 5 ns;      --demi periode de 5ns
	--constant period : time := 2*hp;  --periode de 10ns, soit une frequence de 100Hz
  --constant cte : positive := X"BEB C200";
    --constant cte : positive := 200000000;
    
    constant cte : positive := 200000000;
    --signal Q : positive range 0 to cte; 
    signal Q : std_logic_vector(27 downto 0);
    signal  s_led0_b  : std_logic;
   signal end_count : std_logic;

	
begin 
		--Partie sequentielle
		process(clk,resetn)
		begin
			if(resetn = '1') then 
			Q	<=(others => '0');
			s_led0_b <='0';
			elsif(rising_edge(clk)) then
			 if( restart='1') then
			  Q	<=(others => '0');
			 s_led0_b <='0';
			 else
			   Q <= Q+ 1;
			   if(end_count= '1') then
			 Q	<=(others => '0');
			  s_led0_b <= not(s_led0_b);
			end if;
			end if;
			end if;
		end process;
		
		--Partie combinatoire
	  end_count <= '1' when (Q =cte-1)
                else '0';
             
    end_counter <= end_count;		
						
 led0_b <=s_led0_b;
 
end behavioral;