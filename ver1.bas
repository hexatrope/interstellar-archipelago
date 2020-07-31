10 rem ##### INTERSTELLAR ARCHIPELAGO #####

20 rem ## NOTES ABOUT GLOBAL VARIABLES ##
30 rem shp$(2): Ship - Name / Holds
40 rem crg(4): Ship cargo - Commodities: Raw Ore/Antimatter/Nanotech/Biologics
50 rem cmm(4,3): Commodities - Name / Low / High
60 rem prt$(7,6): Starports - Name / Distance / Comm 1 price / Comm 2 price
70 rem Comm 3 price / Comm 4 price
80 rem loc: Location - number of the station (from prt$)



100 rem NOTES
110 rem create fluctuation numbers for commodities
120 rem each commodity price fluctuates, correcting if too far over/under
130 rem create function for travel between ports
140 rem create function for trading



200 rem #### START HERE
210 gosub 7000: rem Initialize the Game
220 gosub 8000: rem Start game



1000 rem #### MAIN
1010 gosub 8400
1020 print "(T)rade or (D)epart ";
1030 input i$
1040 print
1050 if i$ = "t" then goto 5000
1060 if i$ = "d" then goto 3000
1070 print "Please Choose:":print
1080 goto 1020


2000 end



3000 rem #### TRAVEL
3010 gosub 8300
3020 print "Choose starport number (or 0 to stay) ";
3030 input i$
3040 print
3050 n = val(i$)
3060 if n > 0 and n < 8 then goto 3100
3070 if n = 0 then goto 1000
3080 goto 3020
3100 loc = n
3110 print:print:print ".";:print ".";:print ".";:print ".";:print ".";
3120 goto 1000



5000 rem #### TRADE
3010 rem " / "; cmm$(1,1); ": "; prt$(i, 3); " / "; cmm$(2,1);
3020 rem ": "; prt$(i, 4); " / "; cmm$(3,1); ": "; prt$(i, 5);
3030 rem " / "; cmm$(4,1); ": "; prt$(i, 6)



7000 rem #### INITIALIZE! ####
7010 rem NOTE THAT MOST VERSIONS OF BASIC WILL TAKE LONG VARIABLE NAMES,
7020 rem BUT ONLY RECOGNIZE THE FIRST TWO CHARACTERS. ALL VAR NAMES LONGER THAN
7030 rem TWO CHARACTERS HAVE THE FIRST TWO CHARS UNIQUE SO THEY DON'T COLLIDE.
7040 rem NOTE ALSO THAT VAR NAMES WILL PRODUCE AN ERROR IF THEY CONTAIN
7050 rem RESERVED WORD (LIKE RUN, RND, ETC)

7100 rem ## SHIP
7110 rem Hold the ship data:
7120 rem Name / Holds
7130 dim shp$(2)
7140 rem Get name at startup
7150 shp$(2) = "20"

7200 rem ## SHIP CARGO
7210 rem Hold info on the current ship cargo:
7220 rem Commodity list, same order: Raw Ore/Antimatter/Nanotech/Biologics
7230 dim crg(4): rem ## fix this later to get rid of magic numbers
7240 for i = 1 to 4
7250 crg(a) = 0
7260 next i

7300 rem ## COMMODITIES
7310 rem this just holds the data for commodities in general
7320 rem it is easily accessed when prices are computed for each station
7330 rem Each commodity array holds:
7340 rem Name / Low / High

7350 dim cmm$(4,3)
7360 for item = 1 to 4
7370 for nmr = 1 to 3
7380 read cmm$(item,stat)
7390 next nmr
7400 next item

7410 rem ## COMMODITY DATA - Name / Price Low / Price High
7420 data "raw ore", "15", "120"
7430 data "antimatter", "90", "375"
7440 data "nanotech", "250", "2500"
7450 data "biologics", "750", "4500"

7500 rem ## PORTS
7510 rem Each port array row holds: (1) Name / (2) Distance
7520 rem (3) Commodity 1 current price / (4) Commodity 2 current price
7530 rem (5) Commodity 3 current price / (6) Commodity 4 current price
7540 dim prt$(7,6)
7550 for sp = 1 to 7: rem sp is for "starport"
7560 for mt = 1 to 2: rem mt is for "metric"
7570 read it$
7580 prt$(sp,mt) = it$
7590 next mt
7600 for prc = 3 to 6: rem prc is for "price"
7610 rem Calculate the price range between Price Low and Price High
7620 rng = val(cmm$((prc - 2),3)): rem rng is for "range"
7630 rng = rng - val(cmm$((prc - 2),2))
7640 rem Random num bet 0 and the price range, add the low end of the range plus
7650 rem  1, so final result is a random price between Price Low and Price High.
7660 nmb = int(rnd(1)*rng): rem nmb is for "number"
7670 prt$(sp,prc) = str$(nmb +(val(cmm$((prc - 2),2)) + 1))
7680 next prc
7690 next sp

7700 rem ## PORT DATA - Name / Distance
7710 data "Irae", "50"
7720 data "Lacrimosa", "80"
7730 data "Fidelium", "110"
7740 data "Perpetua", "125"
7750 data "Sanctam", "140"
7760 data "Aeternum", "160"
7770 data "Eleison", "200"

7800 loc = 1: rem start at the first starport in the list

7900 return


8000 rem #### START THE GAME ####
8010 print:print:print:print:print
8020 print "Interstellar Archipelago": print
8030 print "----------------------------------------"
8040 print "You make your living flying a small"
8050 print "trader ship in a solar system on the"
8060 print "far flung edge of colonized space. Life"
8070 print "out here is hard, and supply lines are"
8080 print "thin. Real money can be made getting"
8090 print "goods from one port to another.": print
8100 gosub 10000

8110 print:print "The starports of the archipelago are"
8120 print "laid out in a loose line, extending out"
8130 print "from the central star in the system.": print: print

8140 print "These are the ports, along with how"
8150 print "many million miles each is from the"
8160 print "system's center:":print:print
8170 gosub 10000
8180 gosub 8300
8190 return



8300 rem #### PRINT PORTS
8310 rem ## fix next line to remove magic numbers
8320 for i = 1 to 7
8330 print i;") ";prt$(i,1);" / ";prt$(i, 2);" million":print
8340 next i
8350 return



8400 rem #### PRINT LOCATION
8410 print: print: print "LOC: Starport "; prt$(loc,1)
8420 print "----------------------------------------"
8430 return



10000 rem #### Pause / Continue
10010 print "[RET] to continue ";
10020 input i$
10030 print:print:print
10040 return
