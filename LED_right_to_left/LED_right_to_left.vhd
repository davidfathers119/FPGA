library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library unisim;
use unisim.vcomponents.all;
entity LED_right_to_left is
port(	
    Led: out std_logic_vector(7 downto 0);
    CK_P,CK_N,S_RESET:in std_logic			
);
end;
architecture a of LED_right_to_left is
signal ck: std_logic;
signal F: unsigned(27 downto 0) := (others => '0');
signal led_reg: std_logic_vector(7 downto 0) := "00000001";
begin

u_ibufds_clk: IBUFDS
    port map (
        I  => CK_P,
        IB => CK_N,
        O  => ck
    );

Led <= led_reg;
 
process(ck,S_RESET)
begin
    if S_RESET='1' then
        F <= (others => '0');
        led_reg <= "00000001";
    elsif rising_edge(ck) then
        F <= F + 1;
        if F = to_unsigned(200000000, F'length) then
            F <= (others => '0');
            led_reg <= led_reg(6 downto 0) & led_reg(7);
        end if;
    end if;
end process;
end;
