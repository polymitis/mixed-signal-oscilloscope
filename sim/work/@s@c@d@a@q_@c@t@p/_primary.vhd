library verilog;
use verilog.vl_types.all;
entity SCDAQ_CTP is
    generic(
        PRECISION       : integer := 8;
        NSAMPLES        : integer := 2;
        NOTRG           : integer := 0;
        MODE_LVL        : integer := 1;
        MODE_PEDGE      : integer := 2;
        MODE_NEDGE      : integer := 3;
        MODE_LVL_PEDGE  : integer := 4;
        MODE_LVL_NEDGE  : integer := 5
    );
    port(
        Reset_n         : in     vl_logic;
        DAQ_Clock       : in     vl_logic;
        DAQ_D           : in     vl_logic_vector;
        DAQ_Q           : out    vl_logic_vector;
        DAQ_Trg         : out    vl_logic;
        TRG_MODE        : in     vl_logic_vector(2 downto 0);
        TRG_LVL         : in     vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of PRECISION : constant is 1;
    attribute mti_svvh_generic_type of NSAMPLES : constant is 1;
    attribute mti_svvh_generic_type of NOTRG : constant is 1;
    attribute mti_svvh_generic_type of MODE_LVL : constant is 1;
    attribute mti_svvh_generic_type of MODE_PEDGE : constant is 1;
    attribute mti_svvh_generic_type of MODE_NEDGE : constant is 1;
    attribute mti_svvh_generic_type of MODE_LVL_PEDGE : constant is 1;
    attribute mti_svvh_generic_type of MODE_LVL_NEDGE : constant is 1;
end SCDAQ_CTP;
