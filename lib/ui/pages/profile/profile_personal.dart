part of '../pages.dart';

class ProfilePersonal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profile = Get.put(ProfileController());
    return Obx(
      () => (profile.isLoading.value == false)
          ? ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: Text(
                    'Informasi Pribadi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('No. KTP'),
                              Text('SIM A'),
                              Text('SIM C'),
                              Text('NPWP'),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${profile.personal.value.nik}'),
                              Text('${profile.personal.value.simA}'),
                              Text('${profile.personal.value.simC}'),
                              Text('${profile.personal.value.npwp}'),
                            ]),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: Text(
                    'Kontak Darurat',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Name dan Alamat'),
                              Text('No. Telepon'),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${profile.contact.value.nameAddress}'),
                              Text('${profile.contact.value.phone}'),
                            ]),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: Text(
                    'Informasi Pasangan & Anak',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      children: [
                        cardWidgetHoriz('Name', 'Relationship'),
                        Divider(endIndent: 24, indent: 24, thickness: 1.8),
                        cardWidgetHoriz(
                            '${profile.spouse.value.husband == null ? profile.spouse.value.wife : profile.spouse.value.husband}',
                            '${profile.spouse.value.husband == null ? 'istri' : 'suami'}'),
                        ...profile.children.map((element) {
                          return cardWidgetHoriz(element, 'Anak');
                        }),
                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(left: 24),
                //   child: Text(
                //     'Informasi Pendidikan',
                //     style: TextStyle(fontWeight: FontWeight.bold),
                //   ),
                // ),
                // ...profile.education.map((element) {
                //   return Padding(
                //     padding: const EdgeInsets.only(left: 24),
                //     child: Row(
                //       children: [
                //         Column(
                //           children: [
                //             CircleAvatar(backgroundColor: greyColor, radius: 5),
                //             Container(
                //               width: 2.5,
                //               height: 60,
                //               color: greyColor,
                //             )
                //           ],
                //         ),
                //         SizedBox(width: 16),
                //         Expanded(
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Text(
                //                 '${element.name}',
                //                 style: blackFontStyleTitle2.copyWith(
                //                     fontWeight: FontWeight.bold),
                //               ),
                //               Text('${element.speciality}',
                //                   style: greyFontStyleSubtitle),
                //               Text('${element.dateIn} - ${element.dateOut}',
                //                   style: TextStyle(color: greyColor)),
                //             ],
                //           ),
                //         )
                //       ],
                //     ),
                //   );
                // }),
                // Padding(
                //   padding: EdgeInsets.only(left: 24),
                //   child: Text(
                //     'Pengalaman Kerja',
                //     style: TextStyle(fontWeight: FontWeight.bold),
                //   ),
                // ),
                // ...profile.experience.map((element) {
                //   return Padding(
                //     padding: const EdgeInsets.only(left: 24),
                //     child: Row(
                //       children: [
                //         Column(
                //           children: [
                //             CircleAvatar(backgroundColor: greyColor, radius: 5),
                //             Container(
                //               width: 2.5,
                //               height: 60,
                //               color: greyColor,
                //             )
                //           ],
                //         ),
                //         SizedBox(width: 16),
                //         Expanded(
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Text(
                //                 '${element.company}',
                //                 style: blackFontStyleTitle2.copyWith(
                //                     fontWeight: FontWeight.bold),
                //               ),
                //               Text('${element.jobDesc}',
                //                   style: greyFontStyleSubtitle),
                //               Text('${element.dateIn} - ${element.dateOut}',
                //                   style: TextStyle(color: greyColor)),
                //             ],
                //           ),
                //         )
                //       ],
                //     ),
                //   );
                // }),
                // Padding(
                //   padding: EdgeInsets.only(left: 24),
                //   child: Text(
                //     'Informasi Riwayat Penyakit',
                //     style: TextStyle(fontWeight: FontWeight.bold),
                //   ),
                // ),
                // ...profile.desease.map((element) {
                //   return Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text('${element.name}'),
                //       Text('${element.name}'),
                //       Text('${element.relationship}'),
                //       Text('${element.treatedYear}'),
                //       Text('${element.place}'),
                //     ],
                //   );
                // }),
                // Padding(
                //   padding: EdgeInsets.only(left: 24),
                //   child: Text(
                //     'Kemampuan Bahasa',
                //     style: TextStyle(fontWeight: FontWeight.bold),
                //   ),
                // ),
                // ...profile.language.map((element) {
                //   return Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text('${element.language}'),
                //       Text('${element.reading}'),
                //       Text('${element.writing}'),
                //       Text('${element.speaking}'),
                //       Text('${element.understanding}'),
                //     ],
                //   );
                // }),
                // Padding(
                //   padding: EdgeInsets.only(left: 24),
                //   child: Text(
                //     'Informasi Kursus/Pelatihan',
                //     style: TextStyle(fontWeight: FontWeight.bold),
                //   ),
                // ),
                // ...profile.course.map((element) {
                //   return Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text('${element.title}'),
                //       Text('${element.committee}'),
                //       Text('${element.dateIn}'),
                //       Text('${element.longTime}'),
                //     ],
                //   );
                // }),
                // Padding(
                //   padding: EdgeInsets.only(left: 24),
                //   child: Text(
                //     'Document',
                //     style: TextStyle(fontWeight: FontWeight.bold),
                //   ),
                // ),
                // cardWidgetHoriz('Ijazah', 'Download', color: blues, onTap: () {
                //   downloadHandler('${profile.document.value.ijazah}');
                // }),
                // cardWidgetHoriz('KTP', 'Download', color: blues, onTap: () {
                //   downloadHandler('${profile.document.value.ktp}');
                // }),
                // cardWidgetHoriz('KK', 'Download', color: blues, onTap: () {
                //   downloadHandler('${profile.document.value.kk}');
                // }),
                // cardWidgetHoriz('SIM', 'Download', color: blues, onTap: () {
                //   downloadHandler('${profile.document.value.sim}');
                // }),
                // cardWidgetHoriz('Surat Nikah', 'Download', color: blues,
                //     onTap: () {
                //   downloadHandler('${profile.document.value.nikah}');
                // }),
                // cardWidgetHoriz('Akta Kelahiran Anak', 'Download', color: blues,
                //     onTap: () {
                //   downloadHandler('${profile.document.value.akta}');
                // }),
                // cardWidgetHoriz('Sertifikat', 'Download', color: blues,
                //     onTap: () {
                //   downloadHandler('${profile.document.value.sertifikat}');
                // }),
              ],
            )
          : loadingCircleRed,
    );
  }
}
