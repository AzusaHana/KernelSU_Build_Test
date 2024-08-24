# KernelSU_Build_Test  

## Improtant Things
- KernelSU  
For **NonGKI** devices, the version **0.9.5 (11872)** of KernelSU is the last version (version 1.0 no longer supports NonGKI), so don't ask why the KernelSU version is always 11872. Also, the last supported manager version is **1.0.1 (11948)**.

- Kernel Source  
The kernel source used is all from the official ROM authors, and there have been no modifications except for adding KernelSU.

## Installation Guide  

**Anyway, read the [KernelSU official website](https://kernelsu.org/guide/installation.html) first!!**  

1. Download AnyKernel3 from github action  

**LineageOS 21**: [OPlus SM8250](https://github.com/AzusaHana/KernelSU_Build_Test/actions/workflows/LineageOS-OPlus-SM8250-Kernel.yml) | [OPlus SM8550](https://github.com/AzusaHana/KernelSU_Build_Test/actions/workflows/LineageOS-Salami-Kernel.yml)  
> Supported Devices:  
> - OPlus SM8250: ```OnePlus 8 | OnePlus 8 Pro | OnePlus 8T | OnePlus 9R```  
> - OPlus SM8550: ```OnePlus 11 (Salami)```  

**Nameless 14**: [OPlus SM8250 (Chris Chen)](https://github.com/AzusaHana/KernelSU_Build_Test/actions/workflows/Nameless-OPlus-SM8250-Kernel.yml) | [OPlus SM8350 (Chandu)](https://github.com/AzusaHana/KernelSU_Build_Test/actions/workflows/Nameless-OPlus-SM8350(Chandu)-Kernel.yml) | [OPlus SM8350 (pjgowtham)](https://github.com/AzusaHana/KernelSU_Build_Test/actions/workflows/Nameless-OPlus-SM8350(pjgowtham)-Kernel.yml) | [OPlus SM8550 (Chandu)](https://github.com/AzusaHana/KernelSU_Build_Test/actions/workflows/Nameless-OPlus-SM8550-Kernel.yml)  
> Supported Devices:  
> - OPlus SM8250 (Chris Chen): ```OnePlus 8 | OnePlus 8 Pro | OnePlus 8T | OnePlus 9R```   
> - OPlus SM8350 (Chandu): ```OnePlus 9 | OnePlus 9 Pro```   
> - OPlus SM8350 (pjgowtham): ```OnePlus 9RT | realme GT | realme GT 2 | realme GT Master Edition (lunaa)```
> - OPlus SM8550: ```OnePlus 11 (Salami)```  

**PixelOS 14**: [OPlus SM8250 (jef00)](https://github.com/AzusaHana/KernelSU_Build_Test/actions/workflows/PixelOS-OPlus-SM8250-Kernel.yml)  
> Supported Devices:  
> - OPlus SM8250 (jef00): ```OnePlus 8 | OnePlus 8 Pro | OnePlus 8T | OnePlus 9R```   

2. Using ```adb sideload``` to flash AnyKernel3  
Reboot to recovery mode and use ```adb sideload AK3-xxx.zip``` to flash AnyKernel3.
> Tip: If your custom recovery does not support flashing AnyKernel3, please try to flash TWRP or OrangeFox first.
>> OrangeFox: [OnePlus 8 series and 9R](https://xdaforums.com/t/recovery-unofficial-orangefox-recovery-project-oneplus-8-8t-8-pro-9r-22-may-2024.4515657) | [OnePlus 9/9 Pro](https://xdaforums.com/t/recovery-unofficial-a12-a14-orangefox-recovery-project-oneplus-9-9-pro-28-05-2024.4601751)  

3. Using Kernel Flasher to OTA  
After installing the OTA and before rebooting, use [Kernel Flasher](https://github.com/tiann/KernelFlasher) to flash AnyKernel3 into the other slot.
> Tip: If there is not a local update in ROM, please follow step 2 to flash AnyKernel3 after update.

## Original Kernel Source  

LineageOS 21: [OPlus SM8250](https://github.com/LineageOS/android_kernel_oneplus_sm8250) | [OPlus SM8550](https://github.com/LineageOS/android_kernel_oneplus_sm8550)  
Nameless 14: [OPlus SM8250 (Chris Chen)](https://github.com/Nameless-AOSP-OSS/kernel_oneplus_sm8250) | [OPlus SM8350 (Chandu)](https://github.com/chandu078/android_kernel_oneplus_sm8350) | [OPlus SM8350 (pjgowtham)](https://github.com/pjgowtham/android_kernel_oneplus_sm8350) | [OPlus SM8550 (Chandu)](https://github.com/chandu078/android_kernel_oneplus_sm8550)  
PixelOS 14: [OPlus SM8250 (jef00)](https://github.com/jef00/kernel_oneplus_sm8250/tree/lineage-21-aosp-new)  
