package com.safefood.repository;

import com.safefood.model.domain.Intake;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class IntakeRepositoryOld {

    private final EntityManager em;

    public Long save(Intake intake) {
        em.persist(intake);
        return intake.getCode();
    }

    public Intake findOne(int intakecode) {
        return em.find(Intake.class, intakecode);
    }

    public List<Intake> findByUserId(String userId) {
        return em.createQuery("select i from Intake i " +
                "join fetch i.food " +
                "where i.user.id = :userId order by i.intakeDate")
                .setParameter("userId", userId)
                .getResultList();
    }

    public void deleteIntake(int intakecode) {
        Intake intake = em.find(Intake.class, intakecode);
        em.remove(intake);
    }

    //TODO: search option
    public List<Long> findOptionCode(String userId) {
        return em.createQuery("select distinct i.food.code from Intake i join i.food " +
                "where i.user.id = :userId ", Long.class)
                .setParameter("userId", userId)
                .getResultList();
    }
/*
    public List<Object> findOptionYears(String id) {
        return em.createNativeQuery("select distinct YEAR(i.intake_date) from Intake i", Object.class)
                .getResultList();
    }

    public List<Integer> findOptionMonths(String id) {
        return em.createNativeQuery("select distinct MONTH(i.intakeDate) from Intake i", LocalDateTime.class)
                .getResultList();
    }
*/
}
