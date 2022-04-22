#include <linux/module.h> /* Needed by all modules */
#include <linux/kernel.h> /* Needed for KERN_* and printk */
#include <linux/init.h> /* Needed for --init and --exit macros */
#include <asm/io.h>       /* Needed for IO reads and writes */
#include "xparameters.h"  /* Needed for physical address of multiplier */

/* from xparameters.h */
#define PHY_ADDR XPAR_MULTIPLY_0_S00_AXI_BASEADDR // Physical addresss of multiplier
/* size of physical address range for multiply */
#define MEMSIZE XPAR_MULTIPLY_0_S00_AXI_HIGHADDR - XPAR_MULTIPLY_0_S00_AXI_BASEADDR+1

void* virt_addr; // Virtual address pointing to multiplier

/* This function is run upon module load. This is where you setup data structures and reserve
 * resources useb by the module */
static int __init my_init(void)
{
        /* Linux kernel's version of printf */
        printk(KERN_INFO "Mapping virtual address...\n");
        /* Map virtual address to multiplier phys address */
        virt_addr = ioremap(PHY_ADDR, MEMSIZE);
        /* write 7 to register 0 */
        printk(KERN_INFO "Writing a 7 to register 0\n");
        iowrite32(7, virt_addr+0); // Base address + offset
        /* Write 2 to register 1 */
        printk(KERN_INFO "writing a 2 to register 1\n");
        iowrite32(2, virt_addr+4);
        printk("Read %d from register 0\n", ioread32(virt_addr+0));
        printk("Read %d from register 1\n", ioread32(virt_addr+4));
        printk("Read %d from register 2\n", ioread32(virt_addr+8));
        /* print physical address and virtual address of multiply periph */
        printk("Physical Address: %x\n", PHY_ADDR);
        printk("Virtual Address: %x\n", *(int*)virt_addr);
        /* Non-zero return means that init_module failed */
        return 0;
}

/* This function is run just prior to the module's removal from the system. You should release
 * _ALL_ resources used by your module here */
static void __exit my_exit(void)
{
        printk(KERN_ALERT "unmapping virtual address space...\n");
        iounmap((void*)virt_addr);
}
/* These define info that can be displayed by modinfo */
MODULE_LICENSE("GPL");
MODULE_AUTHOR("ECEN449 Seth Pregler");
MODULE_DESCRIPTION("Simple Multiplier Module");

/* Here we define which functions we want to use for initialization and cleanup */
module_init(my_init);
module_exit(my_exit);
