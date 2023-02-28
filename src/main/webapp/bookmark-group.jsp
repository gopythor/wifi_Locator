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
<H1>북마크 그룹</H1><br>
<p><a href = "index.jsp" title = "Home"> 홈 </a> | <a href = "history.jsp" title="Location History List"> 위치 히스토리 목록 </a>| <a href = "load-wifi.jsp" title="Bring Open API Data"> Open API 와이파이 정보 가져오기 </a>
| <a href = "bookmark-list.jsp" title="Bookmark List"> 북마크 보기 </a>| <a href = "bookmark-group.jsp" title="Bookmark Group"> 북마크 그룹 관리 </a></p>
<button type="button" onclick="location.href='bookmark-group-add.jsp' ">북마크 그룹 이름 추가</button>

<%
	Class.forName("org.sqlite.JDBC");
	Connection conn = DriverManager.getConnection("jdbc:sqlite:E:/dev/eclipse-workspace/wifi/wifi.db");
	System.out.println("Connection to SQLite has been established.");
	String query = "SELECT rowid, * FROM bookmarkGroup ORDER by sequence";
	PreparedStatement prep = conn.prepareStatement(query);
	ResultSet rs = prep.executeQuery();
	String se ="";
%>
<table>
  <tr>
    <th>ID</th>
    <th>북마크 이름</th>
    <th>순서</th>
    <th>등록일자</th>
    <th>수정일자</th>
    <th>비고</th>
  </tr>
  <tr>
  <%while(rs.next()){ %>
    <td><%=rs.getString(1) %></td>
    <td><%=rs.getString(2) %></td>
    <td><%=rs.getString(3) %></td>
    <td><%=rs.getString(4) %></td>
    <%if(rs.getString(5)!=null){
    	se = rs.getString(5);
    }
    	%>
    <td><%=se %></td>
    <%se =""; %>
    <td><a href='bookmark-group-edit.jsp?rowNum=<%=rs.getString(1)%>'> 수정</a> <a href='bookmark-group-del.jsp?rowNum=<%=rs.getString(1)%>'> 삭제</a></td>
    </tr>
     <%} %>
<%		prep.close();
		conn.close(); 
		System.out.println("Close connection from Group table");
	%>
  </table>
</body>
</html>