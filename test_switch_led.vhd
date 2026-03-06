library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_switch_led is
end entity test_switch_led;

architecture tb of test_switch_led is
    component test is
        port(	
            switch: in std_logic_vector(1 downto 0);
            Led: out std_logic_vector(1 downto 0);
            CK_P, CK_N, S_RESET: in std_logic			
        );
    end component;

    signal switch: std_logic_vector(1 downto 0);
    signal Led: std_logic_vector(1 downto 0);
    signal CK_P, CK_N, S_RESET: std_logic;

begin
    uut: test port map (
        switch => switch,
        Led => Led,
        CK_P => CK_P,
        CK_N => CK_N,
        S_RESET => S_RESET
    );

    process
    begin
        S_RESET <= '0';
        CK_P <= '0';
        CK_N <= '1';
        switch <= "00";
        wait for 10 ns;

        S_RESET <= '1';
        wait for 10 ns;

        for i in 0 to 19 loop
            CK_P <= not CK_P;
            CK_N <= not CK_N;
            wait for 5 ns;
        end loop;

        switch <= "11";
        wait for 10 ns;

        S_RESET <= '0';
        wait for 10 ns;

        assert Led = "00" report "Reset test failed" severity error;
        wait;
    end process;
end architecture tb;