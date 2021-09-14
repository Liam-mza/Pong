architecture rtl of bat is

signal s_current, s_next : std_logic_vector (8 downto 0);

begin

decalage: process (enable,s_current,s_next,button_down,button_up) is 
begin 
if (enable = '1') then 
	if (button_up ='1') then 
		if (s_current(8) ='1') then
			s_next <= s_current;
		else s_next <= s_current(7 downto 0) & '0';
		end if;
	elsif (button_down ='1') then 
		if (s_current(0) ='1') then
			s_next <= s_current;
		else s_next <=  '0' & s_current(8 downto 1);
		end if;
	else s_next <= s_current;
	end if;
else s_next <= s_current;
end if ;
end process decalage;

dflip : process (clock, reset) is
		begin
			if ( rising_edge(clock) ) then
				if (reset = '0') then
					s_current <= s_next;
				else s_current <= "000111000";
				end if;
			end if;
end process dflip;
bat_o<=s_current;
end architecture rtl;
