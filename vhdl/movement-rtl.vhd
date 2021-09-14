architecture rtl of movement is
signal s_nextState, s_previousSate :std_logic_vector (WIDTH-1 downto 0);
begin

shift : process (enable, dir,s_previousSate ) is 
begin
	s_nextState <= s_previousSate;
	if (enable ='1') then 
			if (dir='1') then
				if ( s_previousSate(WIDTH-1) = '1') then
					s_nextState <= s_previousSate;
				else s_nextState <= s_previousSate(WIDTH-2 downto 0) & '0';
				end if;
			
			else
				if ( s_previousSate(0)='1') then
					s_nextState <= s_previousSate;
				else 
				s_nextState <= '0' & s_previousSate(WIDTH-1 downto 1);
				end if ;
			end if;
	end if;
end process shift;

dflip : process (clock, reset, enable, dir) is
 begin
		if ( rising_edge(clock) ) then
			if (reset = '0') then
				s_previousSate <= s_nextState;
			else 
				s_previousSate <= INIT;
			end if;
		end if;
	end process dflip;

pos <= s_previousSate;	

end architecture rtl;
