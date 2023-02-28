<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<H1>북마크 그룹 추가</H1><br>
<p><a href = "index.jsp" title = "Home"> 홈 </a> | <a href = "history.jsp" title="Location History List"> 위치 히스토리 목록 </a>| <a href = "load-wifi.jsp" title="Bring Open API Data"> Open API 와이파이 정보 가져오기 </a>
| <a href = "bookmark-list.jsp" title="Bookmark List"> 북마크 보기 </a>| <a href = "bookmark-group.jsp" title="Bookmark Group"> 북마크 그룹 관리 </a></p>
<table>
  <tr>
    <th>북마크 이름</th>
    <th>순서</th>
  </tr>
  <FORM action="bookmark-group-add-do.jsp" method="get">
   <tr>  
   <td><input type="text" name="name"></td>
   <td><input type="number" name="seq"></td>
   <td colspan="2"> <INPUT type="submit" value="추가"></td>
   </FORM>
   </tr>
  </table>
  
  
</body>
</html>