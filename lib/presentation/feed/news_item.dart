import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:news/models/news_model.dart';

class NewsItem extends StatelessWidget {
  final NewsResponse item;
  const NewsItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: _buildNewsItem(item, context),
    );
  }
}

Widget _buildNewsItem(NewsResponse item, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.of(context).pushNamed(
        '/newsDetails',
        arguments: item.link
        );
    },
    child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(143, 255, 255, 255),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: SizedBox(
            height: 110,
            width: double.infinity,
            child: Row(
              children: [
                _buildNewsItemImage(item.image),
                Expanded(
                  child: _buildNewsItemContent(
                    item.title ?? "",
                    item.publishDate ?? "",
                  ),
                ),
              ],
            ),
          ),
        ),
  );
}

Widget _buildNewsItemContent(String title, String date) {
  DateTime newsDate = DateTime.parse(date);
  String formattedDate = DateFormat.yMMMMd().format(newsDate);
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        Text(
          formattedDate,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(),
        ),
      ],
    ),
  );
}

Widget _buildNewsItemImage(String? image) {
  return SizedBox(
    height: double.infinity,
    width: 130,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image(
          fit: BoxFit.cover,
          image: NetworkImage(image ?? ""),
          errorBuilder: (context, error, stackTrace) =>
              SvgPicture.asset(
                'assets/images/news_default.svg',
                height: 40,
                ),
        ),
      ),
    ),
  );
}
