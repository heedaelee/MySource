// 4. Javascript
//submit
function frmPaging() {
	document.getElementById("frmPaging").submit();
}
// 이전 페이지 index
function pagePre(index, pageCnt) { //첫p 번호가 11이고 cnt=5 5개씩 뿌려준다면, 
	if (0 < index - pageCnt) {
		index -= pageCnt; //index =6되니까
		document.getElementById("pageStartNum").value = index; //이전 페이지 누르면 6으로 폼 태그 히든값써줌
		document.getElementById("index").value = index - 1; //그럼 출력할 페이지 번호를 새로 정의된 시작번호 6에서 -1 해주면 이전 페이지 그룹의 번호가 됨=5
		frmPaging();//그러고는 submit함수!
	}
}
// 다음 페이지 index
function pageNext(index, total, listCnt, pageCnt) {//1,11,2,5
	var totalPageCnt = Math.ceil(total / listCnt); //필요한 페이지 카운트 구하고
	var max = Math.ceil(totalPageCnt / pageCnt);//정해진 한 페이지내 출력갯수로 나누기, max는 필요한 페이지 그룹수 
	if (max * pageCnt > index + pageCnt) {//페이지 시작넘버 +한 페이지내 페이지 count가 필요한 그룹x페이지count보다 작다면..(즉 넘어갈 페이지가 있다면)
		index += pageCnt;//한페이지내..cnt page + 시작페이지 해주면 다음페이지 클릭시 나오는 페이지 번호이다.
		document.getElementById("pageStartNum").value = index;//그걸 스타트 넘버에 써줌
		document.getElementById("index").value = index - 1;//출력할 페이지 번호 = 인덱스에 새로운 시작번호 -1이 됨
		frmPaging();
	}
}
// 마지막 페이지 index
function pageLast(index, total, listCnt, pageCnt) {
	var totalPageCnt = Math.ceil(total / listCnt);
	var max = Math.ceil(totalPageCnt / pageCnt);
	while (max * pageCnt > index + pageCnt) {
		index += pageCnt;
	}
	var remainListCnt = total - listCnt * (index - 1);
	var remainPageCnt = Math.floor(remainListCnt / listCnt);
	if (remainListCnt % listCnt != 0) {
		remainPageCnt++;
	}
	var pageLastNum = 0;
	if (remainListCnt <= listCnt) {
		pageLastNum = index;
	} else if (remainPageCnt <= pageCnt) {
		pageLastNum = remainPageCnt + index - 1;
	} else {
		pageLastNum = pageCnt + index - 1;
	}
	document.getElementById("pageStartNum").value = index;
	document.getElementById("index").value = pageLastNum - 1;
	frmPaging();
}
// index 리스트 처리
function pageIndex(pageStartNum) {
	document.getElementById("index").value = pageStartNum - 1;
	frmPaging();
}
// 리스트출력개수 처리
function listCnt() {
	document.getElementById("index").value = 0;
	document.getElementById("pageStartNum").value = 1;
	document.getElementById("listCnt").value = document.getElementById("listCount").value;
	frmPaging();
}
window.onload = function() {
	// 현재번호 active
	var index = document.getElementById("index").value;
	var pageIndex = document.querySelector('.pageIndex'+(Number(index)+1));
	pageIndex.setAttribute("class", "active");
	// 리스트갯수 selected 처리
	$("#listCount > option").each(function () {
		if ($(this).val() == $('#listCnt').val()) {
			$(this).prop("selected", true); //prop(속성,value)
		}
	});
}

//ajax 페이징
var paging = {
        // 기본값 셋팅
        p: {
            index : 0,
            pageStartNum : 1
        },
        // 페이징 생성
        create: function(){
            var htmlTag = '';
            for (var i = paging.p.pageStartNum; i <= paging.p.pageLastNum; i++) {
                htmlTag += '<li class="pageIndex"><span>'+i+'</span></li>';
            }
            $('.index').html(htmlTag);
            
            // 현재 번호 ui
            $('.pageIndex').each(function(){
                if(paging.p.index == $(this).text()-1) {
                    $(this).addClass('active');
                }else {
                    $(this).removeClass('active');
                }
            });
            
            // 이전 페이지 이동 버튼 생성여부
            if(paging.p.pageStartNum != 1) {
                $('.preBtn').html('<li id="pagePreFirst"><span>«</span></li><li id="pagePre"><span>‹</span></li>');
                // 맨 첫 페이지 index
                $('#pagePreFirst').click(function(){
                    var index = paging.p.pageCnt+1;
                    var pageCnt = paging.p.pageCnt;
                    if (0 < index - pageCnt) {
                        index -= pageCnt;
                        paging.p.pageStartNum = index;
                        paging.p.index = index-1;
                        paging.ajax();
                    }
                });
                
                // 이전 페이지 index
                $('#pagePre').click(function(){
                    var index = paging.p.pageStartNum;
                    var pageCnt = paging.p.pageCnt;
                    if (0 < index - pageCnt) {
                        index -= pageCnt;
                        paging.p.pageStartNum = index;
                        paging.p.index = index-1;
                        paging.ajax();
                    }
                });
            }else {
                $('.preBtn').children('li').remove();
            }
            
            // index 리스트 처리
            $('.pageIndex').click(function(){
                var index = Number($(this).find('span').text());
                paging.p.index = index - 1;
                paging.ajax();
            });
            
            // 다음 페이지 이동 버튼 생성여부
            if(paging.p.lastChk) {
                $('.nextBtn').html('<li id="pageNext"><span>›</span></li><li id="pageLast"><span>»</span></li>');
                // 다음 페이지 index
                $('#pageNext').click(function(){
                    var index = paging.p.pageStartNum;
                    var total = paging.p.total;
                    var listCnt = paging.p.listCnt;
                    var pageCnt = paging.p.pageCnt;
                    
                    var totalPageCnt = Math.ceil(total / listCnt);
                    var max = Math.ceil(totalPageCnt / pageCnt);
                    if (max * pageCnt > index + pageCnt) {
                        index += pageCnt;
                        paging.p.pageStartNum = index;
                        paging.p.index = index-1;
                        paging.ajax();
                    }
                });
                // 마지막 페이지 index
                $('#pageLast').click(function(){
                    var index = paging.p.pageStartNum;
                    var total = paging.p.total;
                    var listCnt = paging.p.listCnt;
                    var pageCnt = paging.p.pageCnt;
                    
                    var totalPageCnt = Math.ceil(total / listCnt);
                    var max = Math.ceil(totalPageCnt / pageCnt);
                    while (max * pageCnt > index + pageCnt) {
                        index += pageCnt;
                    }
                    var remainListCnt = total - listCnt * (index - 1);
                    var remainPageCnt = Math.floor(remainListCnt / listCnt);
                    if (remainListCnt % listCnt != 0) {
                        remainPageCnt++;
                    }
                    var pageLastNum = 0;
                    if (remainListCnt <= listCnt) {
                        pageLastNum = index;
                    } else if (remainPageCnt <= pageCnt) {
                        pageLastNum = remainPageCnt + index - 1;
                    } else {
                        pageLastNum = pageCnt + index - 1;
                    }
                    paging.p.pageStartNum = index;
                    paging.p.index = index-1;
                    paging.ajax();
                });
            }else {
                $('.nextBtn').children('li').remove();
            }
        },
        remove : function() {
            $('.preBtn').children('li').remove();
            $('.index').html('1');
            $('.nextBtn').children('li').remove();
        }
};

