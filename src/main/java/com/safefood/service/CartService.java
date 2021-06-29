package com.safefood.service;

import com.safefood.dto.CartDto;
import com.safefood.model.domain.Cart;
import com.safefood.model.domain.CartId;
import com.safefood.model.domain.Food;
import com.safefood.model.domain.Intake;
import com.safefood.repository.CartRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CartService {

    private final CartRepository cartRepository;

    public void insertCart(Cart cart) {
        Optional<Cart> opCart = Optional.ofNullable(cartRepository.findByCodes(cart.getCartId()));
        if (opCart.isEmpty()) {
            cartRepository.insertCart(cart);
        } else {
            Cart findCart = opCart.get();
            int newQuantity = findCart.getQuantity() + cart.getQuantity();
            findCart.changeQuantity(newQuantity);
        }
    }

    public void changeCartQuantity(CartDto cartDto) {
        CartId cartId = new CartId(cartDto.getId(), cartDto.getCode());
        Cart cart = cartRepository.findByCodes(cartId);
        cart.changeQuantity(cartDto.getQuantity());
    }

    public void deleteCart(Cart cart) {
        cartRepository.deleteCart(cart);
    }

    public Cart findCart(CartId cartId) {
        return cartRepository.findByCodes(cartId);
    }

    public List<Cart> findCartList(String id) {
        return cartRepository.findAll(id);
    }

    public void intakeCart(Cart cart, Intake intake) {
        cartRepository.deleteCart(cart);
//        intakeDaoImpl.insertIntake(intake);
    }

    public List<Food> joinfood(CartId cartId) {
        return cartRepository.joinFood(cartId);
    }

}
