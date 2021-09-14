architecture rtl of movement_full is

component direction is
port(change : in std_logic;
     enable : in std_logic;
     reset  : in std_logic;
     clock  : in std_logic;
     dir    : out std_logic);
end component;

component  movement is
generic(WIDTH : natural := 9;
        INIT  : std_logic_vector
		);
port(dir    : in std_logic;
     enable : in std_logic;
     reset  : in std_logic;
     clock  : in std_logic;
     pos    : out std_logic_vector(WIDTH - 1 downto 0));
end component;

signal s_dir_out, s_change, s_and1, s_and2: std_logic;
signal s_pos_out: std_logic_vector(WIDTH-1 downto 0);

begin

s_and1 <= s_dir_out and s_pos_out(WIDTH-2);
s_and2 <= (not s_dir_out) and  s_pos_out(1);
s_change <= s_and1 or (s_and2 or ext_change);

pos <= s_pos_out;
dir_o  <= s_dir_out;
move : movement 
generic map (WIDTH => WIDTH, 
             INIT => INIT)   --INIT  "000001000"
port map ( dir => s_dir_out,
           enable => enable,
		   reset => reset,
		   clock => clock,
		   pos => s_pos_out);

direct1 : direction
port map ( enable => enable,
		   reset => reset,
		   change => s_change,
		   clock => clock,
		   dir => s_dir_out);
end architecture rtl;
