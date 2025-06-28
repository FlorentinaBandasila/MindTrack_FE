import 'package:flutter/material.dart';
import 'package:mindtrack/constant/constant.dart';
import 'package:mindtrack/endpoint/getarticle.dart';
import 'package:mindtrack/models/articlemodel.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  bool _isLoading = true;
  List<ArticleModel> _articles = [];

  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  Future<void> _loadArticles() async {
    final articles = await getArticle();
    if (!mounted) return;

    if (articles != null && articles is List<ArticleModel>) {
      setState(() {
        _articles = articles;
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  void _openLink(String url) async {
    final uri = Uri.tryParse(url.trim());

    if (uri != null && uri.hasScheme) {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch the URL')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid URL format')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.grey,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 9, top: 9, right: 9, bottom: 0),
          child: Container(
            decoration: BoxDecoration(
              color: MyColors.turqouise,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: MyColors.lightblue, width: 2),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset('assets/icons/article_jos.png'),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 260,
                          height: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: MyColors.pink,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Mental Health Articles',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter-VariableFont_opsz,wght',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      if (_isLoading)
                        const Center(child: CircularProgressIndicator())
                      else
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _articles.length,
                          separatorBuilder: (_, __) => const Column(
                            children: [
                              SizedBox(height: 16),
                              Divider(color: MyColors.black),
                              SizedBox(height: 16),
                            ],
                          ),
                          itemBuilder: (context, index) {
                            final article = _articles[index];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (article.link != null) {
                                        _openLink(article.link!);
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 12),
                                      child: Text(
                                        article.title ?? 'Titlu articol',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          fontFamily:
                                              'Inter-VariableFont_opsz,wght',
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: MyColors.lightblue,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(9),
                                    child: Image.asset(
                                      'assets/articlephotos/${article.photo}',
                                      width: 130,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
