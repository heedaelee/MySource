package co.kr.rsad;

import java.io.File;
import java.io.FileOutputStream;
import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;



@Controller
public class FileUploadController {
	@RequestMapping(value = "/ajaxUpload.do", method=RequestMethod.GET)
    public void ajaxUpload() {}
	
	//****중요!!!
	//첫번째 메서드는 MultipartHttpServletRequest 객체에 파라미터 여러개 던져오는걸 Iterator로 받고 While돌리는 구조고..
	//두번째 메서드는 MultipartHttpServletRequest 객체에 파라미터 한개 던져오는걸(내부에 여러개) List<MultipartFile> 로 받아서 for each 돌리는 구조이다!!
	
    @RequestMapping(value = "/fileUpload.do", method=RequestMethod.POST)
    public String fileUp(MultipartHttpServletRequest multi) {
        // 저장 경로 설정
    	String path="C:/photo/"; 
        String fileName = ""; // 업로드 되는 파일명
        
        //파일 디렉토리가 없다면..
        File dir = new File(path);
        if(!dir.isDirectory()){
            dir.mkdir();
        }
         
        Iterator<String> files = multi.getFileNames();
        while(files.hasNext()){
            String uploadFile = files.next();
            MultipartFile mFile = multi.getFile(uploadFile);
             fileName = mFile.getOriginalFilename();
            System.out.println("실제 파일 이름 : " +fileName);
            try {
                mFile.transferTo(new File(path+fileName));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "ajaxUpload";
    }
    
    
    @RequestMapping(value = "/MultiUpload.do", method=RequestMethod.POST)
    public String MultifileUp(MultipartHttpServletRequest multi2) {
        // 저장 경로 설정
    	String path="C:/photo/"; 
        String fileName = ""; // 업로드 되는 파일명
        
      //파일 디렉토리가 없다면..
        File dir = new File(path);
        if(!dir.isDirectory()){
            dir.mkdir();
        }
         
        Iterator<String> files = multi2.getFileNames();
        MultipartFile mpf =  multi2.getFile(files.next());
        
        if(mpf == null || mpf.getSize() <= 0) {
			System.out.println("파일용량 x");
        	return "ajaxUpload";
        }
        //다중파일일땐 getFiles('name값') 써서 List<MultipartFile>로 받아야 함
        List<MultipartFile> fileList = multi2.getFiles("file");
		for (MultipartFile filePart : fileList) {
             fileName = filePart.getOriginalFilename(); // 원본 파일 명
            System.out.println("실제 파일 이름 : " +fileName);
            long fileSize = filePart.getSize(); // 파일 사이즈

          if(!fileName.equals("")) { //파일 쓰기
			try {	
				FileOutputStream fs = new FileOutputStream(path+fileName);
				fs.write(filePart.getBytes());
				fs.close();
			}catch (Exception e) {
				e.printStackTrace();
			}
          }
		}
        return "ajaxUpload";
    }
	
}