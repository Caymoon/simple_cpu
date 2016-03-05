--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.1i
--  \   \         Application : ISE
--  /   /         Filename : TTSSS.vhw
-- /___/   /\     Timestamp : Wed Nov 14 10:28:35 2012
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: TTSSS
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY TTSSS IS
END TTSSS;

ARCHITECTURE testbench_arch OF TTSSS IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT cpu
        PORT (
            rst : In std_logic;
            clk : In std_logic;
            abus : Out std_logic_vector (15 DownTo 0);
            dbus : InOut std_logic_vector (15 DownTo 0);
            nmreq : Out std_logic;
            nrd : Out std_logic;
            nwr : Out std_logic;
            nbhe : Out std_logic;
            nble : Out std_logic;
            abusout : Out std_logic_vector (15 DownTo 0);
            irout : Out std_logic_vector (15 DownTo 0);
            dbusout : Out std_logic_vector (15 DownTo 0);
            nmreqout : Out std_logic;
            nrdout : Out std_logic;
            nwrout : Out std_logic;
            nbheout : Out std_logic;
            ttout : Out std_logic_vector (4 DownTo 0);
            nbleout : Out std_logic
        );
    END COMPONENT;

    SIGNAL rst : std_logic := '0';
    SIGNAL clk : std_logic := '0';
    SIGNAL abus : std_logic_vector (15 DownTo 0) := "0000000000000000";
    SIGNAL dbus : std_logic_vector (15 DownTo 0) := "ZZZZZZZZZZZZZZZZ";
    SIGNAL nmreq : std_logic := '0';
    SIGNAL nrd : std_logic := '0';
    SIGNAL nwr : std_logic := '0';
    SIGNAL nbhe : std_logic := '0';
    SIGNAL nble : std_logic := '0';
    SIGNAL abusout : std_logic_vector (15 DownTo 0) := "0000000000000000";
    SIGNAL irout : std_logic_vector (15 DownTo 0) := "0000000000000000";
    SIGNAL dbusout : std_logic_vector (15 DownTo 0) := "0000000000000000";
    SIGNAL nmreqout : std_logic := '0';
    SIGNAL nrdout : std_logic := '0';
    SIGNAL nwrout : std_logic := '0';
    SIGNAL nbheout : std_logic := '0';
    SIGNAL ttout : std_logic_vector (4 DownTo 0) := "00000";
    SIGNAL nbleout : std_logic := '0';

    constant PERIOD : time := 200 ns;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 0 ns;

    BEGIN
        UUT : cpu
        PORT MAP (
            rst => rst,
            clk => clk,
            abus => abus,
            dbus => dbus,
            nmreq => nmreq,
            nrd => nrd,
            nwr => nwr,
            nbhe => nbhe,
            nble => nble,
            abusout => abusout,
            irout => irout,
            dbusout => dbusout,
            nmreqout => nmreqout,
            nrdout => nrdout,
            nwrout => nwrout,
            nbheout => nbheout,
            ttout => ttout,
            nbleout => nbleout
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
                rst <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  285ns
                WAIT FOR 200 ns;
                rst <= '0';
                dbus <= "0000000110000000";
                -- -------------------------------------
                -- -------------  Current Time:  1285ns
                WAIT FOR 1000 ns;
                dbus <= "0000101000000001";
                -- -------------------------------------
                -- -------------  Current Time:  2285ns
                WAIT FOR 1000 ns;
                dbus <= "0011101000000001";
                -- -------------------------------------
                -- -------------  Current Time:  3285ns
                WAIT FOR 1000 ns;
                dbus <= "0111100000000001";
                -- -------------------------------------
                -- -------------  Current Time:  4285ns
                WAIT FOR 1000 ns;
                dbus <= "1111111111111111";
                -- -------------------------------------
                WAIT FOR 5915 ns;

            END PROCESS;

    END testbench_arch;

