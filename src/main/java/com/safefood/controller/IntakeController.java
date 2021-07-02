package com.safefood.controller;

import com.safefood.dto.FoodDto;
import com.safefood.dto.IntakeDto;
import com.safefood.model.domain.Food;
import com.safefood.model.domain.Intake;
import com.safefood.model.domain.PageBean;
import com.safefood.service.FoodService;
import com.safefood.service.IntakeService;
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
import java.util.HashMap;
import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/intakes")
public class IntakeController {

    private HttpSession session;

    @Autowired
    private final IntakeService intakeService;
    @Autowired
    private final FoodService foodService;

    @GetMapping("/insert")
    private String intakeInsert(Model model, IntakeDto intakeDto) {
        intakeService.insertIntake(intakeDto);
        model.addAttribute("food", foodService.findByCode(intakeDto.getCode()));
        return "foodview";
    }

    @GetMapping
    private String intakeList(Model model, HttpServletRequest request, @ModelAttribute("pagebean") PageBean pagebean) {
        String id = (String) request.getSession().getAttribute("loginid");

        System.out.println(pagebean);

        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("id", id);
        map.put("pagebean", pagebean);

        List<Intake> intakes = intakeService.findIntakes(id, pagebean);
        FoodDto sum = intakeService.sumOfNutrtion(intakes);

        model.addAttribute("list", intakes);
        model.addAttribute("sum", sum);

        String key = null;

        key = "code";
        List<Integer> codes = intakeService.searchOption(id, key);
//        key = "year";
//        List<Integer> years = intakeService.searchOption(id, key);
//        key = "month";
//        List<Integer> months = intakeService.searchOption(id, key);

        model.addAttribute("codes", codes);
//        model.addAttribute("years", years);
//        model.addAttribute("months", months);

        return "intakelist";
    }
}
