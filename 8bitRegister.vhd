-- 8-bit Register with Parallel Load
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register8 is
    Port ( D     : in  STD_LOGIC_VECTOR (7 downto 0);
           CLK   : in  STD_LOGIC;
           LOAD  : in  STD_LOGIC;
           Q     : out  STD_LOGIC_VECTOR (7 downto 0));
end Register8;

architecture Behavioral of Register8 is
    signal reg : STD_LOGIC_VECTOR (7 downto 0);
begin
    process (CLK)
    begin
        if rising_edge(CLK) then
            if LOAD = '1' then
                reg <= D;
            end if;
        end if;
    end process;
    Q <= reg;
end Behavioral;
