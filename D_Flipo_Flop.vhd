-- D Flip-Flop with Asynchronous Reset and Preset
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DFlipFlop is
    Port ( D     : in  STD_LOGIC;
           CLK   : in  STD_LOGIC;
           RESET : in  STD_LOGIC;  -- Asynchronous Reset
           PRESET: in  STD_LOGIC;  -- Asynchronous Preset
           Q     : out STD_LOGIC);
end DFlipFlop;

architecture Behavioral of DFlipFlop is
begin
    process (CLK, RESET, PRESET)
    begin
        if RESET = '1' then
            Q <= '0';  -- Reset the output
        elsif PRESET = '1' then
            Q <= '1';  -- Preset the output
        elsif rising_edge(CLK) then
            Q <= D;  -- Update output with D on rising edge of CLK
        end if;
    end process;
end Behavioral;
