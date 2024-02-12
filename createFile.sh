#!/bin/bash

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

createFileHpp()
{
	fileHpp="$1.hpp"
	touch ${fileHpp}

	echo "#ifndef ${upperCase}_HPP" > ${fileHpp}
	echo "#define ${upperCase}_HPP" >> ${fileHpp}
	echo "" >> ${fileHpp}
	echo "#include <iostream>" >> ${fileHpp}
	echo "" >> ${fileHpp}
	echo "#define ${default} ${defaultMensage}" >> ${fileHpp}
	echo "#define ${constructor} ${constructorMensage}" >> ${fileHpp}
	echo "#define ${copy} ${copyMensage}" >> ${fileHpp}
	echo "#define ${destructor} ${destructorMensage}" >> ${fileHpp}
	echo "#define ${operator} ${operatorMensage}" >> ${fileHpp}
	echo "" >> ${fileHpp}
	echo "class $1" >> ${fileHpp}
	echo "{" >> ${fileHpp}
	echo "	private:" >> ${fileHpp}
	echo "		//(...)" >> ${fileHpp}
	echo "	public:" >> ${fileHpp}
	echo "		$1(void);" >> ${fileHpp}
	echo "		~$1(void);" >> ${fileHpp}
	echo "};" >> ${fileHpp}
	echo "" >> ${fileHpp}
	echo "#endif" >> ${fileHpp}
}

createFileCpp()
{
	fileCpp="$1.cpp"
	touch ${fileCpp}

	echo '#include "'$1.hpp'"' > ${fileCpp}
	echo "" >> ${fileCpp}
	echo "$1::$1(void)" >> ${fileCpp}
	echo "{" >> ${fileCpp}
	echo "	std::cout << ${default} << std::endl;" >> ${fileCpp}
	echo "}" >> ${fileCpp}
	echo "" >> ${fileCpp}
	echo "$1::~$1(void)" >> ${fileCpp}
	echo "{" >> ${fileCpp}
	echo "	std::cout << ${destructor} << std::endl;" >> ${fileCpp}
	echo "}" >> ${fileCpp}
	echo "" >> ${fileCpp}
}

if [ -f "$1.hpp" ] && [ -f "$1.cpp" ] ; then
	echo "There is already a file with this name: $1.hpp $1.cpp"
elif [ -f "$1.hpp" ] ; then
	echo "There is already a file with this name: $1.hpp"
elif [ -f "$1.cpp" ] ; then
	echo "There is already a file with this name: $1.cpp"
else
	createFileHpp $1
	createFileCpp $1
fi
