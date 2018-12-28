package bitcamp.travelmaker.mypage.dto;

import java.sql.Date;

public class PlanDTO {
	private int p_Num;
	private String m_Email;
	private Date p_Sdate;
	private Date p_Edate;
	private String p_Content;
	private int g_Num;
	

	
	
	@Override
	public String toString() {
		return "PlanDTO [p_Num=" + p_Num + ", m_Email=" + m_Email + ", p_Sdate=" + p_Sdate + ", p_Edate=" + p_Edate
				+ ", p_Content=" + p_Content + ", g_Num=" + g_Num + "]";
	}
	public int getG_Num() {
		return g_Num;
	}
	public void setG_Num(int g_Num) {
		this.g_Num = g_Num;
	}
	public int getP_Num() {
		return p_Num;
	}
	public void setP_Num(int p_Num) {
		this.p_Num = p_Num;
	}
	public String getM_Email() {
		return m_Email;
	}
	public void setM_Email(String m_Email) {
		this.m_Email = m_Email;
	}
	public Date getP_Sdate() {
		return p_Sdate;
	}
	public void setP_Sdate(Date p_Sdate) {
		this.p_Sdate = p_Sdate;
	}
	public Date getP_Edate() {
		return p_Edate;
	}
	public void setP_Edate(Date p_Edate) {
		this.p_Edate = p_Edate;
	}
	public String getP_Content() {
		return p_Content;
	}
	public void setP_Content(String p_Content) {
		this.p_Content = p_Content;
	}
	
}
