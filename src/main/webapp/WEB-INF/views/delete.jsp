<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#bbs table {
	    width:580px;
	    margin:0 auto;
	    margin-top:20px;
	    border:1px solid black;
	    border-collapse:collapse;
	    font-size:14px;
	}
	#bbs table caption {font-size:20px; font-weight:bold; margin-bottom:10px;}
	table th {text-align:center; border:1px solid black; padding:4px 10px;}
	table td {text-align:left; border:1px solid black; padding:4px 10px;}
	input {padding: 5px;}
	h2{text-align: center;}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	function list_go(f) {
		f.action="list.do";
		f.submit();
	}
	function delete_ok(f) {
		var chk = false;
		$.ajax({
			url:"pwd_chk.do",
			method : "post",
			data : "pwd="+$("#pwd").val()+"&idx=${idx}",
			dataType : "text",
			async:false,
			success:function(data) {
				if(data=='0'){
					alert("비밀번호 틀림");
					$("#pwd").val('');
					$("#pwd").focus();
				}else if(data=='1'){
					alert("비밀번호 맞음");
					chk = true;
				}
			},
			error:function(){
				alert("읽기실패")
			}
		});
		
		if(chk){
			f.action = "delete_ok.do";
			f.submit();
		}
	}
</script>
</head>
<body>
	<h2>Board 글삭제</h2>
	<div id="bbs">
	<form method="post">
		<table>
			<tbody>
				<tr>
					<th>비밀번호:</th>
					<td><input type="password" name="pwd" id="pwd"></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
						<input type="button" value="삭제" onclick="delete_ok(this.form)">
						<input type="button" value="목록" onclick="list_go(this.form)"/>
						<input type="hidden" name="cPage" value="${cPage}">
						<input type="hidden" name="idx" value="${idx}">
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	</div>
</body>
</html>

