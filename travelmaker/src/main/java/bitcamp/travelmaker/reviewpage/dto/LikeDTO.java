package bitcamp.travelmaker.reviewpage.dto;

public class LikeDTO {
	private int l_Num;
	private String m_Email;
	private int t_Num;
	
	
	
	@Override
	public String toString() {
		return "LikeDTO [l_Num=" + l_Num + ", m_Email=" + m_Email + ", t_Num=" + t_Num + "]";
	}
	public int getL_Num() {
		return l_Num;
	}
	public void setL_Num(int l_Num) {
		this.l_Num = l_Num;
	}
	public String getM_Email() {
		return m_Email;
	}
	public void setM_Email(String m_Email) {
		this.m_Email = m_Email;
	}
	public int getT_Num() {
		return t_Num;
	}
	public void setT_Num(int t_Num) {
		this.t_Num = t_Num;
	}
	
	
}
