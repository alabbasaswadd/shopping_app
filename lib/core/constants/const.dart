enum OrderStateEnum {
  pending, // جاري المعالجة
  scheduled, // تم الجدولة
  inTransit, //جاري التوصيل
  delivered, //تم التوصيل
  cancelled, // تم الإلغاء
  failed, //فشل التوصيل
}

enum ShopStateEnum {
  open,
  close,
}
