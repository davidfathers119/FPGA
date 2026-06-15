`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/06/15 08:57:59
// Design Name: 
// Module Name: test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test(
    input clk,
    output reg LED // LED 在 always 內賦值，需宣告為 reg
    );

    reg [25:0] cnt = 0; // 宣告足夠寬度的暫存器並給予初始值

    always @(posedge clk) begin
        if (cnt == 49999999) begin // 50,000,000 個週期 = 0.5秒 (100MHz時鐘)
            cnt <= 0;
            LED <= ~LED; // 使用非阻塞賦值，0.5秒翻轉一次 = 1秒閃爍週期
        end else begin
            cnt <= cnt + 1;
        end
    end 
endmodule
