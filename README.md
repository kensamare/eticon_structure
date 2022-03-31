<img src="https://user-images.githubusercontent.com/36012868/130392291-52b82b9b-fd52-424b-ba5a-b7630e9cf343.png" data-canonical-src="https://user-images.githubusercontent.com/36012868/130392291-52b82b9b-fd52-424b-ba5a-b7630e9cf343.png" height="200" width=400/>

[![Russian](https://img.shields.io/badge/Language-Russian-blue?style=plastic)](https://github.com/kensamare/eticon_structure/blob/master/doc/README_RU.md)

# ETICON Struct

A package specifically for creating a project structure and individual elements.

## Installation into a project

Add eticon_struct: 1.0.0 to dev_dependencies pubspec.yaml as shown below:
```dart
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^1.0.0
  eticon_struct: ^1.0.0
```

## Project structure

The project structure looks like this:

```bash
├── 📁 assets
│   ├── 📁 fonts
│   │   └── 📄 empty.ttf
│   ├── 📁 icons
│   │   └── 🖼 empty.png
│   └── 📁 images
│       └── 🖼 empty.png
└── 📁 lib
    ├── 📄 main.dart
    ├── 📁 models
    │   └── 📄 about_models.txt
    ├── 📁 project_utils
    │   ├── 📄 pj_colors.dart
    │   ├── 📄 pj_icons.dart
    │   └── 📄 pj_utils.dart
    ├── 📁 project_widgets
    │   ├── 📄 pj_appbar.dart
    │   ├── 📄 pj_text.dart
    │   └── 📄 pj_widgets.dart
    └── 📁 screens
        └── 📁 main_screen
            ├── 📁 cubit
            │   ├── 📄 cb_main_screen.dart
            │   └── 📄 st_main_screen.dart
            ├── 📄 main_screen.dart
            └── 📄 main_screen_provider.dart
  ```
## Creating a project structure

In order to create the structure described above, after a new flutter project has been created,
execute command in terminal:
```bash
flutter pub run eticon_struct:create
```
Basically created:
1. Utilities of the project.
2. Global widgets.
3. Assets.
4. Folder for models.
5. Basic Stateless screen with a cubit connected to it for managing states.

A set of basic libraries is also added to the project:
1. [eticon_api](https://pub.dev/packages/eticon_api)
2. [get](https://pub.dev/packages/get)
3. [flutter_screenutil](https://pub.dev/packages/flutter_screenutil)
4. [flutter_bloc](https://pub.dev/packages/flutter_bloc)
5. [flutter_svg](https://pub.dev/packages/flutter_svg)
6. [get_storage](https://pub.dev/packages/get_storage)
7. [intl](https://pub.dev/packages/intl)
8. [sentry_flutter](https://pub.dev/packages/sentry_flutter)


If you want to create a basic screen without a qubit, then use the special flag --without-cubit:
```bash
flutter pub run eticon_struct:create --without-cubit
```

If you want to create a basic screen as a Stateful Widget, then use the special flag --stf
```bash
flutter pub run eticon_struct:create --stf
```

You can also use these two flags at the same time:
```bash
flutter pub run eticon_struct:create --stf --without-cubit
```
## Creating new screens in the project

You can create new screens in a project using a special command:
```bash
flutter pub run eticon_struct:screen --name=<file_name>
```

Example:
```bash
flutter pub run eticon_struct:screen --name=new
```

After executing this command, a new screen will be added to the project: new_screen.

**NOTE!!!**
> The name is specified in the same way as files are named in Dart, that is, using _ as a word separator.
> Do not add "screen" at the end, it happens automatically when the screen is created!

Similar to creating the project structure, you can use the flags: --stf (to create a screen as a Stateful Widget)
and --without-cubit (to create the screen without cubit).

Example:
```bash
flutter pub run eticon_struct:screen --name=order_schedule --stf --without-cubit
```
## Creating new Cubits not tied to a specific screen

You can create new cubits not tied to a specific screen:
```bash
flutter pub run eticon_struct:cubit --name=<file_name> --path=<your_path>
```

Example:
```bash
flutter pub run eticon_struct:cubit --name=my_cubit --path=project_utils
```

After executing this command, a new cubit will be added to the project_utils directory: my_cubit.

**NOTE!!!**
> The name is specified in the same way as files are named in Dart, that is, using _ as a word separator.
> path is the directory where the new cubit will be created, keep in mind that path is substituted into the following line:
> lib / <path>. Thus, if you specify --path = project_widgets, then the path to cubit creation will be as follows:
> lib / project_widgets.

## Creating Singletons
You can create singleton using the command:
```bash
flutter pub run eticon_struct:singleton --name=<file_name>
```

Example:
```bash
flutter pub run eticon_struct:singleton --name=my_settings
```

After executing this command, a new directory, singletons, will appear in project_utils, which will contain
all singleton you created.

Result of the created singleton:
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

This class will be automatically added to project_utils.dart.

## Contacts
If you still have questions or have any suggestions to improve this package.
You can contact us by mail: <main@eticon.ru>

