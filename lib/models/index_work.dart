part of 'models.dart';

// To parse this JSON data, do
//
//     final indexWorkReport = indexWorkReportFromJson(jsonString);

IndexWorkReport indexWorkReportFromJson(String str) =>
    IndexWorkReport.fromJson(json.decode(str));

class IndexWorkReport {
  IndexWorkReport({
    this.data,
    this.htmlLinks,
    this.total,
    this.hasMorePage,
    this.currentPage,
  });

  List<WorkReport>? data;
  String? htmlLinks;
  int? total;
  bool? hasMorePage;
  int? currentPage;

  factory IndexWorkReport.fromJson(Map<String, dynamic> json) =>
      IndexWorkReport(
        data: List<WorkReport>.from(
            json["data"].map((x) => WorkReport.fromJson(x))),
        htmlLinks: json["html_links"],
        total: json["total"],
        hasMorePage: json["has_more_page"],
        currentPage: json["current_page"],
      );
}

class WorkReport {
  WorkReport({
    required this.id,
    required this.implementationScheduleId,
    required this.imageBefores,
    required this.imageAfters,
    required this.total,
    required this.date,
    required this.progress,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.callId,
    this.taskId,
    required this.siteProjectId,
    required this.serviceCategoryId,
    required this.createdBy,
    this.file,
    required this.customerName,
    required this.imageBeforeSources,
    required this.imageAfterSources,
    required this.fileSrc,
    required this.createdByName,
    //required this.implementationSchedule,
  });

  int id;
  int implementationScheduleId;
  String imageBefores;
  String imageAfters;
  String total;
  DateTime date;
  String progress;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic callId;
  dynamic taskId;
  int siteProjectId;
  int serviceCategoryId;
  CreatedBy createdBy;
  dynamic file;
  String customerName;
  List<ImageSourceReport> imageBeforeSources;
  List<ImageSourceReport> imageAfterSources;
  String fileSrc;
  String createdByName;
  //ImplementationSchedule implementationSchedule;

  factory WorkReport.fromJson(Map<String, dynamic> json) => WorkReport(
        id: json["id"],
        implementationScheduleId: json["implementation_schedule_id"],
        imageBefores: json["image_befores"],
        imageAfters: json["image_afters"],
        total: json["total"],
        date: DateTime.parse(json["date"]),
        progress: json["progress"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        callId: json["call_id"],
        taskId: json["task_id"],
        siteProjectId: json["site_project_id"],
        serviceCategoryId: json["service_category_id"],
        createdBy: CreatedBy.fromJson(json["created_by"]),
        file: json["file"],
        customerName: json["customer_name"],
        imageBeforeSources: List<ImageSourceReport>.from(
            json["image_before_sources"]
                .map((x) => ImageSourceReport.fromJson(x))),
        imageAfterSources: List<ImageSourceReport>.from(
            json["image_after_sources"]
                .map((x) => ImageSourceReport.fromJson(x))),
        fileSrc: json["file_src"],
        createdByName: json["created_by_name"],
        // implementationSchedule:
        //     ImplementationSchedule.fromJson(json["implementation_schedule"]),
      );
}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class ImageSourceReport {
  ImageSourceReport({
    required this.src,
    required this.filename,
  });

  String src;
  String filename;

  factory ImageSourceReport.fromJson(Map<String, dynamic> json) =>
      ImageSourceReport(
        src: json["src"],
        filename: json["filename"],
      );
}

// class ImplementationSchedule {
//   ImplementationSchedule({
//     this.id,
//     this.name,
//     this.projectId,
//     this.fromDate,
//     this.toDate,
//     this.phone,
//     this.location,
//     this.description,
//     this.area,
//     this.repeatInterval,
//     this.repeatType,
//     this.repeatEvery,
//     this.repeat,
//     this.parentId,
//     this.importId,
//     this.createdAt,
//     this.updatedAt,
//     this.siteProjectId,
//     this.serviceCategoryId,
//     this.createdBy,
//     this.createdByName,
//     this.project,
//   });

//   int id;
//   String name;
//   int projectId;
//   DateTime fromDate;
//   DateTime toDate;
//   String phone;
//   String location;
//   String description;
//   String area;
//   dynamic repeatInterval;
//   dynamic repeatType;
//   dynamic repeatEvery;
//   dynamic repeat;
//   dynamic parentId;
//   dynamic importId;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int siteProjectId;
//   int serviceCategoryId;
//   CreatedBy createdBy;
//   String createdByName;
//   Project project;

//   factory ImplementationSchedule.fromJson(Map<String, dynamic> json) =>
//       ImplementationSchedule(
//         id: json["id"],
//         name: json["name"],
//         projectId: json["project_id"],
//         fromDate: DateTime.parse(json["from_date"]),
//         toDate: DateTime.parse(json["to_date"]),
//         phone: json["phone"],
//         location: json["location"],
//         description: json["description"],
//         area: json["area"],
//         repeatInterval: json["repeat_interval"],
//         repeatType: json["repeat_type"],
//         repeatEvery: json["repeat_every"],
//         repeat: json["repeat"],
//         parentId: json["parent_id"],
//         importId: json["import_id"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         siteProjectId: json["site_project_id"],
//         serviceCategoryId: json["service_category_id"],
//         createdBy: CreatedBy.fromJson(json["created_by"]),
//         createdByName: json["created_by_name"],
//         project: Project.fromJson(json["project"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "project_id": projectId,
//         "from_date": fromDate.toIso8601String(),
//         "to_date": toDate.toIso8601String(),
//         "phone": phone,
//         "location": location,
//         "description": description,
//         "area": area,
//         "repeat_interval": repeatInterval,
//         "repeat_type": repeatType,
//         "repeat_every": repeatEvery,
//         "repeat": repeat,
//         "parent_id": parentId,
//         "import_id": importId,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "site_project_id": siteProjectId,
//         "service_category_id": serviceCategoryId,
//         "created_by": createdBy.toJson(),
//         "created_by_name": createdByName,
//         "project": project.toJson(),
//       };
// }

// class Deal {
//   Deal({
//     this.id,
//     this.skkNumber,
//     this.budgetPlanId,
//     this.type,
//     this.projectValue,
//     this.dealBy,
//     this.requestDate,
//     this.note,
//     this.createdAt,
//     this.updatedAt,
//     this.siteProjectId,
//     this.serviceCategoryId,
//     this.createdBy,
//     this.percentFee,
//     this.fee,
//     this.customerName,
//     this.customerPhone,
//     this.address,
//     this.currentStatus,
//     this.createdByName,
//     this.order,
//     this.budgetPlan,
//     this.project,
//   });

//   int id;
//   String skkNumber;
//   int budgetPlanId;
//   String type;
//   String projectValue;
//   int dealBy;
//   DateTime requestDate;
//   String note;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int siteProjectId;
//   int serviceCategoryId;
//   CreatedBy createdBy;
//   dynamic percentFee;
//   String fee;
//   String customerName;
//   String customerPhone;
//   String address;
//   String currentStatus;
//   String createdByName;
//   dynamic order;
//   BudgetPlan budgetPlan;
//   Project project;

//   factory Deal.fromJson(Map<String, dynamic> json) => Deal(
//         id: json["id"],
//         skkNumber: json["skk_number"],
//         budgetPlanId: json["budget_plan_id"],
//         type: json["type"],
//         projectValue: json["project_value"],
//         dealBy: json["deal_by"],
//         requestDate: DateTime.parse(json["request_date"]),
//         note: json["note"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         siteProjectId: json["site_project_id"],
//         serviceCategoryId: json["service_category_id"],
//         createdBy: CreatedBy.fromJson(json["created_by"]),
//         percentFee: json["percent_fee"],
//         fee: json["fee"],
//         customerName: json["customer_name"],
//         customerPhone: json["customer_phone"],
//         address: json["address"],
//         currentStatus: json["current_status"],
//         createdByName: json["created_by_name"],
//         order: json["order"],
//         budgetPlan: BudgetPlan.fromJson(json["budget_plan"]),
//         project: Project.fromJson(json["project"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "skk_number": skkNumber,
//         "budget_plan_id": budgetPlanId,
//         "type": type,
//         "project_value": projectValue,
//         "deal_by": dealBy,
//         "request_date": requestDate.toIso8601String(),
//         "note": note,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "site_project_id": siteProjectId,
//         "service_category_id": serviceCategoryId,
//         "created_by": createdBy.toJson(),
//         "percent_fee": percentFee,
//         "fee": fee,
//         "customer_name": customerName,
//         "customer_phone": customerPhone,
//         "address": address,
//         "current_status": currentStatus,
//         "created_by_name": createdByName,
//         "order": order,
//         "budget_plan": budgetPlan.toJson(),
//         "project": project.toJson(),
//       };
// }

// class Project {
//   Project({
//     this.id,
//     this.dealId,
//     this.projectStatusId,
//     this.projectManagerId,
//     this.startDate,
//     this.endDate,
//     this.rapValue,
//     this.importId,
//     this.importClientOrderId,
//     this.createdAt,
//     this.updatedAt,
//     this.siteProjectId,
//     this.serviceCategoryId,
//     this.createdBy,
//     this.createdByName,
//     this.deal,
//   });

//   int id;
//   int dealId;
//   int projectStatusId;
//   int projectManagerId;
//   DateTime startDate;
//   DateTime endDate;
//   String rapValue;
//   dynamic importId;
//   dynamic importClientOrderId;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int siteProjectId;
//   int serviceCategoryId;
//   CreatedBy createdBy;
//   String createdByName;
//   Deal deal;

//   factory Project.fromJson(Map<String, dynamic> json) => Project(
//         id: json["id"],
//         dealId: json["deal_id"],
//         projectStatusId: json["project_status_id"],
//         projectManagerId: json["project_manager_id"],
//         startDate: DateTime.parse(json["start_date"]),
//         endDate: DateTime.parse(json["end_date"]),
//         rapValue: json["rap_value"],
//         importId: json["import_id"],
//         importClientOrderId: json["import_client_order_id"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         siteProjectId: json["site_project_id"],
//         serviceCategoryId: json["service_category_id"],
//         createdBy: CreatedBy.fromJson(json["created_by"]),
//         createdByName: json["created_by_name"],
//         deal: json["deal"] == null ? null : Deal.fromJson(json["deal"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "deal_id": dealId,
//         "project_status_id": projectStatusId,
//         "project_manager_id": projectManagerId,
//         "start_date":
//             "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
//         "end_date":
//             "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
//         "rap_value": rapValue,
//         "import_id": importId,
//         "import_client_order_id": importClientOrderId,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "site_project_id": siteProjectId,
//         "service_category_id": serviceCategoryId,
//         "created_by": createdBy.toJson(),
//         "created_by_name": createdByName,
//         "deal": deal == null ? null : deal.toJson(),
//       };
// }

// class BudgetPlan {
//   BudgetPlan({
//     this.id,
//     this.orderId,
//     this.name,
//     this.importId,
//     this.createdAt,
//     this.updatedAt,
//     this.siteProjectId,
//     this.serviceCategoryId,
//     this.createdBy,
//     this.totalPrices,
//     this.currentStatus,
//     this.createdByName,
//     this.order,
//   });

//   int id;
//   int orderId;
//   String name;
//   dynamic importId;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int siteProjectId;
//   int serviceCategoryId;
//   CreatedBy createdBy;
//   int totalPrices;
//   String currentStatus;
//   String createdByName;
//   Order order;

//   factory BudgetPlan.fromJson(Map<String, dynamic> json) => BudgetPlan(
//         id: json["id"],
//         orderId: json["order_id"],
//         name: json["name"],
//         importId: json["import_id"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         siteProjectId: json["site_project_id"],
//         serviceCategoryId: json["service_category_id"],
//         createdBy: CreatedBy.fromJson(json["created_by"]),
//         totalPrices: json["total_prices"],
//         currentStatus: json["current_status"],
//         createdByName: json["created_by_name"],
//         order: Order.fromJson(json["order"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "order_id": orderId,
//         "name": name,
//         "import_id": importId,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "site_project_id": siteProjectId,
//         "service_category_id": serviceCategoryId,
//         "created_by": createdBy.toJson(),
//         "total_prices": totalPrices,
//         "current_status": currentStatus,
//         "created_by_name": createdByName,
//         "order": order.toJson(),
//       };
// }

// class Order {
//   Order({
//     this.id,
//     this.category,
//     this.customerId,
//     this.customerName,
//     this.customerPhone,
//     this.customerAddressId,
//     this.picName,
//     this.address,
//     this.province,
//     this.city,
//     this.subdistrict,
//     this.subdistrictAreaName,
//     this.subdistrictAreaId,
//     this.orderStatusId,
//     this.businessCategoryId,
//     this.leadSourceId,
//     this.orderChannelId,
//     this.origin,
//     this.orderDatetime,
//     this.paymentMethod,
//     this.budget,
//     this.importId,
//     this.createdAt,
//     this.updatedAt,
//     this.siteProjectId,
//     this.serviceCategoryId,
//     this.createdBy,
//     this.token,
//     this.images,
//     this.totalPrices,
//     this.fullAddress,
//     this.imageSources,
//     this.createdByName,
//     this.orderServices,
//   });

//   int id;
//   String category;
//   int customerId;
//   String customerName;
//   dynamic customerPhone;
//   int customerAddressId;
//   String picName;
//   String address;
//   String province;
//   String city;
//   String subdistrict;
//   String subdistrictAreaName;
//   int subdistrictAreaId;
//   int orderStatusId;
//   int businessCategoryId;
//   int leadSourceId;
//   int orderChannelId;
//   String origin;
//   dynamic orderDatetime;
//   String paymentMethod;
//   String budget;
//   dynamic importId;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int siteProjectId;
//   int serviceCategoryId;
//   CreatedBy createdBy;
//   dynamic token;
//   dynamic images;
//   int totalPrices;
//   String fullAddress;
//   List<dynamic> imageSources;
//   String createdByName;
//   List<OrderService> orderServices;

//   factory Order.fromJson(Map<String, dynamic> json) => Order(
//         id: json["id"],
//         category: json["category"],
//         customerId: json["customer_id"],
//         customerName: json["customer_name"],
//         customerPhone: json["customer_phone"],
//         customerAddressId: json["customer_address_id"],
//         picName: json["pic_name"],
//         address: json["address"],
//         province: json["province"],
//         city: json["city"],
//         subdistrict: json["subdistrict"],
//         subdistrictAreaName: json["subdistrict_area_name"],
//         subdistrictAreaId: json["subdistrict_area_id"],
//         orderStatusId: json["order_status_id"],
//         businessCategoryId: json["business_category_id"],
//         leadSourceId: json["lead_source_id"],
//         orderChannelId: json["order_channel_id"],
//         origin: json["origin"],
//         orderDatetime: json["order_datetime"],
//         paymentMethod: json["payment_method"],
//         budget: json["budget"],
//         importId: json["import_id"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         siteProjectId: json["site_project_id"],
//         serviceCategoryId: json["service_category_id"],
//         createdBy: CreatedBy.fromJson(json["created_by"]),
//         token: json["token"],
//         images: json["images"],
//         totalPrices: json["total_prices"],
//         fullAddress: json["full_address"],
//         imageSources: List<dynamic>.from(json["image_sources"].map((x) => x)),
//         createdByName: json["created_by_name"],
//         orderServices: List<OrderService>.from(
//             json["order_services"].map((x) => OrderService.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "category": category,
//         "customer_id": customerId,
//         "customer_name": customerName,
//         "customer_phone": customerPhone,
//         "customer_address_id": customerAddressId,
//         "pic_name": picName,
//         "address": address,
//         "province": province,
//         "city": city,
//         "subdistrict": subdistrict,
//         "subdistrict_area_name": subdistrictAreaName,
//         "subdistrict_area_id": subdistrictAreaId,
//         "order_status_id": orderStatusId,
//         "business_category_id": businessCategoryId,
//         "lead_source_id": leadSourceId,
//         "order_channel_id": orderChannelId,
//         "origin": origin,
//         "order_datetime": orderDatetime,
//         "payment_method": paymentMethod,
//         "budget": budget,
//         "import_id": importId,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "site_project_id": siteProjectId,
//         "service_category_id": serviceCategoryId,
//         "created_by": createdBy.toJson(),
//         "token": token,
//         "images": images,
//         "total_prices": totalPrices,
//         "full_address": fullAddress,
//         "image_sources": List<dynamic>.from(imageSources.map((x) => x)),
//         "created_by_name": createdByName,
//         "order_services":
//             List<dynamic>.from(orderServices.map((x) => x.toJson())),
//       };
// }

// class OrderService {
//   OrderService({
//     this.id,
//     this.orderId,
//     this.serviceId,
//     this.siteProjectId,
//     this.serviceCategoryId,
//     this.createdBy,
//     this.totalPrice,
//     this.service,
//     this.orderServicePrices,
//   });

//   int id;
//   int orderId;
//   int serviceId;
//   dynamic siteProjectId;
//   dynamic serviceCategoryId;
//   dynamic createdBy;
//   int totalPrice;
//   Service service;
//   List<OrderServicePrice> orderServicePrices;

//   factory OrderService.fromJson(Map<String, dynamic> json) => OrderService(
//         id: json["id"],
//         orderId: json["order_id"],
//         serviceId: json["service_id"],
//         siteProjectId: json["site_project_id"],
//         serviceCategoryId: json["service_category_id"],
//         createdBy: json["created_by"],
//         totalPrice: json["total_price"],
//         service: Service.fromJson(json["service"]),
//         orderServicePrices: List<OrderServicePrice>.from(
//             json["order_service_prices"]
//                 .map((x) => OrderServicePrice.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "order_id": orderId,
//         "service_id": serviceId,
//         "site_project_id": siteProjectId,
//         "service_category_id": serviceCategoryId,
//         "created_by": createdBy,
//         "total_price": totalPrice,
//         "service": service.toJson(),
//         "order_service_prices":
//             List<dynamic>.from(orderServicePrices.map((x) => x.toJson())),
//       };
// }

// class OrderServicePrice {
//   OrderServicePrice({
//     this.orderServiceId,
//     this.unitPriceId,
//     this.qty,
//     this.price,
//     this.subtotal,
//     this.siteProjectId,
//     this.serviceCategoryId,
//     this.createdBy,
//   });

//   int orderServiceId;
//   int unitPriceId;
//   String qty;
//   String price;
//   String subtotal;
//   dynamic siteProjectId;
//   dynamic serviceCategoryId;
//   dynamic createdBy;

//   factory OrderServicePrice.fromJson(Map<String, dynamic> json) =>
//       OrderServicePrice(
//         orderServiceId: json["order_service_id"],
//         unitPriceId: json["unit_price_id"],
//         qty: json["qty"],
//         price: json["price"],
//         subtotal: json["subtotal"],
//         siteProjectId: json["site_project_id"],
//         serviceCategoryId: json["service_category_id"],
//         createdBy: json["created_by"],
//       );

//   Map<String, dynamic> toJson() => {
//         "order_service_id": orderServiceId,
//         "unit_price_id": unitPriceId,
//         "qty": qty,
//         "price": price,
//         "subtotal": subtotal,
//         "site_project_id": siteProjectId,
//         "service_category_id": serviceCategoryId,
//         "created_by": createdBy,
//       };
// }

// class Service {
//   Service({
//     this.id,
//     this.title,
//     this.popup,
//     this.category,
//     this.image,
//     this.importAhsSubcategoryId,
//     this.createdAt,
//     this.updatedAt,
//     this.siteProjectId,
//     this.serviceCategoryId,
//     this.createdBy,
//     this.imageSrc,
//     this.createdByName,
//   });

//   int id;
//   String title;
//   dynamic popup;
//   String category;
//   dynamic image;
//   String importAhsSubcategoryId;
//   DateTime createdAt;
//   DateTime updatedAt;
//   dynamic siteProjectId;
//   int serviceCategoryId;
//   dynamic createdBy;
//   String imageSrc;
//   String createdByName;

//   factory Service.fromJson(Map<String, dynamic> json) => Service(
//         id: json["id"],
//         title: json["title"],
//         popup: json["popup"],
//         category: json["category"],
//         image: json["image"],
//         importAhsSubcategoryId: json["import_ahs_subcategory_id"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         siteProjectId: json["site_project_id"],
//         serviceCategoryId: json["service_category_id"],
//         createdBy: json["created_by"],
//         imageSrc: json["image_src"],
//         createdByName: json["created_by_name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "popup": popup,
//         "category": category,
//         "image": image,
//         "import_ahs_subcategory_id": importAhsSubcategoryId,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "site_project_id": siteProjectId,
//         "service_category_id": serviceCategoryId,
//         "created_by": createdBy,
//         "image_src": imageSrc,
//         "created_by_name": createdByName,
//       };
// }
