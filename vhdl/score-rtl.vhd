architecture rtl of score is
signal  s_current_sys, s_current_ply : std_logic_vector(7 downto 0);
signal s_Over : std_logic;
begin

dflipPly : process (clock, reset,s_current_sys,s_over,s_current_ply,enable,x_pos) is
begin
if ( rising_edge(clock) ) then
	if (reset='0') then 
		if (enable='1') then 
			if (s_over='0') then
				if (x_pos(0) ='1') then 
				case (s_current_sys) is 
				when "11111100" => s_current_sys <= "01100000";
				when "01100000" => s_current_sys <= "11011010";
				when "11011010" => s_current_sys <= "11110010";
				when "11110010" => s_current_sys <= "01100110";
				when "01100110" => s_current_sys <= "10110110";
				when "10110110" => s_current_sys <= "10111110";
				when "10111110" => s_current_sys <= "11100000";
				when "11100000" => s_current_sys <= "11111110";
				when "11111110" => s_current_sys <= "11110110";
				when "11110110" => s_current_sys <= "11110110";
				when others     => s_current_sys <= "11111100";
				end case;
				elsif (x_pos(11) ='1') then 
				case (s_current_ply) is 
				when "11111100" => s_current_ply <= "01100000";
				when "01100000" => s_current_ply <= "11011010";
				when "11011010" => s_current_ply <= "11110010";
				when "11110010" => s_current_ply <= "01100110";
				when "01100110" => s_current_ply <= "10110110";
				when "10110110" => s_current_ply <= "10111110";
				when "10111110" => s_current_ply <= "11100000";
				when "11100000" => s_current_ply <= "11111110";
				when "11111110" => s_current_ply <= "11110110";
				when "11110110" => s_current_ply <= "11110110";
				when others     => s_current_ply <= "11111100";				
				end case;
				end if;
			end if;
		end if;
	else s_current_sys <= "11111100";
		 s_current_ply<= "11111100";	 
	end if;	
end if;
end process dflipPly;


s_Over <= '1' when s_current_ply = "11110110" or s_current_sys = "11110110" else '0';

user <= s_current_sys;
sys <= s_current_ply;
over <= s_Over;

end architecture rtl;

-- if (reset='0') then 
		-- if (enable='1') then 
			-- if (s_over='0') then
				-- if (x_pos(0) ='1') then 
				-- case (s_current_sys) is 
				-- when "11111100" => s_current_sys <= "01100000";
				-- when "01100000" => s_current_sys <= "11011010";
				-- when "11011010" => s_current_sys <= "11110010";
				-- when "11110010" => s_current_sys <= "01100110";
				-- when "01100110" => s_current_sys <= "10110110";
				-- when "10110110" => s_current_sys <= "10111110";
				-- when "10111110" => s_current_sys <= "11100000";
				-- when "11100000" => s_current_sys <= "11111110";
				-- when "11111110" => s_current_sys <= "11110110";
				-- when "11110110" => s_current_sys <= "11110110";
				-- when others     => s_current_sys <= "11111100";
				-- end case;
				-- elsif (x_pos(11) ='1') then 
				-- case (s_current_ply) is 
				-- when "11111100" => s_current_ply <= "01100000";
				-- when "01100000" => s_current_ply <= "11011010";
				-- when "11011010" => s_current_ply <= "11110010";
				-- when "11110010" => s_current_ply <= "01100110";
				-- when "01100110" => s_current_ply <= "10110110";
				-- when "10110110" => s_current_ply <= "10111110";
				-- when "10111110" => s_current_ply <= "11100000";
				-- when "11100000" => s_current_ply <= "11111110";
				-- when "11111110" => s_current_ply <= "11110110";
				-- when "11110110" => s_current_ply <= "11110110";
				-- when others     => s_current_ply <= "11111100";				
				-- end case;
				-- end if;
			-- end if;
		-- end if;
	-- else s_current_sys <= "11111100";
		 -- s_current_ply<= "11111100";	 
	-- end if;		
	
	
	
	-- if (reset='1') then
		-- s_current_sys <= "11111100";
		-- s_current_ply<= "11111100";	
	-- else 
		-- if (enable='1' and s_over='0') then 
			-- if (x_pos(0) ='1') then 
				-- case (s_current_sys) is 
				-- when "11111100" => s_current_sys <= "01100000";
				-- when "01100000" => s_current_sys <= "11011010";
				-- when "11011010" => s_current_sys <= "11110010";
				-- when "11110010" => s_current_sys <= "01100110";
				-- when "01100110" => s_current_sys <= "10110110";
				-- when "10110110" => s_current_sys <= "10111110";
				-- when "10111110" => s_current_sys <= "11100000";
				-- when "11100000" => s_current_sys <= "11111110";
				-- when "11111110" => s_current_sys <= "11110110";
				-- when "11110110" => s_current_sys <= "11110110";
				-- when others     => s_current_sys <= "11111100";
				-- end case;
			-- elsif (x_pos(11) ='1') then 
				-- case (s_current_ply) is 
				-- when "11111100" => s_current_ply <= "01100000";
				-- when "01100000" => s_current_ply <= "11011010";
				-- when "11011010" => s_current_ply <= "11110010";
				-- when "11110010" => s_current_ply <= "01100110";
				-- when "01100110" => s_current_ply <= "10110110";
				-- when "10110110" => s_current_ply <= "10111110";
				-- when "10111110" => s_current_ply <= "11100000";
				-- when "11100000" => s_current_ply <= "11111110";
				-- when "11111110" => s_current_ply <= "11110110";
				-- when "11110110" => s_current_ply <= "11110110";
				-- when others     => s_current_ply <= "11111100";				
				-- end case;
			-- end if;
		-- end if;
	-- end if;