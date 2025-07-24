interface ITop;
    (* always_ready *)
    method Bit#(4) led();
endinterface

(* synthesize, default_reset="RST" *)
module mkTop (ITop);
    // Enable generator (1hz)
    let clkEnCount = 62_500_000; // Arty Z7 base clk is 125Mhz
    Reg#(UInt#(32)) clkEn <- mkReg(clkEnCount);
    Reg#(UInt#(4)) counter <- mkReg(0);

    rule clk_en;
        if (clkEn == 0)
            clkEn <= clkEnCount;
        else
            clkEn <= clkEn - 1;
    endrule

    rule blink (clkEn == 0);
        counter <= counter + 1;
    endrule

    method Bit#(4) led;
        return pack(counter)[3:0];
    endmethod
endmodule
