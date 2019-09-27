console.log("모듈켜짐");

var replyService = (function() {
	//댓글 등록 로직
	function add(reply, callback, error) {
		console.log("등록중");
		$.ajax({
			type : 'post',
			url: "/exhReplies/new",
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					console.log("add reply..........su");
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					console.log("add reply..........error");
					error(er);
				}
			}
	
		});
	}
	//댓글 리스트 조회 로직
	function getList(param, callback, error) {
		console.log("가져오는중");
		var seq = param.seq;
		var page = param.page || 1;
		$.getJSON("/exhReplies/view/"+seq+"/"+page+".json", function(data) {
			if(callback){
				callback(data);
			}
		}).fail(function(xhr, status, err) {
			if(error){
				error();
			}
		});
	}
	//댓글 삭제 로직
	function remove(reply_num, callback, error) {
		$.ajax({
			type : 'delete',
			url : '/exhReplies/'+reply_num,
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
	//댓글 수정 로직
	function update(reply, callback, error) {
		console.log("UpdateRNO : "+reply.reply_num);
		$.ajax({
			type : 'put',
			url : '/exhReplies/' + reply.reply_num,
			data : JSON.stringify(reply),
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
	//단일 댓글 조회 로직
	function get(rno, callback, error) {
		$.get("/exhReplies/"+reply_num+".json", function(result) {
			if(callback){
				callback(result);
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