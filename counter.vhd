-- 8-bit Up/Down Counter with Reset
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity UpDownCounter is
    Port ( CLK    : in  STD_LOGIC;
           RESET  : in  STD_LOGIC;
           UP_DOWN: in  STD_LOGIC;  -- '1' for Up, '0' for Down
           COUNT  : out STD_LOGIC_VECTOR (7 downto 0));
end UpDownCounter;

architecture Behavioral of UpDownCounter is
    signal count_reg : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
begin
    process (CLK, RESET)
    begin
        if RESET = '1' then
            count_reg <= (others => '0');  -- Reset the counter
        elsif rising_edge(CLK) then
            if UP_DOWN = '1' then
                count_reg <= count_reg + 1;  -- Count up
            else
                count_reg <= count_reg - 1;  -- Count down
            end if;
        end if;
    end process;

    COUNT <= count_reg;  -- Output the count value
end Behavioral;
