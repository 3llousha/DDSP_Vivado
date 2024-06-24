-- 8bit Adder
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Entity declaration
entity Adder8Bit is
  
    Port ( A,B: in  STD_LOGIC_VECTOR (7 downto 0);  -- 8-bit input A,B
           Cin: in  STD_LOGIC; -- Carry-in input
           Cout: out  STD_LOGIC); -- Carry-out output
           Sum: out  STD_LOGIC_VECTOR (7 downto 0); -- 8-bit output Sum
  
end Adder8Bit;

-- Architecture definition
architecture Behavioral of Adder8Bit is
begin
process(A, B, Cin) -- Process for adding A and B with carry-in
  variable temp_sum : STD_LOGIC_VECTOR(8 downto 0); -- Temporary variable that allows for a 9th bit for overflow  
begin
      
        temp_sum := ('0' & A) + ('0' & B) + Cin;   -- Add A, B, and Cin
        Sum <= temp_sum(7 downto 0);  -- Assign the lower 8 bits to Sum
        Cout <= temp_sum(8);-- Assign the 9th bit to Cout

    end process;
end Behavioral;

