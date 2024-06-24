--ALU 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port ( A,B : in  STD_LOGIC_VECTOR (7 downto 0);  -- 8bit inputs A/B
           Cin : in  STD_LOGIC;                     -- Carry-in input
           Sel : in  STD_LOGIC_VECTOR (1 downto 0); -- 2bit select input
           Y : out  STD_LOGIC_VECTOR (7 downto 0);  -- 8bit output
           Cout : out  STD_LOGIC);                  -- Carryout output
end ALU;

-- Architecture definition for ALU
architecture Structural of ALU is
    signal Sum : STD_LOGIC_VECTOR(7 downto 0);       -- Sum output from adder
    signal Cou_internal: STD_LOGIC;                -- Carryout from adder
    signal Logic_out : STD_LOGIC_VECTOR(7 downto 0); -- Output from logic block

    -- Component declaration for Adder8Bit
    component Adder8Bit
        Port ( A,B : in  STD_LOGIC_VECTOR (7 downto 0);
               Cin : in  STD_LOGIC;
               Sum : out  STD_LOGIC_VECTOR (7 downto 0);
               Cout : out  STD_LOGIC);
    end component;

    -- Component declaration for MUX
    component mux4x8
        Port ( S : in  STD_LOGIC_VECTOR (1 downto 0);
               D0,D1,D2,D3 : in  STD_LOGIC_VECTOR (7 downto 0);
               Y : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;

    -- Component declaration for logic_block
    component logic_block
        Port ( A,B : in  STD_LOGIC_VECTOR (7 downto 0);
               Sel : in  STD_LOGIC_VECTOR (1 downto 0);
               Y : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;

begin
    -- Instantiate Adder
    U1: Adder8Bit Port map ( A => A, B => B, Cin => Cin, Sum => Sum, Cout => Cout_internal);
      
    -- Instantiate logic_block
    U2: logic_block Port map ( A => A, B => B, Sel => Sel, Y => Logic_out);
      
    -- Instantiate MUX
    U3: mux4x8 Port map ( S => Sel, D0 => Sum, D1 => Logic_out, D2 => Logic_out, D3 => Logic_out, Y => Y);
      
    -- Assign carry-out based on select signal
    Cout <= Cout_internal when Sel = "00" else '0';
      
end Structural;
