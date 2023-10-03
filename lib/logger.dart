import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

Logger get logger => Log.instance;

class Log extends Logger {
  Log._() : super(printer: Printer());
  static final instance = Log._();
}

/// Class for formatting log outputs
class Printer extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    var color = PrettyPrinter.defaultLevelColors[event.level]!;
    var message = event.message.toString();
    var time = DateFormat('yyyy-MM-dd H:m:s').format(event.time);
    var level = event.level.name;

    // match all characters until the last space
    var regex = RegExp(r'.+\s');

    // split at the line breaks, take the 5th line and take the opposite of the
    // regex to get the class name.
    var className =
        StackTrace.current.toString().split('\n')[3].split(regex)[1];

    return [color('[$level] [$time] $className: $message')];
  }
}
