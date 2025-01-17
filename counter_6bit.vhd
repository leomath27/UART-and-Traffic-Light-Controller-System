-- counter_4bit.vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter_6bit is
    Port (
        CLK   : in STD_LOGIC;
        i_enable   : in STD_LOGIC;
		  i_hold : IN STD_LOGIC;
		  i_reset : IN STD_LOGIC;
        COUNT : out STD_LOGIC_VECTOR (5 downto 0)
    );
end counter_6bit;

architecture Structural of counter_6bit is
   component d_FF
       Port (
				i_d			: IN	STD_LOGIC;
				i_en			: IN STD_LOGIC;
				i_reset		: IN STD_LOGIC;
				i_clock			: IN	STD_LOGIC;
				o_q, o_qBar		: OUT	STD_LOGIC
       );
    end component;
	 
	component mux_2to1_6bit
		PORT (
			sel     : IN  STD_LOGIC;                             -- Select input
         d_in1   : IN  STD_LOGIC_VECTOR(5 downto 0);        -- 8-bit Data input 1
         d_in2   : IN  STD_LOGIC_VECTOR(5 downto 0);        -- 8-bit Data input 2                         -- Reset input
         d_out   : OUT STD_LOGIC_VECTOR(5 downto 0)
		);
	END COMPONENT;
	
	signal t_en : std_LOGIC;
   signal Q, td, td_2, td_3 : STD_LOGIC_VECTOR(5 downto 0);
begin
    -- Flip-flop instances
	FF0: d_FF 
		port map (
			i_d => td(0), 
			i_en => i_enable,
			i_reset => i_reset,
			i_clock => CLK, 
			o_q => Q(0), 
			o_qBar => open
		);
   FF1: d_FF 
		port map (
			i_d => td(1), 
			i_en => i_enable,
			i_reset => i_reset,
			i_clock => CLK, 
			o_q => Q(1), 
			o_qBar => open
		);
   FF2: d_FF 
		port map (
			i_d => td(2), 
			i_en => i_enable,
			i_reset => i_reset,
			i_clock => CLK, 
			o_q => Q(2), 
			o_qBar => open
		);
   FF3: d_FF 
		port map (
			i_d => td(3), 
			i_en => i_enable,
			i_reset => i_reset,
			i_clock => CLK, 
			o_q => Q(3), 
			o_qBar => open
		);
	 FF4: d_FF 
		port map (
			i_d => td(4), 
			i_en => i_enable,
			i_reset => i_reset,
			i_clock => CLK, 
			o_q => Q(4), 
			o_qBar => open
		);
	FF5: d_FF 
		port map (
			i_d => td(5), 
			i_en => i_enable,
			i_reset => i_reset,
			i_clock => CLK, 
			o_q => Q(5), 
			o_qBar => open
		);

	td_2(0) <= NOT Q(0);

	td_2(1) <= (Q(0) XOR Q(1));  

	td_2(2) <= ((Q(0) AND Q(1)) XOR Q(2));  

	td_2(3) <= ((Q(0) AND Q(1) AND Q(2)) XOR Q(3));
	
	td_2(4) <= ((Q(0) AND Q(1) AND Q(2)) AND Q(3)) XOR Q(4);
	
	td_2(5) <= ((Q(0) AND Q(1) AND Q(2)) AND Q(3) AND Q(4)) XOR Q(5);
	
	mux_2to1_6bit_inst : mux_2to1_6bit
		PORT MAP (
			sel => i_hold,
			d_in1 => td_2,
			d_in2 => Q,
			d_out => td
		);

	COUNT <= Q;

end Structural;
