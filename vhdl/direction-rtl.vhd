architecture rtl of direction is
signal s_nextState, s_currentSate :std_logic;

begin
	-- transLog : process (change, enable, s_nextState,s_currentSate) is
		-- begin 
		-- if (enable ='1') then 
			-- if ( change ='1') then
			-- s_nextState <= not (s_currentSate);
			-- else s_nextState <= s_currentSate;
			-- end if; 
		-- else s_nextState <= s_currentSate;
		-- end if;
		
	-- end process transLog;
	
	s_nextState <= (not s_currentSate) when (change='1' and enable='1') else s_currentSate; 
	
	dflip : process (clock) is
		begin
			if ( rising_edge(clock) ) then
				if (reset = '0') then
					s_currentSate <= s_nextState;
				else 
					s_currentSate <= '1';
				end if;
			end if;
	end process dflip;
	dir <= s_currentSate;
end architecture rtl;      
