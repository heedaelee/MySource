package bitcamp.travelmaker.gowith.controller;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import bitcamp.travelmaker.gowith.dto.GowithDTO;
import bitcamp.travelmaker.gowith.service.GowithService;

@Controller
public class UploadController {
	
	
	@Autowired
	private GowithService gowithService;

		
		@RequestMapping(value="gowith_upload.htm", method = RequestMethod.POST)
		public String gowith_upload(MultipartHttpServletRequest request,GowithDTO gowithDTO) throws Exception {
			
			System.out.println(gowithDTO.toString());
			
			gowithService.insertGowith(request, gowithDTO);
			
			return "redirect:gowith_list.htm";
		}
		
	
		
		
}
