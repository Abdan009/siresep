part of 'widgets.dart';

class CardMenuWidget extends StatelessWidget {
  final ImageProvider<Object> image;
  final Function onTap;
  CardMenuWidget({@required this.image, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        height: Get.width * 0.6,
        width: Get.width * 0.6,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(1.0, 1.0),
              blurRadius: 2.0,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: Get.width * 0.4,
                width: Get.width * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(image: image),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
