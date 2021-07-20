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
td {text-align: center;	padding: 15px 10px;	background-color: #F6F6F6;}
th{	text-align: center;	padding: 15px 10px;	background-color: #B2CCFF;}
h2{text-align: center;}
table{width: 800px; margin:10px auto;}
input{padding: 5px;}
</style>
<script type="text/javascript">
	function list_go(f) {
		f.action="list.do";
		f.submit();
	}
	function ans_write(f) {
		f.action="ans_write.do";
		f.submit();
	}
	function update_go(f) {
		f.action="update.do";
		f.submit();
	}
	function delete_go(f) {
		f.action="delete.do";
		f.submit();
	}
</script>
</head>
<body>
	<h2>Board 상세보기</h2>
	<form  method="post" enctype="multipart/form-data">
		<table width="700">
		<tbody>
			<tr>
				<th>작성자</th>
				<td>${vo.writer }</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${vo.title }</td>
			</tr>
			<tr>
				<th>내용</th>
				<td align="left"><script src="//cdn.ckeditor.com/4.16.1/standard/ckeditor.js"></script>
				<textarea rows="10" cols="60" name="content" readonly>${vo.content }</textarea>
				<script type="text/javascript">CKEDITOR.replace('content');</script>
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<c:choose>
					<c:when test="${!empty vo.file_name }">
						<td style="text-align: center;">
							<img src="resources/upload/${vo.file_name}" style="width: 100px;"><br>
							<a href="download.do?file_name=${vo.file_name}">${vo.file_name }</a>
						</td>
					</c:when>
					<c:otherwise>
						<td><b>첨부파일없음</b></td>
					</c:otherwise>
				</c:choose>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" value="목록" onclick="list_go(this.form)" />
					<input type="button" value="수정" onclick="update_go(this.form)" /> 
					<input type="button" value="댓글달기" onclick="ans_write(this.form)" /> 
					<input type="button" value="삭제" onclick="delete_go(this.form)" />
					<!-- 답글에서 사용할 idx를 넘겨줌 -->
					<input type="hidden" name="idx" value="${vo.idx}">
					<!-- cPage 편하게 넘기기위해서 -->
					<input type="hidden" name="cPage" value="${cPage}">
				</td>
			</tr>
            </tbody>
		</table>
	</form>
</body>
</html>