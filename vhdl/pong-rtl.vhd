architecture rtl of pong is
component clock_divider IS
   PORT ( clock   : IN  std_logic;
          reset   : IN  std_logic;
          enable  : OUT std_logic );
END component;


component collision is
port(x_dir   : in std_logic;
     y_dir   : in std_logic;
     x_pos   : in std_logic_vector(11 downto 0);
     y_pos   : in std_logic_vector(8 downto 0);
     bat_pos : in std_logic_vector(8 downto 0);
     change  : out std_logic);
end component;

component debouncer is
port(button   : in std_logic;
     enable   : in std_logic;
     reset    : in std_logic;
     clock    : in std_logic;
     button_o : out std_logic);
end component;

component bat is
port(button_up   : in std_logic;
     button_down : in std_logic;
     enable      : in std_logic;
     reset       : in std_logic;
     clock       : in std_logic;
     bat_o       : out std_logic_vector(8 downto 0));
end component;

component movement_full is
generic(WIDTH : natural := 9;
        INIT  : std_logic_vector);
port(ext_change : in std_logic;
     enable     : in std_logic;
     reset      : in std_logic;
     clock      : in std_logic;
     pos        : out std_logic_vector(WIDTH - 1 downto 0);
     dir_o      : out std_logic);
end component;

component score is
port(x_pos  : in std_logic_vector(11 downto 0);
     enable : in std_logic;
     reset  : in std_logic;
     clock  : in std_logic;
     user   : out std_logic_vector(7 downto 0);
     sys    : out std_logic_vector(7 downto 0);
     over   : out std_logic);
end component;

signal s_enable, s_dir_outX,s_dir_outY, s_reset,s_over, s_button_up, s_button_down , s_debounc_but_Up, s_debounc_but_Down,s_ext_change : std_logic;
signal s_pos_outX : std_logic_vector(11 downto 0);
signal s_pos_outY : std_logic_vector(8 downto 0);
signal s_pos_batY : std_logic_vector(8 downto 0);
begin
display : 
	FOR y IN 8 DOWNTO 0 GENERATE 
	oneline : FOR x IN 11 DOWNTO 0 GENERATE
	
		forBat : if (x=10) generate 
					playfield(y*12+x) <= (s_pos_outY(y) AND s_pos_outX(x)) OR s_pos_batY(y);--Y_pos(y) AND X_pos(X);
		end generate forBat;
		
		noBat : if (x<10 or x>10) generate
				playfield(y*12+x) <= s_pos_outY(y) AND s_pos_outX(x); --Y_pos(y) AND X_pos(X);
		end generate noBat;
	END GENERATE oneline;
END GENERATE display;

s_reset <= not (n_reset);
s_button_down <= not (n_button_down);
s_button_up <= not (n_button_up);


longueur : movement_full 
generic map (WIDTH => 12,
        INIT => "000000010000")
port map(ext_change =>s_ext_change,
     enable =>s_enable,
     reset  => s_reset,
     clock  => clock,
     pos    => s_pos_outX,
     dir_o  => s_dir_outX );
	 
	 
largeur : movement_full 
generic map (WIDTH => 9,
        INIT => "000001000")
port map(ext_change =>'0',
     enable => s_enable,
     reset  => s_reset,
     clock  => clock,
     pos    => s_pos_outY,
     dir_o  => s_dir_outY );
	 
	 
scoreCounter : score 
port map ( enable => s_enable,
		   reset  => s_reset,
		   clock  => clock,
		   user => user,
		   sys => sys,
		   over => s_over,
		   x_pos => s_pos_outX);

bat1: bat 
port map ( button_up => s_debounc_but_Up, --s_debounc_but_Up
		   button_down => s_debounc_but_Down, --s_debounc_but_Down
		   enable => s_enable,
		   reset  => s_reset,
		   clock  => clock,
		   bat_o => s_pos_batY);

		   
bouncerUp: debouncer
port map( button =>s_button_up, 
		  enable =>s_enable,
		  reset => s_reset,
		  clock => clock,
		  button_o =>s_debounc_but_Up);
		  
bouncerdown: debouncer
port map( button =>s_button_down, 
		  enable =>s_enable,
		  reset => s_reset,
		  clock => clock,
		  button_o =>s_debounc_but_Down);

col: collision
port map ( x_dir =>s_dir_outX,
		   y_dir => s_dir_outY,
		   x_pos => s_pos_outX,
		   y_pos => s_pos_outY,
		   bat_pos => s_pos_batY,
		   change => s_ext_change);
		  
div: clock_divider
port map (clock =>  clock ,
          reset => s_reset, 
          enable =>  s_enable);




end architecture rtl; 
