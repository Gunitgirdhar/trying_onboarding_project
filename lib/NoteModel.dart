
import 'AppdataBase.dart';
class NoteModel{
  int? user_id;
  String? user_email;
  int? user_mobile_number;
  String? user_password;
   String? user_gender;

  NoteModel({ this.user_id, this.user_email, this.user_mobile_number, this.user_password, this.user_gender});

  factory NoteModel.fromMap(Map<String,dynamic> map){
    return NoteModel(
        user_id: map[AppDataBase.Column_userId],
        user_email:map[AppDataBase.Column_email],
        user_mobile_number: map[AppDataBase.Column_mobileNo],
        user_password: map[AppDataBase.Column_password],
        user_gender: map[AppDataBase.Column_gender],
    );
  }

  Map<String,dynamic> toMAp(){
    return {
      AppDataBase.Column_userId:user_id,
      AppDataBase.Column_email:user_email,
      AppDataBase.Column_mobileNo:user_mobile_number,
      AppDataBase.Column_password:user_password,
      AppDataBase.Column_gender:user_gender,
    };
  }

}
