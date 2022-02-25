#include <xparameters.h>
#include <xgpio.h>	// Header file for AXI GPIO
#include <xstatus.h>
#include <xil_printf.h>

// Define for peripherals for both LED and BTN/Switch GPIO blocks according to xparameters.h
#define LED XPAR_LED_DEVICE_ID
#define BTN_SWITCH XPAR_BTN_SWITCH_DEVICE_ID
#define WAIT_VAL 10000000


int delay(void);

int main()
{
    int count, count_masked;
    int val, val_l, val_h;
    int status1, status2;

    XGpio led, btn_switch;	// XGpio structs... led(output), btn_switch(input)

    // Initialize both GPIO blocks
    status1 = XGpio_Initialize(&led, LED);
    status2 = XGpio_Initialize(&btn_switch, BTN_SWITCH);

    // Set data direction for both GPIO blocks
    XGpio_SetDataDirection(&led, 1,  0x00);	// Set data direction to outpupt
    XGpio_SetDataDirection(&btn_switch, 1, 0xFF);	// Set data direction to input

    // Verify the initialization of LEDs
    if (status1 != XST_SUCCESS) {
        xil_printf(" Initialization of LEDs Failed");
    }

    // Verify the initialization of buttons and switches
    if (status2 != XST_SUCCESS) {
        xil_printf(" Initialization of Buttons and Switches Failed");
    }

    count = 0;
    count_masked = 0;
    while (1)
    {
    	// Read value of input GPIO block
    	val = XGpio_DiscreteRead(&btn_switch, 1);
    	val_l = val & 0x0F; // Grab lowest 4 bits for switches
    	val_h = val & 0xF0; // Grab upper 4 bits for buttons

    	if (val_h == 0x10) // if btn0 is pressed, increment count
    	{
    		count++;
    		count_masked = count & 0xF;
    		xil_printf("Value of count = 0x%x \n\r", count_masked);

    	}

    	else if (val_h == 0x20) // if btn1 is pressed, decrement count
    	{
    		count--;
    		count_masked = count & 0xF;
    		xil_printf("Value of count = 0x%x \n\r", count_masked);
    	}

    	else if (val_h == 0x40) // if btn3 is pressed, display status of switches
    	{
    		XGpio_DiscreteWrite(&led, 1, val_l); // Display upper 4 bits to LEDs
    		xil_printf("Value of switches: 0x%x \n\r", val_l);

    	}

    	else if (val_h == 0x80)
    	{
    		count_masked = count & 0xF;
    		XGpio_DiscreteWrite(&led, 1, count_masked);
    	}
        delay();
    }
    return (0);
}

int delay(void)
{
    volatile int delay_count=0;
    while(delay_count < WAIT_VAL)
    {
        delay_count++;
    }
    return(0);
}

