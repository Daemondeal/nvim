module DUTNAME_tb;
    // Signals

    /*AUTOREGINPUT*/
    /*AUTOLOGIC*/

    // DUT
    DUTNAME dut (/*AUTOINST*/);


    logic i_clk = 0;
    logic i_rst_n = 0;
    always #0.5ns i_clk = !i_clk;

    initial begin
      i_rst_n = 1;
      @(posedge clk);
      #2;
      i_rst_n = 0;
      @(posedge clk);

    end
endmodule
