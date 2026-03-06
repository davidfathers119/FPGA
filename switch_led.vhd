library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library unisim;
use unisim.vcomponents.all;
entity switch_led is
port(	
    switch: buffer std_logic_vector(1 downto 0);
    Led: out std_logic_vector(1 downto 0);
    CK_P,CK_N,S_RESET:in std_logic			
);
end;
architecture a of switch_led is
signal ck: std_logic;
signal F: unsigned(27 downto 0) := (others => '0');
begin

u_ibufds_clk: IBUFDS
    port map (
        IB => CK_N,
        I  => CK_P,
        O  => ck
    );
     
    Led <= switch;

process(ck,S_RESET)
begin
    if S_RESET='1' then
        F <= (others => '0');
    elsif rising_edge(ck) then
        F <= F + 1;
        if F = to_unsigned(200000000, F'length) then
            F <= (others => '0');
        end if;
    end if;
end process;
end;