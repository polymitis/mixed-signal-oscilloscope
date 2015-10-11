library verilog;
use verilog.vl_types.all;
entity MiniProject_DE270_tb is
    generic(
        CLOCK_25_T      : integer := 40;
        CLOCK_50_T      : integer := 20
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CLOCK_25_T : constant is 1;
    attribute mti_svvh_generic_type of CLOCK_50_T : constant is 1;
end MiniProject_DE270_tb;
