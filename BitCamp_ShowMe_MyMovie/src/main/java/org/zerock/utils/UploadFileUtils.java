package org.zerock.utils;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.apache.commons.io.IOUtils;
import org.imgscalr.Scalr;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;

import lombok.Data;
import lombok.extern.log4j.Log4j;

@Log4j
@Data
public class UploadFileUtils {

	// 파일저장경로내에 날짜별 파일 업로드 경로 설정
	public static String calcPath(String uploadPath) {
		Calendar cal = Calendar.getInstance();
		String yearPath = File.separator + cal.get(Calendar.YEAR);
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);

		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));

		makeDir(uploadPath, yearPath, monthPath, datePath);

		log.info(datePath);

		return datePath;
	}
	
	// 경로에 폴더 생성 
	private static void makeDir(String uploadPath, String... paths) {

		if (new File(uploadPath + paths[paths.length - 1]).exists()) {
			return;
		}
		for (String path : paths) {
			File dirPath = new File(uploadPath + path);
			if (!dirPath.exists()) {
				dirPath.mkdir();
			}
		}
	}
	
	// 썸네일 만들어주는 메소
	private static String makeThumbnail(String uploadPath, String path, String fileName) throws Exception {

		BufferedImage sourceImg = ImageIO.read(new File(uploadPath + path, fileName));

		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);

		String thumbnailName = uploadPath + path + File.separator + "s_" + fileName;

		File newFile = new File(thumbnailName);
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

		ImageIO.write(destImg, formatName.toUpperCase(), newFile);
		return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}

	// 파일저장경로, 원본파일이름, 파일데이터를 파라미터로
	public static String uploadFile(String uploadPath, String originalName, byte[] fileData) 
			throws Exception {

		UUID uid = UUID.randomUUID();

		String savedName = uid.toString() + "_" + originalName;

		String savedPath = calcPath(uploadPath);

		File target = new File(uploadPath + savedPath, savedName);

		FileCopyUtils.copy(fileData, target);

		String formatName = originalName.substring(originalName.lastIndexOf(".") + 1);

		String uploadedFileName = null;

		if (MediaUtils.getMediaType(formatName) != null) {
			uploadedFileName = makeThumbnail(uploadPath, savedPath, savedName);
		} else {
			uploadedFileName = makeIcon(uploadPath, savedPath, savedName);
		}

		return uploadedFileName;

	}
	
	// 경로를 처리하는 문자열의 치환 
	private static String makeIcon(String uploadPath, String path, String fileName) throws Exception {
		String iconName = uploadPath + path + File.separator + fileName;
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
	
	// 파일 삭제 시 실제 경로에 가서 파일삭제 
	public static void deleteFile(String uploadPath, String[] deleteFiles)throws Exception {			
		
		// 썸네일 이름이 붙은 uuid+s_+폴더경로 + 파일이름 
		for(int i=0; i < deleteFiles.length; i ++) {
			File target = new File(uploadPath+deleteFiles[i]);
			if(target.exists()) {
				target.delete();
			}
			// 썸네일 이름이 안붙은 uuid+폴더경로+파일이름
			if(deleteFiles[i].contains("s_")) {
				String path = deleteFiles[i].substring(0, deleteFiles[i].indexOf("s_"));
				String fileName = deleteFiles[i].substring(deleteFiles[i].indexOf("s_")+2);
				File target2 = new File(uploadPath+path+fileName);
				if(target2.exists()) {
					target2.delete();
				}
			}
		}	
	}
	
	public static ResponseEntity<byte[]> display(String fileName, 
			String spath,String photoupload, String upload)throws IOException {
		
		InputStream in = null;
	    ResponseEntity<byte[]> entity = null;
	    String photoUploadPath = photoupload;
	    String uploadPath = upload;
	    try {
	        String formatName = fileName.substring(fileName.lastIndexOf(".")+1); // 확장
	        MediaType mType = MediaUtils.getMediaType(formatName);
	        HttpHeaders headers = new HttpHeaders();

	        if(spath.equalsIgnoreCase("/displayFile")) {

	            if(fileName.contains("img")) {
	                in = new FileInputStream(photoUploadPath + fileName);
	            }else {
	                in = new FileInputStream(uploadPath + fileName); // 풀 경로
	            }
	        }else if(spath.equalsIgnoreCase("/displayImage")) {
	                if(fileName.contains("img")) {
	                String[] str = fileName.split("s_");
	                String add = str[0] + str[1];
	                in = new FileInputStream(photoUploadPath + add);
	            }

	        }

	        if(mType != null) {
	                headers.setContentType(mType);
	            }else {
	                fileName = fileName.substring(fileName.indexOf("_")+1); // 순수한 파일이름
	                headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
	                headers.add("Content-Disposition", "attachment; filename=\""+
	                        new String(fileName.getBytes("UTF-8"), "ISO-8859-1")+"\"");
	        }

	            entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), // 파일을 담는다 엔티티
	                    headers, HttpStatus.CREATED);
	        }catch(Exception e) {
	            e.printStackTrace();
	            entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
	        }finally {
	            in.close();
	        }
	        return entity;
	}

	
}
