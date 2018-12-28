package bitcamp.travelmaker.dto;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class MemberDTO {
	private String m_Email;
	private String m_Email2;
	private String m_Nickname;
	private String a_Code;
	private String m_Pwd;
	private String m_Image;
	private Date m_Regdate;
	private String m_Gender;
	private int m_Social;
	private int f_Status;
	private int count;
	private int m01;
	private int m02;
	private int m03;
	private int m04;
	private int m05;
	private int m06;
	private int m07;
	private int m08;
	private int m09;
	private int m10;
	private int m11;
	private int m12;

	@Override
	public String toString() {
		return "MemberDTO [m_Email=" + m_Email + ", m_Email2=" + m_Email2 + ", m_Nickname=" + m_Nickname + ", a_Code="
				+ a_Code + ", m_Pwd=" + m_Pwd + ", m_Image=" + m_Image + ", m_Regdate=" + m_Regdate + ", m_Gender="
				+ m_Gender + ", m_Social=" + m_Social + ", f_Status=" + f_Status + ", count=" + count + ", m01=" + m01
				+ ", m02=" + m02 + ", m03=" + m03 + ", m04=" + m04 + ", m05=" + m05 + ", m06=" + m06 + ", m07=" + m07
				+ ", m08=" + m08 + ", m09=" + m09 + ", m10=" + m10 + ", m11=" + m11 + ", m12=" + m12 + ", file=" + file
				+ "]";
	}

	public int getM01() {
		return m01;
	}

	public void setM01(int m01) {
		this.m01 = m01;
	}

	public int getM02() {
		return m02;
	}

	public void setM02(int m02) {
		this.m02 = m02;
	}

	public int getM03() {
		return m03;
	}

	public void setM03(int m03) {
		this.m03 = m03;
	}

	public int getM04() {
		return m04;
	}

	public void setM04(int m04) {
		this.m04 = m04;
	}

	public int getM05() {
		return m05;
	}

	public void setM05(int m05) {
		this.m05 = m05;
	}

	public int getM06() {
		return m06;
	}

	public void setM06(int m06) {
		this.m06 = m06;
	}

	public int getM07() {
		return m07;
	}

	public void setM07(int m07) {
		this.m07 = m07;
	}

	public int getM08() {
		return m08;
	}

	public void setM08(int m08) {
		this.m08 = m08;
	}

	public int getM09() {
		return m09;
	}

	public void setM09(int m09) {
		this.m09 = m09;
	}

	public int getM10() {
		return m10;
	}

	public void setM10(int m10) {
		this.m10 = m10;
	}

	public int getM11() {
		return m11;
	}

	public void setM11(int m11) {
		this.m11 = m11;
	}

	public int getM12() {
		return m12;
	}

	public void setM12(int m12) {
		this.m12 = m12;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getF_Status() {
		return f_Status;
	}

	public void setF_Status(int f_Status) {
		this.f_Status = f_Status;
	}

	public String getM_Email2() {
		return m_Email2;
	}

	public void setM_Email2(String m_Email2) {
		this.m_Email2 = m_Email2;
	}

	public int getM_Social() {
		return m_Social;
	}

	public void setM_Social(int m_Social) {
		this.m_Social = m_Social;
	}

	public String getM_Email() {
		return m_Email;
	}

	public void setM_Email(String m_Email) {
		this.m_Email = m_Email;
	}

	public String getM_Nickname() {
		return m_Nickname;
	}

	public void setM_Nickname(String m_Nickname) {
		this.m_Nickname = m_Nickname;
	}

	public String getA_Code() {
		return a_Code;
	}

	public void setA_Code(String a_Code) {
		this.a_Code = a_Code;
	}

	public String getM_Pwd() {
		return m_Pwd;
	}

	public void setM_Pwd(String m_Pwd) {
		this.m_Pwd = m_Pwd;
	}

	public String getM_Image() {
		return m_Image;
	}

	public void setM_Image(String m_Image) {
		this.m_Image = m_Image;
	}

	public Date getM_Regdate() {
		return m_Regdate;
	}

	public void setM_Regdate(Date m_Regdate) {
		this.m_Regdate = m_Regdate;
	}

	public String getM_Gender() {
		return m_Gender;
	}

	public void setM_Gender(String m_Gender) {
		this.m_Gender = m_Gender;
	}

	public void setFile(CommonsMultipartFile file) {
		this.file = file;
	}

	private CommonsMultipartFile file;

	public CommonsMultipartFile getFile() {
		return file;
	}
}
