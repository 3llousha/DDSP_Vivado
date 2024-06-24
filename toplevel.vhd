-- Top-level Microcontroller
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Microcontroller is
    Port ( CLK,RESET   : in  STD_LOGIC;
           INSTRUCTION : in  STD_LOGIC_VECTOR (3 downto 0);
           IN_PORT0,IN_PORT1   : in  STD_LOGIC_VECTOR (7 downto 0);
           OUT_PORT0,OUT_PORT1 : out STD_LOGIC_VECTOR (7 downto 0);
end Microcontroller;

architecture Structural of Microcontroller is
    signal ALU_OP      : STD_LOGIC_VECTOR (1 downto 0);
    signal LOAD_A,LOAD_B,LOAD_C,LOAD_D     : STD_LOGIC;
    signal SEL_A,SEL_B : STD_LOGIC_VECTOR (1 downto 0);


begin
    -- Instantiate Datapath
    Datapath_Inst: entity work.Datapath
        Port map (
            CLK => CLK,
            RESET => RESET,
            ALU_OP => ALU_OP,
            LOAD_A => LOAD_A,
            LOAD_B => LOAD_B,
            LOAD_C => LOAD_C,
            LOAD_D => LOAD_D,
            SEL_A => SEL_A,
            SEL_B => SEL_B,
            IN_PORT0 => IN_PORT0,
            IN_PORT1 => IN_PORT1,
            OUT_PORT0 => OUT_PORT0,
            OUT_PORT1 => OUT_PORT1
        );

    -- Instantiate Control Unit
    ControlUnit_Inst: entity work.ControlUnit
        Port map (
            CLK => CLK,
            RESET => RESET,
            INSTRUCTION => INSTRUCTION,
            ALU_OP => ALU_OP,
            LOAD_A => LOAD_A,
            LOAD_B => LOAD_B,
            LOAD_C => LOAD_C,
            LOAD_D => LOAD_D,
            SEL_A => SEL_A,
            SEL_B => SEL_B
        );

end Structural;
