import 'package:clean_arch_riverpod/core/utils/app_consts.dart';
import 'package:clean_arch_riverpod/featues/home/presentation/widgets/recomendedDoctor/shimmer/item_shimmer_recomended_doc.dart';
import 'package:flutter/material.dart';

class ShimmerRecomendedDoctorList extends StatelessWidget {
  const ShimmerRecomendedDoctorList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: AppConsts.shimmerDoctorListCount,
      itemBuilder: (context, index) {
        return const ItemShimmerRecomendedDoc();
      },
    );
  }
}
