----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2026/06/15 09:04:18
-- Design Name: 
-- Module Name: TOP - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TOP is
Port (
    LED :out std_logic;
    pl_clk :in std_logic  
);

end TOP;

architecture Behavioral of TOP is

    signal clk_100M_90d_0:std_logic;
    signal clk_100M_50d_0:std_logic;
    signal clk_100M_10d_0:std_logic;
    signal clk_200M_50d_0:std_logic;
    signal clk_lck:std_logic;
    signal probe_signals:std_logic_vector(2 downto 0);
    
component timer_wrapper
port(
    clk_lck :out std_logic; 
    clk_200M_50d :out std_logic; 
    clk_100M_90d :out std_logic; 
    clk_100M_50d :out std_logic; 
    clk_100M_10d :out std_logic;  
    sys_clk :in std_logic);
end component;
component test
port(
    LED :out std_logic; 
    clk :in std_logic);
end component;
component ila_0
port(
          clk: in std_logic;
          probe0: in std_logic_vector(2 downto 0)
        );
end component;
begin
    -- 組合 probe 信號
    probe_signals <= clk_200M_50d_0 & clk_100M_90d_0 & clk_100M_50d_0;
    
    u0: timer_wrapper port map (
        clk_lck => clk_lck,
        clk_200M_50d => clk_200M_50d_0,
        clk_100M_90d => clk_100M_90d_0,
        clk_100M_50d => clk_100M_50d_0,
        clk_100M_10d => clk_100M_10d_0,
        sys_clk => pl_clk );
    u1: test  port map (
        LED => LED,
        clk => clk_100M_50d_0);
    u2: ila_0 port map(
        clk => clk_100M_50d_0,  -- 改用派生時鐘以匹配被探測信號
        probe0 => probe_signals
    );
end Behavioral;
