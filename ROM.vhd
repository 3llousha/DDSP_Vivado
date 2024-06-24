library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ROM_SineWave is
    Port ( address : in  STD_LOGIC_VECTOR (4 downto 0);
           data    : out STD_LOGIC_VECTOR (7 downto 0));
end ROM_SineWave;

architecture Behavioral of ROM_SineWave is
    type rom_array is array (0 to 31) of STD_LOGIC_VECTOR (7 downto 0);
    constant ROM : rom_array := (
        "10000000", "11101100", "11111011", "11101100",
        "11001111", "10110010", "10001111", "01110011",
        "01010101", "00111101", "00101110", "00100111",
        "00100111", "00111110", "00111101", "01010101",
        "01110011", "10001111", "10110010", "11001111",
        "11101100", "11111011", "11100111", "10000000",
        "00011001", "00000101", "10010011", "00101100",
        "01001111", "01110010", "10001101", "10101001"
    );
begin
    process(address)
    begin
        data <= ROM(to_integer(unsigned(address)));
    end process;
end Behavioral;
