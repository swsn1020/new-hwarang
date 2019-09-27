console.log("관심모듈켜짐");

var favService = (function() {
	//관심 등록 로직
	function add(fav, callback, error) {
		console.log(fav.exh_seq+"추가중");
		$.ajax({
			type : 'post',
			url: "/exhibition/addFavorite",
			data : JSON.stringify(fav),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					console.log("add success");
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					console.log("add error");
					error(er);
				}
			}
	
		});
	}
	//관심 삭제 로직
	function remove(fav, callback, error) {
		$.ajax({
			type : 'delete',
			url : '/exhibition/removeFavorite',
			data : JSON.stringify(fav),
			contentType : "application/json; charset=utf-8",
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
	
	return {
		add : add,
		remove : remove,
		update : update
	};
})();