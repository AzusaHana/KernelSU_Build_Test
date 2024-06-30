# KernelSU_Build_Test  

## Improtant Things
- KernelSU  
For NonGKI devices, the version 0.9.5 (11872) of KernelSU is the last version (version 1.0 no longer supports NonGKI), so don't ask why the KernelSU version is always 11872. However, you can still update the KernelSU manager.

- Kernel Source  
The kernel source used is all from the official ROM authors, and there have been no modifications except for adding KernelSU

## Installation Guide  

**Anyway, read the [KernelSU official website](https://kernelsu.org/guide/installation.html) first!!**  

1. Download AnyKernel3 from github action  
**Nameless 14**: [OPlus SM8250 (Chris Chen)](https://github.com/AzusaHana/KernelSU_Build_Test/actions/workflows/Nameless-OPlus-SM8250-Kernel.yml) | [OPlus SM8350 (Chandu)](https://github.com/AzusaHana/KernelSU_Build_Test/actions/workflows/Nameless-OPlus-SM8350(Chandu)-Kernel.yml) | [OPlus SM8350 (pjgowtham)](https://github.com/AzusaHana/KernelSU_Build_Test/actions/workflows/Nameless-OPlus-SM8350(pjgowtham)-Kernel.yml)  
> Supported Devices:  
> - OPlus SM8250 (Chris Chen): ```OnePlus 8 | OnePlus 8 Pro | OnePlus 8T | OnePlus 9R```   
> - OPlus SM8350 (Chandu): ```OnePlus 9 | OnePlus 9 Pro```   
> - OPlus SM8350 (pjgowtham): ```OnePlus 9RT | realme GT | realme GT 2 | realme GT Master Edition```  

2. Using ```adb sideload``` to flash AnyKernel3  
Reboot to recovery mode and use ```adb sideload AK3-xxx.zip``` to flash AnyKernel3.
> Tips: If your custom recovery does not support flashing AnyKernel3, please try to flash TWRP or OrangeFox first.
>> OrangeFox: [OPlus SM8250](https://github.com/Wishmasterflo/device_oneplus_opkona)  

3. Using Kernel Flasher to OTA  
After installing the OTA and before rebooting, use Kernel Flasher to flash AnyKernel3 into the other slot.
