#!/bin/bash


# Colors codes
greenColor="\033[0;32m"
redColor="\033[0;31m"
defaultColor="\033[1;37m"

createFileHpp()
{
	upperCase=$(echo "$1" | tr '[:lower:]' '[:upper:]')
	default="DEFAULT_CONSTRUCTOR_${upperCase}"
	defaultMensage="\"Default Constructor $1 Called\""
	constructor="CONSTRUCTOR_${upperCase}"
	constructorMensage="\"Constructor $1 Called\""
	copy="COPY_CONSTRUCTOR_${upperCase}"
	copyMensage="\"Copy Constructor $1 Called\""
	destructor="DESTRUCTOR_${upperCase}"
	destructorMensage="\"Destructor $1 Called\""
	operator="OPERATOR_EQUAL_${upperCase}"
	operatorMensage="\"Operator equal $1 Called\""

	fileHpp="$1.hpp"
	touch ${fileHpp}

	fileHppContent="#ifndef ${upperCase}_HPP
#define ${upperCase}_HPP

#include <iostream>

#define ${copy} ${copyMensage}
#define ${destructor} ${destructorMensage}
#define ${operator} ${operatorMensage}

class $1
{
	private:
		//(...)
	public:
		$1(void);
		~$1(void);
};

#endif"
	
	echo "${fileHppContent}" > ${fileHpp}
}

createFileCpp()
{
	upperCase=$(echo "$1" | tr '[:lower:]' '[:upper:]')
	default="DEFAULT_CONSTRUCTOR_${upperCase}"
	destructor="DESTRUCTOR_${upperCase}"

	fileCpp="$1.cpp"
	touch ${fileCpp}

	fileCppContent="#include \"$1.hpp\"

$1::$1(void)
{
	std::cout << ${default} << std::endl;
}

$1::~$1(void)
{
	std::cout << ${destructor}
}
"
	echo "${fileCppContent}" > ${fileCpp}
}

checkOptions()
{
	if [ "$1" = "-a" ]
	then
		echo 0
	elif [ "$1" = "-h" ]
	then
		echo 1
	elif [ "$1" = "-c" ]
	then
		echo 2
	elif [ "$1" = "-m" ]
	then
		echo 3
	else
		echo 4
	fi
}

createMakefile()
{
	DEFAULT_NAME="a.out"
	DEFAULT_CXX="c++"
	DEFAULT_CC="cc"
	DEFAULT_CFLAGS="-Wall -Werror -Wextra"
	DEFAULT_CXXFLAGS="-Wall -Werror -Wextra -std=c++98"
	DEFAULT_RM="rm -rf"

	read -p "Enter program name (press Enter to default name: a.out ): " NAME
	NAME=${NAME:-$DEFAULT_NAME}

	if [ "$1" = "1" ]
	then
		C_PRINCIPAL=$DEFAULT_CXX
		C_FLAGS_PRINCIPAL=$DEFAULT_CXXFLAGS
		TYPE_OF_C="CXX"
		TYPE_OF_FLAG="CXXFLAGS"
		TYPE="cpp"
	else
		C_PRINCIPAL=$DEFAULT_CC
		C_FLAGS_PRINCIPAL=$DEFAULT_CFLAGS
		TYPE_OF_C="CC"
		TYPE_OF_FLAG="CFLAGS"
		TYPE="c"
	fi

	# Build makefile content
	MAKEFILE_CONTENT="# PROGRAM NAME
NAME=$NAME

# PROGRAMMING LANGUAGE
$TYPE_OF_C=$C_PRINCIPAL

# ARQUIVOS
SRCS= main.${TYPE}

OBJS=\$(SRCS:.${TYPE}=.o)

# FLAGS
$TYPE_OF_FLAG=${C_FLAGS_PRINCIPAL}

# COMANDOS
RM=$DEFAULT_RM

all: \$(NAME)

\$(NAME): \$(OBJS)
	\$(${TYPE_OF_C}) \$(${TYPE_OF_FLAG}) \$(OBJS) -o \$(NAME)

clean:
	\$(RM) \$(OBJS)

fclean: clean
	\$(RM) \$(NAME)

re: fclean all

	"
	
	echo "$MAKEFILE_CONTENT" > Makefile
}

main()
{
	num=$(checkOptions $1)
	case $num in
		"0")
			read -p "Write the name of the .cpp and .hpp file
$> " file
			if [ -f "$file.hpp" ] && [ -f "$file.cpp" ] ; then
				echo "${redColor}There is already a file with this name: ${defaultColor}$file.hpp $file.cpp"
			elif [ -f "$file.hpp" ] ; then
				echo "${redColor}There is already a file with this name: ${defaultColor}$file.hpp"
			elif [ -f "$file.cpp" ] ; then
				echo "${redColor}There is already a file with this name: ${defaultColor}$file.cpp"
			else
				createFileHpp $file ; createFileCpp $file
				echo "${defaultColor}$file.cpp${greenColor} and ${defaultColor}$file.hpp ${greenColor}file created successfully!${defaultColor}"
			fi
			;;
		"1")
			read -p "Write the name of the .hpp file
$> " file
			if [ -f "$file.hpp" ] ; then
				echo "${redColor}There is already a file with this name: ${defaultColor}$file.hpp"
			else
				createFileHpp $file
				echo "${defaultColor}$file.hpp ${greenColor}file created successfully!${defaultColor}"
			fi
			;;
		"2")
			read -p "Write the name of the .cpp file
$> " file
			if [ -f "$file.cpp" ] ; then
				echo "${redColor}There is already a file with this name: ${defaultColor}$file.cpp"
			else
				createFileCpp $file
				echo "${defaultColor}$file.cpp ${greenColor}file created successfully!${defaultColor}"
			fi
			;;
		"3")
			read -p "Which type of Makefile? (C is the default type) : 
1 - For Cpp type
2 - For C type
$> " file
			createMakefile $file
			echo "${greenColor}${defaultColor}Makefile${greenColor} created successfully!${defaultColor}"
			;;
		*)
			echo "invalid option"
			;;
	esac
}

main $1
