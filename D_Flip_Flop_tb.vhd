-- Testbench for D Flip-Flop with Asynchronous Reset and Preset
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_DFlipFlop is
end tb_DFlipFlop;

architecture Behavioral of tb_DFlipFlop is
    signal D     : STD_LOGIC := '0';
    signal CLK   : STD_LOGIC := '0';
    signal RESET : STD_LOGIC := '0';
    signal PRESET: STD_LOGIC := '0';
    signal Q     : STD_LOGIC;

    constant CLK_PERIOD : time := 10 ns;

    component DFlipFlop
        Port ( D     : in  STD_LOGIC;
               CLK   : in  STD_LOGIC;
               RESET : in  STD_LOGIC;
               PRESET: in  STD_LOGIC;
               Q     : out STD_LOGIC);
    end component;

begin
    uut: DFlipFlop Port map (
        D     => D,
        CLK   => CLK,
        RESET => RESET,
        PRESET=> PRESET,
        Q     => Q
    );

    -- Clock process
    clk_process : process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Apply asynchronous reset
        RESET <= '1';
        wait for 20 ns;
        RESET <= '0';
        wait for 20 ns;

        -- Apply asynchronous preset
        PRESET <= '1';
        wait for 20 ns;
        PRESET <= '0';
        wait for 20 ns;

        -- Test normal D flip-flop behavior
        D <= '1';
        wait for CLK_PERIOD;
        D <= '0';
        wait for CLK_PERIOD;
        D <= '1';
        wait for CLK_PERIOD;

        -- Apply asynchronous reset during clock high
        RESET <= '1';
        wait for 10 ns;
        RESET <= '0';
        wait for 20 ns;

        -- Apply asynchronous preset during clock high
        PRESET <= '1';
        wait for 10 ns;
        PRESET <= '0';
        wait for 20 ns;

        wait;
    end process;

end Behavioral;
