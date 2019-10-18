console.log("한줄평모듈켜짐");

var mentionService = (function() {
	//한줄평 등록 로직
	function add(mention, callback, error) {
		console.log("등록중");
		$.ajax({
			type : 'post',
			url: "/exhMention/new",
			data : JSON.stringify(mention),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					console.log("add mention..........su");
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					console.log("add mention..........error");
					error(er);
				}
			}
	
		});
	}
	//한줄평 리스트 조회 로직
	function getList(param, callback, error) {
		console.log("가져오는중");
		var seq = param.seq;
		var page = param.page || 1;
		$.getJSON("/exhMention/view/"+seq+"/"+page+".json", function(data) {
			if(callback){
				callback(data.mentionCnt, data.list);
			}
		}).fail(function(xhr, status, err) {
			if(error){
				error();
			}
		});
	}
	//한줄평 삭제 로직
	function remove(mention_no, callback, error) {
		$.ajax({
			type : 'delete',
			url : '/exhMention/'+mention_no,
			success : function(deleteResult, status, xhr) {
				if(callback){
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if(error){
					error(er);
				}
			}
		});
	}
	//한줄평 수정 로직
	function update(mention, callback, error) {
		console.log("UpdateMNO : "+mention.mention_no);
		$.ajax({
			type : 'put',
			url : '/exhMention/' + mention.mention_no,
			data : JSON.stringify(mention),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error){
					error(er);
				}
			}
		});
	}
	//단일 한줄평 조회 로직
	function get(mention_no, callback, error) {
		$.get("/exhMention/"+mention_no+".json", function(result) {
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status, err) {
			if(error){
				error();
			}
		});
	}

	function getMentionStatus(seq, callback, error) {
		$.getJSON("/exhMention/isEntered/"+seq+".json", function(data) {
			if(callback){
				callback(data);
			}
		}).fail(function(xhr, status, err) {
			if(error){
				error();
			}
		});
	}
	function displayTime(timeValue) {
		var today = new Date();
		var gap = today.getTime() - timeValue;
		var dateObj = new Date(timeValue);
		var str= "";
		
		if(gap < (1000*60*60*24)){
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [(hh > 9 ? '' : '0')+ hh, ':', (mi>9?'':'0')+mi, ':', (ss > 9 ? '':'0')+ ss].join('');
		}else{
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth()+1;
			var dd = dateObj.getDate();
			return [yy, '/', (mm > 9 ? '' : '0')+mm, '/',(dd>9?'':'0') + dd].join('');		
		}
	};
	
	
	return {
		add : add,
		getList : getList,
		remove : remove,
		update : update,
		get : get,
		displayTime : displayTime
	};
})();