part of 'widgets.dart';

class CardCustomWidget extends StatelessWidget {
  final Function onTap;
  final Widget leading;
  final Widget trailing;
  final String title;
  final Widget subTitle;
  final bool isThreeLine;
  final Color color;
  final EdgeInsets margin;
  CardCustomWidget(
      {this.onTap,
      this.leading,
      this.trailing,
      this.title,
      this.subTitle,
      this.isThreeLine,
      this.color,
      this.margin});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: defaultMargin),
      child: GestureDetector(
        onTap: (onTap == null) ? () {} : onTap,
        child: Container(
          width: Get.width,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                offset: Offset(0.0, 1.0),
                blurRadius: 2.0,
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: leading ?? null,
            title: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: trailing ?? null,
            subtitle: subTitle ?? null,
            isThreeLine: isThreeLine ?? false,
          ),
        ),
      ),
    );
  }
}
