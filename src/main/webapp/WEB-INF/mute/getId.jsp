<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	
<title>MU:TE</title>
<!-- Bootstrap CSS -->
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
 
<!-- jQuery -->
<!-- <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script> slim 쓰지말기 --> 
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<!-- Popper.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>

<!-- Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="resources/css/getId.css">
<link rel="stylesheet" href="resources/css/modal.css">

<script>
/* function toggleModal(modalId) {
	$('#' + modalId).modal('toggle');
}


//확인 버튼 클릭 시 닉네임 등록 함수 호출
function checkAndSubmit() {
    // 확인 로직 수행 후 필요한 작업 수행
    // 예시: 닉네임 등록 처리 등
    // ...
	alert("modal")
    // 모달 창 닫기
    $('#addModal').modal('hide');
} */

var cpath = "${pageContext.request.contextPath}";

$(document).ready(function(){
	$('#btn').click(function(){
		let nickname= $('#getId').val();
		//alert(nickname)
		$.ajax({
			url : "nicknameCheck",
			type : "post",
			data : {nickname: nickname},
			dataType : 'json',
			success : function(result){
				//alert(result.available)
				if(result.available==true){
					$("#alert").html('');
					$("#alert").html(' ※ 해당 닉네임은 사용가능합니다').show();
					// 사용 가능한 경우 모달 창을 토글
					 $("#addModal").modal("show");
					// $('#addModal').modal('toggle');
				}else{
					$("#alert").html('');
					$("#alert").html(' ※ 해당 닉네임은 이미 사용중입니다!').show();

				}
			},
			error:function(){
				alert("서버요청실패");
			}
		});
	});

   });
   
/* $(document).ready(function () {
    // 삭제 버튼 클릭 시 모달 창 표시
    $("#btn").click(function () {
        $("#addModal").modal("show");
    });
}); */
</script>
</head>
<body>
	<div id="imgLogo">
		<img id="logo" alt="logo" src="resources/images/mutelogo.png">
	</div>
	
	<div id="register">
		<h1>닉네임을 등록해주세요</h1>
		
		<input type = "text" id="getId" name="id" maxlength=10 placeholder="        닉네임은 최대 10자까지 가능합니다" required>
		<button type="button" name="nickname" id="btn" class="btn">중복 확인</button>
		<br><br><!--  data-toggle="modal" data-target="#addModal" -->
		<h3 id="alert" style="display: none;"></h3>
        
	</div>
	
	<!-- 모달 창 -->
			<div class="modal fade" id="addModal" tabindex="-1" role="dialog"  aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						    <div class="modal-header">
						        <h2 class="modal-title">&nbsp;&nbsp;&nbsp;닉네임을 등록하시겠습니까?</h2>
						    </div>
						    <div class="modal-footer">
						        <button type="button" class="close-btn" onclick="checkAndSubmit()">확인</button>
						        <button type="button" class="close-btn" data-dismiss="modal" >취소</button>
						    </div>
					</div>
				</div>
			</div>
			
</body>
</html>