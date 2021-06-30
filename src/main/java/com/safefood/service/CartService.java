package com.safefood.service;

import com.safefood.dto.CartDto;
import com.safefood.model.domain.*;
import com.safefood.repository.CartRepository;
import com.safefood.repository.FoodRepository;
import com.safefood.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
@RequiredArgsConstructor
public class CartService {

    private final CartRepository cartRepository;
    private final UserRepository userRepository;
    private final FoodRepository foodRepository;

    public void insertCart(CartDto cartDto) {
        CartId cartId = new CartId(cartDto.getId(), cartDto.getCode());
        Optional<Cart> opCart = Optional.ofNullable(cartRepository.findByCodes(cartId));
        if (opCart.isEmpty()) {
            Cart cart = makeCartByCartId(cartId, cartDto.getQuantity());
            cartRepository.insertCart(cart);
        } else {
            Cart findCart = opCart.get();
            int newQuantity = findCart.getQuantity() + cartDto.getQuantity();
            findCart.changeQuantity(newQuantity);
        }
    }

    public Cart makeCartByCartId(CartId cartId, int quantity){
        User user = userRepository.findById(cartId.getUserId());
        Food food = foodRepository.findByCode(cartId.getFoodCode());
        return new Cart(cartId, user, food, quantity);
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

    public List<Cart> findCartList(String userId) {
        return cartRepository.findByUserId(userId);
    }

    public void intakeCart(Cart cart, Intake intake) {
        cartRepository.deleteCart(cart);
//        intakeDaoImpl.insertIntake(intake);
    }

    public List<Food> joinfood(CartId cartId) {
        return cartRepository.joinFood(cartId);
    }

}
