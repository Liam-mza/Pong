architecture rtl of debouncer is
signal s_dff1, s_dff2, s_dff3, s_but_out, s_EnAndRes, s_and1, s_OR, s_in4: std_logic;

begin

dff1: Process (clock) is
begin
        if(rising_edge(clock)) then
                s_dff1 <= button;
        end if;
end process dff1;


dff2: Process (clock) is
begin
        if(rising_edge(clock)) then
                s_dff2 <= s_dff1;
        end if;
end process dff2;


dff3: Process (clock) is
begin
        if(rising_edge(clock)) then
                s_dff3 <= s_dff2;
        end if;
end process dff3;

s_EnAndRes <= reset OR enable;

s_and1 <= s_dff2 and (not (s_dff3));

s_Or <=s_but_out OR s_and1;

s_in4 <= s_Or AND (not (s_EnAndRes));

dff4: Process (clock) is
begin
        if(rising_edge(clock)) then
                s_but_out <= s_in4;
        end if;
end process dff4;

button_o <= s_but_out;

end architecture rtl; 
   
