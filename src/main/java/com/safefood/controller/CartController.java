package com.safefood.controller;

import com.safefood.dto.CartDto;
import com.safefood.model.domain.Cart;
import com.safefood.model.domain.Intake;
import com.safefood.service.CartService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/carts")
public class CartController {

    private HttpSession session;

    @Autowired
    private CartService cartService;

    @GetMapping("/insert")
    private String cartInsert(Model model, CartDto cartDto) {
        try {
            log.info(cartDto.toString());
            cartService.insertCart(cartDto);
            model.addAttribute("cart_msg", "찜하기 목록에 추가되었습니다. 목록을 확인하시겠습니까?");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "index";
    }

    @GetMapping
    private String cartList(Model model, HttpServletRequest request) {
        session = request.getSession();
        String id = (String) session.getAttribute("loginid");
        List<Cart> cartList = cartService.findCartList(id);
        model.addAttribute("list", cartList);
        return "cartlist";
    }

    @GetMapping("/update")
    private String cartUpdate(CartDto cartDto) {
        cartService.changeCartQuantity(cartDto);
        return "redirect:/carts";
    }

    @GetMapping("/cartintake.do")
    private String cartIntake(Model model, Intake intake, Cart cart, HttpServletRequest request) {
        session = request.getSession();
        String id = (String) session.getAttribute("loginid");
        cartService.intakeCart(cart, intake);
        model.addAttribute("list", cartService.findCartList(id));
        return "redirect:cartlist.do";
    }

    @GetMapping("/delete")
    private String cartDelete(CartDto cartDto) {
        cartService.deleteCart(cartDto);
        return "redirect:/carts";
    }
}
