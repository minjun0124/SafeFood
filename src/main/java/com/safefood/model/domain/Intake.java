package com.safefood.model.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class Intake {

    @Id
    @GeneratedValue
    @Column(name = "intake_code")
    @NonNull
    private Long code;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    @NonNull
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "food_code")
    @NonNull
    private Food food;

    private int quantity;
    private LocalDateTime intakeDate;

    public Intake(User user, Food food, int quantity, LocalDateTime intakeDate) {
        this.user = user;
        this.food = food;
        this.quantity = quantity;
        this.intakeDate = intakeDate;
    }

    public void changeQuantity(int newQuantity) {
        this.quantity = newQuantity;
    }
}
