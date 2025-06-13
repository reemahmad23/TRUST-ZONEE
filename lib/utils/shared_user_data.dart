class AppGlobals {
  static int? selectedBranchId;
  static String? selectedUserId;

 
  static void setSelectedUserId(String id) {
    selectedUserId = id;
  }

  static String? getSelectedUserId() {
    return selectedUserId;
  }
}
