package com.safefood.util;

import com.safefood.model.domain.Food;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.ClassPathResource;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import java.util.ArrayList;
import java.util.Map;

/**
 * FoodNutritionSAXHandler와 FoodSAXHandler를 이용해서 식품 정보를 load하는 SAX Parser 프로 그램
 *
 */
@Slf4j
public class FoodSaxParser {
	private StringBuilder xml;
	private ArrayList<Food> foods;
	
	public FoodSaxParser() { 
		loadData();
	}

	/**
	 * FoodNutritionSAXHandler와 FoodSAXHandler를 이용 파싱한 식품 정보와 식품 영양 정보를 Food에 병합한다.
	 */
	private void loadData() {
		SAXParserFactory factory = SAXParserFactory.newInstance();
		try {
			ClassPathResource foodResource = new ClassPathResource("xml/foodInfo.xml");
			ClassPathResource foodNResource = new ClassPathResource("xml/FoodNutritionInfo.xml");
			
			SAXParser parser = factory.newSAXParser();
			
			FoodSAXHandler handler = new FoodSAXHandler();
			FoodNutritionSAXHandler nHandler = new FoodNutritionSAXHandler();
			
			parser.parse(foodResource.getInputStream(), handler);
			parser.parse(foodNResource.getInputStream(), nHandler);
			
			Map<String, Food> foodMap = handler.getFoods();
			foods = nHandler.getList();
			Food find;
			for (Food food : foods) {
				find = foodMap.get(food.getName());
				if (find != null) {
					food.setCode(find.getCode());
					food.setName(find.getName());
					food.setMaker(find.getMaker());
					food.setMaterial(find.getMaterial());
					food.setImgPath(find.getImgPath());
					food.setSearchCnt(0);
				}
			}
			log.info(foods.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public ArrayList<Food> getFoods() {
		return foods;
	}

	public void setFoods(ArrayList<Food> foods) {
		this.foods = foods;
	}

}
