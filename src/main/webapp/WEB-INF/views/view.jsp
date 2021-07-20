<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
tr {
		
	    text-align:center;
	    padding:4px 10px;
	    background-color: #F6F6F6;
	}
	
th {
		width:120px;
	    text-align:center;
	    padding:4px 10px;
	    background-color: #B2CCFF;
	}
</style>
</head>
<body>
	<form method="post">
	<table width="700">
	<tbody>
	<tr>
		<th bgcolor="#B2EBF4">작성자</th>
		<td> </td>
	</tr>
	
	<tr>
		<th bgcolor="#B2EBF4">제목</th>
		<td> </td>
	</tr>
	<tr>
		
	</tr>
	
	<tr>
		<th bgcolor="#B2EBF4">첨부파일</th>
		 <td></td>
	</tr>
	<tr>
		<th bgcolor="#B2EBF4">날짜</th>
		<td> </td>
	</tr>
	<tr>
		<th bgcolor="#B2EBF4">내용</th>
		<td></td>
	</tr>
	<tr>
		<td colspan="2"><textarea cols="90" rows="15"></textarea></td>
	</tr>
	</tbody>
	<tfoot>
	<tr>
     <td colspan="2">
        <input type="button" value="목록" onclick="javascript:location.href='list.jsp'" />
        <input type="button" value="답글" onclick="" />
        <input type="button" value="수정" onclick="" />
        <input type="button" value="삭제" onclick="" />
        <input type="hidden" name="seq" value="" />
	    <input type="hidden" name="pwd" />
     </td>
	</tr>
	</tfoot>
	</table>
	</form>
</body>
</html>