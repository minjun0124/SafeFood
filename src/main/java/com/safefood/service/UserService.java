package com.safefood.service;

import com.safefood.dto.UserDto;
import com.safefood.model.domain.User;
import com.safefood.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    @Transactional
    public String join(User user) {
        validateDuplicateUser(user);
        userRepository.save(user);
        return user.getId();
    }

    private void validateDuplicateUser(User user) {
        Optional<User> opUser = Optional.ofNullable(this.findById(user.getId()));
        if(opUser.isPresent()){
            throw new IllegalStateException("이미 존재하는 회원입니다");
        }
    }

    public User findById(String userId) {
        return userRepository.findById(userId);
    }

    public List<User> findUsers() {
        return userRepository.findAll();
    }

    public boolean loginPass(String userId, String pw) {
        Optional<User> opUser = Optional.ofNullable(this.findById(userId));
        if(opUser.isEmpty()){
            throw new IllegalStateException("존재하지 않는 회원입니다");
        }
        User user = opUser.get();
        return user.getPassword().equals(pw) && !user.getWithdrawStatus();
    }

    public void updateUser(UserDto userDto) {
        User user = this.findById(userDto.getId());
        user.userInfoChange(userDto);
    }

    public void withdrawUser(String userId) {
        User user = this.findById(userId);
        user.setWithdrawStatus(true);
    }

}
