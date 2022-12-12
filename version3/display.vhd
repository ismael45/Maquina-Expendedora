------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Display_Control is
    PORT(
        cambio1: in std_logic_vector(1 downto 0);
        cambio2: in std_logic_vector(1 downto 0);
        cambio3: in std_logic_vector(1 downto 0);
        dar1: in std_logic;
        dar2: in std_logic;
        dar3: in std_logic;
         clk: IN std_logic;
         reset: in std_logic;
         -- error: IN std_logic;
         --vending: IN std_logic;
         seleccion_display: in std_logic_vector(1 downto 0);
         --Venerr:in std_logic_vector(1 downto 0);
         digsel : OUT std_logic_vector(7 DOWNTO 0); --digitos
         segmentos : OUT std_logic_vector(7 DOWNTO 0) --teniendo en cuenta el punto del display será vector de 8 bits
        );
end Display_Control;

architecture Behavioral of Display_Control is
    signal counter: natural range 0 to 18 :=0;
    signal clk_counter: natural range 0 to 2000 :=0;
    signal digitos: natural range 0 to 7 :=0;
begin
    process(clk)
    begin
        --Periodo 1.6 ms-> clk_counter=160000
        if rising_edge(clk) then
            clk_counter<=clk_counter + 1;
            --periodo/8 = 0.2 ms -> clk_counter=20000
            if clk_counter>=20000 then
                clk_counter<=0;
                digitos<=digitos +1;
            end if;
            if digitos > 7 then
                digitos<=0;
            end if;
        end if;

    end process;

    process(digitos, seleccion_display, cambio1)
    begin 
        if seleccion_display = "01" then --P1_1E
            case digitos is
                    when 0=>
                        segmentos<="00110001"; --P
                        digsel <="11111110";
                    when 1=>
                        segmentos<="10011111"; --1
                        digsel <="11111101";
                    when 2=>
                        segmentos<="11101111"; --_
                        digsel <="11111011";
                     when 3=>
                        segmentos<="10011111"; --1
                        digsel <="11110111";
                     when 4=>
                        segmentos<="01100001"; --E
                        digsel <="11101111";
                    when others=>
                        segmentos<="11111111";--no muestra nada en display
                        digsel<="11111111";
                end case;
          end if;
          
          if seleccion_display = "10" then --P2_1.5E
            case digitos is
                    when 0=>
                        segmentos<="00110001"; --P
                        digsel <="11111110";
                    when 1=>
                        segmentos<="00100101"; --2
                        digsel <="11111101";
                    when 2=>
                        segmentos<="11101111"; --_
                        digsel <="11111011";
                     when 3=>
                        segmentos<="10011110"; --1.
                        digsel <="11110111";
                     when 4=>
                        segmentos<="01001001"; --5
                        digsel <="11101111";
                    when 5=>
                        segmentos<="01100001"; --E
                        digsel <="11011111";
               
                    when others=>
                        segmentos<="11111111";--no muestra nada en display
                        digsel<="11111111";
                end case;
          end if;
          
           if seleccion_display = "11" then --P3_2E
            case digitos is
                    when 0=>
                        segmentos<="00110001"; --P
                        digsel <="11111110";
                    when 1=>
                        segmentos<="00001101"; --3
                        digsel <="11111101";
                    when 2=>
                        segmentos<="11101111"; --_
                        digsel <="11111011";
                     when 3=>
                        segmentos<="00100101"; --2
                        digsel <="11110111";
                     when 4=>
                        segmentos<="01100001"; --E
                        digsel <="11101111";
                    when others=>
                        segmentos<="11111111";--no muestra nada en display
                        digsel<="11111111";
                end case;
          end if;
          
           if seleccion_display = "00" then --NO_SEL
            case digitos is
                    when 0=>
                        segmentos<="11010101";--N
                        digsel <="11111110";
                    when 1=>
                        segmentos<="00000011";--O
                        digsel <="11111101";
                    when 2=>
                        segmentos<="11101111";--_
                        digsel <="11111011";
                    when 3=>
                        segmentos<="01001001";--S
                        digsel <="11110111";
                    when 4=>
                        segmentos<="01100001";--E
                        digsel <="11101111";
                    when 5=>
                        segmentos<="11100011"; --L
                        digsel <="11011111";
                    when others=>
                        segmentos<="11111111";--no muestra nada en display
                        digsel<="11111111";
                end case;
          end if;
          
          --VENDIENDO Y CAMBIO
          
          if cambio1="01" then 
            case digitos is
                when 0=> 
                    segmentos<="";
                    digsel<="";
                when 1=> 
                    segmentos<="";
                    digsel<="";
                when 2=> 
                    segmentos<="";
                    digsel<="";
                when 3=> 
                    segmentos<="";
                    digsel<="";
                
            end case;
         end if;
    end process;
            
        
        

end Behavioral;