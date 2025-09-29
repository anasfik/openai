class OpenAIGradersBase {
  Future<OpenAIRunGraderResponseModel> runGrader({
    required OpenAiGeneralGrader grader,
    required String modelSample,
    Map<String, dynamic>? item,
  });
}
