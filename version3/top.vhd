
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
port(
    LED: out std_logic;
    
    clk, reset: in std_logic;
    
    --Botones
    pushbotton_0: in std_logic;
    pushbotton_50: in std_logic;
    pushbotton_1: in std_logic;
    pushbotton_2: in std_logic;
    
    --Switches
    sw1: in std_logic;
    sw2: in std_logic;
    sw3: in std_logic;
    sw4: in std_logic;
    
    digsel : in STD_LOGIC_VECTOR (7 downto 0);
    digctrl : out STD_LOGIC_VECTOR (7 downto 0);
    segment : out STD_LOGIC_VECTOR (6 downto 0)
    
  );  
--  Port ( );
end top;


architecture Behavioral of top is
--Señales intermedias de los sincronizadores
signal sinc_deb: std_logic_vector(3 downto 0);
--Señales para las salidas de los debouncers
signal deb_edge: std_logic_vector(3 downto 0); 
--Señales para las salidas de los detectores de flanco a los distintos productos
signal sal_edge:std_logic_vector(3 downto 0);  
--Señal para la salida de la elección de signal
signal sal_selproducto: std_logic_vector (1 downto 0);
--Señal para agrupar las entradas del dinero en un vector 
signal monedas: std_logic_vector(3 downto 0);
--Señal para el cambio p1 
signal cambio1: std_logic_vector(1 downto 0);
--Señal para el cambio p2 
signal cambio2: std_logic_vector(1 downto 0);
--Señal para el cambio p3 
signal cambio3: std_logic_vector(1 downto 0);




COMPONENT edge_detector
    port( 
          clk: in std_logic;
          sync_in: in std_logic;
          edge: out std_logic;
          reset: in std_logic
    );
END COMPONENT;

COMPONENT sincronizador
    port(  
           CLK : in STD_LOGIC;
           SYNC_IN : in std_logic;
           SYNC_OUT : out STD_LOGIC;
           reset: in std_logic
    );
END COMPONENT; 

COMPONENT DEBOUNCER
    port(
        CLK    : in std_logic;
	   btn_in	: in std_logic;
	   btn_out	: out std_logic;
	   reset: in std_logic
    );
END COMPONENT;

COMPONENT Producto1
    port(  
     reset, clk:in std_logic;
     dinero: in std_logic_vector(3 downto 0);
     s_eleccion: in std_logic_vector (1 downto 0);
     cambiop1: out std_logic_vector(1 downto 0);
     darp1: out std_logic
    );
END COMPONENT;       
    
  COMPONENT Producto2
    port(  
     reset, clk:in std_logic;
     dinero: in std_logic_vector(3 downto 0);
     s_eleccion: in std_logic_vector (1 downto 0);
     cambiop2: out std_logic_vector(1 downto 0);
     darp2: out std_logic
    );
END COMPONENT;  

COMPONENT Producto3
    port(  
     reset, clk:in std_logic;
     dinero: in std_logic_vector(3 downto 0);
     s_eleccion: in std_logic_vector (1 downto 0);
     cambiop3: out std_logic_vector(1 downto 0);
     darp3: out std_logic
    );
END COMPONENT; 

COMPONENT sel_producto 
Port(
    clk: in std_logic;
    reset: in std_logic;
    sw1: in std_logic;
    sw2: in std_logic;
    sw3: in std_logic;
    sw4: in std_logic;
    s_eleccion: out std_logic_vector(1 downto 0)
);
END COMPONENT;

COMPONENT display
    PORT (
        seleccion_display : IN std_logic_vector(1 DOWNTO 0);
        led : OUT std_logic_vector(6 DOWNTO 0));
END COMPONENT;

begin
--INSTANCIACION DEL SINCRONIZADOR, DEL DEBOUNCER Y DEL EDGE DETECTOR
--ASIGNACIÓN DE LOS BOTONES DE MONEDAS A CADA POSICIÓN DEL VECTOR
monedas(0)<=pushbotton_0;
monedas(1)<=pushbotton_50;
monedas(2)<=pushbotton_1;
monedas(3)<=pushbotton_2;
  
   --INSTANCIACIÓN DE LAS ENTIDADES SINCRONIZADOR, DEBOUNCER Y DETECTOR DE FLANCO PARA EL ACONDICIONAMIENTO
--DE LA SEÑAL PROCEDENTE DE LOS PULSADORES
acondicionamiento_botones: for i in 0 to 3 generate
inst_sincronizador: SINCRONIZADOR port map(
                            clk=>clk,
                            sync_in=>monedas(i),
                            sync_out=>sinc_deb(i),
                            reset=>reset);
                            
inst_debouncer: DEBOUNCER port map(
                            CLK=>clk,
                            btn_in=>sinc_deb(i),
                            btn_out=>deb_edge(i),
                            reset=>reset);
                            
inst_edge_detector: EDGE_DETECTOR port map(
                            CLK=>clk,
                            sync_in=>deb_edge(i),
                            edge=>sal_edge(i),
                            reset=>reset);
                            
end generate acondicionamiento_botones; 
 
--INSTANCIACIÓN DE SELECCION DE PRODUCTO

inst_selproducto: SEL_PRODUCTO port map(
                            clk=> clk,
                            reset=>reset,
                            sw1=>sw1,
                            sw2=>sw2,
                            sw3=>sw3,
                            sw4=>sw4,
                            s_eleccion=>sal_selproducto
                           );
                      
inst_producto1: PRODUCTO1 port map(
                            clk=>clk,
                            reset=>reset,
                            dinero=>sal_edge,
                            s_eleccion=>sal_selproducto,
                            cambiop1=>cambio1,
                            darp1=>LED);

inst_producto2: PRODUCTO2 port map(
                            clk=>clk,
                            reset=>reset,
                            dinero=>sal_edge,
                            s_eleccion=>sal_selproducto,
                            cambiop2=>cambio2,
                            darp2=>LED);                       

inst_producto3: PRODUCTO3 port map(
                            clk=>clk,
                            reset=>reset,
                            dinero=>sal_edge,
                            s_eleccion=>sal_selproducto,
                            cambiop3=>cambio3,
                            darp3=>LED);

inst_display : display PORT MAP (
                            seleccion_display=>sal_selproducto,
                            led => segment);
   
    

end Behavioral;
