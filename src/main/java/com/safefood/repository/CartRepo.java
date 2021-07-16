package com.safefood.repository;

import com.safefood.model.domain.Cart;
import com.safefood.model.domain.CartId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CartRepo extends JpaRepository<Cart, CartId> {

}
