part of 'extensions.dart';

extension DateTimeExtension on DateTime {
  String get dateAndTime =>
      "${this.shortdayName}, ${this.day} ${this.shortmounthName} ${this.year}  (" +
      "${(this.hour < 10) ? 0 : ""}" +
      "${this.hour}:" +
      "${(this.minute <= 10) ? 0 : ""}" +
      "${this.minute})";
  String get dateAndTimeNoMinute =>
      "${this.shortdayName}, ${this.day} ${this.shortmounthName} ${this.year}";

  String get dateAndTimeLahir =>
      "${this.shortdayName}, ${this.day} ${this.shortmounthName} ${this.year} ";
  String get dateAndTimeNumber => "${this.day}/${this.month}/${this.year}";
  String get clockTime =>
      "${(this.hour < 10) ? 0 : ""}" +
      "${this.hour} : " +
      "${(this.minute <= 10) ? 0 : ""}" +
      "${this.minute}";
  String get shortmounthName {
    switch (this.month) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return "Mei";
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        return 'Minggu';
    }
  }

  String get shortdayName {
    switch (this.weekday) {
      case 1:
        return 'Senin';
      case 2:
        return 'Selasa';
      case 3:
        return 'Rabu';
      case 4:
        return 'Kamis';
      case 5:
        return "jum'at";
      case 6:
        return 'Sabtu';
      default:
        return 'Minggu';
    }
  }
}

extension TimeExtension on TimeOfDay {
  String get timeToString =>
      "${(this.hour < 10) ? 0 : ""}" +
      "${this.hour} : " +
      "${(this.minute <= 10) ? 0 : ""}" +
      "${this.minute}";
}
