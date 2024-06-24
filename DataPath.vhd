-- Datapath for Microcontroller
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Datapath is
    Port ( CLK,RESET      : in  STD_LOGIC;
           ALU_OP      : in  STD_LOGIC_VECTOR (1 downto 0);
           LOAD_A,LOAD_B,LOAD_C,LOAD_D : in  STD_LOGIC;
           SEL_A,SEL_B : in  STD_LOGIC_VECTOR (1 downto 0);
           IN_PORT0,IN_PORT1 : in  STD_LOGIC_VECTOR (7 downto 0);
           OUT_PORT0, OUT_PORT1 : out STD_LOGIC_VECTOR (7 downto 0);
            
end Datapath;

architecture Structural of Datapath is
    -- Signals for register outputs
    signal Q_A, Q_B, Q_C, Q_D : STD_LOGIC_VECTOR (7 downto 0);
    -- Signals for ALU inputs and output
    signal ALU_A, ALU_B, ALU_Y : STD_LOGIC_VECTOR (7 downto 0);
    signal ALU_Cout : STD_LOGIC;
begin
    -- Instantiating Registers
    Reg_A: entity work.Register8Bit Port map (D => ALU_Y, CLK => CLK, LOAD => LOAD_A, Q => Q_A);
    Reg_B: entity work.Register8Bit Port map (D => ALU_Y, CLK => CLK, LOAD => LOAD_B, Q => Q_B);
    Reg_C: entity work.Register8Bit Port map (D => ALU_Y, CLK => CLK, LOAD => LOAD_C, Q => Q_C);
    Reg_D: entity work.Register8Bit Port map (D => ALU_Y, CLK => CLK, LOAD => LOAD_D, Q => Q_D);

    -- Instantiating Multiplexers
    MuxA: entity work.Mux4x8 Port map (S => SEL_A, D0 => Q_A, D1 => Q_B, D2 => Q_C, D3 => Q_D, Y => ALU_A);
    MuxB: entity work.Mux4x8 Port map (S => SEL_B, D0 => Q_A, D1 => Q_B, D2 => Q_C, D3 => Q_D, Y => ALU_B);

    -- Instantiating ALU
    ALU_Inst: entity work.ALU Port map (A => ALU_A, B => ALU_B, Cin => '0', Sel => ALU_OP, Y => ALU_Y, Cout => ALU_Cout);

    -- Input Ports to Registers
    process (CLK)
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                Q_A <= (others => '0');
                Q_B <= (others => '0');
                Q_C <= (others => '0');
                Q_D <= (others => '0');
            end if;
        end if;
    end process;

    -- Output Ports from Registers
    OUT_PORT0 <= Q_A;
    OUT_PORT1 <= Q_B;

end Structural;
