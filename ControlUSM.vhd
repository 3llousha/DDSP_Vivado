-- State Machine for Control
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
    Port ( CLK,RESET     : in  STD_LOGIC;
           INSTRUCTION  : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_OP       : out STD_LOGIC_VECTOR (1 downto 0);
           LOAD_A,LOAD_B,LOAD_C,LOAD_D   : out STD_LOGIC;
           SEL_A,SEL_B        : out STD_LOGIC_VECTOR (1 downto 0);

end ControlUnit;

architecture Behavioral of ControlUnit is
    type state_type is (IDLE, FETCH, DECODE, EXECUTE, WRITEBACK);
    signal state, next_state : state_type;

    signal inst_reg : STD_LOGIC_VECTOR (3 downto 0);
begin
    process (CLK, RESET)
    begin
        if RESET = '1' then
            state <= IDLE;
        elsif rising_edge(CLK) then
            state <= next_state;
        end if;
    end process;

    process (state, INSTRUCTION)
    begin
        case state is
            when IDLE =>
                next_state <= FETCH;
            when FETCH =>
                inst_reg <= INSTRUCTION;
                next_state <= DECODE;
            when DECODE =>
                -- Decode the instruction and set control signals
                case inst_reg is
                    when "0001" => -- ADD
                        ALU_OP <= "00";
                        SEL_A <= "00";
                        SEL_B <= "01";
                        LOAD_A <= '1';
                    when "0010" => -- SUB
                        ALU_OP <= "01";
                        SEL_A <= "00";
                        SEL_B <= "01";
                        LOAD_B <= '1';
                    when others =>
                        next_state <= IDLE;
                end case;
                next_state <= EXECUTE;
            when EXECUTE =>
                -- Execute the operation in ALU
                next_state <= WRITEBACK;
            when WRITEBACK =>
                -- Write back the result to the registers
                LOAD_A <= '0';
                LOAD_B <= '0';
                LOAD_C <= '0';
                LOAD_D <= '0';
                next_state <= FETCH;
            when others =>
                next_state <= IDLE;
        end case;
    end process;
end Behavioral;
