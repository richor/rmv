Usage: replace the command rm of MacOS to be recycle

To install:
    1. change the  "install.sh" and "rmv" to be executable.
        sudo chmod 744 ./install.sh rmv
    2. then just type:
        ./install.sh
this script will do the following two things:
    a. copy rmv to a user target directory
    b. alias the original command rm to require confirmation
