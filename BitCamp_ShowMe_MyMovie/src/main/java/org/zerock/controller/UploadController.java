package org.zerock.controller;

import java.io.IOException;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.utils.UploadFileUtils;

@Controller
public class UploadController {

	@Resource(name = "uploadPath")
	private String uploadPath;
	
	@Resource(name = "photoUploadPath")
	private String photoUploadPath;
	
	@ResponseBody
	@RequestMapping(value="/{path}/upload", 
	produces="application/json; charset=UTF-8",
	method=RequestMethod.POST)	//produces로 mime타입 지정
	public ResponseEntity<String> uploadAjax(@PathVariable("path")String path, MultipartFile file) throws Exception {		
		if(path.equalsIgnoreCase("img")) {
			return new ResponseEntity<>(
					UploadFileUtils.uploadFile(photoUploadPath, path+file.getOriginalFilename(), 
							file.getBytes()),HttpStatus.CREATED);
		}
		return new ResponseEntity<>(
				UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), 
						file.getBytes()),HttpStatus.CREATED);
	}
	
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte []> displayFile(String fileName, HttpServletRequest req)throws IOException {
		String spath = req.getServletPath();
		ResponseEntity<byte[]> entity = 
				UploadFileUtils.display(fileName, spath, photoUploadPath, uploadPath); 
		return entity;
	}
	
	@ResponseBody
	@GetMapping("/displayImage")
	public ResponseEntity<byte []> displayImage(String fileName,HttpServletRequest req)throws IOException{
		String spath = req.getServletPath();
		ResponseEntity<byte[]> entity =
			UploadFileUtils.display(fileName, spath, photoUploadPath, uploadPath);
		return entity;
	}
	
}
