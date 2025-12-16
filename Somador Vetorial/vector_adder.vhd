library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vector_adder is
    port (
        A_i       : in  STD_LOGIC_VECTOR(31 downto 0);
        B_i       : in  STD_LOGIC_VECTOR(31 downto 0);
        mode_i    : in  STD_LOGIC;
        vecSize_i : in  STD_LOGIC_VECTOR(1 downto 0);
        S_o       : out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity vector_adder;

architecture Behavioral of vector_adder is
begin
    vector_operation_proc : process(A_i, B_i, mode_i, vecSize_i)
    begin
        case vecSize_i is

            when "00" => -- Vetor com 8 elementos de 4 bits
                for i in 0 to 7 loop
                    if mode_i = '0' then
                        S_o((i*4)+3 downto i*4) <= std_logic_vector(
                            unsigned(A_i((i*4)+3 downto i*4)) + 
                            unsigned(B_i((i*4)+3 downto i*4))
                        );
                    else
                        S_o((i*4)+3 downto i*4) <= std_logic_vector(
                            unsigned(A_i((i*4)+3 downto i*4)) - 
                            unsigned(B_i((i*4)+3 downto i*4))
                        );
                    end if;
                end loop;

            when "01" => -- Vetor com 4 elementos de 8 bits
                for i in 0 to 3 loop
                    if mode_i = '0' then
                        S_o((i*8)+7 downto i*8) <= std_logic_vector(
                            unsigned(A_i((i*8)+7 downto i*8)) + 
                            unsigned(B_i((i*8)+7 downto i*8))
                        );
                    else
                        S_o((i*8)+7 downto i*8) <= std_logic_vector(
                            unsigned(A_i((i*8)+7 downto i*8)) - 
                            unsigned(B_i((i*8)+7 downto i*8))
                        );
                    end if;
                end loop;

            when "10" => -- Vetor com 2 elementos de 16 bits
                for i in 0 to 1 loop
                    if mode_i = '0' then
                        S_o((i*16)+15 downto i*16) <= std_logic_vector(
                            unsigned(A_i((i*16)+15 downto i*16)) + 
                            unsigned(B_i((i*16)+15 downto i*16))
                        );
                    else
                        S_o((i*16)+15 downto i*16) <= std_logic_vector(
                            unsigned(A_i((i*16)+15 downto i*16)) - 
                            unsigned(B_i((i*16)+15 downto i*16))
                        );
                    end if;
                end loop;

            when "11" => -- Vetor com 1 elemento de 32 bits
                if mode_i = '0' then
                    S_o <= std_logic_vector(unsigned(A_i) + unsigned(B_i));
                else
                    S_o <= std_logic_vector(unsigned(A_i) - unsigned(B_i));
                end if;

            when others =>
                S_o <= (others => 'X');
                
        end case;
    end process vector_operation_proc;
    
end architecture Behavioral;