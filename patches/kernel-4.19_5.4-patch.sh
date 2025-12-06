#!/bin/bash


patch_files=(
    drivers/input/input.c
    fs/exec.c
    fs/open.c
    fs/read_write.c
    fs/stat.c
    kernel/reboot.c
)

for i in "${patch_files[@]}"; do

    if grep -q "ksu" "$i"; then
        echo "Warning: $i contains KernelSU"
        continue
    fi

    case $i in

    # drivers/input/ changes
    ## input.c
    drivers/input/input.c)
        sed -i '/static void input_handle_event/i\#ifdef CONFIG_KSU\nextern bool ksu_input_hook __read_mostly;\nextern int ksu_handle_input_handle_event(unsigned int *type, unsigned int *code, int *value);\n#endif' drivers/input/input.c
        sed -i '/int disposition = input_get_disposition(dev, type, code, &value);/a\ \n#ifdef CONFIG_KSU\n\tif (unlikely(ksu_input_hook))\n\t\tksu_handle_input_handle_event(&type, &code, &value);\n#endif' drivers/input/input.c
        ;;

    # fs/ changes
    ## exec.c
    fs/exec.c)
        sed -i '/static int do_execveat_common/i\#ifdef CONFIG_KSU\nextern bool ksu_execveat_hook __read_mostly;\nextern int ksu_handle_execveat(int *fd, struct filename **filename_ptr, void *argv,\n\t\t\t\t\tvoid *envp, int *flags);\nextern int ksu_handle_execveat_sucompat(int *fd, struct filename **filename_ptr,\n\t\t\t\t\t\t void *argv, void *envp, int *flags);\n#endif' fs/exec.c
        sed -i '/return __do_execve_file(fd, filename, argv, envp, flags, NULL);/i\ \n#ifdef CONFIG_KSU\n\tif (unlikely(ksu_execveat_hook))\n\t\tksu_handle_execveat(&fd, &filename, &argv, &envp, &flags);\n\telse\n\t\tksu_handle_execveat_sucompat(&fd, &filename, &argv, &envp, &flags);\n#endif' fs/exec.c
        ;;

    ## open.c
    fs/open.c)
        sed -i '/long do_faccessat(int dfd, const char __user \*filename, int mode)/i\#ifdef CONFIG_KSU\nextern int ksu_handle_faccessat(int *dfd, const char __user **filename_user, int *mode,\n\t\t\t\t\tint *flags);\n#endif' fs/open.c
        sed -i '/if (mode & ~S_IRWXO)/i\ \n#ifdef CONFIG_KSU\n\tksu_handle_faccessat(&dfd, &filename, &mode, NULL);\n#endif' fs/open.c
        ;;

    ## read_write.c
    fs/read_write.c)
        sed -i '/ssize_t vfs_read(struct file/i\#ifdef CONFIG_KSU\nextern bool ksu_vfs_read_hook __read_mostly;\nextern int ksu_handle_vfs_read(struct file **file_ptr, char __user **buf_ptr,\n\t\t\t\t\t size_t *count_ptr, loff_t **pos);\n#endif' fs/read_write.c
        sed -i '/ssize_t vfs_read(struct file/,/ssize_t ret;/{/ssize_t ret;/a\
        #ifdef CONFIG_KSU\
        if (unlikely(ksu_vfs_read_hook))\
            ksu_handle_vfs_read(&file, &buf, &count, &pos);\
        #endif
        }' fs/read_write.c
        ;;

    ## stat.c
    fs/stat.c)
        sed -i '/int vfs_statx(int dfd, const char __user \*filename, int flags,/i\#ifdef CONFIG_KSU\nextern int ksu_handle_stat(int *dfd, const char __user **filename_user, int *flags);\n#endif' fs/stat.c
        sed -i '/unsigned int lookup_flags = LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT;/a\ \n#ifdef CONFIG_KSU\n\tksu_handle_stat(&dfd, &filename, &flags);\n#endif' fs/stat.c
        ;;

    # kernel/ changes
    ## reboot.c
    kernel/reboot.c)
        sed -i '/SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,/i\#ifdef CONFIG_KSU\nextern int ksu_handle_sys_reboot(int magic1, int magic2, unsigned int cmd, void __user **arg);\n#endif' kernel/reboot.c
        sed -i '/int ret = 0;/a\ \n#ifdef CONFIG_KSU\n\tksu_handle_sys_reboot(magic1, magic2, cmd, &arg);\n#endif' kernel/reboot.c
        ;;

    esac

done
