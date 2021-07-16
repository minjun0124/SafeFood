package com.safefood.repository.custom;

import com.safefood.model.domain.Food;

import java.util.List;

public interface FoodRepoCustom {

    List<Food> findOrderByCount(String key);
}
