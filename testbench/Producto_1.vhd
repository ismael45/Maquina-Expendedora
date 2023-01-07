library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Producto1 is
    port (
     reset, clk:in std_logic;
     dinero: in std_logic_vector(2 downto 0);
     s_eleccion: in std_logic_vector (1 downto 0);
     cambiop1: out std_logic_vector(1 downto 0);
     darp1: out std_logic;
     inicio_compra:in std_logic;
     falta: out std_logic:='0' --s1
         );
--  Port ( );
end Producto1;

architecture Behavioral of Producto1 is
  type STATES is (S0, S1, S2, S3, S4, S5);
  signal current_s: STATES:=s0;
  signal next_s: STATES;
begin

 state_register: process (RESET, CLK, inicio_compra)
  begin
   if RESET = '0' OR inicio_compra='1' then
      current_s <= S0;
    elsif CLK'event and CLK = '1' then
      current_s <= next_s;     
    end if;
    
  end process;

--ESTADOS

nexstate_decod: process(current_s, dinero,s_eleccion)
begin
    if(s_eleccion= "01") then 
        next_s <= current_s;
        case current_s is
            when s0 =>
                if(dinero = "001") then
                    next_s <= s1;
                elsif(dinero = "010") then
                    next_s <= s2;
                elsif(dinero = "100") then
                    next_s <= s3;
                end if;
       
            when s1=>
                if(dinero = "001") then
                    next_s <= s2;
                elsif(dinero = "010") then
                    next_s <= s4;
                elsif(dinero = "100") then
                    next_s <= s5;
                end if;
           
            when s2 =>
            if(dinero = "001") then
                next_s <= s1;
            elsif(dinero = "010") then
                next_s <= s2;
            elsif(dinero = "100") then
                next_s <= s3;
            end if;
               
        when s3 =>
            if(dinero = "001") then
                next_s <= s1;
            elsif(dinero = "010") then
                next_s <= s2;
            elsif(dinero = "100") then
                next_s <= s3;
            end if;
        
        when s4 =>

            if(dinero = "001") then
                next_s <= s1;
            elsif(dinero = "010") then
                next_s <= s2;
            elsif(dinero = "100") then
                next_s <= s3; 
            end if;
                
        when s5 =>
            if(dinero = "001") then
                next_s <= s1;
            elsif(dinero = "010") then
                next_s <= s2;
            elsif(dinero = "100") then
                next_s <= s3;
            end if;
            
        end case;
        end if;
    end process;  
    
 --SALIDAS   
    
output_decod: process (current_s)
    begin
        cambiop1 <= (OTHERS => '0');
        darp1<='0';
        case current_s is
            when S0 =>
                cambiop1 <= "00";
                darp1 <= '0';
                falta<='0';
            when S1 =>
                cambiop1 <= "00";
                darp1 <= '0';
                falta<='1';
            when S2 =>
                cambiop1 <= "00";
                darp1 <= '1';
                falta<='0';
            when S3 =>
                cambiop1 <= "10";
                darp1 <= '1';
                falta<='0';
            when S4 =>
                cambiop1 <= "01";
                darp1 <= '1';
                falta<='0';
             when S5 =>
                cambiop1 <= "11";
                darp1 <= '1';  
                falta<='0'; 
        end case;
    end process;    
    
end Behavioral;