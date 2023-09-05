import 'package:logger/logger.dart';

import 'package:logger/logger.dart';

Logger get logger => Log.instance;

class Log extends Logger {
  Log._() : super(printer: Printer());
  static final instance = Log._();
}

class Printer extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    var color = PrettyPrinter.defaultLevelColors[event.level]!;
    var message = event.message.toString();
    var time = event.time.toString();

    // match all characters until the last space
    var regex = RegExp(r'.+\s');
    
    // split at the line breaks, take the 5th line and take the opposite of the
    // regex to get the class name.
    var className = StackTrace.current.toString().split('\n')[4].split(regex)[1];

    return [color('$time $className: $message')];
  }
}
