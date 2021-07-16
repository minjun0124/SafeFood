package com.safefood.repository;

import com.safefood.model.domain.Food;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FoodRepository extends JpaRepository<Food, Long>, FoodRepoCustom{

}
