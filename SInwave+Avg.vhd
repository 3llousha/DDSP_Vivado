-- This module integrates the SineWaveGenerator with the AVG module.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SineWavePWM_AVG_System is
    Port ( CLK, RESET     : in  STD_LOGIC;     -- Clock/Reset input
           FREQ_DIV     : in  STD_LOGIC_VECTOR (3 downto 0); -- Frequency divider input
           PWM_OUT      : out STD_LOGIC;  -- PWM output
           AVG_OUT      : out STD_LOGIC_VECTOR (7 downto 0) -- Averaged output
           );
end SineWavePWM_AVG_System;

architecture Structural of SineWavePWM_AVG_System is
    signal enable      : STD_LOGIC;
    signal data_ready  : STD_LOGIC;
    signal pwm_signal  : STD_LOGIC;

    component SineWaveGenerator
        Port ( CLK, RESET          : in  STD_LOGIC;
               FREQ_DIV     : in  STD_LOGIC_VECTOR (3 downto 0);
               ENABLE       : out STD_LOGIC;
               DATA_READY   : out STD_LOGIC;
               PWM_OUT      : out STD_LOGIC);
    end component;

    component AVG_Module
        Port ( CLK,RESET         : in  STD_LOGIC;
               ENABLE, DATA_READY       : in  STD_LOGIC;
                : in  STD_LOGIC;
               PWM_IN      : in  STD_LOGIC;
               AVG_OUT     : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

begin
    -- Instantiate SineWaveGenerator
    SineWaveGen_Inst: SineWaveGenerator
        Port map (
            CLK => CLK,
            RESET => RESET,
            FREQ_DIV => FREQ_DIV,
            ENABLE => enable,
            DATA_READY => data_ready,
            PWM_OUT => pwm_signal
        );

    -- Instantiate AVG Module
    AVG_Module_Inst: AVG_Module
        Port map (
            CLK => CLK,
            RESET => RESET,
            ENABLE => enable,
            DATA_READY => data_ready,
            PWM_IN => pwm_signal,
            AVG_OUT => AVG_OUT
        );

    -- Connect PWM output
    PWM_OUT <= pwm_signal;

end Structural;
