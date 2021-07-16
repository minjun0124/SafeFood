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
        Long foodCode = 10L;
        int quantity = 6;
        CartDto cartDto = new CartDto(user.getId(), foodCode, quantity);
        CartId cartId = new CartId(user.getId(), foodCode);
        Cart cart = new Cart(cartId, userService.findById(user.getId())
                , foodService.findByCode(foodCode), quantity);

        // when
        cartService.insertCart(cartDto);

        // then
        Cart findCart = cartService.findCart(cartId);
        assertEquals(findCart, cart);
    }

    @Test
    public void 찜하기_수량_변경() {
        // given
        User user = userRegister();
        Long foodCode = 10L;
        int quantity = 6;
        CartDto cartDto = new CartDto(user.getId(), foodCode, quantity);
        CartId cartId = new CartId(user.getId(), foodCode);
        cartService.insertCart(cartDto);
        int newQuantity = 10;
        CartDto newCartDto = new CartDto(user.getId(), foodCode, newQuantity);

        // when
        cartService.changeCartQuantity(newCartDto);

        // then
        Cart findCart = cartService.findCart(cartId);
        assertEquals(findCart.getQuantity(), newQuantity);
    }

    private User userRegister() {
        Address address = new Address("seoul", "safe load", "1234");
        User user = new User("testJunit", "test", "test", "seoul", "01012341234");

        userService.join(user);
        return user;
    }

}
