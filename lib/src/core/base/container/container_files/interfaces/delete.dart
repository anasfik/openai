abstract class DeleteInterface {
  Future<void> delete({
    required String fileId,
    required String containerId,
  });
}
