/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include <multiply.h>
#include <xparameters.h>
#include "xil_printf.h"
#include "xil_io.h"

#define BASEADDR XPAR_MULTIPLY_0_S00_AXI_BASEADDR

int main()
{
    init_platform();

    int out;
    /* #define MULTIPLY_mWriteReg(BaseAddress, RegOffset, Data) */
    for (int i = 0; i < 17; i++ ) {
    	// Reg offset vals are 0, 4 and 8 bytes for slv_reg0, slv_reg1, slv_reg2 respectively
    	MULTIPLY_mWriteReg(BASEADDR, 0, i);
    	MULTIPLY_mWriteReg(BASEADDR, 4, i);
    	out = MULTIPLY_mReadReg(BASEADDR, 8);
    	// Use carriage return or else result comes out like: ....
    	//												   		  ....
		//												   	          ....
    	xil_printf("Result of %d * %d is %d\n\r", i, i, out);
    }

    cleanup_platform();
    return 0;
}
