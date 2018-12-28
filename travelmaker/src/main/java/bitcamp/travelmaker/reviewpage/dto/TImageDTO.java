package bitcamp.travelmaker.reviewpage.dto;

import java.util.List;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class TImageDTO {
	private int t_Num;
	private String ti_Image;
	
	
	
	@Override
	public String toString() {
		return "TImageDTO [t_Num=" + t_Num + ", ti_Image=" + ti_Image + ", files=" + files + "]";
	}
	public int getT_Num() {
		return t_Num;
	}
	public void setT_Num(int t_Num) {
		this.t_Num = t_Num;
	}
	public String getTi_Image() {
		return ti_Image;
	}
	public void setTi_Image(String ti_Image) {
		this.ti_Image = ti_Image;
	}
	private List<CommonsMultipartFile> files;
	
	public List<CommonsMultipartFile> getFiles() {
		return files;
	}
	public void setFiles(List<CommonsMultipartFile> files) {
		this.files = files;
	}
	

	
}
