package com.safefood.model.domain;

import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter @Setter
@NonNull
public class Food {

    @Id
    @GeneratedValue
    @Column(name = "food_code")
    private int code;
    private String name;
    private double supportPerEat;
    private double calorie;
    private double carbohydrate;
    private double protein;
    private double fat;
    private double sugar;
    private double sodium;
    private double cholesterol;
    private double transFat;
    private String maker;
    private String material;
    private String imgPath;
    private String allergy;
    private int searchCnt;

    @OneToMany(mappedBy = "food", cascade = CascadeType.ALL)
    private List<Intake> intakes = new ArrayList<>();

    @OneToMany(mappedBy = "food", cascade = CascadeType.ALL)
    private List<Cart> carts = new ArrayList<>();

}
