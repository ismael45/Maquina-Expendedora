library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity edge_detector is
    Port ( CLK : in STD_LOGIC;
           SYNC_IN : in STD_LOGIC;
           EDGE : out STD_LOGIC;
           reset: in std_logic);
end edge_detector;

architecture Behavioral of edge_detector is
        signal sreg : std_logic_vector(2 downto 0);
begin
    process (CLK, reset)
    begin
        if (reset='0') then
            sreg<="000";
        elsif rising_edge(CLK) then
            sreg <= sreg(1 downto 0) & SYNC_IN;
        end if;
    end process;
    with sreg select
    EDGE <= '1' when "100",
            '0' when others;
end Behavioral;

