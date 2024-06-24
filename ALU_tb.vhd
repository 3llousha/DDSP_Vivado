library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Entity declaration for the testbench
entity tb_ALU is
end tb_ALU;

-- Architecture definition for the testbench
architecture Behavioral of tb_ALU is
    component ALU
        Port ( A,B : in  STD_LOGIC_VECTOR (7 downto 0);
               Cin : in  STD_LOGIC;
               Sel : in  STD_LOGIC_VECTOR (1 downto 0);
               Y : out  STD_LOGIC_VECTOR (7 downto 0);
               Cout : out  STD_LOGIC);
    end component;

    -- Signals to connect to ALU
    signal A, B : STD_LOGIC_VECTOR(7 downto 0);
    signal Cin : STD_LOGIC;
    signal Sel : STD_LOGIC_VECTOR(1 downto 0);
    signal Y : STD_LOGIC_VECTOR(7 downto 0);
    signal Cout : STD_LOGIC;

begin
    -- Unit Under Test
    uut: ALU Port map (
        A => A,
        B => B,
        Cin => Cin,
        Sel => Sel,
        Y => Y,
        Cout => Cout
    );


    process
    begin
        -- Test case 1: A + B = 2,  A = 1, B = 1, Cin = 0, Sel = 00
        A <= "00000001"; B <= "00000001"; Cin <= '0'; Sel <= "00";
        wait for 10 ns;

        -- Test case 2: A and B = 1, A = 1, B = 1, Sel = 01
        Sel <= "01";
        wait for 10 ns;

        -- Test case 3: A or B = 1 -- A = 1, B = 1, Sel = 10
        Sel <= "10";
        wait for 10 ns;

        -- Test case 4: Invert A (~1 = 254): A = 1 , Sel = 11
        Sel <= "11";
        wait for 10 ns;

        wait;
    end process;
end Behavioral;
