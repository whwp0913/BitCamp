package org.zerock.controller;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;


import org.zerock.domain.LocalVO;

public class Proxy {
		
	public String getData(String local) throws Exception {
		
		System.out.println("in...."+local);
		
		List<LocalVO> volist = LocalVO.locals;
		
		if (LocalVO.locals.size() < 1) {
			LocalVO vo = new LocalVO();
			volist = vo.getlocals();
		};
		
		String str = null;
		
		for (int i = 0; i < volist.size(); i++) {
			if(volist.get(i).getLocalName().equals(local)) {
				System.out.println("for in");
				str = "http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getCtprvnMesureSidoLIst?"
						+ "serviceKey=ywuIYRT2BGW%2Bv6G31VEoH6DfQKKlka4hqtGWTu05I03SDdUnXjjgfkQeyHDCi0KYpQ0uiw8qpP%2BXTGsJ33njdA%3D%3D&numOfRows="+ volist.get(i).getLocalcount()
						+ "&pageNo=1&startPage=1&sidoName="+ URLEncoder.encode(volist.get(i).getLocalName(), "UTF-8") +"&searchCondition=DAILY";
				break;
			}
		}
		System.out.println(str);
		URL url = new URL(str); // URL 객체생성
		System.out.println(url);
		InputStream in = url.openStream(); // URL객체로 스트림열기.
		ByteArrayOutputStream bos = new ByteArrayOutputStream(); //스트림을 바이트의 객체로 저장.
		byte[] buffer = new byte[1024*8];// 바이트의 배열로 저장할 배열크기 지정
		
		while(true) {
			int count = in.read(buffer); 
			if(count == -1) {break;}
			bos.write(buffer, 0 , count);
		}
		return bos.toString();
	}
	
//	public static void main(String[] args) throws Exception{
//		Proxy proxy = new Proxy();
//		System.out.println(proxy.getData("서울"));
//	}
	
}