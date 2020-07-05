import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Text(
                'Choose language',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
            buildSwitchListTileMenuItem(
                context: context,
                title: 'मराठी',
                subtitle: 'मराठी',
                locale: EasyLocalization.of(context).supportedLocales[1]),
            buildDivider(),
            buildSwitchListTileMenuItem(
                context: context,
                title: 'English',
                subtitle: 'English',
                locale: context.supportedLocales[0]),
            buildDivider(),
            buildSwitchListTileMenuItem(
                context: context,
                title: 'हिन्दी',
                subtitle: 'हिन्दी',
                locale: EasyLocalization.of(context).supportedLocales[2]),
            buildDivider(),
          ],
        ),
      ),
    );
  }

  Container buildDivider() => Container(
        margin: EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Divider(
          color: Colors.grey,
        ),
      );

  Container buildSwitchListTileMenuItem(
      {BuildContext context, String title, String subtitle, Locale locale}) {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 5,
      ),
      child: ListTile(
          dense: true,
          // isThreeLine: true,
          title: Text(
            title,
          ),
          subtitle: Text(
            subtitle,
          ),
          onTap: () async {
            context.locale = locale;
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setInt("localeSaved", 1).then((value) {
              Navigator.pushNamed(context, Constants.ROUTE_CAROUSEL_DEMO);
            });
          }),
    );
  }
}
