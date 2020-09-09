class InvoiceModel {
  List<Result> result;
  String message;
  int status;

  InvoiceModel({this.result, this.message, this.status});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
    message = json['message'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['Status'] = this.status;
    return data;
  }
}

class Result {
  String idRoom;
  String idPeriode;
  String quantity;
  String charge;
  String description;
  String total;
  String idInvoice;
  String transactionDate;
  String statusBayar;
  String jumlahBayar;
  String ppn;
  String jumlah;
  String dariTgl;
  String sampaiTgl;
  String pembayar;
  String petugas;
  String idMember;
  String periode;
  String price;
  String room;
  String descriptionRoom;
  String namaMember;
  String tglTempoByr;
  String alamatUnit;
  String namaTenant;
  String kapasitas;

  Result(
      {this.idRoom,
      this.idPeriode,
      this.quantity,
      this.charge,
      this.description,
      this.total,
      this.idInvoice,
      this.transactionDate,
      this.statusBayar,
      this.jumlahBayar,
      this.ppn,
      this.jumlah,
      this.dariTgl,
      this.sampaiTgl,
      this.pembayar,
      this.petugas,
      this.idMember,
      this.periode,
      this.price,
      this.room,
      this.descriptionRoom,
      this.namaMember,
      this.tglTempoByr,
      this.alamatUnit,
      this.namaTenant,
      this.kapasitas});

  Result.fromJson(Map<String, dynamic> json) {
    idRoom = json['id_room'];
    idPeriode = json['id_periode'];
    quantity = json['quantity'];
    charge = json['charge'];
    description = json['description'];
    total = json['total'];
    idInvoice = json['id_invoice'];
    transactionDate = json['transaction_date'];
    statusBayar = json['status_bayar'];
    jumlahBayar = json['jumlah_bayar'];
    ppn = json['ppn'];
    jumlah = json['jumlah'];
    dariTgl = json['dari_tgl'];
    sampaiTgl = json['sampai_tgl'];
    pembayar = json['pembayar'];
    petugas = json['petugas'];
    idMember = json['id_member'];
    periode = json['periode'];
    price = json['price'];
    room = json['room'];
    descriptionRoom = json['description_room'];
    namaMember = json['nama_member'];
    tglTempoByr = json['tgl_tempo_byr'];
    alamatUnit = json['alamat_unit'];
    namaTenant = json['nama_tenant'];
    kapasitas = json['kapasitas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_room'] = this.idRoom;
    data['id_periode'] = this.idPeriode;
    data['quantity'] = this.quantity;
    data['charge'] = this.charge;
    data['description'] = this.description;
    data['total'] = this.total;
    data['id_invoice'] = this.idInvoice;
    data['transaction_date'] = this.transactionDate;
    data['status_bayar'] = this.statusBayar;
    data['jumlah_bayar'] = this.jumlahBayar;
    data['ppn'] = this.ppn;
    data['jumlah'] = this.jumlah;
    data['dari_tgl'] = this.dariTgl;
    data['sampai_tgl'] = this.sampaiTgl;
    data['pembayar'] = this.pembayar;
    data['petugas'] = this.petugas;
    data['id_member'] = this.idMember;
    data['periode'] = this.periode;
    data['price'] = this.price;
    data['room'] = this.room;
    data['description_room'] = this.descriptionRoom;
    data['nama_member'] = this.namaMember;
    data['tgl_tempo_byr'] = this.tglTempoByr;
    data['alamat_unit'] = this.alamatUnit;
    data['nama_tenant'] = this.namaTenant;
    data['kapasitas'] = this.kapasitas;
    return data;
  }
}
