package com.safefood.repository;

import com.safefood.model.domain.User;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;

@Repository
@RequiredArgsConstructor
public class UserRepository {

    private final EntityManager em;

    public Long save(User user) {
        em.persist(user);
        return user.getId();
    }

     public User findOne(Long id){
        return em.find(User.class, id);
    }
}
