//***************************全局宏定义***********************************************

`define RstEnable       1'b1
`define RstDisable      1'b0
`define ChipEnable      1'b1
`define ChipDisable     1'b0
`define ZeroWord        32'h0000_0000
`define AluOpBus        7:0
`define AluSelBus       2:0
`define WriteEnable     1'b1
`define WriteDisable    1'b0
`define ReadEnable      1'b1
`define ReadDisable     1'b0    
`define InstValid       1'b1    //  指令有效
`define InstInvalid     1'b0    //  指令无效

//***************************指令宏定义**********************************************

`define InstAddrBus     31:0
`define InstBus         31:0

//***************************Regfile宏定义******************************************

`define RegAddrBus      4:0
`define RegDataBus      31:0
`define RegNum          32
`define NOPRegAddr      5'b0000_0

//***************************指令宏定义**********************************************

`define EX_ORI          6'b0011_01
`define EX_NOP          6'b0000_00

//***************************ALU宏定义***********************************************

`define EX_OP_OR        8'b0010_0101
`define EX_OP_NOP       8'b0000_0000

`define EX_SEL_LOGIC    3'b001
`define EX_SEL_NOP      3'b000

