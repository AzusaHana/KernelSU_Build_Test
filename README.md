# KernelSU_Build_Test  

## Important Things

### Official KernelSU
- For **NonGKI** devices, the last officially supported version of KernelSU is **0.9.5 (11872)**.  
  *(Versions 1.0 and later no longer support NonGKI.)*

### Unofficial KernelSU
- KernelSU built for non-GKI kernels uses the [rsuntk KernelSU](https://github.com/rsuntk/KernelSU) branch and the [backslashxx KernelSU](https://github.com/backslashxx/KernelSU) branch.

### Kernel Source
- The kernel source is entirely from the official ROM authors.  
- The only modification is the addition of KernelSU.

## Installation Guide  

**Anyway, read the [KernelSU official website](https://kernelsu.org/guide/installation.html) first!!**  

1. Download AnyKernel3 from github action  

**LineageOS 23.2**:   
- [OPlus SM8250](https://github.com/AzusaHana/KernelSU_Build_Test/actions/workflows/LineageOS-OPlus-SM8250-Kernel.yml): ```OnePlus 8 | OnePlus 8 Pro | OnePlus 8T | OnePlus 9R```  

2. Flashing AnyKernel3 Using ```adb sideload```  
Reboot your device into recovery mode and execute ```adb sideload AK3-xxx.zip``` to install AnyKernel3.  
> Tip: If your custom recovery does not support flashing AnyKernel3, consider flashing LineageOS recovery first and then proceed.  

3. Using Kernel Flasher to OTA  
After installing the OTA and before rebooting, use [Kernel Flasher](https://github.com/tiann/KernelFlasher) to flash AnyKernel3 into the other slot.  
> Tip: If there is not a local update in ROM, please follow step 2 to flash AnyKernel3 after update.  

## Original Kernel Source  

LineageOS 23.2:  
[OPlus SM8250](https://github.com/LineageOS/android_kernel_oneplus_sm8250)
