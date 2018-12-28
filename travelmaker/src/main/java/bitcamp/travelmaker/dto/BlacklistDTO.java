package bitcamp.travelmaker.dto;

public class BlacklistDTO {

	private int b_Num;
	private String m_Email;
	private String b_Reason;
	
	
	@Override
	public String toString() {
		return "BlacklistDTO [b_Num=" + b_Num + ", m_Email=" + m_Email + ", b_Reason=" + b_Reason + "]";
	}
	
	
	public int getB_Num() {
		return b_Num;
	}
	public void setB_Num(int b_Num) {
		this.b_Num = b_Num;
	}
	public String getM_Email() {
		return m_Email;
	}
	public void setM_Email(String m_Email) {
		this.m_Email = m_Email;
	}
	public String getB_Reason() {
		return b_Reason;
	}
	public void setB_Reason(String b_Reason) {
		this.b_Reason = b_Reason;
	}
	
	
}
