// part of 'services.dart';

// class UserService {
//   ////GET
//   static Future<UserModel> getProfile(context) async {
//     String url = API_URL + "/mob/employee";
//     String token =
//         await Provider.of<AuthProvider>(context, listen: false).getToken();

//     var response =
//         await http.get(url, headers: {'Authorization': 'Bearer $token'});

//     if (response.statusCode == 200 && response.body != null) {
//       var jsonObject = json.decode(response.body);
//       // print(response.body);
//       // print(response.statusCode);
//       return UserModel.fromJson(jsonObject["data"]);
//     }
//     return null;
//   }

//   static Future<Personal> getPersonal(context) async {
//     String url = API_URL + "/mob/employee/?type=personal";
//     String token =
//         await Provider.of<AuthProvider>(context, listen: false).getToken();
//     var response =
//         await http.get(url, headers: {'Authorization': 'Bearer $token'});
//     if (response.statusCode == 200 && response.body != null) {
//       var jsonObject = json.decode(response.body);
//       return Personal.fromJson(jsonObject["data"]);
//     }
//     return null;
//   }

//   static Future<Emergency> getEmergency(context) async {
//     String url = API_URL + "/mob/employee/?type=emergency";
//     String token =
//         await Provider.of<AuthProvider>(context, listen: false).getToken();
//     var response =
//         await http.get(url, headers: {'Authorization': 'Bearer $token'});
//     if (response.statusCode == 200 && response.body != null) {
//       var jsonObject = json.decode(response.body);
//       return Emergency.fromJson(jsonObject["data"]);
//     }
//     return null;
//   }

//   static Future<Spouse> getSpouse(context) async {
//     String url = API_URL + "/mob/employee/?type=spouse_children";
//     String token =
//         await Provider.of<AuthProvider>(context, listen: false).getToken();
//     var response =
//         await http.get(url, headers: {'Authorization': 'Bearer $token'});
//     if (response.statusCode == 200 && response.body != null) {
//       var jsonObject = json.decode(response.body);
//       return Spouse.fromJson(jsonObject["data"]);
//     }
//     return null;
//   }

//   static Future<Document> getDocument(context) async {
//     String url = API_URL + "/mob/employee/?type=document";
//     String token =
//         await Provider.of<AuthProvider>(context, listen: false).getToken();
//     var response =
//         await http.get(url, headers: {'Authorization': 'Bearer $token'});
//     if (response.statusCode == 200 && response.body != null) {
//       var jsonObject = json.decode(response.body);
//       return Document.fromJson(jsonObject["data"]);
//     }
//     return null;
//   }

//   static Future<List<Education>> getEducation(context) async {
//     List<Education> list;
//     String url = API_URL + "/mob/employee/?type=education";
//     String token =
//         await Provider.of<AuthProvider>(context, listen: false).getToken();
//     var response =
//         await http.get(url, headers: {'Authorization': 'Bearer $token'});
//     if (response.statusCode == 200) {
//       var data = json.decode(response.body);
//       var rest = data["data"] as List;
//       list = rest.map<Education>((json) => Education.fromJson(json)).toList();
//     }
//     return list;
//   }

//   static Future<List<Experience>> getExperience(context) async {
//     List<Experience> list;
//     String url = API_URL + "/mob/employee/?type=job_experience";
//     String token =
//         await Provider.of<AuthProvider>(context, listen: false).getToken();
//     var response =
//         await http.get(url, headers: {'Authorization': 'Bearer $token'});
//     if (response.statusCode == 200) {
//       var data = json.decode(response.body);
//       var rest = data["data"] as List;
//       list = rest.map<Experience>((json) => Experience.fromJson(json)).toList();
//     }
//     return list;
//   }

//   static Future<List<Course>> getCourse(context) async {
//     List<Course> list;
//     String url = API_URL + "/mob/employee/?type=course";
//     String token =
//         await Provider.of<AuthProvider>(context, listen: false).getToken();
//     var response =
//         await http.get(url, headers: {'Authorization': 'Bearer $token'});
//     if (response.statusCode == 200) {
//       var data = json.decode(response.body);
//       var rest = data["data"] as List;
//       list = rest.map<Course>((json) => Course.fromJson(json)).toList();
//     }
//     return list;
//   }

//   static Future<List<Language>> getLanguage(context) async {
//     List<Language> list;
//     String url = API_URL + "/mob/employee/?type=language";
//     String token =
//         await Provider.of<AuthProvider>(context, listen: false).getToken();
//     var response =
//         await http.get(url, headers: {'Authorization': 'Bearer $token'});
//     if (response.statusCode == 200) {
//       var data = json.decode(response.body);
//       var rest = data["data"] as List;
//       list = rest.map<Language>((json) => Language.fromJson(json)).toList();
//     }
//     return list;
//   }

//   static Future<List<Desease>> getDesease(context) async {
//     List<Desease> list;
//     String url = API_URL + "/mob/employee/?type=desease";
//     String token =
//         await Provider.of<AuthProvider>(context, listen: false).getToken();
//     var response =
//         await http.get(url, headers: {'Authorization': 'Bearer $token'});
//     if (response.statusCode == 200) {
//       var data = json.decode(response.body);
//       var rest = data["data"] as List;
//       list = rest.map<Desease>((json) => Desease.fromJson(json)).toList();
//     }
//     return list;
//   }

//   ////POST
//   static Future updatePersonal(context, int id,
//       {@required String nik, String simA, String simC, String npwp}) async {
//     String url = API_URL + "/mob/employee/update/$id";
//     String token =
//         await Provider.of<AuthProvider>(context, listen: false).getToken();
//     try {
//       http.post(url, headers: {
//         'Authorization': 'Bearer $token'
//       }, body: {
//         'type': 'personal',
//         'nik': nik,
//         'sim_a': simA,
//         'sim_c': simC,
//         'npwp': npwp,
//       }).then((value) {
//         print(value.body);
//         print(value.statusCode);
//       }).catchError((error) {
//         print(error.toString());
//         return false;
//       });
//       return true;
//     } catch (e) {
//       print(e);
//     }
//   }

//   static Future updateEmergency(
//       context, int id, String address, String phone) async {
//     String url = API_URL + "/mob/employee/update/$id";
//     String token =
//         await Provider.of<AuthProvider>(context, listen: false).getToken();
//     try {
//       http.post(url, headers: {
//         'Authorization': 'Bearer $token',
//       }, body: {
//         'type': 'emergency',
//         'name_address': address,
//         'phone': phone,
//       }).then((value) {
//         print(value.body);
//         print(value.statusCode);
//       }).catchError((error) {
//         print(error.toString());
//         return false;
//       });
//       return true;
//     } catch (e) {
//       print(e);
//     }
//   }

//   static Future updateProfile(context, int id,
//       {String name,
//       String email,
//       String birth,
//       String phone,
//       String image,
//       String address}) async {
//     String url = API_URL + "/mob/employee/update/$id";
//     String token =
//         await Provider.of<AuthProvider>(context, listen: false).getToken();
//     try {
//       http.post(url, headers: {
//         'Authorization': 'Bearer $token',
//       }, body: {
//         'type': 'head',
//         'name': name,
//         'email': email,
//         'birth': birth,
//         'phone': phone,
//         'address': address,
//         'image': image,
//       }).then((value) {
//         print(value.body);
//         print(value.statusCode);
//       }).catchError((error) {
//         print(error.toString());
//         return false;
//       });
//       return true;
//     } catch (e) {
//       print(e);
//     }
//   }

//   static Future<void> updateSpouse(context, int id,
//       {String husband, String wife, List<String> children}) async {
//     String url = API_URL + "/mob/employee/update-2/$id";
//     String token =
//         await Provider.of<AuthProvider>(context, listen: false).getToken();
//     var body = json.encode({
//       "category": "spouse_children",
//       "husband": husband,
//       "wife": wife,
//       "children": children,
//     });
//     final response = await http.post(
//       url,
//       headers: {'Authorization': 'Bearer $token'},
//       body: body,
//     );
//     if (response.statusCode == 200 && response != null) {
//       print(response.body);
//       print(response.statusCode);
//       print(body);
//       return body;
//     } else {
//       throw Exception('Failed to update');
//     }
//   }
// }

// class SalaryService {
//   static Future<DetailSalary> getDetail(context, int id) async {
//     String url = API_URL + "/mob/salary-continue-detail/$id";
//     String token =
//         await Provider.of<AuthProvider>(context, listen: false).getToken();
//     var response =
//         await http.get(url, headers: {'Authorization': 'Bearer $token'});
//     if (response.statusCode == 200 && response.body != null) {
//       var jsonObject = json.decode(response.body);
//       return DetailSalary.fromJson(jsonObject);
//     }
//     return null;
//   }
// }
