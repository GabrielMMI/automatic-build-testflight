# Automatic Build to Testflight.

![usage](https://img.shields.io/badge/platform-iOS-ffc713.svg)

Este projeto foi feito utilizando a Command Line Tools do Xcode.

### Instalação

1. Clone este projeto na pasta raiz do Caixa+.
2. That`s it.

### Uso

Após instalar este projeto na pasta raiz do seu projeto, abra o terminal no diretório da pasta raiz do Caixa+, use os comando `makefile`:

Gerar a build CaixaMaisDev para o Testflight com incremento da build automático:
```sh
$ make testflight_pf
```

Podendo passar o número da build que será gerado:
```sh
$ make testflight_pf buildPF=${NUMERO_BUILD}
```

Do mesmo modo, é possível gerar a build CaixaMaisEmpresaDev para o Testflight com incremento da build automático:
```sh
$ make testflight_pj
ou
$ make testflight_pj buildPF=${NUMERO_BUILD}
```

Tambem sendo possível gerar as 2 builds de forma sequencial, ao submeter a build PF para a App Store, a build PJ começa a ser gerada, podendo ou não (incremento automático) passar o número da build.

```sh
$ make testeflight_pf_pj
ou
$ make testeflight_pf_pj buildPF=${NUMERO_BUILD_PF} buildPJ=${NUMERO_BUILD_PJ}
```


### Como Funciona

Ao rodar o comando `makefile testflight_pf`, são executados os seguintes comandos:

- `make increment_build_pf buildPF=${NUMERO_BUILD_PF}`-> esse comando executa um script (localizado na pasta `.scripts`) para incrementar a build do projeto automaticamente, podendo passar o número da build ou não.

- `make clean_project_pf`-> esse comando limpa o projeto.

- `make clean_archive_folder_pf`-> esse comando limpa a pasta de archive, sempre mantendo o último archive gerado, limpando a pasta `.archives`.

- `make archive_pf` -> esse comando gera o archive do projeto selecionado na pasta `.archives/buildPF` para PF e `.archives/buildPJ` para PJ

- `make export_ipa_pf` -> esse comando gera o arquivo `.ipa`.

- `make publish_app_pf` -> esse comando envia o arquivo `.ipa` para a App Store, assim iniciando o processamento para o Testflight.
