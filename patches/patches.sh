#!/bin/bash

PATCH_FILES=(
    fs/exec.c
    fs/open.c
    fs/read_write.c
    fs/stat.c
    drivers/input/input.c
)

check_ksu() {
    local file="$1"
    if grep -q "ksu" "$file"; then
        echo "Warning: $file contains KernelSU"
        return 1
    fi
    return 0
}

patch_exec_c() {
    sed -i '/static int do_execveat_common/i\#ifdef CONFIG_KSU\nextern bool ksu_execveat_hook __read_mostly;\nextern int ksu_handle_execveat(int *fd, struct filename **filename_ptr, void *argv,\n                        void *envp, int *flags);\nextern int ksu_handle_execveat_sucompat(int *fd, struct filename **filename_ptr,\n                                 void *argv, void *envp, int *flags);\n#endif' fs/exec.c

    if grep -q "return __do_execve_file(fd, filename, argv, envp, flags, NULL);" fs/exec.c; then
        local insert_point='/return __do_execve_file(fd, filename, argv, envp, flags, NULL);/i'
    else
        local insert_point='/if (IS_ERR(filename))/i'
    fi

    sed -i "$insert_point"'
        #ifdef CONFIG_KSU
        if (unlikely(ksu_execveat_hook))
                ksu_handle_execveat(&fd, &filename, &argv, &envp, &flags);
        else
                ksu_handle_execveat_sucompat(&fd, &filename, &argv, &envp, &flags);
        #endif' fs/exec.c
}

patch_open_c() {
    if grep -q "long do_faccessat(int dfd, const char __user \*filename, int mode)" fs/open.c; then
        local insert_point='/long do_faccessat(int dfd, const char __user \*filename, int mode)/i'
    else
        local insert_point='/SYSCALL_DEFINE3(faccessat, int, dfd, const char __user \*, filename, int, mode)/i'
    fi

    sed -i "$insert_point"'
#ifdef CONFIG_KSU
extern int ksu_handle_faccessat(int *dfd, const char __user **filename_user, int *mode,
                         int *flags);
#endif' fs/open.c

    sed -i '/if (mode & ~S_IRWXO)/i\
        #ifdef CONFIG_KSU
        ksu_handle_faccessat(&dfd, &filename, &mode, NULL);
        #endif' fs/open.c
}

patch_read_write_c() {
    sed -i '/ssize_t vfs_read(struct file/i\#ifdef CONFIG_KSU\nextern bool ksu_vfs_read_hook __read_mostly;\nextern int ksu_handle_vfs_read(struct file **file_ptr, char __user **buf_ptr,\n                size_t *count_ptr, loff_t **pos);\n#endif' fs/read_write.c

    sed -i '/ssize_t vfs_read(struct file/,/ssize_t ret;/{/ssize_t ret;/a\
        #ifdef CONFIG_KSU
        if (unlikely(ksu_vfs_read_hook))
            ksu_handle_vfs_read(&file, &buf, &count, &pos);
        #endif
    }' fs/read_write.c
}

patch_stat_c() {
    if grep -q "int vfs_statx(int dfd, const char __user \*filename, int flags," fs/stat.c; then
        sed -i '/int vfs_statx(int dfd, const char __user \*filename, int flags,/i\#ifdef CONFIG_KSU\nextern int ksu_handle_stat(int *dfd, const char __user **filename_user, int *flags);\n#endif' fs/stat.c
        sed -i '/unsigned int lookup_flags = LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT;/a\
        #ifdef CONFIG_KSU
        ksu_handle_stat(&dfd, &filename, &flags);
        #endif' fs/stat.c
    else
        sed -i '/int vfs_fstatat(int dfd, const char __user \*filename, struct kstat \*stat,/i\#ifdef CONFIG_KSU\nextern int ksu_handle_stat(int *dfd, const char __user **filename_user, int *flags);\n#endif' fs/stat.c
        sed -i '/if ((flag & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT |/i\
        #ifdef CONFIG_KSU
        ksu_handle_stat(&dfd, &filename, &flag);
        #endif' fs/stat.c
    fi
}

patch_input_c() {
    sed -i '/static void input_handle_event/i\#ifdef CONFIG_KSU\nextern bool ksu_input_hook __read_mostly;\nextern int ksu_handle_input_handle_event(unsigned int *type, unsigned int *code, int *value);\n#endif' drivers/input/input.c

    sed -i '/int disposition = input_get_disposition(dev, type, code, &value);/a\
        #ifdef CONFIG_KSU
        if (unlikely(ksu_input_hook))
                ksu_handle_input_handle_event(&type, &code, &value);
        #endif' drivers/input/input.c
}

for file in "${PATCH_FILES[@]}"; do
    check_ksu "$file" || continue

    case "$file" in
        fs/exec.c)              patch_exec_c ;;
        fs/open.c)              patch_open_c ;;
        fs/read_write.c)        patch_read_write_c ;;
        fs/stat.c)              patch_stat_c ;;
        drivers/input/input.c)  patch_input_c ;;
    esac
done