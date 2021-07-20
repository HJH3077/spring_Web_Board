<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
td {
	text-align: center;
	padding: 15px 10px;
	background-color: #F6F6F6;
}

th {
	text-align: center;
	padding: 15px 10px;
	background-color: #B2CCFF;
}

h2 {
	text-align: center;
}

table {
	width: 800px;
	margin: 10px auto;
}

a {
	text-decoration: none;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$.ajax({
		url : "list_ajax.do",
		method : "post",
		data : "cPage=${cPage}",
		dataType : "json",
		success : function(data) {
			var tr = "";
			var list = data["list"];
			$.each(list, function() {
				tr += "<tr>";
				tr += "<td>" + [ "idx" ] + "</td>";
				tr += "<td>" + this["writer"] + "</td>";
				tr += "<td>" + this["title"] + "</td>";
				tr += "<td>" + this["regdate"].substring(0, 10) + "</td>";
				tr += "<td>" + this["hit"] + "</td>";
				tr += "</tr>";
			})

			$("#tbody").append(tr);
		},
		error : function() {
			alert("읽기실패");
		}
	});

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
		<tbody id="tbody"></tbody>
		<tfoot>
			<tr>
				<td colspan="4">
					<%-- 이전 --%> <c:choose>
						<c:when test="${pvo.beginBlock <= pvo.pagePerBlock }">
							<span style="color: gray; padding: 5px; border: 1px solid gray">이전으로</span>
						</c:when>
						<c:otherwise>
							<span
								style="color: tomato; padding: 5px; border: 1px solid tomato">
								<a
								href="${pageContext.request.contextPath}/MyController?cmd=list&cPage=${pvo.beginBlock-pvo.pagePerBlock}">이전으로</a>
							</span>
						</c:otherwise>
					</c:choose> &nbsp;&nbsp; <%-- 번호 --%> <c:forEach begin="${pvo.beginBlock }"
						end="${pvo.endBlock }" step="1" var="k">
						<c:choose>
							<c:when test="${k==pvo.nowPage}">
								<span style="background-color: tomato; padding: 5px;">${k}</span>
							</c:when>
							<c:otherwise>
								<span style="color: tomato; padding: 5px;"> <a
									href="${pageContext.request.contextPath}/MyController?cmd=list&cPage=${k}">${k}</a>
								</span>
							</c:otherwise>
						</c:choose>
					</c:forEach> &nbsp;&nbsp; <%-- 다음 --%> <c:choose>
						<c:when test="${pvo.endBlock >= pvo.totalPage }">
							<span style="color: gray; padding: 5px; border: 1px solid gray">다음으로</span>
						</c:when>
						<c:otherwise>
							<span
								style="color: tomato; padding: 5px; border: 1px solid tomato">
								<a
								href="${pageContext.request.contextPath}/MyController?cmd=list&cPage=${pvo.beginBlock+pvo.pagePerBlock}">다음으로</a>
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





