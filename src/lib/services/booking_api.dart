
import 'package:src/models/data/schedules/booking_info_data.dart';
import 'package:src/responses/get_list_bookings_response.dart';
import 'package:src/services/api_service.dart';
import 'package:src/services/base_api.dart';

class BookingAPI extends BaseAPI {
  static const String prefix = "booking/";

  BookingAPI() : super(prefix);

  Future<void> getIncomingLessons({
    required String accessToken,
    required String now,
    required int page,
    required int perPage,
    required Function(List<BookingInfoData>, int) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url:
            "list/student?page=$page&perPage=$perPage&dateTimeGte=$now&orderBy=meeting&sortBy=desc",
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        var result = GetListBookingsResponse.fromJson(response.response).data;
        onSuccess(result?.rows ?? [], result?.count ?? 0);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }
}