<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	function list_go(f) {
		f.action="list.do";
		f.submit();
	}
	function update_ok(f) {
		/* 비밀번호체크
		if("${vo.pwd}"==f.pwd.value){
			f.action="${pageContext.request.contextPath}/MyController?cmd=update_ok";
			f.submit();
		}else{
			alert("비밀번호틀림");
			f.pwd.value="";
			f.pwd.focus();
			return;
		} */
		// ajax를 이용해서 비밀번호 맞는지 체크하기
		var chk = false;
		$.ajax({
			url: "pwd_chk.do",
			method : "post",
			data : "pwd="+$("#pwd").val()+"&idx=${idx}",
			dataType : "json",
			async : false,
			success : function(data) {
				if(data=='0'){
					alert("비밀번호 틀림");
					$("#pwd").val("");
					$("#pwd").focus();
				}else if(data=='1'){
					alert("비밀번호 맞음");
					chk = true;
				}
			},
			error :function(){
				alert("읽기실패");
			}
		});
		
		// 비밀번호가 일치하면 수행
		if(chk){
			f.action ="update_ok.do";
			f.submit();
		}
	}
</script>
</head>
<body>
	<h2>Board 글 수정</h2>
	<form  method="post" enctype="multipart/form-data">
		<table width="700">
		<tbody>
			<tr>
				<th>작성자</th>
				<td align="left"><input type="text" name="writer" value="${vo.writer }"></td>
			</tr>
			<tr>
				<th>제목</th>
				<td align="left"> <input type="text" name="title" value="${vo.title }"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td align="left"><script src="//cdn.ckeditor.com/4.16.1/standard/ckeditor.js"></script>
				<textarea rows="10" cols="60" name="content">${vo.content }</textarea>
				<script type="text/javascript">CKEDITOR.replace('content');</script>
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td>
					<c:choose>
							<c:when test="${empty vo.file_name }">
								<input type="file" name="f_name">이전파일없음
								<input type="hidden" name="old_file_name" value="">
							</c:when>
							<c:otherwise>
								<input type="file" name="f_name"> <img src="resources/upload/${vo.file_name}" style="width: 100px;">(${vo.file_name})
								<input type="hidden" name="old_file_name" value="${vo.file_name}">
							</c:otherwise>
						</c:choose>
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td align="left"><input type="password" name="pwd" id="pwd"></td>
			</tr>
			<tr>
				<td colspan="2">
				<input type="button" value="수정" onclick="update_ok(this.form)" /> 
				<input type="button" value="목록" onclick="list_go(this.form)" /> 
				<input type="reset" value="취소" />
				<input type="hidden" name="cPage" value="${cPage }">
				<input type="hidden" name="idx" value="${idx }">
				</td>
			</tr>
            </tbody>
		</table>
	</form>
</body>
</html>