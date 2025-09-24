abstract class DeleteInterface {
  Future<void> delete({
    required String evalId,
  });

  Future<void> deleteRun({
    required String evalId,
    required String runId,
  });
}
