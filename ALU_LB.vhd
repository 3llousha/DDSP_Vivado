---- ALU Logic Block
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Entity declaration for logic_block
entity logic_block is
    Port ( A,B : in  STD_LOGIC_VECTOR (7 downto 0);  -- 8-bit input A
           Sel : in  STD_LOGIC_VECTOR (1 downto 0); -- 2-bit select input
           Y : out  STD_LOGIC_VECTOR (7 downto 0)); -- 8-bit output
end logic_block;

-- Architecture definition for logic_block
architecture Behavioral of logic_block is
begin
    -- Process for logical operations based on select signal
    process(A, B, Sel)
    begin
        case Sel is
            when "00" => Y <= A and B;  -- AND 
            when "01" => Y <= A or B;   -- OR 
            when "10" => Y <= not A;    -- NOT 
            when others => Y <= (others => '0'); -- Default
        end case;
    end process;
end Behavioral;
