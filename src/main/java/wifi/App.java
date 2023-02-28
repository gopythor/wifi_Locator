package wifi;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class App {
	  private static void saveAll(Connection conn, List<wifiList> list)
		      throws SQLException {
		    PreparedStatement prep = conn.prepareStatement("insert into WIFI_INFO values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
		    for (wifiList rs:list) {
		      prep.setString(1, rs.getX_SWIFI_MGR_NO());
		      prep.setString(2, rs.getX_SWIFI_WRDOFC());
		      prep.setString(3, rs.getX_SWIFI_MAIN_NM());
		      prep.setString(4, rs.getX_SWIFI_ADRES1());
		      prep.setString(5, rs.getX_SWIFI_ADRES2());
		      prep.setString(6, rs.getX_SWIFI_INSTL_FLOOR());
		      prep.setString(7, rs.getX_SWIFI_INSTL_TY());
		      prep.setString(8, rs.getX_SWIFI_INSTL_MBY());
		      prep.setString(9, rs.getX_SWIFI_SVC_SE());
		      prep.setString(10, rs.getX_SWIFI_CMCWR());
		      prep.setString(11, rs.getX_SWIFI_CNSTC_YEAR());
		      prep.setString(12, rs.getX_SWIFI_INOUT_DOOR());
		      prep.setString(13, rs.getX_SWIFI_REMARS3());		      
		      prep.setString(14, rs.getLAT());		      
		      prep.setString(15, rs.getLNT());		      
		      prep.setString(16, rs.getWORK_DTTM());		      
		      prep.addBatch();
		    }
		    conn.setAutoCommit(false);
		    prep.executeBatch();
		    conn.setAutoCommit(true);
		    close(prep);
		  }
	  static void close(PreparedStatement prep) {
		    try {
		      if (prep != null) {
		        prep.close();
		      }
		    } catch (Exception e) {
		      e.printStackTrace();
		    }
		  }
	
	  public static void main(String[] args) throws SQLException {
	        SQLiteManager manager = new SQLiteManager();
	 
	        manager.createConnection();     // 연결
	        
	        manager.closeConnection();      // 연결 해제
	        manager.ensureConnection();     // 재연결
	  }
}
