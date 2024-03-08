// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

String diffBetweenDate(bool inprogress, DateTime date1, DateTime date2) {
  var response = inprogress ? "Depuis " : "Il y a ";
  var op = date2.difference(date1).inSeconds;
  var suffix = "s";
  if (op > 59) {
    op = date2.difference(date1).inMinutes;
    suffix = "min";
    if (op > 59) {
      op = date2.difference(date1).inHours;
      suffix = "h";
      if (op > 23) {
        op = date2.difference(date1).inDays;
        suffix = "j";
      }
    }
  }
  response += "$op $suffix";

  return response;
}
