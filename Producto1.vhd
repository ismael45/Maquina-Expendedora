----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.11.2022 13:10:33
-- Design Name: 
-- Module Name: Producto1 - Behavioral
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

entity Producto1 is
    port (
     reset, clk:in std_logic;
     dinerop1: in std_logic_vector(1 downto 0);
     cambiop1: out std_logic_vector(1 downto 0);
     darp1: out std_logic
         );
--  Port ( );
end Producto1;

architecture Behavioral of Producto1 is
    type STATES is (S0, S1, S2, S3, S4, S5);
  signal current_s: STATES;
  signal next_s: STATES;
begin
  state_register: process (RESET, CLK)
  begin
    if RESET = '1' then
      current_s <= S0;
    elsif CLK'event and CLK = '1' then
      current_s <= next_s;     
    end if;
  end process;

process(current_s, dinerop1)
    begin
    case current_s is
        when s0 =>
            cambiop1 <= "00";
            darp1 <= '0';
            if(dinerop1 = "00") then
                next_s <= s0;
            elsif(dinerop1 = "01") then
                next_s <= s1;
            elsif(dinerop1 = "10") then
                next_s <= s2;
            elsif(dinerop1 = "11") then
                next_s <= s3;
            end if;
       
       when s1=>
            cambiop1 <= "00";
            darp1 <= '0';
            if(dinerop1 = "00") then
                next_s <= s1;
            elsif(dinerop1 = "01") then
                next_s <= s2;
            elsif(dinerop1 = "10") then
                next_s <= s4;
            elsif(dinerop1 = "11") then
                next_s <= s5;
            end if;
       
       when s2 =>
            cambiop1 <= "00";
            darp1 <= '1';
            if(dinerop1 = "00") then
                next_s <= s0;
            elsif(dinerop1 = "01") then
                next_s <= s1;
            elsif(dinerop1 = "10") then
                next_s <= s2;
            elsif(dinerop1 = "11") then
                next_s <= s3;
            end if;
               
        when s3 =>
            cambiop1 <= "10";
            darp1 <= '1';
            if(dinerop1 = "00") then
                next_s <= s0;
            elsif(dinerop1 = "01") then
                next_s <= s1;
            elsif(dinerop1 = "10") then
                next_s <= s2;
            elsif(dinerop1 = "11") then
                next_s <= s3;
            end if;
        
        when s4 =>
            cambiop1 <= "01";
            darp1 <= '1';
            if(dinerop1 = "00") then
                next_s <= s0;
            elsif(dinerop1 = "01") then
                next_s <= s1;
            elsif(dinerop1 = "10") then
                next_s <= s2;
            elsif(dinerop1 = "11") then
                next_s <= s3; 
            end if;
                
        when s5 =>
            cambiop1 <= "11";
            darp1 <= '1';
            if(dinerop1 = "00") then
                next_s <= s0;
            elsif(dinerop1 = "01") then
                next_s <= s1;
            elsif(dinerop1 = "10") then
                next_s <= s2;
            elsif(dinerop1 = "11") then
                next_s <= s3;
            end if;
            
        end case;
    end process;  
end Behavioral;
