library verilog;
use verilog.vl_types.all;
entity SCDAQ_BUF is
    generic(
        NSAMPLES        : integer := 128;
        PRECISION       : integer := 8;
        RDO_ADD_LEN     : vl_notype;
        RDO_ADD_BLEN    : integer := 7;
        DAQ_STATE       : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        RDO_STATE       : vl_logic_vector(0 to 1) := (Hi1, Hi0)
    );
    port(
        Reset_n         : in     vl_logic;
        DAQ_Clock       : in     vl_logic;
        DAQ_D           : in     vl_logic_vector;
        DAQ_Trg         : in     vl_logic;
        RDO_Clock       : in     vl_logic;
        RDO_Add         : in     vl_logic_vector;
        RDO_Req         : in     vl_logic;
        RDO_Ack         : out    vl_logic;
        RDO_Q           : out    vl_logic_vector;
        RDO_Done        : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of NSAMPLES : constant is 1;
    attribute mti_svvh_generic_type of PRECISION : constant is 1;
    attribute mti_svvh_generic_type of RDO_ADD_LEN : constant is 3;
    attribute mti_svvh_generic_type of RDO_ADD_BLEN : constant is 1;
    attribute mti_svvh_generic_type of DAQ_STATE : constant is 1;
    attribute mti_svvh_generic_type of RDO_STATE : constant is 1;
end SCDAQ_BUF;
