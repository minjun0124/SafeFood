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

    public List<Cart> findByUserId(String userId) {
        return em.createQuery("select c from Cart c " +
                "where c.cartId.userId = :id", Cart.class)
                .setParameter("id", userId)
                .getResultList();
    }

    public List<Cart> joinFood(String userId) {
        return em.createQuery("select c from Cart c join fetch Food f on c.cartId.foodCode = f.code and c.cartId.userId = :id", Cart.class)
                .setParameter("id", userId)
                .getResultList();
    }

}
