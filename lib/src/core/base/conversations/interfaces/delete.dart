abstract class DeleteInterface {
  Future<void> delete({
    required String conversationId,
  });

  Future<void> deleteItem({
    required String conversationId,
    required String itemId,
  });
}
