package com.safefood.service;

import com.safefood.dto.IntakeDto;
import com.safefood.model.domain.*;
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
@Transactional
@RequiredArgsConstructor
public class IntakeService {

    @Autowired
    IntakeRepository intakeRepository;

    @Autowired
    UserRepository userRepository;

    @Autowired
    FoodRepository foodRepository;

    public void  insertIntake(IntakeDto intakeDto) {
        Intake intake = makeIntake(intakeDto);
        intakeRepository.save(intake);
    }

    public Intake makeIntake(IntakeDto intakeDto){
        User user = userRepository.findById(intakeDto.getId());
        Food food = foodRepository.findByCode(intakeDto.getCode());
        return new Intake(user, food, intakeDto.getQuantity(), LocalDateTime.now());
    }

    public List<Intake> findIntakes(String userId) {
        return intakeRepository.findByUserId(userId);
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
