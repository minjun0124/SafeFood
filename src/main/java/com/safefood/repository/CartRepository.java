package com.safefood.repository;

import com.safefood.dto.CartDto;
import com.safefood.model.domain.Cart;
import com.safefood.model.domain.CartId;
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

    public Cart findByCodes(CartId cartId) {
        return em.find(Cart.class, cartId);
    }

    public List<Cart> findAll(String id) {
        return em.createQuery("select c from Cart c", Cart.class)
                .getResultList();
    }

    public List<Food> joinFood(CartId cartId) {
        return em.createQuery("select f from Food f join Cart c where f.code = c.cartId.foodcode and c.cartId.userid = :id")
                .setParameter("id", cartId.getUserid())
                .getResultList();
    }

}
