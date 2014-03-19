library verilog;
use verilog.vl_types.all;
entity Core is
    port(
        clk             : in     vl_logic;
        nrst            : in     vl_logic;
        iaddr           : out    vl_logic_vector(31 downto 0);
        daddr           : out    vl_logic_vector(7 downto 0);
        dout            : out    vl_logic_vector(7 downto 0);
        wr              : out    vl_logic_vector(3 downto 0)
    );
end Core;
