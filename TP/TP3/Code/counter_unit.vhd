library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all; 

entity counter_unit is
generic (
         max_count : integer :=20000000;
         nb_bit : integer := 28
         --max_count : integer :=4;
         --nb_bit : integer := 3
         );
    port ( 
		clk			: in std_logic; 
        resetn		: in std_logic; 
          
        end_counter	 : out std_logic
     );
end counter_unit;

architecture behavioral of counter_unit is
    
     signal Q : std_logic_vector((nb_bit-1) downto 0);
     signal end_count : std_logic;

begin 
		--Partie sequentielle
		process(clk,resetn)
		begin
			if(resetn = '1') then 
			Q	<=(others => '0');
			
			elsif(rising_edge(clk)) then
			
			   Q <= Q+ 1;
			   if(end_count= '1') then
			 Q	<=(others => '0');
			  
			end if;
			end if;
			
		end process;
		
		--Partie combinatoire
	  end_count <= '1' when (Q =(max_count)-1)
                else '0';
             
    end_counter <= end_count;		
						
 end behavioral;
