library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_MooreFSM is
end tb_MooreFSM;

architecture Behavioral of tb_MooreFSM is
    signal CLK : STD_LOGIC := '0';
    signal RESET : STD_LOGIC := '0';
    signal INPUT : STD_LOGIC := '0';
    signal OUTPUT : STD_LOGIC;

    constant CLK_PERIOD : time := 10 ns;

    component MooreFSM
        Port ( CLK : in  STD_LOGIC;
               RESET : in  STD_LOGIC;
               INPUT : in  STD_LOGIC;
               OUTPUT : out  STD_LOGIC);
    end component;

begin
    uut: MooreFSM Port map (
        CLK => CLK,
        RESET => RESET,
        INPUT => INPUT,
        OUTPUT => OUTPUT
    );

    clk_process : process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_PERIOD/2;
            CLK <= '1';
            wait for CLK_PERIOD/2;
