package com.safefood.repository;

import com.safefood.model.domain.Intake;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface IntakeRepository extends JpaRepository<Intake, Long> {

    @Query("select i from Intake i join fetch i.food where i.user.id = :userId order by i.intakeDate")
    List<Intake> findByUserId(@Param("userId") String userId);

    //TODO: search option
    @Query("select distinct i.food.code from Intake i join i.food where i.user.id = :userId")
    List<Long> findOptionCode(@Param("userId") String userId);

}
