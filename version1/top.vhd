----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.11.2022 14:17:17
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
port(
    LED: out std_logic;
    clk, reset: in std_logic;
    pushbotton_dinero: in std_logic_vector(1 downto 0);
    pushbotton_producto: in std_logic_vector (1 downto 0)
    
  );  
--  Port ( );
end top;

architecture Behavioral of top is
    signal sinc_inout : std_logic;
    signal edge_inout: std_logic_vector(1 downto 0);
    signal trab_p1: std_logic_vector (1 downto 0);
    signal trab_p2: std_logic_vector (1 downto 0);
    signal trab_p3: std_logic_vector (1 downto 0);
    
COMPONENT edge_detector
    port( clk: in std_logic;
          sync_in: in std_logic;
          edge: in std_logic
    );
END COMPONENT;

COMPONENT sincronizador
    port( clk: in std_logic;
          sync_in: in std_logic;
          edge: in std_logic
    );
END COMPONENT; 

COMPONENT edge_detector
    port( clk: in std_logic;
          sync_in: in std_logic;
          edge: in std_logic
    );
END COMPONENT;       
    
begin
    

end Behavioral;
