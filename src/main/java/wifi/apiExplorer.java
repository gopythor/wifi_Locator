package wifi;
import org.json.simple.*;
	import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.HttpURLConnection;
	import java.net.URL;
	import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;


import java.io.BufferedReader;
	import java.io.IOException;

	public class apiExplorer {
		public void dataUpdate(String[] roadAddress) throws IOException, SQLException {
			StringBuilder urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088"); /*URL*/
			urlBuilder.append("/" +  URLEncoder.encode("624f775846736a693934436b6d4e46","UTF-8") ); /*인증키 (sample사용시에는 호출시 제한됩니다.)*/
			urlBuilder.append("/" +  URLEncoder.encode("json","UTF-8") ); /*요청파일타입 (xml,xmlf,xls,json) */
			urlBuilder.append("/" + URLEncoder.encode("TbPublicWifiInfo","UTF-8")); /*서비스명 (대소문자 구분 필수입니다.)*/
			urlBuilder.append("/" + URLEncoder.encode("1","UTF-8")); /*요청시작위치 (sample인증키 사용시 5이내 숫자)*/
			urlBuilder.append("/" + URLEncoder.encode("1000","UTF-8")); /*요청종료위치(sample인증키 사용시 5이상 숫자 선택 안 됨)*/
			// 상위 5개는 필수적으로 순서바꾸지 않고 호출해야 합니다.
			
			// 서비스별 추가 요청 인자이며 자세한 내용은 각 서비스별 '요청인자'부분에 자세히 나와 있습니다.
			urlBuilder.append("/" + URLEncoder.encode(roadAddress[1],"UTF-8")); /* 서비스별 추가 요청인자들*/
//			urlBuilder.append("/" + URLEncoder.encode(roadAddress[2],"UTF-8"));
			
			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");
			System.out.println("Response code: " + conn.getResponseCode()); /* 연결 자체에 대한 확인이 필요하므로 추가합니다.*/
			BufferedReader rd;

			// 서비스코드가 정상이면 200~300사이의 숫자가 나옵니다.
			if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
					rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
					rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			
			//추가
			String str = rd.readLine();
			if(str.contains("없습니다")) {
				return;
			}
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(str);
			JsonObject rootob = element.getAsJsonObject().get("TbPublicWifiInfo").getAsJsonObject();
			Gson gson = new Gson();
			JsonArray item = rootob.getAsJsonObject().get("row").getAsJsonArray();

			List<wifiList> list2 = gson.fromJson(item.toString(), new TypeToken<List<wifiList>>(){}.getType());

			SQLiteManager manager = new SQLiteManager();
			manager.createConnection();     // 연결
			Connection dbConn = manager.getConnection();
			manager.saveAll(dbConn, list2);

			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = rd.readLine()) != null) {
					sb.append(line);
			}
			rd.close();
			conn.disconnect();
	}
		
}
