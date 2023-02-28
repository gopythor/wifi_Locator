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
<body>
<H1>북마크 그룹 수정</H1><br>
<p><a href = "index.jsp" title = "Home"> 홈 </a> | <a href = "history.jsp" title="Location History List"> 위치 히스토리 목록 </a>| <a href = "load-wifi.jsp" title="Bring Open API Data"> Open API 와이파이 정보 가져오기 </a>
| <a href = "bookmark-list.jsp" title="Bookmark List"> 북마크 보기 </a>| <a href = "bookmark-group.jsp" title="Bookmark Group"> 북마크 그룹 관리 </a></p>
<%
	request.setCharacterEncoding("utf-8");
	String row = request.getParameter("rowNum");	
	Connection conn = DriverManager.getConnection("jdbc:sqlite:E:/dev/eclipse-workspace/wifi/wifi.db");
	System.out.println("Connection to SQLite has been established.");
	String query = "SELECT * FROM bookmarkGroup WHERE rowid=?";
	PreparedStatement prep = conn.prepareStatement(query);
	prep.setInt(1,Integer.parseInt(row));
	ResultSet rs = prep.executeQuery();
%>


<table>
  <tr>
    <th>북마크 이름</th>
    <th>순서</th>
  </tr>
   <tr>
    <FORM action="bookmark-group-edit-do.jsp" method="get">  
   <td><input type="text" value="<%=rs.getString(1)%>" name="name"></td>
   <td><input type="text" value="<%=rs.getString(2)%>" name="seq"></td>
   <input type="hidden" name="id" value="<%=row%>" name=/>
   <%		prep.close();
		conn.close(); 
		System.out.println("Close connection from Table");
	%>
   <td colspan="2"> <a href = "bookmark-group.jsp" title="Bookmark Group"> 돌아가기 </a>|<INPUT type="submit" value="수정"></td>
     </FORM>
     </tr>
  </table>
</body>
</html>