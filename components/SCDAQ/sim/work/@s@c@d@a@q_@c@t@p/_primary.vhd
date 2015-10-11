library verilog;
use verilog.vl_types.all;
entity SCDAQ_CTP is
    generic(
        NSAMPLES        : integer := 8;
        PRECISION       : integer := 8;
        CFG_ADD_LEN     : vl_notype;
        CFG_ADD_BLEN    : integer := 5;
        DET_STATE       : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        CFG_STATE       : vl_logic_vector(0 to 1) := (Hi1, Hi0);
        CFG_REG_MODE    : integer := 0;
        CFG_REG_LVL     : integer := 1;
        CFG_REG_MSK     : integer := 2;
        CFG_REG_PAT     : vl_notype;
        NOTRG           : integer := 0;
        MODE_PAT        : integer := 1;
        MODE_LVL        : integer := 2;
        MODE_PEDGE      : integer := 3;
        MODE_NEDGE      : integer := 4;
        MODE_LVL_PEDGE  : integer := 5;
        MODE_LVL_NEDGE  : integer := 6
    );
    port(
        Reset_n         : in     vl_logic;
        DAQ_Clock       : in     vl_logic;
        DAQ_D           : in     vl_logic_vector;
        DAQ_Q           : out    vl_logic_vector;
        DAQ_Trg         : out    vl_logic;
        CFG_Clock       : in     vl_logic;
        CFG_Req         : in     vl_logic;
        CFG_Ack         : out    vl_logic;
        CFG_Add         : in     vl_logic_vector;
        CFG_D           : in     vl_logic_vector;
        CFG_Q           : out    vl_logic_vector;
        CFG_WREn        : in     vl_logic;
        CFG_Done        : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of NSAMPLES : constant is 1;
    attribute mti_svvh_generic_type of PRECISION : constant is 1;
    attribute mti_svvh_generic_type of CFG_ADD_LEN : constant is 3;
    attribute mti_svvh_generic_type of CFG_ADD_BLEN : constant is 1;
    attribute mti_svvh_generic_type of DET_STATE : constant is 1;
    attribute mti_svvh_generic_type of CFG_STATE : constant is 1;
    attribute mti_svvh_generic_type of CFG_REG_MODE : constant is 1;
    attribute mti_svvh_generic_type of CFG_REG_LVL : constant is 1;
    attribute mti_svvh_generic_type of CFG_REG_MSK : constant is 1;
    attribute mti_svvh_generic_type of CFG_REG_PAT : constant is 3;
    attribute mti_svvh_generic_type of NOTRG : constant is 1;
    attribute mti_svvh_generic_type of MODE_PAT : constant is 1;
    attribute mti_svvh_generic_type of MODE_LVL : constant is 1;
    attribute mti_svvh_generic_type of MODE_PEDGE : constant is 1;
    attribute mti_svvh_generic_type of MODE_NEDGE : constant is 1;
    attribute mti_svvh_generic_type of MODE_LVL_PEDGE : constant is 1;
    attribute mti_svvh_generic_type of MODE_LVL_NEDGE : constant is 1;
end SCDAQ_CTP;
