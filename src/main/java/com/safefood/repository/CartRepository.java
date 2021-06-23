package com.safefood.repository;

import com.safefood.model.domain.Cart;
import com.safefood.model.domain.Food;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class CartRepository {

    private final EntityManager em;

    public void insertCart(Cart cart) {
        em.persist(cart);
    }

    public void deleteCart(Cart cart) {
        em.remove(cart);
    }

    public List<Cart> findAll(String id) {
        return em.createQuery("select c from Cart c", Cart.class)
                .getResultList();
    }

    public Cart findOne(int code) {
        return em.find(Cart.class, code);
    }

}
