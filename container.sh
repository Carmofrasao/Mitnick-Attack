#!/bin/bash

# SCRIPT TEM DOIS PARAMETROS

# $1 -> NOME
# $2 -> IP

if [ $# -eq 2 ]; then
    echo "#!/bin/bash"
    echo "adduser usuario"
    echo "passwd usuario < echo '123'"
    echo "echo -e '$1\t$2\n$(cat /etc/hosts)' > output.txt"
else
    echo "Please provide exactly 2 parameters."
fi