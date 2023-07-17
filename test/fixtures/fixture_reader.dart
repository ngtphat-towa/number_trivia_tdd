import 'dart:io';

String fixture(String name) => File('test/fixtures/$name').readAsStringSync();
// String fixture(String name) {
//   var dir = Directory.current.path;
//   dir = dir.replaceAll('\\', '/');
//   if (dir.endsWith('/test')) {
//     dir = dir.replaceAll('/test', '');
//   }
//   return File('$dir/test/fixtures/$name').readAsStringSync();
// }
