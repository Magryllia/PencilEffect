import java.util.Date;  // 追加
import java.text.SimpleDateFormat;  // 追加

String TimeStamp(){
  // timestamp の実装を変更
  Date date = new Date();
  SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd-HHmmss-SSS");
  return sdf.format(date);
}
