# Automatic Build to Testflight.

![usage](https://img.shields.io/badge/platform-iOS-ffc713.svg)

Este projeto foi feito utilizando a Command Line Tools do Xcode.

### Instalação

Obs.1: Todos os paths tem como referencia o diretório do arquivo `Makefile` como "raiz".

1. Clone este projeto em uma pasta aleatória.
2. Execute o arquivo `install_files`.
3. Informe o path onde deseja instalar os arquivos.
4. Abra o arquivo `Makefile` que foi instalado no path informado no passo anterior.
5. Coloque o arquivo `exportOptions.plist` dentro da pasta do projeto, junto com o `.workspace` e faça as alterações necessárias **caso seu projeto ainda não tenha esse arquivo**.
6. Altere os seguintes campos:
```sh
PLIST = #{Path até a plist do seu projeto. Ex: app/projeto/info.plist}
SCHEME = #{Nome do Scheme do seu projeto}

PROJECT_PATH = #{Path até chegar no arquivo .workspace. Ex: app/projeto}
PROJECT_NAME = #{Nome do projeto que dará o nome do .workspace. Ex: "NomeProjeto".workspace}
PROJECT_DISPLAY_NAME = #{Nome do projeto localizado no campo "Display Name" no Target do projeto}

EXPORT_OPTIONS_PLIST = #{Nome da plist de opções de exportação. Ex: exportOptions.plist}

ARCHIVE_PATH = .archives #{Nome da pasta onde será salvo os arquivos gerados .xcarchive e .ipa. Por default é usado a pasta invisível ".archives"}
ARCHIVE_SCHEME_FOLDER = #{Nome da pasta localizada dentro ARCHIVE_PATH para organização da pasta .archives}

USERNAME = #{Apple Id da conta que será enviado o archive. Ex: email@email.com}
PASSWORD = #{Senha específica do app gerada no site https://appleid.apple.com/ . Ex: xxxx-xxxx-xxxx-xxxx}
```
7. That's it.

### Uso

Após instalar este projeto na pasta raiz do seu projeto, abra o terminal no path que foi passado no arquivo `install_files`, sempre estando no mesmo diretório do arquivo `Makefile`, use o comando `make`:

Para gerar a build para o Testflight com incremento da build automático:
```sh
$ make testflight
```

Pode-se passar o número da build que será gerado:
```sh
$ make testflight build=#{NUMERO_BUILD}
Exemplo:
$ make testflight build=12
```


### Como Funciona

Ao rodar o comando `make testflight`, são executados os seguintes comandos:

- `make increment_build build=${NUMERO_BUILD}`-> esse comando executa um script (localizado na pasta `.scripts`) para incrementar a build do projeto automaticamente, podendo passar o número da build ou não.

- `make clean_project`-> esse comando limpa o projeto.

- `make clean_archive_folder`-> esse comando limpa a pasta de archive (`.archives` ou nos novos diretorios informados no campo `ARCHIVE_PATH`).

- `make archive` -> esse comando gera o archive (`.xcarchive`) do projeto selecionado na pasta `ARCHIVE_PATH/ARCHIVE_SCHEME_FOLDER`

- `make export_ipa` -> esse comando gera o arquivo `.ipa` na pasta `ARCHIVE_PATH/ARCHIVE_SCHEME_FOLDER`.

- `make publish_app` -> esse comando envia o arquivo `.ipa` para a App Store, assim iniciando o processamento para o Testflight.

Obs.2: cada comando pode ser executado separadamente.
