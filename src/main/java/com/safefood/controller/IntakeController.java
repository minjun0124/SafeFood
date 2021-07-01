package com.safefood.controller;

import com.safefood.dto.IntakeDto;
import com.safefood.service.FoodService;
import com.safefood.service.IntakeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

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
}
