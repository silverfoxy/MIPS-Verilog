library verilog;
use verilog.vl_types.all;
entity glbl is
    generic(
        ROC_WIDTH       : integer := 100000;
        TOC_WIDTH       : integer := 0
    );
end glbl;
