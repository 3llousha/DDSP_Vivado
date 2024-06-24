-- This is a testbench to verify the functionality of the ROM_SineWave module.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_ROM_SineWave is
end tb_ROM_SineWave;

architecture Behavioral of tb_ROM_SineWave is
    signal address : STD_LOGIC_VECTOR (4 downto 0); -- Test address signal
    signal data    : STD_LOGIC_VECTOR (7 downto 0); -- Test data signal

    -- Component declaration of the DUT (Device Under Test)
    component ROM_SineWave
        Port ( address : in  STD_LOGIC_VECTOR (4 downto 0);
               data    : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

begin
    -- Instantiate the ROM_SineWave module
    uut: ROM_SineWave Port map (
        address => address,
        data => data
    );

    -- Stimulus process to apply test vectors
    process
    begin
        -- Apply test vectors to the address input and observe the output
        for i in 0 to 31 loop
            address <= std_logic_vector(to_unsigned(i, 5));
            wait for 10 ns;
        end loop;
        wait;
    end process;
end Behavioral;
