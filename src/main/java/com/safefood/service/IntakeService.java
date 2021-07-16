package com.safefood.service;

import com.safefood.dto.FoodDto;
import com.safefood.dto.IntakeDto;
import com.safefood.model.domain.*;
import com.safefood.repository.CartRepository;
import com.safefood.repository.FoodRepository;
import com.safefood.repository.IntakeRepository;
import com.safefood.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class IntakeService {

    @Autowired
    IntakeRepository intakeRepository;
    @Autowired
    CartRepository cartRepository;
    @Autowired
    UserRepository userRepository;
    @Autowired
    FoodRepository foodRepository;

    @Transactional
    public void insertIntake(IntakeDto intakeDto) {
        Intake intake = makeIntake(intakeDto);
        intakeRepository.save(intake);
    }

    public Intake makeIntake(IntakeDto intakeDto) {
        User user = userRepository.findById(intakeDto.getId());
        Food food = foodRepository.findByCode(intakeDto.getCode());
        return new Intake(user, food, intakeDto.getQuantity(), LocalDateTime.now());
    }

    public List<Intake> findIntakes(String userId, PageBean pageBean) {
        List<Intake> intakes = intakeRepository.findByUserId(userId);
        Optional<String> opKey = Optional.ofNullable(pageBean.getKey());

        if (opKey.isPresent()) {
            String key = opKey.get();
            int wordToInt = Integer.parseInt(pageBean.getWord());
            for (Intake intake : intakes) {
                if (key.equals("code")) {
                    if (intake.getFood().getCode() != wordToInt) {
                        intakes.remove(intake);
                    }
                } else if (key.equals("year")) {
                    if (intake.getIntakeDate().getYear() != wordToInt) {
                        intakes.remove(intake);
                    }
                } else if (key.equals("month")) {
                    if (intake.getFood().getCode() != wordToInt) {
                        intakes.remove(intake);
                    }
                }
            }
        }
        return intakes;
    }

    public FoodDto sumOfNutrtion(List<Intake> intakes) {
        double supportPerEat = 0;
        double calorie = 0;
        double carbohydrate = 0;
        double protein = 0;
        double fat = 0;
        double sugar = 0;
        double sodium = 0;
        double cholesterol = 0;
        double fattyAcid = 0;
        double transFat = 0;
        for (Intake intake : intakes) {
            supportPerEat = intake.getFood().getSupportPerEat();
            calorie = intake.getFood().getCalorie();
            carbohydrate = intake.getFood().getCarbohydrate();
            protein = intake.getFood().getProtein();
            fat = intake.getFood().getFat();
            sugar = intake.getFood().getSugar();
            sodium = intake.getFood().getSodium();
            cholesterol = intake.getFood().getCholesterol();
            fattyAcid = intake.getFood().getFattyAcid();
            transFat = intake.getFood().getTransFat();
        }
        FoodDto foodDto = new FoodDto(supportPerEat
                , calorie
                , carbohydrate
                , protein
                , fat
                , sugar
                , sodium
                , cholesterol
                , fattyAcid
                , transFat);
        return foodDto;
    }

    //TODO: search option
    public List<Integer> searchOption(String id, String key) {
        /*if (key.equals("code")){
            return intakeRepository.findOptionCode(id);
        } else if (key.equals("year")) {
            return intakeRepository.findOptionYears(id);
        } else {
            return intakeRepository.findOptionMonths(id);
        }*/
        return intakeRepository.findOptionCode(id);
    }

    @Transactional
    public void updateIntake(Intake intake) {
        Intake findIntake = intakeRepository.findOne(intake.getCode());
        findIntake.setQuantity(intake.getQuantity());
    }

    @Transactional
    public void deleteIntake(int intakeCode) {
        intakeRepository.deleteIntake(intakeCode);
    }

    @Transactional
    public void cartIntake(IntakeDto intakeDto) {
        insertIntake(intakeDto);
        CartId cartId = new CartId(intakeDto.getId(), intakeDto.getCode());
        Cart cart = cartRepository.findById(cartId).get();
        int changQuantity = cart.getQuantity() - intakeDto.getQuantity();
        if (changQuantity <= 0){
            cartRepository.delete(cart);
        } else {
            cart.changeQuantity(changQuantity);
        }
    }

/*
    public void deleteIntake(int intakecode) {
        intakeDaoImpl.deleteIntake(intakecode);
    }

    public Intake search(int intakecode) {
        return intakeDaoImpl.search(intakecode);
    }

    public List<Intake> searchAll(HashMap<String, Object> map) {
        return intakeDaoImpl.searchAll(map);
    }

    public Food getSum(HashMap<String, Object> map) {
        return intakeDaoImpl.getSum(map);
    }

    public List<Integer> getOption(HashMap<String, String> option) {
        return intakeDaoImpl.getOption(option);
    }

    public Food todaySum(String id) {
        return intakeDaoImpl.todaySum(id);
    }

    public void prevIntake(int[][] intakeArr, int size, String id) {
        intakeDaoImpl.prevIntake(intakeArr, size, id);
    }
    public List<Food> getRank() {
        return intakeDaoImpl.getRank();
    }

    public Food getDeficiency(String id) {
        return intakeDaoImpl.getDeficiency(id);
    }
    */
}
