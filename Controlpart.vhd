library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Declares a ControlUnit entity with various control and state signals
entity ControlUnit is
    Port (
        CLK     : in STD_LOGIC;         -- Clock input for synchronization
        RESET   : in STD_LOGIC;         -- Asynchronous reset input
        START   : in STD_LOGIC;         -- Start signal input for processing
        ERROR   : in STD_LOGIC;         -- Error signal input
        PROCESS : out STD_LOGIC         -- Output signal to trigger processing
    );
end ControlUnit;

-- Defines the behavior of the ControlUnit
architecture Behavioral of ControlUnit is
    -- Defines possible states of the state machine
    type State_Type is (Idle, Ready, Error);
    -- Signals to hold current and next states
    signal State, Next_State: State_Type;
begin
    -- Handles state transitions based on clock and reset
    process(CLK, RESET)
    begin
        if RESET = '1' then
            State <= Idle;  -- Resets state to Idle
        elsif rising_edge(CLK) then
            State <= Next_State;  -- Updates state on clock's rising edge
        end if;
    end process;

    -- Determines the next state of the FSM based on current state and inputs
    process(State, START, ERROR)
    begin
        case State is
            when Idle =>
                if START = '1' then
                    Next_State <= Ready;  -- Transition to Ready if START is high
                else
                    Next_State <= Idle;  -- Remain in Idle otherwise
                end if;

            when Ready =>
                if ERROR = '1' then
                    Next_State <= Error;  -- Transition to Error if an error occurs
                else
                    Next_State <= Idle;  -- Return to Idle after one cycle
                end if;

            when Error =>
                Next_State <= Idle;  -- Always return to Idle from Error

            when others =>
                Next_State <= Idle;  -- Default case to handle unforeseen states
        end case;
    end process;

    -- Sets the PROCESS signal based on the current state
    -- PROCESS is '1' when in Ready state, '0' otherwise
    PROCESS <= '1' when State = Ready else '0';
end Behavioral;
