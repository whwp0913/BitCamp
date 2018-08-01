package org.zerock.utils;

import java.util.ArrayList;
import java.util.List;

import org.apache.mahout.cf.taste.common.TasteException;
import org.apache.mahout.cf.taste.impl.common.LongPrimitiveIterator;
import org.apache.mahout.cf.taste.impl.model.jdbc.ConnectionPoolDataSource;
import org.apache.mahout.cf.taste.impl.model.jdbc.MySQLJDBCDataModel;
import org.apache.mahout.cf.taste.impl.model.jdbc.ReloadFromJDBCDataModel;
import org.apache.mahout.cf.taste.impl.recommender.GenericItemBasedRecommender;
import org.apache.mahout.cf.taste.impl.similarity.TanimotoCoefficientSimilarity;
import org.apache.mahout.cf.taste.model.DataModel;
import org.apache.mahout.cf.taste.recommender.RecommendedItem;
import org.apache.mahout.cf.taste.similarity.ItemSimilarity;
import org.springframework.stereotype.Service;
import org.zerock.domain.IRecomVO;

import com.zaxxer.hikari.HikariDataSource;

import lombok.Data;

@Service
@Data
public class RecommendSystem {

	public static List<IRecomVO> startRecommend(HikariDataSource hd) throws TasteException {

		List<IRecomVO> recomList = new ArrayList<>();

		DataModel model = new ReloadFromJDBCDataModel(
				new MySQLJDBCDataModel(new ConnectionPoolDataSource(hd), "t_review", "mno", "code", "rating", null));

		ItemSimilarity similarity = new TanimotoCoefficientSimilarity(model);

		GenericItemBasedRecommender recommender = new GenericItemBasedRecommender(model, similarity);

		// Item IDs
		List<Long> arr = new ArrayList<>();
		LongPrimitiveIterator iter = model.getItemIDs();

		while (iter.hasNext()) {
			arr.add(iter.next());
		}

		for (int i = 0; i < 1; i++) {

			List<RecommendedItem> recommendations = recommender.mostSimilarItems(arr.get(i), 5);

			if (recommendations.size() > 0) {

				for (RecommendedItem recommendation : recommendations) {
					IRecomVO vo = new IRecomVO();
					vo.setTitle(arr.get(i));
					vo.setRtitle(recommendation.getItemID());
					vo.setValue(recommendation.getValue());
					recomList.add(vo);
				}

			} else {
				System.out.println("연관성이 없습니다..!");
			}
		}
		return recomList;
	}

}
