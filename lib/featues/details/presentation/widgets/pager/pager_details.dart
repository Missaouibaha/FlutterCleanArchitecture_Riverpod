import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:clean_arch_riverpod/core/utils/app_consts.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/featues/details/presentation/widgets/pager/pages/about_page.dart';
import 'package:clean_arch_riverpod/featues/details/presentation/widgets/pager/pages/location_page.dart';
import 'package:clean_arch_riverpod/featues/details/presentation/widgets/pager/pages/reviews_page.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/doctor_entity.dart';
import 'package:flutter/material.dart';

class PagerDetails extends StatefulWidget {
  final DoctorEntity doctor;
  const PagerDetails({super.key, required this.doctor});

  @override
  State<PagerDetails> createState() => _PagerDetailsState();
}

class _PagerDetailsState extends State<PagerDetails>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _tabController = TabController(
      length: AppConsts.pagerTabLength,
      vsync: this,
    );
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _pageController.jumpToPage(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          tabs: [
            Tab(
              child: Text(
                AppStrings.aboutTitle,
                style: TextStyles.font15BlackSemiBold,
              ),
            ),
            Tab(
              child: Text(
                AppStrings.locationTitle,
                style: TextStyles.font15BlackSemiBold,
              ),
            ),
            Tab(
              child: Text(
                AppStrings.reviewsTitle,
                style: TextStyles.font15BlackSemiBold,
              ),
            ),
          ],
          controller: _tabController,
        ),
        Expanded(
          child: PageView(
            onPageChanged: (index) => _tabController.animateTo(index),
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            children: [
              AboutPage(doctor: widget.doctor),
              LocationPage(doctor: widget.doctor),
              ReviewsPage(),
            ],
          ),
        ),
      ],
    );
  }
}
