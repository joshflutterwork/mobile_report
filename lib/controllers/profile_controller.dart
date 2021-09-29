part of 'controllers.dart';

class ProfileController extends GetxController {
  final authController = Get.find<AuthController>();
  Rx<Spouse> spouse = Spouse().obs;
  Rx<Personal> personal = Personal().obs;
  Rx<Emergency> contact = Emergency().obs;
  Rx<Document> document = Document().obs;
  RxList<String> children = <String>[].obs;
  RxList<Education> education = <Education>[].obs;
  RxList<Desease> desease = <Desease>[].obs;
  RxList<Experience> experience = <Experience>[].obs;
  RxList<Language> language = <Language>[].obs;
  RxList<Course> course = <Course>[].obs;
  var isLoading = false.obs;
  
  @override
  void onInit() {
    getContact();
    getPersonal();
    getSpouseChildren();
    getEducation();
    getExperience();
    getDesease();
    getLanguage();
    getCourse();
    getDocument();
    super.onInit();
  }

  getPersonal() async {
    try {
      isLoading.toggle();
      Request request = Request(
        url: 'employee/?type=personal',
        headers: {'Authorization': 'Bearer ${authController.getTokenHRIS()}'},
      );
      await request.get().then((res) {
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body)['data'];
          final value = Personal.fromJson(data);
          if (value is Personal) {
            personal.update((val) {
              val!.nik = value.nik;
              val.npwp = value.npwp;
              val.simA = value.simA;
              val.simC = value.simC;
            });
          }
        }
      });
    } catch (e) {
      logger.e(e);
    } finally {
      isLoading.toggle();
    }
  }

  getContact() async {
    try {
      isLoading.toggle();
      Request request = Request(
        url: 'employee/?type=emergency',
        headers: {'Authorization': 'Bearer ${authController.getTokenHRIS()}'},
      );
      await request.get().then((res) {
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body)['data'];
          final value = Emergency.fromJson(data);
          if (value is Emergency) {
            contact.update((val) {
              val!.nameAddress = value.nameAddress;
              val.phone = value.phone;
            });
          }
        }
      });
    } catch (e) {
      logger.e(e);
    } finally {
      isLoading.toggle();
    }
  }

  getSpouseChildren() async {
    try {
      isLoading.toggle();
      Request request = Request(
        url: 'employee/?type=spouse_children',
        headers: {'Authorization': 'Bearer ${authController.getTokenHRIS()}'},
      );
      await request.get().then((res) {
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body)['data'];
          final value = Spouse.fromJson(data);
          if (value is Spouse) {
            spouse.update((val) {
              val!.wife = value.wife;
              val.husband = value.husband;
            });
            children.addAll(value.children ?? []);
          }
        }
      });
    } catch (e) {
      logger.e(e);
    } finally {
      isLoading.toggle();
    }
  }

  getEducation() async {
    try {
      isLoading.toggle();
      Request request = Request(
        url: 'employee/?type=education',
        headers: {'Authorization': 'Bearer ${authController.getTokenHRIS()}'},
      );
      await request.get().then((res) {
        if (res.statusCode == 200) {
          final data =
              jsonDecode(res.body)['data'].cast<Map<String, dynamic>>();
          final value =
              (data as List).map((e) => Education.fromJson(e)).toList();
          if (value is List<Education>) {
            education.addAll(value);
          }
        }
      });
    } catch (e) {
      logger.e(e);
    } finally {
      isLoading.toggle();
    }
  }

  getExperience() async {
    try {
      isLoading.toggle();
      Request request = Request(
        url: 'employee/?type=job_experience',
        headers: {'Authorization': 'Bearer ${authController.getTokenHRIS()}'},
      );
      await request.get().then((res) {
        if (res.statusCode == 200) {
          final data =
              jsonDecode(res.body)['data'].cast<Map<String, dynamic>>();
          final value =
              (data as List).map((e) => Experience.fromJson(e)).toList();
          if (value is List<Experience>) {
            experience.addAll(value);
          }
        }
      });
    } catch (e) {
      logger.e(e);
    } finally {
      isLoading.toggle();
    }
  }

  getDesease() async {
    try {
      isLoading.toggle();
      Request request = Request(
        url: 'employee/?type=desease',
        headers: {'Authorization': 'Bearer ${authController.getTokenHRIS()}'},
      );
      await request.get().then((res) {
        if (res.statusCode == 200) {
          final data =
              jsonDecode(res.body)['data'].cast<Map<String, dynamic>>();
          final value = (data as List).map((e) => Desease.fromJson(e)).toList();
          if (value is List<Desease>) {
            desease.addAll(value);
          }
        }
      });
    } catch (e) {
      logger.e(e);
    } finally {
      isLoading.toggle();
    }
  }

  getLanguage() async {
    try {
      isLoading.toggle();
      Request request = Request(
        url: 'employee/?type=language',
        headers: {'Authorization': 'Bearer ${authController.getTokenHRIS()}'},
      );
      await request.get().then((res) {
        if (res.statusCode == 200) {
          final data =
              jsonDecode(res.body)['data'].cast<Map<String, dynamic>>();
          final value =
              (data as List).map((e) => Language.fromJson(e)).toList();
          if (value is List<Language>) {
            language.addAll(value);
          }
        }
      });
    } catch (e) {
      logger.e(e);
    } finally {
      isLoading.toggle();
    }
  }

  getCourse() async {
    try {
      isLoading.toggle();
      Request request = Request(
        url: 'employee/?type=course',
        headers: {'Authorization': 'Bearer ${authController.getTokenHRIS()}'},
      );
      await request.get().then((res) {
        if (res.statusCode == 200) {
          final data =
              jsonDecode(res.body)['data'].cast<Map<String, dynamic>>();
          final value = (data as List).map((e) => Course.fromJson(e)).toList();
          if (value is List<Course>) {
            course.addAll(value);
          }
        }
      });
    } catch (e) {
      logger.e(e);
    } finally {
      isLoading.toggle();
    }
  }

  getDocument() async {
    try {
      isLoading.toggle();
      Request request = Request(
        url: 'employee/?type=document',
        headers: {'Authorization': 'Bearer ${authController.getTokenHRIS()}'},
      );
      await request.get().then((res) {
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body)['data'];
          final value = Document.fromJson(data);
          if (value is Document) {
            document.update((val) {
              val!.kk = value.kk;
              val.ktp = value.ktp;
              val.sim = value.sim;
              val.akta = value.akta;
              val.nikah = value.nikah;
              val.ijazah = value.ijazah;
              val.sertifikat = value.sertifikat;
            });
          }
        }
      });
    } catch (e) {
      logger.e(e);
    } finally {
      isLoading.toggle();
    }
  }
}
