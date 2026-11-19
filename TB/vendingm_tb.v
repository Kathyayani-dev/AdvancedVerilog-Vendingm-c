# code for vendingm_tb
  ...
     module vendingm_tb();
        reg clk,rst;
        reg [1:0]a;
        wire [11:0]cnt;
        wire x;
        wire [2:0]s;

        vendingm DUT(clk,rst,a,x,cnt,s);


        parameter C=10;

        always
        begin
                #(C/2);
                clk=1'b1;
                #(C/2);
                clk=~clk;
        end

        task rst_dut();
        begin
                        @(negedge clk);
                        rst=1'b1;
                        @(negedge clk);
                        rst=~rst;
        end
        endtask

        task initialize;
        begin
                        {clk,rst}=0;
        end
        endtask

        task stimulus(input [1:0]i);
        begin
                        @(negedge clk);
                        a=i;
        end
        endtask

        task delay();
        begin
                #10;
        end
        endtask

        initial
        begin
                initialize;
                rst_dut;
                stimulus(2'b00);
                stimulus(2'b01);
                stimulus(2'b10);
                delay;
                stimulus(2'b10);
                delay;
                stimulus(2'b01);
                stimulus(2'b01);
                stimulus(2'b11);

                #100 $finish;
        end

        endmodule
...
