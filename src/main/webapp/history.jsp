<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.sqlite.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
table {
  border-collapse: collapse;
  border: 1.5px solid #d3d3d3;
  width: 100%;
}

th, td {
  text-align: center;
  border: 1.5px solid #d3d3d3;
  padding: 8px;
}

tr:nth-child(odd){background-color: #f2f2f2}

th {
  background-color: #04AA6D;
  color: white;
}
</style>
<title>와이파이 정보 구하기</title>
<%
	Class.forName("org.sqlite.JDBC");
	Connection conn = DriverManager.getConnection("jdbc:sqlite:E:/dev/eclipse-workspace/wifi/wifi.db");
	System.out.println("Connection to SQLite has been established.");
	String query = "select count(*) from history";
  	PreparedStatement pstmt = conn.prepareStatement(query);
 	ResultSet rs = pstmt.executeQuery();
 	rs.next();
    int count = rs.getInt(1);
    close(pstmt);
	//String query = "select ROWID,* over(order by date_time asc) as rownum, x, y, date_time, rowid from History";
	query = "select *, rowid from History order by date_time desc";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();

%>
<%!
static void close(PreparedStatement prep) {
    try {
	      if (prep != null) {
	        prep.close();
	        System.out.println("Query closed");
	      }
	    } catch (Exception e) {
	      e.printStackTrace();
	    }
	  } 
public void closeConnection(Connection con) {
    try {
        if( con != null ) {
        	con.close();
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
    	con = null;

        // 로그 출력
        System.out.println("CLOSED");
    }
}
%>
</head>
<body>
<H1>위치 히스토리 목록</H1><br>
<p><a href = "index.jsp" title = "Home"> 홈 </a> | <a href = "history.jsp" title="Location History List"> 위치 히스토리 목록 </a>| <a href = "load-wifi.jsp" title="Bring Open API Data"> Open API 와이파이 정보 가져오기 </a>
| <a href = "bookmark-list.jsp" title="Bookmark List"> 북마크 보기 </a>| <a href = "bookmark-group.jsp" title="Bookmark Group"> 북마크 그룹 관리 </a></p>
<p>
<table>
  <tr>
    <th>ID</th>
    <th>X좌표</th>
    <th>Y좌표</th>
    <th>조회일자</th>
    <th>비고</th>
  </tr>
  <%while(rs.next()){ %>
  <tr>
  <td><%= count-- %></td>
  <td><%=rs.getString(1) %></td>
  <td><%=rs.getString(2) %></td>
  <td><%=rs.getString(3) %></td>
  <td><button type="button" onclick="location.href='historyDelete.jsp?rowNum=<%=rs.getString(4)%>';window.location.reload()">삭제</button></td>
  </tr>
  <%} %>
  <%  	close(pstmt); 
  		closeConnection(conn);%>
  </table>
</body>
</html>