// To parse this JSON data, do
//
//     final newSliderModel = newSliderModelFromJson(jsonString);

import 'dart:convert';

NewSliderModel newSliderModelFromJson(String str) => NewSliderModel.fromJson(json.decode(str));

String newSliderModelToJson(NewSliderModel data) => json.encode(data.toJson());

class NewSliderModel {
  bool error;
  String message;
  List<Datum> data;

  NewSliderModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory NewSliderModel.fromJson(Map<String, dynamic> json) => NewSliderModel(
    error: json["error"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String type;
  String typeId;
  String companyId;
  String image;
  String video;
  String slider;
  String specialization;
  String? link;
  DateTime dateAdded;
  List<Data1> data1;

  Datum({
    required this.id,
    required this.type,
    required this.typeId,
    required this.companyId,
    required this.image,
    required this.video,
    required this.slider,
    required this.specialization,
    this.link,
    required this.dateAdded,
    required this.data1,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    type: json["type"],
    typeId: json["type_id"],
    companyId: json["company_id"],
    image: json["image"],
    video: json["video"],
    slider: json["slider"],
    specialization: json["specialization"],
    link: json["link"],
    dateAdded: DateTime.parse(json["date_added"]),
    data1: List<Data1>.from(json["data1"].map((x) => Data1.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "type_id": typeId,
    "company_id": companyId,
    "image": image,
    "video": video,
    "slider": slider,
    "specialization": specialization,
    "link": link,
    "date_added": dateAdded.toIso8601String(),
    "data1": List<dynamic>.from(data1.map((x) => x.toJson())),
  };
}

class Data1 {
  String total;
  String sales;
  String stockType;
  String isPricesInclusiveTax;
  String indication;
  String rxInfo;
  String dosage;
  String type;
  String attrValueIds;
  String sellerRating;
  String sellerSlug;
  String sellerNoOfRatings;
  String sellerProfile;
  dynamic storeName;
  String storeDescription;
  String sellerId;
  String sellerName;
  String id;
  String stock;
  String name;
  String categoryId;
  String shortDescription;
  String slug;
  dynamic description;
  String totalAllowedQuantity;
  String status;
  String deliverableType;
  String deliverableZipcodes;
  String minimumOrderQuantity;
  String sku;
  String quantityStepSize;
  String codAllowed;
  String rowOrder;
  String rating;
  String noOfRatings;
  String image;
  String isReturnable;
  String isCancelable;
  String cancelableTill;
  String indicator;
  List<String> otherImages;
  String videoType;
  String video;
  List<dynamic> tags;
  String warrantyPeriod;
  String guaranteePeriod;
  String madeIn;
  String hsnCode;
  String downloadAllowed;
  String downloadType;
  String downloadLink;
  String brand;
  String availability;
  String categoryName;
  String taxPercentage;
  String taxId;
  List<dynamic> reviewImages;
  List<dynamic> attributes;
  List<Variant> variants;
  String totalStock;
  MinMaxPrice minMaxPrice;
  String relativePath;
  List<String> otherImagesRelativePath;
  String videoRelativePath;
  String totalProduct;
  String deliverableZipcodesIds;
  bool isDeliverable;
  bool isPurchased;
  String isFavorite;
  String imageMd;
  String imageSm;
  List<String> otherImagesMd;
  List<String> otherImagesSm;
  List<dynamic> variantAttributes;

  Data1({
    required this.total,
    required this.sales,
    required this.stockType,
    required this.isPricesInclusiveTax,
    required this.indication,
    required this.rxInfo,
    required this.dosage,
    required this.type,
    required this.attrValueIds,
    required this.sellerRating,
    required this.sellerSlug,
    required this.sellerNoOfRatings,
    required this.sellerProfile,
    this.storeName,
    required this.storeDescription,
    required this.sellerId,
    required this.sellerName,
    required this.id,
    required this.stock,
    required this.name,
    required this.categoryId,
    required this.shortDescription,
    required this.slug,
    this.description,
    required this.totalAllowedQuantity,
    required this.status,
    required this.deliverableType,
    required this.deliverableZipcodes,
    required this.minimumOrderQuantity,
    required this.sku,
    required this.quantityStepSize,
    required this.codAllowed,
    required this.rowOrder,
    required this.rating,
    required this.noOfRatings,
    required this.image,
    required this.isReturnable,
    required this.isCancelable,
    required this.cancelableTill,
    required this.indicator,
    required this.otherImages,
    required this.videoType,
    required this.video,
    required this.tags,
    required this.warrantyPeriod,
    required this.guaranteePeriod,
    required this.madeIn,
    required this.hsnCode,
    required this.downloadAllowed,
    required this.downloadType,
    required this.downloadLink,
    required this.brand,
    required this.availability,
    required this.categoryName,
    required this.taxPercentage,
    required this.taxId,
    required this.reviewImages,
    required this.attributes,
    required this.variants,
    required this.totalStock,
    required this.minMaxPrice,
    required this.relativePath,
    required this.otherImagesRelativePath,
    required this.videoRelativePath,
    required this.totalProduct,
    required this.deliverableZipcodesIds,
    required this.isDeliverable,
    required this.isPurchased,
    required this.isFavorite,
    required this.imageMd,
    required this.imageSm,
    required this.otherImagesMd,
    required this.otherImagesSm,
    required this.variantAttributes,
  });

  factory Data1.fromJson(Map<String, dynamic> json) => Data1(
    total: json["total"],
    sales: json["sales"],
    stockType: json["stock_type"],
    isPricesInclusiveTax: json["is_prices_inclusive_tax"],
    indication: json["indication"],
    rxInfo: json["rx_info"],
    dosage: json["dosage"],
    type: json["type"],
    attrValueIds: json["attr_value_ids"],
    sellerRating: json["seller_rating"],
    sellerSlug: json["seller_slug"],
    sellerNoOfRatings: json["seller_no_of_ratings"],
    sellerProfile: json["seller_profile"],
    storeName: json["store_name"],
    storeDescription: json["store_description"],
    sellerId: json["seller_id"],
    sellerName: json["seller_name"],
    id: json["id"],
    stock: json["stock"],
    name: json["name"],
    categoryId: json["category_id"],
    shortDescription: json["short_description"],
    slug: json["slug"],
    description: json["description"],
    totalAllowedQuantity: json["total_allowed_quantity"],
    status: json["status"],
    deliverableType: json["deliverable_type"],
    deliverableZipcodes: json["deliverable_zipcodes"],
    minimumOrderQuantity: json["minimum_order_quantity"],
    sku: json["sku"],
    quantityStepSize: json["quantity_step_size"],
    codAllowed: json["cod_allowed"],
    rowOrder: json["row_order"],
    rating: json["rating"],
    noOfRatings: json["no_of_ratings"],
    image: json["image"],
    isReturnable: json["is_returnable"],
    isCancelable: json["is_cancelable"],
    cancelableTill: json["cancelable_till"],
    indicator: json["indicator"],
    otherImages: List<String>.from(json["other_images"].map((x) => x)),
    videoType: json["video_type"],
    video: json["video"],
    tags: List<dynamic>.from(json["tags"].map((x) => x)),
    warrantyPeriod: json["warranty_period"],
    guaranteePeriod: json["guarantee_period"],
    madeIn: json["made_in"],
    hsnCode: json["hsn_code"],
    downloadAllowed: json["download_allowed"],
    downloadType: json["download_type"],
    downloadLink: json["download_link"],
    brand: json["brand"],
    availability: json["availability"],
    categoryName: json["category_name"],
    taxPercentage: json["tax_percentage"],
    taxId: json["tax_id"],
    reviewImages: List<dynamic>.from(json["review_images"].map((x) => x)),
    attributes: List<dynamic>.from(json["attributes"].map((x) => x)),
    variants: List<Variant>.from(json["variants"].map((x) => Variant.fromJson(x))),
    totalStock: json["total_stock"],
    minMaxPrice: MinMaxPrice.fromJson(json["min_max_price"]),
    relativePath: json["relative_path"],
    otherImagesRelativePath: List<String>.from(json["other_images_relative_path"].map((x) => x)),
    videoRelativePath: json["video_relative_path"],
    totalProduct: json["total_product"],
    deliverableZipcodesIds: json["deliverable_zipcodes_ids"],
    isDeliverable: json["is_deliverable"],
    isPurchased: json["is_purchased"],
    isFavorite: json["is_favorite"],
    imageMd: json["image_md"],
    imageSm: json["image_sm"],
    otherImagesMd: List<String>.from(json["other_images_md"].map((x) => x)),
    otherImagesSm: List<String>.from(json["other_images_sm"].map((x) => x)),
    variantAttributes: List<dynamic>.from(json["variant_attributes"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "sales": sales,
    "stock_type": stockType,
    "is_prices_inclusive_tax": isPricesInclusiveTax,
    "indication": indication,
    "rx_info": rxInfo,
    "dosage": dosage,
    "type": type,
    "attr_value_ids": attrValueIds,
    "seller_rating": sellerRating,
    "seller_slug": sellerSlug,
    "seller_no_of_ratings": sellerNoOfRatings,
    "seller_profile": sellerProfile,
    "store_name": storeName,
    "store_description": storeDescription,
    "seller_id": sellerId,
    "seller_name": sellerName,
    "id": id,
    "stock": stock,
    "name": name,
    "category_id": categoryId,
    "short_description": shortDescription,
    "slug": slug,
    "description": description,
    "total_allowed_quantity": totalAllowedQuantity,
    "status": status,
    "deliverable_type": deliverableType,
    "deliverable_zipcodes": deliverableZipcodes,
    "minimum_order_quantity": minimumOrderQuantity,
    "sku": sku,
    "quantity_step_size": quantityStepSize,
    "cod_allowed": codAllowed,
    "row_order": rowOrder,
    "rating": rating,
    "no_of_ratings": noOfRatings,
    "image": image,
    "is_returnable": isReturnable,
    "is_cancelable": isCancelable,
    "cancelable_till": cancelableTill,
    "indicator": indicator,
    "other_images": List<dynamic>.from(otherImages.map((x) => x)),
    "video_type": videoType,
    "video": video,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "warranty_period": warrantyPeriod,
    "guarantee_period": guaranteePeriod,
    "made_in": madeIn,
    "hsn_code": hsnCode,
    "download_allowed": downloadAllowed,
    "download_type": downloadType,
    "download_link": downloadLink,
    "brand": brand,
    "availability": availability,
    "category_name": categoryName,
    "tax_percentage": taxPercentage,
    "tax_id": taxId,
    "review_images": List<dynamic>.from(reviewImages.map((x) => x)),
    "attributes": List<dynamic>.from(attributes.map((x) => x)),
    "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
    "total_stock": totalStock,
    "min_max_price": minMaxPrice.toJson(),
    "relative_path": relativePath,
    "other_images_relative_path": List<dynamic>.from(otherImagesRelativePath.map((x) => x)),
    "video_relative_path": videoRelativePath,
    "total_product": totalProduct,
    "deliverable_zipcodes_ids": deliverableZipcodesIds,
    "is_deliverable": isDeliverable,
    "is_purchased": isPurchased,
    "is_favorite": isFavorite,
    "image_md": imageMd,
    "image_sm": imageSm,
    "other_images_md": List<dynamic>.from(otherImagesMd.map((x) => x)),
    "other_images_sm": List<dynamic>.from(otherImagesSm.map((x) => x)),
    "variant_attributes": List<dynamic>.from(variantAttributes.map((x) => x)),
  };
}

class MinMaxPrice {
  int minPrice;
  int maxPrice;
  int specialPrice;
  int maxSpecialPrice;
  int discountInPercentage;

  MinMaxPrice({
    required this.minPrice,
    required this.maxPrice,
    required this.specialPrice,
    required this.maxSpecialPrice,
    required this.discountInPercentage,
  });

  factory MinMaxPrice.fromJson(Map<String, dynamic> json) => MinMaxPrice(
    minPrice: json["min_price"],
    maxPrice: json["max_price"],
    specialPrice: json["special_price"],
    maxSpecialPrice: json["max_special_price"],
    discountInPercentage: json["discount_in_percentage"],
  );

  Map<String, dynamic> toJson() => {
    "min_price": minPrice,
    "max_price": maxPrice,
    "special_price": specialPrice,
    "max_special_price": maxSpecialPrice,
    "discount_in_percentage": discountInPercentage,
  };
}

class Variant {
  String id;
  String productId;
  String attributeValueIds;
  String attributeSet;
  String price;
  String specialPrice;
  String sku;
  String stock;
  List<dynamic> images;
  String availability;
  String status;
  DateTime dateAdded;
  String variantIds;
  String attrName;
  String variantValues;
  String swatcheType;
  String swatcheValue;
  List<dynamic> imagesMd;
  List<dynamic> imagesSm;
  List<dynamic> variantRelativePath;
  String cartCount;

  Variant({
    required this.id,
    required this.productId,
    required this.attributeValueIds,
    required this.attributeSet,
    required this.price,
    required this.specialPrice,
    required this.sku,
    required this.stock,
    required this.images,
    required this.availability,
    required this.status,
    required this.dateAdded,
    required this.variantIds,
    required this.attrName,
    required this.variantValues,
    required this.swatcheType,
    required this.swatcheValue,
    required this.imagesMd,
    required this.imagesSm,
    required this.variantRelativePath,
    required this.cartCount,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    id: json["id"],
    productId: json["product_id"],
    attributeValueIds: json["attribute_value_ids"],
    attributeSet: json["attribute_set"],
    price: json["price"],
    specialPrice: json["special_price"],
    sku: json["sku"],
    stock: json["stock"],
    images: List<dynamic>.from(json["images"].map((x) => x)),
    availability: json["availability"],
    status: json["status"],
    dateAdded: DateTime.parse(json["date_added"]),
    variantIds: json["variant_ids"],
    attrName: json["attr_name"],
    variantValues: json["variant_values"],
    swatcheType: json["swatche_type"],
    swatcheValue: json["swatche_value"],
    imagesMd: List<dynamic>.from(json["images_md"].map((x) => x)),
    imagesSm: List<dynamic>.from(json["images_sm"].map((x) => x)),
    variantRelativePath: List<dynamic>.from(json["variant_relative_path"].map((x) => x)),
    cartCount: json["cart_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "attribute_value_ids": attributeValueIds,
    "attribute_set": attributeSet,
    "price": price,
    "special_price": specialPrice,
    "sku": sku,
    "stock": stock,
    "images": List<dynamic>.from(images.map((x) => x)),
    "availability": availability,
    "status": status,
    "date_added": dateAdded.toIso8601String(),
    "variant_ids": variantIds,
    "attr_name": attrName,
    "variant_values": variantValues,
    "swatche_type": swatcheType,
    "swatche_value": swatcheValue,
    "images_md": List<dynamic>.from(imagesMd.map((x) => x)),
    "images_sm": List<dynamic>.from(imagesSm.map((x) => x)),
    "variant_relative_path": List<dynamic>.from(variantRelativePath.map((x) => x)),
    "cart_count": cartCount,
  };
}
