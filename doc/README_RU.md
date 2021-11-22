<img src="https://user-images.githubusercontent.com/36012868/130392291-52b82b9b-fd52-424b-ba5a-b7630e9cf343.png" data-canonical-src="https://user-images.githubusercontent.com/36012868/130392291-52b82b9b-fd52-424b-ba5a-b7630e9cf343.png" height="200" width=400/>

[![English](https://img.shields.io/badge/Language-English-blue?style=plastic)](https://github.com/kensamare/eticon_structure#readme)

# ETICON Struct

Пакет специально разработанный для создание базовой проектной структуры и отдельных ее эелементов.

## Установка в проект

Добавьте eticon_struct: 1.0.0 в dev_dependencies pubspec.yaml как показано ниже:
```dart
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^1.0.0
  eticon_struct: ^1.0.0
```

## Структура проекта

Структура проекта выглядит следующим образом:

```bash
├── 📁 assets
│   ├── 📁 fonts
│   │   └── 📄 empty.ttf
│   ├── 📁 icon
│   │   └── 🖼 empty.png
│   └── 📁 image
│       └── 🖼 empty.png
└── 📁 lib
    ├── 📄 main.dart
    ├── 📁 models
    │   └── 📄 about_models.txt
    ├── 📁 project_utils
    │   ├── 📄 project_colors.dart
    │   ├── 📄 project_icons.dart
    │   └── 📄 project_utils.dart
    ├── 📁 project_widgets
    │   ├── 📄 project_appbar.dart
    │   ├── 📄 project_text.dart
    │   └── 📄 project_widgets.dart
    └── 📁 screens
        └── 📁 main_screen
            ├── 📁 cubit
            │   ├── 📄 cb_main_screen.dart
            │   └── 📄 st_main_screen.dart
            ├── 📄 main_screen.dart
            └── 📄 main_screen_provider.dart
  ```
## Создание структуры проекта

Для того, чтобы создать структуру описанную выше необходимо после того, как создан новый flutter проект, 
выполнить команду в терминале:
```bash
flutter pub run eticon_struct:create
```
Базово создаются:
1. Утилиты проекта.
2. Глобальные виджеты.
3. Ассеты.
4. Папка для моделей.
5. Базовый Stateless экран с подключенным к нему cubit-ом для управлением состояниями.

Также в проект добавляется набор базовых библиотек:
1. [eticon_api](https://pub.dev/packages/eticon_api)
2. [get](https://pub.dev/packages/get)
3. [flutter_screenutil](https://pub.dev/packages/flutter_screenutil)
4. [flutter_bloc](https://pub.dev/packages/flutter_bloc)
5. [flutter_svg](https://pub.dev/packages/flutter_svg)
6. [get_storage](https://pub.dev/packages/get_storage)
7. [intl](https://pub.dev/packages/intl)
8. [sentry_flutter](https://pub.dev/packages/sentry_flutter)


Если же вы хотите создать базовый экран без кубита, тогда используйте специальный флаг --without-cubit:
```bash
flutter pub run eticon_struct:create --without-cubit
```

Если же вы хотите создать базовый экран как Stateful Widget, тогда используйте специальный флаг --stf
```bash
flutter pub run eticon_struct:create --stf
```

Вы также можете использовать два этих флага одновременно:
```bash
flutter pub run eticon_struct:create --stf --without-cubit
```
## Создание новых экранов в проекте

Вы можете создавать новые экраны в проекте используя специальную команду:
```bash
flutter pub run eticon_struct:screen --name=<file_name>
```

Пример:
```bash
flutter pub run eticon_struct:screen --name=new
```

После выполнения данной команды в проекте добавитьнся новый экран: new_screen.

**ОБРАТИТЕ ВНИМАНИЕ!!!**
> Имя указывется аналогично тому, как именуются файлы в Dart, т.е используя _ как разделитель слов.
> Не следует добавлть приписку "screen" в конце, это происходит автоматически при создании экрана!

Аналогично созданию структуры проекта вы можете использовать флаги: --stf(для того чтобы создать экран как Stateful Widget)
и --without-cubit(для того чтобы экран был создан без cubit-а).

Пример:
```bash
flutter pub run eticon_struct:screen --name=order_schedule --stf --without-cubit
```
## Создание новых Cubit-ов не привязанных к конкретному экрану

Вы можете создавать новые cubit-ы не привязанные к конкретному экрану:
```bash
flutter pub run eticon_struct:cubit --name=<file_name> --path=<your_path>
```

Пример:
```bash
flutter pub run eticon_struct:cubit --name=my_cubit --path=project_utils
```

После выполнения данной команды в директории project_utils добавиться новый cubit: my_cubit.

**ОБРАТИТЕ ВНИМАНИЕ!!!**
> Имя указывется аналогично тому, как именуются файлы в Dart, т.е используя _ как разделитель слов.
> path - это директория в которой будет создан новый cubit, учитывайте, что path подставляется в следующую строку:
> lib/<path>. Таким образом если вы пропишете --path=project_widgets, то путь до создания cubit будет следующим:
> lib/project_widgets.

## Создание Singleton-ов
Вы можете создавать singleton-ы используя команду:
```bash
flutter pub run eticon_struct:singleton --name=<file_name>
```

Пример:
```bash
flutter pub run eticon_struct:singleton --name=my_settings
```
**ОБРАТИТЕ ВНИМАНИЕ!!!**
> Имя указывется аналогично тому, как именуются файлы в Dart, т.е используя _ как разделитель слов.
  
После выполнения данной команды в project_utils появится новая директория singletons в которой будут содержатся
все созданные вами singleton-ы.

Результат созданного singleton:
```dart
class SgMySettings {
  SgMySettings._();

  static SgMySettings instance = SgMySettings._();
  
  static int cnt = 0; //some variables 
  
  //Some Method
  void inc(){
    cnt++;
  }
}
```

Данный класс будет автоматически добавлен в project_utils.dart.

## Контакты
Если у вас все еще остались вопросы или есть какие-либо предложения, чтобы улучшить данный пакет.
Вы можете связаться с нами по почте: <main@eticon.ru>
