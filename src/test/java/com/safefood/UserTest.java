package com.safefood;

import com.safefood.model.domain.Address;
import com.safefood.model.domain.User;
import com.safefood.repository.UserRepository;
import com.safefood.service.UserService;
import org.junit.Rule;
import org.junit.Test;
import org.junit.jupiter.api.Assertions;
import org.junit.rules.ExpectedException;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.jupiter.api.Assertions.*;

@RunWith(SpringRunner.class)
@SpringBootTest
@Transactional
public class UserTest {

    @Autowired
    UserRepository userRepository;

    @Autowired
    UserService userService;

    @Rule
    public ExpectedException exception = ExpectedException.none();

    @Test
//    @Rollback(value = false)
    public void 회원가입() throws Exception{
        //given
        Address address = new Address("seoul", "safe load", "1234");
        User user = new User("test", "test", "test", address,"01012341234");

        //when
        String savedId = userRepository.save(user);

        //then
        assertEquals(user, userRepository.findById(savedId));
    }

    @Test
    public void 회원가입_서비스() {
        //given
        Address address = new Address("seoul", "safe load", "1234");
        User user = new User("test", "test", "test", address,"01012341234");

        //when
        String savedId = userService.join(user);

        //then
        assertEquals(user, userService.findById(savedId));
    }

    @Test(expected = IllegalStateException.class)
    public void 회원가입_중복() throws Exception {
        //given
        Address address = new Address("seoul", "safe load", "1234");
        User user = new User("test", "test", "test", address,"01012341234");
        User userDuple = new User("test", "asdf", "asdf", address,"01078907890");

        //when
        String savedId = userService.join(user);
        String savedIdDuple = userService.join(user);

        //then
        fail("중복된 아이디로는 가입할 수 없습니다.");
    }
}
