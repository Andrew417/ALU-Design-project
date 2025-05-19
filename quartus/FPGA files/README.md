# Digital-Tube-Decoder
a specific module that converts 8-bit signed binary inputs into Binary-Coded Decimal (BCD) format and displays the result on The FPGA's 4-digit 7-segment display (Digital Tube).

# How it works 
if the selection is 0 then the ALU preforms an arithmetic operation, so it showes the signed decimal value on the 7-seg displays <br>
if the selection is 0 then the ALU preforms a logical operation, so it showes the 4-bit binary value on the 7-seg displays <br>

# How to use 
1- include all (.v) files in your project <br>
2- instanitate "Top_module.v" to your ALU top module where:<br>
    - Output of the ALU is connected to input (A)<br>
    - The MSB of the selection line is connectd to the input (sel)<br>
    - system clock should be connected to the input (clk)<br>
   <div align="center">
  <img src="https://github.com/abdallah-zein/Digital-Tube-Decoder/blob/main/Images/block-diagram.jpg" alt=" System Block Diagram">
</div>
<br>
