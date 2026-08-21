#!/bin/bash

patch_files=(
    fs/exec.c
    fs/open.c
    fs/stat.c
    kernel/reboot.c
)

for i in "${patch_files[@]}"; do
    if grep -q "ksu" "$i"; then
        echo "Warning: $i contains KernelSU"
        continue
    fi

    case $i in

    # ==================== fs/exec.c ====================
    fs/exec.c)
        sed -i '/^static int do_execveat_common(/,/^[[:space:]]*return retval;/ {
            /^[[:space:]]*int retval;$/a\
\
#ifdef CONFIG_KSU\
\textern int ksu_handle_execveat(int *, struct filename **, void *, void *, int *);\
\tksu_handle_execveat(\&fd, \&filename, \&argv, \&envp, \&flags);\
#endif
        }' fs/exec.c
        ;;

    # ==================== fs/open.c ====================
    fs/open.c)
        sed -i '/^SYSCALL_DEFINE3(faccessat, int, dfd, const char __user \*, filename, int, mode)/,/^}/ {
            /{/a\
#ifdef CONFIG_KSU\
\textern int ksu_handle_faccessat(int *, const char __user **, int *, int *);\
\tksu_handle_faccessat(\&dfd, \&filename, \&mode, NULL);\
#endif
        }' fs/open.c
        ;;

    # ==================== fs/stat.c ====================
    fs/stat.c)
        sed -i '/^SYSCALL_DEFINE4(newfstatat, int, dfd,/,/^}/ {
            /int error;/a\
\
#ifdef CONFIG_KSU\
\textern int ksu_handle_stat(int *, const char __user **, int *);\
\tksu_handle_stat(\&dfd, \&filename, \&flag);\
#endif
        }' fs/stat.c

        sed -i '/^SYSCALL_DEFINE4(fstatat64, int, dfd,/,/^}/ {
            /int error;/a\
\
#ifdef CONFIG_KSU\
\textern int ksu_handle_stat(int *, const char __user **, int *);\
\tksu_handle_stat(\&dfd, \&filename, \&flag);\
#endif
        }' fs/stat.c

        sed -i '/^SYSCALL_DEFINE2(newfstat, unsigned int, fd, struct stat __user \*, statbuf)/,/^}/ {
            /error = vfs_fstat(fd, \&stat);/a\
\
#pragma GCC diagnostic push\
#pragma GCC diagnostic ignored "-Wdeclaration-after-statement"\
#if defined(CONFIG_KSU) \&\& !defined(CONFIG_KSU_KPROBES_KSUD)\
\textern void ksu_handle_newfstat_ret(unsigned int *, struct stat __user **);\
\tksu_handle_newfstat_ret(\&fd, \&statbuf);\
#endif\
#pragma GCC diagnostic pop
        }' fs/stat.c

        sed -i '/^SYSCALL_DEFINE2(fstat64, unsigned long, fd, struct stat64 __user \*, statbuf)/,/^}/ {
            /error = vfs_fstat(fd, \&stat);/a\
\
#pragma GCC diagnostic push\
#pragma GCC diagnostic ignored "-Wdeclaration-after-statement"\
#if defined(CONFIG_KSU) \&\& !defined(CONFIG_KSU_KPROBES_KSUD)\
\textern void ksu_handle_fstat64_ret(unsigned long *, struct stat64 __user **);\
\tksu_handle_fstat64_ret(\&fd, \&statbuf);\
#endif\
#pragma GCC diagnostic pop
        }' fs/stat.c
        ;;

    # ==================== kernel/reboot.c ====================
    kernel/reboot.c)
        sed -i '/^SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,/,/^}/ {
            /int ret = 0;/a\
\
#if defined(CONFIG_KSU) \&\& !defined(CONFIG_KSU_KPROBES_KSUD)\
\textern int ksu_handle_sys_reboot(int, int, unsigned int, void __user **);\
\tksu_handle_sys_reboot(magic1, magic2, cmd, \&arg);\
#endif
        }' kernel/reboot.c
        ;;

    esac
done
