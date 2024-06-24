-- This is a testbench to verify the functionality of the SineWaveGenerator module.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_SineWaveGenerator is
end tb_SineWaveGenerator;

architecture Behavioral of tb_SineWaveGenerator is
    signal CLK,RESET          : STD_LOGIC := '0';
    signal FREQ_DIV     : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal PWM_OUT      : STD_LOGIC;

    component SineWaveGenerator
        Port ( CLK,RESET          : in  STD_LOGIC;
               FREQ_DIV     : in  STD_LOGIC_VECTOR (7 downto 0);
               PWM_OUT      : out STD_LOGIC);
    end component;

    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instantiate the SineWaveGenerator module
    uut: SineWaveGenerator Port map (
        CLK => CLK,
        RESET => RESET,
        FREQ_DIV => FREQ_DIV,
        PWM_OUT => PWM_OUT
    );

    -- Clock process to generate a clock signal
    clk_process : process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Stimulus process to apply test vectors
    stim_proc: process
    begin
        -- Apply reset
        RESET <= '1';
        wait for 20 ns;
        RESET <= '0';
        wait for 20 ns;

        -- Test different frequency dividers
        FREQ_DIV <= "00000001"; -- Fast frequency
        wait for 500 * CLK_PERIOD;

        FREQ_DIV <= "00010000"; -- Medium frequency
        wait for 500 * CLK_PERIOD;

        FREQ_DIV <= "11111111"; -- Slow frequency
        wait for 500 * CLK_PERIOD;

        wait;
    end process;

end Behavioral;
