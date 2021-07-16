package com.safefood.model.domain;

import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter @Setter
@NonNull
@Data
@NoArgsConstructor
public class Food {

    @Id
    @Column(name = "food_code")
    private Long code;
    private String name;

    public Food(Long code, String name, String imgPath, Long searchCnt) {
        this.code = code;
        this.name = name;
        this.imgPath = imgPath;
        this.searchCnt = searchCnt.intValue();
    }

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
