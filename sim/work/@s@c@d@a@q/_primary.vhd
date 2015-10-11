library verilog;
use verilog.vl_types.all;
entity SCDAQ is
    generic(
        NSAMPLES        : integer := 512;
        PRECISION       : integer := 14;
        RDO_ADD_LEN     : vl_notype;
        RDO_ADD_BLEN    : integer := 9
    );
    port(
        Reset_n         : in     vl_logic;
        DAQ_Clock       : in     vl_logic;
        DAQ_D           : in     vl_logic_vector;
        TRG_MODE        : in     vl_logic_vector(2 downto 0);
        TRG_LVL         : in     vl_logic_vector;
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
end SCDAQ;
