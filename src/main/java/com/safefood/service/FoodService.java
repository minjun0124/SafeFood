package com.safefood.service;

import com.safefood.model.domain.Food;
import com.safefood.model.domain.PageBean;
import com.safefood.repository.FoodRepository;
import com.safefood.repository.old.FoodRepositoryOld;
import com.safefood.util.FoodSaxParser;
import com.safefood.util.PageUtility;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
@Slf4j
public class FoodService {

    private final FoodRepository foodRepository;
    private final FoodRepositoryOld foodRepositoryOld;

    @Transactional
    public void loadData() {
        log.info("Load Food Info");
        ArrayList<Food> foods = new FoodSaxParser().getFoods();
        List<Food> dbFoods = foodRepository.findAll();
        for (Food food : foods) {
            log.info(food.toString());
            if (!dbFoods.contains(food)) {
                foodRepository.save(food);
            }
        }
    }

    public Food findByCode(Long code) {
        return foodRepository.findById(code).get();
    }

    public List<Food> findFoods(PageBean pageBean) {
        int total = Long.valueOf(foodRepository.count()).intValue();
        PageUtility bar = new PageUtility(pageBean.getInterval(), total, pageBean.getPageNo(), "images/");
        System.out.println("FoodService.findFoods" + "total:" + total);
        pageBean.setPagelink(bar.getPageBar());
        PageRequest pageRequest = PageRequest.of(pageBean.getPageNo(), pageBean.getInterval(), Sort.by(Sort.Direction.DESC, "code"));
        return foodRepository.findAll(pageRequest).getContent();
    }

    @Transactional
    public void searchCount(Long code) {
        Food food = foodRepository.findById(code).get();
        food.setSearchCnt(food.getSearchCnt() + 1);
    }

    public List<Food> ranking(String key) {
        return foodRepository.findOrderByCount(key);
    }
}
