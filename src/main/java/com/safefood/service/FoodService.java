package com.safefood.service;

import com.safefood.model.domain.Food;
import com.safefood.model.domain.PageBean;
import com.safefood.repository.FoodRepository;
import com.safefood.util.PageUtility;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class FoodService {

    private final FoodRepository foodRepository;

    @Transactional
    public void loadData() {
        foodRepository.loadData();
    }

    public Food findByCode(int code) {
        return foodRepository.findByCode(code);
    }

    public List<Food> findFoods(PageBean pageBean) {
        int total = foodRepository.countFood();
        PageUtility bar = new PageUtility(pageBean.getInterval(), total, pageBean.getPageNo(), "images/");
        System.out.println("FoodService.findFoods" + "total:" + total);
        pageBean.setPagelink(bar.getPageBar());
        return foodRepository.findAll(pageBean);
    }

    public void searchCount(int code) {
        Food food = foodRepository.findByCode(code);
        food.setSearchCnt(food.getSearchCnt() + 1);
    }

}
