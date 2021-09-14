architecture rtl of collision is
signal s_predicted_y, s_bat_plusBas,s_bat_plusHaut : std_logic_vector(8 downto 0);
begin

prediction: process (y_dir) is 
begin
if (y_dir='0') then
	s_predicted_y <= '0' & y_pos(8 downto 1);
else s_predicted_y <= y_pos(7 downto 0)&'0';
end if;
s_bat_plusBas<= bat_pos(7 downto 0)&'0';
s_bat_plusHaut <= '0' & bat_pos(8 downto 1);
end process prediction;

rebond: process (s_predicted_y,bat_pos) is 
begin
if (  (x_dir='0' and x_pos(11)='1')  or  (x_dir='1' and x_pos(8)='1') ) then 
	if ((bat_pos and  s_predicted_y) = "000000000") then 
		if (y_dir='1' and ((s_bat_plusHaut and  s_predicted_y) = "000000000") and x_dir='1') then
		change<='0';
		elsif(y_dir='0' and ((s_bat_plusBas and  s_predicted_y) = "000000000") and x_dir='1') then
		change<='0';
		elsif(x_dir='0') then
		change<='0';
		else change <='1';
		end if;
	else change <='1';
	end if;
elsif ((x_dir='1' and x_pos(9)='1')) then 
		if ((bat_pos and  s_predicted_y) = "000000000") then 
		change<='0';	
	else change <='1';
	end if;
else change<='0';
end if;
end process rebond;
end architecture rtl;