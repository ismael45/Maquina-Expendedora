library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Display_Control is
    PORT(
        cambio1: in std_logic_vector(1 downto 0);
        cambio2: in std_logic_vector(1 downto 0);
        cambio3: in std_logic_vector(1 downto 0);
        darp1: in std_logic;
        darp2: in std_logic;
        darp3: in std_logic;
        AZUL,ROJO,VERDE:out std_logic:='0';
         clk: in std_logic;
         reset: in std_logic;
         seleccion_display: in std_logic_vector(1 downto 0);
         digsel : OUT std_logic_vector(7 DOWNTO 0); --digitos
         segmentos : OUT std_logic_vector(7 DOWNTO 0); --teniendo en cuenta el punto del display será vector de 8 bits
          falta1: in std_logic; --s1 
          falta2:  in std_logic_vector(1 downto 0); --s1 s2 s4
          falta3: in std_logic_vector(1 downto 0)--s1 s2 s4
        );
end Display_Control;

architecture Behavioral of Display_Control is
    signal counter: natural range 0 to 18 :=0;
    signal clk_counter: natural range 0 to 20000 :=0;
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

    process(digitos, seleccion_display, cambio1, cambio2, cambio3, darp1, darp2, darp3, falta1,falta2,falta3 )
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
          
          --$$$$$$$$$$$$$PRODUCTO 1$$$$$$$$$$$$$$$
       if  darp1  = '1' then 
       AZUL<='1';  
          if cambio1="00" then 
            case digitos is --Cambio 00
                when 0=> 
                    segmentos<="01001001";--S
                    digsel<="11111110";
                when 1=> 
                    segmentos<="00000011";--O
                    digsel<="11111101";
                when 2=> 
                    segmentos<="11100011";--L
                    digsel<="11111011";
                when 3=> 
                    segmentos<="10000100";--D.
                    digsel<="11110111";  
                when 4=> 
                   segmentos<="01100011";--C
                   digsel<="11101111";     
                when 5=> 
                   segmentos<="11111111";--espacio
                   digsel<="11011111";    
                when 6=> 
                   segmentos<="00000011";--0
                   digsel<="10111111";       
                 when 7=>
                   segmentos<="01100001";--E
                   digsel <="01111111";
               end case;
             end if;   
            
            if cambio1="01" then 
                case digitos is --Cambio 0.5E
                when 0=> 
                    segmentos<="01001001";--S
                    digsel<="11111110";
                when 1=> 
                    segmentos<="00000011";--O
                    digsel<="11111101";
                when 2=> 
                    segmentos<="11100011";--L
                    digsel<="11111011";
                when 3=> 
                    segmentos<="10000100";--D.
                    digsel<="11110111";  
                when 4=> 
                   segmentos<="01100011";--C
                   digsel<="11101111";     
                when 5=> 
                   segmentos<="00000010";--0.
                   digsel<="11011111";      
                when 6=> 
                    segmentos<="01001001";--5
                    digsel<="10111111";   
                when 7=>
                   segmentos<="01100001";--E
                   digsel <="01111111";
               end case;           
              end if;     
             
              if cambio1="10" then 
            case digitos is --Cambio 1E
                when 0=> 
                    segmentos<="01001001";--S
                    digsel<="11111110";
                when 1=> 
                    segmentos<="00000011";--O
                    digsel<="11111101";
                when 2=> 
                    segmentos<="11100011";--L
                    digsel<="11111011";
                when 3=> 
                    segmentos<="10000100";--D.
                    digsel<="11110111";  
                when 4=> 
                   segmentos<="01100011";--C
                   digsel<="11101111";     
                when 5=> 
                   segmentos<="11111111";--espacio
                   digsel<="11011111";    
                when 6=> 
                   segmentos<="10011111";--1
                   digsel<="10111111";       
                 when 7=>
                   segmentos<="01100001";--E
                   digsel <="01111111";
               end case;
             end if;         
          
           if cambio1="11" then 
            case digitos is --Cambio 1.5E
                when 0=> 
                    segmentos<="01001001";--S
                    digsel<="11111110";
                when 1=> 
                    segmentos<="00000011";--O
                    digsel<="11111101";
                when 2=> 
                    segmentos<="11100011";--L
                    digsel<="11111011";
                when 3=> 
                    segmentos<="10000100";--D.
                    digsel<="11110111";  
                when 4=> 
                   segmentos<="01100011";--C
                   digsel<="11101111";     
                when 5=> 
                   segmentos<="10011110";--1.
                   digsel<="11011111";      
                when 6=> 
                    segmentos<="01001001";--5
                    digsel<="10111111";   
                when 7=>
                   segmentos<="01100001";--E
                   digsel <="01111111";
               end case;           
              end if;   
                
         end if;
         
          --$$$$$$$$$$$$$PRODUCTO 2$$$$$$$$$$$$$$$
          
         if  darp2   = '1' then   
         ROJO<='1';
          if cambio2="00" then 
            case digitos is --Cambio 00
                when 0=> 
                    segmentos<="01001001";--S
                    digsel<="11111110";
                when 1=> 
                    segmentos<="00000011";--O
                    digsel<="11111101";
                when 2=> 
                    segmentos<="11100011";--L
                    digsel<="11111011";
                when 3=> 
                    segmentos<="10000100";--D.
                    digsel<="11110111";  
                when 4=> 
                   segmentos<="01100011";--C
                   digsel<="11101111";     
                when 5=> 
                   segmentos<="11111111";--espacio
                   digsel<="11011111";    
                when 6=> 
                   segmentos<="00000011";--0
                   digsel<="10111111";       
                 when 7=>
                   segmentos<="01100001";--E
                   digsel <="01111111";
               end case;
             end if;   
            
            if cambio2="01" then 
            case digitos is --Cambio 0.5E
                when 0=> 
                    segmentos<="01001001";--S
                    digsel<="11111110";
                when 1=> 
                    segmentos<="00000011";--O
                    digsel<="11111101";
                when 2=> 
                    segmentos<="11100011";--L
                    digsel<="11111011";
                when 3=> 
                    segmentos<="10000100";--D.
                    digsel<="11110111";  
                when 4=> 
                   segmentos<="01100011";--C
                   digsel<="11101111";     
                when 5=> 
                   segmentos<="00000010";--0.
                   digsel<="11011111";      
                when 6=> 
                    segmentos<="01001001";--5
                    digsel<="10111111";   
                when 7=>
                   segmentos<="01100001";--E
                   digsel <="01111111";
               end case;           
              end if;     
             
              if cambio2="10" then 
            case digitos is --Cambio 1E
                when 0=> 
                    segmentos<="01001001";--S
                    digsel<="11111110";
                when 1=> 
                    segmentos<="00000011";--O
                    digsel<="11111101";
                when 2=> 
                    segmentos<="11100011";--L
                    digsel<="11111011";
                when 3=> 
                    segmentos<="10000100";--D.
                    digsel<="11110111";  
                when 4=> 
                   segmentos<="01100011";--C
                   digsel<="11101111";     
                when 5=> 
                   segmentos<="11111111";--espacio
                   digsel<="11011111";    
                when 6=> 
                   segmentos<="10011111";--1
                   digsel<="10111111";       
                 when 7=>
                   segmentos<="01100001";--E
                   digsel <="01111111";
               end case;
             end if;         
          
           if cambio2="11" then 
            case digitos is --Cambio 1.5E
                when 0=> 
                    segmentos<="01001001";--S
                    digsel<="11111110";
                when 1=> 
                    segmentos<="00000011";--O
                    digsel<="11111101";
                when 2=> 
                    segmentos<="11100011";--L
                    digsel<="11111011";
                when 3=> 
                    segmentos<="10000100";--D.
                    digsel<="11110111";  
                when 4=> 
                   segmentos<="01100011";--C
                   digsel<="11101111";     
                when 5=> 
                   segmentos<="10011110";--1.
                   digsel<="11011111";      
                when 6=> 
                    segmentos<="01001001";--5
                    digsel<="10111111";   
                when 7=>
                   segmentos<="01100001";--E
                   digsel <="01111111";
               end case;           
              end if;   
                
         end if;
         
          --$$$$$$$$$$$$$PRODUCTO 3$$$$$$$$$$$$$$$
         
         if  darp3  = '1' then   
         VERDE<='1';
          if cambio3="00" then 
            case digitos is --Cambio 00
                when 0=> 
                    segmentos<="01001001";--S
                    digsel<="11111110";
                when 1=> 
                    segmentos<="00000011";--O
                    digsel<="11111101";
                when 2=> 
                    segmentos<="11100011";--L
                    digsel<="11111011";
                when 3=> 
                    segmentos<="10000100";--D.
                    digsel<="11110111";  
                when 4=> 
                   segmentos<="01100011";--C
                   digsel<="11101111";     
                when 5=> 
                   segmentos<="11111111";--espacio
                   digsel<="11011111";    
                when 6=> 
                   segmentos<="00000011";--0
                   digsel<="10111111";       
                 when 7=>
                   segmentos<="01100001";--E
                   digsel <="01111111";
               end case;
             end if;   
            
            if cambio3="01" then 
            case digitos is --Cambio 0.5E
                when 0=> 
                    segmentos<="01001001";--S
                    digsel<="11111110";
                when 1=> 
                    segmentos<="00000011";--O
                    digsel<="11111101";
                when 2=> 
                    segmentos<="11100011";--L
                    digsel<="11111011";
                when 3=> 
                    segmentos<="10000100";--D.
                    digsel<="11110111";  
                when 4=> 
                   segmentos<="01100011";--C
                   digsel<="11101111";     
                when 5=> 
                   segmentos<="00000010";--0.
                   digsel<="11011111";      
                when 6=> 
                    segmentos<="01001001";--5
                    digsel<="10111111";   
                when 7=>
                   segmentos<="01100001";--E
                   digsel <="01111111";
               end case;           
              end if;     
             
              if cambio3="10" then 
            case digitos is --Cambio 1E
                when 0=> 
                    segmentos<="01001001";--S
                    digsel<="11111110";
                when 1=> 
                    segmentos<="00000011";--O
                    digsel<="11111101";
                when 2=> 
                    segmentos<="11100011";--L
                    digsel<="11111011";
                when 3=> 
                    segmentos<="10000100";--D.
                    digsel<="11110111";  
                when 4=> 
                   segmentos<="01100011";--C
                   digsel<="11101111";     
                when 5=> 
                   segmentos<="11111111";--espacio
                   digsel<="11011111";    
                when 6=> 
                   segmentos<="10011111";--1
                   digsel<="10111111";       
                 when 7=>
                   segmentos<="01100001";--E
                   digsel <="01111111";
               end case;
             end if;         
          
           if cambio3="11" then 
            case digitos is --Cambio 1.5E
                when 0=> 
                    segmentos<="01001001";--S
                    digsel<="11111110";
                when 1=> 
                    segmentos<="00000011";--O
                    digsel<="11111101";
                when 2=> 
                    segmentos<="11100011";--L
                    digsel<="11111011";
                when 3=> 
                    segmentos<="10000100";--D.
                    digsel<="11110111";  
                when 4=> 
                   segmentos<="01100011";--C
                   digsel<="11101111";     
                when 5=> 
                   segmentos<="10011110";--1.
                   digsel<="11011111";      
                when 6=> 
                    segmentos<="01001001";--5
                    digsel<="10111111";   
                when 7=>
                   segmentos<="01100001";--E
                   digsel <="01111111";
               end case;           
              end if;   
                
         end if;
         
         --$$$$$$$$$$$$$$$$$$$$$$$$$$$$--
         
         if  falta1  = '1' then   
             case digitos is --0.5_LEFT
                when 0=> 
                    segmentos<="00000010";--0.
                    digsel<="11111110";
                when 1=> 
                    segmentos<="01001001";--5
                    digsel<="11111101";
                when 2=> 
                    segmentos<="01100001";--E
                    digsel<="11111011";
                when 3=> 
                    segmentos<="11101111";--_
                    digsel<="11110111";  
                when 4=> 
                   segmentos<="11100011";--L
                   digsel<="11101111";     
                when 5=> 
                   segmentos<="01100001";--E
                   digsel<="11011111";    
                when 6=> 
                   segmentos<="01110001";--F
                   digsel<="10111111";       
                 when 7=>
                   segmentos<="11100001";--t
                   digsel <="01111111";
               end case;
             end if; 
             
             --producto 2 falta 0.5
              if  falta2  = "01" then   
             case digitos is --0.5_LEFT
                when 0=> 
                    segmentos<="00000010";--0.
                    digsel<="11111110";
                when 1=> 
                    segmentos<="01001001";--5
                    digsel<="11111101";
                when 2=> 
                    segmentos<="01100001";--E
                    digsel<="11111011";
                when 3=> 
                    segmentos<="11101111";--_
                    digsel<="11110111";  
                when 4=> 
                   segmentos<="11100011";--L
                   digsel<="11101111";     
                when 5=> 
                   segmentos<="01100001";--E
                   digsel<="11011111";    
                when 6=> 
                   segmentos<="01110001";--F
                   digsel<="10111111";       
                 when 7=>
                   segmentos<="11100001";--t
                   digsel <="01111111";
               end case;
             end if;
              
             --producto 2 falta 1e


           if  falta2  = "10" then   
             case digitos is --1e__LEFT
                when 0=> 
                    segmentos<="10011111";--1
                    digsel<="11111110";
                when 1=> 
                    segmentos<="01100001";--e
                    digsel<="11111101";
                when 2=> 
                    segmentos<="11101111";--_
                    digsel<="11111011";
                when 3=> 
                    segmentos<="11101111";--_
                    digsel<="11110111";  
                when 4=> 
                   segmentos<="11100011";--L
                   digsel<="11101111";     
                when 5=> 
                   segmentos<="01100001";--E
                   digsel<="11011111";    
                when 6=> 
                   segmentos<="01110001";--F
                   digsel<="10111111";       
                 when 7=>
                   segmentos<="11100001";--t
                   digsel <="01111111";
               end case;
             end if; 
             
             --producto 2 falta 1.5
              if  falta2  = "11" then   
             case digitos is --1.5_LEFT
                when 0=> 
                    segmentos<="10011110";--1.
                    digsel<="11111110";
                when 1=> 
                    segmentos<="01001001";--5
                    digsel<="11111101";
                when 2=> 
                    segmentos<="01100001";--E
                    digsel<="11111011";
                when 3=> 
                    segmentos<="11101111";--_
                    digsel<="11110111";  
                when 4=> 
                   segmentos<="11100011";--L
                   digsel<="11101111";     
                when 5=> 
                   segmentos<="01100001";--E
                   digsel<="11011111";    
                when 6=> 
                   segmentos<="01110001";--F
                   digsel<="10111111";       
                 when 7=>
                   segmentos<="11100001";--t
                   digsel <="01111111";
               end case;
             end if;
             
             
             --producto 3 falta 0.5e 
              if  falta3  = "01" then   
             case digitos is --0.5_LEFT
                when 0=> 
                    segmentos<="00000010";--0.
                    digsel<="11111110";
                when 1=> 
                    segmentos<="01001001";--5
                    digsel<="11111101";
                when 2=> 
                    segmentos<="01100001";--E
                    digsel<="11111011";
                when 3=> 
                    segmentos<="11101111";--_
                    digsel<="11110111";  
                when 4=> 
                   segmentos<="11100011";--L
                   digsel<="11101111";     
                when 5=> 
                   segmentos<="01100001";--E
                   digsel<="11011111";    
                when 6=> 
                   segmentos<="01110001";--F
                   digsel<="10111111";       
                 when 7=>
                   segmentos<="11100001";--t
                   digsel <="01111111";
               end case;
             end if; 
             --producto3 falta 1e
             if  falta3  = "10" then   
             case digitos is --1e__LEFT
                when 0=> 
                    segmentos<="10011111";--1
                    digsel<="11111110";
                when 1=> 
                    segmentos<="01100001";--e
                    digsel<="11111101";
                when 2=> 
                    segmentos<="11101111";--_
                    digsel<="11111011";
                when 3=> 
                    segmentos<="11101111";--_
                    digsel<="11110111";  
                when 4=> 
                   segmentos<="11100011";--L
                   digsel<="11101111";     
                when 5=> 
                   segmentos<="01100001";--E
                   digsel<="11011111";    
                when 6=> 
                   segmentos<="01110001";--F
                   digsel<="10111111";       
                 when 7=>
                   segmentos<="11100001";--t
                   digsel <="01111111";
               end case;
             end if;
             --producto 3 falta 1.5e
              if  falta3  = "11" then   
             case digitos is --1.5_LEFT
                when 0=> 
                    segmentos<="10011110";--1.
                    digsel<="11111110";
                when 1=> 
                    segmentos<="01001001";--5
                    digsel<="11111101";
                when 2=> 
                    segmentos<="01100001";--E
                    digsel<="11111011";
                when 3=> 
                    segmentos<="11101111";--_
                    digsel<="11110111";  
                when 4=> 
                   segmentos<="11100011";--L
                   digsel<="11101111";     
                when 5=> 
                   segmentos<="01100001";--E
                   digsel<="11011111";    
                when 6=> 
                   segmentos<="01110001";--F
                   digsel<="10111111";       
                 when 7=>
                   segmentos<="11100001";--t
                   digsel <="01111111";
               end case;
             end if;
             
             
    end process;
            
        
        

end Behavioral;
