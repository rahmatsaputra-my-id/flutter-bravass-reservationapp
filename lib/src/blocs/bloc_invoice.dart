import 'package:bravass_development/src/models/invoice_model.dart';
import 'package:bravass_development/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class InvoiceBloc {
  final _repository = new Repository();
  final _invoiceFetcher = PublishSubject<InvoiceModel>();

  Observable<InvoiceModel> get allInvoice => _invoiceFetcher.stream;

  fetchAllInvoice(String idMember) async {
    InvoiceModel invoiceModel = await _repository.fetchAllInvoice(idMember);
    _invoiceFetcher.sink.add(invoiceModel);
  }

  dispose() async {
    await _invoiceFetcher.drain();
    _invoiceFetcher.close();
  }
}

final invoiceBloc = InvoiceBloc();
