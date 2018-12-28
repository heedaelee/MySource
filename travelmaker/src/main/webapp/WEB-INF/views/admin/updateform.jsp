<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원수정</title>
</head>
<body>
		<div class="content-wrapper1">
		<form action="update.htm" method="post">
		<p><h1 class=text-left>회원 수정</h1><p>
		
		<div class="col-md-6 grid-margin stretch-card">
			<div class="card">
				<div class="card-body" margin="auto">
					<h4 class="card-title">회원 수정</h4>
						<div class="form-group row">
							<label for="exampleInputUsername2" class="col-sm-3 col-form-label">이메일</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" name="m_Email"
									id="m_Email" value="${m[0].m_Email}" readonly>
							</div>
						</div>
						<div class="form-group row">
							<label for="exampleInputEmail2" class="col-sm-3 col-form-label">닉네임</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="exampleInputEmail2"
									name="m_Nickname" value="${m[0].m_Nickname}">
							</div>
						</div>
<!-- 					비밀번호 변경 	 -->
						<div class="form-group row">
							<label for="exampleInputPassword2" class="col-sm-3 col-form-label">Password</label>
							<div class="col-sm-9">
								<input type="password" class="form-control" name="m_Pwd"
									id="exampleInputPassword2" placeholder="Password">
							</div>
						</div>
						<div class="form-group row">
							<label for="exampleInputConfirmPassword2"
								class="col-sm-3 col-form-label">Re Password</label>
							<div class="col-sm-9">
								<input type="password" class="form-control"
									id="exampleInputConfirmPassword2" placeholder="Password">
							</div>
						</div>
<!-- 					비밀번호 변경 끝  	 -->
						<div class="form-group row">
							<label for="exampleInputMobile" class="col-sm-3 col-form-label">이미지</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="exampleInputMobile"
									name="m_Image" value="${m[0].m_Image}">
							</div>
						</div>
						
						
						<div class="form-group row">
							<label for="exampleInputMobile" class="col-sm-3 col-form-label">가입일</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="exampleInputMobile"
									name="m_Regdate" value="${m[0].m_Regdate}">
							</div>
						</div>
						<div class="form-group row">
							<label for="exampleInputMobile" class="col-sm-3 col-form-label">권한상태</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="exampleInputMobile"
									name="enabled" value="${m[0].enabled}">
							</div>
						</div>
						<div class="form-group row">
							<label for="exampleInputMobile" class="col-sm-3 col-form-label">권한코드</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="exampleInputMobile"
									name="a_Code" value="${m[0].a_Code}">
							</div>
						</div>
						<div class="form-group row">
							<label for="exampleInputMobile" class="col-sm-3 col-form-label">성별</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="exampleInputMobile"
									name="m_Gender" value="${m[0].m_Gender}">
							</div>
						</div>
						
						<div class="form-check form-check-flat form-check-primary">
							<label class="form-check-label"> 
							<input type="checkbox" class="form-check-input"> Remember me
							</label>
						</div>
<!-- 						<button type="submit" class="btn btn-gradient-primary mr-2">Submit</button> -->
						<input type="submit" class="btn btn-gradient-primary mr-2" value="수 정">
						<button class="btn btn-light">Cancel</button>
				</div>
			</div>
		</div>
	</form>
	</div>
</body>
</html>