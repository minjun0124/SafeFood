package com.safefood.repository;

import com.safefood.model.domain.User;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import java.util.List;

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

    public List<User> findAll() {
        return em.createQuery("select u from User u", User.class)
                .getResultList();
    }

    public void delete(Long id) {
        User user = em.find(User.class, id);
        em.remove(user);
    }

    public void withdraw(String id) {
        User user = em.find(User.class, id);
        user.setWithdrawStatus(true);
    }

}
