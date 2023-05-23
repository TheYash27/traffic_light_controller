module Traffic_Light_Controller(


    input clk, reset,
    output reg [2:0] main_lr,
    output reg [2:0] side_lr,
    output reg [2:0] main_lr_side,
    output reg [2:0] main_rl_side
    );
    
    parameter S1=1, 
              S2=2, 
              S3=3, 
              S4=4, 
              S5=5,
              S6=6;
    reg [3:0]count;
    reg[2:0] ps;
    parameter main_lr_side_switch=4,
              main_lr_switch=3,
              red_yellow=1,
              side_lr_switch=2;

   
    
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            ps<=S1;
            count<=0;
            end
        else 
            case(ps)
                S1: if(count < main_lr_side_switch) begin
                        ps <= S1;
                        count <= (count + 1);
                        end
                    else begin
                        ps <= S2;
                        count <= 0;
                        end
                S2: if(count < red_yellow) begin
                        ps <= S2;
                        count <= (count + 1);
                        end
                    else begin
                        ps <= S3;
                        count<=0;
                        end
                S3: if(count < main_lr_switch) begin
                        ps <= S3;
                        count <= (count + 1);
                        end
                    else begin
                        ps <= S4;
                        count <= 0;
                        end
                S4:if(count < red_yellow) begin
                        ps <= S4;
                        count <= (count + 1);
                        end
                    else begin
                        ps <= S5;
                        count <= 0;
                        end
                S5:if(count < side_lr_switch) begin
                        ps <= S5;
                        count <= (count + 1);
                        end
                    else begin
                        ps <= S6;
                        count <= 0;
                        end
                S6:if(count < red_yellow) begin
                        ps <= S6;
                        count <= (count+1);
                        end
                    else begin
                        ps <= S1;
                        count <= 0;
                        end
                default: 
                    ps <= S1;
                endcase
            end   

            always @(ps) begin
                case(ps)
                    S1:
                    begin
                       main_lr <= 3'b001;
                       main_rl_side <= 3'b001;
                       main_lr_side <= 3'b100;
                       side_lr <= 3'b100;
                    end
                    S2:
                    begin 
                       main_lr <= 3'b001;
                       main_rl_side <= 3'b010;
                       main_lr_side <= 3'b100;
                       side_lr <= 3'b100;
                    end
                    S3:
                    begin
                       main_lr <= 3'b001;
                       main_rl_side <= 3'b100;
                       main_lr_side <= 3'b001;
                       side_lr <= 3'b100;
                    end
                    S4:
                    begin
                       main_lr <= 3'b010;
                       main_rl_side <= 3'b100;
                       main_lr_side <= 3'b010;
                       side_lr <= 3'b100;
                    end
                    S5:
                    begin
                       main_lr <= 3'b100;
                       main_rl_side <= 3'b100;
                       main_lr_side <= 3'b100;
                       side_lr <= 3'b001;
                    end
                    S6:
                    begin 
                       main_lr <= 3'b100;
                       main_rl_side <= 3'b100;
                       main_lr_side <= 3'b100;
                       side_lr <= 3'b010;
                    end
                    default:
                    begin 
                       main_lr <= 3'b000;
                       main_rl_side <= 3'b000;
                       main_lr_side <= 3'b000;
                       side_lr <= 3'b000;
                    end
                    endcase
            end                
endmodule

module Traffic_Light_Controller_Test_Bench;
reg clk, reset;
wire [2:0] main_lr;
wire [2:0] side_lr;
wire [2:0] main_lr_side;
wire [2:0] main_rl_side;

Traffic_Light_Controller dut(
    .clk(clk),
    .reset(reset),
    .main_lr(main_lr),
    .side_lr(side_lr),
    .main_rl_side(main_rl_side),
    .main_lr_side(main_lr_side)   
);
initial begin
    clk = 1'b0;
    forever #50 clk = ~clk;
end

initial begin
    reset = 0;
    #100;
    reset = 1;
    #100;
    reset = 0;
    #2000; #2000; #2000; #2000; #2000; #2000; #2000; #2000; #2000; #2000;
    $finish;
    end
endmodule