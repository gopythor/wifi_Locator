package wifi;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;
 
public class SQLiteManager {
 
    // 상수 설정
    //   - Database 변수
    private static final String SQLITE_JDBC_DRIVER = "org.sqlite.JDBC";
    private static final String SQLITE_FILE_DB_URL = "jdbc:sqlite:E:/dev/eclipse-workspace/wifi/wifi.db";
    private static final String SQLITE_MEMORY_DB_URL = "jdbc:sqlite::memory";
 
    //  - Database 옵션 변수
    private static final boolean OPT_AUTO_COMMIT = false;
    private static final int OPT_VALID_TIMEOUT = 500;
 
    // 변수 설정
    //   - Database 접속 정보 변수
    private Connection conn = null;
    private String driver = null;
    private String url = null;
 
    // 생성자
    public SQLiteManager(){
        this(SQLITE_FILE_DB_URL);
    }
    public SQLiteManager(String url) {
        // JDBC Driver 설정
        this.driver = SQLITE_JDBC_DRIVER;
        this.url = url;
    }
 
    // DB 연결 함수
    public Connection createConnection() {
        try {
            // JDBC Driver Class 로드
            Class.forName(this.driver);
 
            // DB 연결 객체 생성
            this.conn = DriverManager.getConnection(this.url);
 
            // 로그 출력
            System.out.println("CONNECTED");
 
            // 옵션 설정
            //   - 자동 커밋
            this.conn.setAutoCommit(OPT_AUTO_COMMIT);
 
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
 
        return this.conn;
    }
 
    // DB 연결 종료 함수
    public void closeConnection() {
        try {
            if( this.conn != null ) {
                this.conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            this.conn = null;
 
            // 로그 출력
            System.out.println("CLOSED");
        }
    }
 
    // DB 재연결 함수
    public Connection ensureConnection() {
        try {
            if( this.conn == null || this.conn.isValid(OPT_VALID_TIMEOUT) ) {
                closeConnection();      // 연결 종료
                createConnection();     // 연결
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
 
        return this.conn;
    }
 
    // DB 연결 객체 가져오기
    public Connection getConnection() {
        return this.conn;
    }
    
    public int cardinality() throws SQLException {
       	Statement stmt = this.conn.createStatement();
       	String query = "select count(*) from WIFI_INFO";
       	ResultSet rs = stmt.executeQuery(query);
       	rs.next();
        int count = rs.getInt(1);
    	return count;
    }
    
    
	static void saveAll(Connection conn,List<wifiList> list)
      throws SQLException {
		PreparedStatement prep = conn.prepareStatement("insert or replace into WIFI_INFO values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
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
}