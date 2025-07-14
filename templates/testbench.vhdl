library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB_ is
end TB_;

architecture tb of TB_ is
    signal clk: std_logic := '0';
    signal rst_n: std_logic := '1';

    signal sim_stopped: std_logic := '0'; 

    constant ClockPeriod: time := 1 ns;
begin

    TestProcess: process
    begin
        -- Initialize all signals here
        rst_n <= '0';
        wait for ClockPeriod;
        rst_n <= '1';


        -- Put your logic here
        wait until rising_edge(clk);

        for i in 0 to 9 loop
            wait until rising_edge(clk);
        end loop;

        -- Stop the simulation and return
        sim_stopped <= '1';
        report "Simulation Finished!";
        wait;
    end process TestProcess;

    ClockGen: process
    begin
        if sim_stopped = '0' then 
            clk <= not clk;
            wait for ClockPeriod/2;
        else
            wait;
        end if;
    end process ClockGen;

end tb;
