library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MooreFSM is
    Port ( CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           INPUT : in  STD_LOGIC;
           OUTPUT : out  STD_LOGIC);
end MooreFSM;

architecture Behavioral of MooreFSM is
    type state_type is (S0, S1);  -- Define states
    signal state, next_state : state_type;
    signal output_reg : STD_LOGIC;
begin

    process(CLK, RESET)
    begin
        if RESET = '1' then
            state <= S0;
      
        elsif rising_edge(CLK) then
            state <= next_state;
        end if;
    end process;
          

    process(state, INPUT)
    begin
        case state is
            when S0 =>
                if INPUT = '1' then
                    next_state <= S1;
          
                else
                    next_state <= S0;
                end if;
                  
            when S1 =>
                if INPUT = '0' then
                    next_state <= S0;
                else
                  
                    next_state <= S1;
                end if;
            when others =>
                next_state <= S0;
        end case;
    end process;

    -- Output logic
    process(state)
    begin
        case state is
            when S0 =>
                output_reg <= '0';
            when S1 =>
                output_reg <= '1';
            when others =>
                output_reg <= '0';
        end case;
    end process;

    OUTPUT <= output_reg;
end Behavioral;
