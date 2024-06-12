//create model for login
class ModelLogin {
  final String id;
  final String nama;
  final String alamat;
  final String gender;
  final String tglLahir;
  final String noKtp;
  final String password;
  final String status;

  ModelLogin({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.gender,
    required this.tglLahir,
    required this.noKtp,
    required this.password,
    required this.status,
  });

  factory ModelLogin.fromJson(Map<String, dynamic> json) {
    return ModelLogin(
      id: json['id'],
      nama: json['nama'],
      alamat: json['alamat'],
      gender: json['gender'],
      tglLahir: json['tgl_kahir'],
      noKtp: json['no_ktp'],
      password: json['password'],
      status: json['status'],
    );
  }
}
