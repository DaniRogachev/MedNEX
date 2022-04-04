class ConsultationRequest{
  late final String requestId;
  late final String title;
  late final String description;
  late final String status;
  late final String userId;
  late final String doctorId;

  ConsultationRequest(
      this.title, this.description, this.status, this.userId, this.doctorId, this.requestId);
}