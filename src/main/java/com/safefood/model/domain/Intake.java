package com.safefood.model.domain;

import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Getter
@Setter
public class Intake {

    @Id
    @GeneratedValue
    @Column(name = "intake_code")
    @NonNull
    private int code;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "food_code")
    @NonNull
    private Food food;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    @NonNull
    private User user;

    private int quantity;
    private LocalDateTime intakeDate;
}
