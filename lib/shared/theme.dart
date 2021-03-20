part of 'shared.dart';

const double defaultMargin = 24;

Color mainColor = Colors.deepPurple[900];
Color accentColor1 = Color(0xFFEFEEEE);
Color accentColor2 = Color(0xFFADADAD);
Color accentColor3 = Color(0xFFFBD460);
Color accentColor4 = Color(0xFFFF8000);
const Color darkerText = Color(0xFF17262A);
const Color darkText = Color(0xFF253840);
const Color lightText = Color(0xFF4A6572);

TextStyle whiteTextFont = GoogleFonts.raleway()
    .copyWith(color: Colors.white, fontWeight: FontWeight.w500);
TextStyle blackTextFont = GoogleFonts.raleway()
    .copyWith(color: Colors.black, fontWeight: FontWeight.w500);
TextStyle blueTextFont = GoogleFonts.raleway()
    .copyWith(color: mainColor, fontWeight: FontWeight.w500);
TextStyle greyTextFont = GoogleFonts.raleway()
    .copyWith(color: accentColor2, fontWeight: FontWeight.w500);

TextStyle whiteNumberFont =
    GoogleFonts.openSans().copyWith(color: Colors.white);
TextStyle blackNumberFont =
    GoogleFonts.openSans().copyWith(color: Colors.black);

String fontName = 'Roboto';

TextTheme textTheme = TextTheme(
  headline4: fontDisplay1,
  headline5: fontHeadline,
  headline6: fontTitle,
  subtitle2: fontSubtitle,
  bodyText2: fontBody2,
  bodyText1: fontBody1,
  caption: fontCaption,
);

TextStyle fontDisplay1 = TextStyle(
  fontFamily: fontName,
  fontWeight: FontWeight.bold,
  fontSize: 36,
  letterSpacing: 0.4,
  height: 0.9,
  color: darkerText,
);

TextStyle fontHeadline = TextStyle(
  fontFamily: fontName,
  fontWeight: FontWeight.bold,
  fontSize: 24,
  letterSpacing: 0.27,
  color: darkerText,
);

TextStyle fontTitle = TextStyle(
  fontFamily: fontName,
  fontWeight: FontWeight.bold,
  fontSize: 16,
  letterSpacing: 0.18,
  color: darkerText,
);

TextStyle fontSubtitle = TextStyle(
  fontFamily: fontName,
  fontWeight: FontWeight.w400,
  fontSize: 14,
  letterSpacing: -0.04,
  color: darkText,
);

TextStyle fontBody2 = TextStyle(
  fontFamily: fontName,
  fontWeight: FontWeight.w400,
  fontSize: 14,
  letterSpacing: 0.2,
  color: darkText,
);

TextStyle fontBody1 = TextStyle(
  fontFamily: fontName,
  fontWeight: FontWeight.w400,
  fontSize: 16,
  letterSpacing: -0.05,
  color: darkText,
);

TextStyle fontCaption = TextStyle(
  fontFamily: fontName,
  fontWeight: FontWeight.w400,
  fontSize: 12,
  letterSpacing: 0.2,
  color: lightText, // was lightText
);
