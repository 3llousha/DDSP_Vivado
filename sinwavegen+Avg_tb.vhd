-- This is a testbench to verify the functionality of the SineWavePWM_AVG_System module.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_SineWavePWM_AVG_System is
end tb_SineWavePWM_AVG_System;

architecture Behavioral of tb_SineWavePWM_AVG_System is
    signal CLK,RESET          : STD_LOGIC := '0';
    signal FREQ_DIV     : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal PWM_OUT      : STD_LOGIC;
    signal AVG_OUT      : STD_LOGIC_VECTOR (7 downto 0);

    component SineWavePWM_AVG_System
        Port ( CLK,RESET  : in  STD_LOGIC;
               FREQ_DIV     : in  STD_LOGIC_VECTOR (3 downto 0);
               PWM_OUT      : out STD_LOGIC;
               AVG_OUT      : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instantiate the SineWavePWM_AVG_System module
    uut: SineWavePWM_AVG_System Port map (
        CLK => CLK,
        RESET => RESET,
        FREQ_DIV => FREQ_DIV,
        PWM_OUT => PWM_OUT,
        AVG_OUT => AVG_OUT
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
        FREQ_DIV <= "0001"; -- Fast frequency
        wait for 500 * CLK_PERIOD;

        FREQ_DIV <= "0010"; -- Medium frequency
        wait for 500 * CLK_PERIOD;

        FREQ_DIV <= "0100"; -- Slow frequency
        wait for 500 * CLK_PERIOD;

        wait;
    end process;

end Behavioral;
