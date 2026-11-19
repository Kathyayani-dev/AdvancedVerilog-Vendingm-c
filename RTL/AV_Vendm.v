# code for vendingm.v
  ...
     module vendingm(clk,rst,a,x,cnt,s);
        input [1:0]a;
        input clk,rst;
        output x;

        parameter s00=3'b000,
                s25=3'b001,
                s50=3'b010,
                s75=3'b011,
                s100=3'b100;

        output reg [2:0]s;
        reg [2:0]n_s;

        /*always@(posedge clk)
        begin
                if(rst) s<=s00;
                else s<=n_s;
        end*/

        always@(s,a)
        begin
                case(s)
                        s00:
                           begin
                                if(a==2'b00) n_s=s25;
                                else if(a==2'b01) n_s=s50;
                                else if(a==2'b10) n_s=s100;
                                else n_s=s00;
                           end
                        s25:
                            begin
                                if(a==2'b00) n_s=s50;
                                else if(a==2'b01) n_s=s75;
                                else if(a==2'b10) n_s=s100;
                                else n_s=s25;
                            end
                        s50:
                            begin
                                if(a==2'b00) n_s=s75;
                                else if(a==2'b01) n_s=s100;
                                else if(a==2'b10) n_s=s100;
                                else n_s=s50;
                             end
                        s75:
                             begin
                                if(a==2'b00) n_s=s100;
                                else if(a==2'b01) n_s=s100;
                                else if(a==2'b10) n_s=s100;
                                else n_s=s75;
                              end
                        s100:
                              begin
                                n_s=s00;
                              end
                        default: n_s=s00;
                endcase
        end



        always@(posedge clk)
        begin
                if(rst)
                begin
                        cnt<=12'b0;
                        s<=s00;
                end
                else if((cnt==12'd150)&& ((s==s25)||(s==s50)||(s==s75)) )
                begin
                        cnt<=12'b0;
                        s<=s00;
                end
                else
                begin
                        cnt<=cnt+12'b1;
                        s<=n_s;
                end
        end

        assign x=(s==s100);

endmodule
...
