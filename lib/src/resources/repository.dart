import 'dart:async';

import 'package:bravass_development/src/models/invoice_model.dart';
import 'package:bravass_development/src/models/room_model.dart';

import 'bravass_provider.dart';

class Repository {
  final bravassProvider = new BravassProvider();

  Future<InvoiceModel> fetchAllInvoice(String idMember) =>
      bravassProvider.getInvoice(idMember);

  Future<RoomModel> fetchAllRoom() => bravassProvider.getRoom();
}
