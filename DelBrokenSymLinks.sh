# This command delete broken symbolic links on current directory
sudo find -L $pwd -maxdepth 1 -type l -delete