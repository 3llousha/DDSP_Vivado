-- Control Unit State Machine
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
    Port ( CLK,RESET    : in  STD_LOGIC;
          
           INSTR    : in  STD_LOGIC_VECTOR (7 downto 0);
           LOAD_A,LOAD_B,LOAD_C,LOAD_D   : out STD_LOGIC;
           SEL_A, SEL_B: out STD_LOGIC_VECTOR (1 downto 0);
           ALU_SEL  : out STD_LOGIC_VECTOR (1 downto 0);
           ALU_CIN  : out STD_LOGIC);
end ControlUnit;

architecture Behavioral of ControlUnit is
    type state_type is (IDLE, FETCH, DECODE, EXECUTE, WRITEBACK);
    signal state, next_state : state_type;

    signal load_a_reg, load_b_reg, load_c_reg, load_d_reg : STD_LOGIC := '0';
    signal sel_a_reg, sel_b_reg : STD
