package org.zerock.domain;

import lombok.Data;

@Data
public class SearchResult {

	String title;
	String link;
	String pubDate;
	String director;
	String userRating;
	String uniqueCode;
	String imgSrc;
}
