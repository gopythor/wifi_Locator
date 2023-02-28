<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.sqlite.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import = "wifi.roadAddress" %>
<%@ page import = "org.json.simple.*" %>

<!DOCTYPE html>
<html>
<head>
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
<meta charset="UTF-8">
<title>와이파이 정보 구하기</title>
 <%
    String lat = request.getParameter("LAT");
    String lnt = request.getParameter("LNT");
	int updateCnt = 0;
    
    if((lat == null && lnt == null)||(lat == "" && lnt == "")){
    	lat = "";
    	lnt = "";
    } else {
    	Class.forName("org.sqlite.JDBC");
     	Connection conn = DriverManager.getConnection("jdbc:sqlite:E:/dev/eclipse-workspace/wifi/wifi.db");
     	System.out.println("Connection to SQLite has been established.");
     	String query = "insert or replace into History values (?, ?,?)";
     	PreparedStatement prep = conn.prepareStatement(query);
     	prep.setString(1, lat);
     	prep.setString(2, lnt);
     	Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
     	String currentTimestampToString = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(currentTimestamp);
     	prep.setString(3, currentTimestampToString);
     	prep.executeUpdate();
		prep.close();
		conn.close();
		System.out.println("History closed");
		roadAddress road = new roadAddress();
		//좌표 기준 업데이트
		road.converter(lat,lnt);
		updateCnt = 1;

    }
%>
</head>
<body>

<H1>와이파이 정보 구하기</H1><br>
<p><a href = "index.jsp" title = "Home"> 홈 </a> | <a href = "history.jsp" title="Location History List"> 위치 히스토리 목록 </a>| <a href = "load-wifi.jsp" title="Bring Open API Data"> Open API 와이파이 정보 가져오기 </a>
| <a href = "bookmark-list.jsp" title="Bookmark List"> 북마크 보기 </a>| <a href = "bookmark-group.jsp" title="Bookmark Group"> 북마크 그룹 관리 </a></p>
<p>
<form method="get" name="frm">
  LAT: <input type="text" id="LAT" name="LAT" value="<%=lat%>" onKeyup="this.value=this.value.replace(/[^-\.0-9]/g,'');">
  , LNT: <input type="text" id="LNT" name="LNT"value="<%=lnt%>" onKeyup="this.value=this.value.replace(/[^-\.0-9]/g,'');">
    	<button type='button' onclick="getLocation()">내 위치 가져오기</button>
  	<input type = 'button' value = '근처 WIFI 정보보기' onclick="check()">
  	</form></p>
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
 if(updateCnt>0){ 
  	Connection conn = DriverManager.getConnection("jdbc:sqlite:E:/dev/eclipse-workspace/wifi/wifi.db");
  	System.out.println("Connection to SQLite has been established.");
  	String que = "(6371*acos(cos(radians("+lat+"))*cos(radians(LNT))*cos(radians(LAT)-radians("+lnt+"))+sin(radians("+lat+"))*sin(radians(LNT))))";
	//String query = "select * from (select(6371*acos(cos(radians("+lat+"))*cos(radians(LNT))*cos(radians(LAT)-radians("+lnt+"))+sin(radians("+lat+"))*sin(radians(LNT)))) as distance from WIFI_INFO) from WIFI_INFO limit 20 order by distance";
	String query = "SELECT"+ que + "AS distance, *, rowid FROM WIFI_INFO ORDER BY distance LIMIT 20";
	PreparedStatement prep = conn.prepareStatement(query);
	ResultSet rs = prep.executeQuery();
 %>
<%while(rs.next()){ %>
 <tr>
<% double f = Float.parseFloat(rs.getString(1)); 
f =Math.round(f*10000)/10000.0;%>
  <td><%=f%></td>
  <td><%=rs.getString(2) %></td>
  <td><%=rs.getString(3) %></td>
  <td><a href='detail.jsp?rowNum=<%=rs.getString(18)%>'> <%=rs.getString(4) %></a></td>
  <td><%=rs.getString(5) %></td>
  <td><%=rs.getString(6) %></td>
  <td><%=rs.getString(7) %></td>
  <td><%=rs.getString(8) %></td>
  <td><%=rs.getString(9) %></td>
  <td><%=rs.getString(10) %></td>
  <td><%=rs.getString(11) %></td>
  <td><%=rs.getString(12) %></td>
  <td><%=rs.getString(13) %></td>
  <td><%=rs.getString(14) %></td>
  <td><%=rs.getString(16) %></td>
  <td><%=rs.getString(15) %></td>
  <td><%=rs.getString(17) %></td>
</tr>
 <%} %>
<%		prep.close();
		conn.close(); 
		System.out.println("Close connection from Table");
	%>
  <%
 }else{ 
 %>
 
 <td colspan='17'>위치 정보를 입력한 후에 조회해 주세요.</td>  
  </tr>

<%
 }
%>
</table>
    <script>
    var x = document.getElementById("location");
    function showPosition(pos) {
		document.getElementById("LAT").value = pos.coords.latitude;
		document.getElementById("LNT").value = pos.coords.longitude;
    }
function getLocation() {        
        // Geolocation API에 액세스할 수 있는지를 확인
        if (navigator.geolocation) {
            //위치 정보를 얻기
            navigator.geolocation.getCurrentPosition (showPosition);
        } else {
            alert("이 브라우저에서는 Geolocation이 지원되지 않습니다.")
        }
    }
    
function check(){
    if(document.getElementById("LAT").value==""){
        alert("위도를 입력하세요");
        return;
    }
    if(document.getElementById("LNT").value==""){
        alert("경도를 입력하세요");
        return;
    }
    frm.submit(); //직접 submit()이라는 메소드를 호출. 액션을 들고 가줌
}
    

</script>

</body>
</html>