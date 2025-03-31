#!/bin/bash

# fs/exec.c
sed -i '/^static int do_execveat_common(int fd, struct filename \*filename/ i\#ifdef CONFIG_KSU\nextern bool ksu_execveat_hook __read_mostly;\nextern int ksu_handle_execveat(int *fd, struct filename **filename_ptr, void *argv,\n\t\tvoid *envp, int *flags);\nextern int ksu_handle_execveat_sucompat(int *fd, struct filename **filename_ptr,\n\t\tvoid *argv, void *envp, int *flags);\n#endif' fs/exec.c
sed -i '/return __do_execve_file(fd, filename, argv, envp, flags, NULL);/ i\#ifdef CONFIG_KSU\n\tif (unlikely(ksu_execveat_hook))\n\t\tksu_handle_execveat(&fd, &filename, &argv, &envp, &flags);\n\telse\n\t\tksu_handle_execveat_sucompat(&fd, &filename, &argv, &envp, &flags);\n#endif' fs/exec.c

# fs/open.c
sed -i '/long do_faccessat(int dfd, const char __user \*filename, int mode)/i\#ifdef CONFIG_KSU \nextern int ksu_handle_faccessat(int *dfd, const char __user **filename_user, int *mode,\n\t\t\t\tint *flags);\n#endif' fs/open.c
sed -i '/int res;/ { N; /unsigned int lookup_flags = LOOKUP_FOLLOW;/a\#ifdef CONFIG_KSU\n\tksu_handle_faccessat(&dfd, &filename, &mode, NULL);\n#endif
}' fs/open.c

# fs/read_write.c
sed -i '/ssize_t vfs_read(struct file \*file, char __user \*buf, size_t count, loff_t \*pos)/i\#ifdef CONFIG_KSU \nextern bool ksu_vfs_read_hook __read_mostly;\nextern int ksu_handle_vfs_read(struct file \*\*file_ptr, char __user \*\*buf_ptr, \n\t\t\tsize_t \*count_ptr, loff_t \*\*pos);\n#endif' fs/read_write.c
sed -i '/ssize_t vfs_read(struct file \*file, char __user \*buf, size_t count, loff_t \*pos)/ { N; /{/ { N; /ssize_t ret;/a\#ifdef CONFIG_KSU\n\tif (unlikely(ksu_vfs_read_hook))\n\t\tksu_handle_vfs_read(&file, &buf, &count, &pos);\n#endif
}}' fs/read_write.c

# fs/stat.c
sed -i '/EXPORT_SYMBOL(vfs_statx_fd);/a \\n#ifdef CONFIG_KSU\nextern int ksu_handle_stat(int *dfd, const char __user **filename_user, int *flags);\n#endif' fs/stat.c
sed -i '/unsigned int lookup_flags = LOOKUP_FOLLOW \| LOOKUP_AUTOMOUNT;/a \#ifdef CONFIG_KSU\n\tksu_handle_stat(&dfd, &filename, &flags);\n#endif' fs/stat.c

# drivers/input/input.c
sed -i '/static void input_handle_event(struct input_dev \*dev,/i\#ifdef CONFIG_KSU\nextern bool ksu_input_hook __read_mostly;\nextern int ksu_handle_input_handle_event(unsigned int *type, unsigned int *code, int *value);\n#endif\n' drivers/input/input.c
sed -i '/if (disposition != INPUT_IGNORE_EVENT && type != EV_SYN)/i\#ifdef CONFIG_KSU\n\tif (unlikely(ksu_input_hook))\n\t\tksu_handle_input_handle_event(\&type, \&code, \&value);\n#endif\n' drivers/input/input.c
