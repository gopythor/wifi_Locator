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
<body>

<%
String row = request.getParameter("rowNum");
System.out.println(row);
deleteRow(row);
%>
<%!
	public void deleteRow(String num) throws SQLException{
		Connection conn = DriverManager.getConnection("jdbc:sqlite:E:/dev/eclipse-workspace/wifi/wifi.db");
		System.out.println("Connection to SQLite has been established.");
		String query = "delete from bookmarkList where rowid="+num;
		PreparedStatement pstmt = conn.prepareStatement(query);
		pstmt.executeUpdate();
		pstmt.close(); 
		conn.close();
}


%>
<meta http-equiv="refresh" content="0; url=bookmark-list.jsp">
</body>
</html>