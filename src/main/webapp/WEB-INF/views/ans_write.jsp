<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
<style type="text/css">
td {
	text-align: center;
	padding: 15px 10px;
	background-color: #F6F6F6;
}

th{
	text-align: center;
	padding: 15px 10px;
	background-color: #B2CCFF;
}
h2{text-align: center;}
table{width: 800px; margin:10px auto;}
input{padding: 5px;}
</style>
</style>
<script type="text/javascript">
	function list_go(f) {
		f.action="${pageContext.request.contextPath}/MyController?cmd=list&cPage=${cPage}";
		f.submit();
	}
	function ans_write_ok(f) {
		// 유효성 검사
		for (var i = 0; i < f.elements.length; i++) {
			if(f.elements[i].value==""){
				if(i==3||i==2) continue;
				alert(f.elements[i].name+"을(를) 입력해주세요");
				f.elements[i].focus();
				return;
			}
		}
		f.action="${pageContext.request.contextPath}/MyController?cmd=ans_write_ok";
		f.submit();
	}
</script>
</head>
<body>
	<h2>Board 댓글쓰기</h2>
	<form  method="post" enctype="multipart/form-data">
		<table width="700">
		<tbody>
			<tr>
				<th>작성자</th>
				<td align="left"><input type="text" name="writer"></td>
			</tr>
			<tr>
				<th>제목</th>
				<td align="left"> <input type="text" name="title"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td align="left"><script src="//cdn.ckeditor.com/4.16.1/standard/ckeditor.js"></script>
				<textarea rows="10" cols="60" name="content"></textarea>
				<script type="text/javascript">CKEDITOR.replace('content');</script>
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td align="left"><input type="file" name="file_name"></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td align="left"><input type="password" name="pwd"></td>
			</tr>
			<tr>
				<td colspan="2">
				<input type="button" value="댓글입력" onclick="ans_write_ok(this.form)" /> 
				<input type="button" value="목록" onclick="list_go(this.form)" /> 
				<input type="reset" value="취소" />
				<input type="hidden"  value="${cPage}" name="cPage"> 
				</td>
			</tr>
            </tbody>
		</table>
	</form>
</body>
</html>