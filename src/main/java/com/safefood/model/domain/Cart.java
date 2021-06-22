package com.safefood.model.domain;

import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "cart")
@Getter
@Setter
public class Cart {

    @Id
    @GeneratedValue
    @Column(name = "cart_id")
    @NonNull
    private Long id;

    @NonNull
    private int Quantity;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    @NonNull
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "food_code")
    @NonNull
    private Food food;
}
