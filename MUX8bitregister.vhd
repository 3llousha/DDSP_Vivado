-- 4-to-1 Multiplexer for 8-bit Signals
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux4x8 is
    Port ( S : in  STD_LOGIC_VECTOR (1 downto 0);
           D0,D1,D2,D3 : in  STD_LOGIC_VECTOR (7 downto 0);
           Y : out  STD_LOGIC_VECTOR (7 downto 0));
end Mux4x8;

architecture Behavioral of Mux4x8 is
begin
    process (S, D0, D1, D2, D3)
    begin
        case S is
            when "00" => Y <= D0;
            when "01" => Y <= D1;
            when "02" => Y <= D2;
            when others => Y <= D3;
        end case;
    end process;
end Behavioral;
