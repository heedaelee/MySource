package bitcamp.travelmaker.reviewpage.dto;

import java.sql.Date;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class TravelDTO {
	private int t_Num;
	private String m_Image;
	private String m_Nickname;
	private String m_Email;
	private String t_Title;
	private String t_Content;
	private String t_Country;
	private String t_Local;
	private Double t_Longitude;
	private Double t_Latitude;
	private Date t_Regdate;
	private int t_Status;
	private String t_Image;
	private int t_Hit;
	private int recount;
	private int m_Social;
	private String country;

	
	public String getCountry() {
		return country;
	}


	public void setCountry(String country) {
		this.country = country;
	}


	public int getM_Social() {
		return m_Social;
	}


	public void setM_Social(int m_Social) {
		this.m_Social = m_Social;
	}


	public int getRecount() {
		return recount;
	}


	public void setRecount(int recount) {
		this.recount = recount;
	}


	public void setFile(CommonsMultipartFile file) {
		this.file = file;
	}
	private CommonsMultipartFile file;
	public CommonsMultipartFile getFile() {
		return file;
	}
	

	public String getM_Image() {
		return m_Image;
	}

	public void setM_Image(String m_Image) {
		this.m_Image = m_Image;
	}


	public String getM_Nickname() {
		return m_Nickname;
	}



	public void setM_Nickname(String m_Nickname) {
		this.m_Nickname = m_Nickname;
	}



	public String getT_Image() {
		return t_Image;
	}



	public void setT_Image(String t_Image) {
		this.t_Image = t_Image;
	}



	public int getT_Hit() {
		return t_Hit;
	}


	public void setT_Hit(int t_Hit) {
		this.t_Hit = t_Hit;
	}

	
	public int getT_Num() {
		return t_Num;
	}
	public void setT_Num(int t_Num) {
		this.t_Num = t_Num;
	}
	public String getM_Email() {
		return m_Email;
	}
	public void setM_Email(String m_Email) {
		this.m_Email = m_Email;
	}
	public String getT_Title() {
		return t_Title;
	}
	public void setT_Title(String t_Title) {
		this.t_Title = t_Title;
	}
	public String getT_Content() {
		return t_Content;
	}
	public void setT_Content(String t_Content) {
		this.t_Content = t_Content;
	}
	public String getT_Country() {
		return t_Country;
	}
	public void setT_Country(String t_Country) {
		this.t_Country = t_Country;
	}
	public String getT_Local() {
		return t_Local;
	}
	public void setT_Local(String t_Local) {
		this.t_Local = t_Local;
	}
	public Double getT_Longitude() {
		return t_Longitude;
	}
	public void setT_Longitude(Double t_Longitude) {
		this.t_Longitude = t_Longitude;
	}
	public Double getT_Latitude() {
		return t_Latitude;
	}
	public void setT_Latitude(Double t_Latitude) {
		this.t_Latitude = t_Latitude;
	}
	public Date getT_Regdate() {
		return t_Regdate;
	}
	public void setT_Regdate(Date t_Regdate) {
		this.t_Regdate = t_Regdate;
	}
	public int getT_Status() {
		return t_Status;
	}
	public void setT_Status(int t_Status) {
		this.t_Status = t_Status;
	}


	@Override
	public String toString() {
		return "TravelDTO [t_Num=" + t_Num + ", m_Image=" + m_Image + ", m_Nickname=" + m_Nickname + ", m_Email="
				+ m_Email + ", t_Title=" + t_Title + ", t_Content=" + t_Content + ", t_Country=" + t_Country
				+ ", t_Local=" + t_Local + ", t_Longitude=" + t_Longitude + ", t_Latitude=" + t_Latitude
				+ ", t_Regdate=" + t_Regdate + ", t_Status=" + t_Status + ", t_Image=" + t_Image + ", t_Hit=" + t_Hit
				+ ", recount=" + recount + ", m_Social=" + m_Social + ", country=" + country + ", file=" + file + "]";
	}



	

}
