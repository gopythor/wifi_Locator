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
	display:flex;
	text-align: left;
  	border: 1.5px solid #d3d3d3;
	border-spacing : 0
}
td:nth-child(even){
background-color: #f2f2f2
}

 th,td{display:block;
		height: 25px;
		width: 500px;
	  padding: 10px;
	  border: 1.5px solid #d3d3d3;
} 
th{
background-color: #04AA6D;
  color: white;
  		width: 300px;
}
tbody
{
display:flex;
}

</style>
<%
	String rowNum = request.getParameter("rowNum");
	String rowId = request.getParameter("rowId");

	Class.forName("org.sqlite.JDBC");
	Connection conn = DriverManager.getConnection("jdbc:sqlite:E:/dev/eclipse-workspace/wifi/wifi.db");
	System.out.println("Connection to SQLite has been established.");
 	SQLiteConfig configu = new SQLiteConfig();  
 	configu.enforceForeignKeys(true);  
	String query = "SELECT G.BookmarkName, W.X_SWIFI_MAIN_NM, G.REG, G.rowid, W.rowid FROM bookmarkList G, WIFI_INFO W Where G.rowid ='" + rowId + "'AND W.rowid='"+rowNum+"'"; 

	PreparedStatement prep = conn.prepareStatement(query);
	ResultSet rs = prep.executeQuery();
%>
<body>
<H1>북마크 삭제</H1><br>
<p><a href = "index.jsp" title = "Home"> 홈 </a> | <a href = "history.jsp" title="Location History List"> 위치 히스토리 목록 </a>| <a href = "load-wifi.jsp" title="Bring Open API Data"> Open API 와이파이 정보 가져오기 </a>
| <a href = "bookmark-list.jsp" title="Bookmark List"> 북마크 보기 </a>| <a href = "bookmark-group.jsp" title="Bookmark Group"> 북마크 그룹 관리 </a></p>
<p>북마크를 삭제하시겠습니까?</p>
<table>
  <tr>
    <th>북마크 이름</th>
    <th>와이파이명</th>
    <th>등록일자</th>
    
  </tr>
  
  
   <tr>  
 	<td><%=rs.getString(1) %></td>
    <td><%=rs.getString(2) %></td>
    <td><%=rs.getString(3) %></td>
   <td colspan="2"> <a href = "bookmark-list.jsp" title="Bookmark Group"> 돌아가기 </a> |  <a href='bookmark-list-del.jsp?rowNum=<%=rs.getString(4)%>'> 삭제</a></td>
  <%  	prep.close(); 
  		conn.close();%>
  </table>
</body>
</html>