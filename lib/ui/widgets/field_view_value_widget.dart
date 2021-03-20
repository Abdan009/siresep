part of 'widgets.dart';

class FieldViewValueWidget extends StatelessWidget {
  final String title;
  final Widget body;
  final Function onTap;
  FieldViewValueWidget({@required this.title, @required this.body, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: accentColor2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Text(
                    title + "  :  ",
                    style: blackTextFont.copyWith(fontWeight: FontWeight.bold),
                  ),
                  body,
                ],
              ),
            ),
            (onTap != null)
                ? GestureDetector(
                    onTap: onTap ?? () {},
                    child: Text("Edit", style: blueTextFont),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
