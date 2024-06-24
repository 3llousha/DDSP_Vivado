-- This is a testbench to verify the functionality of the PWM_Generator module.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_PWM_Generator is
end tb_PWM_Generator;

architecture Behavioral of tb_PWM_Generator is
    signal CLK,RESET     : STD_LOGIC := '0'; -- Test clock signal, Test reset signal
    signal DUTY    : STD_LOGIC_VECTOR (7 downto 0) := (others => '0'); -- Test duty cycle signal
    signal PWM_OUT : STD_LOGIC; -- Test PWM output signal

    -- Component declaration of the DUT (Device Under Test)
    component PWM_Generator
        Port ( CLK,RESET     : in  STD_LOGIC;
               DUTY    : in  STD_LOGIC_VECTOR (7 downto 0);
               PWM_OUT : out STD_LOGIC);
    end component;

    constant CLK_PERIOD : time := 10 ns; -- Clock period for simulation

begin
    -- Instantiate the PWM_Generator module
    uut: PWM_Generator Port map (
        CLK => CLK,
        RESET => RESET,
        DUTY => DUTY,
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

        -- Test different duty cycles
        DUTY <= "00000001"; -- 1/256 duty cycle
        wait for 256 * CLK_PERIOD;

        DUTY <= "10000000"; -- 128/256 duty cycle (50%)
        wait for 256 * CLK_PERIOD;

        DUTY <= "11111111"; -- 255/256 duty cycle
        wait for 256 * CLK_PERIOD;

        wait;
    end process;

end Behavioral;
