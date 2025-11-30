library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    port(
        Clock     : in  std_logic;                     
        A, B      : in  unsigned(7 downto 0);                 
        OP        : in  unsigned(15 downto 0);
		  Reset 		: in std_logic;
        Neg       : out std_logic;                   
        R1        : out unsigned(3 downto 0);
        R2        : out unsigned(3 downto 0)        
    );
end ALU;

architecture calculation of ALU is
    signal Reg1, Reg2, Result : unsigned(7 downto 0) := (others => '0');
    signal Reg4 : unsigned(7 downto 0);
begin

    Reg1 <= A;        
    Reg2 <= B;       

    process(Clock, OP)
    begin
	 
	 		 if Reset = '0' then
				Result <= "00000000";
				
			 elsif (rising_edge(Clock)) then          
		
			
					case OP is

						 -- Add
						 when "0000000000000001" =>
							  Result <= Reg1 + Reg2;
							  Neg <= '0';

						 -- Sub
						 when "0000000000000010" =>
							  if (Reg1 < Reg2) then
									Neg <= '1';
									Result <= Reg2 - Reg1;
							  else
									Neg <= '0';
									Result <= Reg1 - Reg2;
							  end if;

						 -- NOT A
						 when "0000000000000100" =>
							  Result <= not Reg1;
							  Neg <= '0';

						 -- NAND
						 when "0000000000001000" =>
							  Result <= not (Reg1 and Reg2);
							  Neg <= '0';

						 -- NOR
						 when "0000000000010000" =>
							  Result <= not (Reg1 or Reg2);
							  Neg <= '0';

						 -- AND
						 when "0000000000100000" =>
							  Result <= Reg1 and Reg2;
							  Neg <= '0';

						 -- XOR
						 when "0000000001000000" =>
							  Result <= Reg1 xor Reg2;
							  Neg <= '0';

						 -- OR
						 when "0000000010000000" =>
							  Result <= Reg1 or Reg2;
							  Neg <= '0';

						 -- XNOR
						 when "0000000100000000" =>
							  Result <= Reg1 xnor Reg2;
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