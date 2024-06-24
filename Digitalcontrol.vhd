-- Importing standard logic and numeric libraries to use with VHDL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  -- Includes definitions for standard logic vectors and related types
use IEEE.NUMERIC_STD.ALL;     -- Includes definitions for arithmetic operations on numeric types

-- Declaration of the DataProcessingModule entity
entity DataProcessingModule is
    Port (
        CLK        : in STD_LOGIC;                  -- Clock input for synchronization
        RESET      : in STD_LOGIC;                  -- Asynchronous reset input
        ENABLE     : in STD_LOGIC;                  -- Enable input to control the operation
        INPUT_DATA : in STD_LOGIC_VECTOR(7 downto 0);  -- 8-bit input data (not used in this example)
        OUTPUT_DATA: out STD_LOGIC_VECTOR(7 downto 0)  -- 8-bit output data
    );
end DataProcessingModule;

-- Behavioral architecture definition of the DataProcessingModule
architecture Behavioral of DataProcessingModule is
    signal temp_data: STD_LOGIC_VECTOR(7 downto 0);  -- Internal signal to hold the processed data
begin
    -- Main process handling the data operations, responding to clock and reset
    process(CLK, RESET)
    begin
        -- Check if reset is active
        if RESET = '1' then
            temp_data <= (others => '0');  -- Reset the internal data to zero
        -- Check if the rising edge of the clock is detected
        elsif rising_edge(CLK) then
            -- Perform the following operation only if the ENABLE signal is high
            if ENABLE = '1' then
                temp_data <= temp_data + 1;  -- Increment the internal data by one
            end if;
        end if;
    end process;

    -- Assign the internal data to the output port
    OUTPUT_DATA <= temp_data;  -- Output the value of the internal signal
end Behavioral;
