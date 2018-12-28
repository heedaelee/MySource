package bitcamp.travelmaker.paging;

//1. PagingVo
public class PagingVo {
  
  private int pageCnt;          // 출력할 페이지번호 갯수(=블락)
  private int index;            // 출력할 페이지번호
  private int pageStartNum;    // 출력할 페이지 시작 번호
  private int listCnt;          // 한페이지 출력할 리스트 갯수
  private int total;            // 게시판 전체 리스트 총 갯수    
  
  ///검색
  private String searchFiled;  //검색 조건
  private String searchValue;  //검색어

  
  
  {
      pageCnt = 5;
      index = 0;//초기화
      pageStartNum = 1;
      listCnt = 6;
  }
  
  public PagingVo() {}
  
  //start last mapper에 던진다
  public int getStart() {
      return index*listCnt+1;
  }
  public int getLast() {
      return (index*listCnt)+listCnt;
  }
  public int getPageLastNum() {
      int remainListCnt = total-listCnt*(pageStartNum-1);
      int remainPageCnt = remainListCnt/listCnt;
      if(remainListCnt%listCnt != 0) {
          remainPageCnt++;
      }
      int pageLastNum = 0;
      if(remainListCnt <= listCnt) {
          pageLastNum = pageStartNum;
      }else if(remainPageCnt <= pageCnt) {
          pageLastNum = remainPageCnt+pageStartNum-1;
      }else {
          pageLastNum = pageCnt+pageStartNum-1;
      }
      return pageLastNum;
  }
  public boolean getLastChk() {
      int n = (int)Math.ceil((double)total/listCnt);
      return getPageLastNum()==n ? false : n==0 ? false : true;
  } //다음 페이지 버튼이 필요한지 아닌지
  
  public int getPageCnt() {
      return pageCnt;
  }
  public void setPageCnt(int pageCnt) {
      this.pageCnt = pageCnt;
  }
  public int getIndex() {
      return index;
  }
  public void setIndex(int index) {
      this.index = index;
  }
  public int getPageStartNum() {
      return pageStartNum;
  }
  public void setPageStartNum(int pageStartNum) {
      this.pageStartNum = pageStartNum;
  }
  public int getListCnt() {
      return listCnt;
  }
  public void setListCnt(int listCnt) {
      this.listCnt = listCnt;
  }
  public int getTotal() {
      return total;
  }
  public void setTotal(int total) {
      this.total = total;
  }
  
  
  public String getSearchFiled() {
	return searchFiled;
}

public void setSearchFiled(String searchFiled) {
	this.searchFiled = searchFiled;
}

public String getSearchValue() {
	return searchValue;
}

public void setSearchValue(String searchValue) {
	this.searchValue = searchValue;
}

@Override
public String toString() {
	return "PagingVo [pageCnt=" + pageCnt + ", index=" + index + ", pageStartNum=" + pageStartNum + ", listCnt="
			+ listCnt + ", total=" + total + ", searchFiled=" + searchFiled + ", searchValue=" + searchValue + "]";
}


}
