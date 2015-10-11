library verilog;
use verilog.vl_types.all;
entity SCDAQ_tb is
    generic(
        CLOCK_50_T      : integer := 20;
        CLOCK_625EN1_T  : integer := 16
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CLOCK_50_T : constant is 1;
    attribute mti_svvh_generic_type of CLOCK_625EN1_T : constant is 1;
end SCDAQ_tb;
