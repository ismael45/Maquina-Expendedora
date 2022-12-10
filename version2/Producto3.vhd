----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.11.2022 13:54:27
-- Design Name: 
-- Module Name: Producto3 - Behavioral
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

entity Producto3 is
     port (
     reset, clk:in std_logic;
     dinero: in std_logic_vector(3 downto 0);
     s_eleccion: in std_logic_vector (1 downto 0);
     cambiop3: out std_logic_vector(1 downto 0);
     darp3: out std_logic
         );
--  Port ( );
end Producto3;

architecture Behavioral of Producto3 is

type STATES is (S0, S1, S2, S3, S4, S5, S6, S7);
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

process(current_s, dinero)
    begin
    if (s_eleccion = "11") then 
    case current_s is
        when s0 =>
            cambiop3 <= "00";
            darp3 <= '0';
            if(dinero = "0001") then
                next_s <= s0;
            elsif(dinero = "0010") then
                next_s <= s1;
            elsif(dinero = "0100") then
                next_s <= s2;
            elsif(dinero = "1000") then
                next_s <= s3;
            end if;
       
       when s1=>
            cambiop3 <= "00";
            darp3 <= '0';
            if(dinero = "0001") then
                next_s <= s1;
            elsif(dinero = "0010") then
                next_s <= s2;
            elsif(dinero = "0100") then
                next_s <= s4;
            elsif(dinero = "1000") then
                next_s <= s5;
            end if;
       
       when s2 =>
            cambiop3 <= "00";
            darp3 <= '0';
            if(dinero = "0001") then
                next_s <= s2;
            elsif(dinero = "0010") then
                next_s <= s4;
            elsif(dinero = "0100") then
                next_s <= s3;
            elsif(dinero = "1000") then
                next_s <= s6;
            end if;
               
        when s3 =>
            cambiop3 <= "00";
            darp3 <= '1';
            if(dinero = "0001") then
                next_s <= s0;
            elsif(dinero = "0010") then
                next_s <= s1;
            elsif(dinero = "0100") then
                next_s <= s2;
            elsif(dinero = "1000") then
                next_s <= s3;
            end if;
        
        when s4 =>
            cambiop3 <= "00";
            darp3 <= '0';
            if(dinero = "0001") then
                next_s <= s4;
            elsif(dinero = "0010") then
                next_s <= s3;
            elsif(dinero = "0100") then
                next_s <= s5;
            elsif(dinero = "1000") then
                next_s <= s7; 
            end if;
                
        when s5 =>
            cambiop3 <= "01";
            darp3 <= '1';
            if(dinero = "0001") then
                next_s <= s0;
            elsif(dinero = "0010") then
                next_s <= s1;
            elsif(dinero = "0100") then
                next_s <= s2;
            elsif(dinero = "1000") then
                next_s <= s3;
            end if;
            
         when s6 =>
            cambiop3 <= "10";
            darp3 <= '1';
            if(dinero = "0001") then
                next_s <= s0;
            elsif(dinero = "0010") then
                next_s <= s1;
            elsif(dinero = "0100") then
                next_s <= s2;
            elsif(dinero = "1000") then
                next_s <= s3;
            end if;
            
          when s7 =>
            cambiop3 <= "11";
            darp3 <= '1';
            if(dinero = "0001") then
                next_s <= s0;
            elsif(dinero = "0010") then
                next_s <= s1;
            elsif(dinero = "0100") then
                next_s <= s2;
            elsif(dinero = "1000") then
                next_s <= s3;
            end if;
            
        end case;
        end if;
    end process;  



end Behavioral;
