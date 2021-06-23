package com.safefood.repository;

import com.safefood.model.domain.Food;
import com.safefood.util.FoodSaxParser;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import java.util.ArrayList;
import java.util.List;

@Repository
@RequiredArgsConstructor
@Slf4j
public class FoodRepository {

    private final EntityManager em;

    public void loadData(String context) {
        log.info("loadData start");
        ArrayList<Food> foods = new FoodSaxParser().getFoods();
        List<Food> dbFoods = em.createQuery("select f from Food f", Food.class).getResultList();
        for (Food food : foods) {
            log.info(food.toString());
            if (!dbFoods.contains(food)) {
                em.persist(food);
            }
        }
    }

    public void save(Food food) {
        em.persist(food);
    }

    public void deleteFood(int code) {
        Food food = em.find(Food.class, code);
        em.remove(food);
    }

    public Food findOne(int code) {
        return em.find(Food.class, code);
    }

    public List<Food> findAll() {
        return em.createQuery("select f from Food f", Food.class)
                .getResultList();
    }

}
