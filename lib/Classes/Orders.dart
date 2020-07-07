class Orders {
  bool isCompleted;
  int orderAmount;
  List<String> itemsName;
  List<int> itemsQty;
  String dateTime, completedTime, shippedTime, status;

  Orders(
      {this.isCompleted,
      this.itemsName,
      this.itemsQty,
      this.orderAmount,
      this.dateTime,
      this.shippedTime,
      this.completedTime,
      this.status});
}
