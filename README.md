## New Py 

![Badge de licença](http://img.shields.io/static/v1?label=LICENÇA&message=GNU&color=sucess&style=for-the-badge)   ![Badge em Desenvolvimento](http://img.shields.io/static/v1?label=STATUS&message=CONCLUÍDO&color=sucess&style=for-the-badge)   ![Badge versionamento](http://img.shields.io/static/v1?label=VERSAO&message=1.0&color=sucess&style=for-the-badge)

### Sobre

&emsp;`new_py` executa os primeiros passos para um projeto Python ( instalações de libs, ambiente virtual, criação de pastas, requirements.txt ,README.md e git ) 

### Pré-requisitos

  - Bash  
  
### Instalação
  
    # Clone o repositório
    >> mkdir newpy
    >> git clone https://github.com/ArandaCampos/new_py.git newpy/

    # Renomear, torná-lo executável, e movê-lo para pasta bin do sistema (Ubuntu)
    >> cd newpy/
    >> cp new_py.sh newpy && chmod +x newpy && sudo mv newpy /usr/bin/
    
    # Rode o código
    >> newpy --version
    newpy 1.0
  
### Tecnologias empregadas
  - Bash
