-- Testbench for Microcontroller
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_Microcontroller is
end tb_Microcontroller;

architecture Behavioral of tb_Microcontroller is
    signal CLK,RESET         : STD_LOGIC := '0';
    signal INSTRUCTION : STD_LOGIC_VECTOR (3 downto 0);
    signal IN_PORT0,IN_PORT1    : STD_LOGIC_VECTOR (7 downto 0);
    signal OUT_PORT0,OUT_PORT1   : STD_LOGIC_VECTOR (7 downto 0);

    constant CLK_PERIOD : time := 10 ns;

    component Microcontroller
        Port ( CLK,RESET       : in  STD_LOGIC;
               INSTRUCTION : in  STD_LOGIC_VECTOR (3 downto 0);
               IN_PORT0,IN_PORT1    : in  STD_LOGIC_VECTOR (7 downto 0);
               OUT_PORT0,OUT_PORT1  : out STD_LOGIC_VECTOR (7 downto 0);
    end component;

begin
    uut: Microcontroller
        Port map (
            CLK => CLK,
            RESET => RESET,
            INSTRUCTION => INSTRUCTION,
            IN_PORT0 => IN_PORT0,
            IN_PORT1 => IN_PORT1,
            OUT_PORT0 => OUT_PORT0,
            OUT_PORT1 => OUT_PORT1
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

        -- Load IN_PORT0 and IN_PORT1
        IN_PORT0 <= "00000001"; -- 1
        IN_PORT1 <= "00000010"; -- 2

        -- Test ADD instruction
        INSTRUCTION <= "0001";  -- ADD IN_PORT0 and IN_PORT1, store result in A
        wait for 50 ns;

        -- Check result
        assert (OUT_PORT0 = "00000011") report "Test failed: ADD instruction" severity error;

        -- Test SUB instruction
        INSTRUCTION <= "0010";  -- SUB IN_PORT1 from IN_PORT0, store result in B
        wait for 50 ns;

        -- Check result
        assert (OUT_PORT1 = "11111111") report "Test failed: SUB instruction" severity error;

        wait;
    end process;

end Behavioral;
