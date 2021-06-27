package com.safefood.service;

import com.safefood.model.domain.Food;
import com.safefood.repository.FoodRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class FoodService {

    private final FoodRepository foodRepository;

    public void loadData(){
        foodRepository.loadData();
    }

    public Food findByCode(int code) {
        return foodRepository.findByCode(code);
    }

    public List<Food> findFoods() {
        return foodRepository.findAll();
    }
}
