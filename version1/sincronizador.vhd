----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.11.2022 14:09:36
-- Design Name: 
-- Module Name: sincronizador - Behavioral
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

entity sincronizador is
    Port ( CLK : in STD_LOGIC;
           SYNC_IN : in STD_LOGIC;
           SYNC_OUT : out STD_LOGIC);
end sincronizador;

architecture Behavioral of sincronizador is
    signal sreg : std_logic_vector(1 downto 0);
begin
    process (CLK)
    begin      
        if rising_edge(CLK) then
            SYNC_OUT <= sreg(1);
            sreg <= sreg(0) & SYNC_IN;
        end if;
    end process;
end Behavioral;

