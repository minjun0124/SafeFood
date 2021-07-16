package com.safefood.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartDto {
    private String id;
    private Long code;
    private int quantity;
    private String name;
    private String imgPath;

    public CartDto(String id, Long code, int quantity) {
        this.id = id;
        this.code = code;
        this.quantity = quantity;
    }
}
