-- Testbench for 8 bit Adder
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity tb_Adder8Bit is
end tb_Adder8Bit;

-- Architecture definition 
architecture Behavioral of tb_Adder8Bit is
    component Adder8Bit
        Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
               B : in  STD_LOGIC_VECTOR (7 downto 0);
               Cin : in  STD_LOGIC;
               Sum : out  STD_LOGIC_VECTOR (7 downto 0);
               Cout : out  STD_LOGIC);
    end component;

    -- Signals to connect to Adder8Bit
    signal A,B : STD_LOGIC_VECTOR(7 downto 0);
    signal Cin : STD_LOGIC;
    signal Sum : STD_LOGIC_VECTOR(7 downto 0);
    signal Cout : STD_LOGIC;

begin
    -- Instantiate Adder8Bit
    uut: Adder8Bit Port map ( -- unit under test
        A => A,
        B => B,
        Cin => Cin,
        Sum => Sum,
        Cout => Cout
    );

    -- Stimulus process to test Adder8Bit
    process
    begin
        -- Test case 1: A = 1, B = 1, Cin = 0: Sum = 2 -- Cout = 0
        A <= "00000001"; B <= "00000001"; Cin <= '0';
        wait for 10 ns;

        -- Test case 2: A = 1, B = 1, Cin = 1: Sum = 3, Cout = 0
        A <= "00000001"; B <= "00000001"; Cin <= '1';
        wait for 10 ns;

        -- Test case 3: A = 255, B = 1, Cin = 0: Sum = 0, Cout = 1
        A <= "11111111"; B <= "00000001"; Cin <= '0';
        wait for 10 ns;

        -- Test case 4: A = 255, B = 1, Cin = 1: Expected Sum = 1 , Cout = 1
        A <= "11111111"; B <= "00000001"; Cin <= '1';
        wait for 10 ns;

        wait;
    end process;
end Behavioral;
