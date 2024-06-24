-- This module calculates the average of the PWM values over a window width.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity AVG_Module is
    Port ( CLK         : in  STD_LOGIC;                -- Clock input
           RESET       : in  STD_LOGIC;                -- Reset input
           ENABLE      : in  STD_LOGIC;                -- Enable input
           DATA_READY  : in  STD_LOGIC;                -- Data ready input
           PWM_IN      : in  STD_LOGIC;                -- PWM input
           AVG_OUT     : out STD_LOGIC_VECTOR (7 downto 0) -- Averaged output
           );
end AVG_Module;

architecture Behavioral of AVG_Module is
    signal sum_reg : STD_LOGIC_VECTOR (15 downto 0) := (others => '0'); -- 16-bit sum register
    signal count   : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');  -- 8-bit counter
begin
    process(CLK, RESET)
    begin
        if RESET = '1' then
            sum_reg <= (others => '0');
            count <= (others => '0');
            AVG_OUT <= (others => '0');
        elsif rising_edge(CLK) then
            if ENABLE = '1' then
                sum_reg <= sum_reg + std_logic_vector(to_unsigned(to_integer(unsigned(PWM_IN)), 16));
                count <= count + 1;
            end if;

            if DATA_READY = '1' then
                if count /= 0 then
                    AVG_OUT <= std_logic_vector(to_unsigned(to_integer(unsigned(sum_reg)) / to_integer(unsigned(count)), 8));
                end if;
                sum_reg <= (others => '0');
                count <= (others => '0');
            end if;
        end if;
    end process;
end Behavioral;
