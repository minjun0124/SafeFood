package com.safefood.repository;

import com.safefood.model.domain.Cart;
import com.safefood.model.domain.CartId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CartRepository extends JpaRepository<Cart, CartId> {

    @Query("select c from Cart c where c.cartId.userId = :id")
    List<Cart> findByUserId(@Param("id") String userId);

    @Query("select c from Cart c join fetch c.food where c.cartId.userId = :id")
    List<Cart> findCartJoinFood(@Param("id") String userId);
}
