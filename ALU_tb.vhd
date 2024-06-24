library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_ALU is
end tb_ALU;

architecture Behavioral of tb_ALU is -- Architecture definition for the testbench
    component ALU
        Port ( A,B : in  STD_LOGIC_VECTOR (7 downto 0);
               Cin : in  STD_LOGIC;
               Sel : in  STD_LOGIC_VECTOR (1 downto 0);
               Y : out  STD_LOGIC_VECTOR (7 downto 0);
               Cout : out  STD_LOGIC);
    end component;
    
    signal A, B : STD_LOGIC_VECTOR(7 downto 0);     -- Signals to connect to ALU
    signal Cin : STD_LOGIC;
    signal Sel : STD_LOGIC_VECTOR(1 downto 0);
    signal Y : STD_LOGIC_VECTOR(7 downto 0);
    signal Cout : STD_LOGIC;
begin

    uut: ALU Port map ( -- Unit Under Test
        A => A,
        B => B,
        Cin => Cin,
        Sel => Sel,
        Y => Y,
        Cout => Cout
    );
    process
    begin
        -- Test case  A + B = 2,  A = 1, B = 1, Cin = 0, Sel = 00
        A <= "00000001"; B <= "00000001"; Cin <= '0'; Sel <= "00";
wait;
    end process;
end Behavioral;
