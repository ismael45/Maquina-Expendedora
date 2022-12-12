----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.11.2022 12:16:27
-- Design Name: 
-- Module Name: trab - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sel_producto is
Port(
    reset, clk: in std_logic;
    eleccion_producto: in std_logic_vector(1 downto 0);
    precio: out std_logic_vector(1 downto 0)
);
--  Port ( );
end sel_producto;

architecture Behavioral of sel_producto is
    type state_type is (s0, s1, s2, s3);
    signal current_s, next_s: state_type;

    begin
    process(clk, reset)
        begin
            if(rising_edge(clk) and reset='1') then 
            current_s <= s0;
            elsif (rising_edge(clk)) then 
            current_s <= next_s;
            end if;
    end process;
    
process(current_s, eleccion_producto)
    begin
       case current_s is 
        when s0 =>
            precio <= "00";
            if(eleccion_producto = "00") then
                next_s <= s0;
            elsif (eleccion_producto = "01") then
                next_s <= s1; 
            elsif (eleccion_producto = "10") then
                next_s <= s2;
            elsif (eleccion_producto = "11") then
                next_s <= s3; 
            end if;
            
        when s1 =>
            precio <= "01";
        when s2 =>
            precio <= "10";
        when s3 =>
            precio <= "11";
       
        end case;   
end process;

end Behavioral;
