--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.1i
--  \   \         Application : ISE
--  /   /         Filename : testalu.vhw
-- /___/   /\     Timestamp : Fri Dec 07 20:56:21 2012
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: testalu
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY testalu IS
END testalu;

ARCHITECTURE testbench_arch OF testalu IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT alu
        PORT (
            ir : In std_logic_vector (15 DownTo 0);
            pcin : In std_logic_vector (15 DownTo 0);
            t2 : In std_logic;
            t3 : In std_logic;
            clk : In std_logic;
            rest : In std_logic;
            aluout : Out std_logic_vector (7 DownTo 0);
            addr : Out std_logic_vector (15 DownTo 0);
            pcnewout : Out std_logic_vector (15 DownTo 0);
            Rupdate : In std_logic;
            writereq : Out std_logic;
            zout : Out std_logic;
            cyout : Out std_logic;
            readreq : Out std_logic;
            Raddr : In std_logic_vector (2 DownTo 0);
            Rdata : In std_logic_vector (7 DownTo 0);
            Rdataout : Out std_logic_vector (7 DownTo 0)
        );
    END COMPONENT;

    SIGNAL ir : std_logic_vector (15 DownTo 0) := "0000000000000000";
    SIGNAL pcin : std_logic_vector (15 DownTo 0) := "0000000000000000";
    SIGNAL t2 : std_logic := '0';
    SIGNAL t3 : std_logic := '0';
    SIGNAL clk : std_logic := '0';
    SIGNAL rest : std_logic := '0';
    SIGNAL aluout : std_logic_vector (7 DownTo 0) := "00000000";
    SIGNAL addr : std_logic_vector (15 DownTo 0) := "0000000000000000";
    SIGNAL pcnewout : std_logic_vector (15 DownTo 0) := "0000000000000000";
    SIGNAL Rupdate : std_logic := '0';
    SIGNAL writereq : std_logic := '0';
    SIGNAL zout : std_logic := '0';
    SIGNAL cyout : std_logic := '0';
    SIGNAL readreq : std_logic := '0';
    SIGNAL Raddr : std_logic_vector (2 DownTo 0) := "000";
    SIGNAL Rdata : std_logic_vector (7 DownTo 0) := "00000000";
    SIGNAL Rdataout : std_logic_vector (7 DownTo 0) := "00000000";

    constant PERIOD : time := 200 ns;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 0 ns;

    BEGIN
        UUT : alu
        PORT MAP (
            ir => ir,
            pcin => pcin,
            t2 => t2,
            t3 => t3,
            clk => clk,
            rest => rest,
            aluout => aluout,
            addr => addr,
            pcnewout => pcnewout,
            Rupdate => Rupdate,
            writereq => writereq,
            zout => zout,
            cyout => cyout,
            readreq => readreq,
            Raddr => Raddr,
            Rdata => Rdata,
            Rdataout => Rdataout
        );

        PROCESS    -- clock process for clk
        BEGIN
            WAIT for OFFSET;
            CLOCK_LOOP : LOOP
                clk <= '0';
                WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
                clk <= '1';
                WAIT FOR (PERIOD * DUTY_CYCLE);
            END LOOP CLOCK_LOOP;
        END PROCESS;

        PROCESS
            BEGIN
                -- -------------  Current Time:  85ns
                WAIT FOR 85 ns;
                rest <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  285ns
                WAIT FOR 200 ns;
                rest <= '0';
                Rupdate <= '1';
                ir <= "0000000110000000";
                Raddr <= "001";
                Rdata <= "00000001";
                -- -------------------------------------
                -- -------------  Current Time:  485ns
                WAIT FOR 200 ns;
                Rupdate <= '0';
                Raddr <= "000";
                -- -------------------------------------
                -- -------------  Current Time:  685ns
                WAIT FOR 200 ns;
                Rupdate <= '1';
                ir <= "0000101000000001";
                Raddr <= "010";
                -- -------------------------------------
                -- -------------  Current Time:  885ns
                WAIT FOR 200 ns;
                Rupdate <= '0';
                Raddr <= "000";
                -- -------------------------------------
                -- -------------  Current Time:  1285ns
                WAIT FOR 400 ns;
                ir <= "0010100100000010";
                -- -------------------------------------
                -- -------------  Current Time:  1485ns
                WAIT FOR 200 ns;
                t2 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  1685ns
                WAIT FOR 200 ns;
                t2 <= '0';
                t3 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  1885ns
                WAIT FOR 200 ns;
                t3 <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  2285ns
                WAIT FOR 400 ns;
                t2 <= '1';
                ir <= "0011101000000001";
                -- -------------------------------------
                -- -------------  Current Time:  2485ns
                WAIT FOR 200 ns;
                t2 <= '0';
                t3 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  2685ns
                WAIT FOR 200 ns;
                t3 <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  3085ns
                WAIT FOR 400 ns;
                t2 <= '1';
                ir <= "0101001000000010";
                -- -------------------------------------
                -- -------------  Current Time:  3285ns
                WAIT FOR 200 ns;
                t2 <= '0';
                t3 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  3485ns
                WAIT FOR 200 ns;
                t3 <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  3885ns
                WAIT FOR 400 ns;
                t2 <= '1';
                ir <= "0100001010000011";
                -- -------------------------------------
                -- -------------  Current Time:  4085ns
                WAIT FOR 200 ns;
                t2 <= '0';
                t3 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  4285ns
                WAIT FOR 200 ns;
                t3 <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  4685ns
                WAIT FOR 400 ns;
                t2 <= '1';
                ir <= "0111100000000001";
                -- -------------------------------------
                -- -------------  Current Time:  4885ns
                WAIT FOR 200 ns;
                t2 <= '0';
                t3 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  5085ns
                WAIT FOR 200 ns;
                t3 <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  5485ns
                WAIT FOR 400 ns;
                t2 <= '1';
                ir <= "0110100000000000";
                -- -------------------------------------
                -- -------------  Current Time:  5685ns
                WAIT FOR 200 ns;
                t2 <= '0';
                t3 <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  5885ns
                WAIT FOR 200 ns;
                t3 <= '0';
                -- -------------------------------------
                WAIT FOR 4315 ns;

            END PROCESS;

    END testbench_arch;

