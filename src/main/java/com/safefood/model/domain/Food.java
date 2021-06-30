package com.safefood.model.domain;

import lombok.Data;
import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter @Setter
@NonNull
@Data
public class Food {

    @Id
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
    private double fattyAcid;
    private double transFat;
    private String maker;
    @Column(length = 3000)
    private String material;
    private String imgPath;
    private String allergy;
    private int searchCnt;

    @OneToMany(mappedBy = "food", cascade = CascadeType.REMOVE)
    private List<Intake> intakes = new ArrayList<>();

    @OneToMany(mappedBy = "food", cascade = CascadeType.REMOVE)
    private List<Cart> carts = new ArrayList<>();

    public void setMaterial(String material) {
        this.material = material;
        setAllergy();
    }

    public void setAllergy() {
        System.out.print("allergy search : ");
        this.allergy = " ";
        for (String a : new Allergy().getAllergies()) {
            if (this.material.contains(a)) {
                this.allergy += a + " ";
            }
        }
    }
}
