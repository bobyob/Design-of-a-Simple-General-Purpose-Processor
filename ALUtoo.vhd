library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALUtoo is
    port(
        Clock     : in  std_logic;                     
        A, B      : in  unsigned(7 downto 0);                 
        OP        : in  unsigned(15 downto 0);
		  Reset 		: in std_logic;
        Neg       : out std_logic;                   
        R1        : out unsigned(3 downto 0);
        R2        : out unsigned(3 downto 0)       
    );
end ALUtoo;

architecture calculation of ALUtoo is
    signal Reg1, Reg2, Result : unsigned(7 downto 0) := (others => '0');
    signal Reg4 : unsigned(7 downto 0);
begin

    Reg1 <= A;        
    Reg2 <= B;       

    process(Clock, Reset)
    begin
	 
	 		 if Reset = '0' then
				Result <= "00000000";
				
			 elsif (rising_edge(Clock)) then            
					case OP is

						 -- Add 2 to A
						 when "0000000000000001" => 											--problem 2 (a)
							  Result <= Reg1 + "00000010"; 						
							  Neg <= '0';

						 -- shift B right by 2, fill with zeroes
						 when "0000000000000010" =>
							  Result <= "00" & Reg2(7 downto 2);
							  Neg <= '0';

						 -- Shift B right by 4, fill with ones
						 when "0000000000000100" =>
							  Result <= "1111" & Reg1(7 downto 4);
							  Neg <= '0';

						 -- min A, B
						 when "0000000000001000" =>
							if Reg2 > Reg1 then
							  Result <= Reg1; --B > A
							  Neg <= '0';
							  else
								result <= Reg2; --A > B
								Neg <= '0';
							end if;

						 -- rotate A by two 		so, 76543210 to 01765432
						 when "0000000000010000" =>
							  Result <= Reg1(1 downto 0) & Reg1(7 downto 2);
							  Neg <= '0';

						 -- invert bit significance of B			so, 76543210 to 01234567
						 when "0000000000100000" =>
							  Result <= Reg2(0) & Reg2(1) & Reg2(2) & Reg2(3) & Reg2(4)& Reg2(5) & Reg2(6) & Reg2(7);
							  Neg <= '0';

						 -- XOR
						 when "0000000001000000" =>
							  Result <= Reg1 xor Reg2;
							  Neg <= '0';

						 -- A+B-4
						 when "0000000010000000" =>
							  Result <= Reg1 + Reg2 - "00000100";
							  Neg <= '0';

						 -- all high bits
						 when "0000000100000000" =>
							  Result <= "11111111";
							  Neg <= '0';

						 -- Default
						 when others =>
							  Result <= Result;
					end case;
			  end if;
		 end process;

		 -- split 8-bit result into two 4-bit outputs
		 R1 <= Result(3 downto 0);
		 R2 <= Result(7 downto 4);

end calculation;