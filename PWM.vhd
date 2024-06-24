-- This module defines a PWM generator with 8-bit resolution.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PWM_Generator is
    Port ( CLK,RESET   : in  STD_LOGIC; -- Clock/Reset input
           DUTY    : in  STD_LOGIC_VECTOR (7 downto 0); -- Duty cycle input
           PWM_OUT : out STD_LOGIC  -- PWM output
           );
end PWM_Generator;

architecture Behavioral of PWM_Generator is
    signal counter : STD_LOGIC_VECTOR (7 downto 0) := (others => '0'); -- 8-bit counter
begin
    process(CLK, RESET)
    begin
        if RESET = '1' then
            -- Reset the counter and PWM output
            counter <= (others => '0');
            PWM_OUT <= '0';
        elsif rising_edge(CLK) then
            -- Increment the counter on each clock cycle
            counter <= counter + 1;
            -- Set PWM output based on the duty cycle
            if counter < DUTY then
                PWM_OUT <= '1';
            else
                PWM_OUT <= '0';
            end if;
        end if;
    end process;
end Behavioral;
