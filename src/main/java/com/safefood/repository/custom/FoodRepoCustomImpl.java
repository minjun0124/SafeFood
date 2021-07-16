package com.safefood.repository.custom;

import com.safefood.model.domain.Food;
import lombok.RequiredArgsConstructor;

import javax.persistence.EntityManager;
import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
public class FoodRepoCustomImpl implements FoodRepoCustom{

    private final EntityManager em;

    @Override
    public List<Food> findOrderByCount(String key) {
        Optional<String> opKey = Optional.ofNullable(key);
        if (opKey.isEmpty() || key.equals("intake")) {
            return em.createQuery("select new Food(f.code, f.name, f.imgPath, sum(i.quantity)) from Food f " +
                    "join Intake i on f.code = i.food.code " +
                    "group by i.food.code order by sum(i.quantity) desc ", Food.class)
                    .setFirstResult(0)
                    .setMaxResults(10)
                    .getResultList();
        } else {
            return em.createQuery("select f from Food f order by f.searchCnt desc", Food.class)
                    .setFirstResult(0)
                    .setMaxResults(10)
                    .getResultList();
        }
    }
}
