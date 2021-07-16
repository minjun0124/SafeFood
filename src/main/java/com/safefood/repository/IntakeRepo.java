package com.safefood.repository;

import com.safefood.model.domain.Intake;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IntakeRepo extends JpaRepository<Intake, Integer> {
}
