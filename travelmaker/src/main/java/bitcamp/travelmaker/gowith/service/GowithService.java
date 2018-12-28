package bitcamp.travelmaker.gowith.service;

import java.io.FileOutputStream;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import bitcamp.travelmaker.gowith.dao.GowithDAO;
import bitcamp.travelmaker.gowith.dto.GowithDTO;
import bitcamp.travelmaker.gowith.dto.go_ReplyDTO;
import bitcamp.travelmaker.mypage.dao.PlanDAO;
import bitcamp.travelmaker.mypage.dto.PlanDTO;
import bitcamp.travelmaker.paging.PagingVo;


@Service
public class GowithService {

	@Autowired
	private SqlSession sqlsession;
	
	
	public List<GowithDTO> selectAllGowith(PagingVo pagingVo) {
		GowithDAO dao = sqlsession.getMapper(GowithDAO.class);
		List<GowithDTO> list = dao.selectAllGowith(pagingVo);
		return list;
	}
	
	public int totalSelect(PagingVo pagingVo) {
		GowithDAO dao = sqlsession.getMapper(GowithDAO.class);
		int totalCount = dao.totalSelect(pagingVo);
		return totalCount;
	}
	
	@Transactional(rollbackFor={Exception.class})
	public int insertGowith(MultipartHttpServletRequest request,GowithDTO gowithDTO) throws Exception{
		int result = 0;
		PlanDTO plandto = new PlanDTO();
		GowithDAO dao = sqlsession.getMapper(GowithDAO.class);
		PlanDAO dao1 = sqlsession.getMapper(PlanDAO.class);
		//보드 쓰기
		plandto.setM_Email(gowithDTO.getM_Email());
		plandto.setP_Content(gowithDTO.getG_Title());
		Date sd = Date.valueOf(gowithDTO.getG_Sdate());
		plandto.setP_Sdate(sd);
		Date ed = Date.valueOf(gowithDTO.getG_Edate());
		plandto.setP_Edate(ed);
		try{
		result = dao.insertGowith(gowithDTO);
		plandto.setG_Num(gowithDTO.getG_Num());
		//플래너 일정 등록
		dao1.planreg(plandto);
		}catch(Exception e) {
			System.out.println("Transaction 예외 발생" + e.getMessage());
			throw e; 
		}
		
		//application 동시 insert
		int g_Num = gowithDTO.getG_Num();
		String m_Email = gowithDTO.getM_Email();
		HashMap<String, Object> map2 = new HashMap<String, Object>();
		map2.put("g_Num", g_Num);
		map2.put("m_Email", m_Email);
		dao.application(map2);
		
		//파일처리
		Iterator<String> itr = request.getFileNames();
		MultipartFile mpf =  request.getFile(itr.next());
		
		if(mpf == null || mpf.getSize() <= 0) {
			System.out.println("파일용량 x");
        	return result;
        }
		
		
		List<MultipartFile> fileList = request.getFiles("file");
		for (MultipartFile filePart : fileList) {
            String originFileName = filePart.getOriginalFilename(); // 원본 파일 명
            long fileSize = filePart.getSize(); // 파일 사이즈

          String path = request.getServletContext().getRealPath("/image/gowith");
          String fpath = path + "\\" + originFileName;
          if(!originFileName.equals("")) { //파일 쓰기
				FileOutputStream fs = new FileOutputStream(fpath);
				fs.write(filePart.getBytes());
				fs.close();
          }
          //사진 쓰기
          
          HashMap<String, Object> map = new HashMap<String, Object>();
          map.put("g_NUM", gowithDTO.getG_Num());
          map.put("gi_IMAGE",originFileName);
          
          dao.insertGimage(map);
		}
		return result;
	}
	
	@Transactional(rollbackFor={Exception.class})
	public int updateGowith(MultipartHttpServletRequest request,GowithDTO gowithDTO) throws Exception{
		int result = 0;
		PlanDTO plandto = new PlanDTO();
		GowithDAO dao = sqlsession.getMapper(GowithDAO.class);
		PlanDAO dao1 = sqlsession.getMapper(PlanDAO.class);
		plandto.setM_Email(gowithDTO.getM_Email());
		plandto.setP_Content(gowithDTO.getG_Title());
		Date sd = Date.valueOf(gowithDTO.getG_Sdate());
		plandto.setP_Sdate(sd);
		Date ed = Date.valueOf(gowithDTO.getG_Edate());
		plandto.setP_Edate(ed);
		plandto.setG_Num(gowithDTO.getG_Num());
		//보드 쓰기
		try{
		result = dao.updateGowith(gowithDTO);
				 dao1.planupdatego(plandto);
		
		}catch(Exception e) {
			System.out.println("Transaction 예외 발생" + e.getMessage());
			throw e; 
		}
		
		
		//파일처리
		Iterator<String> itr = request.getFileNames();
		MultipartFile mpf =  request.getFile(itr.next());

		//파일 재첨부를 안했다면 여기서 null로 받아서 return 됨
		if(mpf == null || mpf.getSize() <= 0) {
			System.out.println("파일용량 x");
        	return result;
        }

		//재첨부 시 기존 이미지 파일 삭제
		int g_Num=gowithDTO.getG_Num();
		dao.deleteGimage(g_Num);
		
		List<MultipartFile> fileList = request.getFiles("file");
		
		for (MultipartFile filePart : fileList) {
            String originFileName = filePart.getOriginalFilename(); // 원본 파일 명
            long fileSize = filePart.getSize(); // 파일 사이즈

          String path = request.getServletContext().getRealPath("/image/gowith");
          String fpath = path + "\\" + originFileName;
          if(!originFileName.equals("")) { //파일 쓰기
				FileOutputStream fs = new FileOutputStream(fpath);
				fs.write(filePart.getBytes());
				fs.close();
          }
          //사진 쓰기
          
          HashMap<String, Object> map = new HashMap<String, Object>();
          map.put("g_NUM", gowithDTO.getG_Num());
          map.put("gi_IMAGE",originFileName);

          dao.insertGimage(map);
		}
		return result;
	}
	
	public GowithDTO selectGowith(int g_Num) {
		
		GowithDAO dao = sqlsession.getMapper(GowithDAO.class);
		
		dao.updateHit(g_Num);//조회수
		GowithDTO gowithDTO=dao.selectGowith(g_Num);//게시물 선택
		List<String> list = dao.selectImg(g_Num); //게시물 따른 사진 선택
		List<HashMap<String, Object>> applist = dao.selectApp(g_Num);
		
		gowithDTO.setGi_Images(list);//사진
		gowithDTO.setApplist(applist);//지원자 리스트
		return gowithDTO;
	}
	
	@Transactional(rollbackFor={Exception.class})
	public void deleteGowith(int g_Num) throws Exception {
		GowithDAO dao = sqlsession.getMapper(GowithDAO.class);
		PlanDAO dao1 = sqlsession.getMapper(PlanDAO.class);
		try {
		dao1.plandelgo(g_Num);
		dao.deleteApp(g_Num);
		dao.deleteGowith(g_Num);
		
		}catch(Exception e) {
			System.out.println("Transaction 예외 발생" + e.getMessage());
			throw e; 
		}
	}
	
	
	
	public List<HashMap<String, Object>> application(int g_Num,String m_Email){
		GowithDAO dao = sqlsession.getMapper(GowithDAO.class);
	
		HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("g_Num", g_Num);
        map.put("m_Email",m_Email);
		 dao.application(map); //참여
		 List<HashMap<String,Object>> appList = dao.selectApp(g_Num); //리스트
		 
		 return appList;
	}
	
	public List<HashMap<String, Object>> appselect(int g_Num){
		GowithDAO dao = sqlsession.getMapper(GowithDAO.class);
		 List<HashMap<String,Object>> appList = dao.selectApp(g_Num); //리스트
		 return appList;
	}
	
	
	public void cancel(int g_num, String m_Email) {
		GowithDAO dao = sqlsession.getMapper(GowithDAO.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("g_Num", g_num);
		map.put("m_Email", m_Email);
		dao.cancel(map);
	}
	
	public String genderCheck(String m_Email) {
		GowithDAO dao = sqlsession.getMapper(GowithDAO.class);
		String m_Gender=""; 
		m_Gender=dao.genderCheck(m_Email);
		return m_Gender;
	}
	
	
	public int replyreg(go_ReplyDTO reply) {
		GowithDAO dao = sqlsession.getMapper(GowithDAO.class);
		int result = dao.replyreg(reply);
		return result;
	}

	public List<go_ReplyDTO> replylist(int g_Num) {
		GowithDAO dao = sqlsession.getMapper(GowithDAO.class);
		List<go_ReplyDTO> reple = dao.replylist(g_Num);
		return reple;
	}
	
	public int rerereg(go_ReplyDTO reply) {
		GowithDAO dao = sqlsession.getMapper(GowithDAO.class);
		int result = dao.rerereg(reply);
		return result;
	}

	public int replyupdate(go_ReplyDTO reply) {
		GowithDAO dao = sqlsession.getMapper(GowithDAO.class);
		int result = dao.replyupdate(reply);
		return result;
	}

	public int replydelete(int j_Num) {
		GowithDAO dao = sqlsession.getMapper(GowithDAO.class);
		int result = dao.replydelete(j_Num);
		return result;
	}
	
	// 마이페이지 글 조회
		public List<GowithDTO> getWithListMypage(String m_EMAIL) {
			GowithDAO dao = sqlsession.getMapper(GowithDAO.class);
			List<GowithDTO> dto = dao.getWithListMypage(m_EMAIL);
			return dto;
		}
		
		// 관리자 회원 글 조회 	
		public List<GowithDTO> getWithListAdmin(String m_EMAIL) {
			GowithDAO dao = sqlsession.getMapper(GowithDAO.class);
			List<GowithDTO> dto = dao.getWithListAdmin(m_EMAIL);
			return dto;
		}

		public List<GowithDTO> getMainGo() {
			GowithDAO dao = sqlsession.getMapper(GowithDAO.class);
			List<GowithDTO> dto = dao.getMainGo();
			return dto;
		}
	
}

