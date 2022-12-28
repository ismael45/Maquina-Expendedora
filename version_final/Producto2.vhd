library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Producto2 is
    port (
     reset, clk:in std_logic;
     dinero: in std_logic_vector(2 downto 0);
     s_eleccion: in std_logic_vector (1 downto 0);
     cambiop2: out std_logic_vector(1 downto 0);
     darp2: out std_logic:='0';
     inicio_compra:in std_logic;
     falta: out std_logic_vector(1 downto 0):="00" --s1 s2 s4
         );
--  Port ( );
end Producto2;

architecture Behavioral of Producto2 is
    type STATES is (S0, S1, S2, S3, S4, S5, S6);
  signal current_s: STATES:=s0;
  signal next_s: STATES;
begin
  state_register: process (RESET, CLK)
  begin
    if RESET = '0' OR inicio_compra='1' then
      current_s <= S0;
    elsif CLK'event and CLK = '1' then
      current_s <= next_s;     
    end if;
    
  end process;

process(current_s, dinero, s_eleccion)
    begin
    if (s_eleccion = "10") then
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
                next_s <= s4;
            elsif(dinero = "010") then
                next_s <= s3;
            elsif(dinero = "100") then
                next_s <= s6;
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
            
         when s6 =>
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
    
    
    output_decod: process (current_s)
    begin
        cambiop2 <= (OTHERS => '0');
        darp2<='0';
        case current_s is
            when S0 =>
                cambiop2 <= "00";
                darp2 <= '0';
                falta<="00";
            when S1 =>
                cambiop2 <= "00";
                darp2 <= '0';
                falta<="10";
            when S2 =>
                cambiop2 <= "00";
                darp2 <= '0';
                falta<="01";
            when S3 =>
                cambiop2 <= "01";
                darp2 <= '1';
                falta<="00";
            when S4 =>
                cambiop2 <= "00";
                darp2 <= '1';
                falta<="00";
             when S5 =>
                cambiop2 <= "10";
                darp2 <= '1';
                falta<="00";
             when S6 =>
                cambiop2 <= "11";
                darp2 <= '1';
                falta<="00";
        end case;
    end process;   


end Behavioral;

