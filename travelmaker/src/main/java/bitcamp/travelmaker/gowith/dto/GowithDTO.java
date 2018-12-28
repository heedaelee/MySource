package bitcamp.travelmaker.gowith.dto;

import java.util.HashMap;
import java.util.List;


public class GowithDTO {
	
	private int g_Num; //참가글번호
	private String m_Email; //이메일
	private String g_Title; //참여글제목
	private String g_Content; //참여글내용
	private String g_Speople;//참여하는사람
	private String g_Epeople; //모집인원
	private String g_Local;//상세지역
	private String g_Local1;//상세지역
	private String g_Longitude;//경도
	private String g_Longitude1;//경도1
	private String g_Latitude;//위도
	private String g_Latitude1;//위도1
	private String g_Plan;//일정
	private String g_Sdate;//일정시작일
	private String g_Edate;//일정종료일
	private String g_Status;//참여상태
	private String g_Regdate;//등록일 
	private String g_Hit;//조회수
	private String g_Gender;//성별
	//닉네임 추가
	private String m_Nickname;//닉네임
	private String m_Image;//프로필 이미지
	private String m_Gender;//글쓴이 성별
	
	//이미지 테이블 why? db에서 조인으로 select해 받아오기 위해
	 
	private String gi_image; //이미지
	private List<String> gi_Images;
	
	//디테일의 신청자 리스트
	private List<HashMap<String, Object>> applist;
	


	
	
	public List<HashMap<String, Object>> getApplist() {
		return applist;
	}

	public void setApplist(List<HashMap<String, Object>> applist) {
		this.applist = applist;
	}

	public List<String> getGi_Images() {
		return gi_Images;
	}

	public void setGi_Images(List<String> gi_Images) {
		this.gi_Images = gi_Images;
	}

	public int getG_Num() {
		return g_Num;
	}

	public void setG_Num(int g_Num) {
		this.g_Num = g_Num;
	}

	public String getM_Email() {
		return m_Email;
	}

	public void setM_Email(String m_Email) {
		this.m_Email = m_Email;
	}

	public String getG_Title() {
		return g_Title;
	}

	public void setG_Title(String g_Title) {
		this.g_Title = g_Title;
	}

	public String getG_Content() {
		return g_Content;
	}

	public void setG_Content(String g_Content) {
		this.g_Content = g_Content;
	}

	public String getG_Speople() {
		return g_Speople;
	}

	public void setG_Speople(String g_Speople) {
		this.g_Speople = g_Speople;
	}

	public String getG_Epeople() {
		return g_Epeople;
	}

	public void setG_Epeople(String g_Epeople) {
		this.g_Epeople = g_Epeople;
	}

	public String getG_Local() {
		return g_Local;
	}

	public void setG_Local(String g_Local) {
		this.g_Local = g_Local;
	}

	public String getG_Local1() {
		return g_Local1;
	}

	public void setG_Local1(String g_Local1) {
		this.g_Local1 = g_Local1;
	}

	public String getG_Longitude() {
		return g_Longitude;
	}

	public void setG_Longitude(String g_Longitude) {
		this.g_Longitude = g_Longitude;
	}

	public String getG_Longitude1() {
		return g_Longitude1;
	}

	public void setG_Longitude1(String g_Longitude1) {
		this.g_Longitude1 = g_Longitude1;
	}

	public String getG_Latitude() {
		return g_Latitude;
	}

	public void setG_Latitude(String g_Latitude) {
		this.g_Latitude = g_Latitude;
	}

	public String getG_Latitude1() {
		return g_Latitude1;
	}

	public void setG_Latitude1(String g_Latitude1) {
		this.g_Latitude1 = g_Latitude1;
	}

	public String getG_Plan() {
		return g_Plan;
	}

	public void setG_Plan(String g_Plan) {
		this.g_Plan = g_Plan;
	}

	public String getG_Sdate() {
		return g_Sdate;
	}

	public void setG_Sdate(String g_Sdate) {
		this.g_Sdate = g_Sdate;
	}

	public String getG_Edate() {
		return g_Edate;
	}

	public void setG_Edate(String g_Edate) {
		this.g_Edate = g_Edate;
	}

	public String getG_Status() {
		return g_Status;
	}

	public void setG_Status(String g_Status) {
		this.g_Status = g_Status;
	}

	public String getG_Regdate() {
		return g_Regdate;
	}

	public void setG_Regdate(String g_Regdate) {
		this.g_Regdate = g_Regdate;
	}

	public String getG_Hit() {
		return g_Hit;
	}

	public void setG_Hit(String g_Hit) {
		this.g_Hit = g_Hit;
	}



	public String getM_Nickname() {
		return m_Nickname;
	}

	public void setM_Nickname(String m_Nickname) {
		this.m_Nickname = m_Nickname;
	}

	public String getGi_image() {
		return gi_image;
	}

	public void setGi_image(String gi_image) {
		this.gi_image = gi_image;
	}
	
	

	public String getG_Gender() {
		return g_Gender;
	}

	public void setG_Gender(String g_Gender) {
		this.g_Gender = g_Gender;
	}
	
	

	public String getM_Image() {
		return m_Image;
	}

	public void setM_Image(String m_Image) {
		this.m_Image = m_Image;
	}

	public String getM_Gender() {
		return m_Gender;
	}

	public void setM_Gender(String m_Gender) {
		this.m_Gender = m_Gender;
	}

	@Override
	public String toString() {
		return "GowithDTO [g_Num=" + g_Num + ", m_Email=" + m_Email + ", g_Title=" + g_Title + ", g_Content="
				+ g_Content + ", g_Speople=" + g_Speople + ", g_Epeople=" + g_Epeople + ", g_Local=" + g_Local
				+ ", g_Local1=" + g_Local1 + ", g_Longitude=" + g_Longitude + ", g_Longitude1=" + g_Longitude1
				+ ", g_Latitude=" + g_Latitude + ", g_Latitude1=" + g_Latitude1 + ", g_Plan=" + g_Plan + ", g_Sdate="
				+ g_Sdate + ", g_Edate=" + g_Edate + ", g_Status=" + g_Status + ", g_Regdate=" + g_Regdate + ", g_Hit="
				+ g_Hit + ", g_Gender=" + g_Gender + ", m_Nickname=" + m_Nickname + ", m_Image=" + m_Image
				+ ", m_Gender=" + m_Gender + ", gi_image=" + gi_image + ", gi_Images=" + gi_Images + ", applist="
				+ applist + "]";
	}

	
	
	
	
}