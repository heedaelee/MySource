package bitcamp.travelmaker.reviewpage.dto;

import java.sql.Date;

public class ReplyDTO {
	private int r_Num;
	private int t_Num;
	private String m_Email;
	private String m_Nickname;
	private String m_Image;
	private int r_Parent;
	private int r_Order;
	private String r_Comment;
	private Date r_Regdate;
	
	
	
	

	@Override
	public String toString() {
		return "ReplyDTO [r_Num=" + r_Num + ", t_Num=" + t_Num + ", m_Email=" + m_Email + ", m_Nickname=" + m_Nickname
				+ ", m_Image=" + m_Image + ", r_Parent=" + r_Parent +  ", r_Order=" + r_Order
				+ ", r_Comment=" + r_Comment + ", r_Regdate=" + r_Regdate + "]";
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
	public int getR_Num() {
		return r_Num;
	}
	public void setR_Num(int r_Num) {
		this.r_Num = r_Num;
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
	public int getR_Parent() {
		return r_Parent;
	}
	public void setR_Parent(int r_Parent) {
		this.r_Parent = r_Parent;
	}
	
	public int getR_Order() {
		return r_Order;
	}
	public void setR_Order(int r_Order) {
		this.r_Order = r_Order;
	}
	public String getR_Comment() {
		return r_Comment;
	}
	public void setR_Comment(String r_Comment) {
		this.r_Comment = r_Comment;
	}
	public Date getR_Regdate() {
		return r_Regdate;
	}
	public void setR_Regdate(Date r_Regdate) {
		this.r_Regdate = r_Regdate;
	}
	
	
}
