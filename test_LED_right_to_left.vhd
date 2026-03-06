library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_LED_right_to_left is
end entity;

architecture tb of test_LED_right_to_left is
    signal led     : std_logic_vector(7 downto 0);
    signal ck      : std_logic := '0';
    signal s_reset : std_logic := '0';
    constant CLK_PERIOD : time := 10 ns;

    function count_ones(v : std_logic_vector) return natural is
        variable n : natural := 0;
    begin
        for i in v'range loop
            if v(i) = '1' then
                n := n + 1;
            end if;
        end loop;
        return n;
    end function;
begin
    dut: entity work.test(a)
        port map (
            Led     => led,
            CK      => ck,
            S_RESET => s_reset
        );

    clk_gen: process
    begin
        while true loop
            ck <= '0';
            wait for CLK_PERIOD / 2;
            ck <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    one_hot_check: process(led)
    begin
        if s_reset = '1' then
            assert count_ones(led) = 1
                report "LED is not one-hot during operation."
                severity error;
        end if;
    end process;

    stim: process
    begin
        -- Reset test
        s_reset <= '0';
        wait for 5 * CLK_PERIOD;
        assert led = "00000001"
            report "Reset value mismatch: LED should be 00000001."
            severity error;

        -- Release reset
        s_reset <= '1';

        -- Rotation test (first step). This may take long because DUT uses F(27) as clock divider.
        wait until led = "00000010" for 4 sec;
        assert led = "00000010"
            report "LED did not rotate to 00000010 within timeout."
            severity error;

        -- Async reset while running
        s_reset <= '0';
        wait for CLK_PERIOD;
        assert led = "00000001"
            report "Asynchronous reset did not restore LED to 00000001."
            severity error;

        assert false report "Test completed." severity failure;
    end process;
end architecture;