<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
td {text-align: center;
	padding: 15px 10px;
	background-color: #F6F6F6;}
th {text-align: center;
	padding: 15px 10px;
	background-color: #B2CCFF;}
h2 {text-align: center;}
table {	width: 800px;
		margin: 10px auto;}
a {	text-decoration: none;}
</style>

<script type="text/javascript">
	function write_go() {
		location.href = "write.do?cPage=${cPage}";
	}
</script>
</head>
<body>
	<h2>Board 리스트</h2>
	<table>
		<thead>
			<tr>
				<th style="width: 10%">번호</th>
				<th style="width: 30%">제목</th>
				<th style="width: 20%">글쓴이</th>
				<th style="width: 30%">날짜</th>
				<th style="width: 10%">조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${empty list}">
					<tr><td colspan="5"><h3>원하시는 자료는 존재하지 않습니다.</h3></td></tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="k" items="${list}" varStatus="vs">
						<tr>
							<td>${pvo.totalRecord-((pvo.nowPage-1)*pvo.numPerPage+vs.index)}</td>
							<td style="text-align: left">
								<c:forEach begin="1" end="${k.step}">&nbsp;&nbsp;[RE]</c:forEach>
								<a href="onelist.do?idx=${k.idx}&cPage=${cPage}">${k.title}</a></td>
							<td>${k.writer }</td>
							<td>${k.regdate.substring(0,10) }</td>
							<td>${k.hit }</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="4">
					<%-- 이전 --%> 
					<c:choose>
						<c:when test="${pvo.beginBlock <= pvo.pagePerBlock }">
							<span style="color: gray; padding: 5px; border: 1px solid gray">이전으로</span>
						</c:when>
						<c:otherwise>
							<span style="color: tomato; padding: 5px; background-color: tomato">
								<a href="list.do?cPage=${pvo.beginBlock-pvo.pagePerBlock}">이전으로</a>
							</span>
						</c:otherwise>
					</c:choose> &nbsp;&nbsp; 
					<%-- 번호 --%> 
					<c:forEach begin="${pvo.beginBlock }" end="${pvo.endBlock }" step="1" var="k">
						<c:choose>
							<c:when test="${k==pvo.nowPage}">
								<span style="background-color: tomato; padding: 5px;">${k}</span>
							</c:when>
							<c:otherwise>
								<span style="color: tomato; padding: 5px;">
									<a href="list.do?cPage=${k}">${k}</a>
								</span>
							</c:otherwise>
						</c:choose>
					</c:forEach> &nbsp;&nbsp; 
					<%-- 다음 --%> 
					<c:choose>
						<c:when test="${pvo.endBlock >= pvo.totalPage }">
							<span style="color: gray; padding: 5px; border: 1px solid gray">다음으로</span>
						</c:when>
						<c:otherwise>
							<span style="color: tomato; padding: 5px; background-color: tomato">
								<a href="list.do?cPage=${pvo.beginBlock+pvo.pagePerBlock}">다음으로</a>
							</span>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<button onclick="write_go()">글쓰기</button>
				</td>
			</tr>
		</tfoot>
	</table>
</body>
</html>