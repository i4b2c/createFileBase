# Create File Base
This script automates the creation of C++ header (.hpp) and source (.cpp) files based on user input. It can also generate a basic Makefile for the project.

Features:

    Creates header and source files with basic class structure and constructors/destructors.
    Supports options for creating files with custom names.
    Generates a Makefile with basic build instructions.

Usage:

    Clone the repository and navigate to the script directory.

    Run the script with the desired options:
        ./createFile.sh -a: Create both header and source files.
        ./createFile.sh -h: Create header file only.
        ./createFile.sh -c: Create source file only.
        ./createFile.sh -m: Create Makefile.

    Provide the name of the file to be created when prompted.

    The script will generate the files in the current directory.

Contributing:

If you find this script useful, please consider contributing to its development. You can report bugs, suggest improvements, or submit pull requests.
