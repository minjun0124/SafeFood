package com.safefood;

import com.safefood.dto.IntakeDto;
import com.safefood.model.domain.Address;
import com.safefood.model.domain.User;
import com.safefood.service.FoodService;
import com.safefood.service.IntakeService;
import com.safefood.service.UserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

@RunWith(SpringRunner.class)
@SpringBootTest
@Transactional
public class IntakeTest {

    @Autowired
    IntakeService intakeService;
    @Autowired
    UserService userService;
    @Autowired
    FoodService foodService;

    @Test
    public void 섭취(){
        // given
        User user = userRegister();
        IntakeDto intakeDto = new IntakeDto(user.getId(), 12L, 6);

        // when
        intakeService.insertIntake(intakeDto);

        // then
//        List<Intake> intakes = intakeService.findIntakes("testJunit", pagebean);

    }

    private User userRegister() {
        Address address = new Address("seoul", "safe load", "1234");
        User user = new User("testJunit", "test", "test", "seoul", "01012341234");

        userService.join(user);
        return user;
    }

}
