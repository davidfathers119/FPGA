----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2026/03/06 17:42:12
-- Design Name: 
-- Module Name: test - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library unisim;
use unisim.vcomponents.all;



entity test is
	generic (
		CLK_FREQ_HZ : integer := 100000000;
		BAUD_RATE   : integer := 115200;
		DEBOUNCE_CYCLES : integer := 200000
	); 
	port (
		CK_P,CK_N: in std_logic;
		reset_n  : in  std_logic;
		btn      : in  std_logic
	);
end test;

architecture Behavioral of test is
    
    signal clk           : std_logic;
	signal btn_sync_0    : std_logic := '0';
	signal btn_sync_1    : std_logic := '0';
	signal btn_stable    : std_logic := '0';
	signal btn_prev      : std_logic := '0';
	signal btn_count     : integer range 0 to DEBOUNCE_CYCLES := 0;

begin

    u_ibufds_clk: IBUFDS
    port map (
        I  => CK_P,
        IB => CK_N,
        O  => clk
	);

	process (clk, reset_n)
	begin
		if reset_n = '0' then
			btn_sync_0   <= '0';
			btn_sync_1   <= '0';
			btn_stable   <= '0';
			btn_prev     <= '0';
			btn_count    <= 0;
		elsif rising_edge(clk) then
			btn_sync_0 <= btn;
			btn_sync_1 <= btn_sync_0;

			if btn_sync_1 = btn_stable then
				btn_count <= 0;
			else
				if btn_count = DEBOUNCE_CYCLES then
					btn_stable <= btn_sync_1;
					btn_count  <= 0;
				else
					btn_count <= btn_count + 1;
				end if;
			end if;

			btn_prev <= btn_stable;
		end if;
	end process;


end Behavioral;
