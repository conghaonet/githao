rem /a/f  是强制删除所有属性的文件
rem /s 可以删除子文件加中的文件
rem /q 是无需确认直接删除
rem 以下语句的作用：删除当前目录中lib及lib下子目录的全部*.g.dart文件。
del /a/f/s lib\*.g.dart

rem flutter packages pub run build_runner clean
flutter packages pub run build_runner build --delete-conflicting-outputs
rem flutter packages pub run build_runner build