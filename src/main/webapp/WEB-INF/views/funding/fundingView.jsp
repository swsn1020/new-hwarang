<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<title>[화랑펀딩] ${funding.funding_subject}</title>
<%@include file="../layout/menu.jsp"%>
<%@ include file="../layout/rightUser.jsp"%>
<script type="text/javascript">
	//디데이 종료 일자 설정
	var countDownDate = new Date("October 22, 2019 06:00:00").getTime(); 
	//1초마다 갱신되도록 함수 생성,실행 
	var x = setInterval(function() { 
		// 오늘 날짜 등록
		var now = new Date().getTime(); 
		// 종료일자에서 현재일자를 뺀 시간
		var distance = countDownDate - now; 
		// 각 변수에 일, 시, 분, 초를 등록
		var d = Math.floor(distance / (1000 * 60 * 60 * 24)); 
		var h = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)); 
		var m = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60)); 
		var s = Math.floor((distance % (1000 * 60)) / 1000); 
		//id가 d-day인 HTML코드에 내용 삽입 
		document.getElementById("d-day").innerHTML = "펀딩마감 "+ d +"일 " + h + "시간 " + m + "분 " + s + "초 남았습니다."; });
</script>
<script type="text/javascript" src="https://static.wadiz.kr/web/polyfill.js?d7fcfad7"></script>
<script type="text/javascript" src="https://static.wadiz.kr/web/wui.js?1f730a8c"></script>
<script type="text/javascript" src="https://static.wadiz.kr/web/vendor.js?f0fe7adb"></script>
<script type="text/javascript" src="https://static.wadiz.kr/web/sentry.c41833af.js"></script>
<script type="text/javascript" src="https://static.wadiz.kr/web/common.js?c078a748"></script>
<script type="text/javascript" src="https://static.wadiz.kr/web/layout.js?c33e6b15"></script>

<link href="https://cdn.wadiz.kr/resources/static/css/wlayout.css?v=201803151400" rel="stylesheet">
<link href="https://cdn.wadiz.kr/resources/Content/css/campaign/detail.css" rel="stylesheet">
<link rel="stylesheet" href="https://static.wadiz.kr/reward/campaign.572e67d0.css">
<!-- 아래는 추후 정리해야할 스타일시트 -->
<link href="https://cdn.wadiz.kr/resources/static/editor/froala_custom.css?v=20190705" rel="stylesheet">
<link href="https://cdn.wadiz.kr/resources/static/css/wdetail.css?v=20180802" rel="stylesheet">
<link href="https://cdn.wadiz.kr/resources/Content/Site.css" rel="stylesheet">
<script type="text/javascript" src="https://cdn.wadiz.kr/resources/static/js/wMotion.js?v=20190222"></script>

<!-- <body> -->
<div style="padding-left: 15%;padding-right: 15%;">
<div id="page-container">


    <!-- S : MAIN -->
    <div id="container" class="wd-layout-sub-content reward">
      <!-- S : 리워드 헤더 -->
      <div class="reward-header">
        <div class="bg" style="background-color: white;"></div> 
        <p class="title-info"><em>전시회</em> <strong>#${funding.funding_hashtag}</strong> </p>
        <h2 class="title"><a href=fundingList> ${funding.funding_subject}</a></h2>
      </div>
      <div class="reward-body-wrap">
      
        <!-- S : 서브 컨텐트 영역 -->
        <div class="wd-ui-sub-contents">
          <!-- S : 페이지 레이아웃 컨테이너 -->
          <div class="wd-ui-info-wrap">
            <!-- S : 우측 캠페인 관련 정보 -->
            <div class="wd-ui-sub-opener-info" style="padding-top: 0;">
            
              <!-- S : 프로젝트 정보  --> 
              <h3 class="text-hidden">프로젝트 정보</h3>
              <div class="project-state-info">
                <div class="state-box">
                  <p class="remaining-day"><div style="font-size: 20px;" id="d-day"></div>
                  <p class="rate-bar"><em style="width:2952%"></em></p>
                  <p class="achievement-rate"><strong><fmt:formatNumber pattern=".0">${(funding.funding_price/funding.funding_target_amount)*100}</fmt:formatNumber></strong>% 달성</p>
                  <p class="total-amount"><strong>${funding.funding_target_amount}</strong>원  펀딩</p>
                </div>
                  <div class="btn-wrap funding">
                     <a href="/order/orderFundingForm?funding_num=${funding.funding_num}" class="btn btn-outline-info" >펀딩하기</a>
                     <a href="/faq/faqList" class="btn btn-outline-info" >문의</a>
                     <a href="/faq/faqList" class="btn btn-outline-info" >공유하기</a>
                  </div>
                <div class="btn-wrap share">
                  <div id="shareSection" class="share-section">
                    <ul class="share-list" style="margin-top:10px">
                      <li><button class="wz button dense icon-facebook circular" onclick="wadiz.share.facebook();" title="페이스북 공유" style="width:36px;padding:0"></button></li>
                      <li><button class="wz button dense icon-kakao circular" onclick="wadiz.share.kakao();" title="카카오톡 공유" style="width:36px;padding:0"></button></li>
                      <li><button class="wz button dense icon-twitter circular" onclick="wadiz.share.twitter();" title="트위터 공유" style="width:36px;padding:0"></button></li>
                      <li><button class="wz button dense icon-link circular" onclick="wadiz.share.urlCopy();" title="URL 공유" style="width:36px;padding:0"></button></li>
                    </ul>
                  </div>
                </div>
                
                <div class="banner-section-RB2"></div>
                <p style="color:#4a4a4a;font-size:12px;padding:0 0 15px;"><i class="wadizicon wa-info" style="color:#c88af9;margin-right:5px;" aria-hidden="true"></i>펀딩하기는 쇼핑하기가 아닙니다! 
                <a style="text-decoration:underline" target="_blank" href="">자세히 알아보기</a></p>
              </div>
              <!--E : 프로젝트 정보  -->
              
             
              <!-- S : 메이커 정보  -->
              <div class="project-maker-info">
                <h3 class="project-right-title">메이커 정보</h3>
                <div class="maker-box">
                  <div class="maker-info">
                    <dl>
                      <dt><button onclick="goMakerProfile('824272206');" style="background-image:url(${funding.maker_logo});"></button></dt>
                      <dd>
                        <p class="name"><a href="#" onclick="goMakerProfile('824272206');">${funding.maker_name }</a></p>
                        <ul class="website">
                          <li><a href="${funding.maker_homepage}">${funding.maker_homepage }</a></li>          
                        </ul>
                        <ul class="social">
                          <li><a href="${funding.maker_facebook}" target="_blank" class="facebook" title="Facebook"></a></li>
                          <li><a href="${funding.maker_insta}" target="_blank" class="instagram" title="Instargram"></a></li>
                        </ul>
                      </dd>
                    </dl>
                  </div>
                  <div class="contact-info">
                      <div class="activity-info">
                        <p class="sub-title-answerTime"></p>
                        <p class="sub-content">메이커 평균 응답 시간<strong id="answerTime" class="content-span">1일 이내</strong></p>
                      </div>
                  </div>

                </div>
              </div>
              <!-- E : 메이커 정보  -->

           

              <!-- S : 프로젝트 신고하기 모바일 -->
                <div class="wz-message-box project-report">
                  <p>신고하기란?</p>
                  <p>해당 프로젝트에 허위내용 및 지적재산권을<br>침해하는 내용이 있다면 제보해주세요.</p>
                  <h2><a href="/report/reportList">[프로젝트 신고하기]</a></h2>
                </div>
              <!-- E : 프로젝트 신고하기 -->

              <!-- S : 보상품 목록, 참여할 때 드리는 선물  -->
              <div id="campaign-rewards" style="position: relative; top:-50px"></div>
              <div class="moveRewards">
                <div class="wd-ui-gift">
                  <h3 class="project-right-title">리워드 선택</h3>
                  
                  <button class="rightinfo-reward-list soldout ing" onclick="location.href='/order/orderFundingForm?funding_num=${funding.funding_num}'" >
                  <div class="top-info">
                    <dl class="reward-info">
                      <dt>
                        ${funding.funding_price}원 펀딩
                      </dt>
                      <dd>
                        <p class="reward-name">[슈퍼얼리버드] ${funding.reward_title}</p>
                        <p>[1SET]${funding.reward_title2 } </p>
                      </dd>
                    </dl>
                    
                    <ul class="data-info">
                      <li class="shipping" style="width: 100%; margin-bottom: 5px;">배송비<em>${funding.reward_shippingCost}원</em></li>
                      <li class="date" style="width: 100%;">리워드 발송 시작일
                        <em>${funding.reward_startDay }</em>
                      
                      </li>
                    </ul>
                     
                    <p class="reward-soldcount">총 수량<strong>${funding.reward_Total}</strong>개 펀딩 중</p>
                  </div>
                  </button>
                </div>
              </div>
              <!-- E : 보상품 목록, 참여할 때 드리는 선물 -->
              

              <!-- S : 인기 프로젝트 리스트 -->
              <div id="normalpane" class="recommend-box-container">
                <div id="fixed-funding-btn" class="fixed-funding-btn">
                  <button onclick="backMoney('backing', 'false');" class="wz button primary block">이 프로젝트 펀딩하기</button>
                </div>
                

                <!-- S : 프로젝트 신고하기 -->
                  <div class="wz-message-box project-report">
                    <p class="title">신고하기란?</p>
                    <p>해당 프로젝트에 허위내용 및 지적재산권을<br>침해하는 내용이 있다면 제보해주세요.</p>
                    
                    <button class="wz button block gray dense" onclick="wadiz.requireLogin();" title="Report">프로젝트 신고하기</button>
                  </div>
                <!-- E : 프로젝트 신고하기 -->

                <div class="recommend-box">
                  <h3 class="title">인기 프로젝트</h3>
                  
                  <div class="item">
                    <div class="number">1</div>
                    <div class="text"><a href="/funding/fundingView?funding_num=334">한글날을 위해 태어난 훈민정음 여권케이스</a></div>
                  </div>
                  
                  <div class="item">
                    <div class="number">2</div>
                    <div class="text"><a href="http://localhost:8081/funding/fundingView?funding_num=286">텀블러? 믹서기? 들고 다니는 무선 블랜더 S10!</a></div>
                  </div>
                  
                  <div class="item">
                    <div class="number">3</div>
                    <div class="text"><a href="http://localhost:8081/funding/fundingView?funding_num=307">[슈퍼 얼리버드] 서울숲재즈페스티벌에서 라운드 미드나잇 제주까지</a></div>
                  </div>
                  
                  <div class="item">
                    <div class="number">4</div>
                    <div class="text"><a href="/funding/fundingView?funding_num=327">압도적인 입체감! 리얼하게 만나는 명화 아트패브릭 액자</a></div>
                  </div>
                  
                  <div class="item">
                    <div class="number">5</div>
                    <div class="text"><a href="/funding/fundingView?funding_num=328">서울에 산다면 놓치지 말아야 할 전시, ㅇㅍㅌ [서울풍경]</a></div>
                  </div>
                  
                  <div class="item">
                    <div class="number">6</div>
                    <div class="text"><a href="/funding/fundingView?funding_num=332">유동큰잔치 | 유재하가요제 출신 실력파 뮤지션들의 음악 페스티벌</a></div>
                  </div>
                  
                  <div class="item">
                    <div class="number">7</div>
                    <div class="text"><a href="/funding/fundingView?funding_num=330">한국 최초 여성영화의 장! SIWFF 20주년 여성감독 DVD 콜렉션</a></div>
                  </div>
                  
                  <div class="item">
                    <div class="number">8</div>
                    <div class="text"><a href="/funding/fundingView?funding_num=329">[국립현대미술관소장] 세계를 사로잡은 포토그래퍼 이정록 작품</a></div>
                  </div>
                  
                  <div class="item">
                    <div class="number">9</div>
                    <div class="text"><a href="/funding/fundingView?funding_num=333">책을 읽는 새로운 방법ㅣ작가추천 인생책과 독서모임 초대장을 구독하세요</a></div>
                  </div>
                  
                  <div class="item">
                    <div class="number">10</div>
                    <div class="text"><a href="/funding/fundingView?funding_num=307">견생템 많이 싸도 괜찮아~하루한장 욜로홀로배변패드</a></div>
                  </div>
                  
                </div>
              </div>
              <!-- E : 인기 프로젝트 리스트 -->

             
            </div>
            <!-- E : 우측 캠페인 관련 정보 -->

            <!-- S : 캠페인 정보 -->
            <div class="wd-ui-sub-campaign-info-container">
              <div class="wd-ui-sub-campaign-info">
                <!-- S : 탭 주요 콘텐츠 -->
                <div class="wd-ui-tab-contents">
                  
  <h3 class="text-hidden">프로젝트 스토리</h3>
  <!-- 이미지가 아닌 동영상 URL이 넘어오는 경우 iframe에 동영상을 보여줘야 함 -->

  <div class="view-slide-wrap" style="padding: 0">
      <ul class="view-slide-big">
        <li>
          <div class="video-wrap">
            <div class="video-container" data-video-url="${funding.funding_video}">
              <div class="video-cover icon-movie" data-cover-url="" style="background-image: url(http://www.jeigroup.com/public/images/board/play.png)"></div>
            </div>
          </div>
        </li>
      </ul>
  </div>
  <ul class="view-slide-nav" style="display: none">
    <li>
      <div class="video-wrap" style="position: relative">
        <img class="img-responsive" id="campaignVideoThumbnail" src="" alt=""> <i class="icon_play_sm">Play</i>
      </div>
    </li>
  </ul>

      <br>
      <!-- S : 펀딩 기간, 보상품 제공일 -->
      <div>
        <div style="padding:20px;background:#eafbf7;background:rgba(0, 204, 163, 0.1)">
          <p style="color:#00cca3;font-size:13px;line-height:20px;margin-bottom:10px;"><strong>목표 금액</strong> ${funding.funding_target_amount}원 &nbsp; &nbsp; 
          <strong>펀딩기간</strong> <fmt:formatDate value="${funding.funding_created_date}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${funding.funding_target_date}" pattern="yyyy-MM-dd"/></p>
           
          
          <p style="color:#4a4a4a;font-size:12px;line-height:19px;"><strong>100% 이상 모이면 펀딩이 성공되는 프로젝트</strong><br>
         	 이 프로젝트는 펀딩 마감일까지 목표 금액이 100% 모이지 않으면 결제가 진행되지 않습니다.</p>
        </div>
      </div>
      <!-- E : 펀딩 기간, 보상품 제공일 -->
      
      <br>
      
        <!-- S : HW / HW + SW -->
        <div>
          <div class="wz message value" style="padding:16px;background:rgba(85, 124, 242, 0.08);border:0">
            <p class="title" style="color:#295cf2;font-size:13px;line-height:18px;margin-bottom:4px;font-weight: bold;"><i class="icon info" style="font-size:16px"></i>&nbsp;이 프로젝트는 전시회관람 리워드입니다. </p>
            <ul>
              <li style="font-size:13px;line-height:18px;color:rgba(0, 0, 0, 0.68)">전시회 관람 리워드의 경우 화랑은 프로젝트 오픈 전 심사를 진행하고 있으며, 메이커의 전시 계획,진행도 등을 체크하고 있습니다.</li>
              <li style="font-size:13px;line-height:18px;color:rgba(0, 0, 0, 0.68)">다만, 크라우드펀딩 특성상 대부분 펀딩 종료 후 티켓이 전송됩니다.이에 이슈가 일부 발생할 수 있습니다. </li>
              <li style="font-size:13px;line-height:18px;color:rgba(0, 0, 0, 0.68)">스토리 내 현재 관람리워드 제작 상황에 대해 기재하도록 하고 있으니, 꼼꼼히 읽어주신 후 펀딩에 참여해주시길 바랍니다.</li>
            </ul>
          </div>
        </div>
        <!-- E : HW / HW + SW -->
      
      <br>
      
        <!-- N : 새소식 메인 노출 -->
        <div id="post-container" class="detail-post-container">
          <input id="post-content-visible" class="post-content-visible" type="checkbox">
          <div class="wd-last">
            
              <span class="wz primary mini badge">
               		 새소식
              </span>
            
            <span class="post-date">
            	2019-09-30
            </span>
          </div>
          <p class="post-title">${funding.funding_news}</p>
          <div class="post-content-wrapper">
            <div class="update-inner-contents">
              <p>내용: ${funding.funding_content }<img src="${funding.funding_image}" class="fr-fic fr-dib"></p>
            </div>
          </div>
          <label class="wz block less button btn-toggle" for="post-content-visible">
            <span class="closed">더보기</span>
            <span class="opened">접기</span>
            <i class="icon expand-more"></i>
          </label>
        </div>
      
      <hr class="wz divider large">
      <!-- S : 프로젝트 내용 -->
      <!-- E : 프로젝트 내용 -->
      
    </div>
  </div>
  <!-- E : campaign 컨텐츠 -->

  <div class="banner-section-RB1"></div>

  
  <!-- E : 업데이트 링크 -->
  <input type="hidden" id="movieembed" value="">
</div>

                </div>
                <!-- E : 탭 주요 콘텐츠 -->
              </div>
            </div>
            <!-- E : 캠페인 정보 -->
            <div class="banner-section-RB3"></div>
          </div>
          <!-- E : 페이지 레이아웃 컨테이너 -->
        </div>
        <!-- E : 서브 컨텐트 영역 -->
      </div>
      <!-- S : 공유하기 링크 값  -->
      <input type="text" id="shareLink" readonly="true" style="position: absolute; left: -9999px" 
      value="https://www.wadiz.kr/web/campaign/detail/44452?utm_source=wadiz&utm_medium=copy_url"/>
      <!-- E : 공유하기 링크 값  -->
    </div>
    </div>


<%@include file="../layout/bottom.jsp"%>