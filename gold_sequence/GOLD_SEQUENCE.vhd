library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity GOLD_SEQUENCE is
	generic (
		G_C_INIT : std_logic_vector(30 downto 0) := (others => '0');
		G_NC     : natural := 1600
	);
	port (
		
		S_RESET : in  std_logic;
		EN       : in  std_logic;
		GOLD_BIT : out std_logic;
		VALID    : out std_logic;
		CK_P,CK_N:in std_logic	
	);
end entity GOLD_SEQUENCE;

architecture RTL of GOLD_SEQUENCE is
    signal ck         : std_logic;
	signal lfsr1      : std_logic_vector(30 downto 0);
	signal lfsr2      : std_logic_vector(30 downto 0);
	signal warmup_cnt : natural range 0 to G_NC;
	signal gold_bit_r : std_logic;
	signal valid_r    : std_logic;
begin
	ck <= CK_P;

	GOLD_BIT <= gold_bit_r;
	VALID    <= valid_r;

	process (ck, S_RESET)
		variable fb1 : std_logic;
		variable fb2 : std_logic;
	begin
		if S_RESET = '0' then
			lfsr1      <= (others => '0');
			lfsr1(0)   <= '1';
			lfsr2      <= G_C_INIT;
			warmup_cnt <= 0;
			gold_bit_r <= '0';
			valid_r    <= '0';
		elsif rising_edge(ck) then
			if EN = '1' then
				fb1 := lfsr1(0) xor lfsr1(3);
				fb2 := lfsr2(0) xor lfsr2(1) xor lfsr2(2) xor lfsr2(3);

				if warmup_cnt < G_NC then
					warmup_cnt <= warmup_cnt + 1;
					valid_r    <= '0';
					gold_bit_r <= '0';
				else
					gold_bit_r <= lfsr1(0) xor lfsr2(0);
					valid_r    <= '1';
				end if;

				lfsr1 <= fb1 & lfsr1(30 downto 1);
				lfsr2 <= fb2 & lfsr2(30 downto 1);
			else
				valid_r <= '0';
			end if;
		end if;
	end process;
end architecture RTL;