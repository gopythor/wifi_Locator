package wifi;

import java.sql.SQLException;

public class loadWifi {
	public static int cardinality() throws SQLException {
        SQLiteManager manager = new SQLiteManager();
        manager.createConnection();     // 연결
        int count = manager.cardinality();
        manager.closeConnection();      // 연결 해제
        return count;
  }
}
