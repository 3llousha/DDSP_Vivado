-- Multiplexer Testbench
-- Testbench for 4-to-1 Multiplexer
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Entity declaration for the testbench
entity tb_mux4x8 is
end tb_mux4x8;

-- Architecture definition for the testbench
architecture Behavioral of tb_mux4x8 is
    -- Component declaration for mux4x8
    component mux4x8
        Port ( S : in  STD_LOGIC_VECTOR (1 downto 0);
               D0,D1,D2,D3 : in  STD_LOGIC_VECTOR (7 downto 0);
               Y : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;

    -- Signals to connect to mux4x8
    signal S : STD_LOGIC_VECTOR(1 downto 0);
    signal D0,D1,D2,D3 : STD_LOGIC_VECTOR(7 downto 0);
    signal Y : STD_LOGIC_VECTOR(7 downto 0);

begin
    -- Instantiate mux4x8
    uut: mux4x8 Port map (
        S => S,
        D0 => D0,
        D1 => D1,
        D2 => D2,
        D3 => D3,
        Y => Y
    );

    process
    begin
        -- Test case 1: Select D0; Y = D0 = 1
        S <= "00"; D0 <= "00000001"; D1 <= "00000010"; D2 <= "00000100"; D3 <= "00001000";
        wait for 10 ns;

        -- Test case 2: Select D1; Y = D1 = 2 
        S <= "01";
        wait for 10 ns;

        -- Test case 3: Select D2; Y = D2 = 4 
        S <= "10";
        wait for 10 ns;

        -- Test case 4: Select D3; Y = D3 = 8 
        S <= "11";
        wait for 10 ns;

        wait;
    end process;
end Behavioral;
