# KernelSU_Build_Test  

## Important Things

### Official KernelSU
- For **NonGKI** devices, the last officially supported version of KernelSU is **0.9.5 (11872)**.  
  *(Versions 1.0 and later no longer support NonGKI, so please stop asking why the KernelSU version is always 11872.)*
- Device-specific notes:
  - **4.19 Kernel:** Only **version 1.0.1 (11948)** or earlier of the official KernelSU manager is supported.
  - **5.4 Kernel:** The latest version of the official KernelSU manager is currently supported.

### Kernel Source
- The kernel source is entirely from the official ROM authors.  
- The only modification is the addition of KernelSU.

## Installation Guide  

**Anyway, read the [KernelSU official website](https://kernelsu.org/guide/installation.html) first!!**  

1. Download AnyKernel3 from github action  

**LineageOS 21**:   
- [OPlus SM8250](https://github.com/AzusaHana/KernelSU_Build_Test/actions/workflows/LineageOS-OPlus-SM8250-Kernel.yml): ```OnePlus 8 | OnePlus 8 Pro | OnePlus 8T | OnePlus 9R```  
- [OPlus SM8550](https://github.com/AzusaHana/KernelSU_Build_Test/actions/workflows/LineageOS-Salami-Kernel.yml): ```OnePlus 11 (salami)```  

**Nameless-CLO 15**:  
- [OPlus SM8250 (Chris Chen)](https://github.com/AzusaHana/KernelSU_Build_Test/actions/workflows/Nameless-OPlus-SM8250-Kernel.yml): ```OnePlus 8 | OnePlus 8 Pro | OnePlus 8T | OnePlus 9R```  

**PixelOS 15**:  
- [OPlus SM8250 (jef00)](https://github.com/AzusaHana/KernelSU_Build_Test/actions/workflows/PixelOS-OPlus-SM8250-Kernel.yml): ```OnePlus 8 | OnePlus 8 Pro | OnePlus 8T```  

**Nameless 14**:   
- [OPlus SM8350 (Chandu)](https://github.com/AzusaHana/KernelSU_Build_Test/actions/workflows/Nameless-OPlus-SM8350(Chandu)-Kernel.yml): ```OnePlus 9 | OnePlus 9 Pro```  
- [OPlus SM8550 (Chandu)](https://github.com/AzusaHana/KernelSU_Build_Test/actions/workflows/Nameless-OPlus-SM8550-Kernel.yml): ```OnePlus 11 (salami)```  

2. Flashing AnyKernel3 Using ```adb sideload```  
Reboot your device into recovery mode and execute ```adb sideload AK3-xxx.zip``` to install AnyKernel3.  
> Tip: If your custom recovery does not support flashing AnyKernel3, consider flashing LineageOS recovery first and then proceed.  

3. Using Kernel Flasher to OTA  
After installing the OTA and before rebooting, use [Kernel Flasher](https://github.com/tiann/KernelFlasher) to flash AnyKernel3 into the other slot.  
> Tip: If there is not a local update in ROM, please follow step 2 to flash AnyKernel3 after update.  

## Original Kernel Source  

LineageOS 22:  
[OPlus SM8250](https://github.com/LineageOS/android_kernel_oneplus_sm8250) | [OPlus SM8550](https://github.com/LineageOS/android_kernel_oneplus_sm8550)  

Nameless-CLO 15:  
[OPlus SM8250 (Chris Chen)](https://github.com/Nameless-AOSP-OSS/kernel_oneplus_sm8250)  

PixelOS 15:  
[OPlus SM8250 (jef00)](https://github.com/jef00/kernel_oneplus_sm8250/tree/fifteen)  

Nameless 14:  
[OPlus SM8350 (Chandu)](https://github.com/chandu078/android_kernel_oneplus_sm8350) | [OPlus SM8550 (Chandu)](https://github.com/chandu078/android_kernel_oneplus_sm8550)  
