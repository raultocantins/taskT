# Task Planner

## 1. Introdução

Task Planner é um aplicativo Flutter desenvolvido para demonstrar as melhores práticas de desenvolvimento móvel. Este projeto inclui exemplos de navegação, gerenciamento de estado e armazenamento local.

## 2. Configuração

### Requisitos

- Flutter: Versão 3.0.5 ou superior, mas inferior a 4.0.0.
- Dart: Versão 3.0.0 ou superior, mas inferior a 4.0.0.
- Android Studio ou VSCode
- Dispositivo Android ou iOS, ou emulador/simulador configurado

### Instalação

Clone o repositório:

```sh
git clone https://github.com/raultocantins/taskT.git
cd task_planner
```

Instale as dependências:

```sh
flutter pub get
```

Execute o aplicativo:

```sh
flutter run
```

## 3. Estrutura do Projeto

A estrutura do projeto segue uma organização modular para facilitar a escalabilidade e manutenção:

```bash
Task Planner/
├── android/
├── ios/
├── lib/
│   ├── src/
│   ├── generated/
│   ├── l10n/
│   ├── src/
│   └── main.dart
├── test/
├── pubspec.yaml
```

`main.dart`: Ponto de entrada do aplicativo.

## 4. Guia de Uso

### Navegação

Exemplo de navegação:

```dart
Navigator.of(context).pushNamed('/nome-da-rota');
```

### Gerenciamento de Estado

Utilizamos o pacote mobx para gerenciamento de estado. Abaixo está um exemplo simples de como configurar o mobx:

```dart
class TagsController = _TagsControllerBase with _$TagsController;

abstract class _TagsControllerBase with Store {
  _TagsControllerBase();

  @observable
  bool? isLoading = false;

  @action
  void changeIsLoading(bool value) {
    isLoading = value;
  }
}
```

### Integração com banco de dados local (sqflite)

## 5. Contribuição

Para contribuir com o Task Planner, siga estas etapas:

1. Faça um fork do repositório.
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`).
3. Commit suas mudanças (`git commit -m 'Adiciona nova feature'`).
4. Faça o push para a branch (`git push origin feature/nova-feature`).
5. Abra um Pull Request.

## 6. Licença

Este projeto está licenciado sob a licença MIT - veja o arquivo LICENSE para mais detalhes.
