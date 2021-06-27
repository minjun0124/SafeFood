package com.safefood;

import com.safefood.dto.UserDto;
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

    @Test
//    @Rollback(value = false)
    public void 회원가입() throws Exception {
        //given
        Address address = new Address("seoul", "safe load", "1234");
        User user = new User("test", "test", "test", "seoul", "01012341234");

        //when
        String savedId = userRepository.save(user);

        //then
        assertEquals(user, userRepository.findById(savedId));
    }

    @Test
    public void 회원가입_서비스() {
        //given
        Address address = new Address("seoul", "safe load", "1234");
        User user = new User("test", "test", "test", "seoul", "01012341234");

        //when
        String savedId = userService.join(user);

        //then
        assertEquals(user, userService.findById(savedId));
    }

    @Test(expected = IllegalStateException.class)
    public void 회원가입_중복() throws Exception {
        //given
        Address address = new Address("seoul", "safe load", "1234");
        User user = new User("test", "test", "test", "seoul", "01012341234");
        User userDuple = new User("test", "asdf", "asdf", "seoul", "01078907890");

        //when
        String savedId = userService.join(user);
        String savedIdDuple = userService.join(user);

        //then
        fail("중복된 아이디로는 가입할 수 없습니다.");
    }

    @Test
    public void 로그인() throws Exception {
        //given
        Address address = new Address("seoul", "safe load", "1234");
        User user = new User("test", "test", "test", "seoul", "01012341234");
        String savedId = userService.join(user);

        //when
        if (!userService.loginPass("test", "test")) {
            //then
            fail("로그인에 실패하였습니다. ID 또는 PW를 확인해주세요.");
        }
    }

    @Test(expected = IllegalStateException.class)
    public void 로그인_실패() throws Exception {
        //given
        Address address = new Address("seoul", "safe load", "1234");
        User user = new User("test", "test", "test", "seoul", "01012341234");

        //when
        if (!userService.loginPass("asdf", "asdf")) {
            //then
            fail("로그인에 실패하였습니다. ID 또는 PW를 확인해주세요.");
        }
    }

    @Test
    @Rollback(value = false)
    public void 회원정보수정() {
        // given
        String userId = "test";
        String userName = "test1";
        String userModName = "test2";
        Address address = new Address("seoul", "safe load", "1234");
        User user1 = new User(userId, "test", userName, "seoul", "01012341234");
        userService.join(user1);
        assertEquals(user1.getName(), userName);

        // when
        UserDto userDto = new UserDto(userId, userModName, "seoul", "01078907890", "nuts");
        userService.updateUser(userDto);

        // then
        User user2 = userService.findById("test");
        assertEquals(user2.getName(), "test2");
    }


    @Test
    public void 회원탈퇴() {
        //given
        Address address = new Address("seoul", "safe load", "1234");
        User user = new User("test", "test", "test", "seoul", "01012341234");
        String savedId = userRepository.save(user);
        assertEquals(user, userRepository.findById(savedId));

        //when
        userService.withdrawUser("test");

        //then
        if (userService.loginPass("test", "test")) {
            fail("회원 탈퇴 처리에 실패하였습니다.");
        }
    }

}
