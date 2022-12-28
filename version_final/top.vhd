library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
port(
    AZUL,ROJO,VERDE:out std_logic;
    
    clk, reset: in std_logic;
    inicio_compra:in std_logic;
    --Botones
    pushbotton_50: in std_logic;
    pushbotton_1: in std_logic;
    pushbotton_2: in std_logic;
    
    --Switches
    sw1: in std_logic;
    sw2: in std_logic;
    sw3: in std_logic;
    sw4: in std_logic;
    
    --Salidas
    digsel : out STD_LOGIC_VECTOR (7 downto 0);
    --digctrl : out STD_LOGIC_VECTOR (7 downto 0);
    segment : out STD_LOGIC_VECTOR (7 downto 0)
    
  );  
--  Port ( );
end top;


architecture Behavioral of top is


--SEÑALES DE LOS SINCRONIZADORES, DEBOUNCERS Y EDGE DETECTOR
 

signal sincro_debouncer50: std_logic;
signal debouncer_edge50: std_logic; 
signal edge_prod50:std_logic;  

signal sincro_debouncer1: std_logic;
signal debouncer_edge1: std_logic; 
signal edge_prod1:std_logic;  

signal sincro_debouncer2: std_logic;
signal debouncer_edge2: std_logic; 
signal edge_prod2:std_logic;  

--$$$$$$$$$$$$$$$$$$$$$



--SEÑAL DEL SELECTOR DE PRODUCTO
signal sal_selproducto: std_logic_vector (1 downto 0);


--Señal para agrupar las entradas del dinero en un vector 
--signal monedas: std_logic_vector(3 downto 0);



--Señal para el cambio p1 
signal cambio1: std_logic_vector(1 downto 0);
--Señal para el cambio p2 
signal cambio2: std_logic_vector(1 downto 0);
--Señal para el cambio p3 
signal cambio3: std_logic_vector(1 downto 0);


--Señal salida dar 1
signal darp1: std_logic;
--Señal salida dar 2
signal darp2: std_logic;
--Señal salida dar 3
signal darp3: std_logic;


signal falta1:  std_logic; --s1 
signal falta2:  std_logic_vector(1 downto 0); --s1 s2 s4
signal falta3:  std_logic_vector(1 downto 0); --s1 s2 s4

--Sincronizador

COMPONENT sincronizador
    port(  
           CLK : in STD_LOGIC;
           SYNC_IN : in std_logic;
           SYNC_OUT : out STD_LOGIC;
           reset: in std_logic
    );
END COMPONENT; 

--Debouncer

COMPONENT debouncer
    port(
        CLK    : in std_logic;
	   btn_in	: in std_logic;
	   btn_out	: out std_logic;
	   reset: in std_logic
    );
END COMPONENT;

--Detector de flanco

COMPONENT edge_detector
    port( 
          clk: in std_logic;
          sync_in: in std_logic;
          edge: out std_logic;
          reset: in std_logic
    );
    END COMPONENT;

--FSM PRODUCTOS

COMPONENT Producto1
    port(  
     reset, clk:in std_logic;
     dinero: in std_logic_vector(2 downto 0);
     s_eleccion: in std_logic_vector (1 downto 0);
     cambiop1: out std_logic_vector(1 downto 0);
     darp1: out std_logic;
     inicio_compra:in std_logic;
     falta: out std_logic --s1
    );
END COMPONENT;       
    
  COMPONENT Producto2
    port(  
     reset, clk:in std_logic;
     dinero: in std_logic_vector(2 downto 0);
     s_eleccion: in std_logic_vector (1 downto 0);
     cambiop2: out std_logic_vector(1 downto 0);
     darp2: out std_logic;
     inicio_compra:in std_logic;
     falta: out std_logic_vector(1 downto 0) --s1 s2 s4
         );
END COMPONENT;  

COMPONENT Producto3
    port(  
     reset, clk:in std_logic;
     dinero: in std_logic_vector(2 downto 0);
     s_eleccion: in std_logic_vector (1 downto 0);
     cambiop3: out std_logic_vector(1 downto 0);
     darp3: out std_logic;
     inicio_compra:in std_logic;
     falta: out std_logic_vector(1 downto 0) --s1 s2 s4
    );
END COMPONENT; 

--SELECTOR DE PRODUCTO

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

--CONTROL DEL DISPLAY

COMPONENT Display_Control
    PORT (
          cambio1: in std_logic_vector(1 downto 0);
          cambio2: in std_logic_vector(1 downto 0);
          cambio3: in std_logic_vector(1 downto 0);
          darp1: in std_logic;
          darp2: in std_logic;
          darp3: in std_logic;
          AZUL: out std_logic;
          ROJO: out std_logic;
          VERDE: out std_logic;
          clk: IN std_logic;
          reset: in std_logic;
          seleccion_display: in std_logic_vector(1 downto 0);
          digsel : OUT std_logic_vector(7 DOWNTO 0); --digitos
          segmentos : OUT std_logic_vector(7 DOWNTO 0); --teniendo en cuenta el punto del display será vector de 8 bits
          falta1: in std_logic; --s1 
          falta2:  in std_logic_vector(1 downto 0); --s1 s2 s4
          falta3: in std_logic_vector(1 downto 0)--s1 s2 s4
        );
      
END COMPONENT;


  




begin


--monedas(0)<=pushbotton_50;
--monedas(1)<=pushbotton_1;
--monedas(2)<=pushbotton_2;
  
   --INSTANCIACIÓN DE LAS ENTIDADES SINCRONIZADOR

                            
inst_sincronizador50: SINCRONIZADOR port map(
                            clk=>clk,
                            sync_in=>pushbotton_50,
                            sync_out=>sincro_debouncer50,
                            reset=>reset);                            

inst_sincronizador1: SINCRONIZADOR port map(
                            clk=>clk,
                            sync_in=>pushbotton_1,
                            sync_out=>sincro_debouncer1,
                            reset=>reset);

inst_sincronizador2: SINCRONIZADOR port map(
                            clk=>clk,
                            sync_in=>pushbotton_2,
                            sync_out=>sincro_debouncer2,
                            reset=>reset);  
                            
   --INSTANCIACIÓN DE LAS ENTIDADES DEBOUNCER                                                      

inst_debouncer50: DEBOUNCER port map(
                            CLK=>clk,
                            btn_in=>sincro_debouncer50,
                            btn_out=>debouncer_edge50,
                            reset=>reset);
                            
inst_debouncer1: DEBOUNCER port map(
                            CLK=>clk,
                            btn_in=>sincro_debouncer1,
                            btn_out=>debouncer_edge1,
                            reset=>reset);
                            
inst_debouncer2: DEBOUNCER port map(
                            CLK=>clk,
                            btn_in=>sincro_debouncer2,
                            btn_out=>debouncer_edge2,
                            reset=>reset);
                            
                            
       --INSTANCIACIÓN DE LAS ENTIDADES EDGE DETECTOR                       
                                                                                   
                            
inst_edge_detector50: EDGE_DETECTOR port map(
                            CLK=>clk,
                            sync_in=>debouncer_edge50,
                            edge=>edge_prod50,
                            reset=>reset
                            );
                            
 inst_edge_detector1: EDGE_DETECTOR port map(
                            CLK=>clk,
                            sync_in=>debouncer_edge1,
                            edge=>edge_prod1,
                            reset=>reset
                            );
                            
inst_edge_detector2: EDGE_DETECTOR port map(
                            CLK=>clk,
                            sync_in=>debouncer_edge2,
                            edge=>edge_prod2,
                            reset=>reset
                            );                                                       
 
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
                           
--INSTANCIACION FSM PRODUCTOS

inst_producto1: PRODUCTO1 port map(
                            clk=>clk,
                            reset=>reset,
                            dinero(0)=>edge_prod50,
                            dinero(1)=>edge_prod1,
                            dinero(2)=>edge_prod2,
                            s_eleccion=>sal_selproducto,
                            cambiop1=>cambio1,
                            darp1=>darp1,
                            inicio_compra=>inicio_compra,
                            falta=>falta1
                            );

inst_producto2: PRODUCTO2 port map(
                            clk=>clk,
                            reset=>reset,
                            dinero(0)=>edge_prod50,
                            dinero(1)=>edge_prod1,
                            dinero(2)=>edge_prod2,
                            s_eleccion=>sal_selproducto,
                            cambiop2=>cambio2,
                            darp2=>darp2,
                            inicio_compra=>inicio_compra,
                            falta=>falta2
                            );                       

inst_producto3: PRODUCTO3 port map(
                            clk=>clk,
                            reset=>reset,
                            dinero(0)=>edge_prod50,
                            dinero(1)=>edge_prod1,
                            dinero(2)=>edge_prod2,
                            s_eleccion=>sal_selproducto,
                            cambiop3=>cambio3,
                            darp3=>darp3,
                            inicio_compra=>inicio_compra,
                            falta=>falta3
                            );

--INSTANCIACION DISPLAY

inst_display_control : Display_Control PORT MAP (
                            cambio1=>cambio1,
                            cambio2=>cambio2,
                            cambio3=>cambio3,
                            darp1=>darp1,
                            darp2=>darp2,
                            darp3=>darp3,
                            clk=>clk,
                            reset=>reset,
                            seleccion_display=>sal_selproducto,
                            digsel=>digsel,
                            AZUL=>AZUL,
                            ROJO=>ROJO,
                            VERDE=>VERDE,
                            segmentos=>segment,
                            falta1=>falta1,
                            falta2=>falta2,
                            falta3=>falta3
                            );
   


end Behavioral;

