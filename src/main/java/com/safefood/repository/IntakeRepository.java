package com.safefood.repository;

import com.safefood.model.domain.Intake;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import java.util.HashMap;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class IntakeRepository {

    private final EntityManager em;

    public int save(Intake intake) {
        em.persist(intake);
        return intake.getCode();
    }

    public Intake findOne(int intakecode) {
        return em.find(Intake.class, intakecode);
    }

    public List<Intake> findByUserId(String userId) {
        return em.createQuery("select i from Intake i where i.user.id = :id")
                .setParameter("id", userId)
                .getResultList();
    }

    public void deleteIntake(int intakecode) {
        Intake intake = em.find(Intake.class, intakecode);
        em.remove(intake);
    }
}
