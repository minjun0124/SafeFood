package com.safefood.controller;

import com.safefood.model.domain.Food;
import com.safefood.model.domain.PageBean;
import com.safefood.service.FoodService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/foods")
public class FoodController {

    @Autowired
    private final FoodService foodService;

    @GetMapping("/loaddata")
    private String loadData(HttpServletRequest request) {
        HttpSession hs = request.getSession();
        hs.setAttribute("isLoad", true);
        foodService.loadData();
        return "redirect:foodlist.do";
    }

    @GetMapping
    private String foodSearch(@ModelAttribute("pagebean") PageBean pagebean, Model model, HttpServletRequest request) {
        model.addAttribute("list", foodService.findFoods(pagebean));
        model.addAttribute("bean", pagebean);
        log.info(pagebean.toString());
        return "foodlist";
    }

    @GetMapping("/detail")
    private String foodView(Model model, int code) {
        foodService.searchCount(code);
        model.addAttribute("food", foodService.findByCode(code));
        return "foodview";
    }

    @GetMapping("/ranking")
    private String ranking(Model model, String key) {
        model.addAttribute("list", foodService.ranking(key));
        return "ranking";
    }
}
