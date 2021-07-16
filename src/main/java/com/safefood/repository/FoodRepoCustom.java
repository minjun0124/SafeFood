package com.safefood.repository;

import com.safefood.model.domain.Food;

import java.util.List;

public interface FoodRepoCustom {

    List<Food> findOrderByCount(String key);
}
