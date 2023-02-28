<%@page import="wifi.loadWifi"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.sqlite.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>와이파이 정보 구하기</title>
<style type="text/css">
 
div{
text-align: center;
font-size: xx-large;
font-weight:bolder;
}
p{
text-align: center;
}

</style>
</head>
<body>
<div>
 <%
 	
 	Class.forName("org.sqlite.JDBC");
 	Connection conn = DriverManager.getConnection("jdbc:sqlite:E:/dev/eclipse-workspace/wifi/wifi.db");
 	System.out.println("Connection to SQLite has been established.");
 	String query = "select count(*) from WIFI_INFO";
  	PreparedStatement pstmt = conn.prepareStatement(query);
 	ResultSet rs = pstmt.executeQuery();
 	rs.next();
    int count = rs.getInt(1);
    
    out.println(count+"개의 WIFI 정보를 정상적으로 저장하였습니다.");
	
            %>
            
<%	pstmt.close();
		conn.close(); 
		System.out.println("Close connection from load-wifi");
	%>
</div>
<p><a href="index.jsp">홈 으로 가기</a></p>

</body>
</html>