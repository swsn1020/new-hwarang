var fnShare = function () {
	var title		=	$('title:eq(0)').text();
	var caption		=	$('title:eq(0)').text(); //.replace('| 문화포털', '');
	var desc		=	'';
	var link		=	window.location.href;
	var picture		=	window.location.origin + '/images/portal/layout/logo.png';

	//meta 정보
	var og_title		=	$( 'meta[property="og:title"]' ).attr( 'content' );
	var og_caption		=	$( 'meta[property="og:caption"]' ).attr( 'content' );
	var og_desc			=	$( 'meta[property="og:description"]' ).attr( 'content' );
	var og_picture		=	$( 'meta[property="og:image"]' ).attr( 'content' );

	if(og_title != null){
		title = og_title;
	}
	if(og_caption != null){
		caption = og_caption;
	}
	if(og_desc != null){
		desc = og_desc;
	}
	if(og_picture != null){
		picture = og_picture;
	}

	title = $.trim(title.replace(/\"/g, "＂").replace(/'/g, "＇"));
	caption = $.trim(caption.replace(/\"/g, "＂").replace(/'/g, "＇"));
	desc = $.trim(desc.replace(/\"/g, "＂").replace(/'/g, "＇"));
	link = $.trim(link);
	picture = $.trim(picture);

	return {
		title		:	title
		,caption		:	caption
		,desc		:	desc
		,link		:	link
		,picture	:	picture
	};
};

// 페이스북
var shareFacebook = function () {
	var data = fnShare();

	var callbackDomain = 'http://www.culture.go.kr';

	if (callbackDomain == 'http://localhost') {
		alert('localhost에서 공유할 경우 문화포털 메인으로 이동 됩니다.');
		callbackDomain = 'http://www.culture.go.kr';
	}

	var shareImg = $('[name=share_img]').val();
	if(shareImg == null || shareImg == '') {
		shareImg = '/images/portal/layout/logo.png';
	}

	shareImg = 'http://www.culture.go.kr' + shareImg;

	var shareURL	=	'https://www.facebook.com/dialog/feed';
	//shareURL	+=	'?app_id=524531650932414';
	shareURL	+=	'?app_id=1969619309921418';	// facebook 신규키로 변경
	shareURL	+=	'&display=popup';
	shareURL 	+=	'&title='			+	encodeURIComponent(data.title);
	//shareURL	+=	'&caption='			+	encodeURI(data.caption);
	shareURL	+=	'&caption='			+	'www.culture.go.kr';
	shareURL 	+=	'&description='		+	encodeURI(data.desc);
	shareURL	+=	'&link='			+	encodeURIComponent(data.link);
	shareURL	+=	'&picture='			+	encodeURI(data.picture);
	//shareURL	+=	'&picture='			+	shareImg;
	shareURL	+=	'&redirect_uri='	+	encodeURIComponent(callbackDomain + '/facebook/feed/callback.do');

	window.open(shareURL, 'facebookFeed', 'width=640,height=400');
	return false;
};

// 트위터
var shareTwitter = function () {
	var data		=	fnShare();
	// var status	=	(data.link + ' ' + data.caption).substring(0, 140);
	// var shareURL	=	'http://twitter.com/home?status=' + encodeURIComponent(status);

	var shareURL	=	'http://twitter.com/share';
	shareURL	+=	'?url='		+	encodeURIComponent(data.link);
	shareURL	+=	'&text='	+	encodeURIComponent(data.title);

	window.open(shareURL, 'twitterFeed', 'width=600,height=400');
	return false;
};

// 구글
var shareGoogle = function () {
	var data		=	fnShare();
	var shareURL	=	'https://www.google.com/bookmarks/mark?op=add';
	shareURL	+=	'&bkmk='	+	encodeURIComponent(data.link);
	shareURL	+=	'&title='	+	encodeURI(data.title);

	window.open(shareURL);
	return false;
};

// 카카오톡
var shareKakaoTalk = function () {
	var data = fnShare();
	//<![CDATA[
	// // 사용할 앱의 JavaScript 키를 설정해 주세요.
	Kakao.init('4c72a26f9d59d4124eee09a5bd2c3127');
	// // 카카오링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.
	Kakao.Link.createDefaultButton({
		container: '#kakao-link-btn',
		objectType: 'feed',
		content: {
			title: data.title,
			description: data.title,
			imageUrl: data.picture,
			link: {
				mobileWebUrl: encodeURI(data.link),
				webUrl: encodeURI(data.link)
			}
		},
		social: {
			likeCount: 286,
			commentCount: 45,
			sharedCount: 845
		},
		buttons: [{
			title: '웹으로 보기',
			link: {
				mobileWebUrl: encodeURI(data.link),
				webUrl: encodeURI(data.link)
			}
		},
			{
				title: '앱으로 보기',
				link: {
					mobileWebUrl: encodeURI(data.link),
					webUrl: encodeURI(data.link)
				}
			}]
	});
	//]]>
	// var data = fnShare();
	// kakaoTalk.link( kakaoTalk.linkParam(data.link, data.title + ' ' + data.link) );
	// return false;
};

// 카카오스토리
var shareKakaoStoryA = function () {
	var data = fnShare();

	//<![CDATA[
	// 사용할 앱의 JavaScript 키를 설정해 주세요.

	// 스토리 공유 버튼을 생성합니다.
	Kakao.Story.share({
		url: encodeURI(data.link),
		text: data.caption
	});
	//]]>
	// var data = fnShare();
	// kakaoStory.link( kakaoStory.linkParam(data.link, data.title, data.desc, null) );
	// return false;

	// var data = fnShare();
	//
	// Kakao.init('4c72a26f9d59d4124eee09a5bd2c3127');
	//
	// Kakao.Story.share({
	// 	url: encodeURI(data.link),
	// 	text: data.caption+'\n' + data.desc
	// });
};

// blog 스크랩
var shareClipboardData = function () {
	var _href = $(location).attr('href');
	if(window.clipboardData) {
		window.clipboardData.setData('Text', _href);
		alert('복사되었습니다. 블로그나 카페에 Ctrl+V로 붙여 넣기 하세요.');
	} else {
		temp = prompt('Ctrl+C로 복사한 후 블로그나 카페에 Ctrl+V로 붙여 넣기 하세요.', _href);
	}
};