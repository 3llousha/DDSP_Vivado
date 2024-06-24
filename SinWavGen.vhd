-- This module generates a sine wave using ROM and feeds it to the PWM generator.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SineWaveGenerator is
    Port ( CLK,RESET          : in  STD_LOGIC;                -- Clock,Reset input
           FREQ_DIV     : in  STD_LOGIC_VECTOR (7 downto 0); -- Frequency divider input
           PWM_OUT      : out STD_LOGIC                 -- PWM output
           );
end SineWaveGenerator;

architecture Behavioral of SineWaveGenerator is
    signal clk_div_counter : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal rom_address     : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
    signal rom_data,pwm_duty : STD_LOGIC_VECTOR (7 downto 0);

    component ROM_SineWave
        Port ( address : in  STD_LOGIC_VECTOR (4 downto 0);
               data    : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    component PWM_Generator
        Port ( CLK,RESET   : in  STD_LOGIC;
               DUTY    : in  STD_LOGIC_VECTOR (7 downto 0);
               PWM_OUT : out STD_LOGIC);
    end component;

begin
    -- Instantiate ROM
    ROM_inst: ROM_SineWave Port map (
        address => rom_address,
        data => rom_data
    );

    -- Instantiate PWM generator
    PWM_inst: PWM_Generator Port map (
        CLK => CLK,
        RESET => RESET,
        DUTY => pwm_duty,
        PWM_OUT => PWM_OUT
    );

    process(CLK, RESET)
    begin
        if RESET = '1' then
            clk_div_counter <= (others => '0');
            rom_address <= (others => '0');
        elsif rising_edge(CLK) then
            -- Clock divider
            if clk_div_counter = FREQ_DIV then
                clk_div_counter <= (others => '0');
                -- Increment ROM address to read next sample
                rom_address <= rom_address + 1;
            else
                clk_div_counter <= clk_div_counter + 1;
            end if;
        end if;
    end process;

    -- Connect ROM data to PWM duty cycle input
    pwm_duty <= rom_data;
end Behavioral;
