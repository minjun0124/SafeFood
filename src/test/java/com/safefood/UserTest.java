package com.safefood;

import com.safefood.model.domain.Address;
import com.safefood.model.domain.User;
import com.safefood.repository.UserRepository;
import org.junit.Test;
import org.junit.jupiter.api.Assertions;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

@RunWith(SpringRunner.class)
@SpringBootTest
@Transactional
public class UserTest {

    @Autowired
    UserRepository userRepository;

    @Test
//    @Rollback(value = false)
    public void 회원가입() throws Exception{
        //given
        User user = new User();
        Address address = new Address("seoul", "safe load", "1234");

        user.setName("test");
        user.setPassword("test");
        user.setPhone("01012341234");
        user.setAddress(address);

        //when
        Long savedId = userRepository.save(user);

        //then
        Assertions.assertEquals(user, userRepository.findOne(savedId));

    }
}
