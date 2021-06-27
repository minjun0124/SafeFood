package com.safefood;

import com.safefood.model.domain.Food;
import com.safefood.service.FoodService;
import org.assertj.core.api.Assertions;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

import static org.assertj.core.api.Assertions.*;

@RunWith(SpringRunner.class)
@SpringBootTest
@Transactional
public class FoodTest {

    @Autowired
    FoodService foodService;

    @Test
    public void 식품정보_불러오기() {
        // given
        foodService.loadData();

        // when
        Optional<Food> opFood = Optional.ofNullable(foodService.findByCode(1));

        // then
        if (opFood.isEmpty()) {
            fail("식품 정보 불러오기 실패");
        }
    }

}
