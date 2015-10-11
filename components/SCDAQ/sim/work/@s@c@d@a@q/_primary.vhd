library verilog;
use verilog.vl_types.all;
entity SCDAQ is
    generic(
        NSAMPLES        : integer := 256;
        NCTPSAMPLES     : integer := 8;
        PRECISION       : integer := 14;
        RDO_ADD_LEN     : vl_notype;
        RDO_ADD_BLEN    : integer := 8;
        CFG_ADD_LEN     : vl_notype;
        CFG_ADD_BLEN    : integer := 5
    );
    port(
        Reset_n         : in     vl_logic;
        DAQ_Clock       : in     vl_logic;
        DAQ_D           : in     vl_logic_vector;
        CFG_Clock       : in     vl_logic;
        CFG_Req         : in     vl_logic;
        CFG_Ack         : out    vl_logic;
        CFG_Add         : in     vl_logic_vector;
        CFG_D           : in     vl_logic_vector;
        CFG_Q           : out    vl_logic_vector;
        CFG_WREn        : in     vl_logic;
        CFG_Done        : in     vl_logic;
        RDO_Clock       : in     vl_logic;
        RDO_Add         : in     vl_logic_vector;
        RDO_Req         : in     vl_logic;
        RDO_Ack         : out    vl_logic;
        RDO_Q           : out    vl_logic_vector;
        RDO_Done        : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of NSAMPLES : constant is 1;
    attribute mti_svvh_generic_type of NCTPSAMPLES : constant is 1;
    attribute mti_svvh_generic_type of PRECISION : constant is 1;
    attribute mti_svvh_generic_type of RDO_ADD_LEN : constant is 3;
    attribute mti_svvh_generic_type of RDO_ADD_BLEN : constant is 1;
    attribute mti_svvh_generic_type of CFG_ADD_LEN : constant is 3;
    attribute mti_svvh_generic_type of CFG_ADD_BLEN : constant is 1;
end SCDAQ;
