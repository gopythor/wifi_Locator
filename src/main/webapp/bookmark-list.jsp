<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<%@ page import="org.sqlite.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>와이파이 정보 구하기</title>
</head>
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
<body>
<H1>북마크 목록</H1><br>
<p><a href = "index.jsp" title = "Home"> 홈 </a> | <a href = "history.jsp" title="Location History List"> 위치 히스토리 목록 </a>| <a href = "load-wifi.jsp" title="Bring Open API Data"> Open API 와이파이 정보 가져오기 </a>
| <a href = "bookmark-list.jsp" title="Bookmark List"> 북마크 보기 </a>| <a href = "bookmark-group.jsp" title="Bookmark Group"> 북마크 그룹 관리 </a></p>
<%
	Class.forName("org.sqlite.JDBC");
	Connection conn = DriverManager.getConnection("jdbc:sqlite:E:/dev/eclipse-workspace/wifi/wifi.db");
	System.out.println("Connection to SQLite has been established.");
	String query = "SELECT G.rowid, G.BookmarkName, W.X_SWIFI_MAIN_NM, G.REG, G.row, W.rowid FROM bookmarkList G, WIFI_INFO W Where G.row = W.rowid ";
	PreparedStatement prep = conn.prepareStatement(query);
	ResultSet rs = prep.executeQuery();
%>
<table>
  <tr>
    <th>ID</th>
    <th>북마크 이름</th>
    <th>와이파이명</th>
    <th>등록일자</th>
    <th>비고</th>
  </tr>
   <%while(rs.next()){ %>
  <tr>
  <td><%=rs.getString(1) %></td>
  <td><%=rs.getString(2) %></td>
  <td><a href='detail.jsp?rowNum=<%=rs.getString(5)%>'> <%=rs.getString(3) %></a></td>
  <td><%=rs.getString(4) %></td>
  <td><a href='bookmark-delete.jsp?rowNum=<%=rs.getString(5)%>&rowId=<%=rs.getString(1)%>'> 삭제</a></td>
  </tr>
  <%} %>
  <%  	prep.close(); 
  		conn.close();%>
  </table>
</body>
</html>