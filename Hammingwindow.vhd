signal sum_with_window : STD_LOGIC_VECTOR (15 downto 0);

constant Hamming_Coefficients: rom_array := (
    "0.0800", "0.1876", "0.4601", "0.7700", "0.9755", "1.0000",
    "0.9755", "0.7700", "0.4601", "0.1876", "0.0800", "0.0000",
    "0.0800", "0.1876", "0.4601", "0.7700", "0.9755", "1.0000",
    "0.9755", "0.7700", "0.4601", "0.1876", "0.0800", "0.0000",
    "0.0800", "0.1876", "0.4601", "0.7700", "0.9755", "1.0000",
    "0.9755", "0.7700", "0.4601", "0.1876", "0.0800", "0.0000"
);


process(CLK, RESET)
begin
    if RESET = '1' then
        sum_with_window <= (others => '0');
        sum_reg <= (others => '0');
        count <= (others => '0');
        AVG_OUT <= (others => '0');
    elsif rising_edge(CLK) then
        if ENABLE = '1' then
            sum_with_window <= std_logic_vector(to_unsigned(to_integer(unsigned(PWM_IN)) * Hamming_Coefficients(to_integer(unsigned(count))), 16));
            sum_reg <= sum_reg + sum_with_window;
            count <= count + 1;
        end if;

        if DATA_READY = '1' then
            if count /= 0 then
                AVG_OUT <= std_logic_vector(to_unsigned(to_integer(unsigned(sum_reg)) / to_integer(unsigned(count)), 8));
            end if;
            sum_reg <= (others => '0');
            count <= (others => '0');
        end if;
    end if;
end process;
