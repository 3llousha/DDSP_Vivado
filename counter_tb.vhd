-- Testbench for 8-bit Up/Down Counter with Reset
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_UpDownCounter is
end tb_UpDownCounter;

architecture Behavioral of tb_UpDownCounter is
    signal CLK    : STD_LOGIC := '0';
    signal RESET  : STD_LOGIC := '0';
    signal UP_DOWN: STD_LOGIC := '0';
    signal COUNT  : STD_LOGIC_VECTOR (7 downto 0);

    constant CLK_PERIOD : time := 10 ns;

    component UpDownCounter
        Port ( CLK    : in  STD_LOGIC;
               RESET  : in  STD_LOGIC;
               UP_DOWN: in  STD_LOGIC;
               COUNT  : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

begin
    uut: UpDownCounter Port map (
        CLK    => CLK,
        RESET  => RESET,
        UP_DOWN=> UP_DOWN,
        COUNT  => COUNT
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
        -- Apply reset
        RESET <= '1';
        wait for 20 ns;
        RESET <= '0';
        wait for 20 ns;

        -- Test counting up
        UP_DOWN <= '1';  -- Count up
        wait for 100 ns;

        -- Apply reset again
        RESET <= '1';
        wait for 20 ns;
        RESET <= '0';
        wait for 20 ns;

        -- Test counting down
        UP_DOWN <= '0';  -- Count down
        wait for 100 ns;

        wait;
    end process;

end Behavioral;
