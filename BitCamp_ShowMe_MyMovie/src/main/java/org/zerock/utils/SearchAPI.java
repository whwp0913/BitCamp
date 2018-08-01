package org.zerock.utils;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.zerock.domain.SearchResult;

public class SearchAPI {

	public static List<SearchResult> searchMovie(String keyword) {

		List<SearchResult> list = new ArrayList<>();

		String clientId = "lymD0PHGjImLKtyrxgpv";// 애플리케이션 클라이언트 아이디값";
		String clientSecret = "UTYB8hQAKN";// 애플리케이션 클라이언트 시크릿값";
		String display = "20";
		
		try {
			String text = URLEncoder.encode(keyword, "UTF-8");
			String apiURL = "https://openapi.naver.com/v1/search/movie?query=" + text + "&display=" + display; // json 결과
			// String apiURL = "https://openapi.naver.com/v1/search/blog.xml?query="+ text;
			// // xml 결과
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("X-Naver-Client-Id", clientId);
			con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();
			String jsonStr = response.toString();

			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonStr);
			JSONArray array = (JSONArray) jsonObject.get("items");

			for (int i = 0; i < array.size(); i++) {
				SearchResult result = new SearchResult();

				JSONObject object = (JSONObject) array.get(i);

				result.setTitle(object.get("title").toString().replace("<b>", "").replace("</b>", ""));
				result.setLink(object.get("link").toString());
				result.setPubDate(object.get("pubDate").toString());
				result.setDirector(object.get("director").toString().split("\\|")[0]);
				result.setUserRating(object.get("userRating").toString());
				result.setImgSrc(object.get("image").toString());
				result.setUniqueCode(result.getLink().split("=")[1]);
				System.out.println(result.getLink().split("=")[1]);

				list.add(result);

			}

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return list;

	}

}
