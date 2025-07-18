import 'package:clean_arch_riverpod/core/helper/extensions.dart';
import 'package:clean_arch_riverpod/core/helper/routing/routes.dart';
import 'package:clean_arch_riverpod/core/widgets/error_dialog.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/doctor_entity.dart';
import 'package:clean_arch_riverpod/featues/home/presentation/widgets/recomendedDoctor/item_recomended_doctor.dart';
import 'package:clean_arch_riverpod/featues/home/presentation/widgets/recomendedDoctor/shimmer/shimmer_recomended_doctor_list.dart';
import 'package:clean_arch_riverpod/featues/search/presentation/providers/filter_doctor_notifier.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoctorListWidget extends ConsumerWidget {
  const DoctorListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorList = ref.watch(filtredDoctorsProvider);
    final cachedData = ref.watch(lastSuccessfulDoctorListProvider);

    return doctorList.when(
      data: (doctors) {
        return _buildDoctorList(doctors);
      },
      error: (error, stackTrace) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ErrorDialog.show(context, error.toString());
        });
        return ShimmerRecomendedDoctorList();
      },
      loading: () {
        return cachedData != null
            ? _buildDoctorList(cachedData)
            : ShimmerRecomendedDoctorList();
      },
    );
  }

  Widget _buildDoctorList(List<DoctorEntity> doctors) {
    return ListView.builder(
      itemCount: doctors?.length ?? 0,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        final doctor = doctors?.elementAt(index);
        return GestureDetector(
          child: Hero(
            tag: doctor?.id ?? 0,
            child: ItemRecomendedDoctor(doctor: doctor),
          ),
          onTap: () {
            context.pushNamed(Routes.detailsScreen, extra: doctor);
          },
        );
      },
    );
  }
}
