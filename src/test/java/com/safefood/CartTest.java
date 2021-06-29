package com.safefood;

import com.safefood.dto.CartDto;
import com.safefood.model.domain.Address;
import com.safefood.model.domain.Cart;
import com.safefood.model.domain.CartId;
import com.safefood.model.domain.User;
import com.safefood.service.CartService;
import com.safefood.service.FoodService;
import com.safefood.service.UserService;
import org.junit.Test;
import org.junit.jupiter.api.Assertions;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.jupiter.api.Assertions.assertEquals;

@RunWith(SpringRunner.class)
@SpringBootTest
@Transactional
public class CartTest {

    @Autowired
    CartService cartService;
    @Autowired
    UserService userService;
    @Autowired
    FoodService foodService;

    @Test
    public void 찜하기() {
        // given
        User user = userRegister();
        int foodCode = 10;
        int quantity = 6;
        CartId cartId = new CartId(user.getId(), foodCode);
        Cart cart = new Cart(cartId, userService.findById(user.getId())
                , foodService.findByCode(foodCode), quantity);

        // when
        cartService.insertCart(cart);

        // then
        Cart findCart = cartService.findCart(cartId);
        assertEquals(findCart, cart);
    }

    @Test
    public void 찜하기_수량_변경() {
        // given
        User user = userRegister();
        int foodCode = 10;
        int quantity = 6;
        CartId cartId = new CartId(user.getId(), foodCode);
        Cart cart = new Cart(cartId, userService.findById(user.getId())
                , foodService.findByCode(foodCode), quantity);
        cartService.insertCart(cart);
        int newQuantity = 10;
        CartDto cartDto = new CartDto(user.getId(), foodCode, newQuantity);

        // when
        cartService.changeCartQuantity(cartDto);

        // then
        Cart findCart = cartService.findCart(cartId);
        assertEquals(findCart.getQuantity(), newQuantity);
    }

    private User userRegister() {
        Address address = new Address("seoul", "safe load", "1234");
        User user = new User("test", "test", "test", "seoul", "01012341234");

        userService.join(user);
        return user;
    }

}
