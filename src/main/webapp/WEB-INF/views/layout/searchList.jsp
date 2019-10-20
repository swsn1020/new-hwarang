<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!DOCTYPE html>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link
	href="https://fonts.googleapis.com/css?family=Raleway:400,500,500i,700,800i"
	rel="stylesheet">
<title>검색리스트</title>
<%@ include file="../layout/menu.jsp"%>
<%@include file="../layout/rightUser.jsp"%>
<div class="container bootstrap snippet" style="padding: 0 10% 0 10%;">
	<div class="row">
		<div class="col-lg-12">
			<div class="ibox float-e-margins">
				<div class="ibox-content">

					<div class="hr-line-dashed"></div>
					<div class="search-result">
						<c:forEach items="${reviewboard}" var="rboard">
							<fmt:formatDate value="${rboard.review_reg_date}" var="regDate"
								pattern="yyyy-MM-dd" />
							<tr>
								<td>
									<h3>
									 <a
											href="/review/view?num=${rboard.review_num}">${rboard.review_title}
											<span class="badge bg-teal"><i class="fa fa-comment-o"></i>${rboard.reply_count}</span>
										</a>
									</h3>
								</td>
								<td>${rboard.review_num}</td>
								<td>[게시판] :  후기게시판 </td>
								<td>${rboard.member_id}</td>
								<td>${rboard.review_content}</td>
								<td>${regDate}</td>
								<td>${rboard.review_read_count}</td>
							</tr>
						</c:forEach>
					</div>

					<div class="hr-line-dashed"></div>
					<div class="search-result">
						<c:forEach items="${freeboard}" var="fboard">
							<fmt:formatDate value="${fboard.regDate }" var="regDate"
								pattern="yyyy-MM-dd" />
							<tr>
								<td>
									<h3>
										 <a href="/board/freeboardView?num=${fboard.num}">${fboard.title}
											<span class="badge bg-teal"><i class="fa fa-comment-o"></i>${fboard.replyCount}</span>
										</a>
									</h3>
								</td>
								<td>${fboard.num} </td>
								<td>[게시판] :  자유게시판 </td>
								<td>${fboard.userid}</td>
								<td>${fboard.content}</td>
								<td>${regDate}</td>
								<td>${fboard.readCount}</td>
							</tr>
						</c:forEach>

					</div>
					<div class="hr-line-dashed"></div>
					<div class="search-result">
						<c:forEach items="${recommendboard}" var="reboard">
							<fmt:formatDate value="${reboard.recomm_reg_date }" var="regDate" pattern="yyyy-MM-dd" />
							<tr>
								<td>
									<h3>
										 <a href="/recommend/view?num=${reboard.recomm_num}">${reboard.recomm_title}
											<span class="badge bg-teal"><i class="fa fa-comment-o"></i>${reboard.reply_count}</span>
										</a>
									</h3>
								</td>
								<td>${reboard.recomm_num} </td>
								<td>[게시판] : 추천게시판 </td>
								<td>${reboard.member_id}</td>
								<td>${reboard.recomm_content}</td>
								<td>${regDate}</td>
								<td>${reboard.recomm_read_count}</td>
							</tr>
						</c:forEach>										
					</div>
					<div class="hr-line-dashed"></div>
					<div class="search-result">
						<c:forEach items="${faqboard}" var="faq">
							<fmt:formatDate value="${faq.regDate }" var="regDate" pattern="yyyy-MM-dd" />
						<tr>							
							<td>${faq.category }</td>
								<td>
									<div id="accordion">
										<div><a data-toggle="collapse" href="#content${vs.index }">Q.&nbsp;${faq.question }</a></div><br>
											<div id="content${vs.index }" class="collapse"  data-parent="#accordion">A.&nbsp;&nbsp;${faq.answer }</div>
											</div>
							</td>
						</tr>
						</c:forEach>										
					</div>
					
					<div class="hr-line-dashed"></div>
					<div class="search-result">
						<c:forEach items="${noticeboard}" var="notice">
							<fmt:formatDate value="${notice.regDate }" var="regDate" pattern="yyyy-MM-dd" />
							<tr>
								<td>
									<h3>
										 <a href="/notice/noticeView?num=${notice.num}">${notice.title }
											<span class="badge bg-teal"><i class="fa fa-comment-o"></i>${notice.replyCnt}</span>
										</a>
									</h3>
								</td>
								<td>${notice.num}</td>
								<td>[게시판] : 공지사항 </td>
								<td>${regDate}</td>
								<td>${reboard.recomm_read_count}</td>
							</tr>
						</c:forEach>										
					</div>
					
						<div class="search-result">
						<c:forEach items="${exhibition}" var="ex">
							<tr>
								<td>
									<h3>
										<a href="/exhibition/view?seq=${ex.exh_seq}">${ex.exh_title}</a>
									</h3>
								</td>
								<td>${reboard.recomm_num} </td>
								<td>공연·전시</td>
								<td>
									<p class="card-text">${fn:substring(ex.exh_startDate, 0, 10)} ~ ${fn:substring(ex.exh_endDate, 0, 10)}<br>${ex.exh_area}&nbsp;/&nbsp;${ex.exh_place}</p>
								</td>
								<td>${reboard.member_id}</td>
								<td>${reboard.recomm_content}</td>
								<td>${regDate}</td>
								<td>${reboard.recomm_read_count}</td>
							</tr>
						</c:forEach>										
					</div>
				</div>
			</div>
		</div>
		<ul class="pagination justify-content-center">
			<li class='${pageMaker.prev == true ? "page-item ":"page-item disabled"}'><a class="page-link" href="searchList?pageNum=${pageMaker.startPage -1}&type=${param.type}&key=${param.key}">이전</a></li>
			<c:forEach var="num" begin="${pageMaker.startPage}"
				end="${pageMaker.endPage}">
				<li class='${pageMaker.cri.pageNum == num ? "page-item active" : "page-item"}'>
					<a class="page-link" href="searchList?pageNum=${num}&type=${param.type}&key=${param.key}">[${num}]</a>
				</li>
			</c:forEach>
			<li class=' ${pageMaker.next == true ? "page-item":"page-item disabled"}'><a class="page-link" href="searchList?pageNum=${pageMaker.endPage +1}&type=${param.type}&key=${param.key}">다음</a>
			</li>
		</ul>
	</div>
	<%@include file="../layout/bottom.jsp"%>