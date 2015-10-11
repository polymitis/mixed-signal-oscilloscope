library verilog;
use verilog.vl_types.all;
entity SignalGenerator is
    generic(
        VPP             : vl_logic_vector(0 to 14) := (Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1);
        VOLTSTEP        : vl_logic_vector(0 to 14) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1);
        RISING_STATE    : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi1);
        FALLING_STATE   : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi0)
    );
    port(
        Clock           : in     vl_logic;
        Reset_n         : in     vl_logic;
        SignalOut       : out    vl_logic_vector(13 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of VPP : constant is 1;
    attribute mti_svvh_generic_type of VOLTSTEP : constant is 1;
    attribute mti_svvh_generic_type of RISING_STATE : constant is 1;
    attribute mti_svvh_generic_type of FALLING_STATE : constant is 1;
end SignalGenerator;
