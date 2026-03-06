library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity GOLD_SEQUENCE_tb is
end entity GOLD_SEQUENCE_tb;

architecture TB of GOLD_SEQUENCE_tb is
    constant C_CLK_PERIOD : time := 10 ns;
    constant C_G_NC       : natural := 1600;
    constant C_CHECK_BITS : natural := 256;
    constant C_INIT_U     : unsigned(30 downto 0) := to_unsigned(16#1ABCDE1#, 31);
    constant C_INIT       : std_logic_vector(30 downto 0) := std_logic_vector(C_INIT_U);

    signal ck_p     : std_logic := '0';
    signal ck_n     : std_logic := '1';
    signal s_reset  : std_logic := '0';
    signal en       : std_logic := '0';
    signal gold_bit : std_logic;
    signal valid    : std_logic;
    signal exp_gold_bit   : std_logic := '0';
    signal bit_match      : std_logic := '1';
    signal mismatch_count : natural := 0;
begin
    ck_p <= not ck_p after C_CLK_PERIOD / 2;
    ck_n <= not ck_p;

    uut: entity work.GOLD_SEQUENCE
        generic map (
            G_C_INIT => C_INIT,
            G_NC     => C_G_NC
        )
        port map (
            CK_P     => ck_p,
            CK_N     => ck_n,
            S_RESET  => s_reset,
            EN       => en,
            GOLD_BIT => gold_bit,
            VALID    => valid
        );

    stim_proc: process
    begin
        s_reset <= '0';
        en      <= '0';
        wait for 10 * C_CLK_PERIOD;

        s_reset <= '1';
        wait for 2 * C_CLK_PERIOD;

        en <= '1';
        wait;
    end process;

    checker_proc: process
        variable ref_lfsr1   : std_logic_vector(30 downto 0);
        variable ref_lfsr2   : std_logic_vector(30 downto 0);
        variable ref_warmup  : natural := 0;
        variable fb1         : std_logic;
        variable fb2         : std_logic;
        variable exp_bit     : std_logic;
        variable checked_cnt : natural := 0;
        variable mismatch    : natural := 0;
    begin
        ref_lfsr1      := (others => '0');
        ref_lfsr1(0)   := '1';
        ref_lfsr2      := C_INIT;
        ref_warmup     := 0;
        checked_cnt    := 0;
        mismatch       := 0;

        wait until s_reset = '1';

        loop
            wait until rising_edge(ck_p);
            wait for 1 ps;

            if en = '1' then
                if ref_warmup < C_G_NC then
                    exp_gold_bit <= '0';
                    bit_match    <= '1';
                    if valid /= '0' then
                        mismatch := mismatch + 1;
                        mismatch_count <= mismatch;
                        report "VALID should be 0 during warmup" severity error;
                    end if;
                    ref_warmup := ref_warmup + 1;
                else
                    exp_bit := ref_lfsr1(0) xor ref_lfsr2(0);
                    exp_gold_bit <= exp_bit;

                    if valid /= '1' then
                        mismatch := mismatch + 1;
                        mismatch_count <= mismatch;
                        bit_match <= '0';
                        report "VALID should be 1 after warmup" severity error;
                    elsif gold_bit = exp_bit then
                        bit_match <= '1';
                    else
                        bit_match <= '0';
                    end if;

                    if gold_bit /= exp_bit then
                        mismatch := mismatch + 1;
                        mismatch_count <= mismatch;
                        report "GOLD_BIT mismatch at checked index " & integer'image(checked_cnt)
                            severity error;
                    end if;

                    checked_cnt := checked_cnt + 1;

                    if checked_cnt = C_CHECK_BITS then
                        if mismatch = 0 then
                            report "TB PASS: compared " & integer'image(C_CHECK_BITS) & " bits, all matched"
                                severity note;
                        else
                            assert false
                                report "TB FAIL: mismatches = " & integer'image(mismatch)
                                severity failure;
                        end if;
                        wait;
                    end if;
                end if;

                fb1 := ref_lfsr1(0) xor ref_lfsr1(3);
                fb2 := ref_lfsr2(0) xor ref_lfsr2(1) xor ref_lfsr2(2) xor ref_lfsr2(3);

                ref_lfsr1 := fb1 & ref_lfsr1(30 downto 1);
                ref_lfsr2 := fb2 & ref_lfsr2(30 downto 1);
            end if;
        end loop;
    end process;
end architecture TB;
