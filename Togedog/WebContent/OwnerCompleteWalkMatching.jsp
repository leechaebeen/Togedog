<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Togedog</title>

<!-- 파비콘 적용 -->
<link rel="shortcut icon" href="favicon.ico">
<link rel="icon" href="images/favicon.png">

<link rel="stylesheet" type="text/css" href="css/MiaryTemplate.css">
<script src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/Modal.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/starRating.css">

<style type="text/css">

	div .nav-btns
	{
		padding: 0px 0px 0px 0%;
		margin: 20px 0px 5px 0px;
	}
	
	
	.nav-tabs
	{
		padding: 0px 0px 0px 0px;
		margin: 10px 10px 0px 20px;
	
	}
	
	th, td
	{
		text-align: center;
		vertical-align: middle;                               
	}
	
	
	/* css 파일 안먹어서 중복으로 작성 */
	.container
	{
		padding: 0px 0px 0px 0px;
		border-radius: 0px 0px 0px 0px;
	}
	
	/* 너비 맞춤 */
	.content-wrap
	{	
		width :100%;
		margin : 0px 0px 0px 0px;
		padding: 0px 0px 0px 0px;
		border-radius: 0px 0px 0px 0px;
		background-color: var(--blue);
	}
	
	.menus
	{
		margin: 30px 0px 0px 0px;
		padding: 0px 0px 0px 90px;
	}
	
	.txt
	{
		margin: 10px 0px 0px 70px;
		padding: 0px 0px 0px 0px;
		font-size: 18px;
		font-weight: bold;
		text-align: left;
	}
	
	
	
	/* 메뉴탭(메인, 기록...) 효과 정리 */
	  
	.flex-column > li > a:hover,
	.flex-column > li > a:focus 
	{
		text-decoration: none;
		background-color: #fff;
		border-radius: 0 10px 10px 0;
	}
	
	 .nav-tabs > li > a 
	{
		margin-right: 0px;
		line-height: 1.42857143;
		border: 1px solid transparent;
		border-radius: 10px 10px 0 0;
	} 
	
	.selBox
	{
		display: inline-block;
		width: 150px;
		height: 25px;		
	}
	
	.icon
	{
		margin-right: 13px;
		margin-top: 5px; 
	}

	/* 추가 200726 */
	.nav-item:hover
	{
		background-color: #FFFFFF;
		cursor: pointer;
	}
</style>

<script>

	$(document).ready(function()
	{
		$("#ownertab").click(function() 
		{
			location.href="<%=cp%>/ownermiarymain.action";	
		});
		
		// 워커 탭 클릭하면 
		$("#workertab").click(function() 
		{
			// 세션에 들어간 유저코드가 누구인지 jstl 로 알아냄 그리고 userType 에 담는다.
			var userType = "<c:out value='${sessionScope.user.getUserType()}' />";
			
			//alert(userType);
			
			// 유저코드가 견주이면
			if(userType == "견주")
			{
				// 이렇게 띄워주고
				if(confirm("워커가 되시면 워커 마이어리를 이용하실 수 있습니다." + "\n" + "확인 버튼을 누르시면 워커 지원 페이지로 전환됩니다!") == true)
				{
					location.href="<%=cp%>/mainworkerrec.action";
				}
				else
				{
					return;
				}
			}
			else // 그렇지 않으면 ... (견주겸워커인경우는 워커마이어리로 가게된다.)
			{
				location.href="<%=cp%>/workermiarymain.action";
			}
			
		});
		
		 // 상세정보 보기 클릭하면
		$("button").filter(".detail").click(function()
		{
			//alert("클릭~!!");
				
			var userCd = "<c:out value='${sessionScope.user.getCode()}' />";
			
			//견주아이디 = $(this).val();
			$("#modal").show();
			
			//상세 정보
			$.ajax(
			{
				url : "walklastdetail.action",
				method : "POST",
				async : false,
				data : { walkLastCd : $(this).val(),
						 userCd : userCd
						},
				success : function(data)
				{	
					$("#getDetail").html(data);
				}
			});
					
		});
		
		// 피드백 버튼 클릭시 
		$('.ownerFeedback').click(function()
		{
			var userCd = "<c:out value='${sessionScope.user.getCode()}' />";
			
			$('#ownerFeedbackMd').modal("show");
			//상세 정보
			$.ajax(
			{
				url : "ownerfeedbackform.action",
				method : "GET",
				async : false,
				data : 
				{ 
					walkLastCd : $(this).val(), 
					userCd : userCd
				},
				success : function(data)
				{	
					$("#getFeedback").html(data);
				}
			});
			
			$("#ownerfeedbackBtn").click(function()
			 {
			 	$("#dogfeedbackForm").submit();
			 	
			 });
			
						
							
		});
				
		// 산책기록 버튼 클릭 시
		$("button").filter(".write").click(function()
		{
			location.href="<%=cp%>/walkrecwrite.action?walkCd=" + $(this).val();
		});
		
	});
	
	function closeModal()
	{
		$('.searchModal').hide();
	};
	
</script>

</head>
<body>
    <c:import url="Header.jsp"></c:import>
    
		<!-- 전체 감싸는 container -->
		<div class="container col-md-12">
		

			<!-- 견주/워커 탭과 content 와 nav-bar 를 감싸는 content-wrap -->
			<div class="content-wrap col-md-12">
		
		
				<!-- 견주/워커 탭 -->
				<div class="tabbable" id="tabs-460097">
					<ul class="nav nav-tabs" style="border-bottom: none;">
						<li class="nav-item">
							<a class="nav-link" id="ownertab" data-toggle="tab">견주</a>
						</li>
						<li class="nav-item" style="background-color: #E8E8E8;">
							<a class="nav-link" id="workertab" data-toggle="tab">워커</a>
						</li>
					</ul>
				</div>
				
				<!-- main 감싸는 content -->
				<div class="content col-md-10">
				
					<!-- 메인 영역 -->
					<div class="main col-md-10">						
							
						<!-- 신청내역/매칭 완료 -->
						<div class="tabbable col-md-8" id="tabs-460097">
							<ul class="nav nav-tabs" style="border-bottom: none;">
								<li class="nav-item col-md-4" style="background-color: #E8E8E8;">
									<a class="nav-link" href="<%=cp %>/ownerwalkmatching.action">산책신청 내역</a>
								</li>
								<li class="nav-item col-md-4" >
									<a class="nav-link active" href="<%=cp %>/ownercompletewalkmatching.action">산책매칭 완료</a>
								</li>
							</ul>
						</div>
						
						<!-- 산책매칭/대행매칭 버튼 -->
					
						<div class="menus col-md-4">
							<button type="button" class="btn btn-xs"  
							 style=" background-color: var(--deep-blue);"
							 onclick="location.href='<%=cp %>/ownerwalkmatching.action'">산책</button>
							<button type="button" class="btn btn-xs"
							 style=" background-color:var(--deep-blue);"
							 onclick="location.href='<%=cp %>/ownerworkermatching.action'">대행</button>
						</div>	
		 
						<br><br><br><br>
						
						<!-- 셀렉트박스  -->
						<div class="col-md-6" style="margin: 10px 0px 0px 0px; padding: 0px 20% 0px 0px; text-align: left;">
							<div><span class="txt"><img src="images/FOOT.png" alt="🐾" style="width: 30px; margin-right: 10px;"/>매칭 완료</span></div>
						</div>
						<div class="col-md-6" style="margin: 10px 0px 20px 0px; padding: 0px 0px 0px 20%;">
							<div class="selBox">
							<select class="form-control" id="" >
								<option value="0">==선택==</option>
								<option value="1">산책날짜순</option>
								<option value="2" selected="selected">진행상태순</option>
							</select>	
							</div>
							<div class="selBox">			
							<select class="form-control" id="">
								<option value="0">==선택==</option>
								<option value="1" selected="selected">5개씩 보기</option>
								<option value="2">10개씩 보기</option>
								<option value="3">20개씩 보기</option>
							</select>
							</div>		
						</div>
						
						<!-- 테이블 -->
						<div style=" width: 90%; margin: 10px 5% 0% 5%;">
							<table class="toMeList table table-hover table-condensed">
								<tr>
									<th style="text-align: center;">번호</th>
									<th style="text-align: center;">상세정보</th>
									<th style="text-align: center;">닉네임</th>
									<th style="text-align: center;">나이</th>
									<th style="text-align: center;">성별</th>
									<th style="text-align: center;">산책날짜</th>
									<th style="text-align: center;">산책시간</th>
									<th style="text-align: center;">산책장소</th>
									<th style="text-align: center;">진행상태</th>
									<th style="text-align: center;">버튼</th>									
								</tr>
								

							<c:forEach var="matching" items="${matchingList }">
								<input type="hidden" value="${matching.walkLastCd }">
								<tr>
									<td>${matching.rowN }</td>
									<!-- 내가 산책 등록한 회원이면 선택한 상대의 상세정보를 보는거고 -->
									<!-- 내가 산책 선택한 회원이면 등록한 상대의 상세정보를 보는거다 -->
									
									<td>
										<button class="detail" value="${matching.walkLastCd }">상세정보보기</button>
									</td>
									<td>${matching.nickName }</td>
									<td>${matching.age }</td>
									<td>${matching.gender }</td>
									<td>${matching.walkDate }</td>
									<td>${matching.startTime } ~ ${matching.endTime }</td>
									<td>${matching.addr1} ${matching.addr2} ${matching.addr3} ${matching.addrDetail }</td>
									<td>${matching.status }</td>
									<!-- 진행상태 -->
									<td>
										<a><svg class="icon" width="1.7em" height="1.7em" viewBox="0 0 16 16" class="bi bi-person-plus-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  											<path fill-rule="evenodd" d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm7.5-3a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5z"/>
  											<path fill-rule="evenodd" d="M13 7.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0v-2z"/>
										</svg>
										</a>
										<button type="button" class="btn btn-default btn-xs ownerFeedback" value="${matching.walkLastCd }">피드백</button>
										<button type="button" class="btn btn-default btn-xs write" value="${matching.walkCd }">산책기록</button>
									</td>
								</tr>
							</c:forEach> 
							
							<!-- 더미 -->
							<tr>
									<td>5</td>
									<!-- 내가 산책 등록한 회원이면 선택한 상대의 상세정보를 보는거고 -->
									<!-- 내가 산책 선택한 회원이면 등록한 상대의 상세정보를 보는거다 -->
									
									<td>
										<button class="detail" value="${matching.walkLastCd }">상세정보보기</button>
									</td>
									<td>togedog</td>
									<td>26</td>
									<td>여자</td>
									<td>2020.10.28</td>
									<td>18:00 ~ 19:30</td>
									<td>서울시 마포구 서교동 쌍용강북교육센터 앞</td>
									<td>대기중</td>
									<!-- 진행상태 -->
									<td>
										<a><svg class="icon" width="1.7em" height="1.7em" viewBox="0 0 16 16" class="bi bi-person-plus-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  											<path fill-rule="evenodd" d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm7.5-3a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5z"/>
  											<path fill-rule="evenodd" d="M13 7.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0v-2z"/>
										</svg>
										</a>
										<button type="button" class="btn btn-default btn-xs ownerFeedback" value="${matching.walkLastCd }">피드백</button>
										<button type="button" class="btn btn-default btn-xs write" value="${matching.walkCd }">산책기록</button>
									</td>
								</tr>
								<tr>
									<td>4</td>
									<!-- 내가 산책 등록한 회원이면 선택한 상대의 상세정보를 보는거고 -->
									<!-- 내가 산책 선택한 회원이면 등록한 상대의 상세정보를 보는거다 -->
									
									<td>
										<button class="detail" value="${matching.walkLastCd }">상세정보보기</button>
									</td>
									<td>라이언</td>
									<td>22</td>
									<td>남자</td>
									<td>2020.10.25</td>
									<td>18:00 ~ 19:00</td>
									<td>서울시 마포구 서교동 나무공원 앞</td>
									<td>대기중</td>
									<!-- 진행상태 -->
									<td>
										<a><svg class="icon" width="1.7em" height="1.7em" viewBox="0 0 16 16" class="bi bi-person-plus-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  											<path fill-rule="evenodd" d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm7.5-3a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5z"/>
  											<path fill-rule="evenodd" d="M13 7.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0v-2z"/>
										</svg>
										</a>
										<button type="button" class="btn btn-default btn-xs ownerFeedback" value="${matching.walkLastCd }">피드백</button>
										<button type="button" class="btn btn-default btn-xs write" value="${matching.walkCd }">산책기록</button>
									</td>
								</tr>
								<tr>
									<td>3</td>
									<!-- 내가 산책 등록한 회원이면 선택한 상대의 상세정보를 보는거고 -->
									<!-- 내가 산책 선택한 회원이면 등록한 상대의 상세정보를 보는거다 -->
									
									<td>
										<button class="detail" value="${matching.walkLastCd }">상세정보보기</button>
									</td>
									<td>오리조아</td>
									<td>28</td>
									<td>여자</td>
									<td>2020.09.25</td>
									<td>14:00 ~ 15:30</td>
									<td>서울시 마포구 서교동 공원 앞</td>
									<td>대기중</td>
									<!-- 진행상태 -->
									<td>
										<a><svg class="icon" width="1.7em" height="1.7em" viewBox="0 0 16 16" class="bi bi-person-plus-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  											<path fill-rule="evenodd" d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm7.5-3a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5z"/>
  											<path fill-rule="evenodd" d="M13 7.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0v-2z"/>
										</svg>
										</a>
										<button type="button" class="btn btn-default btn-xs ownerFeedback" value="${matching.walkLastCd }">피드백</button>
										<button type="button" class="btn btn-default btn-xs write" value="${matching.walkCd }">산책기록</button>
									</td>
								</tr>
								<tr>
									<td>2</td>
									<td>
										<button class="detail" value="${matching.walkLastCd }">상세정보보기</button>
									</td>
									<td>하루아빠</td>
									<td>23</td>
									<td>남자</td>
									<td>2020.09.20</td>
									<td>18:00 ~ 19:30</td>
									<td>서울시 마포구 서교동 파리바게트 앞 벤치</td>
									<td>산책완료</td>
									<!-- 진행상태 -->
									<td>
										<a><svg class="icon" width="1.7em" height="1.7em" viewBox="0 0 16 16" class="bi bi-person-plus-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  											<path fill-rule="evenodd" d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm7.5-3a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5z"/>
  											<path fill-rule="evenodd" d="M13 7.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0v-2z"/>
										</svg>
										</a>
										<button type="button" class="btn btn-default btn-xs ownerFeedback" value="${matching.walkLastCd }">피드백</button>
										<button type="button" class="btn btn-default btn-xs write" value="${matching.walkCd }">산책기록</button>
									</td>
								</tr>
								<tr>
									<td>1</td>
									<td>
										<button class="detail" value="${matching.walkLastCd }">상세정보보기</button>
									</td>
									<td>댕댕러버</td>
									<td>27</td>
									<td>여자</td>
									<td>2020.09.18</td>
									<td>20:00 ~ 20:30</td>
									<td>서울시 마포구 서교동 홍대입구역 9번 출구</td>
									<td>산책완료</td>
									<!-- 진행상태 -->
									<td>
										<a><svg class="icon" width="1.7em" height="1.7em" viewBox="0 0 16 16" class="bi bi-person-plus-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  											<path fill-rule="evenodd" d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm7.5-3a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5z"/>
  											<path fill-rule="evenodd" d="M13 7.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0v-2z"/>
										</svg>
										</a>
										<button type="button" class="btn btn-default btn-xs ownerFeedback" value="${matching.walkLastCd }">피드백</button>
										<button type="button" class="btn btn-default btn-xs write" value="${matching.walkCd }">산책기록</button>
									</td>
								</tr>
						
						
						
							</table>
						</div><!-- end JoinGroupList -->
							
						<!-- 페이징 -->
						<nav class="pagination-sm">
	                        <ul class="pagination">
	                           <li class="page-item">
	                              <a class="page-link" href="#">Previous</a>
	                           </li>
	                           <li class="page-item">
	                              <a class="page-link" href="#">1</a>
	                           </li>
	                           <li class="page-item">
	                              <a class="page-link" href="#">2</a>
	                           </li>
	                           <li class="page-item">
	                              <a class="page-link" href="#">3</a>
	                           </li>
	                           <li class="page-item">
	                              <a class="page-link" href="#">4</a>
	                           </li>
	                           <li class="page-item">
	                              <a class="page-link" href="#">5</a>
	                           </li>
	                           <li class="page-item">
	                              <a class="page-link" href="#">Next</a>
	                           </li>
	                        </ul>
                     </nav>	
							
					</div><!-- end main -->
						
				</div><!-- end content  -->
					
				<!-- 탭들 감싸는 nav-bar -->
				<div class="nav-bar col-md-1"  style="margin-top: 15px; padding-left: 0px;">
					<ul class="nav flex-column">
						<li class="nav-item"><a class="nav-link" href="<%=cp %>/ownermiarymain.action">메 인</a></li>
						<li class="nav-item" style="background-color: #FFFFFF;"><a class="nav-link active" href="<%=cp %>/ownerwalkmatching.action">매 칭</a></li>
						<li class="nav-item"><a class="nav-link" href="<%=cp %>/ownerrecordlisttab.action">기 록</a></li>
						<li class="nav-item"><a class="nav-link" href="<%=cp %>/ownergrouptab.action">그 룹</a></li>
						<li class="nav-item"><a class="nav-link" href="<%=cp %>/ownerstatisticstab.action">통 계</a></li>
						<li class="nav-item"><a class="nav-link" href="<%=cp %>/ownerfriendlist.action">정 보</a></li>
					</ul>
				</div><!--  end nav_bar -->
			</div><!-- end content-wrap  -->

		</div><!-- end container -->
		
		
		
		
		<!-- 내가 받은 신청 모달창 -->
		<div id="modal" class="searchModal">
			<div class="search-modal-content">
				<div class="page-header">
					<h3 style="font-weight: bold;">상세정보</h3>
				</div>


				<!-- 더미 -->				
				<!-- <div class="row">
					<div class="col-sm-12" id="getDetail"></div>
				</div>
				 -->
				<div class="row">
					<div class="col-sm-12">
					
					<div style="text-align: left; font-size: 17px; font-weight:bold;
					  margin: 0px 0px 10px 10px;">견주 정보</div>
					
						<table id="own" class="table table-hover table-condensed">
							<tr>
								<th style="text-align: center;">사진</th>
								<th style="text-align: center;">닉네임</th>
								<th style="text-align: center;">나이</th>
								<th style="text-align: center;">성별</th>
								<th style="text-align: center;">관심사</th>
								<th style="text-align: center;">상세 관심사</th>
								<th style="text-align: center;">산책날짜</th>
								<th style="text-align: center;">산책시간</th>
								<th style="text-align: center;">산책 강아지 수</th>
							</tr>
							<tr>
									<td>none</td>
									<td>댕댕러버</td>
									<td>27</td>
									<td>여자</td>
									<td>여행</td>
									<td>제주도</td>
									<td>2020.09.18</td>
									<td>20:00 ~ 20:30</td>
									<td>2</td>
							<tr>
						</table>
						
						<div style="text-align: left; font-size: 17px; font-weight:bold;
						  margin: 0px 0px 10px 10px;">강아지 정보</div>
					
						<table id="pet" class="table table-hover table-condensed">
							<tr>
								<th style="text-align: center;">사진</th>
								<th style="text-align: center;">칭호</th>
								<th style="text-align: center;">이름</th>
								<th style="text-align: center;">생년월일</th>
								<th style="text-align: center;">성별/중성화여부</th>
								<th style="text-align: center;">견종</th>
								<th style="text-align: center;">사이즈</th>
							</tr>
								<tr>
									<td>none</td>
									<td>특출난 똑똑이</td>
									<td>
										<span class="glyphicon glyphicon-heart" style="color: #F25C69; margin-right: 5px;"></span>
										마루
									</td>
									<td>2018.05.12</td>
									<td> 여아 / 2019.08.12</td>
									<td>말티즈</td>
									<td>소형</td>
								</tr>
								<tr>
									<td>none</td>
									<td>서투른 골목대장</td>
									<td>
										<span class="glyphicon glyphicon-heart" style="color: #F25C69; margin-right: 5px;"></span>
										호두
									</td>
									<td>2014.05.12</td>
									<td> 남아 / 2015.08.12</td>
									<td>말티즈</td>
									<td>소형</td>
								</tr>
						</table>
						
						
						<div style="text-align: left; font-size: 17px; font-weight:bold;
						  margin: 0px 0px 10px 10px;">장애·알러지 정보</div>
					
						<table id="petsub" class="table table-hover table-condensed">
							<tr>
								<th style="text-align: center;">구분</th>
								<th style="text-align: center;">이름</th>
								<th style="text-align: center;">내용</th>
							</tr>
							<tr>
								<td>알러지</td>
								<td>호두</td>
								<td>닭</td>
							</tr>
							<tr>
								<td>장애</td>
								<td>호두</td>
								<td>한 쪽 눈이 안보여요</td>
							</tr>
							
						</table>
						
						<!-- 이전 매칭 정보 --><!-- 단계 높아야 제공 -->
						<div style="text-align: left; font-size: 17px; font-weight:bold;
						  margin: 0px 0px 10px 10px;">이전 매칭 피드백 정보
							<span class="tooltip_event glyphicon glyphicon-question-sign" id="preFeedback"
							style="margin-left: 5px;" 
							data-toggle="tooltip" data-placement="right" title="최근에 상대에게 준 항목별 피드백 점수입니다."
							>
							</span>
						
						</div>
						<table id="ownfdb" class="table table-hover table-condensed">
							<tr>
								<th style="text-align: center;">항목</th>
								<th style="text-align: center;">점수</th>
							</tr>
							<tr>
								<td>준비성</td>
						        <td>
						        	<span class="star">★★★★★</span>
						        </td>
						    </tr> 
						    <tr>
						    	<td>책임감</td>
						        <td>
						        	<span class="star">★★★★☆</span>
						        </td>
						    </tr>
						     <tr>
						    	<td>만족도</td>
						        <td>
						        	<span class="star">★★★★☆</span>
						        </td>
						    </tr>
						    <tr>
						    	<td>정보의 정확도</td>
						        <td>
						        	<span class="star">★★★★☆</span>
						        </td>
						    </tr>
						   
							

						</table>
						
						<br>
						<button type="button" class="btn btn-default btn-xs">피드백</button>
						<button type="button" class="btn btn-default btn-xs">산책기록</button>
						<button type="button" class="btn btn-default btn-xs">신고</button>
					</div>
				</div>
				
				
				
				
				
				
				
				
				
				
				<hr>
				<div
					style="cursor: pointer; background-color: #DDDDDD; text-align: center; padding-bottom: 10px; padding-top: 10px;"
					onClick="closeModal();">
					<span class="pop_bt modalCloseBtn" style="font-size: 11pt;">
					닫기</span>
				</div>
			</div>
		</div><!-- end modal -->
		
		<!-- 산책 후 피드백 모달 -->

		<div class="modal fade" id="ownerFeedbackMd" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
			<div class="modal-content">
				<form action="ownerfeedback.action" method="get" id="dogfeedbackForm" >
					<div class="row">
						<div class="col-sm-12" id="getFeedback"></div>
					</div>
					<button class="btn btn-md" type="button" id="ownerfeedbackBtn">확인</button>
					<button class="btn btn-md" type="reset">취소</button>
				</form>
			</div>
		  </div>
		</div><!-- end modal -->
	<c:import url="Footer.jsp"></c:import>
		
</body>
</html>