<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<%@ page import="org.sqlite.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>와이파이 정보 구하기</title>
<script>
function check(){
    if(document.getElementById("name").value==""){
        alert("북마크를 추가해주세요.");
        return;
    }

    frm.submit(); //직접 submit()이라는 메소드를 호출. 액션을 들고 가줌
}
</script>
<style>
table {
	display:flex;
	text-align: center;
  	border: 1.5px solid #d3d3d3;
	border-spacing : 0
}
td:nth-child(odd){
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

</head>
<%  	
	String row = request.getParameter("rowNum");
	Class.forName("org.sqlite.JDBC");
	Connection conn = DriverManager.getConnection("jdbc:sqlite:E:/dev/eclipse-workspace/wifi/wifi.db");
	System.out.println("Connection to SQLite has been established."); 
	String query = "SELECT BookmarkName, rowid FROM bookmarkGroup ORDER by sequence";
	PreparedStatement pstmt = conn.prepareStatement(query);
	ResultSet rs = pstmt.executeQuery();
	
%>
<body>
<H1>와이파이 정보 구하기</H1><br>
<p><a href = "index.jsp" title = "Home"> 홈 </a> | <a href = "history.jsp" title="Location History List"> 위치 히스토리 목록 </a>| <a href = "load-wifi.jsp" title="Bring Open API Data"> Open API 와이파이 정보 가져오기 </a>
| <a href = "bookmark-list.jsp" title="Bookmark List"> 북마크 보기 </a>| <a href = "bookmark-group.jsp" title="Bookmark Group"> 북마크 그룹 관리 </a></p>
 <form action="detail-do.jsp" method="get" name="frm">
 <select name="BookmarkName" id="name">
     <option value="" disabled selected>북마크 그룹 이름 선택</option>
 <%while (rs.next()) {
     String BookmarkName = rs.getString("BookmarkName");
     String rowid = rs.getString("rowid");
     %> 
	<option value="<%=BookmarkName%>"><%=BookmarkName%></option>
<%} %>
</select>
 <input type="hidden" name="id" value="<%=row%>" name=/>
<input type="button" value="북마크 추가하기" onclick="check()">
</form>
<table>
  <tr>
    <th>거리(KM)</th>
    <th>관리번호</th>
    <th>자치구</th>
    <th>와이파이명</th>
    <th>도로주소명</th>
    <th>상세주소</th>
    <th>설치위치(층)</th>
    <th>설치유형</th>
    <th>설치기관</th>
    <th>서비스구분</th>
    <th>망종류</th>
    <th>설치년도</th>
    <th>실내외구분</th>
    <th>WIFI접속환경</th>
    <th>X좌표</th>
    <th>Y좌표</th>
    <th>작업일자</th>
  </tr>
  <tr>  
  <%
	
	query = "select * from WIFI_INFO where rowid="+row;
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
%>

<%while(rs.next()){ %>
	<td>0.000</td>
	<td><%=rs.getString(1) %></td>
	<td><%=rs.getString(2) %></td>
	<td><%=rs.getString(3) %></td>
	<td><%=rs.getString(4) %></td>
	<td><%=rs.getString(5) %></td>
	 <td><%=rs.getString(6) %></td>
	 <td><%=rs.getString(7) %></td>
	 <td><%=rs.getString(8) %></td>
	 <td><%=rs.getString(9) %></td>
	 <td><%=rs.getString(10) %></td>
	 <td><%=rs.getString(11) %></td>
	 <td><%=rs.getString(12) %></td>
	 <td><%=rs.getString(13) %></td>
	 <td><%=rs.getString(15) %></td>
	 <td><%=rs.getString(14) %></td>
	 <td><%=rs.getString(16) %></td>
 	<%} %>
	<%	pstmt.close();
		conn.close(); 
		System.out.println("Close connection from Table");
	%>
  </tr>
  </table>
</body>
</html>