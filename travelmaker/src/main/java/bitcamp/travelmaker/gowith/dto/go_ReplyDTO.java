package bitcamp.travelmaker.gowith.dto;

import java.sql.Date;

public class go_ReplyDTO {
	private int j_Num;
	private String m_Email;
	private int g_Num;
	private int j_Parent;
	private int j_Order;
	private String j_Comment;
	private Date j_Regdate;
	
	private String m_Nickname;
	private String m_Image;
	
	public int getJ_Num() {
		return j_Num;
	}
	public void setJ_Num(int j_Num) {
		this.j_Num = j_Num;
	}
	public String getM_Email() {
		return m_Email;
	}
	public void setM_Email(String m_Email) {
		this.m_Email = m_Email;
	}
	public int getG_Num() {
		return g_Num;
	}
	public void setG_Num(int g_Num) {
		this.g_Num = g_Num;
	}
	public int getJ_Parent() {
		return j_Parent;
	}
	public void setJ_Parent(int j_Parent) {
		this.j_Parent = j_Parent;
	}
	public int getJ_Order() {
		return j_Order;
	}
	public void setJ_Order(int j_Order) {
		this.j_Order = j_Order;
	}
	public String getJ_Comment() {
		return j_Comment;
	}
	public void setJ_Comment(String j_Comment) {
		this.j_Comment = j_Comment;
	}
	public Date getJ_Regdate() {
		return j_Regdate;
	}
	public void setJ_Regdate(Date j_Regdate) {
		this.j_Regdate = j_Regdate;
	}
	public String getM_Nickname() {
		return m_Nickname;
	}
	public void setM_Nickname(String m_Nickname) {
		this.m_Nickname = m_Nickname;
	}
	public String getM_Image() {
		return m_Image;
	}
	public void setM_Image(String m_Image) {
		this.m_Image = m_Image;
	}
	@Override
	public String toString() {
		return "replyDTO [j_Num=" + j_Num + ", m_Email=" + m_Email + ", g_Num=" + g_Num + ", j_Parent=" + j_Parent
				+ ", j_Order=" + j_Order + ", j_Comment=" + j_Comment + ", j_Regdate=" + j_Regdate + ", m_Nickname="
				+ m_Nickname + ", m_Image=" + m_Image + "]";
	}
	
	
	
	
	
}
