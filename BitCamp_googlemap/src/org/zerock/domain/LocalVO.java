package org.zerock.domain;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;

import lombok.Data;

@Data
public class LocalVO {
	private int lno;
	private String localName;
	private int localcount;
	private double lat,lng; 			
	public static List<LocalVO> locals = new ArrayList<>();

	public LocalVO(int lno, String localName, int localcount) {
		super();
		this.lno = lno;
		this.localName = localName;
		this.localcount = localcount;
		
	}
	
	public LocalVO() {
		
	}
	
	
	public List<LocalVO> getlocals() {
		
		String[] localNames = {"서울", "부산", "대구", "인천", "광주", "대전", "울산",
				"경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주"};
		int[] localCount = {25, 16, 8, 10, 5, 5, 5, 31, 18, 11, 15, 14, 22, 23, 18, 2};																		
		for(int i = 0; i < localNames.length; i++) {
			LocalVO vo = new LocalVO(i, localNames[i], localCount[i]);
			try {
				locals.add(getLatLng(vo));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return locals;
	}
			
	public LocalVO getLatLng(LocalVO vo) throws Exception {
		String str = "https://maps.googleapis.com/maps/api/geocode/json?address="+ URLEncoder.encode(vo.getLocalName(), "UTF-8")
		 		+ "&key=AIzaSyCaL3U3tYGUuZfpmAUKJyoCAlHSHdapuqM";
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
		bos.toString();
		 Gson gson = new Gson();
		 GoogleGeoCodeResponse result = gson.fromJson(bos.toString(),GoogleGeoCodeResponse.class);

		    double lat = Double.parseDouble(result.results[0].geometry.location.lat);

		    double lng = Double.parseDouble(result.results[0].geometry.location.lng);
		    vo.setLat(lat);
		    vo.setLng(lng);
		    System.out.println(lat);
		    System.out.println(lng);
		    
		    return vo;
		    
	}
	
	public static void main(String[] args) {
		LocalVO vo = new LocalVO();
		System.out.println(vo.getlocals().toString());
		Gson gson = new Gson();
		String json = gson.toJson(vo.getlocals());
		System.out.println(json);
		
	}
}
 