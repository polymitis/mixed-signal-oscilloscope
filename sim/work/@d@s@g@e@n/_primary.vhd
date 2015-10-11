library verilog;
use verilog.vl_types.all;
entity DSGEN is
    generic(
        RISING_STATE    : vl_logic := Hi0;
        FALLING_STATE   : vl_logic := Hi1
    );
    port(
        Clock           : in     vl_logic;
        Reset_n         : in     vl_logic;
        Configure       : in     vl_logic;
        Pattern         : in     vl_logic_vector(9 downto 0);
        PeriodDelay     : in     vl_logic_vector(9 downto 0);
        SignalOut       : out    vl_logic_vector(0 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of RISING_STATE : constant is 1;
    attribute mti_svvh_generic_type of FALLING_STATE : constant is 1;
end DSGEN;
