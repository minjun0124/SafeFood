package com.safefood.repository.old;

import com.safefood.model.domain.Food;
import com.safefood.model.domain.PageBean;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import java.util.List;
import java.util.Optional;

@Repository
@RequiredArgsConstructor
@Slf4j
public class FoodRepositoryOld {

    private final EntityManager em;

    public void save(Food food) {
        em.persist(food);
    }

    public void deleteFood(int code) {
        Food food = em.find(Food.class, code);
        em.remove(food);
    }

    public int countFood() {
        return em.createQuery("select count(f) from Food f", Long.class).getSingleResult().intValue();
    }

    public Food findByCode(int code) {
        return em.find(Food.class, code);
    }

    //TODO: search condition - pageBean:key
    public List<Food> findAll(PageBean pageBean) {
        return em.createQuery("select f from Food f order by f.code desc", Food.class)
                .setFirstResult(pageBean.getStart())
                .setMaxResults(pageBean.getInterval())
                .getResultList();
    }

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
