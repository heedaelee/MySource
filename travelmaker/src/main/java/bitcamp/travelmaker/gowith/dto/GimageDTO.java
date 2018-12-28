package bitcamp.travelmaker.gowith.dto;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class GimageDTO {
	
	private int g_num; //참가글번호 -포린 
	private String gi_image; //이미지
	
	public int getG_num() {
		return g_num;
	}
	public void setG_num(int g_num) {
		this.g_num = g_num;
	}
	public String getGi_image() {
		return gi_image;
	}
	public void setGi_image(String gi_image) {
		this.gi_image = gi_image;
	}
	@Override
	public String toString() {
		return "GimageDTO [g_num=" + g_num + ", gi_image=" + gi_image + "]";
	}
	
	
	
	

	
	


	
	

}
