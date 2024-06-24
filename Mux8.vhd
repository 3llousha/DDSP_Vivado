-- Multiplexer
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Entity declaration for mux4x8
entity mux4x8 is
    Port ( 
      S : in  STD_LOGIC_VECTOR (1 downto 0);  -- select input
      D0,D1,D2,D3 : in  STD_LOGIC_VECTOR (7 downto 0); -- 8-bit inputs; D0-D3
      Y : out  STD_LOGIC_VECTOR (7 downto 0)); -- 8-bit output
end mux4x8;

-- Architecture definition for mux4x8
architecture Behavioral of mux4x8 is
begin
    -- Process for multiplexing inputs based on select signal
    process(S, D0, D1, D2, D3)
    begin
        case S is
            when "00" => Y <= D0; -- Select input D0
            when "01" => Y <= D1; -- Select input D1
            when "10" => Y <= D2; -- Select input D2
            when "11" => Y <= D3; -- Select input D3
            when others => Y <= (others => '0'); -- select to Default
        end case;
    end process;
end Behavioral;

