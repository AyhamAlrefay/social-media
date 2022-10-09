import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/colors.dart';

import 'features/calls/presentation/pages/calls.dart';

import 'features/chat/presentation/bloc/get_contacts_user/get_contacts_user_bloc.dart';
import 'features/chat/presentation/bloc/get_messages_user/get_message_user_bloc.dart';
import 'features/chat/presentation/pages/contacts.dart';
import 'features/groups/presentation/pages/groups.dart';
import 'features/status/presentation/pages/status.dart';


class MobileChatScreen extends StatefulWidget {
  static const String routeName = '/mobile-chat-screen';

  const MobileChatScreen({Key? key}) : super(key: key);

  @override
  State<MobileChatScreen> createState() => _MobileChatScreenState();
}

class _MobileChatScreenState extends State<MobileChatScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  static const List<Tab> tab = <Tab>[
    Tab(
      text: 'CHATS',
    ),
    Tab(
      text: 'GROUPS',
    ),
    Tab(
      text: 'STATUS',
    ),
    Tab(
      text: 'CALLS',
    ),
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: tab.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
          length: tab.length,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverSafeArea(
                    top: false,
                    sliver: buildSliverAppBar(innerBoxIsScrolled),
                  ),
                )
              ];
            },
            body: buildTabBarView(),

    ),
    );
  }

  TabBarView buildTabBarView() {
    return TabBarView(
            controller: tabController,
            children: const [
              Chats(),
              Groups(),
              Status(),
              Calls(),
            ],
          );
  }

  SliverAppBar buildSliverAppBar(bool innerBoxIsScrolled) {
    return SliverAppBar(
                    title: const Text('OBWhatsapp'),
                    actions: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.signal_wifi_4_bar)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.bedtime)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.search)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_vert_outlined)),
                    ],
                    brightness: Brightness.light,
                    backgroundColor: backgroundColor,
                    iconTheme: const IconThemeData(
                      color: Colors.amberAccent,
                    ),
                    floating: true,
                    pinned: true,
                    snap: true,
                    forceElevated: innerBoxIsScrolled,
                    bottom: TabBar(
                      controller: tabController,
                      tabs: tab
                          .map((name) => Tab(
                                text: name.text,
                              ))
                          .toList(),
                    ),
                  );
  }
}
