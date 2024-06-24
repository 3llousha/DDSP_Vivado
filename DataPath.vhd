-- Top-Level Data Path
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DataPath is
    Port ( CLK      : in  STD_LOGIC;
           RESET    : in  STD_LOGIC;
           LOAD_A, LOAD_B,LOAD_C,LOAD_D : in  STD_LOGIC;
           SEL_A, SEL_B    : in  STD_LOGIC_VECTOR (1 downto 0);
           ALU_SEL  : in  STD_LOGIC_VECTOR (1 downto 0);
           ALU_CIN  : in  STD_LOGIC;
           INPUT_A,INPUT_B  : in  STD_LOGIC_VECTOR (7 downto 0);
           OUTPUT_A,OUTPUT_B,OUTPUT_C,OUTPUT_D : out  STD_LOGIC_VECTOR (7 downto 0);
           ALU_OUT  : out  STD_LOGIC_VECTOR (7 downto 0));
end DataPath;

architecture Structural of DataPath is
    signal A, B, C, D : STD_LOGIC_VECTOR (7 downto 0);
    signal MUX_A_OUT, MUX_B_OUT, ALU_RESULT : STD_LOGIC_VECTOR (7 downto 0);
    signal ALU_COUT : STD_LOGIC;

    component Register8
        Port ( D     : in  STD_LOGIC_VECTOR (7 downto 0);
               CLK   : in  STD_LOGIC;
               LOAD  : in  STD_LOGIC;
               Q     : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;

    component Mux4x8
        Port ( S : in  STD_LOGIC_VECTOR (1 downto 0);
               D0,D1,D2,D3 : in  STD_LOGIC_VECTOR (7 downto 0);
               Y : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;

    component ALU
        Port ( A,B : in  STD_LOGIC_VECTOR (7 downto 0);
               Cin : in  STD_LOGIC;
               Sel : in  STD_LOGIC_VECTOR (1 downto 0);
               Y : out  STD_LOGIC_VECTOR (7 downto 0);
               Cout : out  STD_LOGIC);
    end component;

begin
    -- Instantiate Registers
    regA: Register8 Port map (D => INPUT_A, CLK => CLK, LOAD => LOAD_A, Q => A);
    regB: Register8 Port map (D => INPUT_B, CLK => CLK, LOAD => LOAD_B, Q => B);
    regC: Register8 Port map (D => ALU_RESULT, CLK => CLK, LOAD => LOAD_C, Q => C);
    regD: Register8 Port map (D => ALU_RESULT, CLK => CLK, LOAD => LOAD_D, Q => D);

    -- Instantiate Multiplexers
    muxA: Mux4x8 Port map (S => SEL_A, D0 => A, D1 => B, D2 => C, D3 => D, Y => MUX_A_OUT);
    muxB: Mux4x8 Port map (S => SEL_B, D0 => A, D1 => B, D2 => C, D3 => D, Y => MUX_B_OUT);

    -- Instantiate ALU
    alu_inst: ALU Port map (A => MUX_A_OUT, B => MUX_B_OUT, Cin => ALU_CIN, Sel => ALU_SEL, Y => ALU_RESULT, Cout => ALU_COUT);

    -- Output assignments
    OUTPUT_A <= A;
    OUTPUT_B <= B;
    OUTPUT_C <= C;
    OUTPUT_D <= D;
    ALU_OUT  <= ALU_RESULT;
end Structural;
