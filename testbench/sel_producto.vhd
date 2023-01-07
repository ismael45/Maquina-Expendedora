library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sel_producto is
Port(
    clk, reset: in std_logic;
    sw1: in std_logic;
    sw2: in std_logic;
    sw3: in std_logic;
    sw4: in std_logic;
    s_eleccion: out std_logic_vector(1 downto 0)
);
--  Port ( );
end sel_producto;

architecture Behavioral of sel_producto is
        begin
       
    process(sw1, sw2, sw3, sw4)
        begin
        if(sw1='1') then
            s_eleccion<="00";--ningun producto elegido
            
        elsif(sw2='1') then
            s_eleccion<="01";--producto 1
            
        elsif(sw3='1') then
            s_eleccion<="10";--producto 2
            
        elsif(sw4='1') then
            s_eleccion<="11";--producto 3   
            
        end if;
    end process;

end Behavioral;