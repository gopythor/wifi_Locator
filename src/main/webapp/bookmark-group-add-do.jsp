<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<%@ page import="org.sqlite.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	String seq = request.getParameter("seq");
  	Class.forName("org.sqlite.JDBC");
 	Connection conn = DriverManager.getConnection("jdbc:sqlite:E:/dev/eclipse-workspace/wifi/wifi.db");
 	System.out.println("Connection to SQLite has been established.");
	String query = "insert or replace into BookmarkGroup values (?, ?,?,?)";
 	PreparedStatement prep = conn.prepareStatement(query);
 	prep.setString(1, name);
 	prep.setString(2, seq);
 	Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
 	String currentTimestampToString = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(currentTimestamp);
 	prep.setString(3, currentTimestampToString);
 	prep.executeUpdate();
	prep.close();
	conn.close();
	System.out.println("Bookmark group save closed");
%>

<meta http-equiv="refresh" content="0; url=bookmark-group.jsp">

