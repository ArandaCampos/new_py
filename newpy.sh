#! /bin/bash
#
# newpy.sh
#
# Versão 1.0
#       -r, --readme    Cria um arquivo README.md
#       -t, --pytest    Instala o pytest, cria o __init__ e o arquivo test__.py
#       -x, --docs      Cria a pasta Docs
#       -d, --django    Inicia um projeto Django
#       -n, --name      Define um Nome para o projeto
#       -V, --verbose   Imprime alertas
#       -h, --help      Ajuda
#       -v, --version   Versão atual
#
# Este script seta as primeiras estruturas de um projeto Python

VERSION="$(basename "$0") 1.0"
HEADER="USO: $VERSION

 Este script realiza as primeiras configurações de um projeto Python
"
ARG_TXT="
 OPÇÔES SEM ARGUMENTO
\t -r, --readme \t\tCria um arquivo README.md
\t -t, --pytest \t\tInstala o pytest, cria o __init__ e o arquivo test__.py
\t -x, --docs   \t\tCria a pasta Docs
\t -d, --django \t\tInicia um projeto Django

 OPÇÔES COM ARGUMENTO
\t -n, --name   \t\tDefine um Nome para o projeto"

# Parametros
DOCS=0
README=0
PYTEST=0
DJANGO=0
NAME=0
VERBOSE=0
NEXT=0

# Caso não haja opções
if [ $# -lt 1 ] ; then
    echo -e "É necessário informar uma opção para funcionar\n"
    echo -e "$ARG_TXT"
    exit 1
fi


for i in $* ;
do
    case $i in
        # --Help
        "--help" | "-h" )
            echo -e "$HEADER\n$ARG_TXT"
            exit 0
            ;;
        # --Version
        "--version" | "-v" )
            echo -e $VERSION
            exit 0
            ;;
        # --Readme
        "--readme" | "-r" )
            README=1
            ;;
        # --Pytest
        "--pytest" | "-t" )
            PYTEST=1
            ;;
        # --Django
        "--django" | "-d" )
            DJANGO=1
            ;;
        # --NAMEPROJECT
        "--name" | "-n" )
            echo $i
            NAME=1
            ;;
        # --DOCS
        "--x" | "--docs" )
            DOCS=1
            ;;
        # --Verbose
        "--V" | "--verbose" )
            VERBOSE=1
            ;;
        *)
            # exit 1
            ;;
    esac
done

if [ $NAME -eq 1 ] ; then
    for i in $@ ;
    do
        if [ $NEXT -eq 1 ] ; then
            NAME=$i
            NEXT=0
        fi
        if [[ $i == "-n" ]] ; then
            NEXT=1
        fi
    done
else
    NAME="NEW_PROJECT"
fi

if [ $DJANGO -eq 1 ] ; then
    django-admin startproject $NAME
    # Se foi criado
    if [ $? -eq 0 ] ; then
        if [ $VERBOSE -eq 1 ] ; then
            echo "  -> Projeto Django criado com sucesso"
        fi
    fi
    echo "django" >> $NAME/requirements.txt
else
    mkdir $NAME
fi

# root diretory
cd $NAME
mkdir $NAME

# Created Virtual Machine Python
virtualenv .
source bin/activate
# Se foi criado
if [ $? -eq 0 ] ; then
    if [ $VERBOSE -eq 1 ] ; then
        echo "  -> Ambiente Virtual criado com sucesso"
    fi
fi

# Readme.md
if [ $README -eq 1 ] ; then
    echo "## $NAME" >> README.md
    if [ $VERBOSE -eq 1 ] ; then
        echo "  -> README.md criado com sucesso"
    fi
fi

# DOCS
if [ $DOCS -eq 1 ] ; then
    mkdir docs
    # Se foi criado
    if [ $? -eq 0 ] ; then
        if [ $VERBOSE -eq 1 ] ; then
            echo "  -> Diretório DOCS criado com sucesso"
        fi
    fi
fi

# PyTest
if [ $PYTEST -eq 1 ] ; then
    echo "pytest" >> requirements.txt
    mkdir test
    touch test/__init__.py
    touch test/test_$NAME.py
    # Se foi criado
    if [ $VERBOSE -eq 1 ] ; then
        echo "  -> Test criado com sucesso"
    fi
fi

# Condicional para verificar se requirements.txt existe
[ -s requirements.txt ]
if [ $? -eq 0 ] ; then
    pip install -r requirements.txt
fi

# Git
echo "
bin
lib
__pycache__" >> .gitignore
git init
git add .
git commit -m "setting"

if [ $VERBOSE -eq 1 ] ; then
    echo "  -> Git iniciado com sucesso"
fi


echo "  -> Projeto $NAME criado com sucesso!"
