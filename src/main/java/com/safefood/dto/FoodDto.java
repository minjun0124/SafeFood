package com.safefood.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class FoodDto {
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
}
